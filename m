Return-Path: <linux-kernel+bounces-370679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802869A30A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39258283412
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71EB1D7E30;
	Thu, 17 Oct 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEk70zN1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8C1D5CD1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203889; cv=none; b=uDUeaJRykM2tYyugH/vKtHxeIXmM3PWu4fZ2qIVJ7dChv4Dn5FsDVaJ7l7eptL+miaEZ8st3pIUR3vR3oDdNt3oh7mE50UFvl5lnyt9z+Bajvc+l0XQrAE/LbIGXz7y5pE9f8tu/TlIHJfPqy50peNTiojDMgvIRdzrTEXwCjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203889; c=relaxed/simple;
	bh=hJcKXZZqP1q18W3w7Qs8TRcql16FNs7FzZ3BFU+kkYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJEAi+xIeR/hKLbKTrXN4bi27gVpsKM+1PnFj+B/O0bO8mQxYuJXHUYCuTMkDSxn/XQPkcBFmYCoT8JAL2nwOvpwyX1QbkDZwb7GuIDsIAzfFPh/Tvqlsgv9dylONDYFOKcrnvppd5OMhOkVspM1HS/rJAnrd/fTFmATzgqL5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEk70zN1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1799829e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729203884; x=1729808684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VocsO7a9C7Q0Qui7xbnKUaUO0s/uFElHeUCAM0fdE+E=;
        b=NEk70zN1wvuWqpNDnzS6XQ651DatKCqOHdJH5LZjIQmvjND9pnLpEBB74kWD8Ma/1w
         jeBZfBtwukGOSale24yyRbofHKfRmxDu9PiWzjE2jBdAQYEteGl+ZX5L5bzj4E0bzQpG
         J8twK02jOsd94RWjCDKijVA39AthvsGl9eUTfDs/3UQeqR7ZRfoXAd5bqJxh5v3lCfqo
         vZNdjqfEb8CLtoasAgs8wYv2nMPCu95lgfJQqRNTHuspkx/6PmzSww/MRv8wXuoHS3h/
         lgBe6MQDWUjABWwi2mN12YmS7T7hAF9RE1wWmppq+scq76nkeCkaruhd27uFIf7aOVMa
         QTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729203884; x=1729808684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VocsO7a9C7Q0Qui7xbnKUaUO0s/uFElHeUCAM0fdE+E=;
        b=Wo2m7dchJF/G8QcRfHxuNYzcz0xWk+aHhCpFbddFnloSZjDN0Fa1rQ3wEA9f9zht8z
         a00KBKftvGCM79K8f08Eo0I1Bn3pr3YSxUdogxpthFwduB73B7fiH9t00U5jAKTajiYp
         1SBccZKN8Ll8MJ71FFOtQaHvNfCol3anmOtulWm0I7yQPnGso1bNj+M+z1zP7JlLkVw0
         k79t7bMsAQHa0SMty9gxMpDvPOEVuPyD1PwfCN9zUQoeMms6G3N5d657QEAqbPmeAtxY
         Qe8F/VUkPaDkQ/dv9UIKN+IkFf8mdTvCs8bdPUVA30dG/bxHku1yCk3UdPVOg60ppvS1
         soiw==
X-Forwarded-Encrypted: i=1; AJvYcCWQucoAUgGdhMcVsY+amGOltTOHX/C/OGXjOqr9uy0WlldS9N6jqQiGwZJZAjRirmifXYvk2eyrspsXWSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjA0NvWNcSpsr6zJDpW/Psy1HioIJkUW1hhNo91OpuQV1TyK6
	pIUehkLJ+nLIgWqHtYdN4vAHu5B67i3v0jTfJ9RVk85d4OTtmUi/YqVL6+fNS2s=
X-Google-Smtp-Source: AGHT+IEa6anJV3E0K7CppiPuZYQbyLcF3shfaKC5Kb78/SiQ3aJxOxbLaEaE05j/Agx5EYEUizZnhg==
X-Received: by 2002:a05:6512:b06:b0:539:e1ea:c298 with SMTP id 2adb3069b0e04-53a15218cdbmr264581e87.22.1729203883984;
        Thu, 17 Oct 2024 15:24:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211bbcsm44012e87.284.2024.10.17.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 15:24:43 -0700 (PDT)
Date: Fri, 18 Oct 2024 01:24:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: srinivas.kandagatla@linaro.org, a39.skl@gmail.com, 
	linux-sound@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, 
	tiwai@suse.com, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v2] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for
 DSM_CTL and SEC7 regs
Message-ID: <nhpeyezvodnww4m4hou3of5xy7lbvme5jydpprpmj3yzr7yarj@thiyvzume4bo>
References: <20241016221049.1145101-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016221049.1145101-1-alexey.klimov@linaro.org>

On Wed, Oct 16, 2024 at 11:10:49PM +0100, Alexey Klimov wrote:
> Turns out some registers of pre-2.5 version of rxmacro codecs are not
> located at the expected offsets but 0xc further away in memory. So far
> the detected registers are CDC_RX_RX2_RX_PATH_SEC7 and
> CDC_RX_RX2_RX_PATH_DSM_CTL.
> 
> CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n) macro incorrectly generates the address
> 0x540 for RX2 but it should be 0x54C and it also overwrites
> CDC_RX_RX2_RX_PATH_SEC7 which is located at 0x540.
> The same goes for CDC_RX_RXn_RX_PATH_SEC7(rx, n).
> 
> Fix this by introducing additional rxn_reg_stride2 offset. For 2.5 version
> and above this offset will be equal to 0.
> With such change the corresponding RXn() macros will generate the same
> values for 2.5 codec version for all RX paths and the same old values
> for pre-2.5 version for RX0 and RX1. However for the latter case with
> RX2 path it will also add rxn_reg_stride2 on top.
> 
> While at this, also remove specific if-check for INTERP_AUX from
> rx_macro_digital_mute() and rx_macro_enable_interp_clk(). These if-check
> was used to handle such special offset for AUX interpolator but since
> CDC_RX_RXn_RX_PATH_SEC7(rx, n) and CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n)
> macros will generate the correst addresses of dsm register, they are no
> longer needed.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

