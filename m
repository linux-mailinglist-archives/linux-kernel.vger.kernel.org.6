Return-Path: <linux-kernel+bounces-328699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC04978785
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3694A289FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7712C552;
	Fri, 13 Sep 2024 18:07:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200E12CDBA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250869; cv=none; b=X1/1w9c4Vb6plf/8Uy+wXFO63H2baJpusUS72N4e+fxmttBW8FuYItOIgNuWRwbN2TUi1OGrlWBkeIbaWf2b49E8pklIRxijnGxqZ32OLlVuxE2eZQe9ipZe93FHwSOYMq/0QeWNKORQuLTRUzcLER/Y6zwv2WuhLilmI+M0SkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250869; c=relaxed/simple;
	bh=8EfGJnTNI4yWLL3tzGnT5AcRP0e1thHNsip9GYzI3b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kt85SlC93vm6dnm3uWp/S37VpGxoCCbq8S+u3XWdFX2kbxfXUQDvSK3hdLzNBU12tyIlB7L/I3n1FJv8asFDJ1IB9qbtnBJDrBUYuHEgNAKqZNrLJ4OGlDs7Rd3Qhv43dhIhIy61d9v2v7afTQ0N9oRS1wjnQNH2D2T1lCORQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F1713D5;
	Fri, 13 Sep 2024 11:08:15 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B7423F64C;
	Fri, 13 Sep 2024 11:07:43 -0700 (PDT)
Message-ID: <8b7ffd4b-6e04-4c3a-bcc4-33d72139414f@arm.com>
Date: Fri, 13 Sep 2024 19:07:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/39] x86/resctrl: Generate default_ctrl instead of
 sharing it
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-9-james.morse@arm.com>
 <72e612b3-0840-4cbf-b5fb-85ed3be4cfc8@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <72e612b3-0840-4cbf-b5fb-85ed3be4cfc8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 14/08/2024 05:00, Reinette Chatre wrote:
> On 8/2/24 10:28 AM, James Morse wrote:
> 
>> +/**
>> + * resctrl_get_default_ctrl() - Return the default control value for this
>> + *                              resource.
>> + * @r:        The resource whose default control type is queried.
>> + */
>> +static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
>> +{
>> +    switch (r->schema_fmt) {
>> +    case RESCTRL_SCHEMA_BITMAP:
>> +        return BIT_MASK(r->cache.cbm_len) - 1;
>> +    case RESCTRL_SCHEMA_PERCENTAGE:
>> +        return 100u;
>> +    case RESCTRL_SCHEMA_MBPS:
>> +        return r->membw.max_bw;
>> +    }
>> +
>> +    return WARN_ON_ONCE(1);
>> +}
>> +

> I am concerned where this is headed. Since RESCTRL_SCHEMA_PERCENTAGE remains
> in use when resctrl is mounted with mba_MBps the default cannot always
> be 100u (it should be MBA_MAX_MBPS when software controller is active).

I agree - and we can certainly tidy that up.
But today when mba_sc is enable the bandwidth_gran and min-bandwidth files both report
'10' (%?), which isn't particularly meaningful.
I think these should both report '1'. There will be a minimum bandwidth, buts it not
something that can be discovered by the mba_sc code.

This was an oversight because the mba_sc mode doesn't update default_ctrl or the format
strings - it hijacks the parsing elsewhere. The default_ctrl isn't visible to user-space,
the value used when reading the schema file comes from the mbps_val array, instead of
ctrl_val.


Some of this has been booted over the horizon - I'll add straightening out the mba_sc
behaviour here to that list.



Thanks,

James

