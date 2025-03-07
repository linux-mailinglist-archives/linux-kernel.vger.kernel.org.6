Return-Path: <linux-kernel+bounces-550742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FFA5638C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE4C3B4E26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146851FFC44;
	Fri,  7 Mar 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bNFzI++1"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28213207DED
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339199; cv=none; b=j27C/Pau4jGSMlKAuAJngs/pX6cVTVuBBNvEt/RvjYu/EAk++LpGa8jsGpaAabhrCDFvigXD3Hp7MvI6P1S7gC+BvV1302+6J9R6GYsusQTyFmRdgoMhbA1RokWoSC/V5w5Pbd2/U4bRroPzlqAjjU8+XVBWST56sfEhjzahqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339199; c=relaxed/simple;
	bh=mmDJGlTiXfNeJMEuXKVI397heeQI8lNwD4tu96M9a9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWFn0yLJGorg5Q0V3++YBmcRI6wgyYHAJkkgE7/i4C94fr3TDAaEVndXwbp0F+euf8UEve62iqt8ZdtuCLXCyt+JYEhFE9enOUi5b4mxRgq+erEFneM0F0bKtJsghf4uTNlSrhZCdM8gDfblwHi4uhZ/e45CjxNy+TtebLNHHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bNFzI++1; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855183fdcafso84060039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741339195; x=1741943995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsKZEMr3HHLvjCn4YoRhdUIIxvIOxDzrpOUWVftatik=;
        b=bNFzI++1qvgLg2R3nJqdUYVRLpcWA+H83tJclXa72NYrp+oGyzHGEUdgDES43/PWKf
         c56sk2TfmcA8YkdwlA+GFs6fLcKc0+XLk1LRCBbgjZuRL1/YxjIPj8VbX89E7LSPf+59
         Wed6SILuMBNuizfQGgjqOgTE6/ary3xOHJ5xGio1vMikfjUoUe6cwHJb9d2Aik76afgL
         gv0wJ1mNczi6rfJg6JHO53TMiOYQabe+n5QVinjlLMdA5dNzkLjfXMgkMCF2iib8ihwj
         au8A54FRifwAJLSZ2W8pKfxUKY0xkcWZTbFqTdrPRg/LlCey9YfoDo/yS621hrb8BU2u
         Wb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339195; x=1741943995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsKZEMr3HHLvjCn4YoRhdUIIxvIOxDzrpOUWVftatik=;
        b=ubZT6D8e6qbuRajIN9sy3K/tZLXDIBRq6/fhU6raRDT8p2Eq7r815Joknh2+1oQNb0
         UhTGksg8bXhoH6srqxNb+5bBHW0TSZfFMXao8veen26Etotad+/YxGRh1PgFh5r2c1Qq
         IZk7O/nYNox5b1HnUAoSrmaa2rSM6tenaV9i56o/XfAtf38/BMQtkE0w9zTjov49i846
         /r01jqZ7A4GqoBEZU9FfFsiCE4e6/XGwCXOqRGUxVFP38ZAGnAAEYKMNmWcoWKmSkwXM
         kiv4hUqZV6IautXe8ofNHeN7V/jGvF0H0V6TONxQ/EDe3Lqsk1g6xgshiqobq1Njs0vb
         xvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU57ZaJ/5HYA1PTIT6SbEDSraNyUNVmilAjRL5YBTDNq30Nav0R3me6qnfv4uWfecx+7bEMOlXud/Qlgbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSmd9Bu7iN6+sbyq9rQJM2Hp4tsZVCxaeVDUubuUTLq1iSQP8
	Jq8xJ4MEZTJ5ybnLhOK8VhIEGO6TqtgOaCmVPW0Mupzj0aMlIFsPdvek9HgFRwk=
X-Gm-Gg: ASbGncvaxn4MwnMuXZ9U7kx6fk13ELyN8RCVZj7eh7aBVsrMxgRXNZXAM2j9F/hAyLs
	TM/siuxvsVFt3qdenIXjZN40kwZp7xQJhrIs5Sje5EiR2V3qZNddo15UAeFK2obcUhsyU4nFAvj
	vGVuh0gVYdU/OLURMwil0sm/rupcrPZwwIkXBLmWbbGWqjiASSYEHVurq+kiUTg97gFPZpyGxfo
	qgBQkMBEY0csKVJ3JkNuNTL/S1/vy2BkbSgy779yX3Jz8mmdfmsXe/KpLtoFkuKd6wKsmChBIcW
	C7lizQlshWtB3Invj1XaGuRCSibHiM4i1nuTFAsZmRAYYRVuGuaZuuIO0cUBQg==
