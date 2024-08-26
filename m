Return-Path: <linux-kernel+bounces-301388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239995EFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3A21F21187
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD2153BED;
	Mon, 26 Aug 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T58HEKMU"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06471482E3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672349; cv=none; b=lFPwT70fCLJssSwlID8vxlXhb7ZWagG1cWZaO/ldQ4S+QUSCdsbyPkAFN9LHKdMz/e0FIS42R0ONa1qZDIGaDYHEdQuriEiqjRoC2Um9WxHwUSRtKODFO5YwJVRn98Ce1wmv04V6WyQ0KDJDXDu7HS4Iy3vkiMQaFZL9CMRlh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672349; c=relaxed/simple;
	bh=o5xw0tRSQ4rmfrAINXdq3owKChOG/qM0A/XglSLP1KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1FHJVyPGvpU9jPScZavEhFXaDGkJ9fGAeTwChcU4GDu15tJ+67WPmmP+grfl5HwUx4mvpdLxU+MzYDUvcmWXQM2e3y5ytoTs3ZnbpRjAdw+HY9K0Ppa1Rj28eLnSjj6Oq3eRpmBG9m8pGzn+Yj7R7tit0+jhaNaCeajfL6gezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T58HEKMU; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1205de17aaso4322705276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724672347; x=1725277147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAElfL7iEWs0FR6f0b+aqkORTm6zYAiodbIi2kSgpzM=;
        b=T58HEKMUdRbYW9V1JmyMzRl29QILInPX8v2yYdeCZQWSbD7AUNvhDOVCndOWl85u8E
         jVlAclwm8kSDpFyYd0aASY9d6vpg0Oa6ef/CjXkNI0fGOiKM+IifWm79eqRfy+jaQDmK
         HCF5gcn4CqokfHIOCnoqmcReV3ebWJmCkAX5EDNlmy5Qi3cgIG9XCI1AGrmL0ZhaMh5z
         5BoTQBTh1klpnSAKEwF/tLV9OiFTPm/gneHzhg1x22e/M9yJtT+q4OpXos49mhZUEdtr
         +B09mKik8GvfVo2AwBoF8as6K/TKyiIj4+a4nuOT8NZZwcE9vt9owJ0DTxsZQK0k0F+K
         chFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672347; x=1725277147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAElfL7iEWs0FR6f0b+aqkORTm6zYAiodbIi2kSgpzM=;
        b=S8ZupOfZ8Bzc8ETC2pALhi0daQ8h9aPDWNHcMm8736fTWEEfvIrsH4rHEmKaTxpwU3
         l+miD/dxJEzD98tYAjDnIRi4Fd4d7XGPpGnsC9mFSXf63KoupkuMPFbSUP7T6yfiPTUl
         XJEdhbK58qzg1QLYxRbueHpchQGMWFXEN2xivQX3JzBV2GkQXN+MOYIYevTiqeqsiAG4
         aP4Xa2XDLd9J0J5PtWBb8q2ohwSyYyLljIZdGWaf6NpUu4xfaY8jNLgWPim3y0Mbke6g
         qx/dFptiKiyYgM23J+x3/dxoTEHttG0FUpVGkGt+kq6MaCBBCnySc5q6FnzfKc22BqsQ
         AUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVhn3XRZySS8BAyKN8o22k4Owx39/SrUjIvQDfxcl+PJzdDGoGHvotZC16lF48j4+q4YBv0fqjEW/ETHiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7M50Gm7ytUk4iGN11blYZCqcA99wOT/14jMy/L4wlrVXYK0rT
	Fa8oiYMdR42TT/YaxiVqo8DHSu9ic4kXiVQp7Fidsoluyi3xx2HkqPhJxHGyBvxzZtlh6Qt2OIj
	SHzJIa+BCYwAvbTMs7PGjOcVD+6kgcKvYLwuwKQ==
X-Google-Smtp-Source: AGHT+IEwIfWKhZC0rCg5R0yqklaYcLcfxKowVHyn5uOUNIXJoiHSy78zrAfh27vJj2IcDPtOnE2yasosYEnXX2xracY=
X-Received: by 2002:a05:6902:1547:b0:e13:cb77:5fda with SMTP id
 3f1490d57ef6-e17a83b29f5mr10549191276.12.1724672346952; Mon, 26 Aug 2024
 04:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820230631.GA436523@sony.com>
In-Reply-To: <20240820230631.GA436523@sony.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 13:38:31 +0200
Message-ID: <CAPDyKFpryBDxAcuGd_AsoOJRr84kfvbXgM=eTaMjOBPGXhohsw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: apply SD quirks earlier during probe
To: Keita Aihara <keita.aihara@sony.com>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com, 
	Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 01:06, Keita Aihara <keita.aihara@sony.com> wrote:
>
> From: Jonathan Bell <jonathan@raspberrypi.com>
>
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks
> are referenced in sd_parse_ext_reg_perf() prior to the quirks being
> initialized in mmc_blk_probe().
>
> Split this out into a SD-specific list of quirks and apply in
> mmc_sd_init_card() instead.
>
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>

Applied for fixes and by adding a stable-tag, thanks!

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

