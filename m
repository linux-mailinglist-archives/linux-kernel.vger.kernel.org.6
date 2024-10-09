Return-Path: <linux-kernel+bounces-357122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8660996BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9D21F2763D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59FB18C92A;
	Wed,  9 Oct 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd9GIFDH"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036B195390
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480239; cv=none; b=RKUPN6MhuuLk9eA31enTsjrbsoPVHScUK/E/QWJNvIqtV49d19/MuKwhAsAhtoySutXVP+hT/enSzJuuIEXzKw59MEOu0kLL4VLvD/DAwiO0WoyzNTKisKMz605Fu0AvWyPT1RlLtRPkGeqFLc4UGcfmSHC4VLg92fMYHve79kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480239; c=relaxed/simple;
	bh=hCS7BTVujCtp4m6ljZNLdynbztIjz790mAoDFaqAogs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+GMLOYdA3Q4snJoV9RvYDJ933Ad9i6wTey1QQBUWyAPhtli+icYZ9sw/EUn3RfckNMQLxkuGrMn+CQCVfH3yRjPoAu0RE5KZW71bU6lWsOos9YVxev90tVTu1A13HmKE8ctrhzuAyaxphoHXNWMJ9BG5UXlfXe5vd5uHNnfd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jd9GIFDH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2904ce7e14so492457276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728480236; x=1729085036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eKg7bGv/gDwJ8Dj8f1rz2qShUBIy5wA6pg80JRqhvBw=;
        b=jd9GIFDHrIh9UNCbtZ6Hyz7OhPAYjdrg5W+G5SnJbMCud9AyjG9RQPm/WkWVNYcKZu
         91La/RRVirAMuFoReGdRujb7qLKZqcUZbfxukcOHXh7mnFg1neAeJJ2xmAv8KFg5tn7c
         JuuiPqaqCyPUMm6xzW2f7C1Bed5Ws+PeE8knEhuVxCXJ/QrcXCA2fwtzqbkAu8V1farB
         qU1k9TKvzS6Y8cnaTImDebEnFfgmbVYW08xoE7UUNyRRz9fD3pZ/+N70KtYAlr1CUxZy
         3S12fkRXlgQ2D7EwZBf1Xhw9GSixYf2JIdoiqK5R2ChEI+3Ds+7Vr6bxHSklH/16CyE8
         7Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480236; x=1729085036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKg7bGv/gDwJ8Dj8f1rz2qShUBIy5wA6pg80JRqhvBw=;
        b=TRG5KpjH7tBHsbGealwFu6G5v8pq9MvURIS7oG4jsPEfb5qclKEsW/ZTBqU4D5fyFa
         HkHyT70CjJpo76z0vQ5Mhx4e5mKvgNKoLuGkY5kofUByKC39dShURnFa0rkDF9fZ2ZKn
         StasCmThnkKx0kI6l0LKy1LSH8fMKX7UlQUSbFIYWl97S0gM/o8PZ4N+k0uVdAt9oC+1
         ANESD+Ye8A1RbCA8DjzzAv+ikMhplv8S9tNUMGR07rHZ7if4LqK4OSuwJpTZN2Kxdept
         OZLzTGb7PfGB49TB9Y8zp1TT1RmexfBeKlRFjdTzAIfYd04Qxvwh9siVEup4vJPDpLWM
         oumQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwldQ2DUJU512IpnjLXCfI1omAsomj4/xsSXh/PsNdevHEIRzj+qgE/vCZ2t8/IuYriN3G+nbjjnXbu8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyEYl+hsFKHNzDKDnAR9ocqb1BKqdwT2WLv5Iw4cakSlqpWxd5
	CsnWdd7d9JjjZQyihNVvybJuM4HSwIPl/LCmGOM3B5DKW90xbDDpzn3AzlgRsIr2oaXgeMVGJfy
	kWR7tdxKYqbIA7bWy01gKXyKxop6BpEfxkdv4Rg==
X-Google-Smtp-Source: AGHT+IHdjIJEGNBc42+O7+FXjnfNDEy5mnh1GgAZbWvtts8h8pDmYrsy1bp7WIFON/JsxIYQBTwc7aUIRRTMf2jauEU=
X-Received: by 2002:a05:6902:2b8d:b0:e28:f7c9:49e6 with SMTP id
 3f1490d57ef6-e28fe41eae1mr2537348276.8.1728480236424; Wed, 09 Oct 2024
 06:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com> <1728368130-37213-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1728368130-37213-5-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:23:20 +0200
Message-ID: <CAPDyKFprgKOBGnnvJUvVxXUTPEHGJMXXQa_HssXxEt01aBRoVA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] soc: rockchip: power-domain: Add
 GENPD_FLAG_RPM_ALWAYS_ON support
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 08:16, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> If low level driver claims to keep its own power domain always on,
> let pd driver respect the flag of GENPD_FLAG_RPM_ALWAYS_ON.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/pmdomain/rockchip/pm-domains.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index cb0f938..b2bb458 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -621,6 +621,9 @@ static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>  {
>         struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
>
> +       if (pd->genpd.flags & GENPD_FLAG_RPM_ALWAYS_ON)
> +               return 0;

During system suspend, genpd may try to power off the PM domains that
have the GENPD_FLAG_RPM_ALWAYS_ON being set.

It seems like you need to prevent the PM domains from being power off
during system suspend too, right? In that case, why not use
GENPD_FLAG_ALWAYS_ON instead?

Or maybe the use case is different, let's continue to discuss patch5 first.

> +
>         return rockchip_pd_power(pd, false);
>  }
>
> --
> 2.7.4
>

Kind regards
Uffe

