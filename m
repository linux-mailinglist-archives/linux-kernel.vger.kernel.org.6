Return-Path: <linux-kernel+bounces-232870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5991AF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7012281812
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE6194A4E;
	Thu, 27 Jun 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdWy26Es"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE121CAB7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514168; cv=none; b=CMsmyg3TcfDolw7T/hZGQhvyUx1wWqEZn6/sYbILVDmRyYXDhS96DJ+6+mxEnnBVDG7uSn1dbZyEO77ta1SYBb/reK61Sl3zlfeIj1s5gQJVazq2kV7021wNHDZgKgo1fcb+kx1OAHL5znXQOoeGyoRIy1z93i0+EC0O6qyLW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514168; c=relaxed/simple;
	bh=+loIEVQbiIvCdpK080P2B2BC20Dlavm8jb2rv/XemnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/hdsukevZLgGUva289ZfaGtb9taTJ5fpnqzY9vKh77TMg5Tu9xN8bsCDb119UY9c1P2YpEYHQpYrdespiNRDjXfd8KMEV4bo8dYz3k/5DOmI6lGcGZeEqQ7FViMAa1Ps4fukiITVuiEHDF1fzoNcfzJeJssVQD0BT5B2zAFT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FdWy26Es; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ce674da85so5386222e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719514164; x=1720118964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVlORxLyi+No4z6mzakpdO+uVb1Q8CeU42Yrc8ZopLA=;
        b=FdWy26EsYMg1O8PZFwF05yLh8qmyWIh/bJIZBfTXIukjW4SD8S5so7RUAejlmOfJJ5
         F8dC/MAIBBnDOPqFo8P66rB+OqDbAZbcRRxmTQkNo5lQUZPGwzuzn6asIVZ8sX2vzp3H
         C4zbJKzGlGY6dxTGKim0wOaCvWKwtkAGxPnjDtgvanFS5+gLuYlH6ITjqQDYV3JxiOGh
         JQP/yZGtNtV6CocGq8efMJJFUfgo8z1BYZ2kOFvCqde0izI9T9AwjK+8+UM9UZwzRBuC
         sIKIe12ebCEfgxn9Ep8s5KqEW1+FYW4bcBnMAbVDKFWgyJqmsb975PtOymgxy05VIGz4
         4Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514164; x=1720118964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVlORxLyi+No4z6mzakpdO+uVb1Q8CeU42Yrc8ZopLA=;
        b=lzedmeKKM5+v7a25RAM4ezb9XLF+a/jG+nyhSDGIRMXKWkSmWJ44H/ZOafQfjoa03q
         gaEnbY8sBj7QfOwlRRgWsFfZKnNM2ZcBviN9s83g0u4r9mfqutyP6X/qG7eHAg1hqDHI
         w8kd53XCSnJ8X/cgXbG1qf3hSLACclcfjubUGgqD4uiAdIlSnNXM9jpvERXM9Q/l0uf6
         lEa4tNKpVG0YAVKEuK/azF0FMfD4CdT9Lm3hkcfyH3CU1/TXrKeYHER05Dvzub/YMbXK
         KGe3ewut9sW4VMqzEVe+FMjx+lGXMgaRavgYzagNpfVgMciO3HwKmIYfdqhctR1sskej
         cPyA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5nFML2sdz4VDqp14l7563VWvFuvvQqGPPSjNtlU+AgtcTXjuI8D4Td4mptzK4bSK/+W0ABaGuBZUrY9Rah+QrfwpwfvNcJrYzCEv
X-Gm-Message-State: AOJu0YyTDj23d2cRNq59cqqKD1q76FC+tNBqD+7gKmlg9NBNCexBliHM
	5w5kb11GIbbq6FxoFbXSM2WXEd7KcZnXnKA65WfvALHP6i4rNW9Ij8cEDFnDmzY=
X-Google-Smtp-Source: AGHT+IHjokj2V4brw5oo7jZhZncGgRxq7Wc7ZcWz0FJNgfC3Iqf86Brk3YH4RGDnAqwGbGyYRtJGkA==
X-Received: by 2002:ac2:464d:0:b0:52c:a88b:9997 with SMTP id 2adb3069b0e04-52ce185d20dmr11430836e87.49.1719514164382;
        Thu, 27 Jun 2024 11:49:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab101c5sm20119e87.79.2024.06.27.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:49:23 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:49:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: codecs: lpass-rx-macro: Simplify with devm
 allocations
Message-ID: <dalyp774uk4ugomvdtrjkjpenfogx6dkx4vtiq6serc4unzasw@xa4adquvcijn>
References: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-1-ede31891d238@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-1-ede31891d238@linaro.org>

On Thu, Jun 27, 2024 at 05:23:43PM GMT, Krzysztof Kozlowski wrote:
> Allocate the default register values array with devm interface to reduce
> number of error paths.  The array is not used after initializing regmap,
> so move the freeing to place right after devm_regmap_init_mmio() to make
> it obvious.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

