Return-Path: <linux-kernel+bounces-351436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B180F991132
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D554B224BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131601ADFFF;
	Fri,  4 Oct 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkSCjUsr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCA15A856
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076483; cv=none; b=tyRl8k6qhlK5vGhNk4WS5PMMQtuUtnmvC26cxPRXmuTQjy22cK+kKMqOeuDotvSagoPQEseZpeoMGFkaronD6Xlle9QsdOVA7ivhv1VBWI0M4QOuvtH3dCI31WHkylhq1yBDDY4O4zbUxHzlT1/OFmKN1/P/Hwejb3W4lfzopLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076483; c=relaxed/simple;
	bh=AMSCQYpuDJW7b9njqvI89iAgglL5LwrjRT4hBrKZsDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPsbSC578HF3ciWTk0v4TNJzN6LISgak0tdPGGmaL6eD/ilJdSoUpmAt/aGMoGlj4NGPMCQp9eo261Rnxah1laXfDig7v6qwnGnjLCl0McO5nOIZc0+hqHa4GaDQgjlVQAOz513aSSx2UqJSWfbFzGe9SXiOz1n6uQxlNHnPq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkSCjUsr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398cc8773dso7321e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728076480; x=1728681280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpSzFA0idugtn5xRJRxYzNrmK1BG08Xyqc6JA7sOzg0=;
        b=hkSCjUsr1ZbtjZ92CBIGo2HjAEmoj79H/ZErQoV3WChT98VZV9lNqMNU3f5vApVTRj
         TuMyR32zcO1jnfUbNBUgvzfkSDqMFBw1GviDNg2oiXl5SJS63SmAXDt9I9oczr2FNZNp
         Gl0ScYVb71NFXKnYcKk4BfrINbHN1dss5YhRkA9jx2h3ynjc8RW01icSfITdzxRh1v2e
         IxRYV3VoE2+NOKoV/aj9PSUx+TN30ouqhLN/UfRj7eHv78z0lsfE+RzETSOycm1GN3ZF
         9xRFoGVtfbgJofIgB9Wur35SqMj6mgw/MNRbxoCNJor9At2WtDxurRxrqwvkC6R3NhnF
         bk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728076480; x=1728681280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpSzFA0idugtn5xRJRxYzNrmK1BG08Xyqc6JA7sOzg0=;
        b=psmlwM+zvv1AQbkzhwgWe9uZ2PK94q60G0wGXtoPRBK/ab6a0/jSvp3wDAEAg/G3fA
         w2VwA1pkVQ/jikTfoQNLrubi8sMT3LRfT6nGSaAr2BcvWOm35KzL8nHFFDKo/ZksZYOY
         +Zgo9rSbPv6VNUveYmfns4hviYhUiAr8HIqsiYXXKmBKfSdRe/zy03bboHoVI1kFOEHR
         eLw31wFGCc6GOw4sp3T1JcCSrleW6XrpCSJkcVByx3GJ/TNpumtZovusLM7yvKCo2N5l
         nm1IvcVSFQfuD3Oi9JMTsFFCMCSGIIF9Hs0fmChtMfHUNH15XePzrAY7pVoRoHSIELS8
         tEWw==
X-Forwarded-Encrypted: i=1; AJvYcCXNiu8mvvD0/HH64FPkdCK0Qt0F4ZywMOMJLa31ZlteE1dWLxNW+dsvN6C+UzbKLfLLYK0pBSdg0LmnJtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/ctO/ziJNdbgnMEwUvRcGxowqHnfwbeKvr/rHCK/NST2Esz8
	iZlij5uyg95WtNuXFe8hDEk3ENekdDrij0J+SFjsVize055pP3HpKcY24qW4DeezNUCCifLx0ZR
	dmBca+ealQpZShu7SmWKEsBajYRnVujyFa6vi
X-Google-Smtp-Source: AGHT+IFOeWVleQi6mz54rMySufvSmJUb/qqPeoKDzRHHn4+5H8YGGYkP/iidPh+hM/W92QifNVcnGSW0RMGzbEWLPsA=
X-Received: by 2002:a05:6512:401d:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-539b13aefc9mr21668e87.5.1728076479635; Fri, 04 Oct 2024
 14:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
In-Reply-To: <20241004180405.555194-1-yang@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Fri, 4 Oct 2024 14:14:25 -0700
Message-ID: <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:04=E2=80=AFAM Yang Shi <yang@os.amperecomputing.c=
om> wrote:
>  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  {
> -       u32 size;
> +       u64 size;
>         struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> +       u64 num_sids =3D arm_smmu_strtab_num_sids(smmu);
> +
> +       size =3D num_sids * sizeof(struct arm_smmu_ste);
> +       /* The max size for dmam_alloc_coherent() is 32-bit */

I'd remove this comment. I assume the intent here was to say that the
maximum size is 4GB (not 32 bit). I also can't find any reference to
this limitation. Where does dmam_alloc_coherent() limit the size of an
allocation to 4GB? Also, this comment might not be applicable to 64
bit platforms.

> +       if (size > SIZE_MAX)
> +               return -EINVAL;

I'm assuming this is for platforms where the range of a u64 is larger
than that of a size_t type? If we're printing an error message if an
allocation fails (i.e. "failed to allocate linear stream table (%llu
bytes)\n"), then we might also want to print an error message here.

> -       cfg->linear.num_ents =3D 1 << smmu->sid_bits;
> +       cfg->linear.num_ents =3D num_sids;

If you're worried about 32 bit platforms, then I'm wondering if this
also needs some attention. cfg->linear.num_ents is defined as an
unsigned int and num_sids could potentially be outside the range of an
unsigned int on 32 bit platforms.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..c8ceddc5e8ef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>         ioasid_t ssid;
>  };
>
> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu)
> +{
> +       return (1ULL << smmu->sid_bits);
> +}
> +

I'm wondering if it makes sense to move this up and put it right
before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
functions are in one place.

On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
tables. I'm thinking it would make sense to limit the size of linear
stream tables for the same reasons.

