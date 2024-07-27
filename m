Return-Path: <linux-kernel+bounces-264077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0693DEC9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9157DB21A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9F57CA7;
	Sat, 27 Jul 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3gWnIVn"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32D4A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077223; cv=none; b=lI9WtCDKcIvATgpZMxFTJtC5eym/l9nUuLNFzkgLAd8KXUlQigJbfR6ZslENKe2sNqWQhHN7AOih5e3OVzyfpKLjZCTFHI5ubW8hQ1Dy++j2iQe2GPHVC5c1GI1JWx8ECPeTCM/m39UtvzFBCii8v1Zp3qt8mr03uDT7VmNlCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077223; c=relaxed/simple;
	bh=ENelbjUMYtttZc5KEREkEeLihVes7V7c0B9aT3qfjr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kafj8HmLU3XTqR2qsQ1AblcwMn/Rph7cjY0+wDb5hOT4XfhISbCCGRzc1kHys9ks8SY8qAumzBxhp5JG6ZExSOovqX9x39/zDZIEUfPa8YUECiPyAOXeoHR3nSE7A3JukUTk8k2hUb8qt0pNXsvY5NqWO8TG6Wnb+qikv2Px7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3gWnIVn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so3076798e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077219; x=1722682019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqpaDDYEK1izIaPS4VXNn8Yq6EehHgLMYxtkn12m9Mo=;
        b=K3gWnIVnagakBsm7LShMtFTmyQfQl83s35R41aCPQTzO1KQBcwDr8iZSkZ1X+RQEwE
         +u9xjg6vifvbUDku9Q0r4k0z7zG/nP1MKQkRqLtP/7Hj8y8diQcgzb6318pM5px+j6oG
         iIfc4G0gsCgFZo0apWEyxbZRUiAZasoYbj6fo6ebP3LaLkLjDJbPlsJspVZ2RVks2Lvk
         yqmT4JDy4QyJluzAF7W6kcQGTBHJuCN2JUNrGp5rcH/k3GbIPJ1jkXRKGxzJ2kpAcwAT
         w4lG9FF81hy3F55doGAYkzRX7Wmj6sHx9zft5LyPY9h/8NLU7FrEEnCLspFIs+qbig6E
         qg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077219; x=1722682019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqpaDDYEK1izIaPS4VXNn8Yq6EehHgLMYxtkn12m9Mo=;
        b=owpvRw8F6+RTTrbApgj6a/fw5MxvsGOyRWbbkKwIjtORyEOcTsg9nWTyd26PO6Ozpi
         Dl4X3YNa0gYesZIXq6Dg4wczFO3/9CT0gELfvps4UtB+EAzkHkAf8n+DYdq7yqPy/mGz
         olMgsrg8MYCip8C+qK3e/AQmxKgZxzNc9nCKTetF+lhTwK1qWW5Uv19fnupJpuJ8GeII
         rDHIeTH1wFpAYteo4Bu2LPxCdxuMVSm5oR+rSrxP1Y7QFKmdLWtyrh8TmIleu6nvozcp
         PRdlwHTvBjCytB92YMaaJKYNFsOE+MCJZSxrk7MvZRAW+sEXQ8c2TBLzML4JDl3A7kQ5
         hO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7GthZQsWza6hZw1P/8nE7tOLeFgxX0lwYFRV6oEGi2TghaztU+gz3SR2UzMni8xEebbEVsgh20XHEjwF/4ZZ6PeLLYLnvcn4rX14h
X-Gm-Message-State: AOJu0YzdTm+13KB7fzEmboN148itLm6B8xm1nbUEFSNJjpzaZXuUIXbY
	syxg6tWZfIApXsZaHHGRJUcUSzhDlga3/x9pbpumprAhatiDVu+zgRf8hyq7AwU=
X-Google-Smtp-Source: AGHT+IEAA8Vyu/jvBki3y6WhpcWjn+fJcdPYHZX+yGcEKRmJlDSK/lXOf+6qfu7//+lx2sfqwCIwxQ==
X-Received: by 2002:a05:6512:3da2:b0:52f:368:5018 with SMTP id 2adb3069b0e04-5309b2d38cdmr1397881e87.43.1722077218856;
        Sat, 27 Jul 2024 03:46:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc402esm737671e87.51.2024.07.27.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:46:58 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:46:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ASoC: codecs: wsa884x: Use designator array
 initializers for Soundwire ports
Message-ID: <3gd2qwpsty4owjzlborg5hkiqltpkk4gfzuj2zvxamjgjwvrlk@2x2zhokcfbv4>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-3-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-3-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:45PM GMT, Krzysztof Kozlowski wrote:
> Two arrays (with 'struct sdw_dpn_prop' and 'struct sdw_port_config')
> store configuration of Soundwire ports, thus each of their element is
> indexed according to the port number (enum wsa884x_port_ids, e.g.
> WSA884X_PORT_DAC).  Except the indexing, they also store port number
> offset by one in member 'num'.
> 
> Entire code depends on that correlation between array index and port
> number, thus make it explicit by using designators.  The code is
> functionally the same, but more obvious for reading.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wsa884x.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

