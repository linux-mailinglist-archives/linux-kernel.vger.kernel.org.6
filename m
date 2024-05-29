Return-Path: <linux-kernel+bounces-193761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DE8D31AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9822865DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A2161939;
	Wed, 29 May 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RohltbjG"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1761FFC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971916; cv=none; b=q6bvCmqSWLmW7pOt0TZuMphL/4IzM0wIZO8w/XlnXCVfkdyd58rrMKHz3buS/ojhftqnSnhaSa2L1jXFnY0xClaOW1P9+mO4DojyjjuyuIkUxDv8geeiB3anVCNoSPbQu6UvcL/Md0gKfMDnoJXXa720a7jLr+Gw3/JrZfrg4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971916; c=relaxed/simple;
	bh=W94EXWPFJ9q9UNIyDf4SkokQQRNWUNrNd3sGFspwBrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCnv68KSf6iC/jmliXAqE9l8d719eavesmi8g+Qu7zWyMX+oWmjKFvl2iT0YJ9EMoYRJ2XMa5BeG0ukVC0vGDaC9MkqtLACAk9Tj8JfFbmF9jpTlt0nyUT07gogubqUIJkxIc/B+8l+z+yrgRdoMITfwWTFxAUZzJVRDfvJeOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RohltbjG; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df4eb08fd9eso1785447276.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716971914; x=1717576714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfxCTrRrYhs+zH3S+r6FD6/9NwKyWS5rNPOaAhWZ11Q=;
        b=RohltbjGHWskRC34ddkEGjirCYmuy5pzcJreKnpaBNjsnXy1DMVfkO7PHYotpf0ygu
         dA/hZBhxrFdjZdUyCv7qg/rvAmK4yGkE5W8t1Hrx6cnmReaoem7cZN3m10ljVymJom3I
         OMlrU7jlQNmDjKqzmVJsNFbpjCuk60VzM68tXHd5EbfkKlQSXuK70XVER4kvnYwbk4nU
         qQatTgsO8+GD6dqBMKunE5RaMXiKbUpUZ6EHW7EJpbGFJxvv8r6JWbAoowecnfdY2PpD
         jgzTGZWV2750xAKP9TnX7FoNR+4u+amxufRhQMLlruOz6yTs9FVXglZB/ZteJ6bbpPYu
         wL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971914; x=1717576714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfxCTrRrYhs+zH3S+r6FD6/9NwKyWS5rNPOaAhWZ11Q=;
        b=EE+7vHzszEriQFm2el62zSyzwM1czig3+DpiQxDYjI+J4vlzRApnD7fdY0MC0/uaQk
         07OQCsrUsWuu/eZmnUNb12e9bfEEbGMxZoL9XE9ubA5lypY4zQz7tw8L0THRZ87JHR3k
         LqRA7uKHaHUfgcJ3ArH6bkGySlqxeuV1SrG71bp8HA5ynPUl37uMDgS7/wwW8lZnCO2a
         75xWfEUKfI8Qjq+9NO+fIHdddE79fNFTfss3MgVmXz0f4xpBxq51pmQRHVDPT+C9WyBA
         QIokNLMzVnoJckOyTSzFkvFWzmIpqjhM+vaSgeKCwo3B1zDuogjacmB4xilmfhswzWNY
         G0UA==
X-Forwarded-Encrypted: i=1; AJvYcCXVF3Ufl7+7pT9+3vVN3sNaBVfDTfpifmIfXXZl7KfEcZOZr3KEnz7NVqD+z0VLeakzoXcltwImUrCRQSPFLMKI5rit7aG5qkEli0yc
X-Gm-Message-State: AOJu0Yxp04xjwXp3Sb5rmAKJIVqAQ8B4pwJFr27mdwtwX/KDlgv8Elyr
	yMq7kwKDGeQFlFTOEmTiknos/lyhbstIC+4IshPPYRRNr+3+Ok5dVQPP4/bAf2I22LU714T0MuA
	8Zk9rd5yAMAQiu6CTqNRUjdbA+EZoCFU1P8aY9Q==
