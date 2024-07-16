Return-Path: <linux-kernel+bounces-253589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C89932377
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAF1B228AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FD197A7D;
	Tue, 16 Jul 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cNp39yqw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410A25624
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123778; cv=none; b=ijO0BSlMfQeq/G8fz8yxN6s9IC2+qYMnSmwMzHVBRltE18RL6kRTTitPviKcX7NQ7FVGrPYdnlVHjTnL/v8wQFWVdDQAwv62ggUFv7geIapkcAk+yioG8XkSZZ4Hv09CU7SWFuLo/j9MiJLbkzziFDMfK1t2QZZiutD+PKzwDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123778; c=relaxed/simple;
	bh=GCT4d51R1N6ToRFotgASCsK+nt/EhZatWUO+z0hqHN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tB2HAtrmhbcveXnk8ZOccKlGmI8VbALHLl//zE6rgwf1TcGXpDEfClHnXhTS0Fvw/ASD7DPQkKefSrQVevt+fF2TDjJGehw3hfNOEZZN2+4M46c5XhUys+f8Qq419Q7gU6T+COnyZIKEt/tIdBLh/DHChoJ4pELUCcDu8Tc33b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cNp39yqw reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59A9340E01A8;
	Tue, 16 Jul 2024 09:56:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uUo9WHSGDPP9; Tue, 16 Jul 2024 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721123766; bh=+1ritM+rr5qoYoC/fcuaPOkpkREkie5KiCElYsbaFd8=;
	h=Date:From:To:Cc:Subject:From;
	b=cNp39yqwIOPiqcsX7JanTkdbfbY2zpNwneYhyHJO2FADVPYXUslcSHVY+OgvD1C8T
	 2+ZgS/ErClNLgE/HEg79aAZXfKiJ/9Zbndx5J1xTGoRjTY7L9aRadIBSIA/9ezSer6
	 La/iFg5y7umgViSHP/Qppo8g5JeS27pLGTxZOi3in89ciSpPyZLYKQX4bitn2doWZV
	 jcfXfc2Za5fFqAfE/al39T7hHRGmno6LgHhuZiF921pzhH9XZoH67WXCaekKntfiMs
	 L1FRUoQBAUeMgLLcQ8eUjrARz2fnWs4jsdviN//6Wd4GJ4gCZF6tvt75GvC7jnOYL1
	 LkBxxfZl8Zy9y8PKQn1qMujE6eXTrSMr31CZ3M6uUJxNnP2uhN/4ZA+ULN8DsjnPrx
	 hmqwww+BDjuOmoylBOlt74CRY0y99+fVvLtoUmyafHefYq/xLR8Y1cdf1NwL43EHNn
	 TChecl+prLcbmSTUKGd8J0J+wiN/N8t9XQzNTRQRr9vUgJOAJXU3OS5n9JpEacMfmJ
	 Wo5C9GO6t+VpFDfQaAMRWtMSeRzdqF/580A4Bbd7dU4MMhzo1whEJ63gyIaxKTqg5Q
	 gP03HN44KfMi8KStnks2fWPYi5+3KSpmufZivXxPwn3als+YdSN8n6So8pbN8Y2JKM
	 6yi5Hn+bCCe6u3nL/M+Dj8T4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2945340E01A2;
	Tue, 16 Jul 2024 09:56:03 +0000 (UTC)
Date: Tue, 16 Jul 2024 11:55:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.11-rc1
Message-ID: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the x86/sev lineup for v6.11-rc1.

There's a simple merge conflict with your current tree to which I'm addin=
g the
resolve at the end of this mail.

Thx.

---

The following changes since commit c3f38fa61af77b49866b006939479069cd4511=
73:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_=
v6.11_rc1

for you to fetch changes up to 5fa96c7ab3dc666c2904a35895635156c17a8f05:

  Documentation/ABI/configfs-tsm: Fix an unexpected indentation silly (20=
24-07-11 12:03:23 +0200)

----------------------------------------------------------------
 - Add support for running the kernel in a SEV-SNP guest, over a Secure
   VM Service Module (SVSM).

   When running over a SVSM, different services can run at different
   protection levels, apart from the guest OS but still within the
   secure SNP environment.  They can provide services to the guest, like
   a vTPM, for example.

   This series adds the required facilities to interface with such a SVSM
   module.

 - The usual fixlets, refactoring and cleanups

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      x86/sev: Move SEV compilation units
      Documentation/ABI/configfs-tsm: Fix an unexpected indentation silly

Tom Lendacky (14):
      x86/irqflags: Provide native versions of the local_irq_save()/resto=
