Return-Path: <linux-kernel+bounces-567577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53539A6880D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8014177E20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CED6254B06;
	Wed, 19 Mar 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukWU7WJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDE254B02
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376655; cv=none; b=dqH1E8mvkgnGsWa80KBXVB6JG25POsTJACeS3efBUYDN4+ZM79v2ycc7t0FY9pd3JGwuLpz8Jk6+4G3+NVZ6IT6n8tCqUOaROyhLqdJm8VUvNTQpv+YPrxGsvnoXXJG++s0L8VuR0f9kF/WFjUZamKsHSlsMwudkDpW0vaEtscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376655; c=relaxed/simple;
	bh=ebyMNCtTTrEqBq7KBj2Z4r0pT6iv1SjarksoD2qQGSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1HqK9GcjHEmPLwTi4MVe1e9s3mP2DPYZM8N28j1A8r7eqCbVkNqgYy/HwI6G9s2Zfgn8X20f1NQstI354pS+RirNNwdHcfXUjqBCqkrRHyFlZScwQVUljq0mnYBectSNSxHWKV7Xe1Xe304rskqrVOywE+Lb2qTjseYikGCrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukWU7WJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F86C4CEEE;
	Wed, 19 Mar 2025 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376653;
	bh=ebyMNCtTTrEqBq7KBj2Z4r0pT6iv1SjarksoD2qQGSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukWU7WJ0noFM/hOU78+UK7hEPIM1AsCNMUg3I/v7hReBhZdSO1fLoD9PHYB8baKxQ
	 MysnS6sBwxAfdluJ44xAGe+vEj8zwnk2yF4Nfgoh5YE4PUr9RPwMEVby+u1O05OGk9
	 UWaa16jJqDUSyd7HPakNbpXf7wXHqNrkPLXxkvZ/tSSYMP2XHRkEjIB/NuJa6eh7YF
	 UBeDFSaZSNar/8IG+SaXUPPl7SIjlfRxOVwLje/BpNgor7wCqy2AzNP3DH4YqWjxaR
	 1jMASTxSZwvlAEDcAwhBDRWZrYRNLTCNiZSpBbEfc0kJTzwbP+JG7wM/AQiyjNrAOc
	 if8CZNHQtxyVQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: [PATCH v2 05/57] irqdomain: cdx: Switch to of_fwnode_handle()
Date: Wed, 19 Mar 2025 10:28:58 +0100
Message-ID: <20250319092951.37667-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/cdx/cdx_msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
index 06d723978232..3388a5d1462c 100644
--- a/drivers/cdx/cdx_msi.c
+++ b/drivers/cdx/cdx_msi.c
@@ -165,7 +165,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 	struct device_node *parent_node;
 	struct irq_domain *parent;
 
-	fwnode_handle = of_node_to_fwnode(np);
+	fwnode_handle = of_fwnode_handle(np);
 
 	parent_node = of_parse_phandle(np, "msi-map", 1);
 	if (!parent_node) {
@@ -173,7 +173,7 @@ struct irq_domain *cdx_msi_domain_init(struct device *dev)
 		return NULL;
 	}
 
-	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node), DOMAIN_BUS_NEXUS);
+	parent = irq_find_matching_fwnode(of_fwnode_handle(parent_node), DOMAIN_BUS_NEXUS);
 	if (!parent || !msi_get_domain_info(parent)) {
 		dev_err(dev, "unable to locate ITS domain\n");
 		return NULL;
-- 
2.49.0


