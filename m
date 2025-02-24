Return-Path: <linux-kernel+bounces-530035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD383A42DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82C9174EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9C245005;
	Mon, 24 Feb 2025 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtbTaoUL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F8242928
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429370; cv=none; b=M55+rwp95PQXN1TngG/ySnG7ILyTJSBJk6PvqVZf9mKL72zBU4PNUOG6UmJ3CzQeS64Vo1aIbEI5eZr6f/SczYnWon2hJgra7SuXWz4cCxBti8Ou/LJRijkUrWheHSrDMzmnA6zzpZx91VjOAAwEyDPNSj2XZZ4MoQPn9DoavMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429370; c=relaxed/simple;
	bh=YWwIwoWgUGkN4PS5fEaN8sQ1nwKBXMww2irPZZb2dRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4LzJOWS5sfXfv0MJqp3XSbOhRtXRB7A4bjsaYCL5ECW19VAT7vHC+C0Zir38rP3pFXUoBYI4fAlHwCWQgDIQr9wTz34pQdTuz9ZS7K2yazO1x0/jBSKs8gUjEbF7ArStjTK/wJQC9TGmTSeGjv2h6YCNEH/HpAaw4yCm2zq9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtbTaoUL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22117c396baso2555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740429368; x=1741034168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cKiypGlQlNh3QGjj5r76b5/2a735Mu54ttXf9R8rE4=;
        b=HtbTaoULzOzWKTGZmu3uvK/Uoqgrw9471cjunT2GGpyfr0qTojMFwoL9lwf8rnvbwF
         Bxoychs9srz5mclUjOXktkx174pAXyGZB+wFte2xLeMZJaAQtYLZx7Tda3rB76/j9byu
         u5C/eZLWLtjzzRD5yDMMcu8xCpZRjdmireI77h6PS34y6F5c2zpyU/3L21b3NWIqZi5q
         FVoEvBHiSXFx3b/io/5MdaeNt1LbEgVHQ1zb9ZW6Ag9jAVxNVfdAs2IWDsVWr38y5lJN
         hq8gzewN2mJBSDiBOuEbxMxLjM6Rku8JrDNDmgIQ4/DTvYEzq8YcLV5wM4XaJjza0rjs
         6fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740429368; x=1741034168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cKiypGlQlNh3QGjj5r76b5/2a735Mu54ttXf9R8rE4=;
        b=ukO7sMQclDqqDH5rxsfU7oJUh4ir9/df4U3Oek1/8zjoo81/HgrsZx6lXP+Cibafvm
         nlto3mRVsx+fyxM85eDiPRISWtOp43y6eOTwcayOlAywLe6Dr5kmYG20NMH+YVfiY/Yb
         uTfvp6671QaPTULvm44+WA/S/WxemWpK+9NZopokcjNn81HVBOJYrQ5nUuNYVk/bC8kB
         RaKvC416WPLplgoLSCgatro4GL75c1Rg8SHd3lGnL5szNanIsQcrU2efDio/HlweuWew
         5B3YTq/hyJ4kf5MJYUsnS7y+TYvFxrymwZjq053T8xLd4Vqrhkf48TSa10WQ+awNbWAy
         hX0g==
X-Forwarded-Encrypted: i=1; AJvYcCUIjL+mQpbNGntIQInPt1tFN1+jrdBfXgpvUrDoIV+GGD8Rua6+bYyHk28SeJcnI0sNc84p5nSdrgFmHxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyniuw7feJHbI5tCZkaGWzByAZfD0CVRwuPjdYrVwIQCv+Yl+80
	JMqqiyOXdz2RTEiuXp8q8DakKSWflu1AcD/rBRFgawYiOVzzhJiIoqYlKtwx1A==
X-Gm-Gg: ASbGncsfw8rXHJ+tWlc0nZ1NLIsihE1wvVwJvRycqkxnM6lGO+WgH4Wz/XBdbI07vj2
	5+s+RN5Q5GOUynJBttVTYXbyCY1UXOsRKZ0ykeouhUz/XRx3RTqlBgS6sv1zeaNoDfG3AYRuv+t
	+CuuN0iD8E+MuBDJ2Tl72kyYd0T27bCt9zwXXC0i2nY+yLWH4m/szsWJrwLYuHkhTyX6fKtsK4c
	L7dMl6ugtu4ho0CUdEd9g2qem9I6WEJ0ym4d0/K4tNPOsMzvY85iRiRxq95naML9yYeWr+KRnfm
	YLizaE+x/SXb673GVNo4XJz5Tw4Uo+sPtjjjOPHV0cRdsw0VluHSRThCa7C2DgM=
