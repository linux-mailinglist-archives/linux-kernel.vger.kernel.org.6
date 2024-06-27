Return-Path: <linux-kernel+bounces-232667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123791AC93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A487D1F21502
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133219939E;
	Thu, 27 Jun 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecNPB9Re"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AA1990DD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505510; cv=none; b=dFv0tUf46f8p5hlBfjg0q5Lv6RcWUQHEJ8qHmQAwVs9veR+t+ND/eFu3J2etw8gp+VtVps7dY9+PwDWrGPbVAvmmx8Ge4QpIGjVnGTMOfAkC7o4YdoNVoUsuDIKzRMhbauhGkIxMWaF3co1c8HJj0n0spSTaQfiKvYAt+0t5HoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505510; c=relaxed/simple;
	bh=b8FGF7FHgiFJgUaljXVANw3hN+FmW1giegzK/EmH7FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgTKoj8XmqtjGY2qyDc4OoZAavu0KesTIPbWHV2u38NBRN8LbHRJfoQIK+eadkGxElERSadTJkklz3XroX9SM7w5khdwmkv8KcwZgPO/VYds1sXxN2YOpcFvmk5HtptQILo++04tkm1YhwbkSUmf2fyycY3RZfPtUbfNVfLHf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecNPB9Re; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719505507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cFCXHxIWumrFyXD+AI2y3OkZOM6rpiSLbLUEprzBZ1I=;
	b=ecNPB9ReKPufLqpqdebPzrPtiyXZ9XQYa4U/VFE/kx9dduwwUWj1bOJPUy5AAT81Sy07Lw
	YYY3Tv+A7Z7a4eJc2HCluBIcsqX2Jz2FX86EyKrXB60MPv4/196r2vAi2Zhs+PdGlPD5ox
	yl4QCJxlxDoT3cpPYThGjYPRFluaAfY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-r3J2wzq0O9eA2O6CGT3m3Q-1; Thu,
 27 Jun 2024 12:25:04 -0400
X-MC-Unique: r3J2wzq0O9eA2O6CGT3m3Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6629D19560B5;
	Thu, 27 Jun 2024 16:25:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF0941955BD4;
	Thu, 27 Jun 2024 16:25:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Remove IA-64 from kernel-parameters
Date: Thu, 27 Jun 2024 18:24:58 +0200
Message-ID: <20240627162458.387700-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

IA-64 has been removed from the tree, so we should also remove
the corresponding kernel-parameters documentation now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Patch is based on linux-next branch (which already contains
       some other patches to kernel-parameters.txt)

 .../admin-guide/kernel-parameters.rst         |  1 -
 .../admin-guide/kernel-parameters.txt         | 45 ++-----------------
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index e8bdf5e86a9b..fdea7c26ef80 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -118,7 +118,6 @@ is applicable::
 	HIBERNATION HIBERNATION is enabled.
 	HW	Appropriate hardware is enabled.
 	HYPER_V HYPERV support is enabled.
-	IA-64	IA-64 architecture is enabled.
 	IMA     Integrity measurement architecture is enabled.
 	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	IPV6	IPv6 support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 86f8f1f464ff..a2d36b622a67 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1738,8 +1738,6 @@
 			for 64-bit NUMA, off otherwise.
 			Format: 0 | 1 (for off | on)
 
-	hcl=		[IA-64] SGI's Hardware Graph compatibility layer
-
 	hd=		[EIDE] (E)IDE hard drive subsystem geometry
 			Format: <cyl>,<head>,<sect>
 
@@ -2498,7 +2496,7 @@
 
 	keepinitrd	[HW,ARM] See retain_initrd.
 
-	kernelcore=	[KNL,X86,IA-64,PPC,EARLY]
+	kernelcore=	[KNL,X86,PPC,EARLY]
 			Format: nn[KMGTPE] | nn% | "mirror"
 			This parameter specifies the amount of memory usable by
 			the kernel for non-movable allocations.  The requested
@@ -3162,17 +3160,10 @@
 			[SECURITY] Choose order of LSM initialization. This
 			overrides CONFIG_LSM, and the "security=" parameter.
 
-	machvec=	[IA-64] Force the use of a particular machine-vector
-			(machvec) in a generic kernel.
-			Example: machvec=hpzx1
-
 	machtype=	[Loongson] Share the same kernel image file between
 			different yeeloong laptops.
 			Example: machtype=lemote-yeeloong-2f-7inch
 
