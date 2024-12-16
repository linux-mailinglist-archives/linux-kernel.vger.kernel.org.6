Return-Path: <linux-kernel+bounces-446883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156B59F2A94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815C618874D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479311CDFDE;
	Mon, 16 Dec 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvB0Jwit"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280C29CA;
	Mon, 16 Dec 2024 07:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332579; cv=none; b=b5+fVoV+nEC2LiYj57LM92wth7tdG3ZbT0qJKSrwt/kjLy0g9vNJXb80Z3uRKpc0sjN6oW9MVPQC56KjZIU87bMuLrsbiN4yO5x5j+JfOOKrc3c3zR1YhzM7MLBN4AJC7/ofjD0npS17cOQnxITrbOm0T5siMAnZYpYL0Ps47AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332579; c=relaxed/simple;
	bh=t8C8Z6fdGZXroWtgERPh/aJeQx+T3zuQsCkcdOtb82A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JA9XkS9MOXE0u4Quf5greEebRJxfO8wVrIgtB2fNWU+Yr3jFw3P/+t78BOqicqMIGFV/3kA0vnx4k97owKBkNMayDDoR823dYxuqIIxbGK3f7jAPxLzuajirlnBmvIxMWqJ0zCOxTwYAhedRWluzBjDrQTfYmEmsYlJtdH5VnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvB0Jwit; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332578; x=1765868578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t8C8Z6fdGZXroWtgERPh/aJeQx+T3zuQsCkcdOtb82A=;
  b=DvB0JwitKQzhEqc5MJZ9S2D8+EZhpLAphB7IDxQzFG6f9wRfFS3z0bk4
   tENacwGB5BVXn5pb/O8DOsy0zzYVJzC0sHBAHzTJSVou3/mImJApI+4h4
   dBQPRD7AwlCbrG8i5W3xVOokWW+kO2YdR0DWASV5ejUsdETMScAMPoi+G
   cHAck+q6BgSYvwTZ80h5VdhnNYlg4IF+X0S6/LHHIyM/dRrUHjEKnhA1g
   R3aWvGVIm4hwjm5VWC0cF5Doc3si7NODCpJdd4+51N7+pqv3k6y0MYsxg
   pi9QTpC+n3mIqDpG4L5ZCHNd0v7qVxBukMH7lncqgJZKZ3TkeMm2tZP5v
   Q==;
X-CSE-ConnectionGUID: bLR9UbhZS9OgDFl5odWwkQ==
X-CSE-MsgGUID: QuVBezJTRU6BYzhm31IbnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584245"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584245"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:02:58 -0800
X-CSE-ConnectionGUID: YIBSoPtsSNyf5ja/Psemrg==
X-CSE-MsgGUID: V87TbRnCQVm4hjKJOYrFKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101258611"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:02:54 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 0/7] perf/core: Add ability for an event to "pause" or "resume" AUX area tracing
Date: Mon, 16 Dec 2024 09:02:36 +0200
Message-ID: <20241216070244.14450-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

Note for V15:
	Same as V14 but without kernel patches because they have been
	applied, and updated "missing_features" patch for the new way
	of detecting missing features.

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

These patches add such a facilty and show how it would work for Intel
Processor Trace.

Maintainers of other AUX area tracing implementations are requested to
consider if this is something they might employ and then whether or not
the ABI would work for them.  Note, thank you to James Clark (ARM) for
evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
positively to the RFC.

Changes to perf tools are now (since V4) fleshed out.

Please note, Intel® Architecture Instruction Set Extensions and Future
Features Programming Reference March 2024 319433-052, currently:

	https://cdrdv2.intel.com/v1/dl/getContent/671368

introduces hardware pause / resume for Intel PT in a feature named
Intel PT Trigger Tracing.

For that more fields in perf_event_attr will be necessary.  The main
differences are:
	- it can be applied not just to overflows, but optionally to
	every event
	- a packet is emitted into the trace, optionally with IP
	information
	- no PMI
	- works with PMC and DR (breakpoint) events only

