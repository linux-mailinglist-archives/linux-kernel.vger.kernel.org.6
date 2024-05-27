Return-Path: <linux-kernel+bounces-190461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5388CFE92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04B11C20FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E813BC26;
	Mon, 27 May 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjfG05cM"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E13FE4A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807959; cv=none; b=hGL3U7WcS65UgKvP//4Uw4TpdTx/p98UJzdIfRh7mVRbL7EPIE0nTWnYJ8ImdNKrpmcXb3wiJ64tbiL4KeXayK9HVFTSCXxFLJXrZkTKpXwZWaKsp3VO5aFZY7PFT7SSl1MF7P3L5RAUP1+vzGB5cO2xyvVSS08vaGfftBfePRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807959; c=relaxed/simple;
	bh=AGOTuEx3RxbJzSknO6FX7GZtQcyn/9D9jvyJ2MsACYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrHd8tZTvyGGmSKn8RVk88AWOP/sQS29hJsvIfOHgYYFjTSo2IDLKYD+fLwqbaHkk/XbUpymjMzvHyYiED02pi7eEzNmk8LihzUbBesa9pRnxYfUdX5jAGpk/4+x4n4R+FiLJmP2EiSjL/jdPzx2T15D/GUNksEXhEk2QaVrd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wjfG05cM; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df771bddc0dso3042039276.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716807957; x=1717412757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGOTuEx3RxbJzSknO6FX7GZtQcyn/9D9jvyJ2MsACYA=;
        b=wjfG05cM7ZiL/VbNpAUsa2zJ27NNe9cY0LYzBqhqNAwbNKdu3mUK0vcVLgmsgmCre+
         ZaYErBz4cXofX+I07KrqanM62QRsvjApaUFGHWfsDdXxxHzMCNHYexjWt6YiyzKeFRP6
         Q8PA9q7foNFCpguREPuZYyiwunVKkNfKlLbrGREmw07UiQOvKC4JvO6B2xwAbiNCYESd
         E30zE63DZAQ7nXhGybBOIcJ+tp/xr6gNy12NBPMbTLBT0byfYq3rI0kCLQpUzqIQ0SVR
         170qPJoKowqOagu1MSdFNbdPUwbMMDaElNghgWuwkLA2vAqvnpWr6hm3sSnQqo4dxGFm
         yUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807957; x=1717412757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGOTuEx3RxbJzSknO6FX7GZtQcyn/9D9jvyJ2MsACYA=;
        b=pYjoMTesT+ixCJRVUxOpnQvCGQyr+gtH37BovNeOsrRkC2qFY0RIIqWL5oMsAlrI6E
         mbxTVTuEKcRgvOU1cz9Q8OEwD5n4ZTJkz+ftmwEv74L/DEj3J7Zbtho2kbr+8bupNTwj
         ADXNiOqWqZ0WmJnCE8/pkhUbcHrdS0RZK511Kj0kvd8s7IoF7gq0mrMxGG+kN9tNa8T4
         rkyDp5fjZ6ODgjoOviUB6QQj804A3QwRyFZvUNsWkFFzoigIN/X1kLrkrlye9rAGCpPW
         ZlQm5Ayd+JywXpRxliwc5sCyGA1Pth48FlYw4LdLkyIVdIJ4gX7gfD010ZlJo0u4UGgx
         gPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfgbdUYWyaKc4v8+7VusAXTKe+Ea/YVxEJKw7eP95kd74IprKBcdJRN4s3yOPyFbEHOOSkhf0odJ8DwxiFWc8KZKyNG+QVWx9Jua0n
X-Gm-Message-State: AOJu0YztajFdIpkIleTv4SqVreH9n4MQ/v0wpDAtMLR8+EyHL558eV7e
	hjPJ25QyIiDU0mSPTq8ZfKDUDOeY30+09G88kMH+BYnXcwLxX9+/l6gCbKi/mOLq6Fb6ObOchYW
	mzTQen6IP9SUfcob16b7J4wUuMdmh9vMk+A4wjw==
X-Google-Smtp-Source: AGHT+IE+x2RNUDIXzBVJyvvEPGXIeKYYisMGL9Wmwd7yQrZe3Q62nlZKoeWKiejefMIQx/H55NGFKTgn7UsM+pYsbXo=
X-Received: by 2002:a25:ced3:0:b0:df4:d5f4:3ef2 with SMTP id
 3f1490d57ef6-df77218adb9mr8965780276.20.1716807956744; Mon, 27 May 2024
 04:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-imx-pinctrl-optional-v2-0-bdff75085156@geanix.com>
In-Reply-To: <20240506-imx-pinctrl-optional-v2-0-bdff75085156@geanix.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 13:05:45 +0200
Message-ID: <CACRpkdYbOTXmap-vJy4JNZSaZnE=yzC35EPD2F=bD8gWdD8-GQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: imx: only enable pinctrl as needed
To: Esben Haabendal <esben@geanix.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:24=E2=80=AFPM Esben Haabendal <esben@geanix.com> =
wrote:

> As not all mach-imx platforms has support for run-time changes of pin
> configurations (such as LS1021A), a more selective approach to enabling
> pinctrl infrastructure makes sense, so that an e.g. an LS1021A only kerne=
l
> could be built without pinctrl support.
>
> This is a very late follow up v1 3 years ago [1]. The situation seems to =
be
> unchanged since then, and I have tried to incorporate the requested
> changes.

What is the verdict from the i.MX pin control maintainers on this?

I can merge this into the pin control tree for v6.11 but it'd be nice
to get an ACK from the maintainers first.

Yours,
Linus Walleij

