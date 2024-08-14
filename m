Return-Path: <linux-kernel+bounces-286214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADE95181A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B24E1F238A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B391AD9C7;
	Wed, 14 Aug 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBzEkQvT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EE1A00DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629489; cv=none; b=N0fTZLbnzDaXQZaARQjj8AP8i5Tdxpop340b6FDs6fK3FcEtlHlxaKwoBSgOVnXMjVDneZGZ3rIuzRNW9apvunhyqsG+EJz90ueTZ0oxxSkM2fFW9AvoMORyWfoeFN3fPZjrRWVtt2uFon2UgWhDHV4t2RSa4G0u3cC772msI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629489; c=relaxed/simple;
	bh=ywl8XmyS9mHm+0bQOP27BgcWEnPO1Bj2PrL8OOlKNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSnmICAskwb9LNRrYegct8An9bb1xa3OjTpbsyygudvvWQSZtCl/ZxJN2yxLb5tS0eh1JDvHPwsg7qR7cfpG4lkLg3QS5GSCTJYaW/ZbayvkRwSpdK4C6uvAQLMjTYwsS4YVn8v83AJswusnO8B9CYgzAf7wjOTqC41WrtfpunQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBzEkQvT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so4649a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723629485; x=1724234285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XNPiYAxD0nXeda3XoGkXcfBa5gPOVQX7S7Zbc6+r9Yg=;
        b=BBzEkQvTFKF8u+F+Ee/es1bhoz9g8uwPkJPgdLQVfP1G+Cy2HX9iXh1KWOL5W/fxw2
         D+hFzmQPx+hK7SahRziNq9J9Y9nOSyKHUN41+ERnR4TfIr0JmSsr0RngWZy83DWO7kxJ
         lWd+K9t1AZBdM9+zJimvtHoC/NmAhIdxoRT1ILpgGByJq/yAH/FxQM/k6AWxVLJTk7aM
         ISPu3YweoQymw8WQD+7n0xhoS1ZcOlAvXt3FejIOXrlJWPgsqSLQYYC1zfQN5D51WV29
         feXtZPWG7WhyMxM3YBSzdTga+QCr4XtSi0mQ4zb3MQ5GfDc2gwJKx+sjsLIAIKhraGGI
         oxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629485; x=1724234285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNPiYAxD0nXeda3XoGkXcfBa5gPOVQX7S7Zbc6+r9Yg=;
        b=tDu56A0NAnqQbqdVHqv9nPS0gyj0l1CP1NGPS6p5Fq8YKaaUZAoa6VuhzDmIoRAKjA
         qjC7j8k7P9d9kCMqz0L70UAphzCS5x/8av17P9v5//0x/pkYA4++V4o+gkzK6b2uk5Bm
         R4ssyQlZLSqRvW3TWc5cqWK0o0jRyXTOolyyReFNv2HZuS8hGynlgHSz70VnQUSn3nxq
         UsCRdVi1tQi4yGBXBuzkUvRuG2QvpLngr+PGqgwvmLkAN3MG/+VKa1Irjro4KvWF2PXE
         S4LhY0UxAsvGc9kWn8gMbU8sVAZDLwIjXzjZwMwRSfnoP9F/VKoaLTThPOU1ty8wQ5aM
         xZiw==
X-Gm-Message-State: AOJu0YxLkOnudcd45iNAJi23CeUk1S1uLfD7dHXNTqY0m/S6sbl+tPA9
	wVt15TNtGBzLqN0wlNYAtaTvdOje1Zln6X+7xoail9I0+GQgOxnpachePcRa4A==
X-Google-Smtp-Source: AGHT+IGOoeQSGPXnP0Clm+mJgyY7hA8NUckb53WhjJatTU+/3rVRLEqRqMqPYgosUnSxt0miWa/RPg==
X-Received: by 2002:a05:6402:3481:b0:5aa:19b1:ffc7 with SMTP id 4fb4d7f45d1cf-5bea28067bdmr77383a12.2.1723629485134;
        Wed, 14 Aug 2024 02:58:05 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded31c5esm14718735e9.13.2024.08.14.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:58:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:58:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
Message-ID: <Zrx_qO1iHwbr4ctO@google.com>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
 <20240813175155.GN1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240813175155.GN1985367@ziepe.ca>

On Tue, Aug 13, 2024 at 02:51:55PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2024 at 08:52:55PM +0000, Mostafa Saleh wrote:
> > Previously, S2 stall was disabled and in case there was an event it
> > wouldn't be reported on the assumption that it's always pinned  by VFIO.
> > 
> > However, now since we can enable stall, devices that use S2 outside
> > VFIO should be able to report the stalls similar to S1.
> > 
> > Also, to keep the old behaviour were S2 events from nested domains were
> > not reported as they are pinned (from VFIO) add a new flag to track this.
> 
> I'm not entirely clear on every detail of this stall feature...
> 
> But from a core perspective device fault reporting should only ever be
> turned on in the STE/CD if the attached domain->iopf_handler is not NULL.
> 
> If it is NULL then any access to a non-present address should trigger
> some kind of device error failure automatically.
> 
> This is new core functionality since this code would have been
> originally written. Now it is all handled transparently by the core
> code. The driver should just deliver all fault events to
> iommu_report_device_fault() and it will sort it out.
> 

I agree, as there is no iopf handler in this case, we should just
report it to the iommu code and it will reject it instead of tracking this
in the driver. And as all the “enable_nesting” stuff is going away soon
anyway it’s not worth adding extra code for it. (plus we shouldn’t
really assume the intention of caller)

> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 8d573d9ca93c..ffa865529d73 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> >  	struct iopf_fault fault_evt = { };
> >  	struct iommu_fault *flt = &fault_evt.fault;
> > +	struct arm_smmu_domain *smmu_domain;
> >  
> >  	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> >  	case EVT_ID_TRANSLATION_FAULT:
> > @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > -	/* Stage-2 is always pinned at the moment */
> > -	if (evt[1] & EVTQ_1_S2)
> > -		return -EFAULT;
> > -
> 
> This makes sense at first blush since the domain mode shouldn't define
> if events should be processed or not, and the events should be failed
> anyhow right? If someone did turn on fault reporting in the STE then
> it should always be processed to conclusion.
> 
> >  	if (!(evt[1] & EVTQ_1_STALL))
> >  		return -EOPNOTSUPP;
> >  
> > @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  		goto out_unlock;
> >  	}
> >  
> > +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> > +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
> 
> Strongly discouraging drivers from calling iommu_get_domain_for_dev()
> in async paths like this. The locking is tricky and the core code does...
> 
> > +	/* nesting domain is always pinned at the moment */
> > +	if (smmu_domain->enable_nesting) {
> 
> This is not necessary - a nesting domain will never have an
> iopf_handler set.
> 
> It immediately calls iommu_report_device_fault() which will reject it
> because of:
> 
> 	if (!group->attach_handle->domain->iopf_handler)
> 		goto err_abort;
> 
> Which after the rework will end up in find_fault_handler() at the top
> of the function:
> 
>  https://lore.kernel.org/r/ZrTNGepJXbmfuKBK@google.com
> 
> So I think these parts are not necessary.

Yes, I will remove this patch and squash the removal of ignoring S2
events.

Thanks,
Mostafa

> 
> Though arguably we should be rejecting domains with iopf_handler set
> in some of the attach calls..
> 
> Jason

