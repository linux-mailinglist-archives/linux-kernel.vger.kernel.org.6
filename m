Return-Path: <linux-kernel+bounces-312924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54880969DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6301B219ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC11DA109;
	Tue,  3 Sep 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rS52qQI3"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849A1DA0F4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367083; cv=none; b=T9rvgFONiVlRDNr/4LF6gSCFdYfnb7f/hxScxNdeI+//nO6Es1YVPLrt5JEmrNg840xT62O8XD9F0JweCSN5BB1SnX7gYLbOJCd/a4JdRzl1T6eh+T9mLbh5LmxlWrO2IojNeIPfSCc6EZByNw9ELz4Wno486K4yft0fsn8hQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367083; c=relaxed/simple;
	bh=so07fhMMxdSs5dvGJCXgXpjSzTunUkiCXhADIMW4sUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2OWXvO8cDPR0FoNHM8XPn+lIC+FiK0jf9CZHjB75CoruLRVDzHT5Z8oNbWrEDnlDi8RxMG6QPm98WGiTRcg1f7C36Os/ZnPBUICMP7XSzL9zhScaEWrM5GSJf/SEEUWucXfIxODKPvyCcftMEIHgWcaRdlQLPgG+XYQ5SQMmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rS52qQI3; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e179c28d5e8so5484885276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367081; x=1725971881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/GPlpR6N9raBXPZjYRGmkOR7a/Tjc3UpicaLb0zTl8=;
        b=rS52qQI3D1xu2JBgaSxEWPuftqx9Sc2QgWxce0CHVLpP8oPbSuHLgYfmawRtZXa5B3
         /rbxEG5zkMNqTkIOpTywCmAAjAjc/6Yaj6uRmD5uN+04wUrcopV2to7+pIJqaL5bDp+B
         e4+SLru1YH+fsYzRXmcHGdDTJxu4CpIJ/DCU5Sh190V2hfCEOzmI9tPNH+/FpCjoe9MP
         wkdo7byrzmgq+48woTpK5oagDbwWHycMIQPPJWjy2DlYVUwj1vjS9YNxG5VvKy3c+wbI
         vbxvkDHjzyzT8jlWdeRciMJgur3ZDzdMhCFKafOi/ZoFqxs4xb0MN5w5lTtSR8bIEhUC
         zxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367081; x=1725971881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/GPlpR6N9raBXPZjYRGmkOR7a/Tjc3UpicaLb0zTl8=;
        b=mE0N9O2+DOZ901x3kpFyfDMc48r8i2lNgX5zC+vEPjZpbKOBpBZybBTHs8TLBkEEXN
         HAGV5F3XxY7ROe/JEH+va4yJx2wU88PFi2k3ry0pwkCs3w50blyFEfqEprRMerbfYSks
         2yevZFAqEgyividigBzsgXhgjkduVK1U6gHKVQtCOcAqX4O6FBm8udg+9dtSYZKBeYFG
         6mSss/yLR8+QwE/OL5NThC+T4xsDmw2DUJQMeSrTXAyuUTlZfbQyCBpwR1BEGnI6yUCj
         GgiU8CS9d7UwRWNMmsqG3TSBhQqkoG08WNsA+/Ecb8UymT/QZXXzN3Sdox2a624X5MAL
         P9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJc1oO1THVO3FvHqsZPlpCswUVYuCkU6wVe4YgRtYQ3Vby51RRmxueqLCMZRn7H6mGxFEBpZF4+4OUaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pwqqm8gO9u6oxBQn5ABm3Js4Vp206N6i8iuMhCBivJbEfDje
	AkMWjmMBAMcPtQlHHU2cyJhtxcfaDl5nOhL2VK8fCtWCTcRaKKzI2rex+7UETvfE8iY7PM6fb43
	fmQgEmhr7+DIxTQLvCWdacnV1ma1t1dPGqE8Q2w==
X-Google-Smtp-Source: AGHT+IEjte3d2I7iHlCrFM55Q6V1uxJf1u47/kPDXpSXZgFMB17aGufprFsCA9FCvY15MVqgrv9KtM+/VSWPoSdQk3o=
X-Received: by 2002:a05:6902:c06:b0:e16:19f7:9702 with SMTP id
 3f1490d57ef6-e1a7a01cc00mr16390835276.24.1725367081048; Tue, 03 Sep 2024
 05:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901182244.45543-1-riyandhiman14@gmail.com>
In-Reply-To: <20240901182244.45543-1-riyandhiman14@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:25 +0200
Message-ID: <CAPDyKFqdu07MwGyoJ8oMmpFw2u2=1zc8m6LCais8Wva58uTcug@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: convert simple_stroul to kstroul
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 20:22, Riyan Dhiman <riyandhiman14@gmail.com> wrote:
>
> simple_strtoul() is obsolete and lacks proper error handling, making it
> unsafe for converting strings to unsigned long values. Replace it with
> kstrtoul(), which provides robust error checking and better safety.
>
> This change improves the reliability of the string-to-integer conversion
> and aligns with current kernel coding standards. Error handling is added
> to catch conversion failures, returning -EINVAL when input is invalid.
>
> Issue reported by checkpatch:
> - WARNING: simple_strtoul is obsolete, use kstrtoul instead
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..140d2b3504b3 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -307,10 +307,10 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
>                               const char *buf, size_t count)
>  {
>         int ret;
> -       char *end;
>         struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
> -       unsigned long set = simple_strtoul(buf, &end, 0);
> -       if (end == buf) {
> +       unsigned long set;
> +
> +       if (kstrtoul(buf, 0, &set)) {
>                 ret = -EINVAL;
>                 goto out;
>         }
> --
> 2.46.0
>

