Return-Path: <linux-kernel+bounces-521484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77964A3BDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92730188D11B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180D1DFE23;
	Wed, 19 Feb 2025 12:26:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672925757;
	Wed, 19 Feb 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967984; cv=none; b=maZIcqDCPIZ9ikgcSMFj1AuyuHCxEqpV+lSC5pYpS82p2l86IWQYPR4o4PFTlmeQnDdMvbO34RKIySAg9+7FhpqmCbIbblicv27a9gF+fcfvZ8EbNK4nCEUPgs+dJ/QdRRxk046kLNdynF1+ntKc5LpXU4406RpIxjm54Itz36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967984; c=relaxed/simple;
	bh=xS1nu3DaFP29JPrP0N+jCTLpQeeROt9QV74r9Kk7h5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdwO8b/HWt6QiCeCmVATrZat5zYvbhvquIbVVAxoM12Cwr+t4q0AGpHrmEQnCJ0p71OBI89OGnwy/gVsrD17ztS5HkdheEjfbZXXwamOWK06/KkE05G7lEZtptwA9ToKOA3TtS5hjI/YibSGzBI1HX6Q9Vk++GFLu9c1vPXGU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47EFF1682;
	Wed, 19 Feb 2025 04:26:40 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25E23F6A8;
	Wed, 19 Feb 2025 04:26:17 -0800 (PST)
Date: Wed, 19 Feb 2025 12:26:15 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, Peter Newman <peternewman@google.com>,
	"Moger, Babu" <bmoger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Message-ID: <Z7XN5wowNkem+Mci@e133380.arm.com>
References: <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
 <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
 <81e3993d-2f00-424b-8cf4-341c321149cd@intel.com>
 <698577f3-00c2-496c-b787-506cef589d26@amd.com>
 <486ea907-a64c-459f-9210-e25f89f7ad38@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486ea907-a64c-459f-9210-e25f89f7ad38@intel.com>

Hi Reinette,

On Tue, Feb 18, 2025 at 01:29:09PM -0800, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/18/25 11:32 AM, Moger, Babu wrote:
> > Hi Reinette,
> > 
> > On 2/18/25 12:14, Reinette Chatre wrote:
> >> Hi Babu,
> >>
> >> On 2/18/25 7:39 AM, Moger, Babu wrote:
> >>  
> >>> 3. Use the actual events instead of flags based on the below comment.
> >>>
> >>> https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/
> >>>
> >>>  Something like this.
> >>>  # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
> >>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>>
> >>>  Are we ready to go with this approach? I am still not clear on this.
> >>>
> >>>  Reinette, What do you think?
> >>
> >> I was actually expecting some push back or at least discussion on this interface
> >> because the braces seem difficult to parse when compared to, for example, using
> > 
> > I am yet to work on it. Will work on it after confirmation.
> > 
> > Here is the output from a system with 12 domains. I created one "test" group.
> > 
> > Output is definitely harder to parse for human eyes.
> > 
> > #cat info/L3_MON/mbm_assign_control
> > test//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}
> > //0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}
> > 
> > It is harder to parse in code also. We should consider only if there is a
> > value-add with this format.
> 
> Please see my comments in [2] for some motivations.
> 
> > 
> > Otherwise I prefer our current flag format.
> > 
> > # cat info/L3_MON/mbm_assign_control
> > test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl
> > //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl
> 
> We could possibly consider some middle ground where flags are separated by
> commas and when the amount of used flags reach 26 the interface can use
> "two letter flags" or "longer names" or "the actual event name" or ....
> 
> > 
> > 
> >> commas to separate the events of a domain. Peter [1] has some reservations about
> > 
> > Yes. I would like to hear from Peter.
> > 
> 
> Reinette

Ack; see also my reply to Peter on the other subthread.

I think the single-letter names provide a much less cumbersome
interface.

From the Arm side, I'd be happy to see just "t" and "l" for now, with
their current fixed mappings to event names, provided that we are
confident that we can add flexibility later without breaking the ABI.

In case this has got lost in the noise, I still think that the v11
proposal for the ABMC interface looks fine as a first step -- I just
wanted to kick the tires re extensibility.

Cheers
---Dave

