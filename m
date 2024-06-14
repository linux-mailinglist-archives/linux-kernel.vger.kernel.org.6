Return-Path: <linux-kernel+bounces-214974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C35908CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F371F29256
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F617559;
	Fri, 14 Jun 2024 13:58:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088D15E90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373494; cv=none; b=iNWGobszbgfUfQiWmUvKVLM0oG7mRRGg5SRSiUa1kP1881X5LKe46pwT+sL8WpJDfsqOMFOeDcraol0QPvz2bnY30+CvygoVlCcfyocKqrLCMlrMnii9/AFcrYTfSWtBZHzEpvrtAAJhKZKbA5YySJIY3SE8kCA5ibrKRAHYmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373494; c=relaxed/simple;
	bh=yOBPQ8pHT89a1GRhRgbWfMfyP2gIvjF4sOr+SrKdnE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk1FkFHyS3IYIms2n0eSkLLLy+c1fBpd6McIGClZjlyBrxCaTNNKUKvx7FWqI3OlXBOFUY3LBVBZExURert8kxjBD+TScwXN8up0Hn1aJGbic16oliHlDck0WizeRkhWdiSR71en+tu2/lRAjRqpu/fBRug3C9hx8tumzX74CCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CC9FEC;
	Fri, 14 Jun 2024 06:58:36 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBD233F5A1;
	Fri, 14 Jun 2024 06:58:08 -0700 (PDT)
Message-ID: <8d3b27d9-1a58-455d-aaa7-ff9a7e49a0b2@arm.com>
Date: Fri, 14 Jun 2024 14:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/35] x86/resctrl: Make resctrl_arch_pseudo_lock_fn()
 take a plr
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
 <20240426150904.8854-22-Dave.Martin@arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240426150904.8854-22-Dave.Martin@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dave,

On 26/04/2024 16:08, Dave Martin wrote:
> From: James Morse <james.morse@arm.com>
> 
> resctrl_arch_pseudo_lock_fn() has architecture specific behaviour,
> and takes a struct rdtgroup as an argument.
> 
> After the filesystem code moves to /fs/, the definition of struct
> rdtgroup will not be available to the architecture code.
> 
> The only reason resctrl_arch_pseudo_lock_fn() wants the rdtgroup is
> for the CLOSID. Embed that in the pseudo_lock_region as a closid,
> and move the definition of struct pseudo_lock_region to resctrl.h.

> FYI: James Morse:
> 
>  * Review the v2 change below, in case there was any functional reason
>    for distinguishing "hw" closids here.
> 
> Changes in v2:
> 
>  * [Commit message only] Typo fix:
>    s/hw_closid/closid/g
> 
>    (The name "closid" is used in the code.  If there is a distinction
>    between "hardware" closids and resctrl closids, it doesn't seem to
>    be explicit in the naming elsewhere.)

Heh, this is a blast from the past!

In 2018 I was trying to get resctrl to convert 'closid' to 'hw_closid' using some
architecture provided helpers. This was an alternative way of folding the CDP code to hide
the differences between x86/arm64. I decided the fs/resctrl code was cleaner without it -
and arm64 can just juggle the numbers instead.


Thanks,

James

