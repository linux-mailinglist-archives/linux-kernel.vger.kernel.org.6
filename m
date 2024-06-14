Return-Path: <linux-kernel+bounces-214972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3069908CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446ACB2440E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AFC2C6;
	Fri, 14 Jun 2024 13:58:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDABA38
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373482; cv=none; b=HlRatek7b1pCFWDXFP/jYedI3Z7HXrZskie2GL3QDNeWKqnrpdQ+JHO/dDcw3LA4btXVxg3n523NirDxKyBf1B6HGosFpSoVcbVgXFOBb0f8ZqIjFgQwYzASSaqkZTGPTAo0AXQ6EjnRm8Ic4PS2CvYCQTas3+q4fc8809doOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373482; c=relaxed/simple;
	bh=yDvO26kar2hp3dxA/NNKku9cZonyj7JnpLHyF9Ib5gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/uRJ59Y9OLSFOlaD3anCecFtqX69cIvsXzHXlEHCqJCX74cI7cUpkP7+jGCr8CH/LCj0rEi93xp/Jrm15ZKbytthuvk4Q2nvrWuJ5MuJO/n8uhc7wSgdPYpCYWnv3GACf6+E7iwccAJcCYlNQBPSXpaD1+s2L+mMe+echQdSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1EF31480;
	Fri, 14 Jun 2024 06:58:24 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634763F8A4;
	Fri, 14 Jun 2024 06:57:54 -0700 (PDT)
Message-ID: <af829bf9-28b2-4b3d-9252-075201689052@arm.com>
Date: Fri, 14 Jun 2024 14:57:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
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
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-19-james.morse@arm.com>
 <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 09/04/2024 04:23, Reinette Chatre wrote:
> On 3/21/2024 9:50 AM, James Morse wrote:
>> resctrl_arch_mon_event_config_write() writes a bitmap of events provided
>> by user-space into the configuration register for the monitors.
>>
>> This assumes that all architectures support all the features each bit
>> corresponds to.
>>
>> MPAM can filter monitors based on read, write, or both, but there are
>> many more options in the existing bitmap. To allow this interface to
>> work for machines with MPAM, allow the architecture helper to return
>> an error if an incompatible bitmap is set.
>>
>> When valid values are provided, there is no change in behaviour. If
>> an invalid value is provided, currently it is silently ignored, but
>> last_cmd_status is updated. After this change, the parser will stop
>> at the first invalid value and return an error to user-space. This
>> matches the way changes to the schemata file are made.
>>
> 
> Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
> MPAM would use it to set what the valid values are. With that done,
> when user space provides a value, mon_config_write() compares user
> provided value against mbm_cfg_mask and will already return early
> (before attempting to write to hardware) with error
> if value is not supported. This seems to accomplish the goal of this
> patch?

Aha, this is done in mon_config_write(), not mbm_config_write_domain(). I'd missed that.
I'll drop this patch.

Thanks!

James

