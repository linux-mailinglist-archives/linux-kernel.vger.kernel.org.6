Return-Path: <linux-kernel+bounces-534695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1027A46A07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AB93AD199
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53736237164;
	Wed, 26 Feb 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkh3rAot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44621A92F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595572; cv=none; b=VuCXUWZBJgc5HKW7Jxjmx4/IBT37rpqDXllsUBC5Osagpb5G2tbZu6aqmTpHQU8JdGf8GbWRfelIuE8ofTaJSdLP7yZdyKKw+8edcxXB69eO0b6fBJElbFWhEW/uRFESsc3BWeHdk0SpCgzn128PDWggU6tEKR1MeaTFEVugzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595572; c=relaxed/simple;
	bh=rCD9QYbyoazCDF/iLKJMcfOqtD6D4ELGTlkaa2TRQvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1qcjoQjp1OUayplALz3/ruj6TLF/sFFapxRmMhtxIVaBjx/SVEZfA7DvUDHSP+Xpoo3uXDs0+8PqmvbmwrNIx+08c0p7nH4IInnMdJlDOlMoteukoUIAxj8X9lC7GZylOfh2mbEh3zY2ed68cCGykwYbBnwJ5xsMtVewzwey/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkh3rAot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4CFC4CED6;
	Wed, 26 Feb 2025 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595572;
	bh=rCD9QYbyoazCDF/iLKJMcfOqtD6D4ELGTlkaa2TRQvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qkh3rAotbyNAH5uU5EFkTF85cDZG6TuME+7BiZkC2kcaIoPENXXj0CUmjLPyD0OqD
	 T687OYJdMOft8gAiODzK9QL/1pCW4G7y65u4SOAptJiJtRSvLYDXhLKV8P7P9C8aFY
	 279Gj+EZwt1dJrtN2yBSsyTs0m7Mrp6ZcbVj/yh4SuoJRTbHydcd9hgFCHkyCdXYmM
	 qyy6X3D6K4Q877Ydkek52unB5mEYYQ9DpuMndTTHVp0UcuF4dvXoho4fGo0j+VGcEN
	 I42twBQDwsFjVJchvghgcHTh2Agr4PD8WxsNOFZ0JBDrtW9hKLhK2/d7tHbHzkkU/F
	 OvIO0mMj01Wfw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:58 +0100
Subject: [PATCH 06/11] nvmet-fcloop: track rport with ref counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The rport object is created via nvme_fc_register_remote and freed
via nvme_fc_unregister_remoteport. That means after the port is
unregistered nothing should use it. Thus ensure with refcounting
that there is no user left before the unregister step.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2269b4d20af2ef9bb423617b94a5f5326ea124bd..d64f5fba136e13c9e4e545acecd905c31542d442 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -223,8 +223,12 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	struct kref			ref;
 };
 
+static int fcloop_rport_get(struct fcloop_rport *rport);
+static void fcloop_rport_put(struct fcloop_rport *rport);
+
 struct fcloop_tport {
 	struct nvmet_fc_target_port	*targetport;
 	struct nvme_fc_remote_port	*remoteport;
@@ -346,6 +350,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
 		spin_lock(&rport->lock);
 	}
 	spin_unlock(&rport->lock);
+	fcloop_rport_put(rport);
 }
 
 static int
@@ -365,7 +370,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 		spin_lock(&rport->lock);
 		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
+		if (queue_work(nvmet_wq, &rport->ls_work))
+			fcloop_rport_get(rport);
 		return ret;
 	}
 
@@ -398,7 +404,8 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 		spin_lock(&rport->lock);
 		list_add_tail(&tls_req->ls_list, &rport->ls_list);
 		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
+		if (queue_work(nvmet_wq, &rport->ls_work))
+			fcloop_rport_get(rport);
 	}
 
 	return 0;
@@ -1078,9 +1085,6 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
 static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
-	struct fcloop_rport *rport = remoteport->private;
-
-	flush_work(&rport->ls_work);
 }
 
 static void
@@ -1386,6 +1390,8 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 
 	/* success */
 	rport = remoteport->private;
+	kref_init(&rport->ref);
+
 	rport->remoteport = remoteport;
 	rport->targetport = (nport->tport) ?  nport->tport->targetport : NULL;
 	if (nport->tport) {
@@ -1418,21 +1424,30 @@ __unlink_remote_port(struct fcloop_nport *nport)
 	return rport;
 }
 
-static int
-__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
+static void
+fcloop_remoteport_unreg(struct kref *ref)
 {
-	int ret;
+	struct fcloop_rport *rport =
+		container_of(ref, struct fcloop_rport, ref);
+	struct fcloop_nport *nport;
 
-	if (!rport) {
-		ret = -EALREADY;
-		goto out;
-	}
+	nport = rport->nport;
+	nvme_fc_unregister_remoteport(rport->remoteport);
 
-	ret = nvme_fc_unregister_remoteport(rport->remoteport);
-out:
 	/* nport ref put: remoteport */
 	fcloop_nport_put(nport);
-	return ret;
+}
+
+static int
+fcloop_rport_get(struct fcloop_rport *rport)
+{
+	return kref_get_unless_zero(&rport->ref);
+}
+
+static void
+fcloop_rport_put(struct fcloop_rport *rport)
+{
+	kref_put(&rport->ref, fcloop_remoteport_unreg);
 }
 
 static ssize_t
@@ -1468,8 +1483,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __remoteport_unreg(nport, rport);
-
+	fcloop_rport_put(rport);
 	fcloop_nport_put(nport);
 
 	return ret ? ret : count;
@@ -1717,10 +1731,7 @@ static void __exit fcloop_exit(void)
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
 		fcloop_tport_put(tport);
-
-		ret = __remoteport_unreg(nport, rport);
-		if (ret)
-			pr_warn("%s: Failed deleting remote port\n", __func__);
+		fcloop_rport_put(rport);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}

-- 
2.48.1


