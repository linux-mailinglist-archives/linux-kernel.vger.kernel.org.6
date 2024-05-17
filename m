Return-Path: <linux-kernel+bounces-182216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E358C8833
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292B81F25194
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B208479;
	Fri, 17 May 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k2S8LvW7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfrQyv5r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1231DFC7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956841; cv=none; b=QxiDjuR4fe9JFfV6GYsyN2wIUWTxy/swSzcChdb9/uE38BijDH4Lrhu0OOgILthBzS9Y20WCr58AllBznD5Bv2lxpfAQI1NhZqjVoGtZLsK0ZBis+WeatLi6DZ6hiG7BlKyKWCR5eguJnVKT5B/GUNIO+yMJVeuFosUyPOrJGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956841; c=relaxed/simple;
	bh=Xjocpe6o+LPVbYekQlUHM7EpcP5a1fvLjeuj7wvDWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzozzbcdZKq/ijzJgSkyGzl267BzAicK0tUO5v4/jJUjMtGK3NkuXZByudn5cbo932PuFdB5S+7jrDw5/ZFq3saafjasu1LNRwP6FsKklA14gTceSqnu4BAcw+FVJfHgOpnmFVT1Lz27tZa3rI8VFo6GdggEE3Qpx0T0E4BU4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k2S8LvW7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfrQyv5r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715956837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8m1vjhmUrX+z6fB8LXwOmch1tlT7U66cdTNDRltqcbU=;
	b=k2S8LvW7NzCu07k72HJZSDMpyXFt9aws7OUpvdyuQA+udWYPdIP8nd4wnfbTyoJVVdk7ja
	uzR50rVKpSlYbQRBC60dMdVwICSvO5BQZQJwsJxNyh+E8JcUfpzKFDiY0qypcDH6C+y635
	y131t21KMtHAN39w3pdlAcjqXa6DjrbelnPMKkp8Z/GAEENT4vTRXTeNugunqGGbLJZwKr
	QfiwTqm27nqXC8Nc0WKldQl+Pk5XkkKboGXkwzuEYOBSkpyD8NU3o0IgXZvK3+6dKIfPhf
	ZExrQG6W4+EVoguV0NLL0ZrdsFdZZak/Hr/p/k/HWJ9B/0K9Rx6NKT9KCubeLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715956837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8m1vjhmUrX+z6fB8LXwOmch1tlT7U66cdTNDRltqcbU=;
	b=jfrQyv5rTcaKrgIlsjj0P+1shzep48aWkPmZcUxYnxrJWVGhhHOTLcgwusZ3sK+V9QCAss
	rY0JxGEJg2EbhqAw==
To: Carsten Tolkmit <ctolkmit@ennit.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: x86/topology: Handle bogus ACPI tables correctly
Date: Fri, 17 May 2024 16:40:36 +0200
Message-ID: <87le48jycb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The ACPI specification clearly states how the processors should be
enumerated in the MADT:

 "To ensure that the boot processor is supported post initialization,
  two guidelines should be followed. The first is that OSPM should
  initialize processors in the order that they appear in the MADT. The
  second is that platform firmware should list the boot processor as the
  first processor entry in the MADT.
  ...
  Failure of OSPM implementations and platform firmware to abide by
  these guidelines can result in both unpredictable and non optimal
  platform operation."

The kernel relies on that ordering to detect the real BSP on crash kernels
which is important to avoid sending a INIT IPI to it as that would cause a
full machine reset.

On a Dell XPS 16 9640 the BIOS ignores this rule and enumerates the CPUs in
the wrong order. As a consequence the kernel falsely detects a crash kernel
and disables the corresponding CPU.

Prevent this by checking the IA32_APICBASE MSR for the BSP bit on the boot
CPU. If that bit is set, then the MADT based BSP detection can be safely
ignored. If the kernel detects a mismatch between the BSP bit and the first
enumerated MADT entry then emit a firmware bug message.

This obviously also has to be taken into account when the boot APIC ID and
the first enumerated APIC ID match. If the boot CPU does not have the BSP
bit set in the APICBASE MSR then there is no way for the boot CPU to
determine which of the CPUs is the real BSP. Sending an INIT to the real
BSP would reset the machine so the only sane way to deal with that is to
limit the number of CPUs to one and emit a corresponding warning message.

Fixes: 5c5682b9f87a ("x86/cpu: Detect real BSP on crash kernels")
Reported-by: Carsten Tolkmit <ctolkmit@ennit.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218837
---

This is a slightly different solution than the initial patch I provided in
the bugzilla. Carsten, can you please test that again?
---
 arch/x86/kernel/cpu/topology.c |   43 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -128,6 +128,9 @@ static void topo_set_cpuids(unsigned int
 
 static __init bool check_for_real_bsp(u32 apic_id)
 {
+	bool is_bsp = false, has_apic_base = boot_cpu_data.x86 >= 6;
+	u64 msr;
+
 	/*
 	 * There is no real good way to detect whether this a kdump()
 	 * kernel, but except on the Voyager SMP monstrosity which is not
@@ -144,17 +147,51 @@ static __init bool check_for_real_bsp(u3
 	if (topo_info.real_bsp_apic_id != BAD_APICID)
 		return false;
 
+	/*
+	 * Check whether the enumeration order is broken by evaluating the
+	 * BSP bit in the APICBASE MSR. If the CPU does not have the
+	 * APICBASE MSR then the BSP detection is not possible and the
+	 * kernel must rely on the firmware enumeration order.
+	 */
+	if (has_apic_base) {
+		rdmsrl(MSR_IA32_APICBASE, msr);
+		is_bsp = !!(msr & MSR_IA32_APICBASE_BSP);
+	}
+
 	if (apic_id == topo_info.boot_cpu_apic_id) {
-		topo_info.real_bsp_apic_id = apic_id;
-		return false;
+		if (is_bsp || !has_apic_base) {
+			topo_info.real_bsp_apic_id = apic_id;
+			return false;
+		}
+		/*
+		 * If the boot APIC is enumerated first, but the APICBASE
+		 * MSR does not have the BSP bit set, then there is no way
+		 * to discover the real BSP here. Assume a crash kernel and
+		 * limit the number of CPUs to 1 as an INIT to the real BSP
+		 * would reset the machine.
+		 */
+		pr_warn("Enumerated BSP APIC %x is not marked in APICBASE MSR\n", apic_id);
+		pr_warn("Assuming crash kernel. Limiting to one CPU to prevent machine INIT\n");
+		set_nr_cpu_ids(1);
+		goto fwbug;
 	}
 
-	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x > %x\n",
+	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x != %x\n",
 		topo_info.boot_cpu_apic_id, apic_id);
+
+	if (is_bsp && has_apic_base) {
+		topo_info.real_bsp_apic_id = topo_info.boot_cpu_apic_id;
+		goto fwbug;
+	}
+
 	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\n");
 
 	topo_info.real_bsp_apic_id = apic_id;
 	return true;
+
+fwbug:
+	pr_warn(FW_BUG "APIC enumeration order not specification compliant\n");
+	return false;
 }
 
 static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,

