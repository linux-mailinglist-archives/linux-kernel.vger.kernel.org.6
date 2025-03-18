Return-Path: <linux-kernel+bounces-565960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FBA6719A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4843A17E5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295520ADC9;
	Tue, 18 Mar 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM8uVMWf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD5224CC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294417; cv=none; b=AIye359/wJeaadUxQSLCnDRqlhtetYDY7H6eQlWREE5XF1jHDnQaY2ygkKyKz3L7MLvcMXmyErXBChjpQGgVjPPOTAWFu7O/yT+6D7SDLRs2qaMxjyJz5LE6sC4VjHgC86aBL6kHOEWLLUOOxNyCk9iM/KbG07qmPrxYANT4eoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294417; c=relaxed/simple;
	bh=nE75BNgsWEd3wOhWskr3tujrO/j2HRVbU7VVwxBCnRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hE5Mn0VJ2EEAPe3RwmVhfb3nOO5a29I65MJbKCfTpmAxHrZI6fxAhxuHoqPMlPdMjudLi5LhazM5mVjMrknXqo9MlGSvMZsFNiORYnrxsfdGoQVP97go3ORMNoRjk4YTujHstee4hy3fiWhmYGBpvXbExMYNu27v7BlpOeqBZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM8uVMWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71F5C4CEDD;
	Tue, 18 Mar 2025 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294415;
	bh=nE75BNgsWEd3wOhWskr3tujrO/j2HRVbU7VVwxBCnRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jM8uVMWfuJ/wmzcBHIb9WMzbiam2ts8QahN2AOWFbMjeNDN9oeI7iSK26enyzoa78
	 EBilcR6XCgKEcqf+r2YoITjHIZFvD9hB17IZMRpip41z/fk1eWs0K9zRSz8AZ5XHmJ
	 kYH/6oSSgDXNtymA0dfHYYi/q2XVD9VvXH/1BK5JgLCMtDO83RcmI4a7Hbrg39B+H4
	 ni6oU3uWbvn03KwWgy4Zgr8wVCAubOEWhd515Bgi9AQgq2Ma8jTqPfrNSNXS06edo7
	 Z5b5nJBE6s93fjK+u1qvWtrhnddTxTaSuTaEkoPHSlKv9I4Enq7BR4bCjSkWcr7ddM
	 FfGWAESUTq50g==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:59 +0100
Subject: [PATCH v3 05/18] nvmet-fcloop: track ref counts for nports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-5-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
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
index 245bfe08d91ec81f1979251e8c757a0d46fd09e9..69121a5f0f280936d1b720e9e994d6e5eb9186ff 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1054,8 +1054,15 @@ static void
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
 
@@ -1063,8 +1070,15 @@ static void
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
 
@@ -1341,6 +1355,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	struct nvme_fc_port_info pinfo;
 	int ret;
 
+	/* nport ref get: rport */
 	nport = fcloop_alloc_nport(buf, count, true);
 	if (!nport)
 		return -EIO;
@@ -1382,6 +1397,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 {
 	struct fcloop_rport *rport = nport->rport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (rport && nport->tport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
@@ -1392,9 +1409,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 static int
 __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
 {
-	if (!rport)
-		return -EALREADY;
-
 	return nvme_fc_unregister_remoteport(rport->remoteport);
 }
 
@@ -1402,8 +1416,8 @@ static ssize_t
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
@@ -1412,24 +1426,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
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
 
@@ -1443,6 +1457,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	struct nvmet_fc_port_info tinfo;
 	int ret;
 
+	/* nport ref get: tport */
 	nport = fcloop_alloc_nport(buf, count, false);
 	if (!nport)
 		return -EIO;
@@ -1480,6 +1495,8 @@ __unlink_target_port(struct fcloop_nport *nport)
 {
 	struct fcloop_tport *tport = nport->tport;
 
+	lockdep_assert_held(&fcloop_lock);
+
 	if (tport && nport->rport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
@@ -1490,9 +1507,6 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	if (!tport)
-		return -EALREADY;
-
 	return nvmet_fc_unregister_targetport(tport->targetport);
 }
 
@@ -1500,8 +1514,8 @@ static ssize_t
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
@@ -1510,24 +1524,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
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
 
@@ -1624,8 +1638,8 @@ static int __init fcloop_init(void)
 
 static void __exit fcloop_exit(void)
 {
-	struct fcloop_lport *lport = NULL;
-	struct fcloop_nport *nport = NULL;
+	struct fcloop_lport *lport;
+	struct fcloop_nport *nport;
 	struct fcloop_tport *tport;
 	struct fcloop_rport *rport;
 	unsigned long flags;
@@ -1636,7 +1650,7 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		nport = list_first_entry_or_null(&fcloop_nports,
 						typeof(*nport), nport_list);
-		if (!nport)
+		if (!nport || !fcloop_nport_get(nport))
 			break;
 
 		tport = __unlink_target_port(nport);
@@ -1644,13 +1658,19 @@ static void __exit fcloop_exit(void)
 
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


