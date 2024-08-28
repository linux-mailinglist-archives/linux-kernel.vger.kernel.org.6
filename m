Return-Path: <linux-kernel+bounces-304335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A421961E47
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EF9B2175B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C9614AD25;
	Wed, 28 Aug 2024 05:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FXiaFZoE"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC89D512
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724823465; cv=none; b=FMPQuXXcdn0cV5kRvZSlUUIPn/Hdm0C8dVUEomjQWeXpC6KIcVOzfU02JX0n2Jex/88OTkVZepAfVPF+G9c1/1lNiNis6KEGVL0n3Wz+XZlJT1zZcIVNoJmPmIp773HvdLsN/wG1XB2v+2Sk6l3ISDloDVyMVAaBwkQgwUFYUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724823465; c=relaxed/simple;
	bh=IG5hgMNIPaaSHtP1Ebgjmk1fCp7OmEQKi89BW4AIIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg/YJt+VK3uGyl/s8UijigHERBWB084Pg9UOZptZhLmLVXwJZjiIr3G+N2Cz0mlZIwnkg0yXNGuJerce5oJAlpBwcmF39AQg5UIKyGpvpkVWn2RnKnWYlv6mWqpHU1aexrprnknKyH2cyJciDgT8N9/pjaWZYywqkXPqFp4TkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FXiaFZoE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4E71C20B7165; Tue, 27 Aug 2024 22:37:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E71C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724823457;
	bh=MvlhFl0YgUXxQqCx/QzeuztzvE6H4pK/dbDElYS3dL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXiaFZoE/NqE2BnrcjX67ysJN+HN98y21fpCR9Y2Qan481LHEae4dor1wM2GNvMNC
	 kuWpcuK3YkghqHGvlrMFIz1ZzwQQtnbB98Jxli/t7HDQ9vxZmG1Q2DERxvSIcCcNVD
	 L1/JOh64UiMPwtL4XarqqITFYD062U3zuE09JnzM=
Date: Tue, 27 Aug 2024 22:37:37 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-ID: <20240828053737.GA22322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
 <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
 <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <5a18105c-8e6f-39fa-370f-2d839d9ab843@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a18105c-8e6f-39fa-370f-2d839d9ab843@gentwo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 23, 2024 at 08:32:43AM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 8 Jul 2024, Saurabh Singh Sengar wrote:
> 
> > > > Calling this for each CPU is expensive when there are large number
> > > > of CPUs along with multiple NUMAs. Fix this by deferring
> > > > refresh_zone_stat_thresholds to be called later at once when all the
> > > > secondary CPUs are up. Also, register the DYN hooks to keep the
> > > > existing hotplug functionality intact.
> > > >
> > >
> > > Seems risky - we'll now have online CPUs which have unintialized data,
> > > yes?  What assurance do we have that this data won't be accessed?
> >
> > I understand that this data is only accessed by userspace tools, and they can
> > only access it post late_initcall. Please let me know if there are any other
> > cases, I will look to address them.
> 
> stat_threshold is used in all statistics functions that modify VM
> counters. It is core to the functioning of the VM statistics.
> 
> However, if the threshold is zero (not initialized) then the VM counter
> handling will simply be less effective because it will not do the per cpu
> counter diffs anymore. This may increase contention and eat up the benefit
> you are getting from deferring the calculation of the threshholds.

Christoph,

Thank you for your review. I would like to gain a better understanding of how
to measure contention. Could you please inform me if there is any recommended
method for doing so?

In my testing, this patch has resulted in a significant improvement in boot time.

> 
> What may be more promising is to make it possible to calculate the
> threshholds per cpu instead of recalculating the thresholds for every zone
> again and again.

I am happy to explore alternatives, can you please share more details around
this approach. Are you referring to avoiding the repetition of the calculation
below?

mem = zone_managed_pages(zone) >> (27 - PAGE_SHIFT);

- Saurabh

