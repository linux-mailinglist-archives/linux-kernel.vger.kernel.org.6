Return-Path: <linux-kernel+bounces-211703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF69055B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BD5B21D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C417E91C;
	Wed, 12 Jun 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f47yGXyv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF021DFC6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203794; cv=none; b=m4erIHripDR7GyfSuS2c5I9iYwjwiaq1ITkqHBBKwGvC78/kHjZs1bpZe+RnlecCkOr1WwyZyrZh75RnRQTAW95DjCuQgi0IEc06y8EGz1SX9LCoSijwh7FsHQn/opFx/RncCZk98N1QwL4fdScgAF1Bm199i2TlH83QvvE/liw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203794; c=relaxed/simple;
	bh=Eia1SQ7Fh2LvoCGqiWI+qaZMBI765dvAVIkmD4DsMCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDPaMQv41E9xitdMcwiGLLwR8K1KQEvMrSWYK/Z5J2AXm8BSvk+MnctCFpewbtpJzQQgxMaqLJIcOuwKFyfX460CsO1Wz+wFpBJD8hnQnIgUZeurxNv6mhOVwzGhLuoKEBGhBrODE32KTf2z8bxr0rK236emc6+/pjIYjyBuARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f47yGXyv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718203793; x=1749739793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Eia1SQ7Fh2LvoCGqiWI+qaZMBI765dvAVIkmD4DsMCE=;
  b=f47yGXyvYBL+E9AFTa961wWvvn+ALw5MqyQwMWEnyn6KkvDH78IlqqyB
   vW+64N1Yk0bLBnnfSP8kWeCurZUCrNnr6YVPEmiOcTamuTTv71yzJ0eaE
   AY6iPcfHmBHl3cu3D3ZpFvdeMD8lO1mga1Rr5dFKiAdwaV9p/GvGXBPxZ
   /v5MTcip8ImXjYqabZ8+arON74sOQkpc6FhBfiCdkYcM6TV3PhgGdBXjm
   2uIjY9Jo6fwhHWjmZ7/euhH0uccYyfv2RYA9Pr1AeUa5rasqaAXjQivrZ
   x5DJ/C1KhLaQVPK/5dEPV5w4NQUbJFkBDLYDmULDZzeM72yJpi06o9wS1
   Q==;
X-CSE-ConnectionGUID: iNV0+oTVS7Ks6eKZPcd6FA==
X-CSE-MsgGUID: Zw33adbQQqWTw6kd0zhVFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25550569"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="25550569"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:49:52 -0700
X-CSE-ConnectionGUID: Ee3u1bY9TVyedS3HYcmsUw==
X-CSE-MsgGUID: d1UvAkCcQC2SIxMUqwFIXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44937061"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:49:52 -0700
Received: from [10.212.10.32] (kliang2-mobl1.ccr.corp.intel.com [10.212.10.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6F3B520B5703;
	Wed, 12 Jun 2024 07:49:51 -0700 (PDT)
Message-ID: <eb5d91d1-2898-45e0-a2d3-aa5c66155911@linux.intel.com>
Date: Wed, 12 Jun 2024 10:49:50 -0400
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <0f1ba5d8ecc62f774590077b2f88f5b64dd98452.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-10 6:40 p.m., Tim Chen wrote:
> On Mon, 2024-06-10 at 13:16 -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The unit control address of some CXL units may be wrongly calculated
>> under some configuration on a EMR machine.
>>
>> The current implementation only saves the unit control address of the
>> units from the first die, and the first unit of the rest of dies. Perf
>> assumed that the units from the other dies have the same offset as the
>> first die. So the unit control address of the rest of the units can be
>> calculated. However, the assumption is wrong, especially for the CXL
>> units.
>>
>> Introduce an RB tree for each uncore type to save the unit control
>> address and ID information for all the units.
>>
>> Compared with the current implementation, more space is required to save
>> the information of all units. The extra size should be acceptable.
>> For example, on EMR, there are 221 units at most. For a 2-socket machine,
>> the extra space is ~6KB at most.
>>
>> Tested-by: Yunying Sun <yunying.sun@intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/events/intel/uncore_discovery.c | 79 +++++++++++++++++++++++-
>>  arch/x86/events/intel/uncore_discovery.h | 10 +++
>>  2 files changed, 87 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index 9a698a92962a..ce520e69a3c1 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -93,6 +93,8 @@ add_uncore_discovery_type(struct uncore_unit_discovery *unit)
>>  	if (!type->box_ctrl_die)
>>  		goto free_type;
>>  
>> +	type->units = RB_ROOT;
>> +
>>  	type->access_type = unit->access_type;
>>  	num_discovered_types[type->access_type]++;
>>  	type->type = unit->box_type;
>> @@ -120,10 +122,59 @@ get_uncore_discovery_type(struct uncore_unit_discovery *unit)
>>  	return add_uncore_discovery_type(unit);
>>  }
>>  
>> +static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
>> +{
>> +	struct intel_uncore_discovery_unit *a_node, *b_node;
>> +
>> +	a_node = rb_entry(a, struct intel_uncore_discovery_unit, node);
>> +	b_node = rb_entry(b, struct intel_uncore_discovery_unit, node);
>> +
>> +	if (a_node->pmu_idx < b_node->pmu_idx)
>> +		return true;
>> +	if (a_node->pmu_idx > b_node->pmu_idx)
>> +		return false;
>> +
>> +	if (a_node->die < b_node->die)
>> +		return true;
>> +	if (a_node->die > b_node->die)
>> +		return false;
>> +
>> +	return 0;
> 
> Will it be better if the rb_node is sorted by id instead
> of pmu_idx+die?

The id and pmu_idx+die can all be used as a key to search the RB tree in
different places.

The id is the physical ID of a unit. The search via id is invoked when
adding a new unit. Perf needs to make sure that the same PMU idx
(logical id) is assigned to the unit with the same physical ID. Because
the units with the same physical ID in different dies share the same PMU.

The pmu_idx+die key is used when setting the cpumask. Please see
intel_uncore_find_discovery_unit_id() in the patch 2. Perf wants to
understand on which dies the given PMU is available.

Since different keys can be used to search the RB tree, I think one of
them has to traverse the whole tree. At the stage of adding a new unit,
the tree is not complete yet. It minimizes the impact of the O(N)
search. So I choose the pmu_idx+die rather than id.

Also, the driver only does once to build the tree and set the cpumask at
driver load time. I think the O(N) should be acceptable here.

Thanks,
Kan

> 
> Then it will be faster for uncore_find_unit() to run in
> O(log(N)) instead of O(N).  Right now it looks like we
> are traversing the whole tree to find the entry with the
> id.
> 
> Tim
> 
>> +}
>> +
>> +static inline struct intel_uncore_discovery_unit *
>> +uncore_find_unit(struct rb_root *root, unsigned int id)
>> +{
>> +	struct intel_uncore_discovery_unit *unit;
>> +	struct rb_node *node;
>> +
>> +	for (node = rb_first(root); node; node = rb_next(node)) {
>> +		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>> +		if (unit->id == id)
>> +			return unit;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
> 
> 

