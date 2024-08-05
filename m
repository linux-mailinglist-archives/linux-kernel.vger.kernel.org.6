Return-Path: <linux-kernel+bounces-274512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C994792D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE301280E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095813AA32;
	Mon,  5 Aug 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oI2ORlXd"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F51547DE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852904; cv=none; b=oOk0AcTvxu+Wys2RgjYCasM72VoWCK55kf+F4bB1o2JzQxODkp5dFxQx+l2HoqSd5T5q0JUFhQ02Qd7b6C1fHH82KrPJupd6j70e1AQWCW0+eAT48sjVEn/oGU8tBdBPBsC7qi70+L/mtg0ZnX7ip7Tj0GMdYFEUH80NDaJcld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852904; c=relaxed/simple;
	bh=iRwmgmhT4KqFnsQ0P95yay3PR79n7RkGMBABFu5stiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFNdbI7PUCszt7guWnGnES4LZDJTKsHMTK5j97L7MOsnrEy1UuTequevqWutFC3lbSJUiAbovmQymTG+qpQsn7xTNjQF94yx8tVlHgMjCI+djZzTqxQJSwRcbzfczIGrou+xd294l2Ig5husaD9n+Q/tcFyo+1HcWtouj505mTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oI2ORlXd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso8731381276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852902; x=1723457702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7PId6VbES8ejzo2uY7FaNwSx3/upuclSuKnTrgn0fnk=;
        b=oI2ORlXdxj30BjWwQtRlhPdHWB5M1cpzmnqde7c889eJPmacnpopMVYVQ99gReMkn2
         6/lIkc7DdJ0jhMKQWXVLeCaBHoh8YF5/xrWq5YHDIMH1etkHNP7l9dpT2bCJfL2ow8kH
         rgKGxRvI6yr14c3GVrMmkDvfJc1LR9J97Mwgr9pSrTJM203O5/PtdFu2H/XNiIvG1DRm
         GWNCjuMpN70WBH6DscIJTqQWJbvCsCDCKDiGOih1nFIKFNI083XT9hzEKPL8OHxQbzLE
         sIMtiCmM+XDaTyDZl8OGqNxIJrzdBuUqh5ZCe8+gusUCX7B0X+f+tBkoeVAqU+fmS7EL
         +KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852902; x=1723457702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PId6VbES8ejzo2uY7FaNwSx3/upuclSuKnTrgn0fnk=;
        b=pun2TJJMb7YNpn9Fq3KqeuVEMrjR4gJZ4CQFUu8BYKTgFQbidr/+VvSXluXSzz7G8d
         u2oww6eGIQTJW9c0/MreyjTFhb+aCALbfpC0+buCV5zyS0Eh4fP55JSClkM1E2bAcQHL
         b3WZW8uHj9DGCKw1dBtCicxR3IW7rOpUzuipXAGCSponhTKO0ETke7MvFlQBEP9srdiq
         e2WRjzi3ZIgYsONbzo+KV4RQ/8YaimC7Rf+/HbfItGCMZv4mILgphltoqCqCHytpBZcu
         8I2t8WALZI3OwKPr64BlbZ+AtcP0Wu/ujJYWTXMIkwwPBY1F3JkzEVK7fDPO8nltnYBF
         LHgg==
X-Forwarded-Encrypted: i=1; AJvYcCX4vDSIU4jCE4vTA8SrWLFNA6NENjMyVcpgQ9RbFYy92ic/HZUSJX9bwRMrtkuu5ZZY6aJ7CvIc6Rerr20J/upazfBH/SIIMTNGfKRr
X-Gm-Message-State: AOJu0YxEt0DzWXTadBj0hvwV4XWUtC02EXOEesqzUSbISN9gAOPNXZdx
	7RKXR8ujr0PKsmhi8F3ChLbfL4CLydJcK3qW21DcGm50qs/lS7fCJzdSGToM+KjVAzHm+wI8j2T
	LXO6A1ee7WYSclF26Wq2O1jO09+HWfLWBGdc+SQ==
X-Google-Smtp-Source: AGHT+IFvONQFJleLY7L+1QwTRWODvOHPNAHqljS/7GjMMR/pJEw+N3kl7iJ2pkiOBpcqDAPkdX1gmWCfDTI6SBhQwvw=
X-Received: by 2002:a05:6902:120e:b0:e0b:c297:8a1f with SMTP id
 3f1490d57ef6-e0bde2e1809mr11328079276.24.1722852902080; Mon, 05 Aug 2024
 03:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802032121.GA4019194@sony.com>
In-Reply-To: <20240802032121.GA4019194@sony.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:14:25 +0200
Message-ID: <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: apply SD quirks earlier during probe
To: Keita Aihara <keita.aihara@sony.com>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com, 
	Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 05:21, Keita Aihara <keita.aihara@sony.com> wrote:
>
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> registers are parsed prior to the quirk being applied in mmc_blk.

In what way is it a problem to read the extended registers first?

>
> Split this out into an SD-specific list of quirks and apply in
> mmc_sd_init_card instead.
>
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> Authored-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h | 22 +++++++++++++---------
>  drivers/mmc/core/sd.c     |  4 ++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..92905fc46436 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,19 @@
>
>  #include "card.h"
>
> +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
> +       /*
> +        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> +        * This has so far only been observed on cards from 11/2019, while new
> +        * cards from 2023/05 do not exhibit this behavior.
> +        */
> +       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> +
> +       END_FIXUP
> +};
> +
>  static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>  #define INAND_CMD38_ARG_EXT_CSD  113
>  #define INAND_CMD38_ARG_ERASE    0x00
> @@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_BLK_NO_CMD23),
>
> -       /*
> -        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> -        * This has so far only been observed on cards from 11/2019, while new
> -        * cards from 2023/05 do not exhibit this behavior.
> -        */
> -       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> -                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> -                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> -
>         /*
>          * Some SD cards lockup while using CMD23 multiblock transfers.
>          */
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..ee37ad14e79e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -26,6 +26,7 @@
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "quirks.h"
>  #include "sd.h"
>  #include "sd_ops.h"
>
> @@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                         goto free_card;
>         }
>
> +       /* Apply quirks prior to card setup */
> +       mmc_fixup_device(card, mmc_sd_fixups);
> +
>         err = mmc_sd_setup_card(host, card, oldcard != NULL);
>         if (err)
>                 goto free_card;
> --
> 2.43.2
>