re()
      x86/sev: Check for the presence of an SVSM in the SNP secrets page
      x86/sev: Use kernel provided SVSM Calling Areas
      x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0
      x86/sev: Use the SVSM to create a vCPU when not in VMPL0
      x86/sev: Provide SVSM discovery support
      x86/sev: Provide guest VMPL level to userspace
      virt: sev-guest: Choose the VMPCK key based on executing VMPL
      sev-guest: configfs-tsm: Allow the privlevel_floor attribute to be =
updated
      fs/configfs: Add a callback to determine attribute visibility
      x86/sev: Take advantage of configfs visibility support in TSM
      x86/sev: Extend the config-fs attestation support for an SVSM
      x86/sev: Allow non-VMPL0 execution when an SVSM is present
      x86/sev: Do RMP memory coverage check after max_pfn has been set

Uwe Kleine-K=C3=B6nig (1):
      virt: sev-guest: Mark driver struct with __refdata to prevent secti=
on mismatch

 Documentation/ABI/testing/configfs-tsm             |  63 +++
 Documentation/ABI/testing/sysfs-devices-system-cpu |  12 +
 Documentation/arch/x86/amd-memory-encryption.rst   |  29 +-
 Documentation/virt/coco/sev-guest.rst              |  11 +
 arch/x86/boot/compressed/sev.c                     |  86 +++-
 arch/x86/coco/Makefile                             |   1 +
 arch/x86/coco/sev/Makefile                         |  15 +
 arch/x86/{kernel/sev.c =3D> coco/sev/core.c}         | 449 +++++++++++++=
+++----
 .../x86/{kernel/sev-shared.c =3D> coco/sev/shared.c} | 460 +++++++++++++=
+++++++-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/irqflags.h                    |  20 +
 arch/x86/include/asm/msr-index.h                   |   2 +
 arch/x86/include/asm/sev-common.h                  |  18 +
 arch/x86/include/asm/sev.h                         | 135 +++++-
 arch/x86/include/uapi/asm/svm.h                    |   1 +
 arch/x86/kernel/Makefile                           |   6 -
 arch/x86/mm/mem_encrypt_amd.c                      |   8 +-
 arch/x86/virt/svm/sev.c                            |  44 +-
 drivers/virt/coco/sev-guest/sev-guest.c            | 211 +++++++++-
 drivers/virt/coco/tdx-guest/tdx-guest.c            |  26 +-
 drivers/virt/coco/tsm.c                            | 177 ++++++--
 fs/configfs/dir.c                                  |  10 +
 include/linux/configfs.h                           |   3 +
 include/linux/tsm.h                                |  59 ++-
 24 files changed, 1658 insertions(+), 189 deletions(-)
 create mode 100644 arch/x86/coco/sev/Makefile
 rename arch/x86/{kernel/sev.c =3D> coco/sev/core.c} (86%)
 rename arch/x86/{kernel/sev-shared.c =3D> coco/sev/shared.c} (72%)

---

commit a07757e6656bcadcc63e9c41d0c9ab9330773730 (refs/remotes/ps2/build-t=
est)
Merge: 10cf263b4d7a 5fa96c7ab3dc
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Tue Jul 16 11:43:26 2024 +0200

    Merge remote-tracking branch 'tip/x86/sev' into build-test
   =20
     Conflicts:
            arch/x86/include/asm/cpufeatures.h

diff --cc arch/x86/include/asm/cpufeatures.h
index a1dd81027c2d,1826f1f94111..6007462e03d6
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@@ -370,94 -370,95 +370,95 @@@
  #define X86_FEATURE_NRIPS		(15*32+ 3) /* "nrip_save" SVM next_rip save =
*/
  #define X86_FEATURE_TSCRATEMSR		(15*32+ 4) /* "tsc_scale" TSC scaling s=
upport */
  #define X86_FEATURE_VMCBCLEAN		(15*32+ 5) /* "vmcb_clean" VMCB clean bi=
ts support */
 -#define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* flush-by-ASID support */
 -#define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* Decode Assists support =
*/
 -#define X86_FEATURE_PAUSEFILTER		(15*32+10) /* filtered pause intercept=
 */
 -#define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* pause filter threshold *=
/
 -#define X86_FEATURE_AVIC		(15*32+13) /* Virtual Interrupt Controller */
 -#define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* Virtual VMSAVE VMLOAD=
 */
 -#define X86_FEATURE_VGIF		(15*32+16) /* Virtual GIF */
 -#define X86_FEATURE_X2AVIC		(15*32+18) /* Virtual x2apic */
 -#define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
 -#define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
 -#define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
 +#define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* "flushbyasid" Flush-by-A=
