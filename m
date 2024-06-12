Return-Path: <linux-kernel+bounces-212152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2B905BED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E92BB224C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E49D82D72;
	Wed, 12 Jun 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxHFU93b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D09374D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220304; cv=none; b=abJyy26NnltvpXA7JjC7Tb/POIB07hZtzRhxuhlp+Kqg3ptWurZlt54PSQv60gWbNXfP9+Ft8oEFTRcSuTCgiVrYHfhz3uNdXxIp7oLkDdKWI1cArVtLsKF6fBAUgXipZ/g0uULpNC5vEQBp0OMSGl2q1vGuL0JkDPVV+rm8ueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220304; c=relaxed/simple;
	bh=41SN8wSL+X2t9A9vIBcjZFbmHv4FF5tpD1VJTgb0HSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1W0ejnQoa8iT0ItIdvyHdnb/ZFt8wMsyN0+cNzYrzhLvoBACZtoEJutzA9D/4o8e4L+HVOP6GiGOSvz7NojJIN89dI8WqwYJ2gqhe0bGwZLT1/8eiDnIYWuXvV7GfNDqpqpF49Lx5MV4zEYPW7kNUM5TifGN1aP/dxAOeeJJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxHFU93b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718220303; x=1749756303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=41SN8wSL+X2t9A9vIBcjZFbmHv4FF5tpD1VJTgb0HSI=;
  b=XxHFU93b66BCkVpu//UP/eG33VDVhCUnlrtinz851eoZGzidvV8hfEql
   ieFFuaFAr7ESybruyjuwfAI+IGtpXKOr+imdc5RE6j5ijp3ShcJH+C9P+
   rsR8QOnQ7MKgSI2wl2ryb+oYFXMK7oAPNzQYGX5ExbMAMMurHPelIFsmp
   D0sTwUjEwXBy7SykhRr14m9fTF9PSHrG5qj94ns4gMv0PgKpQpUajSUPH
   f9q/XgPWkkiqIxsKo6kXhyuq9/CQdUg7ItXOsIblvQQqFKHpyFdavajnj
   +6UxttNalU1oPczNDViE4nfZYBK0y18jAMrcaRBR9YfYjPnDIUb892fZx
   w==;
X-CSE-ConnectionGUID: 49c0n7VzS+eu9nwvglXlgA==
X-CSE-MsgGUID: BBZG9dEkQvCOz71L7uC83A==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14808352"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="14808352"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:25:03 -0700
X-CSE-ConnectionGUID: Hf7lEjKRSQO/8ACZ7OTJzQ==
X-CSE-MsgGUID: DS/EaCFbRbi00biEsCDEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44280121"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 12:25:02 -0700
Received: from [10.212.90.179] (kliang2-mobl1.ccr.corp.intel.com [10.212.90.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4C89220B5703;
	Wed, 12 Jun 2024 12:25:01 -0700 (PDT)
Message-ID: <ab67aa4d-bc58-4c80-a95b-6bf21fb5417f@linux.intel.com>
Date: Wed, 12 Jun 2024 15:25:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf/x86/uncore: Save the unit control address of all
 units
To: Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 eranian@google.com, ak@linux.intel.com, yunying.sun@intel.com
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
 <20240610201619.884021-2-kan.liang@linux.intel.com>
 <0f1ba5d8ecc62f774590077b2f88f5b64dd98452.camel@linux.intel.com>
 <eb5d91d1-2898-45e0-a2d3-aa5c66155911@linux.intel.com>
 <47fad008a152957c87e9846fdbf40746b6e2871a.camel@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <47fad008a152957c87e9846fdbf40746b6e2871a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-12 1:33 p.m., Tim Chen wrote:
> On Wed, 2024-06-12 at 10:49 -0400, Liang, Kan wrote:
>>
>>
>> The id and pmu_idx+die can all be used as a key to search the RB tree in
>> different places.
>>
>> The id is the physical ID of a unit. The search via id is invoked when
>> adding a new unit. Perf needs to make sure that the same PMU idx
>> (logical id) is assigned to the unit with the same physical ID. Because
>> the units with the same physical ID in different dies share the same PMU.
> 
> This info about having same physical ID implies the same PMU
> is worth mentioning in a comment and will be quite helpful in
> understanding the rb-tree organization.
>

Sure I will update the description to explain the choice. Thanks.

Thanks,
Kan

> Thanks.
> 
> Tim
>>
>> The pmu_idx+die key is used when setting the cpumask. Please see
>> intel_uncore_find_discovery_unit_id() in the patch 2. Perf wants to
>> understand on which dies the given PMU is available.
>>
>> Since different keys can be used to search the RB tree, I think one of
>> them has to traverse the whole tree. At the stage of adding a new unit,
>> the tree is not complete yet. It minimizes the impact of the O(N)
>> search. So I choose the pmu_idx+die rather than id.
>>
>> Also, the driver only does once to build the tree and set the cpumask at
>> driver load time. I think the O(N) should be acceptable here.
>>
>> Thanks,
>> Kan
> 

