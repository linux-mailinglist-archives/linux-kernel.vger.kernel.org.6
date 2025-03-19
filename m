Return-Path: <linux-kernel+bounces-567573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E348A68801
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D33BDDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610CF253F14;
	Wed, 19 Mar 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSOdQhrg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC0253F08
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376641; cv=none; b=Xcg2+Cmwc1z/T0tY4x568A+o1awe2lS+4gxtWc+xH2st7+olGt8/TTQlkNJVAMYmYzB+kQ2Gob5UvtgnfkCsZ3DSOrQOzT8KdThR02+71WRx+U9pdrNS2gr3f4KJHQuRDpbxc7jzKDAUDPHiYvbjVliIXsV6varH5lo1vRZ5zH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376641; c=relaxed/simple;
	bh=NNs8SEwDfc9wDIxk1Dn/+q1ci77lX4vcEi1aTxU5XiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anCptidVRZqi/9KB/X0Iqfngxl+7kldzBQK/eOyt8Bte19h71UM6WV7A7MT8E83ofqUQGUP8kFre5obe0JOO/LjQ4TTm55rl45f8cMouxAB9jS4nDLBMOM4kObpnXSAHDk2pwhYQtfkhSNuxsPnSCKTrYcuBeVelGBT1HWv+YvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSOdQhrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FFC116C6;
	Wed, 19 Mar 2025 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376640;
	bh=NNs8SEwDfc9wDIxk1Dn/+q1ci77lX4vcEi1aTxU5XiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSOdQhrgk5hmkbWksclyMaCrFyjiMd812BBwfN6ygHz7ED8jGGeyMaZTbtLXe5n8O
	 KEvcYqkwKDn39WFsQTWmkyuFLVtijGqcDK+K/6TlZECVAyq5V+YhZbMpXvrpY6iiJF
	 pG3WX0U8wTJjrq2yEiPbM788lCU2S+X8n08DhxZIeMHaChZ5gIW8ZMt5qiujKnP0y4
	 xa/bhcUCI4F4gFJ6U/m7OPpqDLAJ+xEzAzyjhOKcfhxYuUvbZNNXsqEbUy61tgQv1B
	 NP5KiW2AMmsIu7itr9LOqIvX9Dw66V8asl5OKb3KPJjzJ9WlmzkIhV0ZUP14s96rMo
	 eHpBMcf4K7FkA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v2 01/57] irqdomain: um: use irq_domain_create_linear() helper
Date: Wed, 19 Mar 2025 10:28:54 +0100
Message-ID: <20250319092951.37667-2-jirislaby@kernel.org>
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

um_pci_init() open-codes what the irq_domain_create_linear() helper
does already. Use the helper instead of open-coding it.

This needs retval checking modification.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

[v2]
This is new in v2.
---
 arch/um/drivers/virt-pci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index dd5580f975cc..efe8b474c07b 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -1000,11 +1000,6 @@ static struct resource virt_platform_resource = {
 
 static int __init um_pci_init(void)
 {
-	struct irq_domain_info inner_domain_info = {
-		.size		= MAX_MSI_VECTORS,
-		.hwirq_max	= MAX_MSI_VECTORS,
-		.ops		= &um_pci_inner_domain_ops,
-	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1030,10 +1025,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	inner_domain_info.fwnode = um_pci_fwnode;
-	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
-	if (IS_ERR(um_pci_inner_domain)) {
-		err = PTR_ERR(um_pci_inner_domain);
+	um_pci_inner_domain = irq_domain_create_linear(um_pci_fwnode, MAX_MSI_VECTORS,
+						       &um_pci_inner_domain_ops, NULL);
+	if (!um_pci_inner_domain) {
+		err = -ENOMEM;
 		goto free;
 	}
 
@@ -1070,7 +1065,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
+	if (um_pci_inner_domain)
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-- 
2.49.0


