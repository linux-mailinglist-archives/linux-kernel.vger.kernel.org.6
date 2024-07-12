Return-Path: <linux-kernel+bounces-250859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065B92FDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBA1B22AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D611741C7;
	Fri, 12 Jul 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cvHB570J"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92704173320
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798768; cv=none; b=Uqqo9uEvGdZ8bF7WooQszDyG8Hg072kVIgdfnTXzFcMZrFnEUZ5jv9ABVY4JBbkfyBfK8ceQyqZCF7Bd+TPh4O9qbkyRnZU2PSX5IehuIv1zFcq+nr4+g52lvLABiKESrpwdtmTAIGFBD/m9CJWQ9beJzmD8a8BJRMhCs6zgNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798768; c=relaxed/simple;
	bh=68/kltcLtm3c5q8IqHBsqqo8yQ9MYg9r+nGvbZAb6v8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IaxTCRzhLGJF6ua70mFIM8CidYbP9QbRPK3jaE59PSrchwHrIwkpcZuAb/D+Mmm+OP02XnqfPVSkFiyV1ce3WuuOwx8Igoe31YYXPcOoiL4ERKYt43I8jGtVIYnEh2v7s1rUDV6d4uvJyJK6OWhCdgKkwMooCZz72SRubobYZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cvHB570J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso2740325e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720798765; x=1721403565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXS6CNYAdyuDwfj4669MHWReU6UN/YmeD5dTtm16ne4=;
        b=cvHB570JIU/T0Kc4UbAjc+leZuO7yBrsLKr9kziLLcpdaAb+yOvSTdi9rQjd267Nwc
         zvn+ip+ghdBKIVk3WuQZstwnRpZ+GRciPeWD5bVIPNNuV2Nvy8M6mzkMZxhgrY5Bn9VH
         ZDLBBmt2l1VGUfoFvaHNjwA6N75Ec8url3uZL6O8CcN2NFQ9i57o0c6hXG2rSf2FmFvV
         QCeaur1zEnXYLL55W8dE96a6l6hTRvfGpZVMAmPaOFkG7rt/4zGvTm+JWc26LaRJCRrs
         WNfejp1msyGDdUF+UGL9rczvsb0NaX9GY7G3IjGPnIePK9ZUB+HzHfzw2vK6LLXQAZZ4
         2wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798765; x=1721403565;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXS6CNYAdyuDwfj4669MHWReU6UN/YmeD5dTtm16ne4=;
        b=YSsiggyVd2pVTZoiOYN14XuNRccs8kLW03fUfn1SJ18gROy0tfXgWCDRQQxHQ6oGjJ
         /aILAV8+6PTj4UrW9xG4QL+XSXY/oxqbKzyfe7Zgy+CtQB3eTpQmidS8I4/WJPCmtRQu
         0DDhkYY4FHZM/h0aUL8uzg2jUNfIyaqkfuzThONxTddzkae4gWm5Gx5FEDaz9sdmj37P
         vPiLBlchYHrpzFlHmTmfSH9yR0P3cqnIeIPX2yXWj5FnulLOkY8dwNrfXt3B/4MSec3S
         zVqlqvvSBsP7s/VjcJ2o99i7WI0lcF2PzFR/Qt77xpuHFCDpePklktCHt0HMtLH+7Ebz
         +CsA==
X-Forwarded-Encrypted: i=1; AJvYcCWa0DgTffN0dwrKLJC/YgmApl3lQswX8yQ7cq/XfrsuHQwY+vExR1YjGOixFV3/qa9Xl7yqpscmkYSqlKP/rSOXfp0Va9Fv5Wows/NK
X-Gm-Message-State: AOJu0YxrLCu7ku5WGRr234/6eV9YUXaPC5IGhI5XesdV74L4uPR89wVT
	T7nyKKa/uWDn9xwXU56qU2W//SRVs6Jz8etMpZ7B1A+XefKRUa3BiTCub+N0//c=