-	max_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory greater
-			than or equal to this physical address is ignored.
-
 	maxcpus=	[SMP,EARLY] Maximum number of processors that an SMP kernel
 			will bring up during bootup.  maxcpus=n : n >= 0 limits
 			the kernel to bring up 'n' processors. Surely after
@@ -3410,9 +3401,6 @@
 			Enable or disable the microcode minimal revision
 			enforcement for the runtime microcode loader.
 
-	min_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory below this
-			physical address is ignored.
-
 	mini2440=	[ARM,HW,KNL]
 			Format:[0..2][b][c][t]
 			Default: "0tb"
@@ -3577,7 +3565,7 @@
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
-	movablecore=	[KNL,X86,IA-64,PPC,EARLY]
+	movablecore=	[KNL,X86,PPC,EARLY]
 			Format: nn[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
@@ -3851,8 +3839,6 @@
 
 	no_entry_flush  [PPC,EARLY] Don't flush the L1-D cache when entering the kernel.
 
-	noexec		[IA-64]
-
 	noexec32	[X86-64]
 			This affects only 32-bit executables.
 			noexec32=on: enable non-executable mappings (default)
@@ -3872,13 +3858,6 @@
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
-	nohalt		[IA-64] Tells the kernel not to use the power saving
-			function PAL_HALT_LIGHT when idle. This increases
-			power-consumption. On the positive side, it reduces
-			interrupt wake-up latency, which may improve performance
-			in certain environments such as networked servers or
-			real-time systems.
-
 	no_hash_pointers
 			[KNL,EARLY]
 			Force pointers printed to the console or buffers to be
@@ -3933,8 +3912,6 @@
 			remapping.
 			[Deprecated - use intremap=off]
 
-	nointroute	[IA-64]
-
 	noinvpcid	[X86,EARLY] Disable the INVPCID cpu feature.
 
 	noiotrap	[SH] Disables trapped I/O port accesses.
@@ -3944,8 +3921,6 @@
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
-	nojitter	[IA-64] Disables jitter checking for ITC timers.
-
 	nokaslr		[KNL,EARLY]
 			When CONFIG_RANDOMIZE_BASE is set, this disables
 			kernel and module base offset ASLR (Address Space
@@ -3960,8 +3935,6 @@
 
 	nolapic_timer	[X86-32,APIC,EARLY] Do not use the local APIC timer.
 
-	nomca		[IA-64] Disable machine check abort handling
-
 	nomce		[X86-32] Disable Machine Check Exception
 
 	nomfgpt		[X86-32] Disable Multi-Function General Purpose
@@ -4013,8 +3986,6 @@
 	noresume	[SWSUSP] Disables resume and restores original swap
 			space.
 
-	nosbagart	[IA-64]
-
 	no-scroll	[VGA] Disables scrollback.
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
@@ -4115,10 +4086,6 @@
 			parameter, xsave area per process might occupy more
 			memory on xsaves enabled systems.
 
-	nptcg=		[IA-64] Override max number of concurrent global TLB
-			purges which is reported from either PAL_VM_SUMMARY or
-			SAL PALO.
-
 	nr_cpus=	[SMP,EARLY] Maximum number of processors that an SMP kernel
 			could support.  nr_cpus=n : n >= 1 limits the kernel to
 			support 'n' processors. It could be larger than the
@@ -6042,9 +6009,6 @@
 			apic=verbose is specified.
 			Example: apic=debug show_lapic=all
 
-	simeth=		[IA-64]
-	simscsi=
-
 	slab_debug[=options[,slabs][;[options[,slabs]]...]	[MM]
 			Enabling slab_debug allows one to determine the
 			culprit if slab objects become corrupted. Enabling
@@ -6561,7 +6525,7 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,S390,EARLY]
+	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
 			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
@@ -7209,9 +7173,6 @@
 			Try vdso32=0 if you encounter an error that says:
 			dl_main: Assertion `(void *) ph->p_vaddr == _rtld_local._dl_sysinfo_dso' failed!
 
-	vector=		[IA-64,SMP]
-			vector=percpu: enable percpu vector domain
-
 	video=		[FB,EARLY] Frame buffer configuration
 			See Documentation/fb/modedb.rst.
 
-- 
2.45.2


