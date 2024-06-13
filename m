Return-Path: <linux-kernel+bounces-213222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B849071CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948E4283A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C010143870;
	Thu, 13 Jun 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iU0cJ8RT"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9717FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282419; cv=none; b=dVYn3/32sHSpxQdM3WADZ0Ix5gSml7r6OYjlxEthEKUxg3HMa2MPlBtnd88b2LsZGBf6R0XFytiHWHIj3PE5F0I//YObYbeTIxX3vtEaegif60U4b9j90zR07grRVexGZt5WfzOIYULVzebD/cL2gxJf2oCjO9YjJOVWyYMQfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282419; c=relaxed/simple;
	bh=1huBxxS455lFb9lb95aj5aHQLKb1A7Gghj5h9+l71k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT8IiYRjr5Cc8VHV1wlj/Tz10Uf+CUjg6fy2oR5UiFrZSqC9mZnVsErNuwQSN3Zaj5yRMfC/lqQC+zVAMYSfN0TJ5HswjxgTMUQoVPs9/2XNbdaJQ3n3/qkbT39PW5Rgt451dn40zOZ59rmY969CNHs4KRdq8wqrrIN/6YuBGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iU0cJ8RT; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so9621471fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718282416; x=1718887216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ih0pRkamLgGn89/coTp+mG03B+Ar2meens0mN7r6I=;
        b=iU0cJ8RTqcuLkRvseOLP+yFg2Y2Echz6G6ReydWdEBxcCy7vjfmMT/mVDQtat1UsQE
         LdZpvU/wNPRoUU4K1NCMAzEE7Uk6mjgD4ZgaGyqgJW6C1dYUiR+faC54BbGorGh/PGPG
         P8uuMFoB1bqOVz/FPvJDKlOEiRgV1fb3tmJ/qKiFzBlUSaHEMqlX34p7TPWmxW0axOjp
         y8a2FUVfiqwPfUvS1sAtENR5qljWhIJ7eqpzPgVCQKOOn255/GcyUq+YfhkEX4mMB4dk
         fK6NK5id/VPH7sriRUf8gsZ3z5KV88mZ14GPBkortKrIkurzbvZG5kZ0o4oqLUD63Rsz
         zEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282416; x=1718887216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3ih0pRkamLgGn89/coTp+mG03B+Ar2meens0mN7r6I=;
        b=Kc72xgbQt5Qe2d+k/XBwH8Ff+ceav3JvxOf0IihhquXwis2wkJjTe7rDBhijZ2SY6X
         SQb2Yn6WmDB4KfbCyurR7BOyq8RsfQJ6T+OyVLe5lMaCYO2jnLZ5+EeVf7gp6zPoQv3w
         ZWZ2AUThH0rR6CD1a8cqMkZhnRTnpupgaykcW1gSlbScSAEYQZgs2RWgV/MayDxfUTHL
         3iSi4OlLbMzAPX+zg+dbCL+xFKQWbmYHXrGMe1M3Mpt0UHueFEyd5sB/QWvvW+hfKz5I
         f2oQh+bTh9sc5Xok1hYgAeQ5U9jNC+0KWzHn4vtbR0FIla5F/jV4FiNvQdd14h0WdNHq
         22tA==
X-Forwarded-Encrypted: i=1; AJvYcCXRHnFYyRGlTYlp0SVu1gw9NMZxSIIxpvplkrxDsKwBg/E7NEWcoeKETHh9WB/HvD4u4GxUVQS9ZDL7dlqK5FHKUZL7S6JOE3DEZBVe
X-Gm-Message-State: AOJu0YxHqzoKBlN2rB3PoRIBzCkmFiDAKAY5T96KLmOgQxF7lTUDxm+f
	s0Q9KNdAfaP7tMR7gTH1TW3LuI/aeUFCsirmkEdeUoT9g3Jy9k04hhpKCbZnhNk=
X-Google-Smtp-Source: AGHT+IEqq49c8cGicA+OdVdYsOlsGoIcr/1WK+4fWR/h8LRWQ3o9Z/xoaT075/lNiMhPVaQRL6RyNA==
X-Received: by 2002:a05:651c:1258:b0:2eb:dd0b:b9ec with SMTP id 38308e7fff4ca-2ebfc932783mr26945561fa.20.1718282415951;
        Thu, 13 Jun 2024 05:40:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c05d3csm2060981fa.43.2024.06.13.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:40:15 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:40:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	krzk+dt@kernel.org
Subject: Re: [PATCH v3 0/4] ASoC: qcom: display port changes
Message-ID: <3q77jowqtvnlsrskzbmt627mgoebnkld2tswjaby6tfluadszn@v7vcgkgagyiy>
References: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>

On Thu, Jun 06, 2024 at 11:49:18AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patchset adds support for.
> 	1. parse Display Port module tokens from ASoC topology
> 	2. add support to DP/HDMI Jack events.
> 	3. fixes a typo in function name in sm8250
> 
> Verified these patches on X13s along with changes to tplg in 
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> 
> x1e80100 is verified by Krzysztof with his changes in tplg 
> 
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/merge_requests/7/commits

Together with [1] and corresponding DT changes:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # X13s

Note, patch [1] is required to get the switching between Speakers and DP
work in a stable way, so I'd consider for it to be a dependency for this
series.

[1] https://lore.kernel.org/linux-sound/20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org/

> 
> Thanks,
> Srini
> 
> Changes since v2:
>  - remove hdmi references.
>  - added more DP jacks
>  - added some comments in code
>  - added x1e80100 patch to this series
> 
> Krzysztof Kozlowski (1):
>   ASoC: qcom: x1e80100: Add USB DisplayPort plug support
> 
> Srinivas Kandagatla (3):
>   ASoC: qcom: q6dsp: parse Display port tokens
>   ASoC: qcom: common: add Display port Jack function
>   ASoC: qcom: sc8280xp: add Display port Jack
> 
>  sound/soc/qcom/common.c         | 35 +++++++++++++++++++++++++++++++++
>  sound/soc/qcom/common.h         |  3 +++
>  sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++
>  sound/soc/qcom/sc8280xp.c       | 15 ++++++++++++++
>  sound/soc/qcom/x1e80100.c       | 20 +++++++++++++++++++
>  5 files changed, 99 insertions(+)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

