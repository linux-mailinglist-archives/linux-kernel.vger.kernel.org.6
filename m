Return-Path: <linux-kernel+bounces-371276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AC19A3917
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D631F22DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8418F2F1;
	Fri, 18 Oct 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGvX/ymO"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9418E74D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241437; cv=none; b=rIeVK2kOEDd2u0zzPSkbqFHZiyu8SzJgwUPsGte+WRegU/qZy7pejq9RZVNmKtZVCy1vMqFeQRb/b90lkr5i9dvEpaxv4aciidi9v5F/jquYK4RXvt3HCYAVI5Mo6wriccfxz47r4yr2jKB3mnmn0baGgFK61Qc0yoVZ4Yf0QqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241437; c=relaxed/simple;
	bh=q6UaaBG1S1+qACQ6YRhwicu8VBEuLQLOH0LNHXVY9yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLwfUfDowaIHk6uC8p+XkMsiOv+BtoLCF1bwdLPbi8uBYCUX2O80INXvFaZQPxLOZ1BasPiTgYwZcCvUhmarEraAGUM7iajKD5fHtJ5SOR+9yzFGQghp2xmE+VGLZPJBdaATybf46D924FBTn2VNArljbeiEPyHBoWlGYycKEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGvX/ymO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e396a69062so17935697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729241434; x=1729846234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/RSforFp+VQNtLc4ofIvEcTd/s/JTnlqhsY7WVRH24=;
        b=cGvX/ymOsRiCUhCtm6gKWeuZv7bEICcUSiqlkEPEsnKr/DjCPCeM5szJA6HiqIMEJJ
         7GBU7tluoAZ/Lc/wJZF4Dp0fflq8F72YmkdRI7OQTp6n8DQfwyLtOGwFr79mM4LDVKpW
         z2e1o2Qq7rnQ+MM6bWbLXn4LLxzwTssXZhGeZ/QCQRRYqGVNzAHfePrMMmlKjRI0x9NN
         H59W4nbjDXpBXrFw101KgpBc3IIaORYMIlHKzenIVrAXJK77QRvbdS85C30cZiZM40Ql
         Yr2J4dEKBnCjbQk4qON2gBvMLCi0Eto8dhwgnNmguO9ApD8m3r33VPrR4mmz7UGDTqvB
         m3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729241434; x=1729846234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/RSforFp+VQNtLc4ofIvEcTd/s/JTnlqhsY7WVRH24=;
        b=MJ9RekSTxcRgqVOiPndH7grVaYFy/FmhARKdQT+pTSjvNzGty8Z/7YAfAw7C2pbjxa
         1e95qsPhHw0t2tO2aABE0WUTmA2G8Kzkp4Y+qjt0/H+rHUEALerwzJ/1AmsytHOPtaND
         WtE26V+qqWNPaAefgFcuyXelE8NnbhE+RB9lN/LhFQ850evzeoXelser3LJCyZ/wtODc
         9lwrDMKFtcokYNyFBG3MyYARbaaZEkh8T5q7ISToQbKb2UPLaEv1vWK727CN+/dcz2mn
         N3BU05x4phKHx6fSan/6UMsO58Em/3VZ2k3+EkSb1YmraOY/5Yh6ipM0DD02vaWs0CeP
         81kA==
X-Forwarded-Encrypted: i=1; AJvYcCUuvqlaVJAwlSsB8i9anZQwcZTwvgZgwokRYpSp/14hNtoMIc2blj7vQkZTdMMspafHTzbCNrfK4dgnYF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOoiMgKqguGmXQLHaBNDVnD2QsOinvrvYzYIHHCMxKD2zQ1t4
	pfnSgYpL/hoKOb6tYhSnsvptsDJfJNe6lEAna+G6L2FPkkEa8iWER3FyEpkXlVy3X8ZGiet+JPR
	ZJBck1dCAHPybFezFATNrISX+DuuNDzP343z1Ug==
