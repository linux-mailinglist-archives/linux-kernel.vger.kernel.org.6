Return-Path: <linux-kernel+bounces-546945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E6A50108
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E3616C6D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025D250BF2;
	Wed,  5 Mar 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkBtHD6j"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75912505CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182263; cv=none; b=tdr+dJkj9xYITi4hDm9BRcN1GUtDNnyO2GcBIy9XqjJHUv85PlpLA7/DqAmmiD0irO3BIv0GnjNQZuIIpTjmQzQjvWWAfQ6X9yuuAuPkXQNLyo+rilcLmGm3q6PP/BRRpNHdzd5B56BwUxTx/ZK+9XsYl/tk0J4IYy83J1LvvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182263; c=relaxed/simple;
	bh=xrrAddc0Dux542IExfOiJL20FzbLUh8sACsEll+OBQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=J5ibtI3ESFKkMuReclUh4Prrsu3v6S5XXb2+DUpslZuD+8k6mMqjgM7dneznxdUGYkcjKI9G/ZL2hgrY4U41j/qlMaSQzmrPDhvXBto5eAwmORajEwSKir2tUvmI3bq1QQlJxLPaIGREStY2Z6EtpMivxmikQGn0M7E66+BB8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkBtHD6j; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3910e101d0fso2237363f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741182260; x=1741787060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Yuyf18O1C9beAnXo5r2fUqE9fJzKJV0tNnseaOAJ1I=;
        b=BkBtHD6j60IDzu33eU+NVm/9jJSPtB5JKPUjFlnDy9wSCKQph1quInznsIyVl6+1y+
         ReukChC0MRf5f4Oat03PtE+shK2Z5TBO+pC6B9rHbtCu6iE4orAXyYYSsbBirAZQh2AE
         EJhkBH4q+EDi/hwnWxlQm8qmum+EQpyJI2Gk1vhEhc703OGsAAtb6tJrwutIjhALXiVJ
         vhL2l8VoVjCFPDgQgtEYY/A8i0EYP1vAQVdA7/1yD111QKofYoPBEX1E/SAxmLY0c1dA
         GdLg7DMt78AkHlIiS5WD0QgYIH2j7Iz/Kcw1xYNwHrTUxKsumU4yCC4WTi1BK5OjnGlA
         V9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182260; x=1741787060;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yuyf18O1C9beAnXo5r2fUqE9fJzKJV0tNnseaOAJ1I=;
        b=RLllcC+55VeR74nwh0AJWr8lY+vRRP4cyNvLPfVZ/YYpLh9/UIB/RiB4cIK/qmgpMb
         /2QNCMzzdts3C7pnkCEDMUADqN3K0s8gL5TUcDAzeAS/fCtYqiFZZSdFhU/2g5bnGgQx
         dssgCa7CElpLJ6b4gUElqORrcnat5NSNX7HfpuXBH5yssv8c1hF16uOzw08XpFzA2Rc1
         2KEFp534ruuYmL8jHauZaC7vWyhaY0Glgrstl8LRZF9AzGq7qavGKOO5eWqTWqbQqZJp
         QfQioPVIIydxmLQEiZqQ6etPKjT6zdVAFPTREJQZdq7fs0+bxc64BCqH0x24zd2L2jSq
         TRaw==
X-Forwarded-Encrypted: i=1; AJvYcCU9kF7GfHSJJILh8H15vQ5kbsZNHcHYQiF2ZKEZhYyshVCnxKmrhom989xJMj4xvR7yAorPlkxpFgFUtck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZgakbba3w02AFJYkvrHoptMBa3B4QSZTkv2LEMnvd8yDQhYb
	mXmDnTLBbn6cF1GzB9OF8okRDQOUpr7flMHdbNFL6mtXupOjieDQvaSkXLdBFjs=
