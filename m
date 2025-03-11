Return-Path: <linux-kernel+bounces-555838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC6A5BD50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFD16C678
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169732356D1;
	Tue, 11 Mar 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qutyueFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766B2356A3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687914; cv=none; b=MXgUE12hkZgNQVChAdPJ8sEEl4331TGyk++wLKKDSWWRfU1edSydhShcRTmzX/pSYY5jmLdjqK3jtRlHz1jubFYvWqgtMsTIr0ZSY1GWvaB3mckV2uf+JJRV4PyQJmosvQTw6QC6qiexHJ4BCfa7KNU7MtGdMJvL2+2gBn4q5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687914; c=relaxed/simple;
	bh=42lgKVStnOsQDpz87YZqnfODlK/usamWTa0F2H2+v3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5qOcTkaMKxMnlZj2MEhemO4vNgAty4p6cZbNtkX8ympbPibBzS6Ay6VxaOP/7Y3OqtaRIBbiySLfB5Z9HcGeeud73bk5EyHn2q5PR/F2my0rNR1KUH1fLQskuiimSW8LasR35OVtOf80mwGZ8au81isCVDSwTArU1G4v0d2hsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qutyueFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90D2C4CEEB;
	Tue, 11 Mar 2025 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687914;
	bh=42lgKVStnOsQDpz87YZqnfODlK/usamWTa0F2H2+v3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qutyueFWGPaV5wLNkl8orV8HVNHEy7PHN/qqUkvkfcZO6T4BqcXgupBg2Cphj+85r
	 FMCbOrZlgQRB0/N9/QZEB1+WmePDaILYWUgPI90kiV9sYq2aFSG73Ecj26iqk5oP0q
	 oInh2rjSUvX0f+x+7qc+QLBYc0v6Pr51y8WycM8RlkztMryg5k0CJPkRufAB5f2G2Z
	 aVmpmsZDSA0ZLHBB2bMXZMtoGK8T0ZQuZ0+F0eSkTjS+m/wEuN7CosF2jmXFYTFUJj
	 RixxKvLiGPqFKZZL1cJtdz5fxG8X6YJ4Gnf+urZ6Sodr4AB1uck1P97ZRiz7Zrs7Xh
	 9jKP28/vf8agg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:31 +0100
Subject: [PATCH v2 05/15] nvmet-fcloop: track ref counts for nports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-5-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

A nport object is always used in association with targerport,
remoteport, tport and rport objects. Add explicit references for any of
the associated object. This ensures that nport is not removed too early
on shutdown sequences.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 106 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 6e5408d59141158059cfe6b74c0924763c0c6b1d..d7c1a0beeccc5778977e4bc5836345e401adaa1c 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1055,8 +1055,15 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	unsigned long flags;
 
 	flush_work(&rport->ls_work);
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	rport->nport->rport = NULL;
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	/* nport ref put: rport */
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1064,8 +1071,15 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	unsigned long flags;
 
 	flush_work(&tport->ls_work);
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	tport->nport->tport = NULL;
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
 
@@ -1342,6 +1356,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	struct nvme_fc_port_info pinfo;
 	int ret;
 
+	/* nport ref get: rport */
 	nport = fcloop_alloc_nport(buf, count, true);
 	if (!nport)
 		return -EIO;