X-Google-Smtp-Source: AGHT+IEfhw8dTGOqtMUmLixgGGVRqyf2gSqNzfjdP2OonSOoTDcrjLgzvPuP0+fWji/QpUGei3fuavAC7iK/8ckB4NI=
X-Received: by 2002:a05:690c:fc2:b0:6e2:1090:af31 with SMTP id
 00721157ae682-6e5bfbe7c76mr17174717b3.3.1729241434462; Fri, 18 Oct 2024
 01:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Oct 2024 10:49:58 +0200
Message-ID: <CAPDyKFq1-fW=d5QiEcYNkErpMuBo0aZzB1pos1CHcPZmAWGTRw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] watchdog: rzg2l_wdt: Enable properly the watchdog
 clocks and power domain
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 18:47, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hi,
>
> Watchdog device available on RZ/G3S SoC is part of a software-controlled
> power domain. The watchdog driver implements struct
> watchdog_ops::restart() handler which is called in atomic context via
> this call chain:
>
> kernel_restart() ->
>   machine_restart() ->
>     do_kernel_restart() ->
>       atomic_notifier_call_chain() ->
>         watchdog_restart_notifier()
>           rzg2l_wdt_restart()
>
> When the rzg2l_wdt_restart() is called it may happen that the watchdog
> clocks to be disabled and the associated power domain to be off.
> Accessing watchdog registers in this state leads to aborts and system
> blocks.
>
> To solve this issue the watchdog power domain was marked as IRQ safe
> as well as watchdog device (as proposed by Ulf Hansson). Along with
> it the clk_prepare_enable() calls from the watchdog restart() handler
> were removed and all is based now on pm_runtime_resume_and_get()
> as explained in patch 03/03.
>
> Series contains also power domain driver changes to be able to
> register the watchdog PM domain as an IRQ safe one.
>
> Initial RFC series for solving this issue was posted at [1].
>
> It is safe to merge watchdog and PM domain driver changes though
> different trees.
>
> Thank you,
> Claudiu Beznea
>
> [1] https://lore.kernel.org/all/20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com/
>
> Changes in v4:
> - in patch 1/1, function rzg2l_cpg_pd_setup():
> -- call rzg2l_cpg_power_on() unconditionally of governor
> -- drop governor's parameter and decide what governor to use based on
>    always_on
> - collected tags
>
> Changes in v3:
> - added patch "clk: renesas: rzg2l-cpg: Move PM domain power on in
>   rzg2l_cpg_pd_setup()"
> - addressed review comments
> - collected tags
> - per-patch changes are listed in individual patches
>
> Changes in v2:
> - adjusted patch title for patch 02/03
> - adjusted description for patch 03/03 along with comment
>   from code
>
> Changes since RFC:
> - dropped patches 01/03, 02/03 from RFC
> - adjusted power domain driver to be able to register the
>   watchdog PM domain as an IRQ safe one
> - drop clock prepare approach from watchdog driver presented in RFC
>   and rely only on pm_runtime_resume_and_get()
> - mark the watchdog device as IRQ safe
>
>
> Claudiu Beznea (4):
>   clk: renesas: rzg2l-cpg: Move PM domain power on in
>     rzg2l_cpg_pd_setup()
>   clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags instead of local ones
>   clk: renesas: r9a08g045: Mark the watchdog and always-on PM domains as
>     IRQ safe
>   watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
>     handler
>
>  drivers/clk/renesas/r9a08g045-cpg.c | 52 +++++++++++------------------
>  drivers/clk/renesas/rzg2l-cpg.c     | 41 ++++++++++++-----------
>  drivers/clk/renesas/rzg2l-cpg.h     | 10 ++----
>  drivers/watchdog/rzg2l_wdt.c        | 20 +++++++++--
>  4 files changed, 63 insertions(+), 60 deletions(-)
>
> --
> 2.39.2
>

For the series, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

