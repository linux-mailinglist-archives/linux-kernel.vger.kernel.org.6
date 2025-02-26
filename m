Return-Path: <linux-kernel+bounces-534691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E8A46A03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E1F168F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85E23535E;
	Wed, 26 Feb 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVxzKg8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3ED235BF4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595562; cv=none; b=Aq53SXdrI8J7PkU4iK+y5EnLUWM9YxHXUE2/uOJy43uwVAvOVCSnaft/ZDoe0VLSF8lx3XsaBFylRseDywYuX83wLN1+nGiJ2eipimBY87PDfO3e8ef83fXEBJz14VNqzPHsiqANmK5VAT08uCd9GPIdaHctDBQX2S78VcR/wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595562; c=relaxed/simple;
	bh=GGboBiUAnzqzEkcPJLhVinGFyNQd+KTlEDa9DnpBz6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqKpqqmugpL2nyjSEsXwsvCzVdSfqBGciNZqafme84t3qwXZB8XWq8u3HrTL4EHkl/zyByg66A9sU9tGPhljBXAbtrTi3r5wRaEC+vzLnszrg7S4bjdSCYBTWv9fiSpRcMrqJati9TtQv+PD5nQa1M+fm8gnD91ytftr3XXEjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVxzKg8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C59C4CEE7;
	Wed, 26 Feb 2025 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595561;
	bh=GGboBiUAnzqzEkcPJLhVinGFyNQd+KTlEDa9DnpBz6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IVxzKg8Qheh7Ol+EGR/xq1SAommDIl0ENloP8OFTqRtlC8TLqPwVmh/WT0edIMQZz
	 WjPHVr2l8skhk0j0CEC4+wffRBmG9l9lcZ/GS60dxIUMfQWfhWYnrYeGQYRS7/6SEz
	 9HFSkipZBVNrHv82eQwamSsOT2z9nGVK22cI2RGj+5bAFsNGOO/z/KYNrlTWf4xkCp
	 g8+STH3jyTAqdDCKqmYmlyQGE4B3lkS7d4DQ9VkRGw00aaK8BzWbab4AIJaacu/Oo1
	 tLZdDRhqveGv3hf+HISYVCkYDOGcFIHKqMMWcqTRh9HnM0rVCXNAew5rgC5loNXoJ4
	 JPXhI84MMCISg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:54 +0100
Subject: [PATCH 02/11] nvmet-fcloop: add ref counting to lport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-2-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The fcloop_lport objects live time is controlled by the user interface
add_local_port and del_local_port. nport, rport and tport objects are
pointing to the lport objects but here is no clear tracking. Let's
introduce an explicit ref counter for the lport objects and prepare the
stage for restructuring how lports are used.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5493677a948d34391c7c08055dfefd91cc3ff33f..ca46830d46ecbaae21f3ee3e69aa7d52905abcae 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -208,6 +208,7 @@ struct fcloop_lport {
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
 	struct completion unreg_done;
+	struct kref ref;
 };
 
 struct fcloop_lport_priv {
@@ -1000,6 +1001,32 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 }
 
+static void
+fcloop_lport_free(struct kref *ref)
+{
+	struct fcloop_lport *lport =
+		container_of(ref, struct fcloop_lport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&lport->lport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(lport);
+}
+
+static void
+fcloop_lport_put(struct fcloop_lport *lport)
+{
+	kref_put(&lport->ref, fcloop_lport_free);
+}
+
+static int
+fcloop_lport_get(struct fcloop_lport *lport)
+{
+	return kref_get_unless_zero(&lport->ref);
+}
+
 static void
 fcloop_nport_free(struct kref *ref)
 {
@@ -1145,6 +1172,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 
 		lport->localport = localport;
 		INIT_LIST_HEAD(&lport->lport_list);
+		kref_init(&lport->ref);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 		list_add_tail(&lport->lport_list, &fcloop_lports);
@@ -1161,13 +1189,6 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
-
-static void
-__unlink_local_port(struct fcloop_lport *lport)
-{
-	list_del(&lport->lport_list);
-}
-
 static int
 __wait_localport_unreg(struct fcloop_lport *lport)
 {
@@ -1180,7 +1201,7 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	if (!ret)
 		wait_for_completion(&lport->unreg_done);
 
-	kfree(lport);
+	fcloop_lport_put(lport);
 
 	return ret;
 }
@@ -1204,8 +1225,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
 		if (tlport->localport->node_name == nodename &&
 		    tlport->localport->port_name == portname) {
+			if (!fcloop_lport_get(tlport))
+				break;
 			lport = tlport;
-			__unlink_local_port(lport);
 			break;
 		}
 	}
@@ -1215,6 +1237,7 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		return -ENOENT;
 
 	ret = __wait_localport_unreg(lport);
+	fcloop_lport_put(lport);
 
 	return ret ? ret : count;
 }
@@ -1640,17 +1663,17 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		lport = list_first_entry_or_null(&fcloop_lports,
 						typeof(*lport), lport_list);
-		if (!lport)
+		if (!lport || !fcloop_lport_get(lport))
 			break;
 
-		__unlink_local_port(lport);
-
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
 		ret = __wait_localport_unreg(lport);
 		if (ret)
 			pr_warn("%s: Failed deleting local port\n", __func__);
 
+		fcloop_lport_put(lport);
+
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}
 

-- 
2.48.1


