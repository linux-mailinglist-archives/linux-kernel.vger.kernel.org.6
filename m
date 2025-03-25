Return-Path: <linux-kernel+bounces-575389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8922A70180
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2227A2EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976F25C6FA;
	Tue, 25 Mar 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkgL+9dj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EF1A08CA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908204; cv=none; b=ldYKa/gaUPTJmr4JoMAN2VGEbHK9kw/Bib3JNdGLTTOIK1jWMFnDsHmjjGiotoGHgOupiGEc2l2oAeyVQQI54UuOENQZPqjkph4ptoBvJO2/DlfBFCFHIO8AP6Tx4MO+sf20ie/FWrjl6/KhZcpFj2x5UU3tu6duZL1j6f57pUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908204; c=relaxed/simple;
	bh=MrQdnqrQ37zkSH+xmL91qGq72ZTsS3ZvH1TLByFafAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKkw91jN04qA1g81TXYZYr5brzgEfD4jqY+X8ZyHoIFu40429RuNtCLtZ9/EqgZpLBFiHiWaqlSVo2dAphVM5oM3BPPyWnTwrp23GRp3ToLePGBlTJteM62owPoamU7pwlxWEgmu5aNaSFHc4VHlZZgeRFjr2pZs4SoeBjrmBpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkgL+9dj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6146596e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742908201; x=1743513001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrQdnqrQ37zkSH+xmL91qGq72ZTsS3ZvH1TLByFafAY=;
        b=wkgL+9djV4oUk8AeK2bW9Bpxi9jE88XeNszTTIS0hjfCYy+t95RHuHjmIM7THhnMcB
         w+1ayyJU+LVdBWfs1RKwcmqiTwYDIdyBZuhTI63VvRyAzHYMTh6NkbPsojI3F7r/Mg/6
         Ug8x/ZGu92v1oEmS/eMIM2MFowZoBrKejnFePJ2ZmoARJEn0r22udhvOyYohh3YiSD+E
         cyohYJs6SHZcSP8Ot3tWHSg6aBLs9erDUPtDo4ixv3jOJBHpCXkYGrWldNQDeyFL4fkr
         nu7g8G3wpDImCShJoWYwxdf0W9bZcaOmlxZIfOb2qJYU2AqP3cqUVfH037/UssWpMgfc
         SFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742908201; x=1743513001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrQdnqrQ37zkSH+xmL91qGq72ZTsS3ZvH1TLByFafAY=;
        b=w44eqGxRDktmaTbJ4/Sm99hxKQ0JgtfAVGALBriwiqJ9uTEtF3nJFdIQTHGK3byFD0
         4HRDqHn6X18YoHEURPhSZbdx8x0k91wdYsNPUQwkiLORT539OJXGoC8Mqaiz54pr8GZ2
         ljd5/gH5uYALNjuBGn7tlyEUzf4E+agbztq5XRgdgTZHfqXY2vXSBs42ChI91N/4qOd+
         Rk2E5N7Fxa6zwKFghR++A+R+YRDqtdbXlSPnvY0PoRtxhwF5mqve20pldJAGQgew7y3l
         YDNp50iXQCAEVeA80TRgvOXdWDe5Nqmjb6cCCKdF9t7dbRVQlKVcSENXWe6Q6p6YknW0
         +C8w==
X-Forwarded-Encrypted: i=1; AJvYcCV+T4C94HTJgp4VaEqNo47EQyH/jFNtPd0vX1BW1S/yAJitc9epmnRA/okQld22aW5bgxEFmg5auEsPPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48HqsRBw0LNsHRsReNqf+qX4ZrR+ZwueLZZvNX2anfg/c41hs
	MgD+xZU0ynuHBr84d48Hu6x1h5p0J4aJeZB/r7c3oAYX6gpYNm/dHoQ1PRUeVnUnOonvgrnSRnJ
	zt1yJej2AhoJ9q1HC+5PPR39giVw+u/MOfftymA==
X-Gm-Gg: ASbGncv/TGYdxyk1uq8KBLxXv+L3GSbJF6aaOnbSVpfx77sljAezMyN2K27KbLfE3JK
	hxka5CMdEJYukNewlP3iZV5InslHT016SuG9WslLX3FakxrsTVBWfpL7+CIrm71hw2bQyLNDiCG
	psRsOIu5zfOeWRAc+6ECePXm0=
X-Google-Smtp-Source: AGHT+IEA8eZg1F5rTtYtGgxFGDqJ7eNk3ccgMGnZd3pLrENcTaD8LN6KiUTpuvzO7iXkBw9qPrcSIjiZ+Ib/g7be7BA=
X-Received: by 2002:a05:6512:1314:b0:54a:cbfb:b62e with SMTP id
 2adb3069b0e04-54ad64f6791mr6320883e87.35.1742908200694; Tue, 25 Mar 2025
 06:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318052709.1731747-1-peng.fan@oss.nxp.com>
 <Z9lJETLh2y27934q@black.fi.intel.com> <PAXPR04MB8459A44864B9213E8265137188DE2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <e3abe8cc-357c-471f-b489-e1a8625933e0@kernel.org> <20250324033038.GA9886@nxa18884-linux>
 <7f22be3e-908d-4036-ab92-97c6b0427d26@kernel.org> <PAXPR04MB8459BDF97DAA5FC1A3A8B7AA88A72@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459BDF97DAA5FC1A3A8B7AA88A72@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Mar 2025 14:09:48 +0100
X-Gm-Features: AQ5f1JrTRSKcnNRqr9tDe943HyISqe1Jb1O_0dxGZ5xxZb_T1URcA8bYen_No_M
Message-ID: <CACRpkdYCgkwuOm5vw8oOSnu7ZVLsC3FDJoA2695gAufwp4NQVQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: s5m8767: Convert to GPIO descriptors
To: Peng Fan <peng.fan@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, 
	"broonie@kernel.org" <broonie@kernel.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:26=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
> > On 24/03/2025 05:21, Peng Fan wrote:
> > > On Tue, Mar 18, 2025 at 02:48:05PM +0100, Krzysztof Kozlowski

> > > To keep DTS unchanged, we need update polarity in gpiolib to force
> > > GPIO_ACTIVE_LOW.
> >
> > How are you going to achieve it if one DTS has LOW and other has
> > HIGH?
>
> With this gpiolib-of change, to fix polarity as HIGH.

Yep those quirks is what we have done to handle legacy cases,
mostly from old devicetrees using bindings where proper polarity
wasn't enforced or properly used because the drivers would
override it anyway.

Ideally the bindings schema should enforce consumers to use
GPIO_ACTIVE_LOW but I don't know if that is possible, but maybe
Krzysztof has ideas!

Yours,
Linus Walleij

