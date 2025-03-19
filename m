Return-Path: <linux-kernel+bounces-567608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E0A68845
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407C219C2E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDB25522C;
	Wed, 19 Mar 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrrsW7XH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF15255227
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376752; cv=none; b=XZEUucuP62DA51vL7hdejdU9ZgQR73tz+2OKNtDDlXb0v8olGETNK5UOSfB46SKJXOIGEJ3ZHuAlqbJG1rlXgxaPpfPTq0fkor83PBNuTc/4RA1jXAtdYSTja0JEGlUU2QNvpT3uRgeFf3c+7rvi2KjoEdSzC+B9+nDRrQNyw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376752; c=relaxed/simple;
	bh=K7NuaEoslCT+xOnJpz2GrUFAcs2CA1ZosMMX7h4U2qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og/iMh0CsTezyc5uWfECajnBhVbdEiMHp5JfxCLnW4ZyUA2EXsQyX2kJ2CLx5lBiSjWBZ4TJ/euWcFG3+yEHGZ5oOGWOITsCmagSRauvjssyH2MU/BqTjpczowZlYZFIftR+agDoBoiq8nu6+PlYB7zqvaLT4TFo3/VqMBFzjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrrsW7XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5069C4CEEE;
	Wed, 19 Mar 2025 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376751;
	bh=K7NuaEoslCT+xOnJpz2GrUFAcs2CA1ZosMMX7h4U2qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrrsW7XHKgr5I6lDrIyZQUl9Rtj9F68dKgpD8ZaCEpXPTtK5qrzubwTWrDou3ytNp
	 IvDuhq45yWVFlN79y0fBWHgx+A2yyk1Y9H9E9iwqvyP4ASfXR6YAIVEth6R8qvjI1R
	 bpo4Fr3oM//UsDlEXhBmJPSaFmIeKAbD/5fNbObPltRNaFi2d4bnl0OidjdVudkjod
	 eDVIABtaZxE2EqINq3a5cPALDveC1Nkw3PyFb8D74QsVhFwnOWkv5W+KNfSC0RUY9p
	 M35ZqGf/lnHksNPr1hkWYhdg9dqhjPkCu+8r2DHvo7NAaVH9y1tt4+bZ8nu/H53nWw
	 7VtxsfQPitAfg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Anatolij Gustschin <agust@denx.de>,
	Scott Wood <oss@buserror.net>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 32/57] irqdomain: ppc: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:25 +0100
Message-ID: <20250319092951.37667-33-jirislaby@kernel.org>
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

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/44x/uic.c                 | 5 +++--
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   | 3 ++-
 arch/powerpc/platforms/52xx/media5200.c          | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        | 4 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        | 2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  | 2 +-
 arch/powerpc/platforms/8xx/cpm1-ic.c             | 3 ++-
 arch/powerpc/platforms/8xx/pic.c                 | 3 ++-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 5 +++--
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 5 +++--
 arch/powerpc/platforms/powermac/pic.c            | 5 +++--
 arch/powerpc/platforms/powernv/opal-irqchip.c    | 3 ++-
 arch/powerpc/sysdev/cpm2_pic.c                   | 3 ++-
 arch/powerpc/sysdev/ehv_pic.c                    | 5 +++--
 arch/powerpc/sysdev/fsl_msi.c                    | 2 +-
 arch/powerpc/sysdev/ge/ge_pic.c                  | 5 +++--
 arch/powerpc/sysdev/i8259.c                      | 4 ++--
 arch/powerpc/sysdev/ipic.c                       | 5 +++--
 arch/powerpc/sysdev/mpic.c                       | 6 +++---
 arch/powerpc/sysdev/tsi108_pci.c                 | 4 ++--
 arch/powerpc/sysdev/xive/common.c                | 2 +-
 21 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/44x/uic.c b/arch/powerpc/platforms/44x/uic.c
index 31f760c2ec5d..481ec25ce78f 100644
--- a/arch/powerpc/platforms/44x/uic.c
+++ b/arch/powerpc/platforms/44x/uic.c
@@ -254,8 +254,9 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	}
 	uic->dcrbase = *dcrreg;
 
-	uic->irqhost = irq_domain_add_linear(node, NR_UIC_INTS, &uic_host_ops,
-					     uic);
+	uic->irqhost = irq_domain_create_linear(of_fwnode_handle(node),
+						NR_UIC_INTS, &uic_host_ops,
+						uic);
 	if (! uic->irqhost)
 		return NULL; /* FIXME: panic? */
 
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index e995eb30bf09..2cf3c6237337 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -188,7 +188,8 @@ mpc5121_ads_cpld_pic_init(void)
 
 	cpld_pic_node = of_node_get(np);
 
