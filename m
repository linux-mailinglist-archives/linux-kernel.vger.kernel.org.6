Return-Path: <linux-kernel+bounces-267095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38D940C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06438B281B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF32193066;
	Tue, 30 Jul 2024 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZYF+TH5"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B79192B87
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329414; cv=none; b=Hh0zX1bIXoi+vchQaOv76wCdhf4ZQEhDAcJi1mYeGfPX4AR+cAdrVLiXdncPi20+Q+V123sWvv4zNzzPWZZzGzJL5ne5scDr/LsjfkT2qg6CGasO8iW+yXX8DYqwGQbuiTGeKx+wicNtCPYZzGzVFfCqsJ27Z/HnqBz7zH0TLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329414; c=relaxed/simple;
	bh=uXUztFw01QkDqDbe0WWySrnr+7BYRZVCE4VrF++FLAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cmu5ejSqYKH/IIHMTajwdSPGNFkNPUNS5IN9yL9bhKQCuxXvtEutjaNwhem/qmLA2kyiE/V50H2I2CZV4472mr0BvS+F0gKptMTCmmolak4rI6XMLCLbvBbvMLqgkO7o0R3nqr6XZSI/Ws9RPPYG5hKCcdsIHGGCuIaPulxdpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZYF+TH5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66498fd4f91so27947547b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722329412; x=1722934212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssng55bauDabcCAYBu4bB+fRXg++qWCVvTBlTDvO6F8=;
        b=RZYF+TH5fE+u3jQLqQUssqFb2ghEK/yHVOMQ12FHepfq5LU48VuF5JU9BTT7eMKnSa
         q3fCSaxzl/UgroZKQ+nOgzJ7zpY4mG52lsfKB5yldrj13q7TIl2tNxeUFUywXqgrEAO0
         ORcH5A1XUDzQNlfPZ5f/WgMF3sNqAqF47XWUXClseN1e10r4p08Fr4SegtsW7irVr2CO
         319DZCOCowJ88sVv6LCutf9p0nhcS3roi+1rdCLTCcx0eeyMFkiiWYS4PA1EbEff6eod
         YDHSMhlvhz2576t22bOTr8zHFIxQx+aclbsRULuDUNSgzJwlVyRmL30CMfT2CfT2mcqx
         mFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329412; x=1722934212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssng55bauDabcCAYBu4bB+fRXg++qWCVvTBlTDvO6F8=;
        b=desJJ6DAazZ5IVQ6p1Z2sh4ZUKW4u/MQ3+GE6pmlpUOS0G1n5tooZdpcJmY10xmmcJ
         cr7i0uFwSNj7P075ucYziWY7glc8sHSehB/E+s4Xy7aGODtSgrPvvtDqO0NsK159NV1V
         JnBzNd0LHvgCBSGU1bD1UQqQBYc863Qq9rKpUicFt9nasE5DNvOgJ7Mi4r/q27pBa+C+
         CNDmGNmRfhBu50Sj+Z2Qgb/QyRdGc50Qea7S9GBl5ScKUciG44VZu1PqChEzNLqmSwSX
         CYdHk+huu7cw5nR4uRpT1y+mt5Y+vRxDHETBy9/+Cn4ulf91FhCY1VGQcwHDXQaPGisO
         bGHA==
X-Forwarded-Encrypted: i=1; AJvYcCXr5xsUKvyO/V2UnrcS0ksAYq1HwUh6e10UEERwTYN9ENI5J3FDt6qXh5DSfhvFs3af8uWq6jNQUSTCJbLd9b9wX0CGsGS1NYOuLAY6
X-Gm-Message-State: AOJu0Yzg/elqeszardc09QFxbEr+SWTMurUwgVWapdajfySf0OTx/h8g
	gn1rHh/7LFPqJcWjIJrqkKOimTwUdHbZT8aeqgez097DQr3WYBd6tXnFNaf1oQ1y32BN4Ni4+ic
	mnRCFr5Lh29OIzZk7Gj6Vi/14Lo1zDyAowM9HQw==
