Return-Path: <linux-kernel+bounces-572639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F8A6CC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB851727B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3323371C;
	Sat, 22 Mar 2025 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0oq16qu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB55158D8B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676987; cv=none; b=bFldfLG+EJYr8mpDhJqtTyVwFC1QK+AYHjuTKrBlmW3bCL5VClBsDCUSkVdPyujl3IkeOe4Sr2jcUvWyA73kVq5Ek1ZgGLRbBA2+7FCBy/qSc3ec7BIoVE3BXo0QiMRJnrq+nmFTPEc3Z9B5n8greAdMcMm05GUmImWCv23SDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676987; c=relaxed/simple;
	bh=j/ms9IZpk8tU3clMvTgmZMuEEGFGCZxNJAP+K7nc4kw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J81FEwwys12huHFNf3mBX71Kz2duaBSPLRripyXRIS3iuySH+x6gACZbfT6F0YlzSzIFFC+/+LPIL1J40nfa3dgDshizt7ctYIcW4CSkz5KPXeSnffw6Z+Hq8dkgxUw0520zvYBCX2XTjTjZdGRLdX31qJjHeIbaYd6Dv9QfNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0oq16qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD9C4CEDD;
	Sat, 22 Mar 2025 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742676987;
	bh=j/ms9IZpk8tU3clMvTgmZMuEEGFGCZxNJAP+K7nc4kw=;
	h=Date:From:To:Cc:Subject:From;
	b=D0oq16qu0mBgHDRcqoI2DnRJ2K2fIRpZhhC5FRvVyJxgiFnHlgv1DuPW6VCQT8E2y
	 +m85viE1fJdsNLP4O5qEQCBhJQ1Y4WfxYsHDfTK366gncQAvzRk5WGsqO4fn1lhtN7
	 EEq+GU6sI9lJxJqiJcQIqz5TrEGA/6zQ1NQ8BoHlmjEkYfw/htc6kVd5amNqiFD7FS
	 1zf2sKkh720jP07Qr5I1A4y5D6c3RhhbrjzRDz9PwZQS3Hcv8R1KXfas44GMmTN76k
	 Puv2XUgyM9glnD40ySIs49x5OskOSiM7ZZWOY3YjnaOxoqDnNeOKq2yttSPEIzCciv
	 yFLKyAZPlCoQQ==
Date: Sat, 22 Mar 2025 21:56:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [GIT PULL] perf events fix
Message-ID: <Z98j9k843MxU7On4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-22

   # HEAD: 50a53b60e141d7e31368a87e222e4dd5597bd4ae perf/amd/ibs: Prevent leaking sensitive data to userspace

[ Merge note: I'm really sorry about this late fix for a late-breaking 
  local information leak regression on AMD CPUs that was introduced in 
  the v6.14 merge window. This is the full fix, and it was booted on 
  several AMD systems and ran a few hours in the perf syscall fuzzer - 
  but it's still less than a day old and carries a risk of regression 
  in itself. ]

Fix an information leak regression in the AMD IBS PMU code.

 Thanks,

	Ingo

------------------>
Namhyung Kim (1):
      perf/amd/ibs: Prevent leaking sensitive data to userspace


 arch/x86/events/amd/ibs.c | 84 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c46500592002..e36c9c63c97c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -941,6 +941,8 @@ static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
 		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
 }
 
+/* Be careful. Works only for contiguous MSRs. */
+#define ibs_fetch_msr_idx(msr)	(msr - MSR_AMD64_IBSFETCHCTL)
 #define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
 
 static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
@@ -1036,6 +1038,67 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	return 1;
 }
 
+static bool perf_ibs_is_kernel_data_addr(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data)
+{
+	u64 sample_type_mask = PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW;
+	union ibs_op_data3 op_data3;
+	u64 dc_lin_addr;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	dc_lin_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+
+	return unlikely((event->attr.sample_type & sample_type_mask) &&
+			op_data3.dc_lin_addr_valid && kernel_ip(dc_lin_addr));
+}
+
+static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data,
+					 int br_target_idx)
+{
+	union ibs_op_data op_data;
+	u64 br_target;
+
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+	br_target = ibs_data->regs[br_target_idx];
+
+	return unlikely((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+			op_data.op_brn_ret && kernel_ip(br_target));
+}
+
+static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
+				    int br_target_idx)
+{
+	if (perf_exclude_event(event, regs))
+		return true;
+
+	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+		return false;
+
+	if (perf_ibs_is_kernel_data_addr(event, ibs_data))
+		return true;
+
+	if (br_target_idx != -1 &&
+	    perf_ibs_is_kernel_br_target(event, ibs_data, br_target_idx))
+		return true;
+
+	return false;
+}
+
+static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
+				   struct perf_ibs_data *ibs_data)
+{
+	if (perf_ibs == &perf_ibs_op) {
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
+		return;
+	}
+
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -1048,6 +1111,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
+	int br_target_idx = -1;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -1102,6 +1166,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
 				rdmsrl(MSR_AMD64_IBSBRTARGET, *buf++);
+				br_target_idx = size;
 				size++;
 			}
 			if (ibs_caps & IBS_CAPS_OPDATA4) {
@@ -1128,16 +1193,20 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (perf_exclude_event(event, &regs) ||
-	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
-	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
+	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
+	/*
+	 * Prevent leaking physical addresses to unprivileged users. Skip
+	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
+	 * unprivileged users.
+	 */
+	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+	    perf_allow_kernel(&event->attr)) {
+		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
+	}
 
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
@@ -1149,6 +1218,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from

