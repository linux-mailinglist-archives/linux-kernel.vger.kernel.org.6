Return-Path: <linux-kernel+bounces-328139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AAC977F63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53212817B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE91D9329;
	Fri, 13 Sep 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1hLH81i"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8021D933E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229611; cv=none; b=fR+zszfhb+UXUxibMLHuzy5iSDcDUfhO3xsr3mfYnmOidy/uk3aItmyepMwcODHN0RStPKAliBD9XN3dh70c+6CAk+gEyQx7zd0I4PDKO/0MvwF8VhSqltvwKiw29TYZRvYrNE6d1EV/oVTQFqT31Tj+ylBpoi/4+VTZiDBC1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229611; c=relaxed/simple;
	bh=WW7fLZZ8VgKohsiVkYZgDdgXl3w5a1PmghDLoJsRYXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQal2ldB0P+cS4KIIm6OHAoWwfZ/ZCF7ohWnWT7jY/8j1KY20Pk+bzNZIAcfBHlz4vtYeW7IbljRFA2xsQpVkI9NF7X5bEhM6ffrLVQBcBd4ah7BX4uf1Uxxo7SFAjG+ZxulkcjhLs1NicF6dSZw5tPz4b7y9ECSrmxa2ulaim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1hLH81i; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1541482276.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726229609; x=1726834409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TX9ih1ubYMKW2iVGMJX/IFiFekSGf836KE5EslMkk1U=;
        b=H1hLH81iyhRIRJyGESMHkbTHfd9eZRtzg9r/AuRiGLvu1JY2UzxjU27AepNkgMvR4g
         eutxcuc/HykSofbqL25BhwO/NcMaj0xRAhXCDZ0nsebTQRLRW91twdhCkWmD2xv3Jfur
         LQotK++WsHGyXFRRmdHXvawLDhmvFHH82PYZdyg+0Xj2WtAjYD/w+S1SHLel2Xipg/X/
         TpkS4tgwnifKpETI1fxtvj10Yvym01YN0bh8EM+5Pa80XD4v5hUH8AaQedfCEfAbpUzT
         cU2AX5Rp2GkeHTAz0eeBMrCgBsG/FxCiOkKjw/aiyhMDILtQeHgk/yKF/mTfH+Mvl6Uw
         B+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229609; x=1726834409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TX9ih1ubYMKW2iVGMJX/IFiFekSGf836KE5EslMkk1U=;
        b=TX4RmkKqPfBkRl7Z8dszk/n46j7D0kxrHXWUmax76/w0p4tUuVZcCCgGWHGgRksdxN
         hZRqnYBMNlr9htM2KKdvX+YWoWmN7AXBk6BmemO8fSIMnTIsR75uwOfCu6on64sQszsK
         FdlC6H+5C6iIZ27bagdJpeI+5+PiG6xPRDziXIMZCsgfzhDcjOwIpvRtuIr23UKifis4
         cYMCR1/LGq6UeUee+nKncR+9fProopZFG1QZLMCzLsu8wOfzhOqRV5hzqQGz+EZOIF8J
         LUX6hKavjF/g41eP+sWedFVd1hLVCBdqzOzmYdBrClaG39ZFmoCcudqGSDecPOtWB+3N
         yl5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtr0wyF4ZFf0xInxfzcM6XZ/ilJKixrliDO1iNPgJ0PrXPbHTnwFBE7hMg3S3A9pm6ND5Bh27/dUoR8oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBN3EUAOTlFtvVcmBokt/IHRWAKV4zoXGwkqSFpdWYtRQ0rD4G
	JxJ1dSBPvibDFsPXrEBc9UNdl7viTHJJaDbUz03AD7BDhhMp6EteqYN2aNo9zPrUMoUe+zNQGns
	Uka6ywOPHs72GPThIXVD8Dq8GB8yFWapJRKfwk+jfCTldEfch
X-Google-Smtp-Source: AGHT+IHgDN2jdvDiw5yXIWHXJe2wI/6BK/3bUrx0vNc1IhCHnapZTBft52RHjxYmhEcK+zl1z3ewNSe+NEDA7nkf7cw=
X-Received: by 2002:a05:6902:dc1:b0:e1c:fbe6:b11a with SMTP id
 3f1490d57ef6-e1d79c15538mr10891169276.0.1726229609197; Fri, 13 Sep 2024
 05:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911090910.3060749-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240911090910.3060749-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:12:53 +0200
Message-ID: <CAPDyKFo-8=UOH7ZLNDZ8+zLCLSW-f_-JvjUQFC26OtVpeT2oFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: core: Use dev_err_probe for deferred regulators
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 11:09, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> In case vmmc or vqmmc regulator is not available yet, use dev_err_probe
> in order to set a deferred probe reason. This is a helpful hint in
> /sys/kernel/debug/devices_deferred
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/regulator.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index 005247a49e51b..01747ab1024ec 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -255,7 +255,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>
>         if (IS_ERR(mmc->supply.vmmc)) {
>                 if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> +                       return dev_err_probe(dev, -EPROBE_DEFER,
> +                                            "vmmc regulator not available\n");
> +
>                 dev_dbg(dev, "No vmmc regulator found\n");
>         } else {
>                 ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
> @@ -267,7 +269,9 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>
>         if (IS_ERR(mmc->supply.vqmmc)) {
>                 if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> +                       return dev_err_probe(dev, -EPROBE_DEFER,
> +                                            "vqmmc regulator not available\n");
> +
>                 dev_dbg(dev, "No vqmmc regulator found\n");
>         }
>
> --
> 2.34.1
>

