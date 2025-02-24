Return-Path: <linux-kernel+bounces-530139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD99A42F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05F63B3124
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790181EDA14;
	Mon, 24 Feb 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQPrFYK5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68B1E0DD8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434052; cv=none; b=kPXjRylvEcxQJ2tsj2EcgbzkmNxCxGzquKlT/+BnVTKx5/vlYUFCqJgc6oUx97HM9qZ4Gkn6NU68dcBuM7xj/wkamPHiL+QNIoctyhu7do8Yoyx8z9/q/97FeRq99rk/RqbzTkd3Xpa4njXT7i8qHfo5R6wDIETO6CZvO2YLSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434052; c=relaxed/simple;
	bh=lOfd6dlmeiqEPHy61wcCsI34PRZuT2J/fiEGMBXUCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccOsQTx3lVroBy3dUCJm4s9CZBvVKJYGTR6eJz2CGy4Sg/1xVfD2CLqyUrs/TcFBdFUfo5ds/jh0KRBWr+BinU6s/tdD/Pd0BYZ0dTZSjaaLuvGH+I4l+hHBuM5Ps3b/GpcDSjARgwb+VBaycWv5xvKimDNqb9qr//7MY/T+Rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQPrFYK5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221ac1f849fso14255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740434049; x=1741038849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcg5x+HnDt6i287wHJ6fnl/QzabNNejalgvIUO3dans=;
        b=bQPrFYK5Cp1y/z40G36LCWEfA1uE+FYfM+adT2pnTLlyvscp/6Fik10O/fKw7MxiFj
         1ScLRE0S+x7WrQNskifkmgGFMuHcW8wBe4Ja6oFIxUSi8Sw9pDLGcwGimkx+rm+Ws0rW
         CeLF7KxH7Y3EKittxRVAsUQ5pD+Bssh57iRIc963cLOBUokIySsaA05e07UvVBcczjqr
         O9/UlpcfIT4y8hgl7S4WxjF7f89Fn9CFwE67kcJGYYxYc/N2j+8b2CkcC+boMEus64e8
         OqPUJyiHleppuf/Lu6c/4Fkwv1bxt1iQRLZsd1YiQHDEo2AEAjviXAgfBMCCZpFRcmBw
         D6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434049; x=1741038849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcg5x+HnDt6i287wHJ6fnl/QzabNNejalgvIUO3dans=;
        b=ja2Ol6lTdT9EZZhWpIprAKPG8Jw51T92ZaeX95VvOdXbAy/UdMTrn5xIDbSlnTGnei
         rYCiqgHprgHmDDw5n+C6uX4OUSeoShAHvCVRmV45F2g0bqKpUPiIu6ck2ZWNtR4inrLD
         CfA6z8Rvo/eGrOWODBMClkvgFuVGjXTvR1HOSSR2LDUe8ERbdAJuwpIE8fN/WqieZF+z
         4wy7HeQCsi4KqB6gqSjXCePPeHghWlsMEqNdKyTVRlvdDEX1cYHUuy7941clobjm5WJY
         PM1cTHiXNlPpIY+d22Q6AbB2jNQ3MOKXwIQesXjDvzhVphs8TfMAlUpljoZxmfOIkx7C
         lwZA==
X-Forwarded-Encrypted: i=1; AJvYcCVVVo8jAupWD6N0g7xT/psp71feBehnbkfU/jGQXqzPAccHIXWlW32wDfzxwamPFX9TFYhhu6Th3imBUqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXEM8wP83kh8/Iyn9KESVAH3D0q+8+Np350/khoNMWufCkFiC
	xdzaI+GNS7NtB4GneHXf71XtcYxRX4WfsBFRMA0M8kuvvea9rO1Nk3dxnSq3ow==
X-Gm-Gg: ASbGnctEAYYtZdlEoNFS9Lkca/CNUsrOYpUdJmLCryTHYTiTxALGxfA2Foox4V7hbQh
	fW345KdpU5ECqwTGh44Lcw4/8YN7E0ggF0gSGXVkuywQ8LxbluXaSQGZALX4kJoR52WRXLixoy1
	HwFArHK8MfYW0zaI4hvK2fvl2GjZkDFmcOlfIhpvbKUUA4/yB2sI2brAUk9FTz6P/ecRRoMyBrq
	aDyOegjzkj5NSjZLbPMYwuysIwgN58Z4EWHN5ibw9w2Rpw9WoJgEERfuCwdt14YLnjal6t40BUX
	3AhhV4/PaCa2aPD2KeXjbot1MvefffKwIxoBL5ExTHUd8kkLTgkPQiZjeFb6tTo=
