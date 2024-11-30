Return-Path: <linux-kernel+bounces-426200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65C9DF031
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A054282379
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51370815;
	Sat, 30 Nov 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNQeEBik"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D9154456
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966615; cv=none; b=EZTMbuKCFsoh0e61R9DNLpfx+5xxpzfykBKOebyAiJGBmT1kmZCFFRK8XnqKvLq+Cr40uauXVbpORFipZKaJl19iqTPFH0Qi7gthq6ZmnTO8pY6Z49tX3Rl7PR5SHekAQIIT6E39AQpDG0I+lMptnx9nV5zOGiOnLfgrVZhVxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966615; c=relaxed/simple;
	bh=cs9uDUZB2++se5eVEafXkaa+FpWCY9F8GcDMnkcUmpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3CIILtdA8s4U+LfFGk5FLsYkRomMloIkMsh68NJKGt4nykBeq0xOddZYA2rKyNfpPKOrnEM7Zoy/Cxctx1ap8a8QtJJo5jPBlglV9cSHrKdLyn6v83ifszM4TGOV0ki9eA1JMYbxYU3H+imJnX3RbYv8eZdEukBpk0JaPrWmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNQeEBik; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de84e4005so3097542e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732966611; x=1733571411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/Pf8loTaik8LYCta5Jf2Zin0SqS3BgDup0y9NRq4n4=;
        b=tNQeEBiketj3ErhnxjUOND3PPJHIaHj3ZLmwJF9Y2HhRLjfYLjRla91ZgdJkDRjpbv
         4IoVX1flWcm38hTYYpvjzLbmQJDk/fkidrkxmV4GGrdFKew12jsaAnQKHi9v1/H/zXAV
         wye5m3Maq34BJehEze8FxevHvTZo1YW0uBWgZw20wgPswmS6KXo5/o2mUft8V61QvzoL
         C24Ipo7JIljMYGUYNRE4Gbwrc75aUfelba5gS4AHQt/JLFcescz5SW3r2FMhUNxWpHQ8
         Rle7XUtnlKtwMWpxj/BLWgRF0lcCFLEg07KJ1WSiLTRS0JxHvy4TSq3uF+lqvXCwF/7t
         pxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732966611; x=1733571411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/Pf8loTaik8LYCta5Jf2Zin0SqS3BgDup0y9NRq4n4=;
        b=oy6QvPwq7faHT09BVYpU6BwwauCNPEVCt+8ZS+WkXBfFoc4MrMOX6hZiQVrVg8DErZ
         2IkFV1hr4BIOwnuLLZHMDJG0wriPwbKs9JHBzMrVGD/n/RhBQHb9s3LZi9ZnTeGdnO8g
         +dIM0vOB3WgmWZtErOCJuHHNqcIS0MmAYn/nQ8hDiXF6dXb30pqQxZZ27RaowBpnB8FN
         t6OSWpS05pVZaTirVlRSGjLF8LW3ZU3PUvPfg1Q13cDKoQ3mvcDpA5y3BuvFTQ/TIhGr
         4DD4ZPAB/Xd3oCRBeO9DTy91/lOKdtv47EeT8cLX3JVPTwJNs5XIr/MWMFSiSlh3hNNn
         GX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUapk/4PNzw/KRcjGMMzUbLglb9IdiH5KECH7obqyX67Y3dTgwEAaSG+eNEj4uOdMuIbztqOl6PmsvQFc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeR1DToGXwZLLyz4i+1y+h/bv9/S3ITpbAEjqSXBFs1x2SKeNI
	yMgPJSOZl7j96dokKWFQaL3Nawf6T2sg8fScPMLgDenhYmZgh9z8H+W259aj2Gw=
X-Gm-Gg: ASbGnctFVbYQRe0/7FbUZqA4TDTuj/k5HqcH7RP7/4aJ6+/rAwsKn/n2APbx06B6hoV
	SHMp6Zt62owWPlvH1qgAwj0tZx5TRAYTwXmDwM9GgLpCJht+8QbGWefkqPwTUfrf5xK9eMr9S/k
	5H3Stbd4NxWAhcrjogN54q3i6RNjxpP2iHNaoK7OX3So4JDDGbS0ONnaQTosTbFuzzOT2zUbKrz
	Su+nEHepw39vhymyDWVzh2R53S1HbPQ00CZeE0FgBHHIAtj7GrDuH6iqBkq5OUqKomGuqEcPof8
	qSX2HQOxXbBgwpOdN9PTr1ZCFMkNyg==
X-Google-Smtp-Source: AGHT+IGIIEiDb6qXnTmJUVDYgM6wgGw7GPagKQ9KPPyyX5Q/cb5H82b2qn+Ew6KeyuYbpTeKoPB4zw==
X-Received: by 2002:a05:6512:3f1f:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53df010900cmr9945955e87.46.1732966611547;
        Sat, 30 Nov 2024 03:36:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f71asm754516e87.244.2024.11.30.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 03:36:50 -0800 (PST)
Date: Sat, 30 Nov 2024 13:36:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v2 3/5] drm: panel: Add a panel driver for the Summit
 display
Message-ID: <qowuzrx7s76r3soelwcvlbnksvstlpdind5xxejuqeeohjzsbh@evmuvvzxp3qh>
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com>
 <20241126-adpdrm-v2-3-c90485336c09@gmail.com>
 <pokf4zrrm7utx4dlq7sfob3pb4m2dh47eyw2g345tvh75x3s2s@ylajym3brih3>
 <CAMT+MTTGtmMvbPy7HvTQ+AdF_X4dTcfXV5n=krm414MnXYqxjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMT+MTTGtmMvbPy7HvTQ+AdF_X4dTcfXV5n=krm414MnXYqxjg@mail.gmail.com>

On Sat, Nov 30, 2024 at 12:15:25PM +0100, Sasha Finkelstein wrote:
> On Sat, 30 Nov 2024 at 10:29, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > > +
> > > +static int summit_resume(struct device *dev)
> > > +{
> > > +     return summit_set_brightness(dev);
> >
> > Doesn't the generic code already handle that for you?
> 
> Apparently not, I have commented out the pm ops, entered sleep
> and the display stayed on.

Please add BL_CORE_SUSPENDRESUME option to the backlight device.
But interestingly enough, none of the panels set that flag.

-- 
With best wishes
Dmitry

