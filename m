Return-Path: <linux-kernel+bounces-447062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0C9F2CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2151188B1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78D201020;
	Mon, 16 Dec 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JnWP9Zl2"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7781FFC46
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340657; cv=none; b=mmtbhaHpr8+I6bM9aP9RyF85f8vWFX+/MjUXqA7UIkfNKz++DTV20sBfJtNNiRPDpbpmJaKNNF1ywBg2inJ0K9axoYBJwrDo2ddCMmq4PHsMxmbglAx6Cpkw7qmwJR+Dkm00arPFPMQf48BcNerjrlyzvDOVomiUAiVV3ORlIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340657; c=relaxed/simple;
	bh=1qR5+1H3fLvBgI1LotDXtcQetIxOlpQF0+huH0Qt/4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqB35N9VvuUsX8zMXClRWHr1sYSv9/5UUknewINcJNG9dS5xJW37qBbOpLQt9LadnSOk84ovGbbiovxB8UQ4drC3GEMNWJ5o/Sw/wdBE/qnnGQo5XLfhfE59oRgbrvBbP2MY7iy28YJSibgW7d8NF5TjAVrGkAubuNwSXBwxsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JnWP9Zl2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-303489e8775so16205261fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734340654; x=1734945454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qR5+1H3fLvBgI1LotDXtcQetIxOlpQF0+huH0Qt/4E=;
        b=JnWP9Zl2prbWhXhYSp3bdNi3H4yHDKDKTwK4gXw4cvejsv5XoACLnDpISJub6hYulP
         GIZ+3aWl3tj/9OTB6n1rhrAV7hwAAbFU6dpWhwB2h25CG+NcS9irBEXJ9AXkYmX97CUP
         ZJikAotjjdRhvBobpxbhrADNVC+qqtIwMOZ33rhltHd0PNk95jyJ0qFjyVXx+DAIixi7
         h47Tl2nJvbY9ki+h2FRmZLKnmITYVrv3wRA6pvj3mGLbZM8R2zDUX/gNPbfdfmzU+juS
         bmRuDVSssi6PYLDugrh/LSUmSFpU6IX5o4kFS54I4GXDZkgzf6Nu4NG67Z1t2IgRCsHJ
         jiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734340654; x=1734945454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qR5+1H3fLvBgI1LotDXtcQetIxOlpQF0+huH0Qt/4E=;
        b=FUI7uearsycTU6lq3ECSvho9aU2Zrj2Q3z37JKdqJCCWXJ3G7CWzbp8dGaxKssPU3y
         x7f38cIyf3sTlzGN0oKyw64PwLPRUBm1uwBw8nO82e3N8AKZqYKvzsEcQSL1ZQpBAw9k
         RZshj6lOhJlOsooipCsUb6Pn0KdY30BDMmNU5WGN+cxPzEQ2AbKLOs1NvWYDQTN846s2
         CWx3VwEkZfe8lVA/TAPuWaudwH1+9TsZRneu3dBzXzuPu5yAZ4DdLBLcA604g4kiYZKs
         gIoTwmxPSL4XBL9Bd7fWwfeV9Ij6REGmCPMGy6uO1YZq3LgRVfXMlxRxvZIUlhYWNGqJ
         qK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9qBxJMwvCeG24A29RRrhmn6HjpeLJuh1VVlrWYmm/ecsQHj3m4z5f8DNW6HeBZDzmmADMnltx3FvGKVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY0dUUXUB5MGcJrKYf68dR6UYd6pEaHWx/Ax6ktzx/qj6CGYD
	Xk+i54SAVo5Ic2RGiDJMLfiVlttlQlEqAe6oGInsXldIpC9uRn1gFkJ2sqEsnkjfTlGkg52DvzH
	+eSR6cRuabqYTavOHoRnWem/+ZuRkmk+A/1/uJ3sKcmZRWnql
X-Gm-Gg: ASbGnctr5yIsI4kwnBfiy1tZ9xUdgwW5YB3EopMoNUPquqYPKE875cT7l/SS4Zeibup
	r4++Erhg8PNx6dEyZeBoFKjJZYBHEExqqLhE1vq9Me+6I7wdEkVbTZ+Z+I95W9JQnK9f7xA==
X-Google-Smtp-Source: AGHT+IEOwduo8usaj8ZRTiMKvnDvI/sKvG+uXPsesp8eVxzp1U/WEzzEulhhST+phRCarmJrvrroOrMmTlHcWhwZgzA=
X-Received: by 2002:a2e:bc09:0:b0:302:2bd8:2687 with SMTP id
 38308e7fff4ca-30254530bc4mr33805791fa.12.1734340654051; Mon, 16 Dec 2024
 01:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-aaeon-up-board-pinctrl-support-v1-0-24719be27631@bootlin.com>
 <20241211-aaeon-up-board-pinctrl-support-v1-3-24719be27631@bootlin.com>
In-Reply-To: <20241211-aaeon-up-board-pinctrl-support-v1-3-24719be27631@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Dec 2024 10:17:23 +0100
Message-ID: <CAMRc=MfUDGaW1cBrsLzAZ6GORFFv5fAjEKXu7esO44v4XckheQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] gpiolib: add gpiochip_add_pinlist_range() function
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:27=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> Add gpiochip_add_pinlist_range() function to add a range for GPIO <-> pin
> mapping, using a list of non consecutive pins.
> Previously, it was only possible to add range of consecutive pins using
> gpiochip_add_pin_range().
>
> The struct pinctrl_gpio_range has a 'pins' member which allows to set a
> list of pins (which can be non consecutive). gpiochip_add_pinlist_range()
> is identical to gpiochip_add_pin_range(), except it set 'pins' member
> instead of 'pin_base' member.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

I don't have anything against this change so in any case:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

But may I suggest the name to be changed to
gpiochip_add_pin_range_sparse() for a better indication of its
purpose?

Bart

