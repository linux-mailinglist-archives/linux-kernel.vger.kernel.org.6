Return-Path: <linux-kernel+bounces-318762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B368A96F2EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074BB2815E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065691CBE82;
	Fri,  6 Sep 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nE54EPjy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305C1CB157
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621785; cv=none; b=Doh7e2BD2r0wRxgabe9PbfcDS4pJUQC0QDncG0Z6X0aWz1UJ3rkFKYDWStF3F2owy8gHMDL7EAbd4x9l/x1R4lz3Ja7a2Itt5F8T3WWnzYVaNLIXGPGk49qqATIEPYtVqpsPjTEcowP/OEJ7ldUY8lzICOmqpP9u4pj2GjW+GJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621785; c=relaxed/simple;
	bh=Wmp19ZLbe2P0V0jL2Ao3BXfy40ExCrN8gOpbuS8Jyqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lB0r38XNoelghdCf6fO2P2rs83mzwJZ3nFTtdKzirSt2+a6T0epxSq/uREQYLZXJoYI+vHgK58EZphD9RtUE44l0Vd/3XGExNDevZTQQq0BcTCxv3twWpIe4S8KPAJp2N7J+SNAzgJD1tOflFDrM+EVTABaJcErD8Ds5MJ751j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nE54EPjy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42c7a384b18so15334605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725621779; x=1726226579; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=92+67uwDsO1hQyzhgte48I/CNhtegYeJx45/P0oF94Y=;
        b=nE54EPjyF0jn2m0WwJAF3FlM27kyBnolT58IuawqnrzmwnaO3xTnxt1HiJRK16o9F0
         qAFQvhpfWPXmR1RrUjg7swJApKC8n0JmvI6kXE//WxwSqlgJ0jiovBWjdQzMbTySdKJ8
         b/zcJpSh4sshb5U62dpOZhGfiFQjii2r7P8gzk2yMXTk+FaNQ/2Kin0T5YRLsXh9YbtK
         GX/01lYngS4RxRwAJs9/O0WmPz5BuDYHKB8biENXnTDt9kdHFHiC75xw8CNFelMmL5A8
         fjVplw+3mvpOs6V2a+w1I3YIO0PtyTtuRLJOYsBUGlQCK9sZx1Izvwff0EVjbeaPjX+V
         E9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621779; x=1726226579;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92+67uwDsO1hQyzhgte48I/CNhtegYeJx45/P0oF94Y=;
        b=R09dXGVl84GjknYikOsUzfPgjetBURz0l9ntNeZ7OlVd5szhjR8hX3rD2fmOFEmp16
         b/oah6DVgyDEmgmlsYqoaEUNSvW3UAGpiujHS9DrxY+1cKR6qAfOJs+B0iP49Np8QDiD
         HHe59xkjkDXx5G2Lg6+EAkwIDNXkgiiSATMl916uxtnMkpWurA9rSI3uS4FFrvT37k8h
         tVLglanEg21u4oMKfOB/QDkIblbGJAGyJx9strlQjKt/i7mkNgPgUEJdaTF71CFl/cth
         hqj8fH8D/QKuJeu2NElvW61H/COEewh6flu+vdNgA1LIqSpbAEEwpaH6fZaA6l7oF+Qx
         i7sA==
X-Forwarded-Encrypted: i=1; AJvYcCWcObQxFFYZ+PuonwXCgxK68Hc3EGlRoKrKl7sW/BqU+yMjXFtrk36FRoD+hAbm3bXlyC4r2fJz96mjsCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZuk1yvxqG0xBWSTCrHveb8w3WrLtGafc473OaAiQGMqxq2Aa
	xHRgG8CdZPras2J94rw7o+qoqppm8CeKm7EJ7GeuxQfbKFynhYwBw50Oh863kqw=
X-Google-Smtp-Source: AGHT+IFj6cn2VhPIBLzycX7f8yDdpZxCP0fnyLUp+RAmxAnbmLYkKHqCh+9DjZxSWH8mgvyVVR5CDA==
X-Received: by 2002:adf:cd0d:0:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-378895c5b22mr1505513f8f.9.1725621778667;
        Fri, 06 Sep 2024 04:22:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b34725desm18835563f8f.81.2024.09.06.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:22:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] clk: meson: Support PLL with fixed fractional
 denominators
In-Reply-To: <20240906-fix_clk-v2-1-7a3941eb2cdf@amlogic.com> (Chuan Liu via's
	message of "Fri, 06 Sep 2024 18:34:40 +0800")
References: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
	<20240906-fix_clk-v2-1-7a3941eb2cdf@amlogic.com>
Date: Fri, 06 Sep 2024 13:22:57 +0200
Message-ID: <1jjzfpqb5a.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 06 Sep 2024 at 18:34, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Some PLLS with fractional multipliers have fractional denominators with
> fixed values, instead of the previous "(1 << pll-> frc.width)".
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 8 +++++---
>  drivers/clk/meson/clk-pll.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index bc570a2ff3a3..a141ab450009 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -57,12 +57,13 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>  					  struct meson_clk_pll_data *pll)
>  {
>  	u64 rate = (u64)parent_rate * m;
> +	unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max
> :
                                 ^ Please don't play with this unless
                                 you've got justification a for it.

By justification, I mean actual numbers showing the difference it makes
and not just for the platforms listed in this series, but all the
platforms supported by this driver.

> +							  (1 << pll->frac.width);
>  
>  	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
>  		u64 frac_rate = (u64)parent_rate * frac;
>  
> -		rate += DIV_ROUND_UP_ULL(frac_rate,
> -					 (1 << pll->frac.width));
> +		rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);
>  	}
>  
>  	return DIV_ROUND_UP_ULL(rate, n);
> @@ -100,7 +101,8 @@ static unsigned int __pll_params_with_frac(unsigned long rate,
>  					   unsigned int n,
>  					   struct meson_clk_pll_data *pll)
>  {
> -	unsigned int frac_max = (1 << pll->frac.width);
> +	unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max :
> +							  (1 << pll->frac.width);
>  	u64 val = (u64)rate * n;
>  
>  	/* Bail out if we are already over the requested rate */
> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> index 7b6b87274073..949157fb7bf5 100644
> --- a/drivers/clk/meson/clk-pll.h
> +++ b/drivers/clk/meson/clk-pll.h
> @@ -43,6 +43,7 @@ struct meson_clk_pll_data {
>  	unsigned int init_count;
>  	const struct pll_params_table *table;
>  	const struct pll_mult_range *range;
> +	unsigned int frac_max;
>  	u8 flags;
>  };

-- 
Jerome

