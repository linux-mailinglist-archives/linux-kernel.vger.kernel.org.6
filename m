Return-Path: <linux-kernel+bounces-239334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50406925B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6457F292129
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A519AD42;
	Wed,  3 Jul 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4C8QV16"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245217B40C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003844; cv=none; b=U84wzCVny8CKyVpXDh6ThLuwmyBktuJGeFNyAmUibIcqnUs2MRT0pmI+N+C9l3TxJDCXEypmoISicxgRK4Dbx9K28zY9G4k/Un6tWX63678Xx3AhB2+rrcYwnyiBdVhz9zZwRQWUhpZiw/X+W2ZAttigLgqTNJr/8Hm3skosooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003844; c=relaxed/simple;
	bh=97g5hVGvQ1qwpc2CPaPuBD9gaA9Pvxly1JlZf2rwD3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDp3N+6cuEk8GSqUBEJhLqqt/5ePxapyTcX1vXi/eGifsYHpQYaCHZwOxX0QF1AKvhfSmvpvOX59C3aCQYLO9mPbLrD9/FSbQaML1mfPyXsQKZ0w3CzA9Rg/ogdten91LioCgOADf8D9j0e4HcLMV80ZgxqcooqV3jndReLHurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4C8QV16; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52db11b1d31so7304972e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720003840; x=1720608640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAbweGD+BN+79RknZZB5w0QdvnNoIWN8iG0fgQ2u8ZA=;
        b=F4C8QV160Oz6Ca5n57eEGTogOSb210p84C3bvYKLKi81s7xhv0XKJw1KHMuiVaa12U
         sDauLBwUZNi137ILUZKwf5Z+MgUyO0LYkIsrYW5mbtYQZr2upiCLpZAOnUntWe598zju
         IQRtbViUFGOafI0n6W45pRjN4am2FCjiJeGoh/8g07GfMEiZIQZgHyL3/9SCQe/OTJ+V
         pBpoK0OdH/D0zxIUUEfOVZoJvVPZh3N/zQuFe3ZbI7JRaN0AGc2+icKMby2WIDwptVmn
         0dyLAMhuwABvvqnB6f3ktfB5YFMsf/IyAfGmpfLrppnIoNwiCtF6EBBBovg7gBBXL/hI
         JTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003840; x=1720608640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAbweGD+BN+79RknZZB5w0QdvnNoIWN8iG0fgQ2u8ZA=;
        b=fA+uODCEkAuSuWv9PU7SM0RTQ0iwbuMCYMvJlWgHE3Etre5XHdQw9jIabtlUMIsN0U
         qftH8O9WFVCAi4JFKD76cpA80o9XisX3Sv7xb4K0n5Y/KUtdunzH46VK6QjS9BbvqWp2
         yR/Vbalnb4F/conD4HW8012a0ehnMeTCeHpF41QokR9T92hBU2DKqa7KtB7PujsD4+OZ
         AjAdLnXS95gkJmnwpvu/q05fag37rAE8NWOzVmyeeLsHMbfoEfJlFk9EYbbmBA/kgxLg
         PJdnWTqfenEcBylEyJ7dnJu6kVx2KmiEP2btieyTPLuqefEP5I7eGsAjyUw5PZxVIwTO
         vYiw==
X-Forwarded-Encrypted: i=1; AJvYcCU1a7/mQ1m6PLSo/0kCULadFKKVwL5RaYp0DRL/J5MqCHFy6xG55orh5QgkQHy77ZLdPt0IWJqtT3ZnOaPFK4Q44WvSj0L2bgSSen7W
X-Gm-Message-State: AOJu0YypWs9DEV7oZQgP1xhiQWcL56SjAnKxbSYHbyNgiUAodTWWVZR8
	3EvsUVNPteEilHn66Fx0LLS8Kzptafet6kkngstsDyb6aVUMoI5HSbqgzVWM0Ic=
X-Google-Smtp-Source: AGHT+IHOOKL4YyNeD/zQtvaedknaKcTA38zEaMOgcwZsU9QXJ4gpOSNYzoc+NWDud4SlyJkddZjdUA==
X-Received: by 2002:a05:6512:39d3:b0:52e:7688:2817 with SMTP id 2adb3069b0e04-52e8266eaebmr6364231e87.17.1720003839232;
        Wed, 03 Jul 2024 03:50:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0b7fesm2128928e87.31.2024.07.03.03.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:50:38 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:50:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michal Simek <michal.simek@amd.com>, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 08/10] clk: qcom: lpasscc-sc8280xp: Constify struct
 regmap_config
Message-ID: <wc5hbb77tc2dalf6feg23ptdxdd7cjhshkgnbeiknalqicu7gn@jghelw744yot>
References: <20240703-clk-const-regmap-v1-0-7d15a0671d6f@gmail.com>
 <20240703-clk-const-regmap-v1-8-7d15a0671d6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-clk-const-regmap-v1-8-7d15a0671d6f@gmail.com>

On Wed, Jul 03, 2024 at 11:50:21AM GMT, Javier Carrasco wrote:
> `lpass_audiocc_sc8280xp_regmap_config` and `lpasscc_sc8280x_regmap_config`
> are not modified and can be declared as const to move their data to a
> read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/clk/qcom/lpasscc-sc8280xp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

