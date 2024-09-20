Return-Path: <linux-kernel+bounces-334467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A897D7A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50704286835
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66F17CA02;
	Fri, 20 Sep 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM8zUjqx"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A41E521
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846992; cv=none; b=Ajlg4UYxWLuw8suaDJY5xKU1659suFfXqVMk/89C9BAm7qttNmbgCRVP+3BlSpLFqI1xKYQlo7QctzCXnhA8/hV9Ce4SMUl2cU6EBXpWSmDUKh5STNVKuHXerDMLLHtqqdBEBKNrb+z9cE1niih6nvGsrrgIzofPZDHxrYPuGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846992; c=relaxed/simple;
	bh=v70E1HX6ZfQ9jhYLTGwrHs5GH6wJwc+GiIBdBgzS9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk8fw+gtJE+bARW+AgWUpKrbGQVZu6F0iOea2jwf4F9oi8k/rlitt5c5aTELbFCerLdSoVmlAC3IIr+3rRL9A79TN4+7YEdPmAlz2otyaqykIwHtgWQgVMREoRGL8Ldwbqnd3Unzadfl9cer5jMbtiwq7AHLmwaRmwFKJEbcSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM8zUjqx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f762de00fbso24180201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726846989; x=1727451789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nB6QDO4zFJh38Jmp3QKlaNX1/zC3u5zuIlycDTEz+hU=;
        b=UM8zUjqxrmYjQP8mI60IJ/yJmClGtYmCwPcw4t3eA/cAshQYodol86uh8AKNSTlPOD
         3Jhzhf402s2M/dcnCQNWQgG5u2k2QXV5yOtqPScd7Pm0IpowbatgKlClwtCJyD+z1UK8
         g9zAHGwjU0A+XCmYUPhzzMHSdu93rfn1mJlx4NYlvL3AW8r1ITIS6Ds7SyecG5Fr5tAg
         5V9Nxwh2dnmnNqVTHFhcQJBRcATMoSWOr9S9tQhnR6DPsoDF5mgqQLtNgwnegCYNSB8W
         BhGvTmPGlujCd04WTuqdHZwHBf0ZHwgWWEL3GpMKyskzHxIChC530Qy3HIOHavxpHQnC
         gCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846989; x=1727451789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB6QDO4zFJh38Jmp3QKlaNX1/zC3u5zuIlycDTEz+hU=;
        b=mMm0c2qrHhwfkTpw6TGKt5dxIiNGvtFeMmzcnpQWidhVfrgnZ71SVF3M564GLbt5Rl
         r+6STLPDD9HT2WXuf9R80oR/1Fb683JmQ0jU81+AdgdWVIEkH9QxgfO0W7xE2FEHJNOV
         b3B6kNxP8PrcxSV7LbWzs5pDbrHaBqOP1fQfaBABXzd9P/XHWUc6jv8oBzsTjw+IRyjF
         UxyyqXgb/r3qscMqTHS061nxu5bcSAMpuLD88O06MbnFbwPBi9vqhIKQZffXn/x50g+7
         VuG+m33oz+5Xcj8P1mFGLzUM1eCeVU4d+Jg4/2SsXq2FLQAQAkXvfAWqLdXjiT4aWxdg
         t9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbu2v1gBJY4IamuXY/Uxq8CFhh4K07p1xfPg1LA7PbVI/NEdeoUmQAMkq8cf6AMRPLZmLfjvUYsde+qhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNT5a+19UhvY2lhfPz7gBRknnAEYG4pBZGLaoI3W3Drb+vHgM
	agDZf1s23z1bS2BXR01WD5+f7QR0S2XVH6Pqz6exxTvSkCoWgut5ZukVSUjA744=
X-Google-Smtp-Source: AGHT+IGt3hzdLsraJIT7tPBdDR6V1G5Ibrb5NQ3oA1x+M+iY3xwn3oDKwJwRd7XJaET4QHzdhZythw==
X-Received: by 2002:a05:651c:212a:b0:2ef:2c91:502a with SMTP id 38308e7fff4ca-2f7cb301268mr22401391fa.3.1726846988985;
        Fri, 20 Sep 2024 08:43:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1e04sm19290631fa.28.2024.09.20.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:43:07 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:43:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dharma Balasubiramani <dharma.b@microchip.com>
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS
 Display panel
Message-ID: <zognzunciriytm3uvoolxjsvu43v3m2lnctsz5swusnmm3aj2z@ag7zkncccdmf>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
 <20240919091548.430285-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919091548.430285-2-manikandan.m@microchip.com>

On Thu, Sep 19, 2024 at 02:45:48PM GMT, Manikandan Muralidharan wrote:
> Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
> Display module with LVDS interface.The panel uses the Sitronix
> ST7262 800x480 Display driver

AC69T88A seems to be a module name, rather than a panel name. What is
the actual panel name present on this module?

> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changes in v2:
> - replace microchip,ac69t88a-lvds-panel with
> microchip,ac69t88a
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

-- 
With best wishes
Dmitry

