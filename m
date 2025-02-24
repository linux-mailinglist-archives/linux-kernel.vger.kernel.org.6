Return-Path: <linux-kernel+bounces-529654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589BDA42952
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4C1887D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E529E263F5B;
	Mon, 24 Feb 2025 17:18:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7E1537C8;
	Mon, 24 Feb 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417489; cv=none; b=niJs3INEYJe8k6Z7mk6WW9LEUPlKwIIlthGRj3ENq0eT7EeuJu6M/ItnMm5zpJ3ZrnEC97cu6D69o3R1vJ7AcCn4guwC4HfOOT7kj45HmsLYJGKsx4xfCf8Jef6G37XybBGfVLi/6jvyukLXyuDSf3MDzXUGfCvMe5aKy9yfWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417489; c=relaxed/simple;
	bh=Udl67jI1Qm6fATwqGT1fr5PHHdw9h5FVAHOl8ACPIDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeRrfWNAqexR63utZhiSeTMriJX7h5sPgoNuewQd+5KiyycsnPmrluoJOg8SaY51R0c6zhZ1edU0bAVoL0SIs2I0isu1Lcba4EvL9H5g9akrPDMeyA7tt9ZQMg/4f70WJg+PcT/5f6A5Rv0peQ/efte/CUbKR+KLq1ScvH/fuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14AA3152B;
	Mon, 24 Feb 2025 09:18:21 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBDBF3F5A1;
	Mon, 24 Feb 2025 09:17:59 -0800 (PST)
Date: Mon, 24 Feb 2025 17:17:54 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z7ydx6vfuw8OdJzL@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
 <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>

On Fri, Feb 21, 2025 at 12:10:44PM -0800, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/21/25 8:00 AM, Dave Martin wrote:
> > On Thu, Feb 20, 2025 at 03:29:12PM -0600, Moger, Babu wrote:
> >> Hi Dave,
> >>
> >> On 2/20/25 09:44, Dave Martin wrote:

[...]

> >>> But mbm_assign_control data is dynamically generated and potentially
> >>> much bigger than a typical sysfs file.
> >>
> >> I have no idea how to handle this case. We may have to live with this
> >> problem. Let us know if there are any ideas.
> > 
> > I think the current implication is that this will work for now provided
> > that the generated text fits in a page.
> > 
> > 
> > Reinette, what's your view on accepting this limitation in the interest
> > of stabilising this series, and tidying up this corner case later?
> > 
> > As for writes to this file, we're unlikely to hit the limit unless
> > there are a lot of RMIDs available and many groups with excessively
> > long names.
> 
> I am more concerned about reads to this file. If only 4K writes are
> supported then user space can reconfigure the system in page sized
> portions. It may not be efficient if the user wants to reconfigure the
> entire system but it will work. The problem with reads is that if
> larger than 4K reads are required but not supported then it will be
> impossible for user space to learn state of the system.
> 
> We may already be at that limit. Peter described [1] how AMD systems
> already have 32 L3 monitoring domains and 256 RMIDs. With conservative
> resource group names of 10 characters I see one line per monitoring group
> that could look like below and thus easily be above 200 characters:
> 
> resgroupAA/mongroupAA/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;32=tl
> 
> Multiplying that with the existing possible 256 monitor groups the limit
> is exceeded today.

That's useful to know.  I guess we probably shouldn't just kick this
issue down the road, then -- at least on the read side (as you say).

> I understand that all domains having "tl" flags are not possible today, but
> even if that is changed to "_" the resulting display still looks to
> easily exceed a page when many RMIDs are in use.
> 
> > 
> > This looks perfectly fixable, but it might be better to settle the
> > design of this series first before we worry too much about it.
> 
> I think it fair to delay support of writing more than a page of
> data but it looks to me like we need a solution to support displaying
> more than a page of data to user space.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20241106154306.2721688-2-peternewman@google.com/

Ack; if I can't find an off-the-shelf solution for this, I'll try to
hack something as minimal as possible to provide the required
behaviour, but I won't try to make it optimal or pretty for now.

It has just occurred to be that ftrace has large, multi-line text files
in sysfs, so I'll try to find out how they handle that there.  Maybe
there is some infrastructure we can re-use.

Either way, hopefully that will move the discussion forward (unless
someone else comes up with a better idea first!)

Cheers
---Dave

