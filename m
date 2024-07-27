Return-Path: <linux-kernel+bounces-264081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048693DED2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226EF2837D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B857CB4;
	Sat, 27 Jul 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcmngQIF"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088876A8DB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077386; cv=none; b=EuIcjEV2lOHDJVGjRb63/+xt2TuRznoJM1bAAgJxFnI7Zkf4yH68TYELDH4ALN37aLfgG0RwzP5jMzYGOkfIvCwVFP2Oq5kfhYmLUq7NNWHkweYU1yJuhirppAb9aSZRr6Wjq6JkprWEio8Wvb/ko12cABSZjmGKszz0EF/r3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077386; c=relaxed/simple;
	bh=YuxfSJ4lv/oCw60ifWm2XJgjH+1otX685tSUrnHE5HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1dHnrfQ4EIxW/BCdnIN/mDa/T37OibAMNy3G8VR3QbQ+Vwh1tIm5s5UaSrKHV1Z4ST1HI3b7E4PmFuFF/FEVVkmA/mmIlGamSZHvpqgrkOR+I/9YFaaS4BYqm1J886xg8FBRD2FexfuhfPbxFHgeDjoGTGGr3pV66JHme0MVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcmngQIF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f035ae0ff1so18451031fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077383; x=1722682183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jcXVWcmcbsKQzq4sH6RxYyKF6535bLDAYqbqnjhWxI=;
        b=AcmngQIFof3i25Ga4cluGvIa/CDNymm5x3Y/wwYYexNmU2mdeRWy7Iv/lRwUq2st61
         +eT7JrCOmG5Fbu170QFPu5+Sf4X5TKEG1kcwLLLuNMdZA3oAICttx070x50ZEiNrhW2m
         RZTw98It6I6BqRLXpFvg+QsylxXL3Gl3j9jpih7E//0Uf+b4jeE1gNb87dHThtai/WFt
         FKYUHXkVPQ7SuaQFKr1Mt6YWZrLuoU86cJ2N+UjUWffLCJMCsxcN15AQS0G86YAX5S26
         hZLilaVl2rLCy14ilWonNW9hVfqSAF63velLpcS6jfdJ3hWAYAOXXuCO73R5v6ltKfdD
         EclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077383; x=1722682183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jcXVWcmcbsKQzq4sH6RxYyKF6535bLDAYqbqnjhWxI=;
        b=CYy2JStaROk5pPXVJo32HmfNfo9Y9Woq2zfkAedgRqeKt9+icNiWNsbX8JBvhH0M53
         1w0GVJlHtRwVGqmTkJLmLkpCpZ/kpGiVmhqNhl8M1DDllKIJMKuF6ihX1r/lvEa8pq5H
         oAyUjHiAGCKAhBt+T3TTQCfYuA4t1R1sGVlia7jKa/4JXO8g6mcC0AH1ykj1i8oa1r5Y
         1Ri13MoJcBclY/iUzJJFhUo+PUUwQA5oEvTX83hVnzazW4tSm87sEWv9N7PF9WN/AwlD
         G4+uRLmb9jz8c69OZ37HTuRboArWVmvY5M9cC09aUgAphfgcmSv68L2pesyAa0qjwXM2
         iqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQIOcGkM87Mklkq7ihNBfx2Y5pAioT+F4C/NLju+eCBAH1bNs6cuW5BLwQms9+v5uTXEZAL5nGVDWhifpt0Jn95KCqHMubiydnlOjS
X-Gm-Message-State: AOJu0YxzAV0kCAbyQtYOROXX2AbYULBp+3LRmG8tdiG4WNtmnVh7piVF
	OUY5BZUUGSk4MTUkNU/eCHejnQioIePvmjHCUPthZ74Z4uc+8zRsiEDD3UQtnjE=
X-Google-Smtp-Source: AGHT+IHnIkK+HB2IdwYErth4W4SCHl2kIZXcIUCxD+QuK/EAVa9ImrPRHZ+ao6U85UaV4uncB6qJdg==
X-Received: by 2002:a2e:311:0:b0:2ee:df8f:652d with SMTP id 38308e7fff4ca-2f12f084567mr5772381fa.2.1722077383159;
        Sat, 27 Jul 2024 03:49:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d075489sm6626471fa.115.2024.07.27.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:49:42 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:49:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ASoC: codecs: wcd939x: Move max port number defines
 to enum
Message-ID: <h4f5c5ecsum3qdphmqvufmumqkrshrivn2qgkdgr243jgsoibn@zcngoula4vsy>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
 <20240725-asoc-wsa88xx-port-arrays-v1-7-80a03f440c72@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-7-80a03f440c72@linaro.org>

On Thu, Jul 25, 2024 at 01:23:49PM GMT, Krzysztof Kozlowski wrote:
> Instead of having separate define to indicate number of TX and RX
> Soundwire ports, move it to the enums defining actual port
> indices/values.  This makes it more obvious why such value was chosen as
> number of TX/RX ports.
> Note: the enums start from 1, thus number of ports equals to the last
> vaue in the enum.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/wcd939x.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

