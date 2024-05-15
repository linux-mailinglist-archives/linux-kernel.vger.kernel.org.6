Return-Path: <linux-kernel+bounces-180081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCEA8C69DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3752283E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C2156221;
	Wed, 15 May 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dndI6Y3x"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143F155A39
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787661; cv=none; b=RzDkg1UhoDW5U10MuqFAIximANREHe+2/lBbRAoc3rcLMjGr/AHN7xa9Boe1hIyS7cMI+r54ef/eVC69fdI2/JcQjshn8I2xO+FrDk/mTYEctnKyYGUXySGUyhNJ78I0BAKDstkSCLN4hbDWto0IgXBcKUVODbTlRbO2OlJT0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787661; c=relaxed/simple;
	bh=Lf2nT4HegNDNqGDTyxgxTlXmuF0Xo/B3kUCwsMk/AxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZUbp6HFvUalpb/ZV+UUeCLQfkvN9mw1+4WmDghGsyNMF7IeSphRxeyamvnWsiGFw/zJi0stzZ6cl8p/MQg6I3YIj2DBh5cM4Q0oCOgdmGGzPe4lIn4f1JjWS2elmcCmFYoV3XEFSpJXjTb9iX8C3NFE2WlHHh3e1lCE1WB4B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dndI6Y3x; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41fef5dda72so311695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715787658; x=1716392458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vO+JXqkTWjh4IOLAvLgHOUrmin8Jhsgi5Im6h/wkV6k=;
        b=dndI6Y3xMpZrvKrZp5aegoAU4WhjzqUVwZBctLPCg/BS1lUOkLnFIYJT9JSirBgk2I
         RgJlCcOy+61djQ7mT7rB+2pim15a4xKSfdqx///yz1IT3djsrY+Tp2+vH5pY497qRNuZ
         F5I/RAwOUAMbKLHVkdpUXZqntOJvlC01Uz6L/WWeIAQlnhAfUi7JS4dRs+vxmz4pNdAl
         UW9uUhxlLC8TX3XpxBfX0NVNle++tdLCPEx+BsmyJGufYTKBuUq3mVqQQao4KQuCK9Pq
         zJqpQFzIAsqIJOSBbxjqSaxAqF7ydCTjrxqwU0vZpridrj5bjdKqKjjnLsNSUTs/8+k+
         AWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715787658; x=1716392458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO+JXqkTWjh4IOLAvLgHOUrmin8Jhsgi5Im6h/wkV6k=;
        b=XNs9GgzGqEB7J7PfjHO4b10ezVWl7TZWGkhew5AFrGSPfiOwFt2VYprDQY57/IeSmP
         JojEG9HF45JqB+NkFLO2QzAQfmnsUbEuPi7u26yBrlfRfa84vNTCmkWThMYeNHzpxcqj
         9UHtRBnSPCthi0Oa3fth3Q4rb6EJGp3dpQySAiLXg1jWorBsl57fueDOEYAY9QEVcKlL
         8/cPsULwBreYuXw0IHfJzaq8k0nLYcGVAXAUbkscthPl7Mpx9/jcz+pDp8w4djnwxvfE
         ijk2WIQlvq7HvLwml0idynqo2YEIMfJlr8xWuBXR0OxVYMvDgo0dBOh9kfpHsMOElW2b
         KAdw==
X-Forwarded-Encrypted: i=1; AJvYcCWy3cy2fVyQai98QiRxBMnhpBCe4UeJusCBUepredcvZVambYrhh3h1z/TS91YfIOWypD0m97vAzh22oBuOlEd0vZ2RqEbexEzJ0k1F
X-Gm-Message-State: AOJu0Yzk5nosDzgu/hRMbWZQeGequMYGHMGZGTzdwUHcgc2eq1Ryv0VD
	KYopLGFU6ZWRDnT5Hp6HpN0lDuGZbZyeGW9dhwxMQU7WsVYn/3IaMAz3ZvYl1w==
