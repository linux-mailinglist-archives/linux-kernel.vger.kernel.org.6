Return-Path: <linux-kernel+bounces-397387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C02D9BDB57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59179284971
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109D188CC6;
	Wed,  6 Nov 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chGKxhm4"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3617B50E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857434; cv=none; b=gnrvmoOVb0uFCCynusJNa6KLoHCsclLTtlG5Mbzpo9ypfZZ49d0X66HBpLCNEmUqXAgRv1wyPq94QbmhV14/+NRUVndxteL3jOMkiCm9Fg9PqTS8wik0xVoRYKDS6s48d8qfV8kcub8U8egqCDtjTJ5w319HkZEYzyE5ylPvCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857434; c=relaxed/simple;
	bh=uV5P/1Uxeb6Q8gAz2rL3UngXzJTvnZaDYnMV708Jv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We835gXXdZDIVMe507/frAVHqtrRcmz3RHVeOLDtvB496tHBajzntL9xfvk8BSSdPFnN+ehpVoO2c7KS6V0DZwLMgPVmJVrkaO7gDjMpaLzpqwavXOtKLBYVvsaEOznFJxMLM4srbSnRc7jn2RFCiHHSDhy6qAqp5BqF5p0Fjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chGKxhm4; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc5b4190eso3246711eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730857432; x=1731462232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yG8jv53AK8R/U67YhXnDA52uUNbJU2dyWkTr6UcdFfc=;
        b=chGKxhm4R3Lu+GT2UodeFSV53HNHOjDSHB2WVta1IPOjVco4kEKzTQ5cwfa1jsjwvO
         3o8J9MWkGVdReRTltJ/16e+ykk7FDexC4R0jQipNcN/MaXg7Mc+BAhtuaeiZTrFUVyAF
         wSNvQVQlaaopfMOVoTWfX/7QyUTYY8w+VzPEENzKo9gj86bpi3BiwN/j27XR7WZvObPm
         1dwzUeTYVRkz5xz7ROyQgFgqu7gWa3xNAkMVZUlrMnoeO0Pu6QZkPo2Gw/RIIgrqJaIo
         9AOm/xpPEUXVBiRZ17zF0GvcndBFhBC9aykTv61vJLV46d96jIueZya2IZbcad13tUTb
         qJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730857432; x=1731462232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG8jv53AK8R/U67YhXnDA52uUNbJU2dyWkTr6UcdFfc=;
        b=EZc+21M6Un1GEcSBrGVEP6HUSB/WgrLA+or5wS5jqzJGsyn7qOSls87kYIggIIBgeA
         KdKH4FplHewJt+osOALczA+ZomSIPfCsT5qWfX8PvetxF3b2uyRgRttCOsqtG6SpMp7j
         swmKKDseqxO+fCx+c++omOK4lccqTJfJoGsJX5Bgr3vji5ERbfmasI9ozi/zE4VFCBRj
         Eom3WTvWCy7t37bS6YytVSx9eNSM7MgdBXgHXHkmpaj4a/UpNgWdT79fW8zAPlA+QVMP
         Qe1P9O2JJ6yl7GTzPEvGNUrs9myA6zoe7KS/PYRCDHWdOTc/3fpIden11XK5BYzLUVLg
         qHUg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3W2dJVdnO8W1jgKsvQbEt6+PUkab0WcKYekK0JckvQSvfYjMmEUuV9Ef/t+7f0sKHy6JlrWeTJHQLb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW83YI9V67xTZLudzcMFNviSgMYcml2glfWqfENLJTf/0AvWZq
	weDquHbphHd3LzZAjRk+fG+pzqyNZSPRt9wmVxEjVBhTdmk2A/xCPlZDNBNv16vKS1jtQ/nr2Nw
	B4yXJoCNF9ERAHznnB+jVNv/8Q7s=
X-Google-Smtp-Source: AGHT+IGBX3Qy0gHZbnfJ0dlUVj0oxLkQ5CnPrtCzD5a9SjWi3pAZZoeCgbcmbNYrXWtedzQhhj/81NXNGq119DaHhqs=
X-Received: by 2002:a05:6820:2018:b0:5ee:74:4d35 with SMTP id
 006d021491bc7-5ee007458d2mr8109318eaf.2.1730857432411; Tue, 05 Nov 2024
 17:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com>
In-Reply-To: <20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 6 Nov 2024 09:43:16 +0800
Message-ID: <CAAfSe-tDhxVQuEpxvCWy7sh122CujdQT_Kq5O6VQ3wFNRn40_w@mail.gmail.com>
Subject: Re: [PATCH] drm:sprd: Correct left shift operator evaluating constant expression
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Karan,

On Wed, 6 Nov 2024 at 02:19, Karan Sanghavi <karansanghvi98@gmail.com> wrote:
>
> The left shift operation followed by a mask with 0xf will
> always result in 0. To correctly evaluate the expression for
> the bitwise OR operation, use a right shift instead.
>
> Reported by Coverity Scan CID: 1511468

Should we add a fixes tag, so that the patch can be backported to the
stable branches.

Apart from that, the patch looks good to me, so,

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Coverity Scan Message:
> CID 1511468: (#1 of 1): Wrong operator used (CONSTANT_EXPRESSION_RESULT)
> operator_confusion: (pll->kint << 4) & 15 is always 0 regardless of the
> values of its operands. This occurs as the bitwise second operand of "|"
> ---
>  drivers/gpu/drm/sprd/megacores_pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
> index 3091dfdc11e3..43c10a5fc441 100644
> --- a/drivers/gpu/drm/sprd/megacores_pll.c
> +++ b/drivers/gpu/drm/sprd/megacores_pll.c
> @@ -94,7 +94,7 @@ static void dphy_set_pll_reg(struct dphy_pll *pll, struct regmap *regmap)
>         reg_val[3] = pll->vco_band | (pll->sdm_en << 1) | (pll->refin << 2);
>         reg_val[4] = pll->kint >> 12;
>         reg_val[5] = pll->kint >> 4;
> -       reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
> +       reg_val[6] = pll->out_sel | ((pll->kint >> 4) & 0xf);
>         reg_val[7] = 1 << 4;
>         reg_val[8] = pll->det_delay;
>
>
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241105-coverity1511468wrongoperator-20130bcd4240
>
> Best regards,
> --
> Karan Sanghavi <karansanghvi98@gmail.com>
>

