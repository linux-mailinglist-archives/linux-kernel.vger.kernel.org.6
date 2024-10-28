Return-Path: <linux-kernel+bounces-385866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66469B3CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4235FB21999
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41851E2311;
	Mon, 28 Oct 2024 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkJ3j38u"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE41E0DB6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151136; cv=none; b=qpfBAAFjG/HrnxSg3LrAyM1ht0JfqwDeYbJc8JMQRQ3PZuoHTvpeRtbXgKlUEYVOa3EZzZ4pTBihXB0PK0xDYE0ZHN0dCc5bKnwCV5AzjvfI+jI++9dNgjQEvTmVK6GWltkj0LT6MLvLcBzUgZR6NpoJazVnDlTwJhhUly4Mgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151136; c=relaxed/simple;
	bh=I+y5LBpxrffDHEAEq6J8VBrLt/nk3//KpfGz0Dbje8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjBtrQn/cvzrDWipkeHZu2UMcONi+V+Y1/LYfaqepdn8L6qV9nsq3FqmN9iAB0PpNDXbbcXQsu7cJ4fVd3L/368U1jbcZiV+xNtmbAelHOxJKKFt/HGV8ITPVyuKAHmLy8W7aQP9cAaOLIz0F63k6ftUR9JXEoXcElJar/MKlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bkJ3j38u; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso44326011fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730151131; x=1730755931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viPeucgoHGdqU2xPgIzGF8IdpMPlf0xB9aPmUtP29kQ=;
        b=bkJ3j38u96byI7ye03Qx/mn+UWN4E/Uxno5Mhwvj7STiD9XLPiWZuUIrgBRfLftXZd
         ThxOWDJ2fFNc8MZjDdSUNPaf0JrUDRf9AXRxO+cQjOxPqWvgGvyiL87MEF/rgs7LMLT/
         9lEwD1bVmS+EFg0elgwF9H5FNm/s0tvrrtOMaMaBQXE29NnO7js8JuQvdswm9P/3XRPQ
         6qz4H0a7oU2J5xU5HNbf/8uX+XEek6zscaS4rf0KBvf2j6aTtU2JEfIBJatsm2CAAXT0
         BBRqAcuMrE2jiSb/k/23uc9RhOn7Yf63QlF4he2oA5sOQ3k1uExBo/GHRKzz/KZKtdIV
         QSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151131; x=1730755931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viPeucgoHGdqU2xPgIzGF8IdpMPlf0xB9aPmUtP29kQ=;
        b=xVK0OQfbD4lkUyMm5BdKdYcVf2DT0BkrSfGC8XyDTM8dP/KLcG75leIu+pqY1ob5Do
         YwqYpJJ0HepTy2OawGockmwgdxEI75HbVBao6kHU3eeVOQn8ROaszeBdBbyBkgaQk+MO
         aCvizVV1oQhGqCS1XWdktHOgPfgBhzD1XCta3L9csJACPe08SG+Gr4HZsKB/r7l1xHlz
         2EYy0uRCTbn6Z53RXhIgS2fIew684ZEOAF/OYeeKrXaYc6GnvkKD7LbuF90sxMeqWb44
         ZYuv95CeiCbsoOtpwp4PFVwIwCkFPN5Cz4aHGoGNnKvirKiqWVo1W4pSeivE5/1tH7v7
         qREg==
X-Forwarded-Encrypted: i=1; AJvYcCW1QPEYBjXP9w66g7L7QZej9eQmyUvlRKsGHsQfvPj29C8Jum89QwyQXleetYb0ERVmK8nEiJ3atcsW8VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQR7/+JjhOYk9nRSyUrSJ589LaaxUFz9qJ01I2oobvttPSsmK
	6FqqePJdeFBmIvf/UyOdkmj9Eb8s4rjsQmULkUxeisPMthxQebjj0eTf0csDFE8=
X-Google-Smtp-Source: AGHT+IFseX4y+MZS55htbXkdAVgkAAMt7Ah6+14DsNDpRvuDzxxDHaTtXbPKoP8HoWMOW7GlK9wDVA==
X-Received: by 2002:a2e:bc15:0:b0:2fb:8de8:7f9e with SMTP id 38308e7fff4ca-2fcbdf61197mr38090101fa.1.1730151131078;
        Mon, 28 Oct 2024 14:32:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d19d7sm12775221fa.96.2024.10.28.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:32:09 -0700 (PDT)
Date: Mon, 28 Oct 2024 23:32:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] clk: qcom: dispcc-qcm2290: remove alpha values
 from disp_cc_pll0_config
Message-ID: <7vvnfzy7e3sbjdlscwf4lutit7p43j4fmoy2xxkfs6ndkqgsqd@dli3uktvyhzu>
References: <20241028-alpha-mode-cleanup-v2-0-9bc6d712bd76@gmail.com>
 <20241028-alpha-mode-cleanup-v2-4-9bc6d712bd76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-alpha-mode-cleanup-v2-4-9bc6d712bd76@gmail.com>

On Mon, Oct 28, 2024 at 07:48:18PM +0100, Gabor Juhos wrote:
> Since both the 'alpha' and 'alpha_hi' members of the configuration is
> initialized (the latter is implicitly) with zero values, the output
> rate of the PLL will be the same whether alpha mode is enabled or not.
> 
> Remove the initialization of the alpha* members to make it clear that
> the alpha mode is not required to get the desired output rate.
> 
> Despite that enabling alpha mode is not needed for the initial
> configuration, the set_rate() op might require that it is enabled
> already. In this particular case however, the clk_alpha_pll_set_rate()
> function will get reset the ALPHA_EN bit when the PLL's rate changes,
> so dropping 'alpha_en_mask' is safe.
> 
> No functional changes intended, compile tested only.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>   - extend the commit message to indicate that dropping 'alpha_en_mask' is safe
>   - Link to v1: https://lore.kernel.org/r/20241021-alpha-mode-cleanup-v1-4-55df8ed73645@gmail.com
> ---
>  drivers/clk/qcom/dispcc-qcm2290.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

