Return-Path: <linux-kernel+bounces-240966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399B92751E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71F41C23F67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917931AC459;
	Thu,  4 Jul 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEkAuid9"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1D1AC449
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092376; cv=none; b=FZtxRsOUWu5y8wTF9xm28qjy5wFymvwQcMS2/8uEltsQKGajNfL5IoNb1DN9VAeEyLxc0H9triiDsdESCkv0HEOdfYiTefdxgJ3PVtxknuliavrrhLNuFquqrRpc2HBzQfsvlv6PxtY4+xdsUmSBTFZC3J5T/zqWUOG7JprarmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092376; c=relaxed/simple;
	bh=Dg3JTq0ZBWP2D2Vr8U1r3aGFATnfejdOWc8Xk9rIx4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqrS2yb4pClqIr6GoCtic5jb8us2iTEo4gmbrVDAm1BGMq9MxTGs5aQ5ohkQfNcuH8odPHie9J4X2Zx1EShqnRj66DOjMqkQCePMGw26cQuqEQ5gQCn+xmCrXiDHbWZXx5HkazlQS0TBADiIaXAa10uvG7UYic6Gho2uCltQ2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEkAuid9; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b101294c0so4784807b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720092373; x=1720697173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz4auga2ihI3UY4J8JDbIVFDxmJf4jQfyvh3R1LfKJQ=;
        b=mEkAuid9SZNozokiF88nNNapNf46Jynmz0sjs+tnMynRIs/AW9CovslVAiwuYz4n8x
         dqt9vS9r6l5GotCvJJm8X1VKvtJscvyUkl6ytG10fAPCoWbdhPMDRhvKPaB+Sc3dpxRg
         VoctEsBhNwW1nFoJuYTvrbHHGW2gQ8pm/5LoI9z9Mvxph/Xm6SnjvoWIXvcNjpbUqKSq
         cZFd4qWO2liLWHS3iOhTw9BvhG/EEdMrU6MjXkTejm4Mmjqq9YizexeyoaZL39qS45GK
         ORXNvXRiepWpsPP+Z1/CexRVcDtVU0PLrTS7tXrBf07CGh9iXknnTeJhCe8BSQwCF2IS
         SCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092373; x=1720697173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz4auga2ihI3UY4J8JDbIVFDxmJf4jQfyvh3R1LfKJQ=;
        b=aiMOOyuH0aBVvWu9akENXpFT9oY7vAJzS8k5AgyPb8UBl80HePbqWtmSjrNNFbi21M
         wAsdw4k/a79XXeBZ8KKKpFnJAF7mA9aOoKgheweZ0SViFUrwe7sPQVPf8Aq3D6/CaFOa
         Cz86YGFMl45V2CLoftPW7u8ArXj90IRoOD8VdYMnfFpPJuRA+BQVI7z2kBwSD1i2Cusk
         BYiCmkhwgLSxHD3F4yiNGeM2KOY31jHDGgBG+anFYqKT/t/lzHGDzpYViGlA2Ozu//40
         tYnbP19G5k+xDnoNzIrjI675hHixPtWct4mPf4BTbze3osD3o10ZEQtc80UVfKRik3nE
         EGlA==
X-Forwarded-Encrypted: i=1; AJvYcCXqnn0g9Hb7EuGrWetqjE/gTyOfGKnnWkq/CFNhwuJOYMRepQ+EH9EadUtqCq4HLSduIT3HkUVpI12f5PStkyjgGjev5UbxW2uj40+u
X-Gm-Message-State: AOJu0YwYCyBTqW6nof3KO7oV0TgCDkBKajs0FMm5LXzRIXpdnWIMyFQG
	Swj3dAPDaVm7+zdEHbZhlDdzTMYbZUc05vOS7yv32XqMc+yMJRe8mhRcV4c5Q7jom2qmy2ZgQfK
	eexu+LreMDM5lvvoxq1T78PkhYp3uHOuMbSELow==
X-Google-Smtp-Source: AGHT+IGUuy8LiMm7CRx7RcUn3ERP1YBHOTaS7EuRnYAtXbHY8JFSwXprjEPPOPd0GIcSCtt0Mrw7VgCiJ21+Ale1Jug=
X-Received: by 2002:a05:690c:6801:b0:62c:f82b:553f with SMTP id
 00721157ae682-652d62e4a62mr15119967b3.31.1720092372647; Thu, 04 Jul 2024
 04:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-5-quic_bibekkum@quicinc.com> <ueuhu5xfzp2rnuxzeqqd6cho476adidztgx7oq2tbiufauv6h4@obblpxvqwnno>
 <6da77880-2ba4-4b02-8b3e-cb0fbd0a9daf@quicinc.com> <20240703130209.GA5750@willie-the-truck>
 <6ad2e62d-8672-4b64-848a-6634d7a9410e@quicinc.com>
