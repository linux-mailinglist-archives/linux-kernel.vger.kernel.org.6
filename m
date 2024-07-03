Return-Path: <linux-kernel+bounces-240110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58C92693C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF61C226B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A835186E32;
	Wed,  3 Jul 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEWIkgRM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12064C6C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037005; cv=none; b=aWmedZyQtBmkLrlmK373FxEU1Q5uFSwBwJEYN2XcgDqjb7V3q0E+tTj4wbkS6zw2Q2WqFi+NhzpekyMI+cRGSqel5xUOXqS7lkW7VwJUftRDuxUAS9B5KF4ST/fdsyYN0Ht+Tm1ou1K+vbswNfp/j6MAzYZJCwuF/pPjpb5dRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037005; c=relaxed/simple;
	bh=KWKxSgkUTigGIrlXO8IkzNopByjBOgpoYRnFd3RiAwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CD2qVCNo7K2tp/4B8ctkeM4lm/V/IFRaE5CxFIyafN7vhjPukl27tO0DLB4Kd/Hbg0he7ho/dkHsAxT+QzcAz7URT5qT7QEhNQIjJgpA+hjsndPIkQ+266a5v/IISUpr0KAhs4mN6XrBX3FmHOpuQFTs5iMlQkhQsZ8c7cuQwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEWIkgRM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037004; x=1751573004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KWKxSgkUTigGIrlXO8IkzNopByjBOgpoYRnFd3RiAwk=;
  b=CEWIkgRMt/ksvN1zrZJByuBsasPv8xmPH/LxqVtm1diYVo3XQryCGvTF
   K+uRvhDdSP2ZlFZGsmLcWE7YJ7xxtK+3IRJEqU3aeg6/2j7XLhV6iDJH0
   mOTc510/sN3N41BRhAUr6ZOADCZnLSjDJ5RmbO26djIdTw3noKinJqeN2
   iC5AIUrN6ivOBKuy9njhIidTblKOYe5TNMbvZBLuocWhHWH/0OiW28tZ5
   nOMR0Xl1wEilLlzJDlU/wa7j4LaS2QkJ0J/2YCX/prbwQ7SZ/+NhqlkfW
   AXc3kDHx7hcarkBFtvyoXOMZrZgNb4mxEQYB0sBi9dDx/8S7MxctIOnol
   A==;
X-CSE-ConnectionGUID: TnnbwbZbRaSts6I0fn1v0w==
X-CSE-MsgGUID: PsM5wN4cTqiLsQ9fh96TOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807558"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807558"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:23 -0700
X-CSE-ConnectionGUID: zjHdWsvsTSCnT9/SdJncyQ==
X-CSE-MsgGUID: NPzgd5CSSj2uSedGm0c8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442539"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 13:03:22 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/9] Support branch counters in block annotation 
Date: Wed,  3 Jul 2024 13:03:47 -0700
Message-Id: <20240703200356.852727-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The branch counters logging (A.K.A LBR event logging) introduces a
per-counter indication of precise event occurrences in LBRs. It can
provide a means to attribute exposed retirement latency to combinations
of events across a block of instructions. It also provides a means of
attributing Timed LBR latencies to events.

The kernel support and basic perf tool support have been merged.
https://lore.kernel.org/lkml/20231025201626.3000228-1-kan.liang@linux.intel.com/

This series is to provide advanced perf tool support via adding the
branch counters information in block annotation. It can further
facilitate the analysis of branch blocks.

The patch 1 and 2 are to fix two existing issues of --total-cycles and
the branch counters feature.

The patch 3-9 are the advanced perf tool support.

Here are some examples.

perf annotation:

$perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,counter
$perf report  --total-cycles --stdio

 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }'
 # Event count (approx.): 1610046
 #
 # Branch counter abbr list:
 # branch-instructions:ppp = A
 # branch-misses = B
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Branch Counter [Program Block Range]
 # ...............  ..............  ...........  ..........  ......................  ..
 #
           57.55%            2.5M        0.00%           3             |A   |-   |                 ...
           25.27%            1.1M        0.00%           2             |AA  |-   |                 ...
           15.61%          667.2K        0.00%           1             |A   |-   |                 ...
            0.16%            6.9K        0.81%         575             |A   |-   |                 ...
            0.16%            6.8K        1.38%         977             |AA  |-   |                 ...
            0.16%            6.8K        0.04%          28             |AA  |B   |                 ...
            0.15%            6.6K        1.33%         946             |A   |-   |                 ...
            0.11%            4.5K        0.06%          46             |AAA+|-   |                 ...

