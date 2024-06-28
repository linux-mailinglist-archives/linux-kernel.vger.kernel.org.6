Return-Path: <linux-kernel+bounces-233603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A092F91BA18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D195A1C20890
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247314B96E;
	Fri, 28 Jun 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh5nwbNL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA745558B9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563728; cv=none; b=lbeYteV4dKeKI1dlzCZ2kZ7X8EpmdeaQJ9PbYkYYqXW+OEO5y2w7WGY/PeASv+z5Nm2twmonfEPTZ+b1x/nERDGuJtDUo5R/jVygic1J2b5UygVQWINpTwyWuCLmNUVoO6lx/KCDS6hnE2k8GXulVX5IaHvDVvPBlJfoxWaJszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563728; c=relaxed/simple;
	bh=r9/2elFYnoxM2mwS8pLdiixRoCcTB/Nu6twSfevvkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBjO/aR1xOL/nMwkYYx/VvHnRj8Uhuijfeai6sCD9iZxVwV98iSQr2L6WwYWAxrGxMs5T+9izR/SLBnuXWmdsFTGTSaFGs5QEJV47em1v+9y7BHz3jaj9J7gTvnTaz3x9b5gUcNfyjRrGtBVPVJaVdtjdwtUmzf6vL9v6nlI5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sh5nwbNL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so2972471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563725; x=1720168525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNolEEmkU6Ry+wXWBxbsl928QObWZnXzUE7LPASxVTE=;
        b=Sh5nwbNL1jwLx6tbmRmDvUzzlvGOwzAwz7CffBWiU/I+gMO+UBESQv/tXar9Cx8b9w
         Qr/nNzEpSV0fMl4HCVYHarM70k0/Ylj+xhzWEy+Bg2FJZHEf/pQbm0hH2LKrNo0yNkoM
         Wsm4ZnHqHhrQexP0tUZOUAWCKFbQ3U/Amj3cj9mNE3ra8GX1oQe0HoS6RCoDRs965bJD
         DF3CC1pN4CYTaEN0UHRb1lVQBwf91/18O6bZIhIkUeW2QKlUiJr9WvkykfQg5/kqbGka
         54gc08hEI95/CafAHpSZ/FNlSIKWfNMUK4daZ3ESQ3LKgWKwl0n76nvukJGsiN4bth3w
         iyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563725; x=1720168525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNolEEmkU6Ry+wXWBxbsl928QObWZnXzUE7LPASxVTE=;
        b=q4DScPqkMojsj4gSX6QScq2tV7FCvMsgN+sv4IrHG0r/vT+uK0YE5TgQKwLNgzkXlF
         i1fsitOJS/sK6hoiBs4mxKjsf9FAwlkbb5TtzzZDxCQOI3elPKNFSN7oUF6s3wgFAzjh
         cQa+ZmBeOe/ciAoTakZWXIdZ93HQyxLW6dNS8E5FOfH2aIip6Pwfn7fH6Qok3Dx69SCW
         8rJmBACwxd5RzsqXLin5jWhxhMklV1uYb3lQnnNX+codwqkuDsMuBnfPxBrzJMtlDpSW
         fasAs9YFASWfCe67N7AFlELlrzUTlpxyg9fsKXayRb3g0ZKqd2gjqEXy1FzwNoOBt/mD
         8ofA==
X-Forwarded-Encrypted: i=1; AJvYcCXgpKwK7YGwGK/m15ickE8bE+Brm+9VAwmzu66JtxNXABrdpww3oCfmEL8POlN8Z5hfXx2grrlYeWGvX9NN/Xf+nytKAHpF2iLVqm4r
X-Gm-Message-State: AOJu0YzqG++Zod3IszU5zDlj40uLiAVN8dUYWa5ElLY29Q+PelPTpK+T
	H1ziLKpN16F9QXrdrgzn+dRYrfP+FGhLJavOJLix+MdwFBvIpVmxyHgZZySRxX4=
X-Google-Smtp-Source: AGHT+IH0dVLpq1WiFFtaJNklk51Rq5LfwF3kNGv46euWX6ESZ9aSdNKd7M7qDLdGFtoOEGCvB3sxKA==
X-Received: by 2002:a2e:88c9:0:b0:2ec:556f:3474 with SMTP id 38308e7fff4ca-2ec5b2e94bbmr102009301fa.52.1719563725213;
        Fri, 28 Jun 2024 01:35:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee51622ae6sm2179691fa.51.2024.06.28.01.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:35:24 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:35:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: dapm: Use unsigned for number of widgets in
 snd_soc_dapm_new_controls()
Message-ID: <r2mogdrjnwf7bg7ytfnxrz2hmwbsuur2pzy2b3fpzz3apyxvts@bppukrkvrxhw>
References: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-3-ede31891d238@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-3-ede31891d238@linaro.org>

On Thu, Jun 27, 2024 at 05:23:45PM GMT, Krzysztof Kozlowski wrote:
> Number of widgets in array passed to snd_soc_dapm_new_controls() cannot
> be negative, so make it explicit by using 'unsigned int', just like
> snd_soc_add_component_controls() is doing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/sound/soc-dapm.h | 2 +-
>  sound/soc/soc-dapm.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

