Return-Path: <linux-kernel+bounces-207613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288C9019B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DE01F219DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5727B65E;
	Mon, 10 Jun 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5Fk5AUq"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421FA935
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717993376; cv=none; b=YekRGPTcBdqroqKFtA1InCx9AB8wtAC5V+VFJ+Ho9pkWApNEWfBDX4jqgob1Zkk3KBoMGOr32JQogXTLsUctvm8LFL2aNTpKC2qz7Qlt+3lz9q2qk9qmuek1iTmfpc2Pp2Lwm3c5V5Oilq/pUEzD4Dh4blAsz5Gaoi5QjTYRNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717993376; c=relaxed/simple;
	bh=0O2vT/NFbDSpRpojVgi4cfit4eulfxI1gkhEAmX4BJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH/NLgFsIYzrpvY91o3Sde94Ccak1EskN6dBBMKnmy5YGMzZpCeXXvwlgJQIXsjcb2yHH7tsgr5Oe+naV/Rv2hsyk6Lbk6nL52LeF271w2jMFdI/IGwbknfYGyHXCK5jr3IWJiIcplvhX3OKNCfHlYhQh8jlUz9kw6omFxEAy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h5Fk5AUq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c2ccff8f0aso1692915a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717993374; x=1718598174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+09eQoC+I5g5eNQtRLU+Ga+T20APAwmlVnC6I3aJD7Y=;
        b=h5Fk5AUqwJJz9gRL6YAtT+Cxk1j9XLbwhRb8hOL29UqlwH9ySjhRY6yHbyRavbqrgS
         2i72DVbIaJcYlIr1fjwb6ZbVKAww/aXKAN6gHuP0x9JUhuR4ylwOeF8rRUx1eG0orGgr
         DmV8Nu+aEuekRe1TgufgClO27Yw4BZ076w7brqxEZ912p7zEziB5azUwLgfKOi648taV
         HnXBauBN5tcOc9SkM5SzwK0Lvr+OlzCYW3mw0DqQ6ZhlO+WuD3gGU8ZYQHi66ArxtdVk
         ZtHoOfowv7qb4gRoDIdy3DK1B1JpHZccJhmX/yVz+KzqhNdr7+FbwCjVL/+/BwGj0D+d
         1drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717993374; x=1718598174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+09eQoC+I5g5eNQtRLU+Ga+T20APAwmlVnC6I3aJD7Y=;
        b=wNgaCc8JU+YkUAtwQcZoVn1VwpuNFH6x9OVJX1d5KqUcNu7TPfILcog3Wg94SgXUDT
         as2C/y9zbvsuBOQ5RDpV1Hbzyuo8aVnUu11aQvdSgyLbkXWQUqdWLQeaGKIknbak27H/
         ZR072vNuUovAAqw/GNSXbQB4bG01HJYm+bYVmgDsu7O3DjIFLRXHrSBXA8Xm6kUl6aq6
         lN5dKy8wNk74q0Vx1RWojQNmRmTVO5XKjo5SDPMOdUnMskJYS1z5VVRNPS+acqeplR3g
         7w7qvdkB8vjTiNS9pg4fEY1ApgGw9PgoQEhkBoNyt7nQ1uQiLLz9UYzVW4/6EtVfxSzy
         EsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWniYACPi2CWiheGXLNBVOt9CiJlZndGl+9MOf64iMk4AXz9NhhZnwTzIWdHUJgAsNBX/G/NpIV3UgG+7P0wy+kM8wcNrHON3jljUAa
X-Gm-Message-State: AOJu0Ywv8EAJ8i/xRQbhXl4SpuWsuFZdb0bC17n0vEp/06hcNGYfMqUi
	SiZEklWwxzG6DKqef8IiPHSWRrjmOZe5Lo7RM+T9LstSVzfa+/Y6APVkrftSow8=
X-Google-Smtp-Source: AGHT+IHPYgNdTd5rMnCuMD1fIfilGijJyc9W8RL6pTRXVfjKVXGxHWmAnc69/KfDUjjjhKEzAXG/FQ==
X-Received: by 2002:a17:90a:7441:b0:2c2:cbd2:df0c with SMTP id 98e67ed59e1d1-2c2cbd2e02amr5858699a91.15.1717993373659;
        Sun, 09 Jun 2024 21:22:53 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2e9d8a7d6sm3092647a91.57.2024.06.09.21.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 21:22:53 -0700 (PDT)
Date: Mon, 10 Jun 2024 09:52:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 2/2] OPP: ti: Use devm_pm_opp_set_config_regulators
Message-ID: <20240610042250.xccda2pr277v6asf@vireshk-i7>
References: <20240606113334.396693-1-primoz.fiser@norik.com>
 <20240606113334.396693-2-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606113334.396693-2-primoz.fiser@norik.com>

Hi Primoz,

Thanks for your changes, they look exactly as we discussed earlier, but .. 

On 06-06-24, 13:33, Primoz Fiser wrote:
> Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
> Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
> when all goes well and hence driver probing eventually fails.
> 
> Switch to using devm_pm_opp_set_config_regulators() function that
> correctly handles return values and doesn't require us to handle
> returned tokens.
> 
> Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index e3b97cd1fbbf..8a4bcc5fb9dc 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> +	ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>  	if (ret < 0)
>  		_free_optimized_voltages(dev, &opp_data);

-- I made a mistake.

The driver gets probed with a platform device, while
devm_pm_opp_set_config_regulators() works with cpu device. And so the
issue related to module insertion/removal/insertion will still be
there :(.

Did you try that though ?

The only way to get this solved is probably by introducing a remove()
method, which clears the OPP config and stores the token returned by
dev_pm_opp_set_config_regulators().

-- 
viresh

