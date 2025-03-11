Return-Path: <linux-kernel+bounces-555848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E376A5BD64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8E31887E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441023A9B7;
	Tue, 11 Mar 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM0rkk1E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BD23A9A2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687937; cv=none; b=grf1sh5gROfk0mcAMHQ1nKIRGbN+yPwN9EdDtJxkFTAQu2B5B7cWl+7iod5goo+mC8xVFWa/TZB/LOuJ7cmM8kg9cj53eB68NnMjHTUJEWNgmX1HwDJfgDdLztXh1eq1J0/5o0bA5eZAJSBjpgtAbICuCr1FboC/YYGmXge4ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687937; c=relaxed/simple;
	bh=7ig0DLd7nkzl08O52hRpSPTMJ+VqCd+IrpqOT21+7Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkzZpLb9JuPfVC5d0ft9ilIrToxu/0tw5rVcPmxHwDcxmXcrukH9hQIWrRjYNqUqkX/OtltA1INs4/BufOyLHcxDnXjTfwMPvThZZf3cW5KQGiFhK1FbA7+aG6idrcq6QzMDd2jvP4FEGyn2A6SKaGyhUryACslm3i4RiwEgv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM0rkk1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C3DC4CEE9;
	Tue, 11 Mar 2025 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687936;
	bh=7ig0DLd7nkzl08O52hRpSPTMJ+VqCd+IrpqOT21+7Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LM0rkk1EHl86/DU5oigIinXNK3Q8CHY5SZikIrn+94WM2zp/ovucEUzfmi1fkMizJ
	 1xJWw3XxckodAY/GDAnNC1vHhYMLHlL4Vel1qlPeVss9WbC/e8+IKOEE4nUpmd8WVC
	 /R+HvPpk+V0xkAOw/b6H4hKznYDhIFXwBXHT9HxBBWS3nzhGkUTAnHdD07fYKBBHyG
	 YU8PHzpgT+rprhB57/qly+/0bGScpuhoCBp8r/ANjggWC0/tJ4H6zZqL+Wk4YxUGNe
	 j39nOSdJQAzCkLQepZ+ivrys1136UuyTDcXdsEaQq3Nn47EBWf1QMFheQHOtL8Y8LD
	 OwwGfuL8cO66w==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:40 +0100
Subject: [PATCH v2 14/15] nvmet-fc: take tgtport refs for portentry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-14-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Ensure that the tgtport is not going away as long portentry is a pointer
on it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d8c7efa6b6937aa9f5b99735f6669da973bf9ed3..50cfa02bf8cd1bc39ee8ca3f0b260c5a8733a9df 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1269,6 +1269,7 @@ nvmet_fc_portentry_bind(struct nvmet_fc_tgtport *tgtport,
 {
 	lockdep_assert_held(&nvmet_fc_tgtlock);
 
+	nvmet_fc_tgtport_get(tgtport);
 	pe->tgtport = tgtport;
 	tgtport->pe = pe;
 
@@ -1288,8 +1289,10 @@ nvmet_fc_portentry_unbind(struct nvmet_fc_port_entry *pe)
 	unsigned long flags;
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
-	if (pe->tgtport)
+	if (pe->tgtport) {
+		nvmet_fc_tgtport_put(pe->tgtport);
 		pe->tgtport->pe = NULL;
+	}
 	list_del(&pe->pe_list);
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
@@ -1307,8 +1310,10 @@ nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	pe = tgtport->pe;
-	if (pe)
+	if (pe) {
+		nvmet_fc_tgtport_put(pe->tgtport);
 		pe->tgtport = NULL;
+	}
 	tgtport->pe = NULL;
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 }
@@ -1331,6 +1336,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry(pe, &nvmet_fc_portentry_list, pe_list) {
 		if (tgtport->fc_target_port.node_name == pe->node_name &&
 		    tgtport->fc_target_port.port_name == pe->port_name) {
+			if (!nvmet_fc_tgtport_get(tgtport))
+				continue;
+
 			WARN_ON(pe->tgtport);
 			tgtport->pe = pe;
 			pe->tgtport = tgtport;
@@ -1661,7 +1669,6 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 }
 EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
-
 /* ********************** FC-NVME LS RCV Handling ************************* */
 
 
@@ -2900,12 +2907,17 @@ nvmet_fc_add_port(struct nvmet_port *port)
 	list_for_each_entry(tgtport, &nvmet_fc_target_list, tgt_list) {
 		if ((tgtport->fc_target_port.node_name == traddr.nn) &&
 		    (tgtport->fc_target_port.port_name == traddr.pn)) {
+			if (!nvmet_fc_tgtport_get(tgtport))
+				continue;
+
 			/* a FC port can only be 1 nvmet port id */
 			if (!tgtport->pe) {
 				nvmet_fc_portentry_bind(tgtport, pe, port);
 				ret = 0;
 			} else
 				ret = -EALREADY;
+
+			nvmet_fc_tgtport_put(tgtport);
 			break;
 		}
 	}
@@ -2921,11 +2933,21 @@ static void
 nvmet_fc_remove_port(struct nvmet_port *port)
 {
 	struct nvmet_fc_port_entry *pe = port->priv;
+	struct nvmet_fc_tgtport *tgtport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
+		tgtport = pe->tgtport;
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	nvmet_fc_portentry_unbind(pe);
 
-	/* terminate any outstanding associations */
-	__nvmet_fc_free_assocs(pe->tgtport);
+	if (tgtport) {
+		/* terminate any outstanding associations */
+		__nvmet_fc_free_assocs(tgtport);
+		nvmet_fc_tgtport_put(tgtport);
+	}
 
 	kfree(pe);
 }
@@ -2934,10 +2956,21 @@ static void
 nvmet_fc_discovery_chg(struct nvmet_port *port)
 {
 	struct nvmet_fc_port_entry *pe = port->priv;
-	struct nvmet_fc_tgtport *tgtport = pe->tgtport;
+	struct nvmet_fc_tgtport *tgtport = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
+	if (pe->tgtport && nvmet_fc_tgtport_get(pe->tgtport))
+		tgtport = pe->tgtport;
+	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
+	if (!tgtport)
+		return;
 
 	if (tgtport && tgtport->ops->discovery_event)
 		tgtport->ops->discovery_event(&tgtport->fc_target_port);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static ssize_t

-- 
2.48.1


