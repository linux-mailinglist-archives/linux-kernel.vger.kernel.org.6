Return-Path: <linux-kernel+bounces-218316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2188A90BC80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C8028176A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14521990DA;
	Mon, 17 Jun 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLX55ZWP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD42198E7E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658007; cv=none; b=aO/BmbRFoXdxdlmoDaqPmwm4lGxTct8bRW1vQOh8xRTF/+94rRIG+ew3Bi8KgK2cY3n6G7M9m49R4MWaIsw1s72DnbLWaa34yGz2GWN2BjQjbrmMrF1vuNCWNMOlphByBMOMfdqRu2ZsQ4ApDKlFOLmkDmiy9wRn7Bg0hUtZ/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658007; c=relaxed/simple;
	bh=WgSLYyErJHoji4fKyM9IQk+BqeeF2YiNgiSt5c2toJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggIm8SPGqxdhwm0diLe1l297bWr8odujbzfIv6E5g+IBmq8Nt35+zWtZKymdihdvBIepykPeg/RzSn9Qo6yvEUyKKmSI/3SvFeGYEBZXN7QokkcYa4JWlnzMIDAEYBtideY2bYn/9SGzpIS6GjPbF1B4q4Ep26iJEvSPDIV7cbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLX55ZWP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718658005; x=1750194005;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WgSLYyErJHoji4fKyM9IQk+BqeeF2YiNgiSt5c2toJQ=;
  b=GLX55ZWPak7Xj9ssMPpA+EYnFWOdYo7y8NLKUHsPQLdPv5MLcDTKbjv0
   665kqndJAa15gEjLozzUH5r0z0u9KFsHmmAEkZ9SGe10oI+5tAXpvUqxX
   TSnDYXpqOOXSVSv6Ers8BLQJRmiO7l1ppXJPkaE9bSnlmpNCU9hc/F546
   j6ate8yP6e7ZsYIO2shhzIUKZjbX8k/oSg92uHFb3u8+VpnqXVuuQ3eTo
   8bJLr10XOXXcZ9SiKEZ6zS5pzhwzm6ceoJ+3MIgUwB3lsoDEr6iMynzJz
   SOTWBpChKk9l6CnzO5kFuTAdIcGZC+1Kb4QBKfTukhFyInqGZRGlgVEaO
   g==;
X-CSE-ConnectionGUID: FFaz67K9TSmz16YlTs/vLg==
X-CSE-MsgGUID: ljHm7uC8QNu2shvKTcAgrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="40914957"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="40914957"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 14:00:05 -0700
X-CSE-ConnectionGUID: XKa3eSioTH28Qfn7IItaBA==
X-CSE-MsgGUID: fItK/p1OSwu/yH7q6qYLtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41412015"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 14:00:04 -0700
Date: Mon, 17 Jun 2024 14:05:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Handle volatile descriptor status read
Message-ID: <20240617140510.3a405344@jacob-builder>
In-Reply-To: <BN9PR11MB52765C0508922F9CDEAE7E9D8CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB52765C0508922F9CDEAE7E9D8CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Mon, 17 Jun 2024 03:04:36 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, June 8, 2024 1:38 AM
> > 
> > Queued invalidation wait descriptor status is volatile in that IOMMU
> > hardware
> > writes the data upon completion.
> > 
> > Use READ_ONCE() to prevent compiler optimizations which ensures memory
> > reads every time. As a side effect, READ_ONCE() also enforces strict
> > types and
> > may add an extra instruction. But it should not have negative
> > performance impact since we use cpu_relax anyway and the extra time(by
> > adding an instruction) may allow IOMMU HW request cacheline ownership
> > easier.  
> 
> I didn't get the meaning of the last sentence.
The wait descriptor is polled by the CPU and written by the IOMMU
concurrently. The IOMMU needs to have the cacheline ownership before
writing the status data to signal completion of the wait descriptor.

If the CPU polling loop is very tight, it might make IOMMU request for
ownership contentious/difficult. Since we already use pause (cpu_relax())
to ease the contention, adding an additional instruction

 mov    (%rax),%eax

Will make the cacheline even less contentious since it is just register mov,
no memory access.

> > 
> > e.g. gcc 12.3
> > BEFORE:
> > 	81 38 ad de 00 00       cmpl   $0x2,(%rax)
> > 
> > AFTER (with READ_ONCE())
> >     772f:       8b 00                   mov    (%rax),%eax
> >     7731:       3d ad de 00 00          cmp    $0x2,%eax //status data
> > is 32 bit
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> Do we need a fix tag here?
I cannot find the exact commit, this is really old code.

> otherwise looks good to me:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>


Thanks,

Jacob