X-Google-Smtp-Source: AGHT+IFt+v0z4s2SEnUzvpF3XhmKLoMZVPIgAXxpi9rthXghlv3Aylzcme0OH0Wr5YydJX6qYwmksw==
X-Received: by 2002:a05:6512:750:b0:52c:d78b:d0b8 with SMTP id 2adb3069b0e04-52eb99a32c7mr6495989e87.39.1720798764436;
        Fri, 12 Jul 2024 08:39:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2ba545sm26557105e9.34.2024.07.12.08.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 08:39:23 -0700 (PDT)
Message-ID: <7f99cb63-0c6b-460e-934b-4e7e8d84bb3a@tuxon.dev>
Date: Fri, 12 Jul 2024 18:39:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] watchdog: rzg2l_wdt: Add support for RZ/G3S
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com
Cc: biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com
References: <20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, watchdog maintainers,

Can you please let me know if there is anything you would like me to
address for this series?

Thank you,
Claudiu Beznea

On 31.05.2024 09:57, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds watchdog support for Renesas RZ/G3S (R9A08G045) SoC.
> 
> Patches do the following:
> - patch 1/9 makes the driver depend on ARCH_RZG2L || ARCH_R9A09G011
> - patch 2/9 makes the driver depend on PM
> - patches 3-7/9 adds fixes and cleanups for the watchdog driver
> - patch 8/9 adds suspend to RAM to the watchdog driver (to be used by
>   RZ/G3S)
> - patch 9/9 documents the RZ/G3S support
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v9:
> - dropped patch "watchdog: rzg2l_wdt: Power on the PM domain in
>   rzg2l_wdt_restart()" until further clarifications; this will not
>   impact any behavior as the RZ/G3S power domain support is not
>   instantiated
> - on patch "watchdog: rzg2l_wdt: Remove reset de-assert from probe"
>   call pm_runtime_put() in case the reset deassert fails
> 
> Changes in v8:
> - added patch 9
> - collected tags
> 
> Changes in v7:
> - updated the dependency on patch 2/9
> 
> Changes in v6:
> - update patch 2/9 description
> - fixed the dependency on COMPILE_TEST previously introduced in patch
>   2/9
> 
> Changes in v5:
> - updated description of patch 2/9
> - simplify the code in patch 2/9 by using on a new line:
>   depends on PM || COMPILE_TEST
> 
> Changes in v4:
> - added patch "watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and
>   ARCH_R9A09G011"
> - collected tags
> 
> Changes in v3:
> - make driver depend on PM not select it
> - drop patches already accepted (patches 1, 10, 11 from v2)
> - re-arranged the tags in patch 8/8 as they were messed by b4 am/shazam
> 
> Changes in v2:
> - added patch "watchdog: rzg2l_wdt: Select PM"
> - propagate the return status of rzg2l_wdt_start() to it's callers
>   in patch "watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()" 
> - propagate the return status of rzg2l_wdt_stop() to it's callers
>   in patch "watchdog: rzg2l_wdt: Check return status of pm_runtime_put()" 
> - removed pm_ptr() from patch "watchdog: rzg2l_wdt: Add suspend/resume support"
> - s/G2UL/G2L in patch "dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support"
> - collected tags
> 
> Claudiu Beznea (9):
>   watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and
>     ARCH_R9A09G011
>   watchdog: rzg2l_wdt: Make the driver depend on PM
>   watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
>   watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
>   watchdog: rzg2l_wdt: Remove reset de-assert from probe
>   watchdog: rzg2l_wdt: Remove comparison with zero
>   watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
>   watchdog: rzg2l_wdt: Add suspend/resume support
>   dt-bindings: watchdog: renesas,wdt: Document RZ/G3S support
> 
>  .../bindings/watchdog/renesas,wdt.yaml        |   1 +
>  drivers/watchdog/Kconfig                      |   3 +-
>  drivers/watchdog/rzg2l_wdt.c                  | 113 ++++++++++--------
>  3 files changed, 66 insertions(+), 51 deletions(-)
> 

