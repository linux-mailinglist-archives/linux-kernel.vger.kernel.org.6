Return-Path: <linux-kernel+bounces-318805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27996F392
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322C7B25251
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F78F1CBE8A;
	Fri,  6 Sep 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ3mikOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4641CBEA2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623420; cv=none; b=iX0DtXXtxfcTxG9cpuQBCuEetEEQWEsoMuojHOeSXIumXE6ehiWU+yWIXpri5lTFgNShQdPtr8m+uzrUFEwTjlifgLf9GBFC1zorU8zg3zZW9zO8TQ5gar3hYDKVLtaZ+a28D9KU3Perjn/MBbUuXyf03Yhwpy/HI1a+6p0UUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623420; c=relaxed/simple;
	bh=uD8v9jEwNtzydWYOwT56CgYtDXAtvo2dF3YOLNleRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPVs0IyyoruI8uIsVQldPhnlX+go3xAmSWpdXAbgnWEiScKpu0FX7u2bHWhwwFt6Mk8dN81nZV5QGGL+3dHWpgK7dmP2i5FAft9EnHxRwaML5KH5XN5HC2c/PYC19cgqWJn71PrdQIOUa9E4JMtAL19PNbWmaHLie2vk73v91QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ3mikOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40136C4CEC5;
	Fri,  6 Sep 2024 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725623420;
	bh=uD8v9jEwNtzydWYOwT56CgYtDXAtvo2dF3YOLNleRyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ3mikOTphsdAbIWTEirpBQIqkIVkGteca1kiXxBy6W10Lpcsaz5xulC/6mp+V5Y6
	 ByLWV008NHIIxzuSSFAYq9N2LATiOq+k+Ol7t1VUuGLgCau7+Nn2KUh8TzCJFmNaiL
	 3jy3BF6kV6kJTSydn73DDXtsBLVbFQar22UodQa7AclGEcrT+Khi3ydESbypw4NhBW
	 4rSbyVnxgPw6dY5AywBB1oDFz5S7mk9LDJV1949yVAjygqX1IcLXrpDC7aFboYkeTr
	 UAMqN9HRB6GJoPiSzI/Q2RF++F6MtCuxKKsb1G7bqJsqfhGekHggbr7JctjrAFN3J6
	 4d8d/Xes5+Ibw==
Date: Fri, 6 Sep 2024 12:50:15 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH v3 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Message-ID: <20240906115015.GA16423@willie-the-truck>
References: <cover.1725037424.git.robin.murphy@arm.com>
 <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
 <20240902144714.GA11443@willie-the-truck>
 <0a41657e-a52c-43c9-9b73-89fd73a376c7@arm.com>
 <20240904122356.GE13550@willie-the-truck>
 <6eccf37d-07ed-4fcd-bf76-d54603c4361b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eccf37d-07ed-4fcd-bf76-d54603c4361b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 04, 2024 at 06:15:24PM +0100, Robin Murphy wrote:
> On 2024-09-04 1:24 pm, Will Deacon wrote:
> > On Mon, Sep 02, 2024 at 07:47:18PM +0100, Robin Murphy wrote:
> > > On 02/09/2024 3:47 pm, Will Deacon wrote:
> > > > > +static ssize_t arm_ni_format_show(struct device *dev,
> > > > > +				  struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
> > > > > +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
> > > > > +
> > > > > +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
> > > > > +}
> > > > 
> > > > Nit: if you end up adding single-bit config fields in the future, this
> > > > will quietly do the wrong thing. Maybe safe-guard the 'lo==hi' case (even
> > > > if you just warn once and return without doing anything).
> > > 
> > > The counter-argument is that I don't foresee having any reason to add
> > > single-bit config fields here in future, nor indeed config1 or config2
> > > fields, so I intentionally pruned the would-be dead code while copy-pasting
> > > this implementation from arm-cmn. Yes, if someone were to make an incomplete
> > > change without paying attention or testing they could introduce a bug, but
> > > when is that ever not true?
> > 
> > I guess I'm just a little more wary when it comes to UAPI. Somebody starts
> > relying on the broken message and then you're toast. It's also incredibly
> > easy to avoid by construction and the dead code isn't hurting anybody.
> 
> Even presuming some theoretical unreviewed broken patch did get merged and
> into real-world kernels without ever being fixed, I still struggle to
> imagine how userspace could somehow grow to *rely* on one PMU driver
> displaying a format attribute in an unexpected manner inconsistent with
> every other PMU driver, as opposed to the far more likely scenario of going
> wrong trying to parse it.

I think you lose the game when you try to imagine what userspace could do :)

But c'mon, this is simple to address and then we don't have to imagine
anything.

> Anyway, after playing with some fun compile-time checks yesterday I've just
> realised there is actually an even simpler solution for doing the right
> thing in general, so I guess thanks for leaning on this :)

Hurrah! Thanks.

> > > > > +	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
> > > > > +	if (!name)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
> > > > > +	if (err)
> > > > > +		return err;
> > > > 
> > > > What happens if there's a CPU hotplug operation here? Can we end up calling
> > > > perf_pmu_migrate_context() concurrently with perf_pmu_register()?
> > > 
> > > Yes. Alternatively we could register the PMU before the hotplug handler,
> > > then potentially miss a hotplug event and leave a user-visible PMU
> > > associated with an invalid CPU. This is a known issue for all system PMU
> > > drivers, and the conclusion 5 years ago was that it's impractical to close
> > > this race from outside perf core itself[1][2].
> > 
> > Ok, I'm going to walk right into the trap you've set me...
> > 
> > Why can't we prevent hotplug (e.g. with cpus_read_lock()) while we're
> > setting this up?
> > 
> > ... and climbing back out of that trap, is the conversation you had with
> > Thomas written down anywhere?
> 
> I think that must have been the time we talked in person in Cambridge. I
> can't now remember if there is (or was) anything in perf_pmu_register()
> that's actually incompatible with being called under cpus_read_lock(), but I
> do recall that the overall concept of exporting more bits of the hotplug
> machinery in order to copy-paste the same boilerplate bodge in every PMU
> driver was... unpopular.

Unpopular, maybe, but you only have to look at a few PMU drivers to see
we're already in that situation for other aspects of the code.
Consolidation would be welcome, but I'd sooner have boilerplate code
than bugs.

> > I don't want to block this patch, but if five years has passed with
> > nobody looking at this then we probably need to address that at some
> > point before adding more and more broken drivers.
> 
> Looking at it again, is there actually a problem with the current state of
> things? Following through the call path:
> 
>   perf_pmu_migrate_context()
>     __perf_pmu_remove()
>       perf_event_groups_first()
>         __group_cmp()
>           perf_event_groups_cmp()
> 
> the "pmu" pointer only seems to be used as a key to match events in the
> current CPU context, which obviously won't find anything at this point.
> AFAICS it's never even dereferenced, unless any events *are* found for
> __perf_pmu_install() to do something with, which necessarily implies an
> initialised and registered PMU for them to have been opened in the first
> place.

You might well be right, but this could will change in future and I don't
think it's been written to work safely under this race. I also pointed
out that a similar race exists on the unregister path.

Will

