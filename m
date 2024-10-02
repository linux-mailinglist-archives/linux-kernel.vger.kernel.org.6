Return-Path: <linux-kernel+bounces-348052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62D98E1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C48B1C22E90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8E1D1E8A;
	Wed,  2 Oct 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Vk2wFtW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5A1D1E84
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891909; cv=none; b=PV6nb+Gz2x2wMwwqGp7zHPyKVxjIqFSCIjWfcDB9IGBpdbsgJDuimJvgTiwWXw4QWpeerMxQTqU1+/UlLM4EVipkGk2LSj5noL+QBw1WrajoZJOCVyOGpO3rekoL5850jUUxiMY6uLB3mT1C/bNJNuiYn7anVwCMM4CGAmAKZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891909; c=relaxed/simple;
	bh=xwkBuhSjkTlBiMz8Xr2IeV1xOh5JXrfBl+ZNGTMHehg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leGza2nbf8nuYYrSSef5nHuocMMLYfPLnuH8vMJG346xIEYMcn43+ICSrLPUDLR8oU6nDUgv1VUFgO0PuD5KthNEOepKZloGf0hZ9RxTpFS3Owz1IVUXqi6R2LnQqBhgV12wK3GrIMJSgC6Getyyfs0d7BfpcGbfV1lt+vDus6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Vk2wFtW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398c2e4118so2654e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727891906; x=1728496706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CmciQRMdqJJmdA+o4Yczg2B0DLFpVISB3vcsHITkRI=;
        b=2Vk2wFtWm4SXEJKK087AuxZRouD0Od0TqmYM9VuJqw9TA8bygF8eDW5FycGwOaWA61
         LOzxd49bAcPCDWOGxZ4mI98/x2QvMzc063NNnNR0SsmYKf1hUr7rqj+1kK2k+JWBqnUK
         TRypFZ1POYjvl+WOsuBUJh1mf/tucTj9DaHKWRaGi3ZnDHgVDeY0iIirwVqTfy/NvodS
         j/yKNcGC35bov26WTfupCox2Nh0+NZQ2p58uV8UiQ46Bf5Z+edSM6YKDqekP9ui7It0A
         qOzunFQ7pMEk52O71oWQIhSnKCyLRXnCpK/BNFOi61Wa9vzw6PfFFU9smCkJoFdLWcYK
         HWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891906; x=1728496706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CmciQRMdqJJmdA+o4Yczg2B0DLFpVISB3vcsHITkRI=;
        b=nuFoJDy3IolY/dX9rgiy/oUFu99R0lsmMePeSpDVMqcbtrliYJneXEHjYpqeHDrGU2
         2aXc7joWOc+mxXHcRhMfQ5BKWZJ6q2abuRmvwjwjF7VqVMdqGghKesV1bgx7tDNU34kC
         9pFccv7gVK9mp0kg3VL2dCJvNPqLVHAC5Yt6NqwwtprbASj8VUzFuMRC46fO/9gF3WTw
         xjhDTByiLV8OL5fQpfYv1N6JsmSb32qOtGDDP5GWPygR4EbJ4HsQH2A+0MURJRIs4gQW
         OH1SnUYA3hiLA4TFXpSovcCDvwS9WkOKNgVYC6zVWHiaR8tnAHei/Vam9YLsraoZ3sZV
         BfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVnMyvsbfcd/33pHReYU7Qc5LOFEAtewoaAn43aSSsdDD7vCMrbPrMlPWyh1MtJscJJZ/vwN01JLnwBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzujeGyJWmaf7QSwFWz58vrXPYiOdmPqcM7q/LbXikvIFiymY7/
	TGgIptZfsitLKu7lLgwm/yak1ZfgsgZcIPHIAKzlQ/Q/MV6ju3gh01/Zgm0yP82mQv2/X7s1VIy
	nwzkAZ6ppZlZxoLKz7bRy1uQUdYAJwtojREBm
X-Google-Smtp-Source: AGHT+IGXB1RimgWc+7vVzjuyh0WZ76qU8lNNL5d2jOOshylw6MgWVFaY5Y1R85PQukBSl6+UxCcB4LX5B2N/nmUYMrg=
X-Received: by 2002:a05:6512:238f:b0:539:9f44:db7b with SMTP id
 2adb3069b0e04-539a6d780a9mr13174e87.1.1727891905550; Wed, 02 Oct 2024
 10:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002015357.1766934-1-danielmentz@google.com> <ZvzGg0P5Bj2sgNZm@Asurada-Nvidia>
In-Reply-To: <ZvzGg0P5Bj2sgNZm@Asurada-Nvidia>
From: Daniel Mentz <danielmentz@google.com>
Date: Wed, 2 Oct 2024 10:58:14 -0700
Message-ID: <CAE2F3rAQ8BpYcZZBS6BfFeZtMkH9LK7WZ7nniJSbTBW4xDq_rQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32
To: Nicolin Chen <nicolinc@nvidia.com>, Yang Shi <yang@os.amperecomputing.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Ryan Huang <tzukui@google.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:05=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
>
> On Tue, Oct 01, 2024 at 06:53:57PM -0700, Daniel Mentz wrote:
> >
> > The function arm_smmu_init_strtab_2lvl uses the expression
> >
> > ((1 << smmu->sid_bits) - 1)
> >
> > to calculate the largest StreamID value. However, this fails for the
> > maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
> > states:
> >
> > "If the value of the right operand is negative or is greater than or
> > equal to the width of the promoted left operand, the behavior is
> > undefined."
> >
> > With smmu->sid_bits being 32, the prerequisites for undefined behavior
> > are met.  We observed that the value of (1 << 32) is 1 and not 0 as we
> > initially expected.
> >
> > Similar bit shift operations in arm_smmu_init_strtab_linear seem to not
> > be affected, because it appears to be unlikely for an SMMU to have
> > SMMU_IDR1.SIDSIZE set to 32 but then not support 2-level Stream tables
> >
> > This issue was found by Ryan Huang <tzukui@google.com> on our team.
>
> There is a patch that's sent a few hours earlier :)
> https://lore.kernel.org/linux-arm-kernel/20241001180346.1485194-1-yang@os=
.amperecomputing.com/

Thanks Nicolin.

Yang, in your change, I believe you are arguing based on the Arm spec
("dest =3D src << (shift % 32)"). Consider mentioning that the C
standard states that this behavior is undefined.

>
> Thanks
> Nicolin
>
> > Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()=
")
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 737c5b882355..b55327d6058e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_s=
mmu_device *smmu)
> >         u32 l1size;
> >         struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> >         unsigned int last_sid_idx =3D
> > -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> > +               arm_smmu_strtab_l1_idx((1ULL << smmu->sid_bits) - 1);
> >
> >         /* Calculate the L1 size, capped to the SIDSIZE. */
> >         cfg->l2.num_l1_ents =3D min(last_sid_idx + 1, STRTAB_MAX_L1_ENT=
RIES);
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >

