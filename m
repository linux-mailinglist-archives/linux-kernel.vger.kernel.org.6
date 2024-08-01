Return-Path: <linux-kernel+bounces-270865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64207944669
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0A7285213
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABD13D891;
	Thu,  1 Aug 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnyxjlFg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5516CD09
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500466; cv=none; b=mSnRAb4bkMKaOnhRAecnqmbJb9T2RNB6rbKaoIGAe9PCO8vWaigQnAXv5ydrGl82a7l/xfWN+nDkhgecv/qym2gI9wF14+JPRyWWwadzqA6LRwXTN+zHoZS9fjbbUVkPX6k5SJrZT39rjNv5FloGJTc4XhMQ0a6zKYVqnWGXkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500466; c=relaxed/simple;
	bh=Z/R/jE3UetsT6jIzeeUL2oO4nHocrgIt0QNSJ9yXa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+x6jUcQJuZexe0Gdf/K3mO6VtB7HNo0uoHBvD0eGlELxN93tKdbMraV7z1CcnMxeG1oYhknVSxN9WWv6ewvbp40DKV8SRe0WgH55ntajoNfxwYqRC7xHj1gs0/sFkr9E83zAhIyoyyqYAwnV07MEmhlmV1tfbXtVsC6wJMTduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnyxjlFg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso84228611fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722500463; x=1723105263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwtmoHKhwxmQ7ba/RVWyEJFACGd+bpfz3WwZuXqhvo4=;
        b=XnyxjlFgbVZt4olAK7yBuLYLCB/svNm+FWPUA5ZjttlNHgYRSFa8gEWMben7m07nR1
         XXWa66aWyFgKaAOgYZXQx38nrFdp7JH0uo4Xn6qsI290MzjU+nW+iNiDMpZVHbPBPIFA
         /aCK4OMg9zALOgf/pGI7RFSUZwjWe9kfPNYdsgZz0MQhFcy+kMhkznvbasMzEn7IXjYJ
         c+d7mZ4dHub7c+uDK+/Y5fT1WOYhi33Vb2wE7lmKziaOL9F45XAKovcwEb+GVw9w2stl
         xWvhTqI8kx2OgNrb6BhUkCCDmgBOifg87ylnZL7pgedJRzvv/jwGGcCuR6xyfrRLd0BN
         1Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500463; x=1723105263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwtmoHKhwxmQ7ba/RVWyEJFACGd+bpfz3WwZuXqhvo4=;
        b=ntrkxXVXbGslBKrc/ctB9pwGju3oqdBy8bfgiqpStopoWRGmwG3TG4COGxyIeBMo9Q
         suQPKEel45jBaN41Nwz5y10stShg+Wy3vg3tbfpzN0frCXYzYc7QCr1vZw4V0C/GTmWK
         oUWMFCRDbZOyT4TVMTfV5on790D74ZZNpM2r+nj9NTQRgjPJW/fS4giAxbGhsfQVzwtK
         pSDK/IMwXUUAoBunKazVgq/W4X0+xRifVzNMNz3N7LaT5B8TVU/B38Er3RxN+ogY4NhX
         yElz2NU2V3Ik6EM+iNsj8f+5AFln9J6YSsIsdkwVCX/dJgNatD7cRonGflGyKlrA3HDW
         POUA==
X-Forwarded-Encrypted: i=1; AJvYcCVF8Xp4tWxcfGDpH6l6W+C8yPGYmLA71cEsaakuRInbpw73RTUIe7VDXVzHcOG9v/tKnFe2amASWf2S36c4czlwd89fBnYj0mhYOuUO
X-Gm-Message-State: AOJu0Yw6MnstLDubHEQm99wvRvZ5CX0w5anS9+iqQI+4HI5v+gEvKCe4
	JOv5vYVslIN9SJq2hriMrwNHHlXS2Zm1Nm3W2jq8Haylhzw9JZlw+EljpXJhYYQ=
X-Google-Smtp-Source: AGHT+IH2rrp/DcZo+alL+PQQLhSzxuBc4O3JwWhJX/xYrbDZk4ReJ8Td8cb1JnBDOgBdEencF/BngA==
X-Received: by 2002:a2e:9b1a:0:b0:2ee:8d19:85af with SMTP id 38308e7fff4ca-2f1532d3daemr12584361fa.36.1722500461234;
        Thu, 01 Aug 2024 01:21:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d074b19sm22171011fa.110.2024.08.01.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:21:00 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:20:59 +0300
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
Subject: Re: [PATCH v3 1/8] ASoC: qcom: apq8016_sbc.c: Add Quinary support
Message-ID: <fm6wqsznxxxlofht2nouqtaryl7delloatc2v3b737unt7hqd4@l46iayvs64ru>
References: <20240731-msm8953-msm8976-asoc-v3-0-163f23c3a28d@gmail.com>
 <20240731-msm8953-msm8976-asoc-v3-1-163f23c3a28d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-msm8953-msm8976-asoc-v3-1-163f23c3a28d@gmail.com>

On Wed, Jul 31, 2024 at 05:25:25PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add support for configuring Quinary Mi2S interface
> it will be used on MSM8953 and MSM8976 platform.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: Split from MSM8953 support patch,add msg]
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

