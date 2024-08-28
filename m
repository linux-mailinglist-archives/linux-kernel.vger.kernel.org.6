Return-Path: <linux-kernel+bounces-305264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5F7962C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFE6285DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562D13C3D5;
	Wed, 28 Aug 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wa9kQkFG"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938B381C2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858639; cv=none; b=CzjKn5dIy1YCHpnH0UtnWXphpCKmde86CqsbN1Q4/c4M5dlKEZch75EhYeZknPy8qYwaGItBc8VKoR3GGh0WbNCrs6WFPjhaUOPbX2DS2jfMC7ttQpDJFMV8xXO2W67WS8ZupiWlTzm8tN2NdX0I+P88i4vefMPP7spd7w8nX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858639; c=relaxed/simple;
	bh=xq5eFf2qa1PgRByiVODCaCeUJJgqbvf9h2fyL1gcrUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1QD4HO0fzcX2pGm5JPfKZFtSfdMAYwG10y0sMU9DducfbQwc3FGi5hYHr+T9ZKv3Y3BHRxheSDk4SAa9me9EbE2MW6+ezzTFROhRH9SKCmJccznnEe23H99uXswgpmAQf4DyhAVVreYI/9IuE+isARW/sKP1kDVlpsj6EKXQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wa9kQkFG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e179c28f990so5826243276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858637; x=1725463437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CG4oTPD0zwywYFWX0Kb6mWWmoLCq85f/1yiRy7yIqc8=;
        b=wa9kQkFGKTDn/NViaH7ZTwagL2INsQc2P40Kdv/4xggvs/9+zh7a7vEOSGdP7NV+0d
         i7FrzwDSlSjuX2bALKHVRME4x73TKCiDkXR87fzeMM9wP6M5M4YmXs1/E3ip7jQwKxS0
         CXtSBErUHLdbodg9f2FOFszBc5xIIFN23HxMY+6il4maPKQtBY6UpzvmkYB8QhXHfPiE
         RxJn99TgFaBKGKYT9r0a3Fiav4pX4Z7IC+1EGlotmvBx0tdkVfloOgc8SxvVz79cDcUU
         HenSMj/u+c1o24WAJZDu+6+2qVE2hjBk67K/PQFvc46R5KHQHHqCpoytCGTe7W9IWNd/
         ymkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858637; x=1725463437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG4oTPD0zwywYFWX0Kb6mWWmoLCq85f/1yiRy7yIqc8=;
        b=iqa2+SqjqWoEWf6BdtyipwuxzsZ7Xu1RAU+cmWKEHExYVn7D3eyhYPiUDyyVuf7B4p
         ASNANBzfVySZMLXyklzNC/0FpVPkbP4uqSX8lvjFWXOEYMq3yH/lz/FaYrppVaKryzfh
         a0C2TolZgunmx4aDg/gAg6HHXJps7WftEvB+43xZA+grlSoYKYefeUBEEHnZZPEKca7p
         DzKG3y13Wj89dBQrLSYek0M2t+dfOYOA5DDB9QFEXhRA90Hp4j3b5dA+Wp/EI/B5jwVn
         T/Tu8R1I7yFpKxPr6rtXToelmEBCd8kTg7aHePebof9nGg3jh39aNWMaInvWvEwBM6d3
         aymQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcnA7ErUhOzGxsOKTwIvt6+FMvbp/8NNH3T8uwbSGqxiRShStTm+dsRRSAyylhr7LLqQVntcmmCM1+uYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecoUwAijw3GNM21Rtmxx8k7+HjTtAJIP78o5DNNe92lZnihoF
	fOoAX+dMrx+mTexYtDnX4RAkU83MVoKlWIjiXRHGRYW6R0Bvx5yhAxtISkxL2ZqK82argVH+QuE
	434vlo6gkkAdOd9PsOqUBEQdojYbhCATr4Dt0/A==
X-Google-Smtp-Source: AGHT+IGrQ8fIZASydEMTPgJtn6QAWdCuqrWbDh+r3EcwsMgb2mqXieOzplvqVupD9INUYmMzBF4NNL8ZwfYeKBgNa8Y=
X-Received: by 2002:a05:6902:2847:b0:e1a:43fb:12e6 with SMTP id
 3f1490d57ef6-e1a43fb14c7mr3278001276.35.1724858637220; Wed, 28 Aug 2024
 08:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124851.379759-1-liaochen4@huawei.com>
In-Reply-To: <20240826124851.379759-1-liaochen4@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:23:20 +0200
Message-ID: <CAPDyKFoFH+=Q+h8zuiuopi+f4p63QUoj_qEn83YVBinh8PnKBA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-of-aspeed: fix module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andrew@codeconstruct.com.au, 
	adrian.hunter@intel.com, joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 14:57, Liao Chen <liaochen4@huawei.com> wrote:
>
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Applied for fixes, by adding fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 430c1f90037b..37240895ffaa 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -510,6 +510,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
>         { .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
>         { }
>  };
> +MODULE_DEVICE_TABLE(of, aspeed_sdhci_of_match);
>
>  static struct platform_driver aspeed_sdhci_driver = {
>         .driver         = {
> --
> 2.34.1
>