(The below output is in the TUI mode. Users can press 'B' to display
the Branch counter abbr list.)

Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
4000 Hz, Event count (approx.):
f3  /home/sdp/test/tchain_edit [Percent: local period]
Percent       │ IPC Cycle       Branch Counter (Average IPC: 1.39, IPC Coverage: 29.4%)
              │                                     0000000000401755 <f3>:
  0.00   0.00 │                                       endbr64
              │                                       push    %rbp
              │                                       mov     %rsp,%rbp
              │                                       movl    $0x0,-0x4(%rbp)
  0.00   0.00 │1.33     3          |A   |-   |      ↓ jmp     25
 11.03  11.03 │                                 11:   mov     -0x4(%rbp),%eax
              │                                       and     $0x1,%eax
              │                                       test    %eax,%eax
 17.13  17.13 │2.41     1          |A   |-   |      ↓ je      21
              │                                       addl    $0x1,-0x4(%rbp)
 21.84  21.84 │2.22     2          |AA  |-   |      ↓ jmp     25
 17.13  17.13 │                                 21:   addl    $0x1,-0x4(%rbp)
 21.84  21.84 │                                 25:   cmpl    $0x270f,-0x4(%rbp)
 11.03  11.03 │0.61     3          |A   |-   |      ↑ jle     11
              │                                       nop
              │                                       pop     %rbp
  0.00   0.00 │0.24    20          |AA  |B   |      ← ret

perf script:

$perf script -F +brstackinsn,+brcntr

 # Branch counter abbr list:
 # branch-instructions:ppp = A
 # branch-misses = B
 # '-' No event occurs
 # '+' Event occurrences may be lost due to branch counter saturated
     tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (home/sdp/test/tchain_edit)
        f3+31:
        0000000000401774        insn: eb 04                     br_cntr: AA     # PRED 5 cycles [5]
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: A      # PRED 1 cycles [6] 2.00 IPC
        0000000000401766        insn: 8b 45 fc
        0000000000401769        insn: 83 e0 01
        000000000040176c        insn: 85 c0

$perf script -F +brstackinsn,+brcntr -v

     tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (/home/sdp/test/tchain_edit)
        f3+31:
        0000000000401774        insn: eb 04                     br_cntr: branch-instructions:ppp 2 branch-misses 0      # PRED 5 cycles [5]
        000000000040177a        insn: 81 7d fc 0f 27 00 00
        0000000000401781        insn: 7e e3                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [6] 2.00 IPC
        0000000000401766        insn: 8b 45 fc
        0000000000401769        insn: 83 e0 01
        000000000040176c        insn: 85 c0

Kan Liang (9):
  perf report: Fix --total-cycles --stdio output error
  perf report: Remove the first overflow check for branch counters
  perf evlist: Save branch counters information
  perf annotate: Save branch counters for each block
  perf evsel: Assign abbr name for the branch counter events
  perf report: Display the branch counter histogram
  perf annotate: Display the branch counter histogram
  perf script: Add branch counters
  perf test: Add new test cases for the branch counter feature

 tools/perf/Documentation/perf-report.txt |   1 +
 tools/perf/Documentation/perf-script.txt |   2 +-
 tools/perf/builtin-annotate.c            |  13 +-
 tools/perf/builtin-diff.c                |   8 +-
 tools/perf/builtin-report.c              |  25 ++-
 tools/perf/builtin-script.c              |  69 +++++++-
 tools/perf/builtin-top.c                 |   4 +-
 tools/perf/tests/shell/record.sh         |  17 +-
 tools/perf/ui/browsers/annotate.c        |  18 +-
 tools/perf/ui/browsers/hists.c           |  18 +-
 tools/perf/util/annotate.c               | 209 +++++++++++++++++++++--
 tools/perf/util/annotate.h               |  24 ++-
 tools/perf/util/block-info.c             |  66 ++++++-
 tools/perf/util/block-info.h             |   8 +-
 tools/perf/util/branch.h                 |   1 +
 tools/perf/util/disasm.c                 |   1 +
 tools/perf/util/evlist.c                 |  66 +++++++
 tools/perf/util/evlist.h                 |   2 +
 tools/perf/util/evsel.c                  |  15 +-
 tools/perf/util/evsel.h                  |  12 ++
 tools/perf/util/hist.c                   |   5 +-
 tools/perf/util/hist.h                   |   2 +-
 tools/perf/util/machine.c                |   3 +
 23 files changed, 519 insertions(+), 70 deletions(-)

-- 
2.38.1


