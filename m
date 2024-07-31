Return-Path: <linux-kernel+bounces-269488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F0943363
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335F01C22B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4221B3741;
	Wed, 31 Jul 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwm3du9V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA71CA94
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439911; cv=none; b=TMz1MB0d+x35MeF23sUIpQF8uQb3EMn40kPHeDofE30k/Y29xGfcE1K9uMkPP8R8ugjcvBBzUG+nTpOTVjppgHqc0RWdIs/uvR04F0myGObHh8/4MAtBRLHpy9q3a/Zaf+uZURQ9JDNz47MBXny4zRq3t+MqGM6hr7fPYRB7RQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439911; c=relaxed/simple;
	bh=oetgaNYrSjdZmfK7eeNuQ1Rtf/TVJYlpzPtWe3V8jkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWvFnY2/UAXixtSS0nEKnMF89Knb23iy2PNOMORuU7Gf5MDWyhQm09VBx5MXKQMs0+lYKqugY/hkLroo/rph85MM2/aaxg3Tf16SjQYgtWvlrkdkRzvpm88ABsxgZuIouRQqsjJLmnWpylIAIjKEivTtjDCzGoZd1QPW9T4w0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwm3du9V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722439909; x=1753975909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oetgaNYrSjdZmfK7eeNuQ1Rtf/TVJYlpzPtWe3V8jkw=;
  b=Zwm3du9VGXSNMrPdOXBztrtxpH/7wedxjGjhN8/KY+254BmDQzkU+cKR
   tUL/Z4hIwHpIxBE2vb//NdrquRGbvCKzTzDgebf5s7MP31VpBneNOMQmy
   p4QX5qBPAcymZhiAnMQSgEtXkfChTdyp3KRdPKm/GOJZ8ntBXuiq+gxix
   Ws5V1v4yG9R4kwUk5tdeO6lr2KWhWr6gdnvghOvavdaj6JRqX7j9EEaUf
   cKjCl3vr0vGURD4yZBUzZGIX86Yn/emb6UyFraCCtti6KX5xgxKMo/zPG
   kv4XSsj+UKSLXSmY/IjcLezw/wPUZnx//xxUq0f/KYgixssOvywdvVaRb
   Q==;
