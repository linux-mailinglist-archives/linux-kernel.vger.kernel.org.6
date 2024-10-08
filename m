Return-Path: <linux-kernel+bounces-355349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5E995142
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD47B29555
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D11DF978;
	Tue,  8 Oct 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jj80nJOD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43A1DF72E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396314; cv=none; b=Hgho6oCuOWSO1eLNGRQ+fTUNQ4u87DQSd2OZrWeWTJXIYIo6o7awKY8kUoBM5R1nN1YSehZcRe56Bt7ahMbXhOYE+udL8/5PadZmpwdLVEHQPtFmoCPfgH0S2oL6NcyZ2j6G8wkVJcLikvoCbdjyC6bREdS7k4tvNNuabAWGkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396314; c=relaxed/simple;
	bh=F/zAtiWZQI7SQwrRf3j8mFudmNdtJgba/frtTc8eoX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhNpPxUjuhCMb8b7Sh14zEuQYTVodLoBKpIOf3V2WVOXFrlSBrcc8AJV68nFQLwZSjzH928aKMw6DpoXBjZogrR0YCqE1HI0rwzkK/k9W0oNOcOWbtB0oFIYkx14qhHs50MYVDzyaPnMqlGMMGw/jC/riG5L47G57lNku6+Bqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jj80nJOD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53994aadb66so5121095e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728396311; x=1729001111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/zAtiWZQI7SQwrRf3j8mFudmNdtJgba/frtTc8eoX8=;
        b=jj80nJODha1dlCx2y9/E0MowoKSZLlvro6pslO4Kh5Es0TNNs52060QpnlNLpgiTyp
         voXNlOz/IoT1rd1ckri8zFVCTyUQZNVLHXRr8rtbOsQ1Jpregw1Nuq1OKVFSBKrP+HHM
         wfgI919uvLrvQueqEG4257VkVrx2xJMnGqHaqvaUYPfIvtZRHER+VOO1KUCmoUUTztiJ
         /u+ClM8CLjvAYc7eypNeU62EIRvLa2YMrPsQ3nhYH6RcOAikWA/cBrKQwzoKbS+sASe9
         oHE3cTOA598Lg7WqR95oZOYxR+BbwZymf6o1RIUZSseZ5hSh31P8V+hawCofj0iixQye
         soQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396311; x=1729001111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/zAtiWZQI7SQwrRf3j8mFudmNdtJgba/frtTc8eoX8=;
        b=ckw2pQGbCcutDJBX4PPt3G5ExLwTd1HUiReCxqb34CnnzjdHUqlbidSyj4IvwIg1RN
         zf7Ba1ZuOcj2y6nAKFaSLAYdBECBHQ0/TIN0pfw5u127zCYGvdX9laRmuRCgZGGktaid
         GIHZjAp9ZZMq0QwOAhlorCaoav50VdhNfz41EKy4VcBrHTitc9hfqdJ1sXW/Wc/jFMqo
         KKWjzA8lBDY81zzchGYHz9CPE4LkofAFjqnU4dbs4Al9z57N7QR9x/RKg18D10pV19bh
         Z4w2v2sG9g1HOrVWB9oFqbwcZ/mreS79C/OO5bAa0yvbUN1wrBOmXqieVfO4gyQdjayv
         KHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFKOoQ1OPxne5SbOdEdDIt0wup72L05IYiINiM9Mq8Nc27KM030yDuyxM3bL9Zp82mzCeO+cwOVyTt7oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ztrP+RL5IoaobXYypd//ViXKo8ohTbWuYIlfS7yrKMGP6K5Y
	8wa7uoYaQM0vdlxRV2dPfNiWDTXbI54MxHC1/zFRk1PPSxK8Epcui0lIPWyMHjI/pOTomkIc1QP
	1tQkU3ZD2skaX3pasuMvE6fCPb0oyuFLbHIDUJg==
X-Google-Smtp-Source: AGHT+IH1k+VS7+QOkdRfKiZ/ppDlZVYCrXPrQ0PrBFHAOvGlq7s9Ltc5V63YkuZv1c4KqrPzzDwk1k5PEzavj/a9qU8=
X-Received: by 2002:a05:6512:12d3:b0:535:69ee:9717 with SMTP id
 2adb3069b0e04-539ab84a7cfmr8460693e87.3.1728396310565; Tue, 08 Oct 2024
 07:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 8 Oct 2024 16:04:59 +0200
Message-ID: <CAMRc=Md4BOsdv=w+ju00X_R1Z_RAXz2vidVMrb7riaE2HoS9kw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add Aspeed G7 gpio support
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com, Peter.Yin@quantatw.com, 
	Jay_Zhang@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:14=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:
>
> The Aspeed 7th generation SoC features two GPIO controllers: one with 12
> GPIO pins and another with 216 GPIO pins. The main difference from the
> previous generation is that the control logic has been updated to support
> per-pin control, allowing each pin to have its own 32-bit register for
> configuring value, direction, interrupt type, and more.
> This patch serial also add low-level operations (llops) to abstract the
> register access for GPIO registers and the coprocessor request/release in
> gpio-aspeed.c making it easier to extend the driver to support different
> hardware register layouts.
>

I picked up the first two patches for v6.12. The rest conflicts with
my v6.13 branch so I'll send the fixes to Torvalds, wait for rc3 and
then apply the rest.

Thanks,
Bart

