Return-Path: <linux-kernel+bounces-573124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC16A6D349
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DD1188DEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72311519A7;
	Mon, 24 Mar 2025 03:18:13 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D491799F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742786293; cv=none; b=E4uzO15T3xYijvZYeCbQ9ooxB5q9NePDlMK+fe5ni2FsSFqJJuxI0T3IzcT1qrAWFWpMIFuqZnC/QJ0L/JTdZ3nxyKQ0JTztdYt/uV56gqXYXO+/+60Hs9bpF5/2R+tIXQmxF6Zwcuo3x9qNLJEvlW4ekTr8MShr54CRJjmmLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742786293; c=relaxed/simple;
	bh=UdeiOpu4SaB1EFXascDTBQoJeqnzup9eC1pAjD/8tmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNoJXRYXtvasAb/Ga+/+P8cTm3W623DGDv23SExQGF82RnSvEx1AE5yXPdiQQAQTTm19FUrmZYgtKHy5xDGyOvgMo3tY9IfEw1C/IqfBEGRAUTtYr1QDaQyRYH2oyNGP4GwscT6aFGEa0GIuL5x9ssO/5aJe9OiX3HGVC5J/GUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 9CEBD7C0115;
	Mon, 24 Mar 2025 11:17:57 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P1609374T281457048416624S1742786276537166_;
	Mon, 24 Mar 2025 11:17:57 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:shaopeijie@cestc.cn
X-SENDER:shaopeijie@cestc.cn
X-LOGIN-NAME:shaopeijie@cestc.cn
X-FST-TO:hch@lst.de
X-RCPT-COUNT:8
X-LOCAL-RCPT-COUNT:3
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<4867d17f220f89c11711a249c798926b>
X-System-Flag:0
From: shaopeijie@cestc.cn
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn,
	gechangzhong@cestc.cn,
	Peijie Shao <shaopeijie@cestc.cn>
Subject: [PATCH] nvmet: Replace sock_create with sock_create_kern
Date: Mon, 24 Mar 2025 11:17:08 +0800
Message-ID: <20250324031708.1687164-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peijie Shao <shaopeijie@cestc.cn>

Replacing sock_create() with sock_create_kern()
changes the socket object's label to kernel_t,
thereby bypassing unnecessary SELinux permission
checks. It also helps to avoid copy and paste bugs.

Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f9cac8a5abe..216afacc8179 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2049,7 +2049,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
+	ret = sock_create_kern(current->nsproxy->net_ns,
+				port->addr.ss_family, SOCK_STREAM,
 				IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
-- 
2.43.0




