Return-Path: <linux-kernel+bounces-315000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DE96BC00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4732D28469D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920F1D88B8;
	Wed,  4 Sep 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsK6zi6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B91D5893
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452647; cv=none; b=tGu+EMxFH21sXFNfJpwkRSmjNhZ+/k5CP6UXkEOKthBJz4r29pDeqZLezpFNcAzlLho2IgouNBlnmgdgDB1flxz2A+795zQeRqcSwuHu0b+FoWXPdrHKm9ZORzuUHKifgMA5kuKaPtMm3KXIQngwQlhE6M8U0zN0Alo6GQtfE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452647; c=relaxed/simple;
	bh=j/87510LA4gtO73Emfr696qWrE/N497dC5nxyxs0adU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8Nc42t9zI4z5ENG2E3IP1tRKr8azOgdZpT/oqcza2o/QWUvqEaeKR8Vz3/t9SPTF6eyGpyFjR/T1QA4iTkL/YrC3aGdBpanSf+5XYWt7HOJfWFZbDAkBI/xJBWxSWGdcpfLgk17dcDidyaYZzEccIpAFWk7pZq+HoeA3FDuXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsK6zi6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22782C4CEC2;
	Wed,  4 Sep 2024 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452647;
	bh=j/87510LA4gtO73Emfr696qWrE/N497dC5nxyxs0adU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsK6zi6qoN5b4VLEVKr8CODHVpu+VCRsqnQcVrZ7ADRMPV2At4yz7FUKQIVBhCIgU
	 dUojUxuigczjSgwSjPjHBLRi+iuriHoFk4qinqDXI3b6baB7LTBw3HJpSn3vwg+XzF
	 Gpnhe6P065FrDC8zNupQJ+TLs5dxvK2Ev/Fa7nEp3zLNViPk9LrEx4kCIbwrCenHda
	 VzM62ieSElgSkyOc2I/iM2VedonEVjpqs/2LnYJI0yTp1wZr4+m1iSV9Dh9OQM5kpb
	 CbFz/6C0lTBIPfIidNGe2tK+Cg1tpkBwZA78Wss/PcMWwML+ND3gzBfKHkUoB/RoLR
	 Rs25UtW669YuQ==
Date: Wed, 4 Sep 2024 13:24:02 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH v3 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Message-ID: <20240904122356.GE13550@willie-the-truck>
References: <cover.1725037424.git.robin.murphy@arm.com>
 <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
 <20240902144714.GA11443@willie-the-truck>
 <0a41657e-a52c-43c9-9b73-89fd73a376c7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a41657e-a52c-43c9-9b73-89fd73a376c7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 02, 2024 at 07:47:18PM +0100, Robin Murphy wrote:
> On 02/09/2024 3:47 pm, Will Deacon wrote:
> > > +static ssize_t arm_ni_format_show(struct device *dev,
> > > +				  struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
> > > +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
> > > +
> > > +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
> > > +}
> > 
> > Nit: if you end up adding single-bit config fields in the future, this
> > will quietly do the wrong thing. Maybe safe-guard the 'lo==hi' case (even
> > if you just warn once and return without doing anything).
> 
> The counter-argument is that I don't foresee having any reason to add
> single-bit config fields here in future, nor indeed config1 or config2
> fields, so I intentionally pruned the would-be dead code while copy-pasting
> this implementation from arm-cmn. Yes, if someone were to make an incomplete
> change without paying attention or testing they could introduce a bug, but
> when is that ever not true?

I guess I'm just a little more wary when it comes to UAPI. Somebody starts
relying on the broken message and then you're toast. It's also incredibly
easy to avoid by construction and the dead code isn't hurting anybody.

> > > +	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
> > > +	if (!name)
> > > +		return -ENOMEM;
> > > +
> > > +	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
> > > +	if (err)
> > > +		return err;
> > 
> > What happens if there's a CPU hotplug operation here? Can we end up calling
> > perf_pmu_migrate_context() concurrently with perf_pmu_register()?
> 
> Yes. Alternatively we could register the PMU before the hotplug handler,
> then potentially miss a hotplug event and leave a user-visible PMU
> associated with an invalid CPU. This is a known issue for all system PMU
> drivers, and the conclusion 5 years ago was that it's impractical to close
> this race from outside perf core itself[1][2].

Ok, I'm going to walk right into the trap you've set me...

Why can't we prevent hotplug (e.g. with cpus_read_lock()) while we're
setting this up?

... and climbing back out of that trap, is the conversation you had with
Thomas written down anywhere?

I don't want to block this patch, but if five years has passed with
nobody looking at this then we probably need to address that at some
point before adding more and more broken drivers.

Will