SID support */
 +#define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* "decodeassists" Decode =
Assists support */
 +#define X86_FEATURE_PAUSEFILTER		(15*32+10) /* "pausefilter" Filtered p=
ause intercept */
 +#define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* "pfthreshold" Pause filt=
er threshold */
 +#define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Contro=
ller */
 +#define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Vir=
tual VMSAVE VMLOAD */
 +#define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
 +#define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 +#define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SP=
EC_CTRL */
 +#define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 +#define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
 =20
  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 =
*/
 -#define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipul=
ation instructions*/
 -#define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protectio=
n */
 -#define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace *=
/
 -#define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 -#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instr=
uctions */
 -#define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector=
 Bit Manipulation Instructions */
 -#define X86_FEATURE_SHSTK		(16*32+ 7) /* "" Shadow stack */
 -#define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions *=
/
 -#define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 -#define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication=
 Double Quadword */
 -#define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network In=
structions */
 -#define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W=
] and VPSHUF-BITQMB instructions */
 -#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption *=
/
 -#define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors o=
f DW/QW */
 -#define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 -#define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 -#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 -#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 -#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 -#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 -#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructio=
ns */
 -#define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Lau=
nch Control */
 +#define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vecto=
r Bit Manipulation instructions*/
 +#define X86_FEATURE_UMIP		(16*32+ 2) /* "umip" User Mode Instruction Pr=
otection */
 +#define X86_FEATURE_PKU			(16*32+ 3) /* "pku" Protection Keys for Users=
pace */
 +#define X86_FEATURE_OSPKE		(16*32+ 4) /* "ospke" OS Protection Keys Ena=
ble */
 +#define X86_FEATURE_WAITPKG		(16*32+ 5) /* "waitpkg" UMONITOR/UMWAIT/TP=
AUSE Instructions */
 +#define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* "avx512_vbmi2" Additiona=
l AVX512 Vector Bit Manipulation Instructions */
 +#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow stack */
 +#define X86_FEATURE_GFNI		(16*32+ 8) /* "gfni" Galois Field New Instruc=
tions */
 +#define X86_FEATURE_VAES		(16*32+ 9) /* "vaes" Vector AES */
 +#define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* "vpclmulqdq" Carry-Less M=
ultiplication Double Quadword */
 +#define X86_FEATURE_AVX512_VNNI		(16*32+11) /* "avx512_vnni" Vector Neu=
ral Network Instructions */
 +#define X86_FEATURE_AVX512_BITALG	(16*32+12) /* "avx512_bitalg" Support=
 for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
 +#define X86_FEATURE_TME			(16*32+13) /* "tme" Intel Total Memory Encryp=
tion */
 +#define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* "avx512_vpopcntdq" P=
OPCNT for vectors of DW/QW */
 +#define X86_FEATURE_LA57		(16*32+16) /* "la57" 5-level page tables */
 +#define X86_FEATURE_RDPID		(16*32+22) /* "rdpid" RDPID instruction */
 +#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* "bus_lock_detect" Bus=
 Lock detect */
 +#define X86_FEATURE_CLDEMOTE		(16*32+25) /* "cldemote" CLDEMOTE instruc=
tion */
 +#define X86_FEATURE_MOVDIRI		(16*32+27) /* "movdiri" MOVDIRI instructio=
n */
 +#define X86_FEATURE_MOVDIR64B		(16*32+28) /* "movdir64b" MOVDIR64B inst=
ruction */
 +#define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS i=
nstructions */
 +#define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Exten=
sions Launch Control */
 =20
  /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 -#define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery =
support */
 -#define X86_FEATURE_SUCCOR		(17*32+ 1) /* Uncorrectable error containme=
nt and recovery */
 -#define X86_FEATURE_SMCA		(17*32+ 3) /* Scalable MCA */
 +#define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA o=
verflow recovery support */
 +#define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error =
containment and recovery */
 +#define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 =20
  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 =
*/
 -#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network =
Instructions */
 -#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumu=
lation Single precision */
 -#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
 -#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect=
 for D/Q */
 -#define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR a=
vailable */
 -#define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 -#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* "" RTM transaction a=
lways aborts */
 -#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 -#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 -#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of =
more than one type */
 -#define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tr=
acking */
 -#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 -#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 -#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
 -#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
 -#define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
 -#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
 -#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
 -#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IB=
RS + IBPB) */
 -#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirec=
