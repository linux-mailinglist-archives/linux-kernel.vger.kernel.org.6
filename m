Return-Path: <linux-kernel+bounces-284918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F49506DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD96B236BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B654019CCF7;
	Tue, 13 Aug 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HScecNjD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640AD19AD8E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556611; cv=none; b=jJiYZIC4z1Pqd55cMwYC54kvcIXzxcpAfOneMajCAhMsTqi1+8sHcA4YoSp0koDQWvYop0oQr9DHMKYGjSpl7rZAvssadAJuhOPzRKrL38vc0/74+xAALZ0CYDMxVx3PE1XhATjOYvcG1NogUU44J1tq6iBwYdZHoSB4CQjNAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556611; c=relaxed/simple;
	bh=LnxvK3Y/FdZrQG9MDhGhpntXMLPySQ/0jyqHkDK1sPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2Zrhs+wX0L61Ae5uWmJbBcUxS/x6Cf1xlebhLX+OocFR8Jyi0H/KPU5hSKNrEYEF/XS2OGZImqSDzIFhGq/eRhlwoDxazEXAg7Zr+2MflfjmHfMiaierdVUKeTAjeujpvun46HNFepvYGH7y8WJ+nkNgPWJx6681M8cjD+FkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HScecNjD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427fc9834deso32645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723556608; x=1724161408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Cu6yfPujhw6fB1N8lInQ2Ql6fk98oC5gSkan91gIQ4=;
        b=HScecNjDwq4CBh1D6srTJe+G0GlkaFl3D19shVM0Y+7CVHorTTyemm0xeKohKBeEF/
         dVFouabPxOObzJK0YduGFWVh/emgVzEPQwwZIoO/hrRNlTHeYhkvfGa1ljratBClKqna
         MrusA6lMvGiOeCyEQ5ky9MKyRKbggmbMnWtDFfZEp3qr9/2gB3LJZypRPfhIxGuIJPjk
         t88iuYtq5Fw4LIWtiPDkl4fwyOj3iMBZSVPvwBUHikT7Fa+Goxux6MWVESaZ4Wc0Lb9p
         5sNcZ8OEi/6+eSc5VbEjTWJ7Az2SYH6sUp0RG9E2CjQztboAScAhCyPoLFDpESkMGBBM
         PQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556608; x=1724161408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Cu6yfPujhw6fB1N8lInQ2Ql6fk98oC5gSkan91gIQ4=;
        b=u4MyxPe/tRcSME94f4uK7NVkk3QbfbO3srQwYxvqN6huo9J22GoNqmnL+air5tnICF
         FKVx6kRuYtYOMpSUPBlGG94hUrM5u58Hh3TrM1qs+tr9dm7NM/7+JTKEcmokJ9LxY0wm
         beoHnBUAYWvIgX7/X/u8tTGcLm4qja2x3N55+JXGNAuK9ZegDCumn6cIwNQ4jXlChtAp
         Ks/iRKKLrO5QNCNPXG8+FrifidfTZyt8rqaOWJ27f49bMSJnGxCyGTk1bN/AvSf+Yz9c
         BzfORmmiiLpo8T3OCU/0y4kvYxBiTADJ0VrfVPDxAhd/xuCaF2b1Lb0C71JlB/gjR4sD
         wmTw==
X-Gm-Message-State: AOJu0YxnVGtHQ/8vxzm1D+xbqQ+YfOgJPvwYUxm19jJn0AYWC6fE9na9
	rCPHdGJlE8sO6bERTd8mxpduIiviONBjeWsZa45fvYcGzt96yChk/E3Ix5Df9g==
X-Google-Smtp-Source: AGHT+IElInwkbbsXFlvNFFwCJ3MNM6wm6OEDR1d2oK/QWIGbYtLpQJEx6Ik309H6zI76mem6/9tRTA==
X-Received: by 2002:a05:600c:1d95:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-429d715b507mr570035e9.6.1723556607417;
        Tue, 13 Aug 2024 06:43:27 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee71esm10255851f8f.50.2024.08.13.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:43:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:43:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
Message-ID: <Zrti-uek_5WCQ2J8@google.com>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
 <e5a8e78e-2459-453a-b3b7-e1ed2ca4addc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a8e78e-2459-453a-b3b7-e1ed2ca4addc@arm.com>

Hi Robin,

On Tue, Aug 13, 2024 at 12:57:02PM +0100, Robin Murphy wrote:
> On 12/08/2024 9:52 pm, Mostafa Saleh wrote:
> > Previously, S2 stall was disabled and in case there was an event it
> > wouldn't be reported on the assumption that it's always pinned  by VFIO.
> > 
> > However, now since we can enable stall, devices that use S2 outside
> > VFIO should be able to report the stalls similar to S1.
> > 
> > Also, to keep the old behaviour were S2 events from nested domains were
> > not reported as they are pinned (from VFIO) add a new flag to track this.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
> >   2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 8d573d9ca93c..ffa865529d73 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >   	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> >   	struct iopf_fault fault_evt = { };
> >   	struct iommu_fault *flt = &fault_evt.fault;
> > +	struct arm_smmu_domain *smmu_domain;
> >   	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> >   	case EVT_ID_TRANSLATION_FAULT:
> > @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >   		return -EOPNOTSUPP;
> >   	}
> > -	/* Stage-2 is always pinned at the moment */
> > -	if (evt[1] & EVTQ_1_S2)
> > -		return -EFAULT;
> > -
> >   	if (!(evt[1] & EVTQ_1_STALL))
> >   		return -EOPNOTSUPP;
> > @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >   		goto out_unlock;
> >   	}
> > +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> > +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
> > +
> > +	/* nesting domain is always pinned at the moment */
> > +	if (smmu_domain->enable_nesting) {
> 
> Ugh, has the whole enable_nesting method still not gone away already?

It should go away with Jason latest nesting patches:
https://lore.kernel.org/linux-iommu/0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com/T/#mc5558cb88b10fcdc4b91076cf813123cac75f11d

I can just ignore that here, and only remove the S2 check, and as
VFIO anyway doesn't register a handler it shouldn't really matter.
So, it's one line change, I can also squash with the previous patch,
please let me know what you think.

Thanks,
Mostafa

> 
> However, at least for now, isn't this functionally equivalent to just
> testing !(smmu->features & ARM_SMMU_FEAT_TRANS_S1) anyway? We still won't be
> able to differentiate a nominally-pinned non-nested VFIO domain from a
> nominally-stallable non-VFIO domain on S2-only hardware.
> 
> Thanks,
> Robin.
> 
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> >   	iommu_report_device_fault(master->dev, &fault_evt);
> >   out_unlock:
> >   	mutex_unlock(&smmu->streams_mutex);
> > @@ -3373,8 +3379,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> >   	mutex_lock(&smmu_domain->init_mutex);
> >   	if (smmu_domain->smmu)
> >   		ret = -EPERM;
> > -	else
> > +	else {
> >   		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
> > +		smmu_domain->enable_nesting = true;
> > +	}
> >   	mutex_unlock(&smmu_domain->init_mutex);
> >   	return ret;
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 0dc7ad43c64c..f66efeec2cf8 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -745,6 +745,8 @@ struct arm_smmu_domain {
> >   	spinlock_t			devices_lock;
> >   	struct mmu_notifier		mmu_notifier;
> > +
> > +	bool				enable_nesting;
> >   };
> >   /* The following are exposed for testing purposes. */

