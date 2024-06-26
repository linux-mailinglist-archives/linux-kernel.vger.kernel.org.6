Return-Path: <linux-kernel+bounces-230536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D60917E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC2FB2469D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF381552F6;
	Wed, 26 Jun 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atagzg1L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1517B433;
	Wed, 26 Jun 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397974; cv=none; b=ao46CKf153aNXPClmaqyaTR+G1tDnrxhHjTiY40sDY29bL36//JksRYF/igDepz/C64NzbCC33SakQpCC3A1AgLyVNG2bRHVeOlmkesDRyr6jYLrkIaksp6dz9v4X/Zt026UxdfFwlBMvoFFZoqjluUqqGQPMIKcdHbcixUCfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397974; c=relaxed/simple;
	bh=3izx0B3mI55jofLEkEwXdEAp1lB1IbFcARH6Cmm5Bnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjMVOJSrUKaDLp6HHOHLkIlmugb+NwVgDyZb/IESDJu+wkNN1+k3/YIuKp2pcfJZxShg6fA8huzxRvh1N/NLE5fdYgKu3EHavC4QZ/uUuBdIVqI4ltsga6/SCMFyuzxvpntDTYYY2Y1+OIaCOmFr/NTBMtuBuUxNO8IZ6INi3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atagzg1L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719397973; x=1750933973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3izx0B3mI55jofLEkEwXdEAp1lB1IbFcARH6Cmm5Bnc=;
  b=atagzg1Lve7YXSJv6mhp8xnds06aI1DFhCpFfAiaeJJcYlt8w/OotuGX
   egMxpabTk40wYfW/DE6egxVCO5it9MY1T9fHlTCJ/aizM9P/PgyckfSiv
   FnmXIa6ix2/ub0gZntK8DfB3UUKi4bH//XdF4BgBRyAf/AwaKfnb9LVEa
   Y/vKQHPIxWkMq4iKMgBsLtlB2EDqnIkhbzGB2BN7L+Bl8E6b3lqOsL9aX
   lVJZwp1P1ZwsXevjbxipszV5P1BNqK73JYPxHX8kpJpLp1Q7Ch1xIevpw
   hKh6TojSWEOdl8dcbnB/5CNnl4dac/ePHunXYZcLtuNCjEH+f5iIl1Mdv
   w==;
X-CSE-ConnectionGUID: /twzRki/ReyftWVbrSz/Ag==
X-CSE-MsgGUID: YUc/gPA5T2O83jFpqc4MLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27864747"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27864747"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:32:52 -0700
X-CSE-ConnectionGUID: qrXbhX2PS1q+W2TPO99iqQ==
X-CSE-MsgGUID: r2KSOniWSa2Xeu3HhYGpuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48403102"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:32:48 -0700
Message-ID: <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>
Date: Wed, 26 Jun 2024 13:32:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
To: duchangbin <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
 <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/06/24 05:26, duchangbin wrote:
> On Tue, Jun 25, 2024 at 04:20:49PM +0300, Adrian Hunter wrote:
>> On 25/06/24 06:37, Changbin Du wrote:
>>> The vdso dumped from process memory (in buildid-cache) lacks debugging
>>> info. To annotate vdso symbols with source lines we need specify a
>>> debugging version.
>>>
>>> For x86, we can find them from your local build as
>>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
>>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
>>> the buildid has to match.
>>>
>>> $ sudo perf record -a
>>> $ sudo perf report --objdump=llvm-objdump \
>>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
>>>
>>> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
>>> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
>>> Percent│       movq    -48(%rbp),%rsi
>>>        │       testq   %rax,%rax
>>>        │     ;               return vread_hvclock();
>>>        │       movq    %rax,%rdx
>>>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>>>        │     ↑ js      eb
>>>        │     ↑ jmp     74
>>>        │     ;               ts->tv_sec = vdso_ts->sec;
>>>   0.02 │147:   leaq    2(%rbx),%rax
>>>        │       shlq    $4, %rax
>>>        │       addq    %r10,%rax
>>>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>>>   9.38 │152:   movl    (%r10),%ecx
>>>
>>> When doing cross platform analysis, we also need specify the vdso path if
>>> we are interested in its symbols.
>>
>> Would it be possible to add vdso and vdso debug to the build-id
>> cache and ensure perf can find it there?
>>
>> Typically, getting dsos from another machine is handled via
>> build-id cache e.g. what perf-archive does
>>
> Hmm. I agree this is better alternative approach for cross-machine analysis.
> When collecting vdsos to buildid cache, I think we can use the local searched
> objects (with debug symbols) instead if its build-id matches vdsos from process
> dumping (the real code ran).
> 
> Currently I just follow what perf does for vmlinux so to reuse most of existing
> code. Maybe vmlinux is too big to add to buildid-cahce?
> 
> Can we keep our current strategy for now? I'll think about above options when
> I have more time.
> 

I tried adding vdso via perf buildid-cache.  It doesn't work only
because the lookup expects the basename to be "vdso" but it is
"elf".

Adding a link from "vdso" to "elf" made it work e.g.

$ cat gettimeofday-test.c
#include <stdio.h>
#include <sys/time.h>

int main()
{
        struct timeval tv;
        int ret;

        ret = gettimeofday(&tv, NULL);
        if (ret == -1) {
                fprintf(stderr, "gettimeofday failed\n");
                return 1;
        }

        printf("%lu.%lu\n", (unsigned long)tv.tv_sec, (unsigned long)tv.tv_usec);

        return 0;
$ perf record -e intel_pt//u ./gettimeofday-test
1719397042.892837
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.026 MB perf.data ]
$ perf script --itrace=e
$ perf buildid-cache --remove /lib/modules/6.5.0-41-generic/vdso/vdso64.so
$ perf script --itrace=e
Warning:
2 instruction trace errors
 instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
 instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
$ perf buildid-cache --add /lib/modules/6.5.0-41-generic/vdso/vdso64.so
$ perf script --itrace=e
Warning:
2 instruction trace errors
 instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
 instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
$ cd ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8
~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ln -s elf vdso
~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ls -l
total 36
-rw-r--r-- 1 ahunter ahunter 33272 Jun 26 13:17 elf
-rw-r----- 1 ahunter ahunter     0 Jun 26 13:17 probes
lrwxrwxrwx 1 ahunter ahunter     3 Jun 26 13:18 vdso -> elf
/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ cd
$ perf script --itrace=e
$ 

So maybe a change could be made to build_id_cache__add() to add
the extra link if the file name matches vdso


