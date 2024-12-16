Return-Path: <linux-kernel+bounces-448237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF919F3D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1B3188D8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353941D61BF;
	Mon, 16 Dec 2024 22:16:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB491D1730;
	Mon, 16 Dec 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387375; cv=none; b=cxDLvEBbfqoOZSn/XvnpeC2TDndtFcYiEwqjrl3EDb36ZKowE0vNHFMwD+mwYMG4wzlx/oA1UrCKLJL8XoKwWKyNzPaSxT63Ibw030aAOHyuAFE3ly1UIRepoReU2Wu3KaZlgvWT51LjnRsJXRRab4XP56+yt4KEvvv0j4kpUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387375; c=relaxed/simple;
	bh=MHXbgCt5iM3Lmiq1ccpeu5zZNvv3KDoyJh4e9VGd7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji56BaLHFXY/GvDODwXMOLShGOfCuNsB9bxbAd/8uC6aUPweC79Pr4/m75ERAbSj1XsanRKRzVcvAwHpEZQ/vQY6zA8QUz2dAWOg52kn5Ggfyi1ijYSEeoHCXTDmOayKprNPoxdkXcqBoV9tWLkr1UY4wP3yjsODSt2kq/N1RwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A81113E;
	Mon, 16 Dec 2024 14:16:40 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6B13F58B;
	Mon, 16 Dec 2024 14:16:06 -0800 (PST)
Date: Mon, 16 Dec 2024 23:15:13 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z2CmcelSy89NULtz@arm.com>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
 <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>

On Thu, Dec 12, 2024 at 12:21:00PM +0530, Viresh Kumar wrote:
> On 06-12-24, 13:55, Beata Michalska wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 04fc786dd2c0..70df2a24437b 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
> >  show_one(scaling_min_freq, min);
> >  show_one(scaling_max_freq, max);
> >  
> > -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> > +__weak int arch_freq_get_on_cpu(int cpu)
> >  {
> > -	return 0;
> > +	return -EOPNOTSUPP;
> 
> I did suggest not doing this as it may not be acceptable.
> 
> https://lore.kernel.org/all/CAKohpokFUpQyHYO017kOn-Jbt0CFZ1GuxoG3N-fenWJ_poW=4Q@mail.gmail.com/
>
My bad as I must have misinterpreted that message. Although I am not entirely
sure why this might be unacceptable as it is not such uncommon approach to use
signed int space to cover both: expected positive value as well as potential
error code case failure.
Enabling the new attribute for all is an option, tough not entirely compelling
one as exposing a feature that is known not to be supported seems bit
counterintuitive. On the other hand using cpufreq driver flags won't help much
as the support for the new attrib is platform-specific, not driver-specific.

---
BR
Beata
> -- 
> viresh