X-Google-Smtp-Source: AGHT+IHaH843HTFlex9kiZqcHpRgOavmlHObIcSN9r1RcQ8QKdI50gtE2lb4j2DGqAQRh59wKV6n8g==
X-Received: by 2002:a17:902:ec90:b0:216:607d:c867 with SMTP id d9443c01a7336-22307aabb1cmr843455ad.29.1740429367405;
        Mon, 24 Feb 2025 12:36:07 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cb81sm101015a91.38.2025.02.24.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:36:06 -0800 (PST)
Date: Mon, 24 Feb 2025 20:35:56 +0000
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
Message-ID: <Z7zYLBLZGKim-5UL@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>

oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 5aa2e7af58b4..364d8469a480 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
>  	}
>  }
>  
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				    struct iommu_domain *domain)
> +{
> +	struct arm_smmu_nested_domain *nested_domain;
> +	struct arm_smmu_vmaster *vmaster;
> +	unsigned long vsid;
> +	int ret;
> +
> +	iommu_group_mutex_assert(state->master->dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_NESTED)
> +		return 0;
> +	nested_domain = to_smmu_nested_domain(domain);
> +
> +	/* Skip invalid vSTE */
> +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +		return 0;
> +
> +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> +					 state->master->dev, &vsid);
> +	if (ret)
> +		return ret;
> +
> +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> +	if (!vmaster)
> +		return -ENOMEM;
> +	vmaster->vsmmu = nested_domain->vsmmu;
> +	vmaster->vsid = vsid;
> +	state->vmaster = vmaster;
> +
> +	return 0;
> +}
> +
> +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> +{
> +	struct arm_smmu_master *master = state->master;
> +
> +	mutex_lock(&master->smmu->streams_mutex);
> +	if (state->vmaster != master->vmaster) {
> +		kfree(master->vmaster);
> +		master->vmaster = state->vmaster;
> +	}

Does this condition suggest that we might end up calling
`arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
commiting to a vmaster?

> +	mutex_unlock(&master->smmu->streams_mutex);
> +}
> +
> +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> +{
> +	mutex_lock(&master->smmu->streams_mutex);
> +	kfree(master->vmaster);
> +	master->vmaster = NULL;
> +	mutex_unlock(&master->smmu->streams_mutex);
> +}
> +
>  static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  				      struct device *dev)
>  {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..9e50bcee69d1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	struct arm_smmu_domain *smmu_domain =
>  		to_smmu_domain_devices(new_domain);
>  	unsigned long flags;
> +	int ret;
>  
>  	/*
>  	 * arm_smmu_share_asid() must not see two domains pointing to the same
> @@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	}
>  
>  	if (smmu_domain) {
> +		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);

IMO, this adds a little confusion for folks not using iommufd.

I guess it'd be cleaner if we invoke this below within the:
`if (new_domain->type == IOMMU_DOMAIN_NESTED)` condition instead of
simply returning from the function if the new_domain->type isn't NESTED.

> +		if (ret)
> +			return ret;
> +
>  		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
> -		if (!master_domain)
> +		if (!master_domain) {
> +			kfree(state->vmaster);
>  			return -ENOMEM;
> +		}
>  		master_domain->master = master;
>  		master_domain->ssid = state->ssid;
>  		if (new_domain->type == IOMMU_DOMAIN_NESTED)
> @@ -2861,6 +2868,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  			spin_unlock_irqrestore(&smmu_domain->devices_lock,
>  					       flags);
>  			kfree(master_domain);
> +			kfree(state->vmaster);
>  			return -EINVAL;
>  		}
>  
> @@ -2893,6 +2901,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  
>  	lockdep_assert_held(&arm_smmu_asid_lock);
>  
> +	arm_smmu_attach_commit_vmaster(state);
> +
>  	if (state->ats_enabled && !master->ats_enabled) {
>  		arm_smmu_enable_ats(master);
>  	} else if (state->ats_enabled && master->ats_enabled) {
> @@ -3162,6 +3172,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  	struct arm_smmu_ste ste;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  
> +	arm_smmu_master_clear_vmaster(master);
>  	arm_smmu_make_bypass_ste(master->smmu, &ste);
>  	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
>  	return 0;
> @@ -3180,7 +3191,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
>  					struct device *dev)
>  {
>  	struct arm_smmu_ste ste;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  
> +	arm_smmu_master_clear_vmaster(master);
>  	arm_smmu_make_abort_ste(&ste);
>  	arm_smmu_attach_dev_ste(domain, dev, &ste,
>  				STRTAB_STE_1_S1DSS_TERMINATE);
> 

Thanks,
Praan

