Return-Path: <linux-kernel+bounces-170877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB188BDD31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF9B281CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60931442F4;
	Tue,  7 May 2024 08:31:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CC143C6C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070717; cv=none; b=V+TVKIPZvocIt11Uay0qqTLenyF9fmkgglcXX7Hkv1wNOcDeIH0Ad17OgYkuMY8HAoKj3ivE26vABNjNFhlp6QOU19em8DSv+htDrMakpSmKrG3i5jIcfpvi5LeB/OYK7WPaDf7WrlmPzYN123WWD2/0XXECD1yg1IAXxK5EYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070717; c=relaxed/simple;
	bh=rxjgmTJY356gbfLe+hoAimBuO98HddJcAQLBx5Oylc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG5iUmPLniM2YduPb6WY5vMuYinyGJFPjXwE8TXHYx8BxS8GEYoQ5xLVzVMn9zbliWqhtvAd6dVKBAYtDoeO6TeSinLZUBZ7gkE9SeiaC8qera+D22Mxm8LONV4aQCsyg2TmOfp6xBHihv4ay3aJFydRTXkkOU7K3BRht9S3CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81869106F;
	Tue,  7 May 2024 01:32:18 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC0D53F793;
	Tue,  7 May 2024 01:31:49 -0700 (PDT)
Date: Tue, 7 May 2024 10:31:40 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <Zjnm7LzrYLCbz-XX@arm.com>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
 <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
 <ZiuF0zgqkMlmkEZz@arm.com>
 <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>

On Mon, Apr 29, 2024 at 02:55:15PM +0530, Viresh Kumar wrote:
> On 26-04-24, 12:45, Beata Michalska wrote:
> > It seems that we might need to revisit the discussion we've had around
> > scaling_cur_freq and cpuinfo_cur_freq and the use of arch_freq_get_on_cpu.
> > As Vanshi has raised, having both utilizing arch specific feedback for
> > getting current frequency is bit problematic and might be confusing at best.
> > As arch_freq_get_on_cpu is already used by show_scaling_cur_freq there are not
> > many options we are left with, if we want to kee all archs aligned:
> > we can either try to rework show_scaling_cur_freq and it's use of
> > arch_freq_get_on_cpu, and move it to cpuinfo_cur_freq, which would align with
> > relevant docs, though that will not work for x86, or we keep it only there and
> > skip updating cpuinfo_cur_freq, going against the guidelines. Other options,
> > purely theoretical, would involve making arch_freq_get_on_cpu aware of type of
> > the info requested (hw vs sw) or adding yet another arch-specific implementation,
> > and those are not really appealing alternatives to say at least.
> > What's your opinion on this one ?
> 
> Hi Beata / Vanshidhar,
> 
> Lets forget for once what X86 and ARM may have done and think about it
> once again. I also had a chat with Vincent today about this.
> 
> The documentation says it clearly, cpuinfo_cur_freq is the one
> received from hardware and scaling_cur_freq is the one requested from
> software.
> 
> Now, I know that X86 has made both of them quite similar and I
> suggested to make them all aligned (and never received a reply on my
> previous message).
> 
> There are few reasons why it may be worth keeping the definition (and
> behavior) of the sysfs files as is, at least for ARM:
> - First is that the documentation says so.
> - There is no point providing the same information via both the
>   interfaces, there are two interfaces here for a reason.
> - There maybe tools around which depend on the documented behavior.
> - From userspace, currently there is only one way to know the exact
>   frequency that the cpufreq governors have requested from a platform,
>   i.e. the value from scaling_cur_freq. If we make it similar to
>   cpuinfo_cur_freq, then userspace will never know about the requested
>   frequency and the eventual one and if they are same or different.
> 
> Lets keep the behavior as is and update only cpuinfo_cur_freq with
> arch_freq_get_on_cpu().
> 
> Makes sense ?
>
First of all - apologies for late reply.

It all makes sense, though to clarify things up, for my own benefit, and to
avoid any potential confusion ....

Adding arch_freq_get_on_cpu to cpuinfo_cur_freq does seem to be the right
approach - no argue on this one. Doing that though means we need a way to
skip calling arch_freq_get_on_cpu() from show_scaling_cur_freq(), to avoid
having both providing the same information when that should not be the case.
In the initial approach [1], that was handled by checking whether the cpufreq
driver supports 'get' callback (and thus cpuinfo_cur_freq). In case it didn't,
things remained unchanged for scaling_cur_freq. That does not seem to be a viable
option though, as there are at least few drivers, that will support both:
cpuinfo_cur_freq alongside scaling_cur_freq (+ APERF/MPERF) and for those,
we would hit the initial problem of both relying on arch_freq_get_on_cpu.
So I guess we need another way of avoiding calling arch_freq_get_on_cpu
for show_scaling_cur_freq (and most probably avoid calling that one for
cpuinfo_cur_freq). Quick idea on how to not bring arch specificity into
cpufreq generic code would be to introduce a new flag for cpufreq drivers though
that seems a bit stretched. Will ponder a bit about that but in the meantime
suggestions are more than welcomed.

Aside: I will most probably send the changes separately from this series to not
mix things any further.

---
[1] https://lore.kernel.org/all/20230606155754.245998-1-beata.michalska@arm.com/
---
BR
Beata


> -- 
> viresh