X-CSE-ConnectionGUID: yUo7rqKpRl21M0xi2xlF3A==
X-CSE-MsgGUID: 2sZ/aLPiQK+YzZ5LYschnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20212502"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20212502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 08:31:48 -0700
X-CSE-ConnectionGUID: g7RqMqiLQFKSsfhMhIXt/Q==
X-CSE-MsgGUID: GJ3usMD+Q82oMX5N9idSqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54408300"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 08:31:48 -0700
Received: from [10.212.113.245] (kliang2-mobl1.ccr.corp.intel.com [10.212.113.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 222F720BA6EC;
	Wed, 31 Jul 2024 08:31:46 -0700 (PDT)
Message-ID: <5d534069-a1b3-4789-8d76-f36f956a1e12@linux.intel.com>
Date: Wed, 31 Jul 2024 11:31:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Support branch counters in block annotation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
 Andi Kleen <andi@firstfloor.org>, mingo@kernel.org,
 linux-kernel@vger.kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
 eranian@google.com
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <ZqpSuBqSZsj2FEcO@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZqpSuBqSZsj2FEcO@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Arnaldo,

On 2024-07-31 11:05 a.m., Arnaldo Carvalho de Melo wrote:
> On Wed, Jul 03, 2024 at 01:03:47PM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The branch counters logging (A.K.A LBR event logging) introduces a
>> per-counter indication of precise event occurrences in LBRs. It can
>> provide a means to attribute exposed retirement latency to combinations
>> of events across a block of instructions. It also provides a means of
>> attributing Timed LBR latencies to events.
>>
>> The kernel support and basic perf tool support have been merged.
>> https://lore.kernel.org/lkml/20231025201626.3000228-1-kan.liang@linux.intel.com/
>>
>> This series is to provide advanced perf tool support via adding the
>> branch counters information in block annotation. It can further
>> facilitate the analysis of branch blocks.
>>
>> The patch 1 and 2 are to fix two existing issues of --total-cycles and
>> the branch counters feature.
>>
>> The patch 3-9 are the advanced perf tool support.
> 
> I couldn't find any newer versions of this series nor reviews, is that
> right?

Right. There is no newer version nor reviews.

The patch series can be successfully applied on top of the latest
tmp.perf-tools-next (on top of the commit 756785ab6380 ("perf list: Give
clues if failed to open tracing events directory")).

I think we can still use it for the review.

> 
> I'll try and review this soon, but if someone else could take a look,
> try it and provide a Reviewed-by or at least an Acked-by, that would
> help!

Thanks!

Kan
> 
> - Arnaldo
>  
>> Here are some examples.
>>
>> perf annotation:
>>
>> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,counter
>> $perf report  --total-cycles --stdio
>>
>>  # To display the perf.data header info, please use --header/--header-only options.
>>  #
>>  #
>>  # Total Lost Samples: 0
>>  #
>>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }'
>>  # Event count (approx.): 1610046
>>  #
>>  # Branch counter abbr list:
>>  # branch-instructions:ppp = A
>>  # branch-misses = B
>>  # '-' No event occurs
>>  # '+' Event occurrences may be lost due to branch counter saturated
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          Branch Counter [Program Block Range]
>>  # ...............  ..............  ...........  ..........  ......................  ..
>>  #
>>            57.55%            2.5M        0.00%           3             |A   |-   |                 ...
>>            25.27%            1.1M        0.00%           2             |AA  |-   |                 ...
>>            15.61%          667.2K        0.00%           1             |A   |-   |                 ...
>>             0.16%            6.9K        0.81%         575             |A   |-   |                 ...
>>             0.16%            6.8K        1.38%         977             |AA  |-   |                 ...
>>             0.16%            6.8K        0.04%          28             |AA  |B   |                 ...
>>             0.15%            6.6K        1.33%         946             |A   |-   |                 ...
>>             0.11%            4.5K        0.06%          46             |AAA+|-   |                 ...
>>
>> (The below output is in the TUI mode. Users can press 'B' to display
>> the Branch counter abbr list.)
>>
>> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
>> 4000 Hz, Event count (approx.):
>> f3  /home/sdp/test/tchain_edit [Percent: local period]
>> Percent       │ IPC Cycle       Branch Counter (Average IPC: 1.39, IPC Coverage: 29.4%)
>>               │                                     0000000000401755 <f3>:
>>   0.00   0.00 │                                       endbr64
>>               │                                       push    %rbp
>>               │                                       mov     %rsp,%rbp
>>               │                                       movl    $0x0,-0x4(%rbp)
>>   0.00   0.00 │1.33     3          |A   |-   |      ↓ jmp     25
>>  11.03  11.03 │                                 11:   mov     -0x4(%rbp),%eax
>>               │                                       and     $0x1,%eax
>>               │                                       test    %eax,%eax
>>  17.13  17.13 │2.41     1          |A   |-   |      ↓ je      21
>>               │                                       addl    $0x1,-0x4(%rbp)
>>  21.84  21.84 │2.22     2          |AA  |-   |      ↓ jmp     25
>>  17.13  17.13 │                                 21:   addl    $0x1,-0x4(%rbp)
>>  21.84  21.84 │                                 25:   cmpl    $0x270f,-0x4(%rbp)
>>  11.03  11.03 │0.61     3          |A   |-   |      ↑ jle     11
>>               │                                       nop
>>               │                                       pop     %rbp
>>   0.00   0.00 │0.24    20          |AA  |B   |      ← ret
>>
>> perf script:
>>
>> $perf script -F +brstackinsn,+brcntr
>>
>>  # Branch counter abbr list:
>>  # branch-instructions:ppp = A
>>  # branch-misses = B
>>  # '-' No event occurs
>>  # '+' Event occurrences may be lost due to branch counter saturated
>>      tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (home/sdp/test/tchain_edit)
>>         f3+31:
>>         0000000000401774        insn: eb 04                     br_cntr: AA     # PRED 5 cycles [5]
>>         000000000040177a        insn: 81 7d fc 0f 27 00 00
>>         0000000000401781        insn: 7e e3                     br_cntr: A      # PRED 1 cycles [6] 2.00 IPC
>>         0000000000401766        insn: 8b 45 fc
>>         0000000000401769        insn: 83 e0 01
>>         000000000040176c        insn: 85 c0
>>
>> $perf script -F +brstackinsn,+brcntr -v
>>
>>      tchain_edit  332203 3366329.405674:      53030 branch-instructions:ppp:            401781 f3+0x2c (/home/sdp/test/tchain_edit)
>>         f3+31:
>>         0000000000401774        insn: eb 04                     br_cntr: branch-instructions:ppp 2 branch-misses 0      # PRED 5 cycles [5]
>>         000000000040177a        insn: 81 7d fc 0f 27 00 00
>>         0000000000401781        insn: 7e e3                     br_cntr: branch-instructions:ppp 1 branch-misses 0      # PRED 1 cycles [6] 2.00 IPC
>>         0000000000401766        insn: 8b 45 fc
>>         0000000000401769        insn: 83 e0 01
>>         000000000040176c        insn: 85 c0
>>
>> Kan Liang (9):
>>   perf report: Fix --total-cycles --stdio output error
>>   perf report: Remove the first overflow check for branch counters
>>   perf evlist: Save branch counters information
>>   perf annotate: Save branch counters for each block
>>   perf evsel: Assign abbr name for the branch counter events
>>   perf report: Display the branch counter histogram
>>   perf annotate: Display the branch counter histogram
>>   perf script: Add branch counters
>>   perf test: Add new test cases for the branch counter feature
>>
>>  tools/perf/Documentation/perf-report.txt |   1 +
>>  tools/perf/Documentation/perf-script.txt |   2 +-
>>  tools/perf/builtin-annotate.c            |  13 +-
>>  tools/perf/builtin-diff.c                |   8 +-
>>  tools/perf/builtin-report.c              |  25 ++-
>>  tools/perf/builtin-script.c              |  69 +++++++-
>>  tools/perf/builtin-top.c                 |   4 +-
>>  tools/perf/tests/shell/record.sh         |  17 +-
>>  tools/perf/ui/browsers/annotate.c        |  18 +-
>>  tools/perf/ui/browsers/hists.c           |  18 +-
>>  tools/perf/util/annotate.c               | 209 +++++++++++++++++++++--
>>  tools/perf/util/annotate.h               |  24 ++-
>>  tools/perf/util/block-info.c             |  66 ++++++-
>>  tools/perf/util/block-info.h             |   8 +-
>>  tools/perf/util/branch.h                 |   1 +
>>  tools/perf/util/disasm.c                 |   1 +
>>  tools/perf/util/evlist.c                 |  66 +++++++
>>  tools/perf/util/evlist.h                 |   2 +
>>  tools/perf/util/evsel.c                  |  15 +-
>>  tools/perf/util/evsel.h                  |  12 ++
>>  tools/perf/util/hist.c                   |   5 +-
>>  tools/perf/util/hist.h                   |   2 +-
>>  tools/perf/util/machine.c                |   3 +
>>  23 files changed, 519 insertions(+), 70 deletions(-)
>>
>> -- 
>> 2.38.1
> 

