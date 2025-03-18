Return-Path: <linux-kernel+bounces-565958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A5A67197
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B254017DA23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749620A5D5;
	Tue, 18 Mar 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPeOYr/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6520A5C4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294410; cv=none; b=ah8rlP9q004l4d3/McELFJ0qiGZPYM6RNmMlRGHKOBKE36O6rOXvXx/xwpTrubXOtCcc86e2BihyBip31zIug+fvJgSa9TuVD6eRE78eu4O+XkCtHKsPZoIzUhUvHGV7tdwdYVrKOWDveLOhr4ZRWX5NeWSWiX2CMr85AZISoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294410; c=relaxed/simple;
	bh=OQSv15/6TyBgYVPiFmCsM9pOg5Rh9yhAqL/bdMmg7e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MroJ95IxTBSiG4vggCIdQMEXksIPEM3jCY9Cso0gb//LQcGavuV60bmA7YCcUyXpDe1cE0vet2iM3FxBb060/nKUAEkCcWzZutd3iG2E1RPitqr8VzUqXV2NH5tM6Em1dLXyn6lfU13Q8B4riGO6bcNN+YhSbRXgPQLVXOUbOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPeOYr/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2330C4CEE3;
	Tue, 18 Mar 2025 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294410;
	bh=OQSv15/6TyBgYVPiFmCsM9pOg5Rh9yhAqL/bdMmg7e8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PPeOYr/PZrvh+L+uTQQ+nlAvj/DS3C6WxgD2OF+1DOERvpwX3Agzd9LJgdTXb1YYw
	 TUxlsAAeg4IJTmR+EfsKeoOlmORLFa0HjDEdeEXNTN4RDBFMQtQx+iJjNt0nc2pjT0
	 nYlAZ7qE3utvy3SyiJdcY3Ykt676iDGuki43k+49u7xUhN02DxQMsT1eEXs3qqqI9o
	 9i4ntJdbI8j+AXzl4GxXyylImG47FMCwLQEKfUrDddbR5zPksklvpbvp3gu5KXYZg2
	 T+kXFhZ/kt+X3IeNvwhNxYu9VI29cROX5bZq0f5XogeoLhFmKhx3GSMfbTUJCCBF8o
	 VNUcpdI4LYYNg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:39:57 +0100
Subject: [PATCH v3 03/18] nvmet-fcloop: add ref counting to lport
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-3-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index cfce70d1b11ff305b203d716f78fad23f114e9c3..c6d5a31ce0b5ccb10988e339ae22d528e06d5e2b 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -208,6 +208,7 @@ struct fcloop_lport {
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
 	struct completion unreg_done;
+	refcount_t ref;
 };
 
 struct fcloop_lport_priv {
@@ -993,6 +994,27 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 }
 
+static void
+fcloop_lport_put(struct fcloop_lport *lport)
+{
+	unsigned long flags;
+
+	if (!refcount_dec_and_test(&lport->ref))
+		return;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&lport->lport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(lport);
+}
+
+static int
+fcloop_lport_get(struct fcloop_lport *lport)
+{
+	return refcount_inc_not_zero(&lport->ref);
+}
+
 static void
 fcloop_nport_put(struct fcloop_nport *nport)
 {
@@ -1022,6 +1044,8 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
 
 	/* release any threads waiting for the unreg to complete */
 	complete(&lport->unreg_done);
+
+	fcloop_lport_put(lport);
 }
 
 static void
@@ -1133,6 +1157,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 
 		lport->localport = localport;
 		INIT_LIST_HEAD(&lport->lport_list);
+		refcount_set(&lport->ref, 1);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 		list_add_tail(&lport->lport_list, &fcloop_lports);
@@ -1149,13 +1174,6 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
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
@@ -1168,8 +1186,6 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	if (!ret)
 		wait_for_completion(&lport->unreg_done);
 
-	kfree(lport);
-
 	return ret;
 }
 
@@ -1192,8 +1208,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
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
@@ -1203,6 +1220,7 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		return -ENOENT;
 
 	ret = __wait_localport_unreg(lport);
+	fcloop_lport_put(lport);
 
 	return ret ? ret : count;
 }
@@ -1628,17 +1646,17 @@ static void __exit fcloop_exit(void)
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


