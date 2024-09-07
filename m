Return-Path: <linux-kernel+bounces-319632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B2970006
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BA82845AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975323E49D;
	Sat,  7 Sep 2024 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="YDyElkem"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160728E8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725684620; cv=none; b=NXz4/FJIar9hjWDUN5p8p/Ta5X1BDGZpWv46q8Lpy5uTd/bRYmiObEEGN1kwXtN5+kJwgk5fBlsEi3f6Y0aYxifd/oPuiPt37v451uh42uInEsfnRcxRcC8+kBhHrcqE/znEDUILzRZRlv741j8AJpDx6ZWTzq0AnUv2igF3WTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725684620; c=relaxed/simple;
	bh=vMFJsnhY0b8h00xWfcUBnglnC19nzBmR6VLnnv7w9rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svrxfx5z8mjZal089e5u8gkyet0P1ADpAxFm7+lPuXuMyMiUsydgf01Ulz2QMOXAAKvkKaC2efF5PV96KKucWh+/aYPYMTUOLKRVGafJHi3l5nrAMWFLMdzOIcxbs0QCzRFDOF+kLY9xKXPZHesArroDhqVvIa/MOxQI3g9t23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=YDyElkem; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=YDyElkem;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id BD26C6FF
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 13:50:12 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7d2159ebf3dso3728295a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 21:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725684612; x=1726289412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSMukMIhcDVQ104P2W74lSerkCACmtj94ee8fjaLxa4=;
        b=YDyElkemO7HYTzLTEk+sZHHuiJIWuCSKJXBQBECkAzfMB5RWNf+FYK8la/43lSxuhz
         gBgerCEHwQbdQHyOcsSoPJvbPkQVnLAS+W5/TpfbTdIf1Sd+ugXFiY8T5lcFrHPc+eZk
         3dLq1qE7ZBLEjHoq9t82wyyAPh5Z9flyMU+gCLQw+QuaqFjTfBa1wLoPpIIch6jA6hpI
         i0LTz+3H26oVRHKgBNyWPBt71+5OsWftAMBbGolWtXnfUXwLmZX3gGrMUYwHqaMWL+z+
         uG9ZZBZCnjepWJZEYyw45h5AsdUWia3czAFdmy/OhzZHPpQFYw3ASqiCmujIIUu7iFts
         NcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725684612; x=1726289412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSMukMIhcDVQ104P2W74lSerkCACmtj94ee8fjaLxa4=;
        b=fZrG3U9ygPPk5gGTJKh2I7UWHaTNTciyB+cixpoaFgdRHbrIcULeL60ZubvZeiDEDX
         WdNRnrGcXU3ct0w1e25DYc1bQ7cbMb1iiJVVY0dD1spL480gIhbWzHUujhce6slE3TM/
         tzXZxqZNHktflFAn6N6G63AUjsDlL3GBESQNcpkikb9ifHnPNis6ANeJeKO4WlIAjADu
         TNI5uJ9OmCC9LcPI9LXYvwoxTSKZrT8RkyRqiiDjbI/VrElWSU4oOfNcYA3DKOsw60qL
         MSaHdwy4wWhiFUogUBVHt7FnaZLkx0WykCSjqPTDjGy0wGjO+azni26tViOYKBni7sjA
         67zg==
X-Forwarded-Encrypted: i=1; AJvYcCX1rOiVF6a+u4cEFI3qmH5deNy0ROVl4hEdXsfjvsJNGn8qol7wDZ/Ciyc6M9mct3l8fKvkXqIGMqnR1uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mkMqJdZtZaDI/dWG1+/0Ys+EG5hDwNYU56AxAHZsHW8hV+KP
	gC8QsNr14TF+akFZMgTNenF9fAMXWKvV6MuLwckHx/a0vqP1cLorN32pKC/rzvZZfsR8V+ET+Xe
	v1KSjzqW5n8tb7pverTnRBwJzd9lXIdCtYOMEugvywNra9kGcdFjGqZKajblVT2w=
X-Received: by 2002:a17:903:2303:b0:206:c12d:abad with SMTP id d9443c01a7336-206f05523e9mr76534235ad.34.1725684611662;
        Fri, 06 Sep 2024 21:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk7UlUC3AHUh16SCd2taB+NCntOKFAyIOi25PshPx3ZbLNjNzHyk6BXfmJVY+8FNLV6qwfiw==
X-Received: by 2002:a17:903:2303:b0:206:c12d:abad with SMTP id d9443c01a7336-206f05523e9mr76533955ad.34.1725684611310;
        Fri, 06 Sep 2024 21:50:11 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710ef71c5sm2565125ad.132.2024.09.06.21.50.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2024 21:50:10 -0700 (PDT)
Date: Sat, 7 Sep 2024 13:49:59 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org,
	linux-imx@nxp.com, festevam@gmail.com, frieder.schrempf@kontron.de,
	aford@beaconembedded.com, Sandor.yu@nxp.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
Message-ID: <Ztvbd4XqY95YMAZd@atmark-techno.com>
References: <20240904233100.114611-1-aford173@gmail.com>
 <20240904233100.114611-5-aford173@gmail.com>
 <ZtpMPCHBnEgtkBWp@atmark-techno.com>
 <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
 <ada922ea-b307-4ccf-9e2d-9a2a08fb97c1@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ada922ea-b307-4ccf-9e2d-9a2a08fb97c1@fris.de>

Frieder Schrempf wrote on Fri, Sep 06, 2024 at 10:28:59PM +0200:
> I think I managed to get behind the calculation of the fractional-n divider
> parameters. I came up with a spreadsheet to calculate the output frequency
> from existing register values and I have a crude Python script that can be
> used to search for parameters for a given pixel clock.
> 
> I tested this with three different non-CEA-861 pixel clock values (supported
> by my HDMI USB grabber) for which the integer PLL yielded deviations >0.5%.
> With the new LUT entries those modes work now.
> 
> I will clean things up a bit and then share what I have. I hope that this
> allows anyone to calculate parameters for their non-standard displays if
> required.
> 
> If someone feels extra motivated they could try to calculate the fractional
> parameters at runtime. However I'm not sure that this is feasible. The
> numerical computation of a large number of parameters is quite heavy and
> it's probably not easy to strip the algorithm down to something that can be
> run on the target without too much overhead.

I think keeping the LUT is perfectly fine if we know where the values
come from - perhaps having your python program in a comment above the
LUT so anyone can check the values match?

My main problem with the LUT is just that -- there's no way of
checking. If the values come from somewhere sensible and can be verified
I think it makes sense to keep it to fill the holes where the integer
divider isn't enough.

> > This way, the calling function can determine if it needs to be
> > multiplied by 5.  I haven't fully determined how the fractional
> > calculator determines what frequency it wants for a target frequency,
> > and using the values for P, M and S from the fractional divider
> > doesn't seem to always yield 5x like they did for the table entries
> > using the integer divider.
> 
> For what I found out the factor of 5 always applies. For the integer part
> and also for the fractional part.

In that case I'm definitely in favor of moving it inside the function as
part of the calculation

Thank you both!
-- 
Dominique

