Return-Path: <linux-kernel+bounces-212054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDC905A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3D61F22736
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F963DB91;
	Wed, 12 Jun 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCemn0Sq"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA73BBD5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216206; cv=none; b=YOidzFlfoVM1AaZ1Xjh8y4V5tODhMwOVYBDeg4lnOFq8LZGcPCvwVY6D3bZjNkgUgChfPCaHhMz68qc3Y66okYrO3JMpRxiiFwDl+WsZaH9G+PZhJBT3a+GkAUx/mPIWUuNdKh9zDv9LNJD2LDGY/Wy+mZZ1ht75e2tvx/4LNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216206; c=relaxed/simple;
	bh=XOoDEVo4OZzwLhKRiU4JC4hHaduq+EtwyfIuPbwP1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlXjayUsxRgSKvFNt8mUV+WyEr2ui1DgT2lBkiHQ/NFyrKWjQsJ+8LJINuoqAfhu9BH1kI0oS+68O24fiaOveaMF2/YwW0DQ4geWBDDoGa4N+V86kUnutvwMMPBhboZKzT6cIzudPYKVOaIKspboTJ9iVhhmgtlSw9QeWOJWSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xCemn0Sq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c82101407so362667e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718216203; x=1718821003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUlMhvz/JBG0hn+cnvEVI731dfNOlIAiHpYX40k8o80=;
        b=xCemn0SqcVvJ2gDTBuoHsGbzC/unsRRE3JBI2txB7s3q91fa2eUlQS+Cmz+u9TZH59
         73eBB5D9Wk47YDD9+ohcPTj6Gtl9oKCg8VCFJ82+m2u69y3wBilu/7iAiF3EtwvIsvYw
         xOE1MReQOZOAU8BTd4DyCqqFZk3kSuPUwKMF8669Y72OSo+tIrTYuy7OMUCsgcLDr1FK
         3+J82UFpmffNcBvpWpjnpPEQuw7CNzDmd+fVTMWJEL7KX2fPpKHwbUws1UuoDAMA8DXR
         ioiFMR6mDVD4NZojfs+pjJM+UO7MbNto49nwSzgZXI34DGXJoDpRxTWrL3OtCvD1IhmV
         /IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216203; x=1718821003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUlMhvz/JBG0hn+cnvEVI731dfNOlIAiHpYX40k8o80=;
        b=WYkmnq+pcnZzwwsym6YIrm6W/6sb8htdAyBiDBHINSrgsa27P/ZYN4xi2PWszqt5AA
         b1BHFFGxPVGCNNUZeMGXMCPqEE0dJa2bAKAD1/u/O7VUmMKEhbV956hwLwU/2WfaG13K
         M01JGmDYE/meyuWRcCKNmAfqbGOqcSf3WB4XPGm3Zt7gzy5T0dyUdEUNKOcE2Mx3asbF
         cy/7P9pCMPy5WC8TVQeo5kEneDW9RsQdeC39eo2+UfpCl0j60hBQAsE1LJq5uft5BG45
         fv+lFFYpikmAT4fPJgTpRcyelGxdXLwUAkn+Bpw+RKDSxY+6mCF7C+axjy598f6LQ3e+
         sqiA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ku8EhFw9A12AcrY9148tKzDnI3CPHvGYvNlQP2/Jmadr1yU5l+Za3jGl/3lMl7p/+RR59WxHiMNzhWRxqSTh2OFPdlUwggj7oMQn
X-Gm-Message-State: AOJu0Yx/fx9dJVBb6l/rshYQdFJ80ore4JoB0nEU3UnJ9BQ+EKbSijk9
	59XC+cjrAn+Tl/NpDhzYVyG1v0j5lEt98bxiFou8O+zh3y0ztmba3LK5KArf+GM=
X-Google-Smtp-Source: AGHT+IFi6JIRt0lupvSgxsB5ZYGwl4QJ74CdnmzB6WDu0EVO/YwQmQY0fZ4yKdEvWvDG3PDsu/+Avw==
X-Received: by 2002:ac2:494b:0:b0:52c:868f:a28d with SMTP id 2adb3069b0e04-52c9a4036d2mr1927485e87.50.1718216203024;
        Wed, 12 Jun 2024 11:16:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1e57sm2635583e87.26.2024.06.12.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:16:42 -0700 (PDT)
Date: Wed, 12 Jun 2024 21:16:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Banajit Goswami <bgoswami@quicinc.com>, neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 2/3] ASoC: codec: lpass-rx-macro: prepare driver to
 accomdate new codec versions
Message-ID: <ltq4i765kg6onbcknqntk5uarberl5mblar74l74tnvhsc7sfl@5a3sulhvcce2>
References: <20240612-lpass-codec-v25-v1-0-9f40611a1370@linaro.org>
 <20240612-lpass-codec-v25-v1-2-9f40611a1370@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-lpass-codec-v25-v1-2-9f40611a1370@linaro.org>

On Wed, Jun 12, 2024 at 05:57:22PM +0100, Srinivas Kandagatla wrote:
> LPASS Codec v2.5 has significant changes in the rx block register strides.
> This is a preparatory patch to do the required changes in the existing driver
> to be able to accomdate these changes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 361 ++++++++++++++++++++++----------------
>  1 file changed, 209 insertions(+), 152 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

