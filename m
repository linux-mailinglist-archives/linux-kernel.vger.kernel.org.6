Return-Path: <linux-kernel+bounces-422836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831E9D9ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DB5165AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2751DF25D;
	Tue, 26 Nov 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXFBPRDw"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E631DF257
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656309; cv=none; b=jZQ26dsnXyxi0RoyeGeaBo2QdLODnxaOO/Y2WsaBt/htt+9fWEop0IxUM5FpZ/cExNa2eNg011GketKWxkA+vn6Pd/vsGk+s0L6n1Ij2I478zjByGuglHwasEEP8lplfwAG1G2tM0n7O4bkbZ+2t1MZ5SS97D6LbhwDnb3XVkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656309; c=relaxed/simple;
	bh=OCbEhyVLJAVes5U0OfNBYmU9gspkQL7a73ulu1r6IXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7YgZMnbX7YFg9b2pBVA5k4pspqfJ6oHfDURaJG+G15PjsTgQZ1JsC/TyaZFP0BTmpqgBsdsKr5tU1wRoSU0j8dOjEZY354jeG4fKLd2E55wA6gLDdQ3ffxGAGQflBXG+WpZJk15TzQTnvekHsdwaeptYInkml1PhwpuLLzdsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXFBPRDw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da209492cso7832151e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732656306; x=1733261106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h3kJfGGhVM0yFSXEKXnzQX8yDxkzOWLSNwlq2YprHM=;
        b=FXFBPRDwIOvyE2GEhwJvQoG7+kGD6ElmZUqN09deH6bmfrwRSKCAVjsDDyvaOtNW83
         MxK5ZnDkf4urTjw6xnCeZO1V/JYI6qX6CDCrKMsizIBg6Jjf6al09IPH5sciL6tDUXFy
         +Krae5Q8gwmNWhIwBRev77La6p5mr+v1ephNSw65tLREqsKmpXprmhqNYqmyJWOvbxYr
         9cL6xXkKf7iVvs5bLhy2wjPDwowAnOQ590/JaaghCGge4P813lSLEtKc3e+43q84hJ//
         uHQQ7RnW4qbxMherUqhj877PLflPHbxpJLNsKsW4ygjX2RCGkJkp3ppnCuHKsmRC+GNI
         9/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656306; x=1733261106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h3kJfGGhVM0yFSXEKXnzQX8yDxkzOWLSNwlq2YprHM=;
        b=kJG5eyCteq46h36GGKzpfpBgsnIj2S+LFfUgmA6qvMLWkk3GUfg2GjaNFFpCUkCBLj
         +V6p7uDKSLpRU4rWxB7J3xRPSbavdIfvcy0+zUe5mAx/ZOsIZMi/XV5d3YzCNcVl3YZA
         0gi0113cVyCCskkwYtdufnZcrj0ni/1fXPijMpTrMPKj+oU44stmZk0VNWNMbl2B8YDN
         AWObBKFwWiS2TrxRscPxtmrQeVaQkfvcGZ7sxdV+E7dfyq5wl8YMrgptewvBqHwF/Byi
         EU0jec5EsPcuV83xXnoG1sBNhk1GV6QyDcXND/FUSQDRoOC6qHdUOfIZQyD3qjOyxNYE
         fpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQDY3VR+57DTtroy5FLNpbE5jcqc1HvBBqarJq8zUsasMucjBwTxb5iHQJ9MaKaFJlK5PAOdPPB8nUTpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUvA3xttIU8e7MTxxplYtKFEPMylTaxvNUftqC0+17Pl573lu
	IWF+o8kS6iRNH9z02DLbi0c37mEJHnpylsijak7PC2ef5hRHdaa30tzT1tcwMZ79Sy8g05mTNUs
	Dg8dSa5UHbeSkDlemP/EaKxraGcItcSnQBFwklg==
X-Gm-Gg: ASbGncv4CT7LYZY65CBqey3C3FT+63GOCcEltJeHv+hK1EZK/tUDm4C4vxNiO34lHxp
	YluY28/iTAMzvkBlSCVsqL1NIZkYxBA==
X-Google-Smtp-Source: AGHT+IHSrPR6Pqpyg4e7ER+ek3MH0oeiQVFy40chfxmpilpXRCIjRdoDRTm7U+FqL/Q1H+0po9DrV+HI5wtgsosAtoA=
X-Received: by 2002:a05:6512:3da3:b0:53d:d3ff:85f1 with SMTP id
 2adb3069b0e04-53df00ff18dmr264363e87.42.1732656305985; Tue, 26 Nov 2024
 13:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-imx-pinctrl-optional-v2-0-bdff75085156@geanix.com>
 <20240506-imx-pinctrl-optional-v2-1-bdff75085156@geanix.com> <49ff070a-ce67-42d7-84ec-8b54fd7e9742@roeck-us.net>
In-Reply-To: <49ff070a-ce67-42d7-84ec-8b54fd7e9742@roeck-us.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 26 Nov 2024 22:24:55 +0100
Message-ID: <CACRpkdaBR5mmj43y_80b9jd3TAqRWMdCyD9EP6AY-Y0-asz4TA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx: Allow user to disable pinctrl
To: Guenter Roeck <linux@roeck-us.net>
Cc: Esben Haabendal <esben@geanix.com>, Russell King <linux@armlinux.org.uk>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:17=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On Mon, May 06, 2024 at 12:23:53PM +0200, Esben Haabendal wrote:

> > Making pinctrl drivers and subsequently the pinctrl framework
> > user-controllable, allows building a kernel without this.
> > While in many (most) cases, this could make the system unbootable, it
> > does allow building smaller kernels for those situations where picntrl
> > is not needed.
> >
> > One such situation is when building a kernel for NXP LS1021A systems,
> > which does not have run-time controllable pinctrl, so pinctrl framework
> > and drivers are 100% dead-weight.
> >
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> This patch didn't update default configurations, meaning PINCTRL is now
> disabled by affected configurations such as imx_v4_v5_defconfig or
> imx_v6_v7_defconfig, making pretty much all imx platforms non-bootable
> unless the default configuration is changed manually.

Since the patch tries to add default selects for all drivers I suspect this
oneliner is the culprit:

@@ -6,7 +6,6 @@ menuconfig ARCH_MXC
        select CLKSRC_IMX_GPT
        select GENERIC_IRQ_CHIP
        select GPIOLIB
-       select PINCTRL
        select PM_OPP if PM
        select SOC_BUS
        select SRAM

Should we just add that one line back?

Yours,
Linus Walleij

