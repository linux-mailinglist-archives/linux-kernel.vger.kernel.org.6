Return-Path: <linux-kernel+bounces-223447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2F91132A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D22228133F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234381BB695;
	Thu, 20 Jun 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijHXEocE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85D1BB68C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718915314; cv=none; b=mF/vQzAlVkN0qtpgMQNQkHTMA1VCe/eIE1JixCoiHndtowO1PsnqgMn9miw6L3nL92AX88gC8AcT7R7cMrR3pbF68kLAjzKlsgPAPncJLIosi12c+lEY2nGnACx5nY9pNcSbk00QEeUwejJV090IaapsH/XxcMInIG5XvUuIi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718915314; c=relaxed/simple;
	bh=UkmDyFQy591dYaa7VHDPHpXjKce1/rqccMMiHX2MPEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL343T7PubLL9y99cscPjFBQ5kjTqzzB8PZfMKVH23N0cWF7+P+oRp2RoINvUFKomdHC4S+3i3aNVcDUL+VvSDPwgciQ0KMrNyEtaSnhjIFEbzfYB4xprjHYJq1BTSt4d48niJiunr2XuzSjFR23HsSqcE1hL6HVH/vDEgjOWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijHXEocE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso1437479e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718915310; x=1719520110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Qq7ONicKjWObOBmDaLHMa6+38qMtcLZP9rDKDaS5bI=;
        b=ijHXEocEDueD+99MDKnD7Es5/8KoYQ3ld9dm0qcDFRjxmtWY5XSWqOwKfDhzebYRMS
         gVmn8DMUzcjk7D+hlShDkK/B+CVp/oQdNgbJZyi6B96Hbc4t/MEDsdlVk3ezk0JWJsrs
         dvKXbFFtV3RYhFmwRmQRFphYOFPfBnyA0IOUkJAUiMnLdwM8aVJUyReAH2BabkwhH0pd
         UUIFh3IsyQmvHIpncpzrJkxrJJ6E+5KlUELXtwwLgLBixulrA2318obARBe4R0xT4teB
         qgyY0NtA2Pt8vH6q8VTVpHrAJ4QNzFOKxDdAzLC/wb5IdSF8AxRoEdfJZOMBN2icNi9v
         Mp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718915310; x=1719520110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qq7ONicKjWObOBmDaLHMa6+38qMtcLZP9rDKDaS5bI=;
        b=R66w3x0FtH8nFOYIZ4sSMZ+xLyU0umM3RFw5+ozm2AB6sF1+GnvwmElNK5ckvqaAtp
         kIGET7hccF5wAg2UycLBcLIcvSL75h6xyG0NELqrd7wygYv3nheQc203FvqNx0lH9+s3
         Rl+ruoJbwLK0AZAQWJsK00Xm6P/84cpNsQeqjyuLuSEtPdTeZTJeodMSxPua2ullBz5a
         4SYnjJNuIS7dtaj7D2lISZluhK1BOY1HHmemZaU80aMv7WZXY7COKnAjbvW8xtlIzwgz
         gn0ELOhWEU/PreVq8thPOST1wvQGM8QdMSKRLCoorJEqfQ1GQD7ps4AjPhhE9sxgSm/J
         H+jA==
X-Forwarded-Encrypted: i=1; AJvYcCUedYmXCe39txw2UffHPEjS1PEH3i7QvT6c5qVOdQt3iXr+gxwgScDjnDFVQRgOUuxG0AGk2CqBsjK/kG1l2A+TdtKFyD00d2QH+PBG
X-Gm-Message-State: AOJu0YxRVri/H7Jo7CMEPOqhxMylEjFpOi7aE6SiHMU3CQdhWy3uS7V/
	7iJCAQ92CTEvv0twDFbwRaARcEkqET1reqNZA7bOFCboyNMWdqYTUx3llM2POuE=
X-Google-Smtp-Source: AGHT+IH//vghqAcxQJwYgnR3Ce2y3NWrMIiABGLcHezgJ21sFgCt2msKsgQEX+zkT9WfeQcTRVsKdw==
X-Received: by 2002:a05:6512:3f0d:b0:52b:8365:3630 with SMTP id 2adb3069b0e04-52ccaa885a1mr4638439e87.51.1718915310420;
        Thu, 20 Jun 2024 13:28:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca88a96bdsm1867368e87.306.2024.06.20.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:28:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:28:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manikantan R <quic_manrav@quicinc.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of
 enabling vi channels
Message-ID: <hz5eqta4ttzsnwttqzqrec4vcwvyleoow7thoiym3g3wjsfqk4@tx23nktde3gh>
References: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
 <20240619-lpass-wsa-vi-v2-2-7aff3f97a490@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-lpass-wsa-vi-v2-2-7aff3f97a490@linaro.org>

On Wed, Jun 19, 2024 at 02:42:01PM GMT, Srinivas Kandagatla wrote:
> Existing code only configures one of WSA_MACRO_TX0 or WSA_MACRO_TX1
> paths eventhough we enable both of them. Fix this bug by adding proper
> checks and rearranging some of the common code to able to allow setting
> both TX0 and TX1 paths

Same question. What is the observed issue? Corrupted audio? Cracking?
Under/overruns?

> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Co-developed-by: Manikantan R <quic_manrav@quicinc.com>
> Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 112 ++++++++++++++++++++++---------------
>  1 file changed, 68 insertions(+), 44 deletions(-)
> 

-- 
With best wishes
Dmitry

