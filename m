Return-Path: <linux-kernel+bounces-309714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559E966F93
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469531C21C56
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660616BE01;
	Sat, 31 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADpS0UUS"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E941531EA;
	Sat, 31 Aug 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083845; cv=none; b=DbcN3Vaatrs2xkkbVa2mIZUjdgqdr52l5yhDUYXK7WfzXDAC2uryncvkRNCVdxuxKug88JxULuleD0fZB+c6a0gjrKZp7cr28Glz1MNQqP/4gk8Vu8UNFHZobISB1OfwqHLbdmWWAYFMKOqyUH7AXluC8yWX7RjsEdurCaFqhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083845; c=relaxed/simple;
	bh=AiAs+f0DOwqb3mqumMEKWPoSTet5sVEF8qBpc+MVTOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKI73o6NoDKsoBOb5XLc5SiXtmNvIqL79y5IUdyaYK3vD2jUZysp8fNRG5Ejpd1auovyZ41YozYEw27myf6qwu7air9VbNbMhOuoI5yoN1FYTB8q7SmOeVHGsjVStzk/FyF7YEOdS42KQCo1LgyV3e4YXwe5aQ1JCnEiwzMHFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADpS0UUS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1881773a12.2;
        Fri, 30 Aug 2024 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083843; x=1725688643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wrsQB/6kr7Ma/wyHDMG36Gt57JsM43DlFH99Cporu0=;
        b=ADpS0UUS/80IIHYvyejBfiQ3mJMbZxSAt4PUttIzLitNugLB9EMu7TzoZcxuTdyY7A
         t71MXWWvobRhEYETaFE8MiIduwihef87Mlfk4ZbWN345aHnPX8E3zR9ekEnpEHgFBbCX
         dD1JuPvtA3CqtNgFnVZD1aieipQv6hjCu3+IbWWYPzNWpHVl9B4R+rVzbcX6KwuY33wW
         ELUKc2pROGZwsWAm6xALqfJ6SoD5aS1PuKP8sljh62gSkWUqLe8j1CtKY6YGA3WNWv+G
         sKuggGA7vx+MYGA4xXGLT6xgigM7NBZr4/ijXuuNXQGZbAToQYUWu670v9R/W39BdvXj
         YYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083843; x=1725688643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wrsQB/6kr7Ma/wyHDMG36Gt57JsM43DlFH99Cporu0=;
        b=HwXG5YAkdQ4WLnPaTEYqpNSfzSRL38pshzqI38qBW0RXYlK3+onCTp7a9uh43tbTTy
         ItapBht9yuBPntZkOVTRpyiI8tgMxJmRLgUlJ+4Tenom6mvuV43qG92hZWH0vd7CN50Y
         xWNQGn5Z6KZKoDFnSVnKlbnwCXQHm82Qa5Twwfxl9/lQxyFkyn08oYf3p4jWPFMXNW5k
         AcTTWuw3ZkIqt0hICyspPF/u4Ya+yDBj2MioLEczIGsxZbfIKd6wyo9PRAbJ17ptAbOH
         6RXoQDNoKbGD23VxJeFvQS4AkaCval7IcRW1u+4IpdFXbQoh+hpwRPX3iJE4w6EvA82M
         RRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNCuw58SRRS1VUcBF5dwaq4APT1DHnnbBF6kkh9FaLIMROFo/gV+GIyjVXttGHLPA2x70yPmy7Ms4@vger.kernel.org, AJvYcCWn40xMlac48wqkcBfteu89xaOKclZW13C/1ABZNPo9WLM3p/b1OqnZiiLlKbw9qGvxrFP1fxExUy81Rsic@vger.kernel.org
X-Gm-Message-State: AOJu0YzWetHcmtwvWw+bG0Jv0E/qTn1yKs+IGilFQ+ZSofXL3MR+yTIT
	49SwYZxSIUjLGfJvSiARPyFmdUmPcJ7JyeBSny19Pw0RZ/enYPaU
X-Google-Smtp-Source: AGHT+IHdDgp5kIe/Uz9eKdMkNiesjGU6gPSz8C0iguDZ2YnuDqyASfy0yI9S6X6wUtplLyyhUB+OQg==
X-Received: by 2002:a05:6a20:e68c:b0:1c4:8291:e94e with SMTP id adf61e73a8af0-1cece047a11mr2504621637.45.1725083843358;
        Fri, 30 Aug 2024 22:57:23 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2053aa8cb4asm12027045ad.271.2024.08.30.22.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:57:23 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@somainline.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 3/4] irqchip/apple-aic: Add a new "Global fast IPIs only" feature level
Date: Sat, 31 Aug 2024 13:48:18 +0800
Message-ID: <20240831055605.3542-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831055605.3542-1-towinchenmi@gmail.com>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with the A11 (T8015) SoC, Apple began using arm64 sysregs for
fast IPIs. However, on A11, there is no such things as "Local" fast IPIs,
as the SYS_IMP_APL_IPI_RR_LOCAL_EL1 register does not seem to exist.

Add a new feature level, used by the compatible "apple,t8015-aic",
controlled by a static branch key named use_local_fast_ipi. When
use_fast_ipi is true and use_local_fast_ipi is false, fast IPIs are used
but all IPIs goes through the register SYS_IMP_APL_IPI_RR_GLOBAL_EL1, as
"global" IPIs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 8d81d5fb3c50..01a3c79054f5 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -235,6 +235,8 @@ enum fiq_hwirq {
 };
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+/* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs (M1+) */
+static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
 
 struct aic_info {
 	int version;
@@ -252,6 +254,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool local_fast_ipi;
 };
 
 static const struct aic_info aic1_info __initconst = {
@@ -270,17 +273,32 @@ static const struct aic_info aic1_fipi_info __initconst = {
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic1_local_fipi_info __initconst = {
+	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+
+	.fast_ipi	= true,
+	.local_fast_ipi = true,
+};
+
 static const struct aic_info aic2_info __initconst = {
 	.version	= 2,
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
 	.fast_ipi	= true,
+	.local_fast_ipi = true,
 };
 
 static const struct of_device_id aic_info_match[] = {
 	{
 		.compatible = "apple,t8103-aic",
+		.data = &aic1_local_fipi_info,
+	},
+	{
+		.compatible = "apple,t8015-aic",
 		.data = &aic1_fipi_info,
 	},
 	{
@@ -750,7 +768,8 @@ static void aic_ipi_send_fast(int cpu)
 	u64 cluster = MPIDR_CLUSTER(mpidr);
 	u64 idx = MPIDR_CPU(mpidr);
 
-	if (MPIDR_CLUSTER(my_mpidr) == cluster)
+	if (static_branch_likely(&use_local_fast_ipi) &&
+	    MPIDR_CLUSTER(my_mpidr) == cluster)
 		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
 			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
 	else
@@ -990,6 +1009,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
+	if (!irqc->info.local_fast_ipi)
+		static_branch_disable(&use_local_fast_ipi);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
-- 
2.46.0


