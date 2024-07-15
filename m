Return-Path: <linux-kernel+bounces-252941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF25931A37
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2368D280F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D76BFC0;
	Mon, 15 Jul 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jOo/G2O8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3314482EF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067661; cv=none; b=n7YyG0TXNrQSbKnB8d57gAPAW/U22PMPGed1LIcPONVEVp2jvwP5pM+ZZTp6pmaeLvAOZt3+wfa0OAD7zBEdsRuejKcaoFw1Stb66tpyfBkLnU+0qRIp1R3rnuTkSQ2CCwlpLeK1dgxUb+VTB+7JmXB1bU0Gtun9sGtmG5Sm63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067661; c=relaxed/simple;
	bh=WfQsMUPUxNqmyKbdc8guK35tYRdh9MATkdmcQik/CyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hFBvwbU4/UShGSponzDxSiBpVCYNVie/nk0KEcvTvPePP8H6CntcnQ07zYYBzJSMfx96exwGXTd2jl3/8682nwexAsHqWlQuP1SeK/WU92Ssuvw4L2MBGb7NHu/3VpHyx3Vjljj7Wpi4rNhm7gfl3swGDRwkiiPsQX4j4Lg3MDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jOo/G2O8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C2E7340E021B;
	Mon, 15 Jul 2024 18:20:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1Zn--4UE4qQR; Mon, 15 Jul 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721067651; bh=IDnhFbzitxBabwE8kf7KZ1P8Dv0BK91BJm0w98xykRI=;
	h=Date:From:To:Cc:Subject:From;
	b=jOo/G2O8CqjDOowyuT3zBalCe0usRurcGmx/moefr+v0hjXDM3Ttt7yaydQtFz+5q
	 nYX83nWKPjWXeq8HlLTT6m2wNxq3qJ1CzK8MA4mYfTkwhhKlrkS9MqZq4xmq0lyyFq
	 2K35Q0a+M8ZHgC6ROMV+L9OicOqtpKuDboUrgbWg8YJMSegt9ooMhYZ2jvgS55qQd3
	 l2q+Yq6vC+vT+sLM/AkheIRuFAF0icmE6PyC6kvud5MOpEbaonz4IzOOQmuOxKCeLS
	 oxtR6krUqyN+TSFLS6pKCPYOzfh1ymGibsAbEwt0NhkWLHWaBg7PqiI5euwcb3mZZo
	 +MULoYg8Vt1J1zPXJIoW9oZ1an9g6iBCPOV2Bh4LAK8l5mURgC/u96iGdrYLphLYrs
	 ufij7+xCh78+BXkzKx1H1b1Ih/i0wWBEp5qCwfWXiN47fkMrDJA/6gizmpTZM37rD4
	 ADTEKoijYA53Cf6dy3GFSypFtRUnQRs8GSN/7/OOI3WYHIYpClSQHolvS/DHdRHPVz
	 /OBq4IrMs3NU/w4RAPYautybdLqpon6Fn8uhg93+ZQ/zyBzg0aldMlTVsznNrCbc2S
	 RoXioJsGfgqZUPDR590tG0c3OZME4jGvIXfm+NoMVuGR73Y3zt8/3zjc5b5eMNon8J
	 tW13sujK3R9+AcoQVoosczYk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D32D40E019C;
	Mon, 15 Jul 2024 18:20:48 +0000 (UTC)
Date: Mon, 15 Jul 2024 20:20:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.11-rc1
Message-ID: <20240715182042.GAZpVoenFmK87PlcjT@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cpu lineup for v6.11-rc1.

If you encounter a merge conflict - likely - I've added the resolve we've been
using in linux-next at the end of that mail if you'd like to compare notes.

Thx.

---

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.11_rc1

for you to fetch changes up to 34b3fc558b537bdf99644dcde539e151716f6331:

  x86/cpu/intel: Drop stray FAM6 check with new Intel CPU model defines (2024-06-29 16:10:37 +0200)

----------------------------------------------------------------
- Flip the logic to add feature names to /proc/cpuinfo to having to
  explicitly specify the flag if there's a valid reason to show it in
  /proc/cpuinfo

