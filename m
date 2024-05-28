Return-Path: <linux-kernel+bounces-192944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF618D24AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6224128BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6CF17554C;
	Tue, 28 May 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR4cC4OT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E4174EE4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924677; cv=none; b=ANGyucaWaBotgLrpWhH4LYAVoHSQFXdLkd9TCToU5HjQymxYAPKdQ9Njbvb2/ebDp2wiYy1mh2mtpsmAdACqS9wx1N2I5gYExPUCI17x6Sjjq48eUd2gc/uh2b1O/c2ZtP6UNaTDv0Gznn3zWrq323HvCg6zNA3PNctd1oQvWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924677; c=relaxed/simple;
	bh=Q/SKZhYssyNzbFU7Ep/1zhoqA/l8WmeLyFzvgcCE9aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GExk5ik6M6sefor0d76NSdFT5y/8CzACrD1NMgGi/R8wl58iVGfc9MlMGxWYEWixcjdvcxubEd+ajYn0htIai1rW6izZaap1L8XZb+Fo6dLnRwrj81DpBejH/Yz/9a2dykVDBZJmNKpmuzrfXqyWzW7vPbPr302qf36wxrRi3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR4cC4OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A66C32781;
	Tue, 28 May 2024 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716924677;
	bh=Q/SKZhYssyNzbFU7Ep/1zhoqA/l8WmeLyFzvgcCE9aI=;
	h=Date:From:To:Cc:Subject:From;
	b=jR4cC4OTiSJn4VbM0JvMOrSivGMU8ByssV+tlAXbfojb1eQNsgULTrsOitmTHGEwY
	 DR8naK+4u+v+sPq+Jt0x9VomguuLzEF7z4MLYvu+aZG0a/eJt7ETtMQGFCmA4UyiLh
	 dX5DfkfCZsSxxQKXG602iQdmoOoxPdS/dh8joNIGdRkrkYrjT70GztLS6rM/I3pb5X
	 NE3wpChqR3+tL9fHSvR1qKepWSTIrBKxoSt5im2H0sMsD6/yASv31TzhKbSLWbN+a0
	 Pxinnoyfq3Sr7SJfMGvfmjxY+lQXHtvbXqZV+44AdwXrSrt/VBSqbi5NXzbhAokrrr
	 fYXmZo6pSd8FQ==
Date: Tue, 28 May 2024 16:31:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michael Roth <michael.roth@amd.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync kvm headers with the kernel
 sources
Message-ID: <ZlYxAdHjyAkvGtMW@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

To pick the changes in:

  4af663c2f64a8d25 ("KVM: SEV: Allow per-guest configuration of GHCB protocol version")
  4f5defae708992dd ("KVM: SEV: introduce KVM_SEV_INIT2 operation")
  26c44aa9e076ed83 ("KVM: SEV: define VM types for SEV and SEV-ES")
  ac5c48027bacb1b5 ("KVM: SEV: publish supported VMSA features")
  651d61bc8b7d8bb6 ("KVM: PPC: Fix documentation for ppc mmu caps")

That don't change functionality in tools/perf, as no new ioctl is added
for the 'perf trace' scripts to harvest.

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 22 ++++++++++++++++++++--
 tools/include/uapi/linux/kvm.h        |  4 ++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index ef11aa4cab42536c..9fae1b73b529caf5 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -457,8 +457,13 @@ struct kvm_sync_regs {
 
 #define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE	0x00000001
 
-/* attributes for system fd (group 0) */
-#define KVM_X86_XCOMP_GUEST_SUPP	0
+/* vendor-independent attributes for system fd (group 0) */
+#define KVM_X86_GRP_SYSTEM		0
+#  define KVM_X86_XCOMP_GUEST_SUPP	0
+
+/* vendor-specific groups and attributes for system fd */
+#define KVM_X86_GRP_SEV			1
+#  define KVM_X86_SEV_VMSA_FEATURES	0
 
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
@@ -689,6 +694,9 @@ enum sev_cmd_id {
 	/* Guest Migration Extension */
 	KVM_SEV_SEND_CANCEL,
 
+	/* Second time is the charm; improved versions of the above ioctls.  */
+	KVM_SEV_INIT2,
+
 	KVM_SEV_NR_MAX,
 };
 
@@ -700,6 +708,14 @@ struct kvm_sev_cmd {
 	__u32 sev_fd;
 };
 
+struct kvm_sev_init {
+	__u64 vmsa_features;
+	__u32 flags;
+	__u16 ghcb_version;
+	__u16 pad1;
+	__u32 pad2[8];
+};
+
 struct kvm_sev_launch_start {
 	__u32 handle;
 	__u32 policy;
@@ -856,5 +872,7 @@ struct kvm_hyperv_eventfd {
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
+#define KVM_X86_SEV_VM		2
+#define KVM_X86_SEV_ES_VM	3
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index ea32b101b9999d20..d03842abae5784cf 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1221,9 +1221,9 @@ struct kvm_vfio_spapr_tce {
 /* Available with KVM_CAP_SPAPR_RESIZE_HPT */
 #define KVM_PPC_RESIZE_HPT_PREPARE _IOR(KVMIO, 0xad, struct kvm_ppc_resize_hpt)
 #define KVM_PPC_RESIZE_HPT_COMMIT  _IOR(KVMIO, 0xae, struct kvm_ppc_resize_hpt)
-/* Available with KVM_CAP_PPC_RADIX_MMU or KVM_CAP_PPC_MMU_HASH_V3 */
+/* Available with KVM_CAP_PPC_MMU_RADIX or KVM_CAP_PPC_MMU_HASH_V3 */
 #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
-/* Available with KVM_CAP_PPC_RADIX_MMU */
+/* Available with KVM_CAP_PPC_MMU_RADIX */
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
-- 
2.44.0


