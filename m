Return-Path: <linux-kernel+bounces-534693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B8A46A05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB671888B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A31236A6D;
	Wed, 26 Feb 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwf8vNjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014C236457
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595567; cv=none; b=aWU1AY8Zdc0SUC8RH/EVH0GmxXnTwVKNM8nFG/IZ/crHsmQmpCmm/hEB34IqkKG8NwOpUmfas8BiATIQGuuAHj7CxpkKwMlLUVxSfOIgT6Rt9+MvlxFwvgHuvWZRusstIvwR0qy+dw8/Dnd1m3rm+D0ikI61u8yGCNNgF72BGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595567; c=relaxed/simple;
	bh=hpAwt8sa4lVKf33YbvMGj5JYpcBJeY0KnjyqEjt3T/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=heHkFTqzloc0IforEQ1HbDbiYnR69S2JTb35mjKehiYeEzd/85ZGOl/E45dccJo6D9fnH7oSw7T55EsoN7OUvEmdeLvWq6pFcHik2jniePXuv3S2o++Nif2lkSdvlIu75HCvBlj3ZRtNW3NNTFkEghw0XoOrS/Im4JZ6Mz7ZnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwf8vNjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A881C4CEE7;
	Wed, 26 Feb 2025 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595567;
	bh=hpAwt8sa4lVKf33YbvMGj5JYpcBJeY0KnjyqEjt3T/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nwf8vNjSjzpId+uUtsOySrgqouR6zL4gSXLikn4qPEdF+Ea1GDSv79zHBgAIFJvFb
	 JIyazK+Ot18xJcbfjEuyJ4yVgbAK5StVY5jzos4wkz48C5rHj4wqZjF3TvOCZhPyIg
	 YzvDckqk32/OtJfTQ1V8VgJZBwXwnNnmuA4NUrb1G1EKitM3CQiQZKVSlB40cB3asn
	 NmBsEaJifGmfcruL1lUop1oLCEpKxl5M5Dq60ESQotqE9lsKOyEpEia6s9AtYzXk68
	 2YCnk3OhUqKqfqS7dQDVNqMEgWZJ+2BCFvPbs8bW9lxd/QaKO+aAH/dxx7Jw6IIcHa
	 RHNkg2Dm+mseg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:56 +0100
Subject: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

A nport object is always used in association with targerport,
remoteport, tport and rport objects. Add explicit references for any of
the associated object. This makes the unreliable reference updates in
the two callback fcloop_targetport_delete and fcloop_remoteport_delete
obsolete.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 57 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index de1963c34bd88d0335f70de569565740fd395a0a..80693705c069dd114b2d4f15d0482dd2d713a273 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1071,16 +1071,11 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	struct fcloop_rport *rport = remoteport->private;
 
 	flush_work(&rport->ls_work);
-	fcloop_nport_put(rport->nport);
 }
 
 static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
-	struct fcloop_tport *tport = targetport->private;
-
-	flush_work(&tport->ls_work);
-	fcloop_nport_put(tport->nport);
 }
 
 #define	FCLOOP_HW_QUEUES		4
@@ -1358,6 +1353,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	struct nvme_fc_port_info pinfo;
 	int ret;
 
+	/* nport ref get: rport */
 	nport = fcloop_alloc_nport(buf, count, true);
 	if (!nport)
 		return -EIO;
@@ -1375,6 +1371,9 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 		return ret;
 	}
 
+	/* nport ref get: remoteport */
+	fcloop_nport_get(nport);
+
 	/* success */
 	rport = remoteport->private;
 	rport->remoteport = remoteport;
@@ -1403,16 +1402,27 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	/* nport ref put: rport */
+	fcloop_nport_put(nport);
+
 	return rport;
 }
 
 static int
 __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	if (!rport)
-		return -EALREADY;
+	int ret;
 
-	return nvme_fc_unregister_remoteport(rport->remoteport);
+	if (!rport) {
+		ret = -EALREADY;
+		goto out;
+	}
+
+	ret = nvme_fc_unregister_remoteport(rport->remoteport);
+out:
+	/* nport ref put: remoteport */
+	fcloop_nport_put(nport);
+	return ret;
 }
 
 static ssize_t
@@ -1434,6 +1444,9 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
 		if (tmpport->node_name == nodename &&
 		    tmpport->port_name == portname && tmpport->rport) {
+
+			if (!fcloop_nport_get(tmpport))
+				break;
 			nport = tmpport;
 			rport = __unlink_remote_port(nport);
 			break;
@@ -1447,6 +1460,8 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 
 	ret = __remoteport_unreg(nport, rport);
 
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 
@@ -1460,6 +1475,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	struct nvmet_fc_port_info tinfo;
 	int ret;
 
+	/* nport ref get: tport */
 	nport = fcloop_alloc_nport(buf, count, false);
 	if (!nport)
 		return -EIO;
@@ -1475,6 +1491,9 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 		return ret;
 	}
 
+	/* nport ref get: targetport */
+	fcloop_nport_get(nport);
+
 	/* success */
 	tport = targetport->private;
 	tport->targetport = targetport;
@@ -1501,16 +1520,27 @@ __unlink_target_port(struct fcloop_nport *nport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
 
+	/* nport ref put: tport */
+	fcloop_nport_put(nport);
+
 	return tport;
 }
 
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	if (!tport)
-		return -EALREADY;
+	int ret;
 
-	return nvmet_fc_unregister_targetport(tport->targetport);
+	if (!tport) {
+		ret = -EALREADY;
+		goto out;
+	}
+
+	ret = nvmet_fc_unregister_targetport(tport->targetport);
+out:
+	/* nport ref put: targetport */
+	fcloop_nport_put(nport);
+	return ret;
 }
 
 static ssize_t
@@ -1532,6 +1562,9 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
 		if (tmpport->node_name == nodename &&
 		    tmpport->port_name == portname && tmpport->tport) {
+
+			if (!fcloop_nport_get(tmpport))
+				break;
 			nport = tmpport;
 			tport = __unlink_target_port(nport);
 			break;
@@ -1545,6 +1578,8 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 
 	ret = __targetport_unreg(nport, tport);
 
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 

-- 
2.48.1


