Return-Path: <linux-kernel+bounces-561268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F27A60F77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3B61B63469
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022F1FCFF6;
	Fri, 14 Mar 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnIf5EtZ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D91FCFE3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949858; cv=none; b=IGVsh+W7wB8jcA9/GwFWoljDY5MnFORVJ6EoAxft5rD3l6C7uZl55qhaDotyKlahCfxzxDcTgbi7pnNDkCPzBm3ZP8RmTeYlK/u2/P3r6OC6IG89TFtRPrYSpbEBFhNRrViOLmMRMPIurzPUc///+PWP/DaU9lR6gqmKL9iX24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949858; c=relaxed/simple;
	bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQL5x8DrWifmQJA21kqe1q7dALno+t1reDqwCbKyuXQb+NEjlzVpAa/i5R9Awo8yUEFgfrAdtKWEqRzAzRfHmqzsAu9Nu0Wuz9Z6i0sjLRG1cbyAMcykQvrE+xbgVA3TrdQ+CiSq93OwI4HRDz9T3g54fKot0R72DAX2jLVe6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lnIf5EtZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so2089857e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949855; x=1742554655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
        b=lnIf5EtZ9qg8dVkti2vKLJhl4rBUEuuWKWUTQuoSCv6k+anF6iWeyl5dYLJ6Yr0Vq7
         EyTPBPV20MpaFPHSok5UficfJkk+OieZ/rDuuJCdU1uZ/pJcwBqtcDr3MnRNHxrQSIm1
         4nl2Oq/fCTB2u4848NJozAcWwL75StNqYB8vAtetwS4h4Q/yIodVtnu728LBzZpJsjVW
         WgWjUsaQIaoHtltPD0SSaKobkSU0HYCdEy1c1ZuIOKMxHSBRSZSY232Al1q7rsBBGso2
         D/T9H4QbXnF5IpNIyESc+zozOeDpZeGZbRVfBTZxYQZTmXe00W5WQgiiAk6jJAA/xO0G
         hHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949855; x=1742554655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKCqYNBypZASUp5pMtBC6KobHZh44HrAoDmtFddJOE=;
        b=gkATnwGAzBSXybznf+P+R1niQGeKSs5/Zo59OaKr3PoS9YQOKb4LpRdhCwbrn995F7
         BdpHTCR8+lheERJKH36sZs7VJ7miPt5gvqwwlr415/Ozj6L+MH3dRS4+qhMxVWPOMKjf
         ABKyEFU/V6PDabUOYgXyZ1Zxv5qLRHQ0Alf00T37Uw9rwnGU956/LEvVK3NYs3MiiqYm
         lKBz1p/bSdovP9qCU2w/DAusL+3fmqMSk6tba/9g9Ueb5RaFLi4OTgTDizq1HYw7Qq6k
         jAO86iSypzeO7fBYBYhTm8xdDvbE9CaNw2tOn4F8Upt/PwOKEiD7XQ5+xGrpRZqDvu+F
         1c2g==
X-Gm-Message-State: AOJu0Yx3mlnpFPZatXVQy/NnTA/HPBpDdKDYvQkKcwrqClQIp66CEAGS
	6EjfdqjwycD9CWx7x7x22N/CN8TkeDoWimSyl7G/4OcsvH5vnIvguqcd9A6ZSrv2jk3MrS6wv8Y
	IHdyukvEly29nPzslSlMZa/Cw2RupIpwsLg3o5HJd2Sv4WffuGa8=
X-Gm-Gg: ASbGncsZDA0rUgD7Nx0AGhqQnOZ0KyfT5Zn7prnB1gMhs4Vpceiuyz+EJi02ATGk7LP
	xz/G9HMoHMeg9j3VDnNbL9qmVYzwndLi7jHNNMg/NWhQfWHa+fHquzkpD8qNAJzuDmipNeWGFJQ
	b5lI1NkmtiIL1SPyZn1ZmNLzQ=
X-Google-Smtp-Source: AGHT+IEf76asqhDkdkvXhqu+mO/IFieIf/3f+AsGMLvleEYnKKvWPUb+WclKn/4pflNYlJ7Kbm1m+cmFDlssMD/heM4=
X-Received: by 2002:a05:6512:33d6:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-549c38f5f4bmr616654e87.23.1741949855093; Fri, 14 Mar 2025
 03:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.137040686@linutronix.de>
In-Reply-To: <20250313142524.137040686@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:57:23 +0100
X-Gm-Features: AQ5f1Jr6On0gNmSSDDUyRHyYbipvFLs7mW9hVn3bWPpLuNR3rb3rLES9gqD-UtI
Message-ID: <CACRpkda5=PcFi9a87SaQMeN+pPPubUxp6EKm3oNSo8UB6XHzHQ@mail.gmail.com>
Subject: Re: [patch 3/7] soc: dove: Convert generic irqchip locking to guard()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Talel Shenhar <talel@amazon.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> Conversion was done with Coccinelle. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

