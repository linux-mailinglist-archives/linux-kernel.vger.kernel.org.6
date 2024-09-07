Return-Path: <linux-kernel+bounces-319715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98814970140
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD5E1C21950
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D914BF97;
	Sat,  7 Sep 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="qwIEGGD0"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212F2D627
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699729; cv=none; b=IypO2y79qoQVQ16LlXZyoMOUvpslSuSayn29yN/uH1T43/vPeRjqjkXk6sklQQHej4JJQ2G5tBkgtKLdKhkh2vM85uEBUOGySJkIa8KX8i0H6FRez0UoyN8mQGnpWB6AN6dRAjWd5uGitIvBRzs5Mcv/vlRwGbUzUNMPuiskkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699729; c=relaxed/simple;
	bh=pGVn7h+WnqxXGOjypEJFAeCgjHJ45inuW4GHNk+acbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYjRYIZdONFQp2R6Kj1l4UPbQ9ml27Q4v45dv0lhsb56mvwUPFKXvNTDFTzgXjiESGGfa6EjQE+oUGb2lqrk/CpJDVdxJgwhhRERJl//gb2x82LHmSXECHFGBj8g/BcsxYK99Nuq0/hGwLpMLhovonk0RJ9W4Zw3+7TtaRpmAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=qwIEGGD0; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4X16Y54Jr0z9vPy;
	Sat,  7 Sep 2024 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1725699721; bh=pGVn7h+WnqxXGOjypEJFAeCgjHJ45inuW4GHNk+acbM=;
	h=From:To:Cc:Subject:Date:From;
	b=qwIEGGD0CDK17HQuUkn+a8/64DhlUkL0jbyb8DEwzininS99hu6xDAy0lMcJYb2SN
	 l/+G1sHAHEWRQYvmMK75PbDlQiHs3XCrDa7Vtdx2tNR4ynULXM6gtKOqmMJer+YWpf
	 XAwgwx4AwgbA0GTk/DTUBTmKw1G6ZmRZI9ABkPi0=
X-Riseup-User-ID: 97836F88E2623D772C04D7916FE9D739BA59FCCB928BA66A063BBBE0CBA62D76
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4X16Y41vBfzFtJG;
	Sat,  7 Sep 2024 09:02:00 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	x86@kernel.org,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH] x86/cpu/topology: remove limit of CPUs due to noapic on x86_64
Date: Sat,  7 Sep 2024 11:01:38 +0200
Message-ID: <20240907090142.2938-1-ffmancera@riseup.net>
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
2.46.0