-	cpld_pic_host = irq_domain_add_linear(np, 16, &cpld_pic_host_ops, NULL);
+	cpld_pic_host = irq_domain_create_linear(of_fwnode_handle(np), 16,
+						 &cpld_pic_host_ops, NULL);
 	if (!cpld_pic_host) {
 		printk(KERN_ERR "CPLD PIC: failed to allocate irq host!\n");
 		goto end;
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 19626cd42406..bc7f83cfec1d 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -168,7 +168,7 @@ static void __init media5200_init_irq(void)
 
 	spin_lock_init(&media5200_irq.lock);
 
-	media5200_irq.irqhost = irq_domain_add_linear(fpga_np,
+	media5200_irq.irqhost = irq_domain_create_linear(of_fwnode_handle(fpga_np),
 			MEDIA5200_NUM_IRQS, &media5200_irq_ops, &media5200_irq);
 	if (!media5200_irq.irqhost)
 		goto out;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 1ea591ec6083..f042b21b2b73 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -247,9 +247,9 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 	if (!cascade_virq)
 		return;
 
-	gpt->irqhost = irq_domain_add_linear(node, 1, &mpc52xx_gpt_irq_ops, gpt);
+	gpt->irqhost = irq_domain_create_linear(of_fwnode_handle(node), 1, &mpc52xx_gpt_irq_ops, gpt);
 	if (!gpt->irqhost) {
-		dev_err(gpt->dev, "irq_domain_add_linear() failed\n");
+		dev_err(gpt->dev, "irq_domain_create_linear() failed\n");
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 43c881d31ca6..7ec56d3788a9 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -446,7 +446,7 @@ void __init mpc52xx_init_irq(void)
 	 * As last step, add an irq host to translate the real
 	 * hw irq information provided by the ofw to linux virq
 	 */
-	mpc52xx_irqhost = irq_domain_add_linear(picnode,
+	mpc52xx_irqhost = irq_domain_create_linear(of_fwnode_handle(picnode),
 	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
 	                                 &mpc52xx_irqhost_ops, NULL);
 
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 60e0b8947ce6..b4f6360830b1 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -278,7 +278,7 @@ void __init socrates_fpga_pic_init(struct device_node *pic)
 	int i;
 
 	/* Setup an irq_domain structure */
-	socrates_fpga_pic_irq_host = irq_domain_add_linear(pic,
+	socrates_fpga_pic_irq_host = irq_domain_create_linear(of_fwnode_handle(pic),
 		    SOCRATES_FPGA_NUM_IRQS, &socrates_fpga_pic_host_ops, NULL);
 	if (socrates_fpga_pic_irq_host == NULL) {
 		pr_err("FPGA PIC: Unable to allocate host\n");
diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index a18fc7c99f83..1549f6cd29f4 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -110,7 +110,8 @@ static int cpm_pic_probe(struct platform_device *pdev)
 
 	out_be32(&data->reg->cpic_cimr, 0);
 
-	data->host = irq_domain_add_linear(dev->of_node, 64, &cpm_pic_host_ops, data);
+	data->host = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
+					      64, &cpm_pic_host_ops, data);
 	if (!data->host)
 		return -ENODEV;
 
diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index ea6b0e523c60..7639f28172be 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -146,7 +146,8 @@ void __init mpc8xx_pic_init(void)
 	if (!siu_reg)
 		goto out;
 
-	mpc8xx_pic_host = irq_domain_add_linear(np, 64, &mpc8xx_pic_host_ops, NULL);
+	mpc8xx_pic_host = irq_domain_create_linear(of_fwnode_handle(np), 64,
+						   &mpc8xx_pic_host_ops, NULL);
 	if (!mpc8xx_pic_host)
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 013d66304c31..a41649bf0cb8 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -149,8 +149,9 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 
 	__flipper_quiesce(io_base);
 
-	irq_domain = irq_domain_add_linear(np, FLIPPER_NR_IRQS,
-				  &flipper_irq_domain_ops, io_base);
+	irq_domain = irq_domain_create_linear(of_fwnode_handle(np),
+					      FLIPPER_NR_IRQS,
+					      &flipper_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
 		return NULL;
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 4d2d92de30af..9abb3da36ba5 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -175,8 +175,9 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
 
 	__hlwd_quiesce(io_base);
 
-	irq_domain = irq_domain_add_linear(np, HLWD_NR_IRQS,
-					   &hlwd_irq_domain_ops, io_base);
+	irq_domain = irq_domain_create_linear(of_fwnode_handle(np),
+					      HLWD_NR_IRQS,
+					      &hlwd_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
 		iounmap(io_base);
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 03a7c51f2645..2eddc8bff7ab 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -327,8 +327,9 @@ static void __init pmac_pic_probe_oldstyle(void)
 	/*
 	 * Allocate an irq host
 	 */
-	pmac_pic_host = irq_domain_add_linear(master, max_irqs,
-					      &pmac_pic_host_ops, NULL);
+	pmac_pic_host = irq_domain_create_linear(of_fwnode_handle(master),
+						 max_irqs,
+						 &pmac_pic_host_ops, NULL);
 	BUG_ON(pmac_pic_host == NULL);
 	irq_set_default_domain(pmac_pic_host);
 
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index d92759c21fae..e180bd8e1400 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -191,7 +191,8 @@ int __init opal_event_init(void)
 	 * fall back to the legacy method (opal_event_request(...))
 	 * anyway. */
 	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
-	opal_event_irqchip.domain = irq_domain_add_linear(dn, MAX_NUM_EVENTS,
+	opal_event_irqchip.domain = irq_domain_create_linear(of_fwnode_handle(dn),
+				MAX_NUM_EVENTS,
 				&opal_event_domain_ops, &opal_event_irqchip);
 	of_node_put(dn);
 	if (!opal_event_irqchip.domain) {
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index e14493685fe8..c63d72f17a3e 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -259,7 +259,8 @@ void cpm2_pic_init(struct device_node *node)
 	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
 
 	/* create a legacy host */
-	cpm2_pic_host = irq_domain_add_linear(node, 64, &cpm2_pic_host_ops, NULL);
+	cpm2_pic_host = irq_domain_create_linear(of_fwnode_handle(node), 64,
+						 &cpm2_pic_host_ops, NULL);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index fb502b72fca1..4ee8d36ca647 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -269,8 +269,9 @@ void __init ehv_pic_init(void)
 		return;
 	}
 
-	ehv_pic->irqhost = irq_domain_add_linear(np, NR_EHV_PIC_INTS,
-						 &ehv_pic_host_ops, ehv_pic);
+	ehv_pic->irqhost = irq_domain_create_linear(of_fwnode_handle(np),
+						    NR_EHV_PIC_INTS,
+						    &ehv_pic_host_ops, ehv_pic);
 	if (!ehv_pic->irqhost) {
 		of_node_put(np);
 		kfree(ehv_pic);
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 7b9a5ea9cad9..4fe8a7b1b288 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -412,7 +412,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	}
 	platform_set_drvdata(dev, msi);
 
-	msi->irqhost = irq_domain_add_linear(dev->dev.of_node,
+	msi->irqhost = irq_domain_create_linear(of_fwnode_handle(dev->dev.of_node),
 				      NR_MSI_IRQS_MAX, &fsl_msi_host_ops, msi);
 
 	if (msi->irqhost == NULL) {
diff --git a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
index a6c424680c37..5b1f8dc3c960 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -214,8 +214,9 @@ void __init gef_pic_init(struct device_node *np)
 	}
 
 	/* Setup an irq_domain structure */
-	gef_pic_irq_host = irq_domain_add_linear(np, GEF_PIC_NUM_IRQS,
-					  &gef_pic_host_ops, NULL);
+	gef_pic_irq_host = irq_domain_create_linear(of_fwnode_handle(np),
+						    GEF_PIC_NUM_IRQS,
+						    &gef_pic_host_ops, NULL);
 	if (gef_pic_irq_host == NULL)
 		return;
 
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 06e391485da7..99bb2b916949 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -260,8 +260,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	i8259_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
-					   &i8259_host_ops, NULL);
+	i8259_host = irq_domain_create_legacy(of_fwnode_handle(node), NR_IRQS_LEGACY, 0, 0,
+					      &i8259_host_ops, NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index a35be0232978..f7b415ebb71c 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -711,8 +711,9 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	if (ipic == NULL)
 		return NULL;
 
-	ipic->irqhost = irq_domain_add_linear(node, NR_IPIC_INTS,
-					      &ipic_host_ops, ipic);
+	ipic->irqhost = irq_domain_create_linear(of_fwnode_handle(node),
+						 NR_IPIC_INTS,
+						 &ipic_host_ops, ipic);
 	if (ipic->irqhost == NULL) {
 		kfree(ipic);
 		return NULL;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 4afbab83a2e2..3de090159a1b 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1483,9 +1483,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
-	mpic->irqhost = irq_domain_add_linear(mpic->node,
-				       intvec_top,
-				       &mpic_host_ops, mpic);
+	mpic->irqhost = irq_domain_create_linear(of_fwnode_handle(mpic->node),
+						 intvec_top,
+						 &mpic_host_ops, mpic);
 
 	/*
 	 * FIXME: The code leaks the MPIC object and mappings here; this
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 0e42f7bad7db..07d0f6a83879 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -404,8 +404,8 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
-					     &pci_irq_domain_ops, NULL);
+	pci_irq_host = irq_domain_create_legacy(of_fwnode_handle(node), NR_IRQS_LEGACY, 0, 0,
+						&pci_irq_domain_ops, NULL);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq domain!\n");
 		return;
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dc2e61837396..f10592405024 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1464,7 +1464,7 @@ static const struct irq_domain_ops xive_irq_domain_ops = {
 
 static void __init xive_init_host(struct device_node *np)
 {
-	xive_irq_domain = irq_domain_add_tree(np, &xive_irq_domain_ops, NULL);
+	xive_irq_domain = irq_domain_create_tree(of_fwnode_handle(np), &xive_irq_domain_ops, NULL);
 	if (WARN_ON(xive_irq_domain == NULL))
 		return;
 	irq_set_default_domain(xive_irq_domain);
-- 
2.49.0


