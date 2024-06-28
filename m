Return-Path: <linux-kernel+bounces-233605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4191BA1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4C11C20F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398A14A4FC;
	Fri, 28 Jun 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfQ0KTPi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B114EC4D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563748; cv=none; b=a6LVbRkl8xf61tc1bE61lOCAyOONa8sqpsqqx0e7zikQUqFK3UvU156aCBX9mP+GFVzWyslsMC2YzKYe4b22j1ck6V0eEb8emad14okRGRD4Og4ZDRTaME3KDjfzUx/1k0elSk/NM9PdV+7RT546aZhw3UnjPeBmLKxeq5CxkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563748; c=relaxed/simple;
	bh=Aeqbd8mZF5g0gMvxy8MT2FkZAI51t9W3BeDBDhRYKN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSh9WXEbVkELNuo3c96tjGuMGD4bd9jjUoXXv1U1I8RzoRjKm+uZZn8WBH8umLGOEh3XFyyljfD91W0X46oGNYMU+u8uM+QeFyw0XnYHAkB0nKsV8+YhuUHeqkppMt9U+GVH45oMt1griVS51KtX9AUD/67FbEPEBfHC3BVyI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfQ0KTPi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cecba8d11so388064e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563744; x=1720168544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kW8kDPyCelVzk0XP+f0C1TOEkGrqmmm6HbfYVtTsZyA=;
        b=NfQ0KTPifBwF4t6W3AUoHCV4ne4NxDOjpqwKEXJrzzthgBwpel/q7rg3ht7cKRQ0aX
         lFcrmMGgEVm/IhB5HkUjaV+GOaSiEWlV/xOlmXfxiYnZmzoxxx7RjmWPqBGR5EMStl/J
         ufwfLmLKWy8cizY/i32gp7BPb1LkD2WOebAak713r5VUhVPkhbaYvGJocwyXamtqoTJK
         OTg4GWyx0bLzpD074D3LbZU9dmp+Nt0Sm4HRn0nyt/ar+FqrG4EtOUySeyObI9IvIn7F
         0CJJd9bsj045ZeTuyLnaeHxVq6grrnyYIlWEVB8Dwt+mX3rlQ/Qr8VRaE5q/04lsgVI+
         eMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563744; x=1720168544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW8kDPyCelVzk0XP+f0C1TOEkGrqmmm6HbfYVtTsZyA=;
        b=Lbkk3/FFuYGU0kfUt3EGxr1pJLSXkeek8SmE+sMAH9s1+f4Qd12mA+w1WK7YDAvSxz
         d6v4T4s8ZzlQgpgVvI2oyx6TIVnbQNVkNUwGhoegdgtW6XsekSKfKdIDoctVGTzLF2p0
         Tw988JH/2917xJhndQWb6fxDm75eEusaqTx0OYNNpzkMxbuD0hEnCNc8Is7OlOFQfOII
         iYFaNNWyT3dQNt+KyzW2iT57Nf7UIWl2tPGfGbBVA0KCYtPq5GsEAnUSnG81FGgYTEab
         YQsK26VaKoHTnYEtdHbPsCtV29HoEa1G2of7g1yKCiTxS0gNjY/hnlIPHGB5bjHn6B3N
         kung==
X-Forwarded-Encrypted: i=1; AJvYcCUvCZP/aOcWmeiR/cWW5RbiCcOIJChN7+nRMW/i/lYtPZZgP1RHYaFeQuFuAITMSfnASppWkBCp2k9XCNKDN7SKEfdzHuWdB9JWPY+e
X-Gm-Message-State: AOJu0YwhOkHai0RtmKgsgp/LmX0LfXPm4nhDfByq5c5WsTTkzPg+2NDy
	eVYTk1r1yDFny38vEHKRhp6Uez6vnG4a9hTOPQ1sHRLUwRdv5YEZOP10IABRTOA=
X-Google-Smtp-Source: AGHT+IHTiAZIPdDFBY86RLx+OqmRRF+qtx5Trn2TYV6LbMTMP6YvfamTxpc4oxDTByLWmHsNlvA5Vw==
X-Received: by 2002:a05:6512:281:b0:52c:e10b:cb36 with SMTP id 2adb3069b0e04-52ce183add6mr9396478e87.33.1719563744009;
        Fri, 28 Jun 2024 01:35:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b37asm209380e87.275.2024.06.28.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:35:43 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:35:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: codecs: lpass-rx-macro: Use unsigned for
 number of widgets
Message-ID: <ojokmx4l5eaeclemszd4esgyfcov4gcqteegh3vqpbk7cdfmgn@yayrzbbaire5>
References: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-4-ede31891d238@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-4-ede31891d238@linaro.org>

On Thu, Jun 27, 2024 at 05:23:46PM GMT, Krzysztof Kozlowski wrote:
> Driver uses ARRAY_SIZE() to get number of widgets later passed to
> snd_soc_dapm_new_controls(), which is an 'unsigned int'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-rx-macro.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

