Return-Path: <linux-kernel+bounces-431372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C639E3C84
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D77280B98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B591F75A9;
	Wed,  4 Dec 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp4ApjzZ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFC1E3DCF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321922; cv=none; b=ZQOCTjp8h+OLfnksNgvHCks2NPewr0dlX1N8tgyKcmVYK88Dzxa0MP5AeSH+GoU1rQUOpC0Szy+vYQDV+1SUJLi+pF3DzudUIR8gP12eitCn3m4omwyRFXp+gkCF8sFWnhISHk9z2hR2JL/1a0Nll2NjULGCRdIxgpDIlHlzBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321922; c=relaxed/simple;
	bh=WgMzzPONzvXMDffdEbLrbj7uxW0Hra0oNVW7bnaTYSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MY1D0ErNegMXUounLDMar0EhuelYpclapFcmTX5IPsRTHjiJW8vwalXZx6duBWyF1DlL0vB2+iUg0rUOmrsV9wbTOhqgXZrq/+MiYEbcc36cpRk4j8+3hIARbuH0MieMMvJ4JiGtn8EJyjbSQRkY9LpDKPM1R8Mwiz8sv0idTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pp4ApjzZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5803099276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733321919; x=1733926719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgMzzPONzvXMDffdEbLrbj7uxW0Hra0oNVW7bnaTYSQ=;
        b=Pp4ApjzZFqEGci12v2Jd6KFEAwzPy4Ot8Kx8y2vX5UE+xKwxqCtivb+KBERXloG4i+
         6ISrWlaacJMKY93oCLH0VDFqjwrKXpR3CbaVSNmZUsRLIFA7Yt2WjtnYO3S0uZ+3OI5f
         jJE+0D4kCoufQsxesh3v5VK6+G5UobVk1qhCS9gH8dTKFzhRBCJlNU8kPr7SAFTKqSzq
         dv/QfJaL0p/rqCfM/sY/gs5FKOY1TnkhHkfd5UAiQ0+VREcAKRDzIutsydRmTb1VkeSh
         bhIjVgf7lBjAEgQYXzfypnb56eyFoX9lD9H+irbDCNZsBAKNR6uih2vLVXumS2LAkSfD
         AFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321919; x=1733926719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgMzzPONzvXMDffdEbLrbj7uxW0Hra0oNVW7bnaTYSQ=;
        b=b7YWO0GZ5A+0TIF8jG+gaJKL0P1aNf+Zl7CoUmNOZuFE3g8zRLMLiQuhTGbPyqI2od
         3Bs+pKaNLQJB0cLSzwhiiMMaWuuhbX9Luk9PWAosAg7cMy8dcNnzBpUfRSuKPLvpQt19
         p5re6nLH28POWpTALMXeOKcxVG8KSOEagXA7Tkk/O2GVSUnp4Q4TezPXxJBUOgjxq8jm
         /qWIPKLLhWaPGjo1Hd/BBIoJgf/0HGfn5NzMZaECKWpwe4vLmTwO4GOYtitfMHCxfHdS
         +WPxWuIIqTju1n1dsB5ElZ5UnQGAysmTJNuvRSS3F22EmfmDU4/1H/XytyVFkPWU3jzU
         l3gg==
X-Gm-Message-State: AOJu0YxNRLuI3PnXqs2AX2G2OLBxkGcRy/uftSJR1QqPRb0yw7uvODDf
	3Qbm54lAhTko7JojoMy4CZUsxFZ1mwmdMnz5lIloq0g68wdEkv7ckkpsxbLoVpLnT5Hbgw3hjlL
	Fp9qUmJJl5Tclijk7EeQmKxSB/MjoVVzYJ0WH7w==
X-Gm-Gg: ASbGnctokaZT0JVVGkBQfL/hUcPvBRSH9eTj9ooKKJ7XnaajENB/93BnU5q0XyB8VTX
	DYeOYjlkbdvj+OKTLZ1GrHYr/WE4wVQ==
X-Google-Smtp-Source: AGHT+IHEBiMzARXCmqv420GKkYL/RmMowf+ypMis1l/b3gAkWJs2OLgwlqwdaIBmHS5oWLjT+lsU/IYaahq4W2xwfOs=
X-Received: by 2002:a05:6902:18d5:b0:e30:6dea:3ab4 with SMTP id
 3f1490d57ef6-e39d3e1c824mr7567913276.23.1733321919294; Wed, 04 Dec 2024
 06:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-14-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-14-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:18:27 +0100
Message-ID: <CACRpkdYQUiN8VNTgK7-9bnr40TiACT3MSScb5QF3mz4MawzXHQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] ARM: mark mach-sa1100 as deprecated
To: Arnd Bergmann <arnd@kernel.org>, Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Ralph Siemsen <ralph.siemsen@linaro.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Most of the old StrongARM1100 machines were removed two years ago as part
> of a wider cleanup, the remaining four were left either because someone
> showed interest in converting them to devicetree, or because they were
> still supported by qemu and therefore useful to keep the platform alive.
>
> None of the devicetree conversion actually happened, and qemu has
> marked the platform as deprecated, so do the same in the kernel now.
>
> If anyone is still running one of these four machines and planning
> to keep updating their kernels, please speak up now so we can adapt
> the plans as needed.
>
> If nobody is found using StrongARM1100 any more, it can be removing
> during 2025, leaving 6.12-LTS as the last longterm support kernel
> for it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I do have an HP Compaq iPAQ still running.

BUT. I know very well that me and anyone else who actually want
to keep running that platform better get our act together and convert
it to device tree if we want to continue using it. If others are up
for testing I can surely help out.

Kristoffer Ericson is still listed as MAINTAINER for the Journada
so including him in the mail thread.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