- Switch a bunch of Intel x86 model checking code to the new CPU model
  defines

- Fixes and cleanups

----------------------------------------------------------------
Alison Schofield (2):
      x86/cpu: Remove useless work in detect_tme_early()
      x86/pconfig: Remove unused MKTME pconfig code

Andrew Cooper (1):
      x86/cpu/intel: Drop stray FAM6 check with new Intel CPU model defines

Borislav Petkov (AMD) (1):
      x86/cpufeatures: Flip the /proc/cpuinfo appearance logic

Jeff Johnson (1):
      x86/mce/inject: Add missing MODULE_DESCRIPTION() line

Mateusz Guzik (1):
      x86/CPU/AMD: Always inline amd_clear_divider()

Tony Luck (8):
      x86/platform/intel-mid: Switch to new Intel CPU model defines
      x86/cpu/intel: Switch to new Intel CPU model defines
      x86/PCI: Switch to new Intel CPU model defines
      x86/virt/tdx: Switch to new Intel CPU model defines
      perf/x86/intel: Switch to new Intel CPU model defines
      x86/cpu: Switch to new Intel CPU model defines
      x86/boot: Switch to new Intel CPU model defines
      perf/x86/rapl: Switch to new Intel CPU model defines

 arch/x86/boot/cpucheck.c                |   2 +-
 arch/x86/events/intel/core.c            | 212 ++++-----
 arch/x86/events/rapl.c                  |  90 ++--
 arch/x86/include/asm/cpu_device_id.h    |   8 +-
 arch/x86/include/asm/cpufeatures.h      | 800 ++++++++++++++++----------------
 arch/x86/include/asm/intel_pconfig.h    |  65 ---
 arch/x86/include/asm/processor.h        |  12 +-
 arch/x86/include/asm/vmxfeatures.h      | 110 ++---
 arch/x86/kernel/cpu/Makefile            |   2 +-
 arch/x86/kernel/cpu/amd.c               |  11 -
 arch/x86/kernel/cpu/intel.c             | 188 +++-----
 arch/x86/kernel/cpu/intel_pconfig.c     |  84 ----
 arch/x86/kernel/cpu/mce/inject.c        |   1 +
 arch/x86/kernel/cpu/mkcapflags.sh       |   3 +-
 arch/x86/pci/intel_mid_pci.c            |   4 +-
 arch/x86/platform/intel-mid/intel-mid.c |   6 +-
 arch/x86/virt/vmx/tdx/tdx.c             |   8 +-
 17 files changed, 701 insertions(+), 905 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_pconfig.h
 delete mode 100644 arch/x86/kernel/cpu/intel_pconfig.c

---

diff --cc arch/x86/include/asm/vmxfeatures.h
index 695f36664889,fe42067cd6d8..09b1d7e607c1
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@@ -70,24 -70,24 +70,24 @@@
  #define VMX_FEATURE_APIC_REGISTER_VIRT	( 2*32+  8) /* "vapic_reg" Hardware emulation of reads to the virtual-APIC */
  #define VMX_FEATURE_VIRT_INTR_DELIVERY	( 2*32+  9) /* "vid" Evaluation and delivery of pending virtual interrupts */
  #define VMX_FEATURE_PAUSE_LOOP_EXITING	( 2*32+ 10) /* "ple" Conditionally VM-Exit on PAUSE at CPL0 */
- #define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* "" VM-Exit on RDRAND*/
- #define VMX_FEATURE_INVPCID		( 2*32+ 12) /* "" Enable INVPCID in guest */
- #define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* "" Enable VM-Functions (leaf dependent) */
- #define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* VMREAD/VMWRITE in guest can access shadow VMCS */
- #define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* "" VM-Exit on ENCLS (leaf dependent) */
- #define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
+ #define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* VM-Exit on RDRAND*/
+ #define VMX_FEATURE_INVPCID		( 2*32+ 12) /* Enable INVPCID in guest */
+ #define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* Enable VM-Functions (leaf dependent) */
+ #define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* "shadow_vmcs" VMREAD/VMWRITE in guest can access shadow VMCS */
+ #define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* VM-Exit on ENCLS (leaf dependent) */
+ #define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* VM-Exit on RDSEED */
  #define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
