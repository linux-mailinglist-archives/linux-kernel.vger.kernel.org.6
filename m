Return-Path: <linux-kernel+bounces-427804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAE9E070F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AEF1734C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935252040BB;
	Mon,  2 Dec 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="iYDiYCcB"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8D204F63
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151566; cv=none; b=IaNhKGCRRZQ5Ue98aJl5dDSWfLXN7dO0zT3DGKt7zRjjq/m068ja1/NJ4yRZrTqDmGWCDi/janPquXVVD0zXc1XdWhl2ifzVhREiPlIf0CQFC/nvdZzKFNDQHLACsykhMgnKqeP7jS0YWouz3dacFaG98qpeQtebD7+tT3tzFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151566; c=relaxed/simple;
	bh=eMU0r/c+7AEPd71uuU9TeJoT24P6UgAQj4u1HF22eAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhGfMNik78K/xylYTothlgOkcYV9rPUrMgnoLfy2hgJVfpqrUa6xtwyOURMZfbgJxzsMvVIFbpGjQrZcgukAhbSIH/h8phO0+SEFWt/6RhKwxzttrrBohQ+bGp88ULoTHUryY0Q3JYTzteVPokvSPagNPUEqUFXr5g2mGCvko64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=iYDiYCcB; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Y26Pf00jFzDqBG;
	Mon,  2 Dec 2024 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1733151558; bh=eMU0r/c+7AEPd71uuU9TeJoT24P6UgAQj4u1HF22eAM=;
	h=From:To:Cc:Subject:Date:From;
	b=iYDiYCcBiR3T8h8XtTUGxS/cU3mcbUWUrWFStxFeoaIfOw9OZi9A+5TdnACfcZO+w
	 3tsIk4akK2xDrqLWFOmLpB/Hgtqs3T4+oryGQ6WGQHX2Dk1OxlU4RaLaCOKK1gILls
	 ebZnbp18BQqfCILSkswnfyCtr35DLvRgGVnmaxag=
X-Riseup-User-ID: C708F88ED7D4EF4B8DD1D07AAA1D35F85937C8C16F79F349541768C6829E9E4B
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Y26Pc03H0zJn5n;
	Mon,  2 Dec 2024 14:59:15 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	x86@kernel.org,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH v3] x86/cpu/topology: remove limit of CPUs due to noapic on x86
Date: Mon,  2 Dec 2024 14:58:45 +0000
Message-ID: <20241202145905.1482-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86 the command line parameter "noapic" should not limit the number
of possible CPUs, as it only limits the use of IRQ sharing or device IRQ
remapping. This restores the behavior previous to the rework of possible
CPUs management.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
v3: remove a unnecessary new line
---
 arch/x86/kernel/cpu/topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..b2e313ea17bf 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -428,8 +428,8 @@ void __init topology_apply_cmdline_limits_early(void)
 {
 	unsigned int possible = nr_cpu_ids;
 
-	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
-	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+	/* 'maxcpus=0' 'nosmp' 'nolapic' 'disableapic' */
+	if (!setup_max_cpus || apic_is_disabled)
 		possible = 1;
 
 	/* 'possible_cpus=N' */
@@ -443,7 +443,7 @@ void __init topology_apply_cmdline_limits_early(void)
 
 static __init bool restrict_to_up(void)
 {
-	if (!smp_found_config || ioapic_is_disabled)
+	if (!smp_found_config)
 		return true;
 	/*
 	 * XEN PV is special as it does not advertise the local APIC
-- 
2.47.1


