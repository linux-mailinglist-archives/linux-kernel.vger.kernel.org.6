Return-Path: <linux-kernel+bounces-312923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4F969DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C215D2834A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B71DA0EC;
	Tue,  3 Sep 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS3kc797"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D121DA0E5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367081; cv=none; b=WUvjFBtKQuWNPa4JaebUG3WwNtLkXaZXcNksCrw4x+1kzxe5ddYnWr50p1AzE96iWOHMjg9g1CT/ppzgHvKeWq8xXP0DqWB9GuSIgRC5SZHSD+13sAnyfxnpxL4Jq2ODS+nX+R5Vi1iptMVxC3+8Citt7fsArs/HUZYTQ17l8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367081; c=relaxed/simple;
	bh=uu6Yoeqi+RNoig3ATUPsT67nAJWUqDSiEcB/mI869tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLporrENjR8FxzZAM4mKBbhdk/kgXuRZA0GqtRsVnN54xpjYHzFBElG15coQyIH9jpCh46RR5NyTEQpZ8OnYCb3byXE5BSEz1CLLzn+FaCm5cr3R7aKBIQqFXEzSGyl4Sbpu7EBuBMAXHyRpFWu6peXBT1ExEq1owMhuQR08K2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS3kc797; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso4623719276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367078; x=1725971878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ttVzkkd4yGmrGeqOJ869ESzGGtHpDRb7/D4IC8eBd4=;
        b=VS3kc797SAsXs7KxZFv1Ynhn/mC3GBHrU5vSBcwkET2YsMClY5NZDIftw1/GF76o5R
         5c53yBYiw9M3Ak/M/JTbIcPYaGNmXX63DjRSCW/dsnwXaBtYu5nt5Z7kUQiiBwH0/k5I
         lJITqAur9HDLJvD+nSzPtbR/2gTCRZ95sgfr4iyjgKoPFX0WtjfQ7PTFZOO2G0StoFRe
         bddtq1K94RtRKPghvfpXW9Tvsblyr9O8eT/R3cE7Y/3jLffrUg8I3KOIpkRHMfWR+1xs
         c/2utaYQzxw+Oc3ZK+8iJuyBaBkzqb8TkxsT04ZVkL0fp0+AZl+uMKOko85J24SiW7ei
         MGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367078; x=1725971878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ttVzkkd4yGmrGeqOJ869ESzGGtHpDRb7/D4IC8eBd4=;
        b=AwpMYAGcTe12hvy4f1QfLFtd1OAogRmNbcYYvkeWRCKqSwdLBq9NCLP0jPp5XbPERo
         g3srqPEaQ0JvLDBTFvZNXGvocoOZ1t0+wmekcvawE7wmuy7yIvrM/I7ZQT17RBBQdB/i
         5HzdiLGyC5KasIWVLm7FGZH6O/PzVTE6cruXgznoTiLhEdJNi/Um60Mpa4uLkBnOBjNa
         hTPedcqeOBc0vs/8GkMCqe6xEQulinhlGEtWk8bXPsmJtVB+du3RYis65SovU/AdsK2h
         cGpuV2rEkZOaKH30YY8bHR0j1R0f1q+d7yXmsL9rLnDMOMAOiq+yUYChWBvkmHo9H0XC
         1YNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfpH3fgYM2IAT07pzUrvQCFkH6ffkQvLI7IMvHqcq+FdV6pyTpn8wAUkR8sdWvps0fcyuLNVS5sYVZW1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvaokbc/RJ+1yKgrQaci58AAlCsUADOfdTLIaWNCwJOmicEre
	2wT6L7K7gttDsentFHU8EzuBSS2ouY2mz94q6FxNfYs4cSoNU9NEwVPBJqmaY3kUs4oAFX1Ih5U
	3a+H4SRtUU/tUu+NaNE+5Vhr6RVXZa5VG66vs5x4JCj56Hunr
X-Google-Smtp-Source: AGHT+IHHBkaojbuJ6rcO32k08NkULZE8JcrC5eAZHxo6A82M/tYG2W17RLlunsSJO2ZGGq1x90VJ7lCRhqfhEMPtblE=
X-Received: by 2002:a25:8312:0:b0:e16:5174:fdaf with SMTP id
 3f1490d57ef6-e1a5c613ad4mr15597080276.1.1725367077643; Tue, 03 Sep 2024
 05:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901173309.7124-1-riyandhiman14@gmail.com>
In-Reply-To: <20240901173309.7124-1-riyandhiman14@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:22 +0200
Message-ID: <CAPDyKFoFZEKwhAgC4UT7NP1ZaVBj1BjLk79LcUmTg-wSDs7Y+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Calculate size from pointer
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 19:33, Riyan Dhiman <riyandhiman14@gmail.com> wrote:
>
> Calculate the size from pointer instead of
> struct to adhere to linux kernel coding style.
>
> Issue reported by checkpatch.
>
> This commit has no functional changes.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..dfd495e86985 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2484,7 +2484,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                 return ERR_PTR(devidx);
>         }
>
> -       md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
> +       md = kzalloc(sizeof(*md), GFP_KERNEL);
>         if (!md) {
>                 ret = -ENOMEM;
>                 goto out;
> --
> 2.46.0
>

