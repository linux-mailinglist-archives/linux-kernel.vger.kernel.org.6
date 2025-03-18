Return-Path: <linux-kernel+bounces-565964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B5A6719E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01D43B91D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06120B1F2;
	Tue, 18 Mar 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwv68cRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CF20B1EA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294425; cv=none; b=KrUZj6tCWZ+3D/yWbaoZel0RANpQninSa88xsnM9dv7XpIyoMxFXQ0m40jqq9RAq1I5k0NuuAoG+dKF6iUc9dWYEJCC5PHmMMeWPy0GyNQ9WhIGId/ohbBWbXysQKcor0eFwVLKwn8qTemhbVThnHPqdfSMAlY1crolfeRZE5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294425; c=relaxed/simple;
	bh=Ao268T67hDxmPxHaefQt0CLnltxYa5k4a0l1IHd9hCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEsL7noTcFolIYRUP1uYbMDD9w6izUBcGmYRLqFAzQ1CsbDk3AL7lr2mLDa0hnhlECNc7nxwlXntYlbe+Aegi86ELcr8UQsuVJwfb0uzRHEQbopG5Cz84UQEsdGx6bqwIx0BzL+UdJiZvQhqVYDQz9dZBkfn+4CyoEzhAAA/72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwv68cRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C466BC4CEF1;
	Tue, 18 Mar 2025 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294425;
	bh=Ao268T67hDxmPxHaefQt0CLnltxYa5k4a0l1IHd9hCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Iwv68cRy9tqCoYfLNsYQLavDYYTwic6Oc8x/ZZz4dmO9bwrzmj0bOGQCU2tJtS0US
	 NDSgaQ8l5TEc5sCR8LgS9PLczdTy10ABgkyiUKFydwWHByBN9NsZTG1ngSz384w+n8
	 RrEffaCh1unPpy8Xj5wmBuVWycFe90FhGl24jdFBaY3wx2B5x4Ri3fAVdAOYKR+73G
	 sDEz3+2tD0vKXPjlr1Yt1LMgUAJH/zto93EAMyGnixlf8AzjayVhm7a96NPnrRBz/O
	 2+xVVQwyJVXbxU4UxdLgW7rBl6bsxT4/0hJf1io+MtU3XYlcxg0GsJKWM96w3o4j+U
	 0wjN15SW0UuXA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:03 +0100
Subject: [PATCH v3 09/18] nvmet-fcloop: prevent double port deletion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-9-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The delete callback can be called either via the unregister function or
from the transport directly. Thus it is necessary ensure resources are
not freed multiple times.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index de23f0bc5599b6f8dd5c3713dd38c952e6fdda28..06f42da6a0335c53ae319133119d057aab12e07e 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -215,6 +215,8 @@ struct fcloop_lport_priv {
 	struct fcloop_lport *lport;
 };
 
+#define PORT_DELETE	0
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port	*remoteport;
 	struct nvmet_fc_target_port	*targetport;
@@ -223,6 +225,7 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_tport {
@@ -233,6 +236,7 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_nport {
@@ -1062,14 +1066,20 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&rport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETE, &rport->flags))
+		delete_port = false;
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	/* nport ref put: rport */
 	fcloop_nport_put(rport->nport);
 }
@@ -1078,14 +1088,20 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&tport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETE, &tport->flags))
+		delete_port = false;
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	complete(&tport->nport->tport_unreg_done);
 
 	/* nport ref put: tport */
@@ -1394,6 +1410,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	rport->flags = 0;
 	spin_lock_init(&rport->lock);
 	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
 	INIT_LIST_HEAD(&rport->ls_list);
@@ -1492,6 +1509,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	tport->flags = 0;
 	spin_lock_init(&tport->lock);
 	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
 	INIT_LIST_HEAD(&tport->ls_list);

-- 
2.48.1


