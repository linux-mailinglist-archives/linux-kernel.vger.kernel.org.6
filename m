Return-Path: <linux-kernel+bounces-431434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D69E3D73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFFEB42B06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7020C016;
	Wed,  4 Dec 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/d58ev4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963D20ADF2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323868; cv=none; b=qOd4MdKPXJqnZcs3gKsxm0jwOA2ChueXun4GmIT1+7g+kngIKQf3ddqbgEznV3C/6us+ev9ZfzcQCDSLuMh7ywOhEcIPSp3wDoQohbjxmEI1CHCiYsAF2vCIpb1tW/VcJZ27SAt4YaqqKEUzfVVBxpqCh2Tyd5ytpIQXWtqz3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323868; c=relaxed/simple;
	bh=kDIzcQ6vbeuE8FDNby2S0zBxGVr9TcWaanupyXqFi9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf0OLKMSPOpWeq/quhPowGy3/Ws4tbRBeuZGUvQz5LVJsh8XLaWI7KjuvYskGZt5Wn0Gx4DPkwCB1mMPhGPqEbc1j5g5up6aZO3le4AOtIAkzWQxxq2ul02TzglFkTl5u9dpFoXKRHA+BzG0mg9J6SFU11lhjO4L+SvbogFWD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/d58ev4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724f383c5bfso5433264b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733323866; x=1733928666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDIzcQ6vbeuE8FDNby2S0zBxGVr9TcWaanupyXqFi9k=;
        b=q/d58ev4RtkpC5IQN81D6A9MgJGJAzu4aXzUV/Eib/uCAf1Ol/hjtxnpVxFQnYKYFt
         EjMmLK8suQIkGs8TUsbdrzxDIj2vfv+7Cld/JYEvzRFlyD/KVoer+6Zk0ZF8Y/aBp2zC
         KPOYMaIW16l8fOoxGQulfuZEB/WE6zi2yvcZBhsudI0ZnS4cPgOLAg5UimLxW9fmD8KK
         PluS7O5lNqfEByRBj8/BVweGfDopu+Jr0chuAgww+qQ3EABTgdY/BUTYp4RvhraNvfSt
         N0KkwiPXyjibIaNUzr0rshtarXGqH/e2aaBJj0tRePm1exv6j+Ac9fOTiioYA+H5O3ii
         1LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323866; x=1733928666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDIzcQ6vbeuE8FDNby2S0zBxGVr9TcWaanupyXqFi9k=;
        b=TcGk6Jfe3c0CC9Y9REsj8cuFXyNtwI1sDoayQmmX3Wy8BUrANCNpjQSf08Mv/QIWfj
         pd2SEivT0596mlGr4dRYy9GaYJzDIz+NAL7U2GJ12RDyR2VDk7X6w5Hb3q0xwAJUgrrK
         zR3rQFeNLWlLc+ednHKW8akaHbGolRcWyHfxT+iD5l97EOj9XdNwUVelqVnYhWVvudDa
         ci6KZlIJgcpcQFy7Z9ObuMGyPwWkTriCsKrf05LGcrkkV0QjhHyMlhk9zXT8tXpSsNUi
         c0aSHjb5vfHml7xxYDe61Ew0HnBpvSfRpdUj+wWAurYzY62VKh1b5ZHQqVwjCqbTP9iN
         mfqw==
X-Forwarded-Encrypted: i=1; AJvYcCXaJ31qjgcjFbt6R0IMCHs2SXty2Po4+wArlHerDWYQW69VlxjYfnHyx7+CwTmvuGqN+eHe+l6/m3/Mmns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWj5/P7erqpZlNdxAsQOIUrnM0hSTwICcK/Lhrkw4oETXWWbM
	2fGWc4VTrxcw8XvLo6UqyQyaVdwwt1OX0uJ0FPsY7eQHJE66NmwhKSaxGr7gCLSQpxFLOfCDXuO
	60TYADsuR3Z3fHveHNlpdUwo/ketbJiMmN7WINg==
X-Gm-Gg: ASbGncvlGUjdTDHLIxbOYfr2kEv8mVfhxOaVOkPGUuxUIwLIhkLC1iW8bz+YVu6sOyR
	O/U8NG9gd+1tFW4dCy+Ro7IrVCx0wnntP/Q==
X-Google-Smtp-Source: AGHT+IHhPo8ZM+oBcAXAmoAGuYzzQRkMbjIfXqq/wrIpoANjBt0loJwIy6Q+f2LjyQLs6AQneluG2KMYSXOqhbfNX3g=
X-Received: by 2002:a17:90b:17c9:b0:2ee:6e22:bfd0 with SMTP id
 98e67ed59e1d1-2ef1ce997f8mr5608820a91.21.1733323866059; Wed, 04 Dec 2024
 06:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-3-arnd@kernel.org>
 <CACRpkdY243J4C3A9_13eTN84T2SeOjyoh0bWk6U1mqffUd6urw@mail.gmail.com>
In-Reply-To: <CACRpkdY243J4C3A9_13eTN84T2SeOjyoh0bWk6U1mqffUd6urw@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 4 Dec 2024 09:50:57 -0500
Message-ID: <CANp-EDb27XE0SMpDFUKm-L3j=rZhugbK20cQZGtAmP5D0r2C6w@mail.gmail.com>
Subject: Re: [PATCH 02/15] ARM: limit OABI support to StrongARM CPUs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Mack <daniel@zonque.org>, Gregory Clement <gregory.clement@bootlin.com>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, "Jeremy J. Peper" <jeremy@jeremypeper.com>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:59=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:

> Hm why do we need a separate netwinder_defconfig if this defconfig alread=
y
> supports it?

AFAIK footbridge_defconfig is for the "Compaq Personal Server", which
is different than NetWinder. They could probably be reconciled by
using devicetree and converting any platform devices. However testing
could be a challenge, not sure who has working hardware anymore.

> I am occasionally booting the NetWinder and then I use this defconfig,
> the netwinder_defconfig wasn't even working for me.

Interesting. I successfully used netwinder_defconfig a few years ago.

I have several times thought about updating the netwinder, starting
with a more modern bootloader (I got u-boot working at one point), so
we no longer need ATAGS. However toolchain support is problematic
("bx" hack anyone?) and there are so many cheaper faster boards (RPi
for example) which require much less effort.

Regards
-Ralph