X-Google-Smtp-Source: AGHT+IHYz1YNu90yzXHeRG9Cltgc3qDq8cWUxHoIVZOWm3IFTOEk9LCi5Cpyrkar83w7qV9HsmfOEw==
X-Received: by 2002:a05:6602:584:b0:855:9ba9:618 with SMTP id ca18e2360f4ac-85b0eb2db5fmr650176639f.8.1741339195150;
        Fri, 07 Mar 2025 01:19:55 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a008ffcsm822075173.101.2025.03.07.01.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:19:54 -0800 (PST)
Message-ID: <1198d3ac-d715-4f82-853e-bf9d0ad9dde7@sifive.com>
Date: Fri, 7 Mar 2025 03:19:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU
 PMU events
To: Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20250213220341.3215660-1-samuel.holland@sifive.com>
 <Z7ZLB-wZY9wTZSBZ@google.com>
 <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAOnJCUJYKkGXOJiLTnPOgPSnEiCeXFaoGQRiT5Au+rbvP1unZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Atish,

On 2025-03-01 3:21 AM, Atish Patra wrote:
> On Wed, Feb 19, 2025 at 1:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Wed, Feb 12, 2025 at 05:21:33PM -0800, Samuel Holland wrote:
>>> This series updates the PMU event JSON files to add support for newer
>>> SiFive CPUs, including those used in the HiFive Premier P550 board.
>>> Since most changes are incremental, symbolic links are used when a set
>>> of events is unchanged from the previous CPU series.
>>>
>>> I originally sent this series about a year ago[1], but received no
>>> feedback. The P550 board is now available (and I have tested this series
>>> on it), so it would be good to get perf support for it upstream.
>>>
>>> [1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/
>>>
> 
> Tested the patches that are part of sifive's release tree for p550.
> Both perf stat/record seems to work fine
> for a bunch of events.
> 
> Based on that
> Tested-by: Atish Patra <atishp@rivosinc.com>

Thanks for testing!

> @Samuel Holland : perf report that the following two events are not
> supported on the p550 board.
> 
> cycle and instruction count:
>   core_clock_cycles
>        [Counts core clock cycles]
>   instructions_retired
>        [Counts instructions retired]
> 
> I assumed that these are raw events cycle/instruction retired events
> that can support
> perf sampling as well. Maybe I am missing something ? DT binding ?

perf is correct. Those two events are not supported on P550, only by the newer
cores (bulled-0d and p650). Yes, those are aliases of cycles and instructions
that were added to support sampling.

Regards,
Samuel

>>>
>>> Eric Lin (5):
>>>   perf vendor events riscv: Update SiFive Bullet events
>>>   perf vendor events riscv: Add SiFive Bullet version 0x07 events
>>>   perf vendor events riscv: Add SiFive Bullet version 0x0d events
>>>   perf vendor events riscv: Add SiFive P550 events
>>>   perf vendor events riscv: Add SiFive P650 events
>>>
>>> Samuel Holland (2):
>>>   perf vendor events riscv: Rename U74 to Bullet
>>>   perf vendor events riscv: Remove leading zeroes
>>
>> It'd be nice if anyone in the RISC-V community can review this.
>>
>> Thanks,
>> Namhyung
>>
>>>
>>>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
>>>  .../cycle-and-instruction-count.json          | 12 +++
>>>  .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
>>>  .../riscv/sifive/bullet-07/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
>>>  .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
>>>  .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
>>>  .../cycle-and-instruction-count.json          |  1 +
>>>  .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
>>>  .../riscv/sifive/bullet-0d/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
>>>  .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
>>>  .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
>>>  .../sifive/{u74 => bullet}/firmware.json      |  0
>>>  .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
>>>  .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
>>>  .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
>>>  .../arch/riscv/sifive/p550/firmware.json      |  1 +
>>>  .../arch/riscv/sifive/p550/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
>>>  .../arch/riscv/sifive/p550/microarch.json     |  1 +
>>>  .../p650/cycle-and-instruction-count.json     |  1 +
>>>  .../arch/riscv/sifive/p650/firmware.json      |  1 +
>>>  .../arch/riscv/sifive/p650/instruction.json   |  1 +
>>>  .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
>>>  .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
>>>  .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
>>>  .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
>>>  .../arch/riscv/sifive/u74/memory.json         | 32 -------
>>>  .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
>>>  30 files changed, 555 insertions(+), 182 deletions(-)
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
>>>  rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
>>>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
>>>  create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
>>>  delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
>>>
>>> --
>>> 2.47.0
>>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> --
> Regards,
> Atish


