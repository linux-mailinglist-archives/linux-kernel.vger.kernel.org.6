Return-Path: <linux-kernel+bounces-230042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39459177A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82B9B21FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE913E02B;
	Wed, 26 Jun 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgZalXMG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CF13A88A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377546; cv=none; b=reeTXa0fZK8bIxpCvzML1zf9l/GL3FIadzj1UoafXw6p4ivL6OjkHBBg6WvasfAqutfN2ku2YCh8Q4JYgUjyMDw1lP9a8G+emaJSNubC5IyVoXFBmbgtOSoDG8rUAYTm66q95BxSPbbJ2/pfFbe1nZBgHIXitIv1ano20xBsvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377546; c=relaxed/simple;
	bh=UH7Guk0ZViEtNHLe2Rm6vPoD2ZtesweQWurg2zPQG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3hgJVd6kO8BQSIvA07ypu4EQacUmoW7tSJPWR18dccdrbqLUasNlWDUKMmyUuMPAeQmzmohhwxd85FgLLixe9gRuLnbu9C/56kpDCexMxsk0sdEDpbxGKpwwyJ7tBco6OkeoTm19/bVTx25x+Njkx4qrVHx1JZLFhyt7Hu4sKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BgZalXMG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so6868493e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719377543; x=1719982343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHtEVEj8JBWiO4kzFiIiv1rmTa0ntU60eMALIMv5KOs=;
        b=BgZalXMGqmsF1ttSDo91MGRGTVeRXbdmHms+95r7kn8GCK7E0/uVLqhvvTNcdv03z4
         1c54dx4oUmsOf/CHofFgHJkQGjtEcij8dMNWHyQb9TYE11y9WClbH5XnjjLl3nmt7T/P
         CsfYxJ+yvQCAq8JUeanEP8fXmMOQGuXOAo+Mviivd5X1eRQ1w5m8e5/tXTBWw2E08Uzy
         wRDGa1K/aLQzkT6PK0nvEli/2YwM98zdQq6dQTaYrnzHoiiD0mknsndoUtWN0afnx00c
         fCoG1r8CXWIGtOtyZAVYo4YFUvP0qQVq26hmfO45BOOo3HOLH5pGPVxdDeJX1PALY2Ef
         0Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719377543; x=1719982343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHtEVEj8JBWiO4kzFiIiv1rmTa0ntU60eMALIMv5KOs=;
        b=WrDC5DOVHQkuyxcI8zjwzsJTQfvvDpXDtGHDLFFxPvca/xMLnD2xMSYotDL0fGeK5p
         HLDNaaYZ0kB4K0NaeLarbjkcVZU0qPfp+s+rRE2cI+wmrJPxRVJQIg4PWQtGu0pOkIAx
         +gHejKTKTXLb+WqH/+pGEGKgk9tIMa6YLbv1I1D+TXKt0cVXfSnLGtMLfMD6iEenDQWW
         XJ4vTiukHG17L2vIa/lfL6EImbJBXIdFxXzGHUDRxleIyX6Dmb+4KL8qsj0PCXwwCb6A
         0RwSOF8w0NCtpLGAMBu/x/KwYn46gqwTyMU7WDrMo6RuStOlQyS4+OgurMw5p1LMk81h
         hKxw==
X-Forwarded-Encrypted: i=1; AJvYcCVFIXW5hvY8+VCwKeol593IqLbuuZ/rPeQvTRTdaFUGXTHVW5VpYLA7jCUAhE/FHuelV/nrjFd2kgNGyoDaVbDdPjJUyBXakoFcetdR
X-Gm-Message-State: AOJu0YyM8Z2WQWq6Xs5Mz8FFqD/SiOLxZJwIaTlDkC2X3yVYH/01p+kX
	rBKR2baSkJcDRWX0O800b/nQRZPjSKFb8oukUDMO03QxDsCW5Oj3HZBrv3NLGxM=
X-Google-Smtp-Source: AGHT+IG2adZQtvwyPskuS7BzV1Hv7koYS1cTyuzBuEl/nHq624PyB5bLw8U2WyHXv+Od7Ngz+ahDJg==
X-Received: by 2002:ac2:5e79:0:b0:52c:8909:bd35 with SMTP id 2adb3069b0e04-52ce182bc95mr6906334e87.10.1719377543219;
        Tue, 25 Jun 2024 21:52:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cf3361cc7sm324288e87.65.2024.06.25.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 21:52:22 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:52:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: codecs: lpass-macro: Use enum for handling
 codec version
Message-ID: <fyuovswhhso2ishvullvj473xnstqcpc2czqiqy5lfaafy2cix@kfifmubk7gy3>
References: <20240625165736.722106-1-krzysztof.kozlowski@linaro.org>
 <20240625165736.722106-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625165736.722106-2-krzysztof.kozlowski@linaro.org>

On Tue, Jun 25, 2024 at 06:57:36PM GMT, Krzysztof Kozlowski wrote:
> Replace 'int' with proper 'enum lpass_codec_version' in every place
> which handles the parsed codec version (not raw register values!) to be
> explicit about contents of the variable.  This makes code easier to read
> and compilers could check missing switch cases.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-macro-common.c | 8 ++++----
>  sound/soc/codecs/lpass-macro-common.h | 4 ++--
>  sound/soc/codecs/lpass-rx-macro.c     | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