In-Reply-To: <6ad2e62d-8672-4b64-848a-6634d7a9410e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jul 2024 14:26:01 +0300
Message-ID: <CAA8EJpqDFeCVEiuVM4RJoYPVjRn+PNRAYbe3RcFdDsDTj_Gkwg@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] iommu/arm-smmu: add ACTLR data and support for SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Will Deacon <will@kernel.org>, robdclark@gmail.com, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	konrad.dybcio@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 at 12:12, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 7/3/2024 6:32 PM, Will Deacon wrote:
> > On Wed, Jul 03, 2024 at 05:45:23PM +0530, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 7/2/2024 12:04 AM, Dmitry Baryshkov wrote:
> >>> On Fri, Jun 28, 2024 at 07:34:33PM GMT, Bibek Kumar Patro wrote:
> >>>> Add ACTLR data table for SM8550 along with support for
> >>>> same including SM8550 specific implementation operations.
> >>>>
> >>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >>>> ---
> >>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 +++++++++++++++++=
+++++
> >>>>    1 file changed, 89 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> index 77c9abffe07d..b4521471ffe9 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>>> @@ -23,6 +23,85 @@
> >>>>
> >>>>    #define CPRE                    (1 << 1)
> >>>>    #define CMTLB                   (1 << 0)
> >>>> +#define PREFETCH_SHIFT            8
> >>>> +#define PREFETCH_DEFAULT  0
> >>>> +#define PREFETCH_SHALLOW  (1 << PREFETCH_SHIFT)
> >>>> +#define PREFETCH_MODERATE (2 << PREFETCH_SHIFT)
> >>>> +#define PREFETCH_DEEP             (3 << PREFETCH_SHIFT)
> >>>> +
> >>>> +static const struct actlr_config sm8550_apps_actlr_cfg[] =3D {
> >>>> +  { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>> +  { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> >>>> +  { 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> >>>> +  { 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> >>>
> >>> - Please keep the list sorted
> >>
> >> Sure Dmitry, will sort this list in reverse-christmas-tree order
> >> in next iteration. Thanks for this input.
> >>
> >>> - Please comment, which devices use these settings.
> >>
> >> As discussed in earlier versions of this patch, these table entries
> >> are kind of just blind values for SMMU device, where SMMU do not have
> >> idea on which SID belong to which client. During probe time when the
> >> clients' Stream-ID has corresponding ACTLR entry then the driver would
> >> set value in register.
> >
> > I'm still firmly of the opinion that this stuff needs a higher-level
> > description in the device-tree and should not be hard-coded in the driv=
er
> > like this. It's not just a list of opaque values; it describes
> > SoC-specific topological information that should not be this rigid.
> >
>
> As per my understanding since ACTLR register is an implementation
> defined register,
> so I think the placement can also depend on factor of how these
> registers are used?
>
> For Qualcomm SoCs, it stores prefetch values for each client, improving
> performance without defining hardware design.
> Even without setting this value, clients on these Stream-IDs would still
> function, albeit with reduced performance.
>
> The SteamID/Mask pair in first two columns <which is a SoC topology> is
> only used as reference to find preferred prefetch setting for the
> corresponding client on this StreamID
>
> To refer initial discussion and Robin's thoughts on device-tree approach
> for this property which we proposed as a part of RFC:
> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.=
com/
>
> " On 9/18/2023 4:49 PM, Robin Murphy wrote: "
>  >
>  > At the very least this would need to be in a implementation-specific
>  > backend, since everything about ACTLR is implementation-defined; there
>  > could be bits in there that the driver needs to manage itself and
>  > clients have absolutely no business overriding (e.g. the MMU-500 errat=
a
>  > workarounds). The generic driver can't know what's valid, nor what the
>  > consequences are of not being able to satisfy a particular setting. Th=
en
>  > there's still the question of what if two clients ask for different
>  > settings but want to attach to the same context?
>  >
>  > It's also questionable whether this would belong in DT at all, since i=
t
>  > has a bit of a smell of software policv about it.
>  >
>  > If it could be
>  > sufficiently justified then it would need a proper binding proposal, a=
nd
>  > "write this opaque value into this register" type properties are
>  > generally not approved of.
>  >
>  > Thanks,
>  > Robin.
>  >
>
> So as per the initial discussions it felt right to have this data stored
> inside driver.
> One potential downside is that the driver file could become cluttered
> with this data, but this can be mitigated by storing the table in a
> separate file if necessary.
>
> For use cases or vendor that implement the ACTLR register differently,
> deeply involving SoC topology values or defining hardware design
> (something similar to Stream Matching Register),then it might be more
> appropriate to place it in the devicetree?
>
> This is just my understanding. I=E2=80=99d appreciate your further though=
ts on
> this - Will, Robin, Dmitry, Rob.

My understanding was that DT should be a place for variable
information. In this case the mapping between Stream-IDs and the
corresponding register programming is more or less fixed for a
particular Soc.
Probably the only way this can be handled outside of the driver is by
increasing #iommu-cells and encoding these values in this extra IOMMU
cell.

--=20
With best wishes
Dmitry