X-Google-Smtp-Source: AGHT+IF4zkK+9qcTrEHm26uzBQdqcNqen5+pNAcmX4VX/yw1jKxwy5wBWP+dUke1z+UX+tjIaoXTMqgAaXp37jXJLeI=
X-Received: by 2002:a81:8184:0:b0:65f:a486:5a61 with SMTP id
 00721157ae682-67a05c8a4a8mr115235097b3.10.1722329412113; Tue, 30 Jul 2024
 01:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
 <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
 <CAF6AEGuWULwrJDWW37nQhByTpc-2bBYVv3b_Ac6OCwaJ83Ed9w@mail.gmail.com>
 <CAA8EJpp9zaQSKbis7J9kYTudTt=RFhfbzeayz3b-VbGQENtqeA@mail.gmail.com> <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com>
In-Reply-To: <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jul 2024 11:50:01 +0300
Message-ID: <CAA8EJppZsNTqh_KxD=BWXjmedA1ogeMa74cA=vVbCWAU7A-qgQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 11:08, Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> On 29.07.2024 11:21 PM, Dmitry Baryshkov wrote:
> > On Tue, 30 Jul 2024 at 00:08, Rob Clark <robdclark@gmail.com> wrote:
> >>
> >> On Mon, Jul 29, 2024 at 1:14=E2=80=AFPM Dmitry Baryshkov
> >> <dmitry.baryshkov@linaro.org> wrote:
> >>>
> >>> On Mon, Jul 29, 2024 at 10:37:48AM GMT, Konrad Dybcio wrote:
> >>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>
> >>>> SDM845's Adreno SMMU is unique in that it actually advertizes suppor=
t
> >>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
> >>>>
> >>>> This however, seems either broken in the hardware implementation, th=
e
> >>>> hypervisor middleware that abstracts the SMMU, or there's a bug in t=
he
> >>>> Linux kernel somewhere down the line that nobody managed to track do=
wn.
> >>>>
> >>>> Booting SDM845 with 16K page sizes and drm/msm results in:
> >>>>
> >>>> *** gpu fault: ttbr0=3D0000000000000000 iova=3D000100000000c000 dir=
=3DREAD
> >>>> type=3DTRANSLATION source=3DCP (0,0,0,0)
> >>>>
> >>>> right after loading the firmware. The GPU then starts spitting out
> >>>> illegal intstruction errors, as it's quite obvious that it got a
> >>>> bogus pointer.
> >>>>
> >>>> Hide 16K support on SDM845's Adreno SMMU to work around this.
> >>>>
> >>>> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>>> There's a mismatch in sender/committer addresses but that's "fine":
> >>>> https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@g=
regkh/
> >>>> ---
> >>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
> >>>>  1 file changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> index 36c6b36ad4ff..d25825c05817 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_=
device *smmu)
> >>>>       return 0;
> >>>>  }
> >>>>
> >>>> +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smm=
u)
> >>>> +{
> >>>> +     /* SDM845 Adreno SMMU advertizes 16K pages support, but someth=
ing is broken */
> >>>> +     if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-s=
mmu-v2"))
> >>>> +             smmu->features &=3D ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
> >>>
> >>> Shouldn't we hide that uncoditionally as it's likely that none of v2
> >>> Adreno SMMUs support 16k pages?
> >>
> >> Hmm, that would be unfortunate to have the GPU not supporting the CPU
> >> page size.  I guess we could still map 16k pages as multiple 4k pages,
> >> but that is a bit sad..
> >
> > For now this might be limited to older platforms (v2 vs -500)
>
> In the commit message:
>
> >>>> SDM845's Adreno SMMU is unique in that it actually advertizes suppor=
t
> >>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.

My question is about forbidding 16k pages for sdm845 only or for other
chips too. I'd assume that it shouldn't also work for other smmu-v2
platforms.

--=20
With best wishes
Dmitry