X-Gm-Gg: ASbGncu+mwmJDJTQKcNOKzWEmtLXCZQZjVCYNsfCwImtiQogaUWfCatqpwwS6cE+iYY
	rh+av0CJ3LrHpBNFIeHeccat6FM1umrbr2rJQth5u6aILstUdUdjAz+bYl3ZFYSBMCT0JlzyxU5
	TPGTRb1gY6S6TcihV7Tc0ZBXkArCSP9nLtPUTDw+Y5FmM1Xq8EsgalHjnnDN+QLHn38BxKtVTaL
	aJAwV3rm1QplP9kege/Trgw1FKbeC7BDnm6asYIpU5tDSX56cPW4UrA1E+XIui0cvJ8CJqwtxXC
	78mm45FoeabZQQSDywUF5f8Shlg/14XDc1HqQqrvgq1+mTpKxb4LLJE=
X-Google-Smtp-Source: AGHT+IHMWvLxl1WDyzDe67fQu7NHQ3gH4J0xuhCCrvkx6C7VPkprgfxVwtlDiiEjL9nH+nz8AmxYVQ==
X-Received: by 2002:a5d:60cc:0:b0:390:fd23:c145 with SMTP id ffacd0b85a97d-3911f7bda8fmr2112624f8f.36.1741182259933;
        Wed, 05 Mar 2025 05:44:19 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd430c2e9sm17754905e9.33.2025.03.05.05.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:44:19 -0800 (PST)
Message-ID: <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
Date: Wed, 5 Mar 2025 13:44:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: Ian Rogers <irogers@google.com>
References: <20250305083735.393333-1-irogers@google.com>
 <20250305083735.393333-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305083735.393333-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 8:37 am, Ian Rogers wrote:
> In the case of '{instructions,slots},faults,topdown-retiring' the
> first event that must be grouped, slots, is ignored causing the
> topdown-retiring event not to be adjacent to the group it needs to be
> inserted into. Don't ignore the group members when computing the
> force_grouped_index.
> 
> Make the force_grouped_index be for the leader of the group it is
> within and always use it first rather than a group leader index so
> that topdown events may be sorted from one group into another.
> 
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Testing on Arm seems ok, but presumably this doesn't change anything 
there because arch_evsel__must_be_in_group() is always false.

On x86 I ran into the topdown metrics not opening on cpu_core at all, so 
I'm not sure if I'm able to test that the original issue is fixed on my 
machine. From looking at the link the issue is that the ungrouped 
topdown event is "<not supported>", but I always see that regardless of 
grouping despite perf list saying it exists:

  $ perf list --unit cpu_core | grep -i topdown
   topdown-bad-spec OR cpu_core/topdown-bad-spec/     [Kernel PMU event]
   topdown-be-bound OR cpu_core/topdown-be-bound/     [Kernel PMU event]
   topdown-br-mispredict OR cpu_core/topdown-br-mispredict/[Kernel PMU 
event]
   topdown-fe-bound OR cpu_core/topdown-fe-bound/     [Kernel PMU event]
   topdown-fetch-lat OR cpu_core/topdown-fetch-lat/   [Kernel PMU event]
   topdown-heavy-ops OR cpu_core/topdown-heavy-ops/   [Kernel PMU event]
   topdown-mem-bound OR cpu_core/topdown-mem-bound/   [Kernel PMU event]
   topdown-retiring OR cpu_core/topdown-retiring/     [Kernel PMU event]
   topdown.backend_bound_slots
   topdown.bad_spec_slots
   topdown.br_mispredict_slots
   topdown.memory_bound_slots
        [TOPDOWN.MEMORY_BOUND_SLOTS. Unit: cpu_core]


  $ sudo perf stat -e topdown-retiring -- true
  Performance counter stats for 'true':
      <not counted>   cpu_atom/topdown-retiring/           (0.00%)
    <not supported>   cpu_core/topdown-retiring/


  $ sudo perf stat -e topdown-retiring -vvv -- true
Control descriptor is not initialized
Opening: topdown-retiring
------------------------------------------------------------
perf_event_attr:
   type                             10 (cpu_atom)
   size                             136
   config                           0xc2 (topdown-retiring)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8 = 3
Opening: topdown-retiring
------------------------------------------------------------
perf_event_attr:
   type                             4 (cpu_core)
   size                             136
   config                           0x8000 (topdown-retiring)
   sample_type                      IDENTIFIER
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
   disabled                         1
   inherit                          1
   enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off exclude_guest for PMU cpu_core
Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, 
falling back to no-inherit.
Warning:
topdown-retiring event is not supported by the kernel.


