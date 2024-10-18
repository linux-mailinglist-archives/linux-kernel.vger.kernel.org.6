Return-Path: <linux-kernel+bounces-372087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D89A4450
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC66B1C22341
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6866204080;
	Fri, 18 Oct 2024 17:07:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7920400C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271249; cv=none; b=M//pOw6wkK90F2bPuIvToJHy3L14oT9Fry+TlPuWFwkuhX/K3vZBYkCJkN7i35Vq0ze2F+60FJCN5qGmisU4E1vdzDHs3O4NCXl5WjjFZFQos3lEDLBXNEUeAwf4BX+b4VnuhzuoFF+PlJ6U4LnF65mR4uPmH1ivRnD6jeA6JvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271249; c=relaxed/simple;
	bh=nyJcBtVOQUIERqDCjN4CNZkSIwDbjHwudrH+HgGuNJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuOlykOiWK5mRKyZSx2Qqy+4tifHeKJjJ4hXvXb1bUFNupqcFtvQnKJiXAUi9zp7opm+RNOgHFG8CU0GHsL+n0kGHXdY/TzdX2OiNDxfVBFdfycjs2JHBcepArjpjWdlcc83bs6ftP4SLlFi0abHz8p0/oeCeZ/hp7XR7xIsORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B392915BF;
	Fri, 18 Oct 2024 10:07:56 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401733F528;
	Fri, 18 Oct 2024 10:07:23 -0700 (PDT)
Message-ID: <d48e65cc-3c7b-4a93-80a2-fa0d676e88c4@arm.com>
Date: Fri, 18 Oct 2024 18:07:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/40] x86/resctrl: Use schema type to determine how to
 parse schema values
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-5-james.morse@arm.com>
 <Zw73nIUgPPQSa_ug@agluck-desk3.sc.intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <Zw73nIUgPPQSa_ug@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 16/10/2024 00:15, Tony Luck wrote:
> On Fri, Oct 04, 2024 at 06:03:11PM +0000, James Morse wrote:
>> +static ctrlval_parser_t *get_parser(struct rdt_resource *r)
>> +{
>> +	switch (r->schema_fmt) {
>> +	case RESCTRL_SCHEMA_BITMAP:
>> +		return &parse_cbm;
>> +	case RESCTRL_SCHEMA_RANGE:
>> +		return &parse_bw;
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> Is it really worth making this a helper function? It's only
> used once.

Moved. This was just to avoid bloating the caller with boiler-plate.


>> +
>>  /*
>>   * For each domain in this resource we expect to find a series of:
>>   *	id=mask
>> @@ -204,6 +225,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  static int parse_line(char *line, struct resctrl_schema *s,
>>  		      struct rdtgroup *rdtgrp)
>>  {
>> +	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
> 
> No check to see if get_parser() returned NULL.

No - but you must have passed it a non-existant enum value for that to happen, so we're
already in memory corruption territory. (I probably should have made get_parser()
WARN_ON_ONCE() when returning NULL)


>>  	enum resctrl_conf_type t = s->conf_type;
>>  	struct resctrl_staged_config *cfg;
>>  	struct rdt_resource *r = s->res;
>> @@ -235,7 +257,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
>>  		if (d->hdr.id == dom_id) {
>>  			data.buf = dom;
>>  			data.rdtgrp = rdtgrp;
>> -			if (r->parse_ctrlval(&data, s, d))
>> +			if (parse_ctrlval(&data, s, d))
>>  				return -EINVAL;
> 
> Without the helper this could be:
> 
> 			switch (r->schema_fmt) {
> 			case RESCTRL_SCHEMA_BITMAP:
> 				if (parse_cbm(&data, s, d))
> 					return -EINVAL;
> 				break;
> 			case RESCTRL_SCHEMA_RANGE:
> 				if (parse_bw(&data, s, d))
> 					return -EINVAL;
> 				break;
> 			default:
> 				WARN_ON_ONCE(1);
> 				return -EINVAL;
> 			}

I'd prefer the switch statement to have no default so that it triggers a compiler warning
when future enum entries are added. This way the compiler can find cases where a new
schema format missed a bit - it doesn't need booting the result on hardware to trigger a
warning.

To avoid 'break' in a loop not breaking out of the loop, and to avoid bloating the loop
I've kept the function pointer so the non-existant enum case is handled with the rest of
the errors at the top of the function:
|        /* Walking r->domains, ensure it can't race with cpuhp */
|        lockdep_assert_cpus_held();
|
|        switch (r->schema_fmt) {
|        case RESCTRL_SCHEMA_BITMAP:
|                parse_ctrlval = &parse_cbm;
|                break;
|        case RESCTRL_SCHEMA_RANGE:
|                parse_ctrlval = &parse_bw;
|                break;
|        }
|
|        if (WARN_ON_ONCE(!parse_ctrlval))
|                return -EINVAL;
|
|        if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&


Thanks,

James