--#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* Conditionally reflect EPT violations as #VE exceptions */
- #define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
- #define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
++#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "ept_violation_ve" Conditionally reflect EPT violations as #VE exceptions */
+ #define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* Suppress VMX indicators in Processor Trace */
+ #define VMX_FEATURE_XSAVES		( 2*32+ 20) /* Enable XSAVES and XRSTORS in guest */
  #define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
- #define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
- #define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
- #define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* Enable TPAUSE, UMONITOR, UMWAIT in guest */
- #define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
- #define VMX_FEATURE_BUS_LOCK_DETECTION	( 2*32+ 30) /* "" VM-Exit when bus lock caused */
- #define VMX_FEATURE_NOTIFY_VM_EXITING	( 2*32+ 31) /* VM-Exit when no event windows after notify window */
+ #define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* Processor Trace logs GPAs */
+ #define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* "tsc_scaling" Scale hardware TSC when read in guest */
+ #define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* "usr_wait_pause" Enable TPAUSE, UMONITOR, UMWAIT in guest */
+ #define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* VM-Exit on ENCLV (leaf dependent) */
+ #define VMX_FEATURE_BUS_LOCK_DETECTION	( 2*32+ 30) /* VM-Exit when bus lock caused */
+ #define VMX_FEATURE_NOTIFY_VM_EXITING	( 2*32+ 31) /* "notify_vm_exiting" VM-Exit when no event windows after notify window */
  
  /* Tertiary Processor-Based VM-Execution Controls, word 3 */
- #define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* Enable IPI virtualization */
+ #define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* "ipi_virt" Enable IPI virtualization */
  #endif /* _ASM_X86_VMXFEATURES_H */
diff --cc arch/x86/kernel/cpu/intel.c
index fdf3489d92a4,a9ea0dba6f0c..08b95a35b5cb
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@@ -230,61 -201,23 +201,39 @@@ static void detect_tme_early(struct cpu
  		clear_cpu_cap(c, X86_FEATURE_TME);
  		return;
  	}
- 
- 	if (mktme_status != MKTME_UNINITIALIZED)
- 		goto detect_keyid_bits;
- 
- 	pr_info("x86/tme: enabled by BIOS\n");
- 
- 	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
- 	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
- 		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
- 
- 	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
- 	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
- 		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
- 				tme_crypto_algs);
- 		mktme_status = MKTME_DISABLED;
- 	}
- detect_keyid_bits:
+ 	pr_info_once("x86/tme: enabled by BIOS\n");
  	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
- 	nr_keyids = (1UL << keyid_bits) - 1;
- 	if (nr_keyids) {
- 		pr_info_once("x86/mktme: enabled by BIOS\n");
- 		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
- 	} else {
- 		pr_info_once("x86/mktme: disabled by BIOS\n");
- 	}
- 
- 	if (mktme_status == MKTME_UNINITIALIZED) {
- 		/* MKTME is usable */
- 		mktme_status = MKTME_ENABLED;
- 	}
+ 	if (!keyid_bits)
+ 		return;
  
  	/*
- 	 * KeyID bits effectively lower the number of physical address
- 	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+ 	 * KeyID bits are set by BIOS and can be present regardless
+ 	 * of whether the kernel is using them. They effectively lower
+ 	 * the number of physical address bits.
+ 	 *
+ 	 * Update cpuinfo_x86::x86_phys_bits accordingly.
  	 */
  	c->x86_phys_bits -= keyid_bits;
+ 	pr_info_once("x86/mktme: BIOS enabled: x86_phys_bits reduced by %d\n",
+ 		     keyid_bits);
  }
  
 +void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 +{
 +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 +		return;
 +
 +	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
 +		return;
 +
 +	/*
 +	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
 +	 * enumeration. Unlock it and update the maximum leaf info.
 +	 */
 +	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0)
 +		c->cpuid_level = cpuid_eax(0);
 +}
 +
  static void early_init_intel(struct cpuinfo_x86 *c)
  {
  	u64 misc_enable;


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

