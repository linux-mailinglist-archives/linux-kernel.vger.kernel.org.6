Return-Path: <linux-kernel+bounces-406551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B859C60AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868FE283F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5C2194B1;
	Tue, 12 Nov 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD9OQIjT"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D3218303
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437069; cv=none; b=qZEsBkk4Fotvpf7cHYERJms6iDnrh5aFDz9sa4Qskp6odnnODdW7m3PG4iSerIjPElkd4/cMfOWRwchddrZT8OplOiqFWX3I3G9OpcVhEJ8x5zToWf5HIoSPpS8x6Ecdedjkz5xiaxGS0c1UPIpwAOmlJtyb9ldrT7y1nxVN29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437069; c=relaxed/simple;
	bh=umvgPJnmoFbJOcPsEYyj2bEHoUFZgIA/ixmRZhrahOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BshS3mFfG0ayBgrNj26Va0BzeQ/0JQKJbfyAVzRVWmEYECg6BSDd1btUrZIg2+Qe8qCJ9BzVWkRxE6MHvjMatO7M30bINDiPg+M8tO0ZyEK4ZPwuO8vyNQUbMaKZWv4JpIZd+TRPJMpd490gCgHRxiYoh58dogojfhAan48u7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kD9OQIjT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ecaa45af7bso9410427b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437067; x=1732041867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxgsDspc5q1Jni5adG0LIm1mb6Zw1UKHydszhDw5eao=;
        b=kD9OQIjT67qboL5mx8m5olcM1j6SYSRxCXL+CI/AO1awYoAGRJgf1PQG77+2AQZ4yM
         7dhvTsD4BXlulCvoUAKecGJIbYhpUZr/W5DIp1+mfdr/RkKuvnCMzT448YQ793gFCRT0
         wd/jVEh3ra++BM8FDcv81WwoUFeIEv2p5xrQWlY/nfVIj0raj61EgmZs7AN1wwd+MD2F
         M3Jiai+GInlPerq7nzfIakf417I/BmkGmtkDeVVMDifs8IBs6mfqJSNQA9yS+iCEIGTT
         FMQjcvNlLL2hxoG9aj4x0FZSwnB+gDDCzgNLovbqtdIK5HH92i+YqNou46YTVnGlkhQB
         eKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437067; x=1732041867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxgsDspc5q1Jni5adG0LIm1mb6Zw1UKHydszhDw5eao=;
        b=CkNWWkCBE4uZrrqvYslUwUjwES8PxchkADkyZRT7NZ9+OY+P7QNSkcL6vebQCjR+QH
         xzi/sLWPoM+mUfYN2rdBGoXWBu1WlmaQdmhLjTR41RgrmybLwzydfG+B/o75zJDfhjbQ
         aSSCwSOaQ3fKl/VkFq961RnFnd5EzsiqccV52AfSnup58EvGvuxZ+cJdRUP+10uYVnnk
         isfvic/kZZhk53KwAMvu2M8v+57FqUT7JMqjwFjQ5s7qwrnakgP92QDvBi0hTWAEaCML
         xbLOFNbTCmkBaGUQS/qdcrDmZ/VgCXWhoUooyeMz5wuuHmPw6q6zu/8gEiy85ZNUQr6Y
         CvSg==
X-Forwarded-Encrypted: i=1; AJvYcCUEUkvtMDTWu54vjShfQMjffGNfDHpO808mWT46KODYtTVyisFshRR8cjKtHKzQ3cVIPGEOm+m3sgUK/L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybqpOr5FLVYHki3TPMCcgeNHVg1VNpxFDpQ9apqGEjpCzAPFBY
	6WQlRdSMqc4++rpr9gST+BBhNd3DBgK7y/qc7htaUmgAYLVcFflNWFU6esraDIWvZMqJstHihPR
	BM9A0garXjyLdVSjtJFbiTZ4FhSFwWxmRy6m6VA==
X-Google-Smtp-Source: AGHT+IFMWgRdxZRJtK+Lo3CBpB+VX1bBIjkAiyKqAQn28lKpDNF2wtZFNkKRtCi41qnWunWXbKSXnRp5CfqY5x5v/NA=
X-Received: by 2002:a05:690c:887:b0:6ea:7e37:8cc3 with SMTP id
 00721157ae682-6ecb31b89b0mr847947b3.2.1731437067438; Tue, 12 Nov 2024
 10:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241111085039.26527-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:51 +0100
Message-ID: <CAPDyKFopLrZ2Pn66m-CtjDGOEZyiZ+_i8TnnD4KSHpFqCTN7eg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Fix MMC_CAP2_CRYPTO flag setting
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, mengqi.zhang@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 09:50, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> Currently, the MMC_CAP2_CRYPTO flag is set by default for eMMC hosts.
> However, this flag should not be set for hosts that do not support inline
> encryption.
>
> The 'crypto' clock, as described in the documentation, is used for data
> encryption and decryption. Therefore, only hosts that are configured with
> this 'crypto' clock should have the MMC_CAP2_CRYPTO flag set.
>
> Fixes: 7b438d0377fb ("mmc: mtk-sd: add Inline Crypto Engine clock control")
> Fixes: ed299eda8fbb ("mmc: mtk-sd: fix devm_clk_get_optional usage")
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

This didn't apply on fixes the branch, but only on next. That said, I
have queued this up for next and added a stable tag.

Note that, this means that the fix needs to be backported manually,
but I leave that to you or someone else to take care of.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 022526a1f754..efb0d2d5716b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2907,7 +2907,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
>                 if (IS_ERR(host->crypto_clk))
>                         return PTR_ERR(host->crypto_clk);
> -               mmc->caps2 |= MMC_CAP2_CRYPTO;
> +               else if (host->crypto_clk)
> +                       mmc->caps2 |= MMC_CAP2_CRYPTO;
>         }
>
>         host->irq = platform_get_irq(pdev, 0);
> --
> 2.46.0
>

