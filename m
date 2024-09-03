Return-Path: <linux-kernel+bounces-312928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430D969DD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3067C281343
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFF21C188;
	Tue,  3 Sep 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj2258lo"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5421C16C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367096; cv=none; b=aDiiSnN9zITrADKbh0Z7dx8QVfzgGzAXgFaFJMPStonxVeeSEFoNHyUndCYcz+O75Rc0DsOk9epl4oCTynEVc6KaN9FmUXmhWB1Vtvm48u/MCpBnRONOeGDQ0JbB4aHSG8iAuMxpel+AgF6thugtavcJ7B5J50Vh9Str1bHwEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367096; c=relaxed/simple;
	bh=PHFmIYpMuaIPbbtJKB+FFJR7T5QaUXv/5qyIoj3ad+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QosF1ruW/KkvhjRRMsEfOrD0aYV4ZdUZN/6LKi2+0IO1xdcIezgluLthpnri0+8aP3K/UNnwAXjHjmc9u9gzyF44nekJ5C8y/mUBF9K3vl9kL+YD2i8TUNUKYVIdThmt5jRdQDm3bs9NM6trP2wvA76MGWR1GAgzr5lXflUQz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj2258lo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so5606128276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367094; x=1725971894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lpBdp/bMtiNkcEVqKYlrcjklKfrSjhz3f/Yq+TwUwZ4=;
        b=Sj2258loOHfI0S9QJH67/OsqadWKqyYcvsB7BYTLsKJaawEKUFvg3wQupANOAOVFl7
         63cgCfqfLLe9wPBTJV+8A+IdOkz5uoeJ/pPvnOkOS1DtgE+0NE9bRT23Q1NLC3cNoaAC
         pDVp7Mpm1jZKb04u5tYPf9n7qZEKaV37qIdE1V8/JxSX+W3alFAPc3NwyMvOmlMka5Zb
         8ztohTTVNyTfROPgIY3NInkwgMeq3Dp2rP2DsduZh4oG7gwB0vXbu/OrdCl7wRsHwfCU
         97a4nMCWL7hAwdIuCgLuFH9hDHv40lONxgaP6jiwoq4Ud+GSWmjHRvE29oqpO4nOZjoV
         1Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367094; x=1725971894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpBdp/bMtiNkcEVqKYlrcjklKfrSjhz3f/Yq+TwUwZ4=;
        b=WwAemvg2WasYiE9OsRG8d9aZyoQUXOxjPzXIeP8K/joBfscw7b5dLyr7BecItYUnee
         vjSbJ2rXszqmDHIaDwKdBOdmlRutdPvRguL0RyVq9g0y0D6xwgT23yLez8YJ+D2gxeGo
         TUNhM28Zc79zl5tZ/ThjdBEQuDDs2I9T6MPB0acG1WPQqN8OfP/BMzJCXkyNyYP7C0gp
         M1bOa5mDhEqncC9481pObzw9FeWojlofAkKSZ5jFzo/dq8EK4F6beXamTy2biL90wr4W
         E1yPdnTxcHYkr40PsA5wl/S/mYGiizCXEZ5ojSmFj1EXxMmg3C6gxJUzk9tFZ3Ro2Poj
         cxVQ==
X-Gm-Message-State: AOJu0YyNwZXPvqOHbaRxDVVIShpSOatSDbnRYxtV6IEiHSS1qcySVj6i
	vyU1TDYkNm1S4URvMrcvG7lzNl2pcW6mZBRu/LzhAbUV1yeYJvllUrN/2/p4LvN3ffa6rohgraL
	WRqoJ4QBgRV4KbT8p8DX/4yEzv+GxT3f3YUPMGd2yIcPv4hU8
X-Google-Smtp-Source: AGHT+IGtMZcAL/iFXk0ke4oDxanFeDAd8/aJAnGd4nVHUxQM2zNPpeWSAwWuQJ55JPaYKdFUZSETDX7DSJeBRKTavng=
X-Received: by 2002:a05:6902:1088:b0:e0e:cd17:610a with SMTP id
 3f1490d57ef6-e1a79fbec69mr16502764276.6.1725367094246; Tue, 03 Sep 2024
 05:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902151231.3705204-1-jens.wiklander@linaro.org> <20240902151231.3705204-2-jens.wiklander@linaro.org>
In-Reply-To: <20240902151231.3705204-2-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:38 +0200
Message-ID: <CAPDyKFr+nF5Y-fe6FpKcBt0zX=_oEmy7j-rbvG-1tmP_qQXrWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] optee: add RPMB dependency
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Arnd Bergmann <arnd@arndb.de>, 
	Sumit Garg <sumit.garg@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prevent build error when CONFIG_RPMB=m and CONFIG_OPTEE=y by adding a
> dependency to CONFIG_RPMB for CONFIG_OPTEE so the RPMB subsystem always
> is reachable if configured. This means that CONFIG_OPTEE automatically
> becomes compiled as a module if CONFIG_RPMB is compiled as a module. If
> CONFIG_RPMB isn't configured or is configured as built-in, CONFIG_OPTEE
> will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
> ---
>  drivers/tee/optee/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 976928641aa6..7bb7990d0b07 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -4,6 +4,7 @@ config OPTEE
>         tristate "OP-TEE"
>         depends on HAVE_ARM_SMCCC
>         depends on MMU
> +       depends on RPMB || !RPMB
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> --
> 2.34.1
>