@@ -1383,6 +1398,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 {
 	struct fcloop_rport *rport = nport->rport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (rport && nport->tport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
@@ -1393,9 +1410,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 static int
 __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	if (!rport)
-		return -EALREADY;
-
 	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
@@ -1403,8 +1417,8 @@ static ssize_t
 fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_nport *nport = NULL, *tmpport;
-	static struct fcloop_rport *rport;
+	struct fcloop_nport *nport;
+	struct fcloop_rport *rport;
 	u64 nodename, portname;
 	unsigned long flags;
 	int ret;
@@ -1413,24 +1427,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
-		if (tmpport->node_name == nodename &&
-		    tmpport->port_name == portname && tmpport->rport) {
-			nport = tmpport;
-			rport = __unlink_remote_port(nport);
-			break;
-		}
-	}
+	nport = fcloop_nport_lookup(nodename, portname);
+	if (!nport)
+		return -ENOENT;
 
+	spin_lock_irqsave(&fcloop_lock, flags);
+	rport = __unlink_remote_port(nport);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (!nport)
-		return -ENOENT;
+	if (!rport) {
+		ret = -ENOENT;
+		goto out_nport_put;
+	}
 
 	ret = __remoteport_unreg(nport, rport);
 
+out_nport_put:
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 
@@ -1444,6 +1458,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	struct nvmet_fc_port_info tinfo;
 	int ret;
 
+	/* nport ref get: tport */
 	nport = fcloop_alloc_nport(buf, count, false);
 	if (!nport)
 		return -EIO;
@@ -1481,6 +1496,8 @@ __unlink_target_port(struct fcloop_nport *nport)
 {
 	struct fcloop_tport *tport = nport->tport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (tport && nport->rport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
@@ -1491,9 +1508,6 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	if (!tport)
-		return -EALREADY;
-
 	return nvmet_fc_unregister_targetport(tport->targetport);
 }
 
@@ -1501,8 +1515,8 @@ static ssize_t
 fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct fcloop_nport *nport = NULL, *tmpport;
-	struct fcloop_tport *tport = NULL;
+	struct fcloop_nport *nport;
+	struct fcloop_tport *tport;
 	u64 nodename, portname;
 	unsigned long flags;
 	int ret;
@@ -1511,24 +1525,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&fcloop_lock, flags);
-
-	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
-		if (tmpport->node_name == nodename &&
-		    tmpport->port_name == portname && tmpport->tport) {
-			nport = tmpport;
-			tport = __unlink_target_port(nport);
-			break;
-		}
-	}
+	nport = fcloop_nport_lookup(nodename, portname);
+	if (!nport)
+		return -ENOENT;
 
+	spin_lock_irqsave(&fcloop_lock, flags);
+	tport = __unlink_target_port(nport);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (!nport)
-		return -ENOENT;
+	if (!tport) {
+		ret = -ENOENT;
+		goto out_nport_put;
+	}
 
 	ret = __targetport_unreg(nport, tport);
 
+out_nport_put:
+	fcloop_nport_put(nport);
+
 	return ret ? ret : count;
 }
 
@@ -1625,8 +1639,8 @@ static int __init fcloop_init(void)
 
 static void __exit fcloop_exit(void)
 {
-	struct fcloop_lport *lport = NULL;
-	struct fcloop_nport *nport = NULL;
+	struct fcloop_lport *lport;
+	struct fcloop_nport *nport;
 	struct fcloop_tport *tport;
 	struct fcloop_rport *rport;
 	unsigned long flags;
@@ -1637,7 +1651,7 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		nport = list_first_entry_or_null(&fcloop_nports,
 						typeof(*nport), nport_list);
-		if (!nport)
+		if (!nport || !fcloop_nport_get(nport))
 			break;
 
 		tport = __unlink_target_port(nport);
@@ -1645,13 +1659,19 @@ static void __exit fcloop_exit(void)
 
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
-		ret = __targetport_unreg(nport, tport);
-		if (ret)
-			pr_warn("%s: Failed deleting target port\n", __func__);
+		if (tport) {
+			ret = __targetport_unreg(nport, tport);
+			if (ret)
+				pr_warn("%s: Failed deleting target port\n", __func__);
+		}
 
-		ret = __remoteport_unreg(nport, rport);
-		if (ret)
-			pr_warn("%s: Failed deleting remote port\n", __func__);
+		if (rport) {
+			ret = __remoteport_unreg(nport, rport);
+			if (ret)
+				pr_warn("%s: Failed deleting remote port\n", __func__);
+		}
+
+		fcloop_nport_put(nport);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}

-- 
2.48.1