X-Google-Smtp-Source: AGHT+IHpV0wJBjkz/uiNnJbApuw4cK0JvcZtxkvSENnR0QDdzmWnFUZlqPQiOoJqXfr/mDKKEF4FGw==
X-Received: by 2002:a05:600c:5010:b0:41b:4c6a:de6d with SMTP id 5b1f17b1804b1-4200f8b159fmr8618745e9.5.1715787657840;
        Wed, 15 May 2024 08:40:57 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014c21260sm125210465e9.3.2024.05.15.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:40:57 -0700 (PDT)
Date: Wed, 15 May 2024 15:40:55 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZkTXh_m9F8VA2dds@google.com>
References: <20240418163025.1193763-2-sebastianene@google.com>
 <20240418163025.1193763-4-sebastianene@google.com>
 <20240503150114.GB18656@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503150114.GB18656@willie-the-truck>

On Fri, May 03, 2024 at 04:01:16PM +0100, Will Deacon wrote:
> On Thu, Apr 18, 2024 at 04:30:24PM +0000, Sebastian Ene wrote:
> > Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> > and copy the response message back to the host buffers. Save the
> > returned FF-A version as we will need it later to interpret the response
> > from the TEE.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 023712e8beeb..d53f50c73acb 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -674,6 +674,49 @@ static void do_ffa_version(struct arm_smccc_res *res,
> >  	hyp_spin_unlock(&host_buffers.lock);
> >  }

Hello Will,

> >  
> > +static void do_ffa_part_get(struct arm_smccc_res *res,
> > +			    struct kvm_cpu_context *ctxt)
> > +{
> > +	DECLARE_REG(u32, uuid0, ctxt, 1);
> > +	DECLARE_REG(u32, uuid1, ctxt, 2);
> > +	DECLARE_REG(u32, uuid2, ctxt, 3);
> > +	DECLARE_REG(u32, uuid3, ctxt, 4);
> > +	DECLARE_REG(u32, flags, ctxt, 5);
> > +	u32 off, count, sz, buf_sz;
> > +
> > +	hyp_spin_lock(&host_buffers.lock);
> > +	if (!host_buffers.rx) {
> > +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> 
> This should be FFA_RET_BUSY per the spec.
> 

Good catch, thank you ! I am fixing this.

> > +		goto out_unlock;
> > +	}
> > +
> > +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> > +			  uuid2, uuid3, flags, 0, 0,
> > +			  res);
> > +
> > +	if (res->a0 != FFA_SUCCESS)
> > +		goto out_unlock;
> > +
> > +	count = res->a2;
> > +	if (!count)
> > +		goto out_unlock;
> > +
> > +	if (host_buffers.ffa_version > FFA_VERSION_1_0) {
> 
> The spec says that the size field is populated based on the flags
> parameter. Why aren't you checking that instead of the version number?
>

Right but the flags were introduced in the latest version (they were not
in 1.0). In 1.0 the content of w5 is reserved and this is why I need the
version check.

> > +		buf_sz = sz = res->a3;
> > +		if (sz > sizeof(struct ffa_partition_info))
> > +			buf_sz = sizeof(struct ffa_partition_info);
> 
> I don't think this is right, as if the payload really is bigger than
> 'struct ffa_partition_info' we'll truncate the data (and you don't
> adjust res->a3 afaict).
> 
> Can't we just copy the whole thing back to the host? We're not
> interpreting the thing, so we can just treat it like a stream of bytes.
>

Let me rewrite this. You are right, we should treat it like a stream of
bytes.

> > +	} else {
> > +		/* FFA_VERSION_1_0 lacks the size in the response */
> > +		buf_sz = sz = 8;
> 
> Can you define that as a constant in arm_ffa.h, please? It's the size of
> a 1.0 partition info structure.
> 

Yup, I am adding this.

> > +	}
> > +
> > +	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);
> 
> We should bounds-check against 'KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE' and
> return an error (FFA_RET_ABORTED) if the size is over that.
> 

Thanks, this should work I will do this.

> > +	for (off = 0; off < count * sz; off += sz)
> > +
> > +		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);
> 
> I think this is wrong if bit 0 of 'flags' is set to 1. In that case, I
> think you just get back the number of partitions and that's it, so we
> shouldn't be going near the mailboxes.
> 

I removed this, thanks for the review !

> Will

