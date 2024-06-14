Return-Path: <linux-kernel+bounces-214973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B289D908CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32461C254DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F5EED3;
	Fri, 14 Jun 2024 13:58:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E725EAD4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373487; cv=none; b=dDDafA9LEBf61kOB7PcBtNOm64wYpWCX/knJv/FYVuvvfbo14TMYxTglk3Ir/y6R36ormJw7KBWar71dS+fypg/thVmSHcjTZxohPwE+Lw91zHw/JU0G6yhxraY9/Uf2AXC4mtA7Y3qXeDRG/dAXgPfTi36dZyG2WqEaBfeZCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373487; c=relaxed/simple;
	bh=Mic4ahtg2YdkV2IbtpTn74zifuut2aA5xwcJx3NUCNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAMrXiCsWk4+urq/qcXsdn2kMBBEf7tY3+Ln1+kEYHtL2xh/J+fOYcm6jYk77gndQpfYOoD5s0eupb2JsbxLvJu3qvqvIn2ukiY+rg/o4lDyizsdDpgI/tUbNHs7W2/5nSTyDQRui0IB1wJvV7/5cFbTZbJte6+QKom1W96iy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71879FEC;
	Fri, 14 Jun 2024 06:58:29 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796A73F5A1;
	Fri, 14 Jun 2024 06:57:58 -0700 (PDT)
Message-ID: <6b863124-d1ce-429f-b1b6-73fc48978a6d@arm.com>
Date: Fri, 14 Jun 2024 14:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/35] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
Content-Language: en-GB
To: Dave Martin <Dave.Martin@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, "Shaopeng Tan (Fujitsu)"
 <tan.shaopeng@fujitsu.com>, baolin.wang@linux.alibaba.com,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
 <20240426150904.8854-17-Dave.Martin@arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240426150904.8854-17-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 26/04/2024 16:08, Dave Martin wrote:
> From: James Morse <james.morse@arm.com>
> 
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.


>  * Reword comments to avoid being overly arch-specific.
> 
>    Is the _content_ of mbm_cfg_mask arch-independent?

This comes from the mbm_total_bytes_config, nothing in Documentation/arch/x86/resctrl.rst
says this is AMD specific, so it can be assumed to be defined by resctrl, but depending on
some hardware feature.

I'm not sure we can make this retroactively platform specific.


Thanks,

James

