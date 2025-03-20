Return-Path: <linux-kernel+bounces-569203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5DA69FED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C77346151D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0751DF972;
	Thu, 20 Mar 2025 06:42:11 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AB29A0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452931; cv=none; b=lRjpWGXMu8b0rn9BaYAJ3r2a5Yw+d5chk7igvkAht4BzgD8OzdBooUwb81hR7bJ69ctFED2Mq6ZieacIShlkDgPaq+tRhQ5cLLKWpowntcf5MCKDA0hDSW8FkXy7qmPJNYLbJc6OabN6v7vzaTuOjIr0fZvkkyhpMCtx9Iv0t2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452931; c=relaxed/simple;
	bh=FUzJ9jmM6F97ERSY8jwNCIx2978t1zJTWOPpNILMHjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdwRfWGcKsRdVJLfn7AwQieE+wReujPsApu69SkzT4rO5ag4fRvPch8dRfYIgrs7pziSivE1OXH5iyGj7lMfPYG5MxtzZVDplgPFFGBfRG8sdQ6QbS+Ma7DaGHwAyPvqDb7zP7WKrFwwLDTSWPQPgJdmOt8+EpyuqGZ2ki+xsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id A16057C0115;
	Thu, 20 Mar 2025 14:36:35 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609374T281456747934064S1742452594471158_;
	Thu, 20 Mar 2025 14:36:35 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:shaopeijie@cestc.cn
X-SENDER:shaopeijie@cestc.cn
X-LOGIN-NAME:shaopeijie@cestc.cn
X-FST-TO:kbusch@kernel.org
X-RCPT-COUNT:9
X-LOCAL-RCPT-COUNT:3
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<ba8584b988ac8f78fbffabd1439a33d6>
X-System-Flag:0
From: shaopeijie@cestc.cn
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn,
	gechangzhong@cestc.cn,
	Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Date: Thu, 20 Mar 2025 14:35:23 +0800
Message-ID: <20250320063523.2201926-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peijie Shao <shaopeijie@cestc.cn>

In a SELinux enabled kernel, socket_create() initializes the
security label of the socket using the security label of the
calling process, this typically works well.

However, in a containerized environment like Kubernetes,
problem arises when a privileged container(domain spc_t)
connects to an NVMe target and mounts the NVMe as persistent
storage for unprivileged containers(domain container_t).

This is because the container_t domain cannot access
resources labeled with spc_t, resulting in socket_sendmsg
returning -EACCES.

The solution is to use socket_create_kern() instead of
socket_create(), which labels the socket context to kernel_t.
Access control will then be handled by the VFS layer rather
than the socket itself.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..71f7045881eb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1790,7 +1790,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
-	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
+	ret = sock_create_kern(current->nsproxy->net_ns,
+			ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
-- 
2.43.0




