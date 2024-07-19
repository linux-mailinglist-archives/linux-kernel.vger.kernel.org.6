Return-Path: <linux-kernel+bounces-257235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE91937722
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1941F213E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4486250;
	Fri, 19 Jul 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aX9w0ErI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C285626
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388571; cv=none; b=Q2tKPSNXcLXtU7dbc65ebaBogreL8UmKNJtCD8KzmfREIB9yweSp4t+3UEQ2nuAD6MFfqaaNJ6M9/I4HjHob1vhubx+jq8G5D/pte2zARiY+kT9pgvGa9dn/8O/1mMOKUAA+T5D9iBRymLy3W3jnvlVSk2vgePwWHX14khEKPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388571; c=relaxed/simple;
	bh=d885wO6ZZiqVGlX5skkPomIniLdQSV0WS6LUE03sajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD7k9Mn/Y03TuIRLUaq2igbcw4djqOornIQz3LMUjSePZjWJSU1QZpY+UXR3N1Xmu5IElHJnuNyJhYx19eQwNkDSf9GKzB7S1c0Se6+zLtw1RfE5QWCnKHayr+fv13SmoIP4dPEHEckxcRZ7W2ROSHn0Odq4tL++z4Ekc2HpKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aX9w0ErI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso24052251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721388567; x=1721993367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUe1KmR1homs38GJN3VUTc88rskqy350KhsEGjDSIQs=;
        b=aX9w0ErIB0J0POqQ0dlmNLBIhlXQRI0+IXGUcl1C4q529gPTkCYk+FVGnCZUW5b+3V
         9OOBANcQtwwzhyUT2rx7XcxzGsqCiH586Ayokdf8V1bohYxprIpz7lm/umI18CFFeRNr
         STVp+/+F9FvH3lFmK/a8hxzIB3mAVo7FCb6rCA/QLWvPfRL0pCgrcUKHDgr32k7PUgm4
         ev2VpzUopD4uMUD9V8Uas4HfUnB6iH2IdW7LdeKdxRSyPIJovuEuba0UXGyspwStry7h
         YNXHjZ5dohRRco5R1g1ttVXS+0ss9HoNmd5qTpuc/0eW+beZcrOuw7kvhbwY2hmahujR
         T2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721388567; x=1721993367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUe1KmR1homs38GJN3VUTc88rskqy350KhsEGjDSIQs=;
        b=J5kUReU1TFd6sigvm2Yt4Z9Ge28QIeoA81MJ198JOwF2+sbXK8Ii7U71A69OYhgYLx
         qkJSsxcSNcubdgotQLSadv/9VT0BhncJad1MiS3EJwb9L55XNJ32WsSiKwzGKpRj1/sr
         SfnIZ+JRP6JA9i+cB/nCxWur13Emu5qjAr0Tem4DgMNY4I1CKixdPOmSmbDVgnCLh3ps
         zzTZ2wdTAE1LPHN5LJLc6BU7byr8W50yy1xEs/QiYUziXMGMP90R4jlvQf6dwyuGrvO3
         Pi9ti3p/ZqBDVo6u8wUkA+F/6WoE7vtIVNJ9+qObMgejvEPJOy+Kjm4HBpXT9EElsrnL
         jQcw==
X-Forwarded-Encrypted: i=1; AJvYcCWxvg07Pr7x53hjczj8fHR11Yv/iQAZx4fL2q61Gsv+/fkmlFoQ9LzRvfGkASstx1L3dSz1yLN1pjp3TEDdk3jU2r0bmY9owGCKmOJ+
X-Gm-Message-State: AOJu0YzkAOjvDkefECC5nY1QAX3sDe3lakPNSEWpcJ+QuIPi587gHVP+
	fEre+o3YI5iCfP6tBnZMpBJHITDQ71iDDRAlINJJuDavbkKI6s4Chf8aGphNsdo=
X-Google-Smtp-Source: AGHT+IGrP39+ZynNEPP6XIz3gZODEK4Pgdp9fJGvd1Id55KuEB5cig6ZzbIGYRSM4zawNwPDyyjpjw==
X-Received: by 2002:a05:6512:33ce:b0:52e:9428:c6dd with SMTP id 2adb3069b0e04-52ee543e86cmr6100144e87.59.1721388567414;
        Fri, 19 Jul 2024 04:29:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556acd6sm166955e87.148.2024.07.19.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:29:26 -0700 (PDT)
Date: Fri, 19 Jul 2024 14:29:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Chris Lew <quic_clew@quicinc.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pd-mapper: mark qcom_pdm_domains as
 __maybe_unused
Message-ID: <4bhowo76xl3ktpjwpclbvruv2bsbfrs643kdjn6sfivxt2dgx2@yqyojdlk3egu>
References: <20240719101238.199850-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719101238.199850-1-arnd@kernel.org>

On Fri, Jul 19, 2024 at 12:12:31PM GMT, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The qcom_pdm_domains[] array is used only when passing it into of_match_node()
> but is not also referenced by MODULE_DEVICE_TABLE() or the platform driver
> as a table. When CONFIG_OF is disabled, this causes a harmless build warning:
> 
> drivers/soc/qcom/qcom_pd_mapper.c:520:34: error: 'qcom_pdm_domains' defined but not used [-Werror=unused-const-variable=]
> 
> Avoid this by marking the variable as __maybe_unused. This also makes it
> clear that anything referenced by it will be dropped by the compiler when
> it is unused.
> 
> Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

