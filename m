Return-Path: <linux-kernel+bounces-286970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF09520FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5D41F23019
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9E31BC065;
	Wed, 14 Aug 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2snk5Th"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070111B9B2B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656178; cv=none; b=Tv8T+BGDwUmKxDUA/h1TZV41r1W/1mPWlLb9KCHKtA4W9VUagwc57VYBduYmO9zmAnGWhCdwmhFyEFnTdfRPdla3XNI7TbXC5glFypvAJn0+x1AghzYDEdLVm1O5iuLn4WNf2JL/p14bmcbasqQI5INctdoh1Qrfe+oCsNMym7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656178; c=relaxed/simple;
	bh=f1RmKlqVd2mEVwfc2Sh+M2IKkmy1k3LlwnHEvoWTbqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJtW6wb7a/+do2fZy53FLuI5NH8LIuo/GbANgDXDTMFPFXDbVfPeJzWzZP+oxEL4gRkOaSZvOwudnotPg5m0Swb31Ds9eM4qPbOrnZ3dvYOAhegJHAZ0qamqylQGifOTnma5ugBq1+fMk5qcaj9OX7HACNiKZJtar2cZgS+COiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2snk5Th; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-827113c1fb4so9947241.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723656175; x=1724260975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1orJ6nO6ZqFwQLaPKdFYgCrAZEOYItqQBupC7tbBRhE=;
        b=D2snk5ThFVcd65AiKML2/U2T0VeLLX97SXy7BLD3PC1rKRlOjehSp18iJgG+5snpli
         BP52rAfUtmHiHcwnDSPsnO5LrDsGpj995mrMssn4/ztd66/YGAv898sy3UKwpCl/SeNJ
         nV9rhj8y/t8jmPyXXjs/e3e6XMFmxNU2ztRVKr4CgVDCYAWe3y7R3WcvFjhlcwCGPI2z
         pudjwMoK5gMF7lWNsNMHDVwfXUIjfnSSgWcqslaA/gU7ulcJGyz122hLnN+EkfVhcChC
         wT29XSSUycG1KrNG6VOqfFTvt2OMreE1pCbnn78o6JMPMRRjWTBH2Zll76F+Iw1lxxuA
         vODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656175; x=1724260975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1orJ6nO6ZqFwQLaPKdFYgCrAZEOYItqQBupC7tbBRhE=;
        b=fEmQya6i/LFETtNsTScsif+UZ/X0JCLnHM9JlXx7GLy29bMfAqYF8jsiQCf6sgACfR
         lkPTJ3dVv9WYyIsw5b3y89lVXWWC/pLh3B1CpMQM4hQsqIDIGSnoyGS+STCyt0FNKFeS
         YH0Ngmui3BkBkFgXzk+LjJnE33/QTyFlaesZmjBGbxCypUt14RzzzmMPjjSXU4IKOZ7E
         uYtFc9M564ndy378drIkoRoyZXHM5pmGVZZhFFzd915dHq//zaOU/Vrini0ZkZt5CwpD
         9rvIwwFLigCm5CRo/gNOzRyCoTMmAZgpDLxqx7N60mL04fVDWIbo3MKSvZJMIC7gjoaS
         jVYw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzfSFKHU0/hB/K8koHkSUx5Ya82WZXx01OAzWFoh97XfzoTCJ5f07SC94SDMZsKOHB1TsIh3+/S749A7Sm1Fc5ZNqpZXhrLgfUPtD
X-Gm-Message-State: AOJu0Yx8/POM2aIriK6+KKFnpMAbgAc8V9kTDhd9Mp1CBBnbvhYE4MZ4
	XE/v3R99nTCFiTGPgQa3nPuPDkM+PxtzAQurEOgYvv5l35jU1+eOYHIrzcylY2ljd7Vbsa8+aeX
	pmYbuqeMgsYBxwR6soRymmfSYrBbxfA4nRlaXcQ==
X-Google-Smtp-Source: AGHT+IG3b3VoA49ASMXUxYJgavmQR8JbYzZCSLToVi6Teklw6eT/Mpr/6/Fk5ShHKZ00PpJjOdB9b0Ong6gjAsG5qt8=
X-Received: by 2002:a05:6122:3c89:b0:4f5:f65:26be with SMTP id
 71dfb90a1353d-4fad17773b8mr5087403e0c.0.1723656174948; Wed, 14 Aug 2024
 10:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-ufs-bug-fix-v1-0-5eb49d5f7571@linaro.org>
In-Reply-To: <20240814-ufs-bug-fix-v1-0-5eb49d5f7571@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 14 Aug 2024 22:52:19 +0530
Message-ID: <CAMi1Hd04z56++7cj+w4=fyi2ov42OO6mAnDbkw5CehJw+fJ8ww@mail.gmail.com>
Subject: Re: [PATCH 0/3] ufs: qcom: Fix probe failure on SM8550 SoC due to
 broken SDBS field
To: manivannan.sadhasivam@linaro.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Kyoungrul Kim <k831.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 22:45, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> Hi,
>
> This series fixes the probe failure on the Qcom SM8550 SoC due to the broken
> SDBS field in the host controller capabilities register.
>
> Please consider this series for v6.11 as it fixes a regression.

Thank you Mani. This series fixes the UFS regression reported on
SM8550-HDK with v6.11-rc2.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (3):
>       ufs: core: Rename LSDB to SDBS to reflect the UFSHCI 4.0 spec
>       ufs: core: Add a quirk for handling broken SDBS field in controller capabilities register
>       ufs: qcom: Add UFSHCD_QUIRK_BROKEN_SDBS_CAP for SM8550 SoC
>
>  drivers/ufs/core/ufshcd.c   | 9 +++++----
>  drivers/ufs/host/ufs-qcom.c | 6 +++++-
>  include/ufs/ufshcd.h        | 9 ++++++++-
>  include/ufs/ufshci.h        | 2 +-
>  4 files changed, 19 insertions(+), 7 deletions(-)
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240814-ufs-bug-fix-4427fb01b860
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>
>