t Branch Predictors */
 -#define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 -#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILIT=
IES MSR (Intel) */
 -#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABI=
LITIES MSR */
 -#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store B=
ypass Disable */
 +#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* "avx512_4vnniw" AVX-512=
 Neural Network Instructions */
 +#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* "avx512_4fmaps" AVX-512=
 Multiply Accumulation Single precision */
 +#define X86_FEATURE_FSRM		(18*32+ 4) /* "fsrm" Fast Short Rep Mov */
 +#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* "avx512_vp2inters=
ect" AVX-512 Intersect for D/Q */
 +#define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* SRBDS mitigation MSR avai=
lable */
 +#define X86_FEATURE_MD_CLEAR		(18*32+10) /* "md_clear" VERW clears CPU =
buffers */
 +#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* RTM transaction alwa=
ys aborts */
 +#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* TSX_FORCE_ABORT */
 +#define X86_FEATURE_SERIALIZE		(18*32+14) /* "serialize" SERIALIZE inst=
ruction */
 +#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* This part has CPUs of mor=
e than one type */
 +#define X86_FEATURE_TSXLDTRK		(18*32+16) /* "tsxldtrk" TSX Suspend Load=
 Address Tracking */
 +#define X86_FEATURE_PCONFIG		(18*32+18) /* "pconfig" Intel PCONFIG */
 +#define X86_FEATURE_ARCH_LBR		(18*32+19) /* "arch_lbr" Intel ARCH LBR *=
/
 +#define X86_FEATURE_IBT			(18*32+20) /* "ibt" Indirect Branch Tracking =
*/
 +#define X86_FEATURE_AMX_BF16		(18*32+22) /* "amx_bf16" AMX bf16 Support=
 */
 +#define X86_FEATURE_AVX512_FP16		(18*32+23) /* "avx512_fp16" AVX512 FP1=
6 */
 +#define X86_FEATURE_AMX_TILE		(18*32+24) /* "amx_tile" AMX tile Support=
 */
 +#define X86_FEATURE_AMX_INT8		(18*32+25) /* "amx_int8" AMX int8 Support=
 */
 +#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* Speculation Control (IBRS =
+ IBPB) */
 +#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* Single Thread Indirect B=
ranch Predictors */
 +#define X86_FEATURE_FLUSH_L1D		(18*32+28) /* "flush_l1d" Flush L1D cach=
e */
 +#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* "arch_capabilities"=
 IA32_ARCH_CAPABILITIES MSR (Intel) */
 +#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* IA32_CORE_CAPABILIT=
IES MSR */
 +#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* Speculative Store Bypa=
ss Disable */
 =20
  /* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX)=
, word 19 */
 -#define X86_FEATURE_SME			(19*32+ 0) /* AMD Secure Memory Encryption */
 -#define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualiza=
tion */
 -#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is=
 supported */
 -#define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtuali=
zation - Encrypted State */
 -#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtual=
ization - Secure Nested Paging */
 -#define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 -#define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced=
 cache coherency */
 -#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug sta=
te swap support */
 +#define X86_FEATURE_SME			(19*32+ 0) /* "sme" AMD Secure Memory Encrypt=
ion */
 +#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" AMD Secure Encrypted Virt=
ualization */
 +#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is su=
pported */
 +#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" AMD Secure Encrypted=
 Virtualization - Encrypted State */
 +#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" AMD Secure Encrypt=
ed Virtualization - Secure Nested Paging */
 +#define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 +#define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced ca=
che coherency */
 +#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES f=
ull debug state swap support */
+ #define X86_FEATURE_SVSM		(19*32+28) /* SVSM present */
 =20
  /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), wo=
rd 20 */
 -#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data B=
reakpoints */
 -#define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* "" WRMSR to {FS,GS,K=
ERNEL_GS}_BASE is non-serializing */
 -#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always seriali=
zing / synchronizes RDTSC */
 -#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Cl=
ears Base */
 -#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
 -#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* "" SMM_CTL MSR is not =
present */
 +#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Brea=
kpoints */
 +#define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERN=
EL_GS}_BASE is non-serializing */
 +#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializin=
g / synchronizes RDTSC */
 +#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clear=
s Base */
 +#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 +#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not pre=
sent */
 =20
 -#define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction =
Barrier */
 -#define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] fl=
ushes all branch type predictions */
 -#define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SR=
SO */
 +#define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Bar=
rier */
 +#define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flush=
es all branch type predictions */
 +#define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO =
*/
 =20
  /*
   * Extended auxiliary flags: Linux defined - for features scattered in =
various

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

