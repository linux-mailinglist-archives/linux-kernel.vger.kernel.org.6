Return-Path: <linux-kernel+bounces-531996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5FA447A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723FB8671F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E371946A2;
	Tue, 25 Feb 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+90Mwc2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742B19258C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503312; cv=none; b=ladeRZPmn02bYNKgxT7ys1+XeNwOLAfXAzTxW9YYY49hS7hpTQxh+fMU8iNNgxCEgnjNY1cn0AIqqoDEIM6rJJtA9iR/SJi55EiDFXd537U/Ue1iBXHzTpJvfMjJ0y2u318nx/BNfizYi10hvOjc9vnFQ3HLSpWQJpT2gOSgqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503312; c=relaxed/simple;
	bh=SS9kgyaImj6RHK5LJn7d2R6kJ3V1FoRJ0mFcyFKs1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhvmZitxB+QFVdyo8BNlG811EkGctHUzfEe1NvjybagD55BcdeM6CjijyxZlY+7NtBSmENYvShUiaDFKE7cMDjq2T7WSTpfFNCAIiiXWkM5G2W6/QAAxj/L7oFEaO97zFR12CLksWWk3TVxC5DzIcRAs1ZRDp2AqKG/q06+5Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+90Mwc2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22117c396baso201245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503309; x=1741108109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QM6kau2iQ4j6ZEaDdmG4fMZZFTf4UoSv3ypQuKbFJw=;
        b=1+90Mwc2tBTehc48eAdUaVeASRqHpq6148FESDI3wonZcgPuiM8ddmoGqsMMpOOGWF
         RwHdsMJL/7i0ZPXQzGm1EnbMF/WPCBqHcKcSHykx7E6VhAgejGNnmm8aD76BADryfK52
         rDwA/mLwrT/Xv6W7jwP3T0qYWMf6NY3BEdyQRVKYinPBktKurSCW+RYXr4K0g//SjNT2
         V/6qieZycgjxgyBjkYvto6mxcEM5kRgn+QG2LSluWa9LuJcuejeOlWlAQMnP4oB+dx19
         6uklvoKdzZp3m4PV/YTtO9fJ9Kn2ziOW4/OPm36Qil/8SSnyQkFFWeuN7++7MVESIf+9
         KoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503309; x=1741108109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QM6kau2iQ4j6ZEaDdmG4fMZZFTf4UoSv3ypQuKbFJw=;
        b=XDuPTuk6H6MbTYAleQjf4MbobBxoxdK2pOg1ANhFyVVd9hXDm0/LrsmEgMapnVyWoH
         1tL+k24RfMaTjXsYzIE1GKJl78Peut2t0YoUeN+OX0I01fljMEtO4itdtDpi9Vz24Zv6
         /kMa1wYczVGk6FVUdULgj12zLUe+mxv1BoGlIctYyyyJODKVtEpItfBYiXQQB2SuzHpy
         KDAW9hmlGjNs1E/CZp+Omx9OAxOu2WJnfGq39EefU21NoGJsr9HnUCo3Tn6cP5PQxW16
         3KbfJkqjQGuoxv3zZ14rTxrp89cDP5ShbASqeMPJGT4TGXMOilVoXa4Aks2LwrRpMOet
         aeJg==
X-Forwarded-Encrypted: i=1; AJvYcCUl80In3i6Q5hR6juUM6ZDngjTsbLCVH8nCjihCF9jYUJOzg+94YVjMFFE1dGC7auZvARf2PuPvLdl6FRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hfM5FJiM6OqUUAac7RDWGxex3R2UODXot7QkcU//da9oc+65
	ZLC9qp3ltcM2QCOYMWMO5uMrmLLEQGjgInsJ590tH/t9itaj+vwgahygCJDbfg==
