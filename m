Return-Path: <linux-kernel+bounces-183556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BBF8C9A92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826281C21A16
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859B22619;
	Mon, 20 May 2024 09:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E62D7A8;
	Mon, 20 May 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198126; cv=none; b=t8cFF+A3e+RW/jisv0ZX97tTIGryudsQs2yDo3kIC9xn4OUZR8FeaHv95q/uZNY6/3KWGX16MVprvtgl3qlt7G6E/MEp/cmLnTil8q8suMtODH2KQE01GonmcgXGA3g1FpXBxhjoQYjO6G9ijvk2dcCQEzK44Nbg2bd3QmL6hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198126; c=relaxed/simple;
	bh=tqJq6X3A7QqdtDBvorzQ9Ec8VgEK4mqpyfp7HfySsTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Slu7cc/jLGPzrx0se1BifF9vxoegxyEwi5GyeloefYI3SVnlooqjwg1hqwAIrYLJmZb+YcLxOjUTOKcgX0gJP13yzDl7Znrm3/i0U9evEnHIz2VrmRN3/9rewk+WobXyXSKUkFwhQHPJDgqJdj8ww1i0b+xul6ToKiiXNH2+sFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39B06FEC;
	Mon, 20 May 2024 02:42:28 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB703F766;
	Mon, 20 May 2024 02:42:02 -0700 (PDT)
Message-ID: <6c910206-2409-4a7e-9d5e-8ffc1c269c08@foss.arm.com>
Date: Mon, 20 May 2024 10:42:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] perf maps: Improve the kcore maps merging
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240515211045.377080-1-leo.yan@arm.com>
 <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <niayan01@foss.arm.com>
In-Reply-To: <CAP-5=fVh-i5cCdW9MJ5AeN2k5Os2W6fifSCMi3gi6qMt_cdDPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 22:39, Ian Rogers wrote:

[...]

> Thanks Leo, testing this change on perf-tools-next with an x86 debian
> laptop I see:
> ```
> $ perf test 24 -v
> 24: Object code reading:
> --- start ---
> test child forked, pid 3407499
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: build id mismatch for vmlinux.
> symsrc__init: cannot get elf header.
> overlapping maps in [kernel.kallsyms] (disable tui for more info)
> Using /proc/kcore for kernel data
> Using /proc/kallsyms for symbols
> Parsing event 'cycles'
> Using CPUID GenuineIntel-6-8D-1
> mmap size 528384B
> Reading object code for memory address: 0xfffffffface8d64a
> File is: /proc/kcore
> On file address is: 0xfffffffface8d64a
> dso__data_read_offset failed
> ---- end(-1) ----
> 24: Object code reading                                             : FAILED!
> ```
> The test passes without the changes. Let me know if you need me to dig deeper.

Just update for the test failure.

The failure is caused by the memory map's attribute is not updated after 
I removed the map replacement related code in patch 02. This means the 
old (identical) kernel map (generated by '/proc/kallsyms') still keeps 
some stale info for 'pgoff', 'mapping_type', etc.

To fix this issue, in the new patch, it removes the old kernel map (to 
avoid any stale info) and update 'machine->vmlinux_map'.

Just one concern. I saw the kcore exposes kernel text section which is 
dependent on the CONFIG_ARCH_PROC_KCORE_TEXT config, but some arches 
(e.g. PowerPC, etc) are absent for this config. But you can see even the 
current code doesn't handle this case, if the replacement map is not 
found, it is arbitrarily assigned to the first map in kcore [1]. An 
option is to rollback to use the old identical kernel map, this is not 
addressed in my latest patch, which is simply report failure in this 
case. Please review it and let me know how you think.

Thanks,
Leo

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/symbol.c?h=v6.9#n1366

