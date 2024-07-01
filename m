Return-Path: <linux-kernel+bounces-236926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866D91E8AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F5EB214E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EC16F84F;
	Mon,  1 Jul 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkYrT3Z+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869316DEAD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862447; cv=none; b=gB5uNrUdjlMka/5HUC42P8BEUYI65EuHAHIPe0Zervn/ohbzeBwRQ5YLIERi587pec6TCaFMPC2kycVvXnnS5RkKgKtXLS6m0GHoiyUKrBfbLsgPmSs1ypueUc/UPeOlIZIaxQNZp5nr1POUFI6L59gILA4QVJ/xc6jZ22ID1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862447; c=relaxed/simple;
	bh=GqWUmN8vicjOeJLEWfrNOVZ7nMrI1gyKg60+lcC4I1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtGQxU//2OYZygQIX1Jq7ZWrSGy2+tCT4txl0cOjzm3zcbWdOB2BKnpENFM7q/jwuS6jf611MAzlUMc3GePiMeOyi7L64OSWvxrLu2waiFUyA9wSmqziIjzwgYyrA1BGanUQ0iSZLHiwdnDwug6BluYayxOcZw1HMAbhyYQjQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkYrT3Z+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so10918a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719862445; x=1720467245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLv8nBE8MAPhTzu4Pe0VYjku1Tl2AHNOOkQcp9/ZdEI=;
        b=UkYrT3Z+TEeHrV78imRJgHbDy8CT1OVHRqGhXNg+5ATAbTL3UH/C4ewstxiqyPZp7A
         aczq0w5SpV3trPgfrzNI7jBSQqFdFbfBow9l6Im4m66vk0oEPkLGt1LfkZ7jCJXDKzzQ
         //BrzNfnG4N0cdqi9rHqvqPL94qoYJWlTU+xYqPggQ9W5sswxNNvN3VAFt54bB91cepn
         q8BIpZh82cq0z1+0lOT4jxR/7yMzDS8qoDZLRElRR7eYz47BNd76XCbh+7qqG2uU7VRf
         h4hSHI96jdo5/CQagFlXbhZKFtUxUbO+WtAiKePC3deik3cWfrk4sEjNLLNkmkSucWC6
         mtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862445; x=1720467245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLv8nBE8MAPhTzu4Pe0VYjku1Tl2AHNOOkQcp9/ZdEI=;
        b=Sfpw4WES17PLr8i2srLb3MFkKId4bAiipmEQjQvvVKW6g3ZMkMau776MWCrDDsAPlo
         GdULrVrOQ9bem/Oe/p8f9ZMn3ISkQsn0OMkXrjbGQSQWaVyBfQqsrATQAat9q6rfsC3g
         he7Hl2jLv3S6bwdJykTsa4g3GwstCymnNWnQptlGqlZ1fBG5dPhoTap88U2KH56YWQBo
         gqWYdI0/j05k02H4LWufOXi4c41AkjI1SCb1+ceBG2V2OaIAqsieLxq9DXOS2TvyqCPV
         bjxm4kJ1vteMWgkG15v1fdV749i8vC4RyU96Ae2pxz62Ii0fplMxXLPOXGHpOr3N4dB8
         a4tw==
X-Forwarded-Encrypted: i=1; AJvYcCXxAdn9q7WoGYAEY0D6f2Cf0NT/37ATRKow3QjLfdTMDt1xMWU1F9Fa9CMJ34zNiLyN8iJ07fITV60I/s9lzQgIRCUKYLloHmme3mwf
X-Gm-Message-State: AOJu0Yyk1nR9z8haSQkypOyNZKU5dqBgN0xdodZydXxuSZMZARLHUjSv
	ja7AI0L4OeTmU/C8UiJWAbQtkx2IfIS388MxI0PDKC8Yh36ep4DTb6AlQ+afViHAPnTflPIxuDm
	ZG7pp+7fDyEKPFMjHSEy5LRub36TwemvEwilT
X-Google-Smtp-Source: AGHT+IHXcfFF7nEh7bzw1aPRlCKzpCzTU07EXQDKT9/pl7Y576hP+SUgYE1Vu8uRmhB5tC6qEWbDsk816Q4QLs3uQtc=
X-Received: by 2002:a50:9308:0:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5872f79a720mr442372a12.6.1719862444542; Mon, 01 Jul 2024
 12:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701162025.375134-1-robdclark@gmail.com> <20240701162025.375134-3-robdclark@gmail.com>
In-Reply-To: <20240701162025.375134-3-robdclark@gmail.com>
From: Pranjal Shrivastava <praan@google.com>
Date: Tue, 2 Jul 2024 01:03:52 +0530
Message-ID: <CAN6iL-TV3OGN4eDx6yG9u9Y-2tEn6NS9B3Vq5ijAoFvJ71PssQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-qcom-debug: Do not print for
 handled faults
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:50=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Handled faults can be "normal", don't spam dmesg about them.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index e4ee78fb6a66..681fbdfc325d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -419,10 +419,6 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *d=
ev)
>         tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, iova,
>                                  fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_F=
AULT_WRITE : IOMMU_FAULT_READ);
>         if (!tmp || tmp =3D=3D -EBUSY) {
> -               dev_dbg(smmu->dev,
> -                       "Context fault handled by client: iova=3D0x%08lx,=
 fsr=3D0x%x, fsynr=3D0x%x, cb=3D%d\n",
> -                       iova, fsr, fsynr, idx);
> -               dev_dbg(smmu->dev, "soft iova-to-phys=3D%pa\n", &phys_sof=
t);
>                 ret =3D IRQ_HANDLED;
>                 resume =3D ARM_SMMU_RESUME_TERMINATE;
>         } else {
> --
> 2.45.2
>
Seems consistent with the arm_smmu_context_fault handler.
Reviewed-by: Pranjal Shrivastava <praan@google.com>