X-Google-Smtp-Source: AGHT+IEpKhaMyBCkt6aQomwMTBim64fWChp3DGISBq2p87Hyiqlav2xt82oY5FJwGrR4tW3dc9pk3Q==
X-Received: by 2002:a17:903:22ce:b0:216:21cb:2e14 with SMTP id d9443c01a7336-22307a989ecmr1049425ad.21.1740434049047;
        Mon, 24 Feb 2025 13:54:09 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6fa230sm131119b3a.70.2025.02.24.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:54:08 -0800 (PST)
Date: Mon, 24 Feb 2025 21:53:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z7zqdrQn7Q8yXfcn@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zlH74/orq9HF7Q@Asurada-Nvidia>

On Mon, Feb 24, 2025 at 01:31:11PM -0800, Nicolin Chen wrote:
> On Mon, Feb 24, 2025 at 08:35:56PM +0000, Pranjal Shrivastava wrote:
> > oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > index 5aa2e7af58b4..364d8469a480 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
> > >  	}
> > >  }
> > >  
> > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > +				    struct iommu_domain *domain)
> > > +{
> > > +	struct arm_smmu_nested_domain *nested_domain;
> > > +	struct arm_smmu_vmaster *vmaster;
> > > +	unsigned long vsid;
> > > +	int ret;
> > > +
> > > +	iommu_group_mutex_assert(state->master->dev);
> > > +
> > > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > +		return 0;
> > > +	nested_domain = to_smmu_nested_domain(domain);
> > > +
> > > +	/* Skip invalid vSTE */
> > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > +		return 0;
> > > +
> > > +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > > +					 state->master->dev, &vsid);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> > > +	if (!vmaster)
> > > +		return -ENOMEM;
> > > +	vmaster->vsmmu = nested_domain->vsmmu;
> > > +	vmaster->vsid = vsid;
> > > +	state->vmaster = vmaster;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > > +{
> > > +	struct arm_smmu_master *master = state->master;
> > > +
> > > +	mutex_lock(&master->smmu->streams_mutex);
> > > +	if (state->vmaster != master->vmaster) {
> > > +		kfree(master->vmaster);
> > > +		master->vmaster = state->vmaster;
> > > +	}
> > 
> > Does this condition suggest that we might end up calling
> > `arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
> > commiting to a vmaster?
> 
> No. prepare() and commit() are 1:1. How is it interpreted to have
> "multiple times"?

Ohh alright. I was just confused about why do we need to check:
`if (state->vmaster != master->vmaster)` ?

> 
> > > +	mutex_unlock(&master->smmu->streams_mutex);
> > > +}
> > > +
> > > +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > > +{
> > > +	mutex_lock(&master->smmu->streams_mutex);
> > > +	kfree(master->vmaster);
> > > +	master->vmaster = NULL;
> > > +	mutex_unlock(&master->smmu->streams_mutex);
> > > +}
> > > +
> > >  static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
> > >  				      struct device *dev)
> > >  {
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 358072b4e293..9e50bcee69d1 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> > >  	struct arm_smmu_domain *smmu_domain =
> > >  		to_smmu_domain_devices(new_domain);
> > >  	unsigned long flags;
> > > +	int ret;
> > >  
> > >  	/*
> > >  	 * arm_smmu_share_asid() must not see two domains pointing to the same
> > > @@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> > >  	}
> > >  
> > >  	if (smmu_domain) {
> > > +		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
> > 
> > IMO, this adds a little confusion for folks not using iommufd.
> > 
> > I guess it'd be cleaner if we invoke this below within the:
> > `if (new_domain->type == IOMMU_DOMAIN_NESTED)` condition instead of
> > simply returning from the function if the new_domain->type isn't NESTED.
> 
> But the arm_smmu_attach_commit_vmaster() still has to be
> unconditional as !NESTED domain should clean the vamster away..
> 

Ack. Right.

Thanks,
Praan

