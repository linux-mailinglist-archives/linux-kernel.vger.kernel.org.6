Return-Path: <linux-kernel+bounces-264079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6699D93DECE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106301F2332B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40157CA7;
	Sat, 27 Jul 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtzKeLmI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609C54720
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077362; cv=none; b=lHF8iOxLWZT17sXYbTAbAcptsLUyn9rgQu6sjgje8osHKBZR8kgK8HcWN4MvtTs+ixQkvbXqR8sGPI4PJYoQfqyk7M7c8jK/bw28lrxqm/9GjOOeYdmri3LrutLgq1Ljuz8FrKdXXf1tYZ9j2rGDD6kJ9xf2zsT9S2gd/PzCL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077362; c=relaxed/simple;
	bh=u29x3z9nNj7e32wU/R5WeTPNlM66fftlY+D73KLs8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH6y+9Xr1osa1ZYF+EGWS0oznP5WiMrguLpBrAEBtBGP5qHCze6kIVT+nVpJzOuRvwznR0LKv1PRQEaBhUfcvJR5ykxOzdj33uHltYG8IUd5fzbP9jZZpFSckQTVGm/082q0WJk6ibUVolqBHwRUUaS5NhUUJsRIMTZGrXffFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtzKeLmI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f025b94e07so25600271fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077359; x=1722682159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geCRQMjPSwcsby6sgvnZan39KM22MCRt7HcUFv8NB60=;
        b=EtzKeLmI4RGMVx/ApTQhGuvp/fn2CIVOrVqiU9bBrzT3jSeZscHSoRAMD5L5INdjl7
         bGPqC/ALiZbGGwhzxckvo3RVkd2ndbdTUaPdQNmL8skuv4B0XjrO18g8gfmrzT1lHxrW
         gqtLyL0vHxDlLsvDrtip2y7uqVYVFFupOQK531bzLYsychVfRcuy55a67Iv2ZRDJ3e4I
         0L6sdPH8+viSSxzc+pk0KTglW7uM+JJcY7FKIWOaITiyz0h5Xw0R5dIN/zzOXaJijgPi
         Zh3UUv93eyp7/MmSUxjodb1P31OmUs7OCjX/6o/a1uDQJzMvgWpo5Dgdmef9luZ+dakf
         BqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077359; x=1722682159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geCRQMjPSwcsby6sgvnZan39KM22MCRt7HcUFv8NB60=;
        b=DFUgYwu7GZ1kdbTogNNe7arbnr2WnF9zj96vtxJMWTvaCou/6ilTb9PB+OGroCxkvh
         jq1rkkrxiFVxzdoGfNXogBrAJZOr7th7CZhiQXfV+YWQ5anq64e0tHlf6xJch49hvBAB
         9isIcnFhO024BnskDusMp2LGQSO0GEpYtn+e1P8SVJ9eQgiabwxWoE+wxTo119QC3pxi
         6sfER8+zWwXzOxhEW6n6kuBv7KZOlwA1fqthHqK9bUdmcw2wfOSq5Eo1G6LRcxsJsDwh
         6YlibSPlxm+TouacKpL58BbSeXTjW4mzK7/5MnUdsX3WSUgFNyoXUUc5KKeUw8GbGjPJ
         oM4g==
X-Forwarded-Encrypted: i=1; AJvYcCU36/6G/bErdEFKSUL5gniKbtqa57MFrxzEeOscXxOXn95f4qZ3GkvZqiE272yOLT48digdYHs590QMO1l4ZfR+ZrxrAtmXaSScYVhf
X-Gm-Message-State: AOJu0Yzve0UvQcq8GPzgnguMxaxTgr3x8egrzrQ+g1mSNI29wPbsNDjX
	MQhRRodgmYgp7f4MQqcvhgXPv+ZFk80xYTuwJtDRI6y3DKzq9yhALm+g4sertsU=
X-Google-Smtp-Source: AGHT+IGAakSUy6drg7IAUAowlVvqX75jk6w0OUsoc5NIprF+xI64fMmRUUrOeW29bqgdNpmn/JjE+A==
X-Received: by 2002:a2e:2d02:0:b0:2ef:20ae:d111 with SMTP id 38308e7fff4ca-2f12ebcaee1mr16162881fa.6.1722077359180;
        Sat, 27 Jul 2024 03:49:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0f9ccsm6943211fa.14.2024.07.27.03.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:49:18 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:49:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] ASoC: codecs: wcd937x: Move max port number defines
 to enum
Message-ID: <lwgi3xhry2zz2filzdrivluexoyft6ohx5b6xfqsp3u3vx3qvg@hg6aq6tpmsmo>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-5-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-5-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:47PM GMT, Krzysztof Kozlowski wrote:
> Instead of having separate define to indicate number of TX and RX
> Soundwire ports, move it to the enums defining actual port
> indices/values.  This makes it more obvious why such value was chosen as
> number of TX/RX ports.
> Note: the enums start from 1, thus number of ports equals to the last
> vaue in the enum.
> 
> WCD937X_MAX_SWR_PORTS is used in one of structures in the header, so
> entire enum must be moved to the top of the header file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wcd937x.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

