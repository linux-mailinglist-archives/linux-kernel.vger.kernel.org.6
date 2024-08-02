Return-Path: <linux-kernel+bounces-272836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB19461B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC5DB220DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFB1A34C1;
	Fri,  2 Aug 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6sFIyKb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yDcRcizV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B226166F03
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615348; cv=none; b=udC4jZYK0/beZNglDGNpih0QASh1lZjgx0MoqqsR8wOd5HIkoafvB7QobEEKWoBnPJIUpOqhB4AH1vc2VVjTzwONCQcuOpvBM7GurqhcPZmvD9HULtBzKbXfW1oKrISnJC0U/WqsPj4SP+iRNPKZZH18ggY0kTpbkIH3SKpx9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615348; c=relaxed/simple;
	bh=joGtQ+2N69Ik6xvxIoZy2SV0eRi8wasUBBpnChs/kok=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hWpZS6Bv0Q5FQB13/nOWcqVtIva1O2RFPwmHY2xMFFNustVjHIKvq4B+T76oVzU+mVAU0QmXnTXlhexNANC/hEjshiZ0RG3jQPrj6BuU//0TxlW66XahOSCiDuSSc9QBNxe2wK98uHzyYFkxeung9wBL8A0LB3z5Ym0cHe4JMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6sFIyKb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yDcRcizV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.779537108@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2ttF1MAUDY4YRNHsjpOQQVG3OtWwhiDniK/3/J3rcqM=;
	b=Y6sFIyKbWefT0fA1xukJ1KPLFso7xKxl09qyqAYhT8Ms1GDnnfiwGWAZZlTg9WGag9uKuz
	Fh9jofTDcDGBIFA6A6xe5v6CwkJx9Sx3NbArIoKpMYrb3PArSNwAf96W/EZFlCiCQanM+5
	PgJz0HySsCGQnlgkfBatpHku7M3DgWmi6LK34/BuqyD1NcNYDmUGZLE1dOlsPOwdQesBAL
	5vlXsotMQeX9M6YuoyrIWRRl/EDPbqF5Q3fDStkWWJzZyM3vCMobFJOm5R4rgb5TE2cgpi
	oTOCAr/z4HcFjRDWtpN2ZBAlb+LGO8fzJ/8NRgYpnJPAgEtoLEtPNOuVL/rAFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2ttF1MAUDY4YRNHsjpOQQVG3OtWwhiDniK/3/J3rcqM=;
	b=yDcRcizV/WxLOvQ/Dda5Dk/uLCarRdqgUES5f5XVmCAgi5LagdmUUS9I0g6W5fKR6RpZDb
	p3Ogaffzr3wmFJCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 09/15] x86/mpparse: Cleanup apic_printk()s
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:44 +0200 (CEST)

Use the new apic_pr_verbose() helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/mpparse.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -68,7 +68,7 @@ static void __init mpc_oem_bus_info(stru
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
-	apic_printk(APIC_VERBOSE, "Bus #%d is %s\n", m->busid, str);
+	apic_pr_verbose("Bus #%d is %s\n", m->busid, str);
 }
 
 static void __init MP_bus_info(struct mpc_bus *m)
@@ -417,7 +417,7 @@ static unsigned long __init get_mpc_size
 	mpc = early_memremap(physptr, PAGE_SIZE);
 	size = mpc->length;
 	early_memunmap(mpc, PAGE_SIZE);
-	apic_printk(APIC_VERBOSE, "  mpc: %lx-%lx\n", physptr, physptr + size);
+	apic_pr_verbose("  mpc: %lx-%lx\n", physptr, physptr + size);
 
 	return size;
 }
@@ -560,7 +560,7 @@ static int __init smp_scan_config(unsign
 	struct mpf_intel *mpf;
 	int ret = 0;
 
-	apic_printk(APIC_VERBOSE, "Scan for SMP in [mem %#010lx-%#010lx]\n",
+	apic_pr_verbose("Scan for SMP in [mem %#010lx-%#010lx]\n",
 		    base, base + length - 1);
 	BUILD_BUG_ON(sizeof(*mpf) != 16);
 
@@ -683,13 +683,13 @@ static void __init check_irq_src(struct
 {
 	int i;
 
-	apic_printk(APIC_VERBOSE, "OLD ");
+	apic_pr_verbose("OLD ");
 	print_mp_irq_info(m);
 
 	i = get_MP_intsrc_index(m);
 	if (i > 0) {
 		memcpy(m, &mp_irqs[i], sizeof(*m));
-		apic_printk(APIC_VERBOSE, "NEW ");
+		apic_pr_verbose("NEW ");
 		print_mp_irq_info(&mp_irqs[i]);
 		return;
 	}
@@ -772,7 +772,7 @@ static int  __init replace_intsrc_all(st
 			continue;
 
 		if (nr_m_spare > 0) {
-			apic_printk(APIC_VERBOSE, "*NEW* found\n");
+			apic_pr_verbose("*NEW* found\n");
 			nr_m_spare--;
 			memcpy(m_spare[nr_m_spare], &mp_irqs[i], sizeof(mp_irqs[i]));
 			m_spare[nr_m_spare] = NULL;