X-Gm-Gg: ASbGncv3kCwrLBK4C87JIpgqM9boH9L7Dw1aZ8Yddpicc4cqcmNYCL5IgxHRr4rJliY
	9mxEb2HF9EFFaRg1NGTepk0HTb9SRSfIXUHx+n4H2xgjLs0mcTtWHj92be+WXR+Jwb0i6+ACK14
	3NQYgefWkXGMRwBn/vwAMn1KrCsMjWQSrsC1KLd6TA+OYB8XWA8k8KNg8RWT5Yc/zhfKr2+zZNX
	lbn5P4at6ynrqBC6EdlF1YAvlt2YMAqfUhr7APA0nvLLYQbSjta6HfTUC+0v5EZ4P1zbGtcJ5Rl
	3Vvulu/9HVneYuzdX6kspNd6ZLZmiJNMB67Tu5mmjqWHK1fJOjVQIAJ33HtZ02I=
X-Google-Smtp-Source: AGHT+IHxrabWDtym7s/ddOkqBHoBfq1ZqP6yAIbeWpN90fX7xeP+90KuPUzmekpH3adGkKddVDiEdg==
X-Received: by 2002:a17:902:ec90:b0:216:607d:c867 with SMTP id d9443c01a7336-22307aabb1cmr3599065ad.29.1740503308535;
        Tue, 25 Feb 2025 09:08:28 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9ae8sm1757069b3a.120.2025.02.25.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:08:27 -0800 (PST)
Date: Tue, 25 Feb 2025 17:08:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
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
Message-ID: <Z735AMlhP29YEndU@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
 <20250225160225.GA593877@nvidia.com>
 <Z73yt4r0iDFwbty2@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73yt4r0iDFwbty2@Asurada-Nvidia>

On Tue, Feb 25, 2025 at 08:41:27AM -0800, Nicolin Chen wrote:
> On Tue, Feb 25, 2025 at 12:02:25PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:
> > 
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > >  
> > >  	iommu_group_mutex_assert(state->master->dev);
> > >  
> > > -	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > -		return 0;
> > >  	nested_domain = to_smmu_nested_domain(domain);
> > >  
> > >  	/* Skip invalid vSTE */
> > > @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > >  {
> > >  	struct arm_smmu_master *master = state->master;
> > >  
> > > -	mutex_lock(&master->smmu->streams_mutex);
> > > -	if (state->vmaster != master->vmaster) {
> > > -		kfree(master->vmaster);
> > > -		master->vmaster = state->vmaster;
> > > -	}
> > > -	mutex_unlock(&master->smmu->streams_mutex);
> > > -}
> > > -
> > > -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > > -{
> > >  	mutex_lock(&master->smmu->streams_mutex);
> > >  	kfree(master->vmaster);
> > > -	master->vmaster = NULL;
> > > +	master->vmaster = state->vmaster;
> > >  	mutex_unlock(&master->smmu->streams_mutex);
> > >  }
> > 
> > I'd leave the clear_vmaster just for clarity. Commit should not be
> > unpaired with prepare in the other functions.
> > 
> > It looks fine with this on top too
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Ack. I added it back and a #ifdef to the vmaster: 
> 
> +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> +{
> +       struct arm_smmu_attach_state state = { .master = master };
> +
> +       arm_smmu_attach_commit_vmaster(&state);
> +}
> [...]
> @@ -824,6 +829,9 @@ struct arm_smmu_master {
>         struct arm_smmu_device          *smmu;
>         struct device                   *dev;
>         struct arm_smmu_stream          *streams;
> +#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
> +       struct arm_smmu_vmaster         *vmaster; /* use smmu->streams_mutex */
> +#endif
>         /* Locked by the iommu core using the group mutex */
>         struct arm_smmu_ctx_desc_cfg    cd_table;
>         unsigned int                    num_streams;
> @@ -972,6 +980,9 @@ struct arm_smmu_attach_state {
>         bool disable_ats;
>         ioasid_t ssid;
>         /* Resulting state */
> +#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
> +       struct arm_smmu_vmaster *vmaster;
> +#endif
>         bool ats_enabled;
>  };
> 

Umm.. I'm not too sure how I feel about these #ifdefs _between_ a struct
definition. Given that currently, the arm_smmu_v3.h file doesn't have
such `#ifdef CONFIG`s between structs. I'd say, in case
CONFIG_ARM_SMMU_V3_IOMMUFD is turned off, we can simply leave the
vmaster ptr NULL?


-Praan




