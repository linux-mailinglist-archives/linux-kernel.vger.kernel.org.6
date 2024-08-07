Return-Path: <linux-kernel+bounces-277853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF994A74E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A8E1F25531
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E321E4EEE;
	Wed,  7 Aug 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HT9Y7P3l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9D1E4879
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031864; cv=none; b=rsT+BBY/b0xd6y4jKhgELMqQH2MGexjcVaYLEpnKlg8I+5gphNJcWbIzq7BqFPjMsMFO9NQMzsiaAjvVI+hQBNNOJp2IgO8DtMZOIDBvzE93K012YiEyzNjBhr05u+WfG2U9w4+VAST2i8jC4P/gjlC6YoRbU11vrdgGf/Yh1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031864; c=relaxed/simple;
	bh=ekbA+CBk1rCX5m1LXJaRRsfyTg0RWY0moQLq9XtTTSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F56c3NWq3zJH8QZT6R8cJ+I8zx47JZ8oM0hOr+kQsuZ5XPOQHPJJXhIWWpvDYZyunWIOBb+u/BD10oTkumTgglk6gpO5bLbW+OmnR4K28ScDqbYDC2Du/X0FeWIezssnRDa0pVlLiFQ8I0yqNr2ZCIXg/onGerpeZH3O3Z5vEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HT9Y7P3l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723031862; x=1754567862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ekbA+CBk1rCX5m1LXJaRRsfyTg0RWY0moQLq9XtTTSQ=;
  b=HT9Y7P3lyjMAyJUjRHlodLuOTAADogCrmJZCghuhMpnvXwh4InPg+ogD
   T+vbEyoP6uAIph9T2KOwJ8NUtarz3RvA2qPQOTC1x2Pu74dMqlPvXLMFb
   bC0bdmV7RPLxWpQmSIcsEV/nf7QKVaxKroEG2CrXrVuVumq22EbCm6Gjs
   nbKSMek89nS6pn0eOmcc7jkaHsIl0I2ARje5YFxqZ4dsTon0FrWyOngo7
   QtRuADdl3lPgJEBe1HTbclMcqJLl++zHhSXBv4bUaSvutW0bq6P3PpexW
   XjgigbxClDjJl5zA7hEXWHBLlFtQcPyqWc16TOzVKuU2Qs2dwdkClMOYj
   w==;
X-CSE-ConnectionGUID: VLY5vGadSG+qMa5/Pvm+Cg==
X-CSE-MsgGUID: fIANXNQBTKGvg+HgagNBag==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38551771"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="38551771"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 04:57:41 -0700
X-CSE-ConnectionGUID: zxsB1Y2KQF2TDcc8vqPBsQ==
X-CSE-MsgGUID: M1aydhkdQx+bP/W0gKWydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="87498630"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 04:57:42 -0700
Received: from [10.212.63.105] (kliang2-mobl1.ccr.corp.intel.com [10.212.63.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F07E420CFECD;
	Wed,  7 Aug 2024 04:57:39 -0700 (PDT)
Message-ID: <bfc6c316-99c5-4115-b8f1-83890d7adf38@linux.intel.com>
Date: Wed, 7 Aug 2024 07:57:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] perf report: Display the branch counter histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
 ak@linux.intel.com, eranian@google.com
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-7-kan.liang@linux.intel.com>
 <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
 <9b7c5c61-ef8c-43a8-bf1c-7ff32b4c8bee@linux.intel.com>
 <CAM9d7cgE=cDyeOyXrRZt53vKD=FRSqQRMz8=f=bGT-gzm2jjkg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cgE=cDyeOyXrRZt53vKD=FRSqQRMz8=f=bGT-gzm2jjkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Namhyung,

On 2024-08-06 7:29 p.m., Namhyung Kim wrote:
>>>>            57.55%            2.5M        0.00%           3             |A   |-   |                 ...
>>>>            25.27%            1.1M        0.00%           2             |AA  |-   |                 ...
>>>>            15.61%          667.2K        0.00%           1             |A   |-   |                 ...
>>>>             0.16%            6.9K        0.81%         575             |A   |-   |                 ...
>>>>             0.16%            6.8K        1.38%         977             |AA  |-   |                 ...
>>>>             0.16%            6.8K        0.04%          28             |AA  |B   |                 ...
>>>>             0.15%            6.6K        1.33%         946             |A   |-   |                 ...
>>>>             0.11%            4.5K        0.06%          46             |AAA+|-   |                 ...
>>>>             0.10%            4.4K        0.88%         624             |A   |-   |                 ...
>>>>             0.09%            3.7K        0.74%         524             |AAA+|B   |                 ...
>>> I think this format assumes short width and might not work
>>> well when it has more events with bigger width.  Maybe
>>> A=<n>, B=<n> ?
>> The purpose of "AAA" is to print a histogram here which can give the end
>> user a straightforward image of the distribution. The A=<n> may not be
>> that obvious.
> I understand your point.  But I think we need to provide an easily
> parse-able format at least for CSV output.

I guess we may use a similar method of perf script in patch 8.

By default, the histogram will be output.
If an user want a number, -v should be used.

$perf report --total-cycles --stdio -v

# Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
   Branch Counter                    >
# ...............  ..............  ...........  ..........
..............................  ..................>
#
            4.61%          116.4K        0.00%          91
        A=3+,B=1                     >
            4.28%          108.0K        0.00%          26
        A=1 ,B=1                     >
            3.42%           86.4K        0.00%          81
        A=3+,B=1                     >
            2.84%           71.6K        0.00%          50
        A=3+,B=-                     >
            2.65%           66.8K        0.00%         178
        A=3+,B=1          [__lock_acq>
            2.26%           57.1K        0.00%          44
        A=2 ,B=-                     >

Without -v,
$perf report --total-cycles --stdio

# Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
   Branch Counter                    >
# ...............  ..............  ...........  ..........
..............................  ..................>
#
            4.61%          116.4K        0.00%          91
      |AAA+|B+  |                    >
            4.28%          108.0K        0.00%          26
      |A   |B   |                    >
            3.42%           86.4K        0.00%          81
      |AAA+|B+  |                    >
            2.84%           71.6K        0.00%          50
      |AAA+|-   |                    >
            2.65%           66.8K        0.00%         178
      |AAA+|B+  |         [__lock_acq>
            2.26%           57.1K        0.00%          44
      |AA  |-   |                    >

What do you think?

Thanks,
Kan

