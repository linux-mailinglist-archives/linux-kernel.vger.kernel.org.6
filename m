Return-Path: <linux-kernel+bounces-372838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E89A4E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8EB228C5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D129D0C;
	Sat, 19 Oct 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVd0TSCV"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481620DF4
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729343661; cv=none; b=X0SrzS0QJYwlJIr2wwDMEcYsj4K/niim3vfqbwvh7MzQsHYlrO7QFvop3maHkrLsCNf7VrB217EpMpJXttEqk7Sng5/Gpnavsk+Ibx67PVZ9KRLw6w+zG5sBnV/En1xpZ7TLqMnY8dNJiwJlIMol7R/+OFHR/UJmu07l9YdEQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729343661; c=relaxed/simple;
	bh=nFttUmTwQuRiqVsH4U6ZQZ/PMt4PrXLz7NgQU/oEK8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1WxyqLt6Zcg72bPk2ddWcVJmioJDVRweON53oaT9Ak4XL0ptdWhToVSs7b9atg/t4sUGin71em6dsBMFBCjsdXGdF3umJi8NwUtbwql0M71Weoy3bsgnI2k9rZSWpXGTieN3hfOuuJKcStmGsvE4qSDIbtBJmX0a6gmar1fpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVd0TSCV; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb599aac99so31268501fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729343657; x=1729948457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsxiJAaLUxZ8WyINPgvN9VPitcA+1/D6dK458s/cN50=;
        b=iVd0TSCVd29MGdEkzPPi3/Q7NxQWVYxAnYSCP16F3d+41BjMVfosxmaPo3YZp7EiHb
         72Z5mgnMa6FXmFmbVsaGoGSMNRILGLbbCgUZZHRyJj61tsxSQw+1xmQcNYgJ1JIqPZ9d
         zkFVRcnYbSHQR0+amdxn40BYJcvhT2RUOkJm/AIxb1YpjV5axeV5enuN/pEDEwbIINk3
         1KOx6Nwp5PB5Lc7uOdxpROAfRrHGGaKwlzq2WWbfq+fy69HFu9iLFYSfoPXgVQuKzcAE
         hnGnYRPVKNCzOkkTi6uVOFz2iFOV7ENkqZbppXxu8oD/lZ2aSpTFQY+JoRrsOcC4+kzV
         5PYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729343657; x=1729948457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsxiJAaLUxZ8WyINPgvN9VPitcA+1/D6dK458s/cN50=;
        b=eV/REb+3r8zWdkp8vgyqqbyNDKtGXS8HGPK2Jw5i8zHUs2wjSKu3aMGEIJYKlcMIIH
         8fLE/B/liDrIJQ/B6Oy5QFlbKSAn84KONFYHAC96eBgOdkBDpFS/l/RkATiCxQ0zmMn9
         iCFPJTXRhzVZ9H2Z/C2DbJAQ0S9mNqFHU4yVFK4SoS59N9+ET0X/N7Z6ZsY9dHUFpWaO
         SUyBVGG+mVAZfH1EmnzjHc3TKL/xz/hSU8zQkFx79Nmyy/5LX00lxWddU/tN5IIO6nUk
         F8JqP0FqXxAV2jLKAbMsHa80tZOKR/ofumM4/BhU1V3vb7h4drDAvT9j36BO6NRY7Ek6
         msNg==
X-Forwarded-Encrypted: i=1; AJvYcCU4QW3mhg5H5QgxQzNL9Ae+HJL5t/eLbaVaxopfY6Gt7NmhGMaCEjoaMnIrFvURguxaspgD4+aA40MQ6iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLW5LXlge5OV/ZXvBRS7f/wKR+DAZImWVXk0KR5MytscVo9Wo4
	1qKdA+UxA8wcPKpFGGkuaaPPI/Ww+hNiyElh/wOzUv7N0/CaFeTuzI06jTaN3D4=
X-Google-Smtp-Source: AGHT+IEjv+MXakpefCsgi5HLZxPHwYDurtx/yD0nuWtCXMQYx9C38W3JKkkERUExxV4d2KBsbM6yEQ==
X-Received: by 2002:a2e:e01:0:b0:2fa:cdd1:4f16 with SMTP id 38308e7fff4ca-2fb82ea761bmr22402471fa.14.1729343657256;
        Sat, 19 Oct 2024 06:14:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb80712069sm5028321fa.0.2024.10.19.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:14:15 -0700 (PDT)
Date: Sat, 19 Oct 2024 16:14:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm: a6xx: avoid excessive stack usage
Message-ID: <k42wmgziqia6balqsrfualbg73giesjxxtyaldkxsrdxkro2li@6neybqsu27me>
References: <20241018151143.3543939-1-arnd@kernel.org>
 <20241019093146.kdp25pir5onjmg4g@hu-akhilpo-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019093146.kdp25pir5onjmg4g@hu-akhilpo-hyd.qualcomm.com>

On Sat, Oct 19, 2024 at 03:01:46PM +0530, Akhil P Oommen wrote:
> On Fri, Oct 18, 2024 at 03:11:38PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Clang-19 and above sometimes end up with multiple copies of the large
> > a6xx_hfi_msg_bw_table structure on the stack. The problem is that
> > a6xx_hfi_send_bw_table() calls a number of device specific functions to
> > fill the structure, but these create another copy of the structure on
> > the stack which gets copied to the first.
> > 
> > If the functions get inlined, that busts the warning limit:
> > 
> > drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' [-Werror,-Wframe-larger-than]
> 
> Why does this warning says that the limit is 1024? 1024 bytes is too small, isn't it?

Kernel stacks are expected to be space limited, so 1024 is a logical
limit for a single function.


-- 
With best wishes
Dmitry

