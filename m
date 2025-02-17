Return-Path: <linux-kernel+bounces-514939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0FA35DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02BF188E546
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6A25A627;
	Fri, 14 Feb 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHygU2Fw"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201A263C73
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536647; cv=none; b=Eji9PwSalYiGdlIOSHqKi4KIZcFDI8KAYHafcQymTLLYNfxzDW6mkiTp/+rZrKHpGUJhQEAob1GM3i7Gk0lASK8cxVPwCoV9D3AXhUkGiXXPxILQhJvTmmx6hIwXhR1/HO9rluVcEHhSomlkhJFwEazufw9twsiSLc9Fgq5Q7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536647; c=relaxed/simple;
	bh=JJ+O3NQc7ZRxc/eAygdOLugfRhN3r8KOEi5bbWBrjKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjWJXm8FsF/kFIbKQBmv8PQTfyvv8HWZYIhHGHHd9WGeLi6HoaZSjXvH/CGeQmu3g4ZQ1HmNRb5asxXtYynj8zB5lT8OeM8LiEd78TodwY59/cn1Mcb1UgQe8pJdhxzM9D4l6m5N7CxSfi20rYoiLRVKYLO0j6EbMPl+/Z2Rn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHygU2Fw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f972c031efso27052667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739536645; x=1740141445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PJIeOuHK6HT3LfS+Gyhx912FloyWVeSMjTYMVQ61KWs=;
        b=CHygU2Fw89aAA7PSbeojSR2Ch6baGXb07HTqKIVrBhnRue9KCs+2zbAnzRV15LsssT
         sFNHo4IujZgiMvmlSavmMJZN4ftPtGY8cF3wIBIPoAHsy7z0oR6ltc7bltCDbwJYPRyQ
         zmB8+JjWNBnuKMNKe0iW0Z9fZOmt+AF3ZJ50aqRNyjd3S8yw7mWgjGB7EcwnEG8W4W6M
         rbWJlYPi++YvPZAn8+HBgHqQ4sKFqeJMNqTmxPsy/7tgHA4N73nRjLaJyMTkr6P3y4mj
         qZpq3UXy7imUBL60PhdbyoMo7RlpotjmsTpJHjWdl+na6MFtJan3ulP1aAZERZAUhPOW
         IgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536645; x=1740141445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJIeOuHK6HT3LfS+Gyhx912FloyWVeSMjTYMVQ61KWs=;
        b=TgS3p6Jbg0Tje217xh1PAKSK1fzTPi9RvkSulzXzNeLHKjQN5g1j3ulx4kMinDCKv4
         ARJRtXvKs01SBgCIIOrWumK7HTNYidfQZBMNbiDK1fxXdoKU8HyU70Q/SdFBykLUcKaR
         DHw1i4e9/J8CNxZPSFxzyL35R8bZqIDgR77jv9AxPQoM39PjGRfJ8JGm9JJC0DBMo+UQ
         OVjZM3JcPnzS69w5YGK2YTbn3w2/4xliNl0vvGoCd/rm0hsp/nwbYxrLKzp/OisJawke
         AdSTsLml/pJfKos4MDIS8qDuZXEcUUTOAl4KZtaIyQnZ8Ep/pfyeJ4i2uMl+fRSrJ939
         PlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXA8B4FmtwtF/CugjwDg5n77SSiBE1Xg1gGDWTonTvHYFDn5o8MBXCFPXUpg5ajDg77sK8/mLG18U2SsWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRXpK7M9xSKlCdxVz4HRVbU5//bFLCsnWGBj7Z1bE/fzINRCJ
	B2MB6W0tMpz534Ujx8RdPPflUIrCTv88CqleQYKL/xF5/xS5jyM9HX67kfLnI53x0ZkxuimGct/
	oOpa2z+GxnX5tkfaM4HCffP5H0CYnS4yERnpk9w==
X-Gm-Gg: ASbGnctevRXUfun2h9jd3XLOo0at6A0jkwR2sEIGhvwuM3o8OE2Vp2FQaPrRsVboCcb
	ZclvOQSdM4SsVPBILMpR1bQYKbmtKwFypCYQ9sN9q1wRbmeQg9CK3NcknPHAo5NU3BvW9zwY+6Q
	==
X-Google-Smtp-Source: AGHT+IFFUIbAl5XDVgSjeARoAg42VVByccGOmxG3hSULf8SrcrXGHd+9G5Ugv+8hOXmpTF7lxA8JoAU9tHSD43F9q0M=
X-Received: by 2002:a05:6902:1b08:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5daac7a614mr6387024276.16.1739536644605; Fri, 14 Feb 2025
 04:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214102130.3000-1-johan+linaro@kernel.org>
In-Reply-To: <20250214102130.3000-1-johan+linaro@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 14 Feb 2025 13:36:48 +0100
X-Gm-Features: AWEUYZm-GqVQrKsKGZVAfCbeybEf32Dak5WgakPU21UHnEHfkiCIl9P2xjgmigM
Message-ID: <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 11:21, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The simple-pm-bus driver only enables runtime PM for some buses
> ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> pm_runtime_force_resume() during system suspend unconditionally.
>
> This currently works, but that is not obvious and depends on
> implementation details which may change at some point.
>
> Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> future surprises.
>
> Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")

This doesn't look like it is needed to me. It isn't broken, right?

> Cc: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Seems reasonable to me, but I think we need an ack from Geert here too.

Anyway, feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/bus/simple-pm-bus.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 5dea31769f9a..d8e029e7e53f 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> +static int simple_pm_bus_suspend(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int simple_pm_bus_resume(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_resume(dev);
> +}
> +
>  static const struct dev_pm_ops simple_pm_bus_pm_ops = {
>         RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_resume)
>  };
>
>  #define ONLY_BUS       ((void *) 1) /* Match if the device is only a bus. */
> --
> 2.45.3
>

