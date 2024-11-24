Return-Path: <linux-kernel+bounces-420202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD09D77C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2628B3176D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB167346D;
	Sun, 24 Nov 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="oTOWb0yL"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941136F307
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470349; cv=none; b=fq8n4x+EFJRpqbaJrCH2f5VB1xXp/U5QYrpixvJv+ebhjXiN+p2ESoAEcHk5BbmdT9elPAVTIg/Ddew+yfy7NDouarX+5bKy0/qBURqI7iWJKKijznPiI1RmonoLJmWCSssqsrFeeHaejIRbBH9Oy67abezc2HNfBizSNeeGhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470349; c=relaxed/simple;
	bh=EjTKw52XEP5sDYgOb2I3+VAHq2/8LE6N9diKnI/zHnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4cT6lytQ4UwfJ6q7Vvr9SMTkTJ+aYOIMDY11Acu6mwnQxt6HBuF8MEdAUx2jFI/B8EHTybWUeYzqaWkNFZMoYAa9Hk7X2k/DTFkxXq0hPvA0GCfWcD0dYkDVrzyc/VmFDvyVdzPmENBYz/BeIPmmlbzW4Z6US+bp7U73NDVeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=oTOWb0yL; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XxGTG328NzDqh4;
	Sun, 24 Nov 2024 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1732470341; bh=EjTKw52XEP5sDYgOb2I3+VAHq2/8LE6N9diKnI/zHnA=;
	h=From:To:Cc:Subject:Date:From;
	b=oTOWb0yLvr9PEyqaXfG0i3isZjjM7yeVZ9x8O2QDWGHVBDccdBo84AMeKUV4buqXW
	 +36x8DpsVw3ieWYn6gHPOihcuFRHVXgU6/sdzM4g0YY2qTsNr65mczk/oFpolhig7D
	 z6DNjbBQ0Iaeox994kTNJBpfZKZ+4dE5pyviDBGw=
X-Riseup-User-ID: A59CE217345DDF0B2EE92A352F7C9AB5DEDF285CB89B9ED4039D291B389A1692
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XxGTD6yLKzJsBP;
	Sun, 24 Nov 2024 17:45:36 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	x86@kernel.org,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH RESEND] x86/cpu/topology: remove limit of CPUs due to noapic on x86_64
Date: Sun, 24 Nov 2024 18:45:07 +0100
Message-ID: <20241124174510.2561-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86_64 the command line parameter "noapic" should not limit the
number of possible CPUs, as it only limits the use of IRQ sharing or
device IRQ remapping. Only on x86_32 the command line parameter
"nolapic" limits the number of possible CPUs to one. This restores the
behavior previous to the rework of possible CPU management.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
RESEND: original patch https://lkml.org/lkml/2024/9/7/160
---
 arch/x86/kernel/cpu/topology.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..5f10a010e35a 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,10 +428,16 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
-	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+	/* 'maxcpus=0' 'nosmp' */
+	if (!setup_max_cpus)
 		possible = 1;
 
+#if defined(CONFIG_X86_32)
+	/* 'nolapic' 'disableapic' 'noapic' */
+	if (apic_is_disabled || ioapic_is_disabled)
+		possible = 1;
+#endif
+
 	/* 'possible_cpus=N' */
 	possible = min_t(unsigned int, max_possible_cpus, possible);
 
@@ -443,8 +449,14 @@ void __init topology_apply_cmdline_limits_early(void)
 
 static __init bool restrict_to_up(void)
 {
-	if (!smp_found_config || ioapic_is_disabled)
+	if (!smp_found_config)
 		return true;
+
+#if defined(CONFIG_X86_32)
+	if (ioapic_is_disabled)
+		return true;
+#endif
+
 	/*
 	 * XEN PV is special as it does not advertise the local APIC
 	 * properly, but provides a fake topology for it so that the
-- 
2.46.2