X-Google-Smtp-Source: AGHT+IE1L3rfPGCLoTSF1U8u6pMaFUTuNBhiX5mIr9Mk1JgZ59CkSKB1rpS3GkWmoGbfmxnz12oXzgSsF9H6xHUSkJo=
X-Received: by 2002:a25:107:0:b0:de6:107b:6557 with SMTP id
 3f1490d57ef6-df77218a0d0mr14340358276.27.1716971914233; Wed, 29 May 2024
 01:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
 <CACRpkdbOAoSDNFhXfz3djUZh1_MQ_T75CC+-LmojRXvyCbUusA@mail.gmail.com>
 <06a4e5fd-3d26-4923-bcbf-0bdd66d756c4@linux.dev> <CACRpkdbSsgxtKqF6ORXubufTaegjysHU7zH-tJfDfKNd=Kdoeg@mail.gmail.com>
 <51d984f5-896e-469f-914d-2c902be91748@linux.dev>
In-Reply-To: <51d984f5-896e-469f-914d-2c902be91748@linux.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 10:38:21 +0200
Message-ID: <CACRpkdZ19+zUCEBCJJ+MBnnaF+caZKFTDxYiWZ0BRGx+PxN3bw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: zynqmp: Support muxing individual pins
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	Krishna Potthuri <sai.krishna.potthuri@amd.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 4:28=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:

> Well, perhaps you should have reviewed the original driver more
> closely.

Do you want to push me down and increase my work related
stress? Because that is the effect of such statements.

It looks like criticism of me as a person, so explain yourself.

Writing this kind of things looks to me like some kind of abusive way
to express your desire and that is what burns maintainers out, so
if that is what you are doing, stop doing that, adjust your behaviour
and focus on technical issues.

> > If you want to mux individual pins instead of groups and functions, by
> > all means, but please do not mix the two approaches in the same
> > driver, I'm just trying to save Xilinx from themselves here.
>
> I see no point in creating thousands of groups

Please share your calculations for figures like "thousands".

In my experience, groups are usually in the tens, perhaps
hundreds, physically restricted by the number of pins
underneath a BGA. A Micro-FCBGA has 479 balls and many
are GND and power, so that sets a ballpark figure.

> for every combination of pin musings

It is clear from the documentation that the point if the pinmux
groups and pins are not to present all possible options (known as
a "phone exchange" solution) but those that are used in practice,
i.e. these representing real world use cases. See below.

> when we could just switch to the solution in this (or v2 of)
> patch. For compatibility we cannot be rid of the old situation, but we
> can at least fix it. There is no technical problem with them coexisting.

Historically there are  ~2 camps:

- One camp want to use groups and
functions to combine pins in groups with functions to form usecases.

In some cases (such as pinctrl-gemini.c or the very latest
pinctrl-scmi.c merged for v6.10) this reflects how the hardware
actually looks: it does not make individual pins available for muxing,
but you poke bits or send messages to change entire
groups-to-function mappings, so it is necessary for some hardware.

So when you write that "groups are a Linux-only concept" this
is because you probably haven't seen this part of the world.
Groups exist in hardware, and in the SCMI specification.

There are systems with individual control of the muxing
of every pin, such that e.g. every pin has a muxing register.

These are again not really phone exchanges: I am yet to see
a system where any function can be mapped to any pin. These
just do not exist. What exists in practice is that each pin can be
mapped to 2-4 functions, in extreme cases some more. Often
these functions are mapped to adjacent pins, and the "chessboard"
picture in the documentation for the subsystem reflects this.

For this reason, it is often helpful for driver writers to group
adjacent pins into groups, so an iterator can walk over the
pins and poke their registers in order, instead of treating each
pin as a unique entity.

- Then there is the camp that just by habit *want* to control
each pin individually. The extreme example is pinctrl-single.c
which is named like such because each pin is controlled by
a single register. TI wanted this solution mainly because their
hardware wasn't described in manuals, but in other HW
description files, and they needed to process large volumes
of data into DT-form.

I didn't like this solution initially because it makes it hard for
people without datasheets to understand what is going on.
But I was convinced to let this coexist with the group and function
mapping, which is fine: maybe one size doesn't fit all.

i.MX and others also do this approach but with large sets of
defines in the <dt-bindings/*> files.

Combining these two approaches is not something I recommend.

Yours,
Linus Walleij

