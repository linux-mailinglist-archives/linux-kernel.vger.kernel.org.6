Return-Path: <linux-kernel+bounces-427793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB49E05AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4690328E593
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A52208996;
	Mon,  2 Dec 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="L/RIxXhi"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE0204F9B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151204; cv=none; b=tDxsSDbVE5TtMBmK7ixvyndzOtPR+AjvLXsAvPk0YMMX7wAj+XcWZBSdwJk89I5s2ah+qBrDLHGKFTFTn7Z4m3KQFmg9xMg6LTOjNgObZXrKgSyEHkEeemG/n14oaCGXM8iy3+Ey/pA05skRrtTx05msCuNnMvyKSPmjiQB2/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151204; c=relaxed/simple;
	bh=jXQjIU1H3A9YIpgYmGkC0szjgftkkNkV8mxkIgvczQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwPjNdOwiTLy+fVgwAwdXlBcfeq1dCrSjoolI5kcbb0Ez9Tqd6pnSqS3czIWNlHwI3VtwXpVm/SQM3j9gSN7dv5patv7gp3ZeY2P4SeSghUrcVNK/CZGe60IdfMxb2116ulOtmZM3xXiGU072cU7GOOYAJFyKmSjwjeoP52+sfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=L/RIxXhi; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Y26Gh25lZz9s6v;
	Mon,  2 Dec 2024 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1733151196; bh=jXQjIU1H3A9YIpgYmGkC0szjgftkkNkV8mxkIgvczQA=;
	h=From:To:Cc:Subject:Date:From;
	b=L/RIxXhifLC2dnobmefkZYY44RekxXiGY9ZR/qE+21a3kxetjoEl0HFBJ25R61SK8
	 gW2OqWzsvcZbZm35hwIt6X+nveYfAElnGmgT6ABpW/DmOfbh7GyeXoyRORLV77kUXA
	 mqmERVKUDLewqYtQTLTwrLGY9q3rXojiir862P9E=
X-Riseup-User-ID: CDF788113BB231E3723F47D744AD551ADC7B626B659682C1C71785E4A78254B9
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Y26Gf2N5TzFtSF;
	Mon,  2 Dec 2024 14:53:14 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	x86@kernel.org,
	Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH v2] x86/cpu/topology: remove limit of CPUs due to noapic on x86
Date: Mon,  2 Dec 2024 14:52:34 +0000
Message-ID: <20241202145243.1228-1-ffmancera@riseup.net>
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
 arch/x86/kernel/cpu/topology.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..b21f28f6a8a8 100644
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
@@ -443,8 +443,9 @@ void __init topology_apply_cmdline_limits_early(void)
 
 static __init bool restrict_to_up(void)
 {
-	if (!smp_found_config || ioapic_is_disabled)
+	if (!smp_found_config)
 		return true;
+
 	/*
 	 * XEN PV is special as it does not advertise the local APIC
 	 * properly, but provides a fake topology for it so that the
-- 
2.47.1