Here are the proposed additions to perf_event_attr, please comment:

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0c557f0a17b3..05dcc43f11bb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -369,6 +369,22 @@ enum perf_event_read_format {
 	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
+enum {
+	PERF_AUX_ACTION_START_PAUSED		=   1U << 0,
+	PERF_AUX_ACTION_PAUSE			=   1U << 1,
+	PERF_AUX_ACTION_RESUME			=   1U << 2,
+	PERF_AUX_ACTION_EMIT			=   1U << 3,
+	PERF_AUX_ACTION_NR			= 0x1f << 4,
+	PERF_AUX_ACTION_NO_IP			=   1U << 9,
+	PERF_AUX_ACTION_PAUSE_ON_EVT		=   1U << 10,
+	PERF_AUX_ACTION_RESUME_ON_EVT		=   1U << 11,
+	PERF_AUX_ACTION_EMIT_ON_EVT		=   1U << 12,
+	PERF_AUX_ACTION_NR_ON_EVT		= 0x1f << 13,
+	PERF_AUX_ACTION_NO_IP_ON_EVT		=   1U << 18,
+	PERF_AUX_ACTION_MASK			= ~PERF_AUX_ACTION_START_PAUSED,
+	PERF_AUX_PAUSE_RESUME_MASK		= PERF_AUX_ACTION_PAUSE | PERF_AUX_ACTION_RESUME,
+};
+
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
 #define PERF_ATTR_SIZE_VER1	72	/* add: config2 */
 #define PERF_ATTR_SIZE_VER2	80	/* add: branch_sample_type */
@@ -515,10 +531,19 @@ struct perf_event_attr {
 	union {
 		__u32	aux_action;
 		struct {
-			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
-				aux_pause        :  1, /* on overflow, pause AUX area tracing */
-				aux_resume       :  1, /* on overflow, resume AUX area tracing */
-				__reserved_3     : 29;
+			__u32	aux_start_paused  :  1, /* start AUX area tracing paused */
+				aux_pause         :  1, /* on overflow, pause AUX area tracing */
+				aux_resume        :  1, /* on overflow, resume AUX area tracing */
+				aux_emit          :  1, /* generate AUX records instead of events */
+				aux_nr            :  5, /* AUX area tracing reference number */
+				aux_no_ip         :  1, /* suppress IP in AUX records */
+				/* Following apply to event occurrence not overflows */
+				aux_pause_on_evt  :  1, /* on event, pause AUX area tracing */
+				aux_resume_on_evt :  1, /* on event, resume AUX area tracing */
+				aux_emit_on_evt   :  1, /* generate AUX records instead of events */
+				aux_nr_on_evt     :  5, /* AUX area tracing reference number */
+				aux_no_ip_on_evt  :  1, /* suppress IP in AUX records */
+				__reserved_3      : 13;
 		};
 	};


Changes in V16:
      Rebased

Changes in V15:
      perf/x86/intel/pt: Fix buffer full but size is 0 case
      perf/core: Add aux_pause, aux_resume, aux_start_paused
      perf/x86/intel/pt: Add support for pause / resume
      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	Dropped kernel patches because they have been applied

      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
	Re-base on new API probe method of missing feature detection
	and add probe for aux_action.

Changes in V14:
      Dropped KVM patches

      perf/x86/intel/pt: Add support for pause / resume
	Set pt->handle_nmi after configuration is completed instead of during

Changes in V13:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Do aux_resume at the end of __perf_event_overflow() so as to trace
	less of perf itself

      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
	Add error message also in EOPNOTSUPP case (Leo)

Changes in V12:
	Add previously sent patch "perf/x86/intel/pt: Fix buffer full
	but size is 0 case"

	Add previously sent patch set "KVM: x86: Fix Intel PT Host/Guest
	mode when host tracing"

	Rebase on current tip plus patch set "KVM: x86: Fix Intel PT Host/Guest
	mode when host tracing"

Changes in V11:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Make assignment to event->hw.aux_paused conditional on
	(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE).

      perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	Remove definition of has_aux_action() because it has
	already been added as an inline function.

      perf/x86/intel/pt: Fix sampling synchronization
      perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
      perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
	Dropped because they have already been applied

Changes in V10:
      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused into a union within struct hw_perf_event.
	Additional comment wrt PERF_EF_PAUSE/PERF_EF_RESUME.
	Factor out has_aux_action() as an inline function.
	Use scoped_guard for irqsave.
	Move calls of perf_event_aux_pause() from __perf_event_output()
	to __perf_event_overflow().

Changes in V9:
      perf/x86/intel/pt: Fix sampling synchronization
	New patch

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Move aux_paused to struct hw_perf_event

      perf/x86/intel/pt: Add support for pause / resume
	Add more comments and barriers for resume_allowed and
	pause_allowed
	Always use WRITE_ONCE with resume_allowed


Changes in V8:

      perf tools: Parse aux-action
	Fix clang warning:
	     util/auxtrace.c:821:7: error: missing field 'aux_action' initializer [-Werror,-Wmissing-field-initializers]
	     821 |         {NULL},
	         |              ^

Changes in V7:

	Add Andi's Reviewed-by for patches 2-12
	Re-base

Changes in V6:

      perf/core: Add aux_pause, aux_resume, aux_start_paused
	Removed READ/WRITE_ONCE from __perf_event_aux_pause()
	Expanded comment about guarding against NMI

Changes in V5:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Added James' Ack

    perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
	New patch

    perf tools
	Added Ian's Ack

Changes in V4:

    perf/core: Add aux_pause, aux_resume, aux_start_paused
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32

    coresight: Have a stab at support for pause / resume
	Dropped

    perf tools
	All new patches

Changes in RFC V3:

    coresight: Have a stab at support for pause / resume
	'mode' -> 'flags' so it at least compiles

Changes in RFC V2:

	Use ->stop() / ->start() instead of ->pause_resume()
	Move aux_start_paused bit into aux_output_cfg
	Tighten up when Intel PT pause / resume is allowed
	Add an example of how it might work for CoreSight


Adrian Hunter (7):
      perf tools: Add aux_start_paused, aux_pause and aux_resume
      perf tools: Add aux-action config term
      perf tools: Parse aux-action
      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
      perf intel-pt: Improve man page format
      perf intel-pt: Add documentation for pause / resume
      perf intel-pt: Add a test for pause / resume

 tools/perf/Documentation/perf-intel-pt.txt | 596 ++++++++++++++++++-----------
 tools/perf/Documentation/perf-record.txt   |   4 +
 tools/perf/builtin-record.c                |   4 +-
 tools/perf/tests/shell/test_intel_pt.sh    |  28 ++
 tools/perf/util/auxtrace.c                 |  67 +++-
 tools/perf/util/auxtrace.h                 |   6 +-
 tools/perf/util/evsel.c                    | 101 ++++-
 tools/perf/util/evsel.h                    |   1 +
 tools/perf/util/evsel_config.h             |   1 +
 tools/perf/util/parse-events.c             |  10 +
 tools/perf/util/parse-events.h             |   1 +
 tools/perf/util/parse-events.l             |   1 +
 tools/perf/util/perf_event_attr_fprintf.c  |   3 +
 tools/perf/util/pmu.c                      |   1 +
 14 files changed, 584 insertions(+), 240 deletions(-)


Regards
Adrian

