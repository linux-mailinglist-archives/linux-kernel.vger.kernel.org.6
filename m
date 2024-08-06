Return-Path: <linux-kernel+bounces-276950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8A949A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F9E1F2317F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68815F409;
	Tue,  6 Aug 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrW5R93f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06E82863
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980228; cv=none; b=ThJLyPBFuGvfQbmikkozWVPe5t/SLQIyCC5Dsl/MSjSSJoP31W7Q6tGi0pXkl+OqJSZ1k/rcS81fUffSdDWFhRG+bG6emkI65+Qnq798WG9ftbP4NJ4JOBa305J3jdJZtzwxCMO45CivA065jwISzpSH0Srs/VHTCRL5bs4voqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980228; c=relaxed/simple;
	bh=iGfua2WZ8ZPalx5KnQbpkjx/XN2O6toZy/TytvDzeaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BSSMJPC8efsF1od4Vnh+ax1AeUejOltVGmlHTHUrpx+oELDDqZQALsnFqGDcJO9/kVr5b9tVrbNUot5k9H8Q5RtIsB6iPGCQ15KdBPkHHg1KR7DTTcRudgWhVdNw3WfRrw/h3J81CU+HtU5qCvBfRnId23i3Ipcb6vptVaKeGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrW5R93f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722980227; x=1754516227;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=iGfua2WZ8ZPalx5KnQbpkjx/XN2O6toZy/TytvDzeaA=;
  b=NrW5R93f23bUNMhQBLlubymud6Dhke93SmwKX8Gx8uLE7PF42t0HiEFT
   0HYq4vEyskTppOYvi0pegdlml7EzL1l5piF9Idx3QADwoczYDcMptQYxm
   EmLoHTOMo26vSdFGF80bkFzX5ZUTt4OVyp23TxiV70Rdr0US6ArS+GgMQ
   kyhOn39YceUaOmknosII75VNzCZjF4fwAobeQisUJPS9wFgcB9kwTGeUj
   DA3+vpipz1VoPkSDmeYdPPZXdFM25JmeGWMkEgfXBvzPKsAfChk9w/ygm
   ixgDmiXKHxdGPqWcUHUcAvX82wgvMGSVXNR5nm8Zwbc1v54DOjHNTamjH
   Q==;
X-CSE-ConnectionGUID: tHYXoZoGSdCCI2pgR7cozA==
X-CSE-MsgGUID: hzkY4jOgQhqjudeW4gFg5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38479469"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38479469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 14:37:06 -0700
X-CSE-ConnectionGUID: XMAwgPXEQv6XHRk+XHrNHg==
X-CSE-MsgGUID: 2bs4Naj+Qo6u7tRwlXBHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56590134"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 14:37:06 -0700
Received: from [10.212.84.25] (kliang2-mobl1.ccr.corp.intel.com [10.212.84.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8D10920CFECD;
	Tue,  6 Aug 2024 14:37:04 -0700 (PDT)
Message-ID: <20ba40ec-7e2a-4a0d-b9d3-fe8e1256fbb8@linux.intel.com>
Date: Tue, 6 Aug 2024 17:37:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] perf annotate: Display the branch counter histogram
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, eranian@google.com
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-8-kan.liang@linux.intel.com>
 <Zq1K-YM4JoEQwov1@tassilo>
 <c634b005-c382-48cc-bf54-6f570687d5c0@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c634b005-c382-48cc-bf54-6f570687d5c0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andi,

On 2024-08-06 10:42 a.m., Liang, Kan wrote:
> 
> 
> On 2024-08-02 5:09 p.m., Andi Kleen wrote:
>>> Display the branch counter histogram in the annotation view.
>>>
>>> Press 'B' to display the branch counter's abbreviation list as well.
>>>
>>> Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
>>> 4000 Hz, Event count (approx.):
>>> f3  /home/sdp/test/tchain_edit [Percent: local period]
>>
>> Can we output the abbreviation mappings here in the header too? 
>> Otherwise it will be hard to use.
> 
> If so, the 'B' will be redundant. I will remove the 'B' and move the
> abbreviation mappings in the header.
> 

Actually, the output here is in the TUI mode, not --stdio mode.

There is only one single title line for the TUI mode.
It's filled out quickly. As you can see in the example, the number of
the "Event count (approx.)" is missed as well. The abbreviation mappings
will never get a chance to be output.

For the TUI mode, usually shortcut keys are used to display aux
information. The 'B' in this patch follows the existing behavior.

For the --stdio mode, perf should print out the abbreviation mappings in
the header. I think the --stdio mode is the one used by other tools to
parse the result, right? The previous patch 6 (--stdio mode) does show
everything in the header.

Is there a use-case in the TUI mode that has difficulties utilizing the
shortcut 'B'? If yes, could you please elaborate?

Thanks,
Kan

