Return-Path: <linux-kernel+bounces-416087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE009D4090
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B81EB2D517
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5183153BF8;
	Wed, 20 Nov 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCgbt368"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61E14F9F3;
	Wed, 20 Nov 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120240; cv=none; b=GPbLQscRgE8KkWAWXtLM+ClZYm5ECailiBZTst0XrNJNgmMtnxsfZ1M/0lKFI+h8KGHND/OYuydM7OeXBiYVpz9XnJn0aGp/8/wWzF/QdO2pgXZoFq1JLQeqVAa+P1C3qifergu94a9yEgJAtiGOtINyqA8cupp4pU/Hvd92Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120240; c=relaxed/simple;
	bh=T7PybO749Z0HQXamO36BFc8tXpmMHexp/EK155PI1C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsgQTdRWjJ0VMQFGZO8f+C1efEBuXSOELoDMMlWfkXuUStLiuI7pNoDnx9Op3CVKbmTAmZh3ZTPNoztrjmc6el8oFuJKBMnQHXKe8njlEAQbIbTm2QYzYKXiXhXVM6T8WWybFRJCHDFaTN6i60vkUvjTzwyAWajU38E2UmsjikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCgbt368; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76272C4CECE;
	Wed, 20 Nov 2024 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732120239;
	bh=T7PybO749Z0HQXamO36BFc8tXpmMHexp/EK155PI1C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCgbt368A+f7AB4+yktg1PO02DIPBZA+pusid2yTBd6Fva+Nc2+AUCjgMkIS6jzX4
	 mPb5Q7vOPr/xH0OEjIKmoUSI29sjmThgSI9Khp/gPE8f78TEx+YbYghLdwN52Cx4bN
	 MFcX1MdHrasoC6LZGnWlwmJNTfJuCAyvnKCeNnjUR5KjcEOI8yjANQTHZt5Vko2kkC
	 q+KMOdfedC1xD89D6hAyRswGTLetGnOhhFj/fRpcjcwk8AkmvdkblOMnPXTcUMlYzU
	 oenzE6AFJwoiTXM/3Rr5xf5IJrpnzbSlZhxWVy8Ex/e/9VIcbHpBgadniAwXptweTX
	 bZxDLXAvnXPPg==
From: Borislav Petkov <bp@kernel.org>
To: linux-doc@vger.kernel.org
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 2/2] x86/apic: Remove "disablelapic" cmdline option
Date: Wed, 20 Nov 2024 17:30:33 +0100
Message-ID: <20241120163033.12829-2-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120163033.12829-1-bp@kernel.org>
References: <20241120163033.12829-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The convention is "no<something>" and there already is "nolapic". Drop
the disable one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/apic/apic.c    | 9 +--------
 arch/x86/kernel/cpu/topology.c | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c5fb28e6451a..1267b2691abc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2582,19 +2582,12 @@ int apic_is_clustered_box(void)
 /*
  * APIC command line parameters
  */
-static int __init setup_disableapic(char *arg)
+static int __init setup_nolapic(char *arg)
 {
 	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 	return 0;
 }
-early_param("disableapic", setup_disableapic);
-
-/* same as disableapic, for compatibility */
-static int __init setup_nolapic(char *arg)
-{
-	return setup_disableapic(arg);
-}
 early_param("nolapic", setup_nolapic);
 
 static int __init parse_lapic_timer_c2_ok(char *arg)
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..6ebed852a9ef 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,7 +428,7 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'noapic' */
 	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
 		possible = 1;
 
-- 
2.43.0


