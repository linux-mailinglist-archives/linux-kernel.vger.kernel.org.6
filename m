Return-Path: <linux-kernel+bounces-270871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFE944677
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19211C22335
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9099716DC3A;
	Thu,  1 Aug 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gS2UdRq+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80216DC35
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500577; cv=none; b=l4tpB1PmUfHO7paIYYby28oHbr+CRTMT6rG30FeUE1ibwvTuSlfqZj+JSSqTv2/jZWxRWaajyk4tJ4f8ibxoyMfKSWcF/5Hg5Czqpt9N0+9/OiOJ9JUNT2hd+ADw/T1uGWCCJy3k+ppn0xa7LQBBvlXb21hziCBzo2et3ZhPbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500577; c=relaxed/simple;
	bh=DT7Z/Dr7EC6wH3bHClnXwVde/S0OfRJ0y8xo3AP575Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho9a754bDMfWMVCg+Hdu38SxO+BX0KvS34fibIyHRQmRMemKFnji+lxmpODi1EnQddB0kHEl5W3UODFCejW3Iu0PtYVsZ97sAljTH5+AcAcwX0M3KTvhC+cZR07s4K9ZvSK6W3fc1Y6t6Ov8MQ50RGCuAzoU6PKbBNMzvT+srLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gS2UdRq+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efba36802so11062180e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722500574; x=1723105374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSGnD2DWNUSNtIkP15Czx/EJx9+uS/yBEuP8HGdsMsE=;
        b=gS2UdRq+FH1IQ88u23BgjIvht3gryVEtpZjwXs7g8GtL3NuMCv/sXALqECsDO+8zDd
         mxgbduJBk69WMlgs5GWXVJzHnZ2k04hqt0aB7/T2Cdzxx25Qz4LWjavkuWALWUoq38bx
         0juzW3OQu5w4q0+qxsyCS5QVvj27L9zEHnnL+mu8O992iN0rJc36OSe7YVvlkMv3flBw
         6ZJLYQ0GaM8UZlCTtNcdSB/qfAy/UISeRLxhNz3qayVYiydZXWfItnrmqlD9OlaJqtrc
         ntjaIXXvyU5MFLd6LW23QdkGY5kuVRy44xltPLd19Yr2w7GmOS6sBhuVhGNIZT/5PKY2
         4zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500574; x=1723105374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSGnD2DWNUSNtIkP15Czx/EJx9+uS/yBEuP8HGdsMsE=;
        b=YByp4gj56TbXaudF99dwz4HK7KAf3UVReo05STtUf75bPsIvCbO8LTQcwSTidmPZQ5
         R6GFo5Fe0OPzApoxiUvt4GH4sRV27xmu8RGqrFs7qcis5kNpB9nWVTIreghDiWD/U9BG
         zfn3P9gq2SQAqQt98SoMICjqg/xJsR4BXFE4xKKxLvUlFsxM9CGMnh6lsNvI+HvKQqBL
         zFPStZ8jvB4uyP/ziZVWFj6gxueXT89wOZaYvBK8Z+H1TPFa4/abdwXymrpTOKVkWMCS
         xEQLb2Vy/VBbf37uxuQj5tnzy90DKuC37GgOP/bJlK39IfKO/CYTCgqURoZWrKAPUt6N
         jR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUpEAmINVE8qinEuDkpurLOn3sZunmnvBBm1Wff20vMwLq5NkrmqgLfRJ2RQOKndtbZoGY7IrWxrnsUbg2ry79ryt0nh6AQKSU+vJBV
X-Gm-Message-State: AOJu0Ywx7AkeLtOoNPDZbyH0zCTiTYhBGZpbkz2v3zdFezLDybz5iXge
	sSC5qRD0xvisL5j9YHGAIkEtcqzQNAagp7nn0hN+ltXFf1qI7w2cRAti30Lr5wM=
X-Google-Smtp-Source: AGHT+IEWp6JLVNetkx76xZrMoBBE0Pp+5XNDbasSkEXbs7i9l6MQsrr7uyA9rchqJH6Db172CYonUQ==
X-Received: by 2002:ac2:41ca:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-530b61f3485mr858416e87.56.1722500574277;
        Thu, 01 Aug 2024 01:22:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530abeefd1bsm802326e87.179.2024.08.01.01.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:22:53 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:22:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v3 6/8] ASoC: qcom: apq8016_sbc: Add support for msm8953
 SoC
Message-ID: <hhz6m6mzvwh7q5hxbiitbwiicgi5gjv4mx7wnq4m7ihthw3qab@3dy7xddqfczh>
References: <20240731-msm8953-msm8976-asoc-v3-0-163f23c3a28d@gmail.com>
 <20240731-msm8953-msm8976-asoc-v3-6-163f23c3a28d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-msm8953-msm8976-asoc-v3-6-163f23c3a28d@gmail.com>

On Wed, Jul 31, 2024 at 05:25:30PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Introduce support for audio card on MSM8953 platform.
> Main difference between MSM8953 and MSM8916 is Q6AFE CLK API
> supported by firmware which influence way we set codec clocks.
> SoCs shipping on at least msm-3.18 should use v2 clocks.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: rename functions, add msg]
> Co-developed-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

