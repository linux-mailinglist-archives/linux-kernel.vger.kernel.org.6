Return-Path: <linux-kernel+bounces-547093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A14A502EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E13A984B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D76248863;
	Wed,  5 Mar 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/FodS+J"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDF84D02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186442; cv=none; b=P0JGTlLC1NdIFtF9fLC04UINg099lSVjKeRtC37iH4RzBw6XiT3F7XSalfKYzWPTHtbIF/3JUefVtBzqbTs/KebOI5V+9iaok/dxTLc2n23WvQ9c6Mj8rCrjk6qwRpjQSFmYRjmAotTZurC4NwGwxhcSVLcq3DMkHdRagh34974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186442; c=relaxed/simple;
	bh=jTkplcEsWFR/ytitWc/gZ9Jgm54mf9GXdauo+Q8kRBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpTj9K4tQykRzXdf2INJavu6N+O2p/AVfyqywYKwtiNo8vWkRwe3Z3LBMOsUXzVk1QB5cGSK11VGJuRMDW0TaM+EYHXL609meFM+Lhu9ChsOZQlxFCZzegS53Z9gRBmR3XHHB5fJaiU1kS9vv03hc2TeLgXq1rySUjXg1y9pwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/FodS+J; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fd2587d059so42602057b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186440; x=1741791240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/8e1NK0iHuTNXsrRQMu1Rap5op5xIoO/iE7QbD4E6K4=;
        b=Y/FodS+J30C868V4Ywnu/qvS5RyRM7GvU7UH3gxg4aosQS+35Zz9gGhTj2bA6QY/hN
         hJbLf3cd8k/mKfoFIxt1cCy2kSG4X5l2s+0SZaCJERv4LDnn2hvsQZ1LpYF/LKMOzaPw
         ztnyU8DtXbnanSy5Q/7eI9f8ysQ0Qmp+8SRkie3HJZRaANHFXkN6hn048lfRNcRKYU0a
         rQQbmtW54mUdVjEL0UbXrLYZ/9r90/g8PWZ5J8thB/to1Rzq8yxvYbSVQzIXlkT5Gnk6
         bkWz+lP3PwtZ559klAsS1zpTSqTDk8fLgODAUh3uCXYBqWpZSUFWgKuK2aruAZr4Pteg
         jgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186440; x=1741791240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8e1NK0iHuTNXsrRQMu1Rap5op5xIoO/iE7QbD4E6K4=;
        b=T3+K/AaFv5m0XvvjayQfJolfYIcVY31JXJqHqsig4W4g2iMprbeMf/MN6WyJ3ANOE8
         XOVkFx5e9IlmK+i40EPKhOzMVb6SSkE0YjERuQDzJGtUk4dDkY/QEdfOFKNB7VzPAPYG
         UOnJRy57K0Igl6C7uQnA2i2Jw4JhRFyI9yceTVjq2PixtO0u5t5uTMvuon0udAIEWcvg
         A29HxRPd30V+Pyo8sonV5NCH19YveiPdxUKldYrn37G22vZ3+9yDjWXHvb6wQSN9H+JZ
         lPqnTWzg6m5CbY6gg1p0YqeUmrN6oTGGCtfP7Ai6eQpr+ck0vmfJEuwGCjrbiuAjUR3f
         +/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5OWHn51l3WpaTiLnvtbOxvyAvPHW33cLAQU6jF4rurhtyVKS5/THpc9mdpYXJw2F4oXqVq5uWRZKY0Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWfSKu9/AESoj8+fPMpr1o9LIVS4ElfFIK4FUOsDsyExkKAQG
	DQIFMgYkNdcV1/eYoBzjugx9r61rHUaG9IF4yhFDMojtm8o2EmJemMt/42MZDgi3JhaYENBTqw1
	Yc0PtFPBsMncP9Y9vbwxvk1O/mJ6zABQM9Doxyw==
X-Gm-Gg: ASbGncucQJoRh+ykdDy/HGWMgQrXpFGlRkCp7K9qe6+BHJpBBUuZb9849GL/F56FCl+
	MR0gTPLMHhLdNJCsH1jmx8NLekqWBEQPmkcZGU/LqgH235qAIxJjndwHqsFAJj7LUu/j4sV6zWZ
	mGrEF8Oje3ZfmLHlzKXbaYr5O42MI=
X-Google-Smtp-Source: AGHT+IHVMDgrxpiMAMts0+d6pAHMmbs+DKlyOlsJcQRgBdUnM1Arh/L/Y1HIIcETYwiUqxFlkWz35mNO77MdJGM7YEc=
X-Received: by 2002:a05:690c:750d:b0:6f9:e609:6a4b with SMTP id
 00721157ae682-6fda30be95dmr42050127b3.23.1741186440140; Wed, 05 Mar 2025
 06:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304142803.689201-1-arnd@kernel.org>
In-Reply-To: <20250304142803.689201-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Mar 2025 15:53:24 +0100
X-Gm-Features: AQ5f1Jop9maVmyVlQa4pDNjDZNA9U2rexGCX4_vVPocLK9GIMh5i3XadhUynJ5Y
Message-ID: <CAPDyKFo79xyTOKxN7A52J2Et50++fifdosUpyb2mm3NMc+EC1Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 15:28, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:
>
> drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit declaration of function 'devm_of_regulator_get'; did you mean 'devm_regulator_get'? [-Wimplicit-function-declaration]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
>       |                              ^~~~~~~~~~~~~~~~~~~~~
>       |                              devm_regulator_get
> drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to 'struct regulator *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
>       |                            ^
>
> Add a Kconfig dependency.
>
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
> index 7e4f9b628f0b..218d43186e5b 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -5,6 +5,7 @@ config ROCKCHIP_PM_DOMAINS
>         bool "Rockchip generic power domain"
>         depends on PM
>         depends on HAVE_ARM_SMCCC_DISCOVERY
> +       depends on REGULATOR
>         select PM_GENERIC_DOMAINS
>         help
>           Say y here to enable power domain support.
> --
> 2.39.5
>

