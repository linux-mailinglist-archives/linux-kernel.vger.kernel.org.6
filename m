Return-Path: <linux-kernel+bounces-229333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C7916E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB4B1F22CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7717623D;
	Tue, 25 Jun 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MN4EH9bG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C0175573
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334229; cv=none; b=dyw72gMRAuF9fOOn+ar0Fo8N5+z6nBaNIagHGYKntCcFDN27SEw6lOfNTxO7JlxsV31bs9LaM+gRafoPS39LIwtA1kAT0WNTs7EJbsIoxC6w/rt7yY7uDhHEgvPGUkZNRIpYfF7AJPNIxPf1jdo3qjr3M/T7VyUvCVmE2+Fhj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334229; c=relaxed/simple;
	bh=FpCXBcjNasPCd7gzQ0d/1eVDiQnq9bdmJyABlclUbEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOoXLkHg2cDP0EiGViwlzJpEntixsV+6FH4cAkeerX2mwtgxn+0/UqfeZHCOJasgPU8BGZAOGwPFd3iCJnEWNkqtVCeZK9XxiJNMpBmp0/ULbed2mJTpJNHzbLaGFNq9Yut1MU4AAy0NSefEzwlbe4z2SPVn89kLrXin5DuzydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MN4EH9bG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd9f9505cso4751553e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719334225; x=1719939025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir2hWbZRQe6JRonqyk5LScY3xCjHxyFZ1ViC/BMSe58=;
        b=MN4EH9bG8sH5S5sTcgO7D4m+j1q0Fd8dduDS0k3frpQjuHC5an1WX0X0ldDFVZnWpC
         JiMP1KdQS2CopJG77hHrs1ji1y07hfLlooDQpXrI0JUVmoRdhRmFnAYIS2wNO+Jdj/Jy
         ELy0XqKgeDeyDn8XEAMcL0TXhNzkeiERIX9ZJbmByk33Lx3PGsdbDF0Oj6jVw78W/Eh5
         anwHtwB9xmAQnCh+MWrIFi2mBpa8O9ytxR1lFlCAvt3gGzPp1ftn+fQx0CH7Q2iDy04R
         YQ2mDTQIBiqf7SOgT4JXWfQS90xgCfRsouJeBbVd0igCF7h0pJzKODZUixiqm6aBemvp
         ggSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334225; x=1719939025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir2hWbZRQe6JRonqyk5LScY3xCjHxyFZ1ViC/BMSe58=;
        b=skvZ8eYuh68RAwoWLBBaGUHhEklUpmjBp/znUYXTv3+iwwgm3uxrGk/RQ5is/zWNsZ
         Jx3j8sf2IMlDlNUFdITU7EO10oH8QibQcjSpx7ekhzFfDz3AjV63HoUAOfF1mhG4c1L4
         tSk5qhOdPQWT4PGTfeJngnu5Fsi1+Qahx2kTA4mtmKnsB71UpNZ7HBjwLFZIlw1LqTm7
         8gycIYvZnaEpRwqG9sF5cPeLUqdazgUjZb2brPRrYN3cu7BnPM9PuPO/kJMwpyazPVe7
         2J3zJMgY/99mKI/BKi1R8hfS6rBmEIAdNN9sdktqxa6rZEih3C3xtB8MX0xOrzo++o17
         PhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeac0BJ8QXAPUnPCs9lQkz8z+hHSnaBs/+gDOh74ML69C0Pm/+VRK0IgvgfCU9guHr4xW9c4hxWNyhjpR7y/NZWf7LWw8iM/4c3ApR
X-Gm-Message-State: AOJu0YwWPUGkbfSsdWCY34jFxskk23H4mGGJoTgWcnjyUodMcbcqgYaY
	LM6aALncH8Q91M8jrG2CzHrr2rrYgYn52IySx9toxez0i434c14ixE1RdCpWNY8=
X-Google-Smtp-Source: AGHT+IEWhnQd9LfyRRriXAv2lYlKo5QSl+8ZswlUlB2fAE+H6jrFVIyXYSOJ5WBxj4SizxoPJGOuBw==
X-Received: by 2002:ac2:4823:0:b0:52c:d56f:b2cc with SMTP id 2adb3069b0e04-52cdf82574bmr5362111e87.58.1719334225501;
        Tue, 25 Jun 2024 09:50:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b47b2sm1279133e87.50.2024.06.25.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:50:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:50:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: add missing handling of
 v2.1 codec
Message-ID: <7kw3xiqoc6sltaz5w4m2azprieaqbu7jivupgpzzwesxynyjd3@j2fla7epac6z>
References: <20240625160614.450506-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625160614.450506-1-krzysztof.kozlowski@linaro.org>

On Tue, Jun 25, 2024 at 06:06:14PM GMT, Krzysztof Kozlowski wrote:
> We have also v2.1 version of the codec (see 'enum lpass_codec_version'),
> so handle it as well in all switch cases.
> 
> Fixes: dbacef05898d ("ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

