Return-Path: <linux-kernel+bounces-534694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51154A46A06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87013ACF43
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8560236457;
	Wed, 26 Feb 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGpRrc29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C172237164
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595570; cv=none; b=XA5r7uA8wH3CXTCPxRlQIXGxnpwEmytsvT5EIDKiSBmykYQhGAga8I8uM25ecCT2Vb7EFfsSg6mE4Z5yELvVbvtoSplW7oR9hjbTBXTJJU8hXIkH9GEFs5heCWZALKzeg6mE83x+1Nl5FDWP2Te+JTHwQRV1qqcZLJk2qdJhjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595570; c=relaxed/simple;
	bh=gdFyyvV3CV/ZqFGdzKB4cfzAhMwvR9qpkHzsViZuBwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/rp4bWEqtwR6pSHcGc5rgYkqmbOnV3qnCb6F45fskYR8X0VktxLe9MY+wKHw/xx270g51ukGPGUOffJalvKN1kCBbDqTYGfyl7IspdjCdmZOcETW9AgSvT/fRlC5e5zgGo4GGcNW7wvLA3KDaCDmpTow4ElNKpxpHVvizg8GV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGpRrc29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F5AC4CED6;
	Wed, 26 Feb 2025 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595569;
	bh=gdFyyvV3CV/ZqFGdzKB4cfzAhMwvR9qpkHzsViZuBwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AGpRrc29TsfXPoD+d4Y4asIqjRm2j2QzRzi+azZgP3pKM8/h/fwIDmznZd95p0+Vh
	 FmlNGR31+G47egARQWq4/F9sMWvyhK2G8DxAAdapPdYN5XgMW6Zc46+lcRHTBxJzwP
	 VXLmQpZQpfwT4carjghoGjaVLQx5az0Uf3MFXHTHL7XEO6jGsWMAzO6iQTaToxUaUF
	 qZChoyjb6bXiA1pL+xkuAgWSMyFmXQUJsnxuDnCtrGC7MvJOV2hbLww0/s6ifX1dR0
	 QyUJutZ2UYcr3kBhW+wkNZN92DTE7LdZSY8zyICNF+Fq4R04ytbt7l6F1D1Vu4gJhJ
	 I6lIvqpdjz1+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:57 +0100
Subject: [PATCH 05/11] nvmet-fcloop: track tport with ref counting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-5-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The tport object is created via nvmet_fc_register_targetport and freed
via nvmet_fc_unregister_targetport. That means after the port is
unregistered nothing should use it. Thus ensure with refcounting
that there is no user left before the unregister step.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 80693705c069dd114b2d4f15d0482dd2d713a273..2269b4d20af2ef9bb423617b94a5f5326ea124bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -233,8 +233,12 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	struct kref			ref;
 };
 
+static int fcloop_tport_get(struct fcloop_tport *tport);
+static void fcloop_tport_put(struct fcloop_tport *tport);
+
 struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
@@ -426,6 +430,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
 		spin_lock(&tport->lock);
 	}
 	spin_unlock(&tport->lock);
+	fcloop_tport_put(tport);
 }
 
 static int
@@ -444,12 +449,16 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
+	if (!tport)
+		return -ECONNABORTED;
+
 	if (!tport->remoteport) {
 		tls_req->status = -ECONNREFUSED;
 		spin_lock(&tport->lock);
 		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
+		if (queue_work(nvmet_wq, &tport->ls_work))
+			fcloop_tport_get(tport);
 		return ret;
 	}
 
@@ -481,7 +490,8 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 		spin_lock(&tport->lock);
 		list_add_tail(&tport->ls_list, &tls_req->ls_list);
 		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
+		if (queue_work(nvmet_wq, &tport->ls_work))
+			fcloop_tport_get(tport);
 	}
 
 	return 0;
@@ -1496,6 +1506,8 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 
 	/* success */
 	tport = targetport->private;
+	kref_init(&tport->ref);
+
 	tport->targetport = targetport;
 	tport->remoteport = (nport->rport) ?  nport->rport->remoteport : NULL;
 	if (nport->rport)
@@ -1526,21 +1538,30 @@ __unlink_target_port(struct fcloop_nport *nport)
 	return tport;
 }
 
-static int
-__targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
+static void
+fcloop_targetport_unreg(struct kref *ref)
 {
-	int ret;
+	struct fcloop_tport *tport =
+		container_of(ref, struct fcloop_tport, ref);
+	struct fcloop_nport *nport;
 
-	if (!tport) {
-		ret = -EALREADY;
-		goto out;
-	}
+	nport = tport->nport;
+	nvmet_fc_unregister_targetport(tport->targetport);
 
-	ret = nvmet_fc_unregister_targetport(tport->targetport);
-out:
 	/* nport ref put: targetport */
 	fcloop_nport_put(nport);
-	return ret;
+}
+
+static int
+fcloop_tport_get(struct fcloop_tport *tport)
+{
+	return kref_get_unless_zero(&tport->ref);
+}
+
+static void
+fcloop_tport_put(struct fcloop_tport *tport)
+{
+	kref_put(&tport->ref, fcloop_targetport_unreg);
 }
 
 static ssize_t
@@ -1576,8 +1597,7 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (!nport)
 		return -ENOENT;
 
-	ret = __targetport_unreg(nport, tport);
-
+	fcloop_tport_put(tport);
 	fcloop_nport_put(nport);
 
 	return ret ? ret : count;
@@ -1696,9 +1716,7 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __targetport_unreg(nport, tport);
-		if (ret)
-			pr_warn("%s: Failed deleting target port\n", __func__);
+		fcloop_tport_put(tport);
 
 		ret = __remoteport_unreg(nport, rport);
 		if (ret)

-- 
2.48.1


