Return-Path: <linux-kernel+bounces-346110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2798BFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97A51C23F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCED1C9EB6;
	Tue,  1 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVJQGd2t"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5B1C6F71
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792299; cv=none; b=ubcp3f0j/N6+JSjr9RtoDMysYGsVlL+w2U9lv/+AGjn3TzYhb/uowuY7XIWIUZEKJj9szq1Xb6q/UybWowv27zZplzlrOogafA0mIWIcRHesngOhJ0Ddxl1V6liqc6p2godjXKuRmihPLEacrPe4RC7RdocGgsiwlT5YxWEbiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792299; c=relaxed/simple;
	bh=XsFwKLOGlPvFEBxHyR86cL5eojW2dIOejDjQT5SGeFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9RdnrHUyQnydH43/xjnndibpYIJ+1EUdvCiRfIdBdyjXTLfoIcREmaQSmJePh5bgHogMswIydfqPduOPGdd23Tuu1wNxpobC9YDCr/z4rSZ3HAAyA8u7mV7ZWZFbNUZFVQ1ZzpMYOSAix89cTNkYbaa/PyDg2bc4KU/dyeAICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVJQGd2t; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so3449843e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792296; x=1728397096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsFwKLOGlPvFEBxHyR86cL5eojW2dIOejDjQT5SGeFI=;
        b=zVJQGd2tOhUiWy4Hu1hnJEjTYMHpDWy4KH8gdJUGQb8twwJeoMBWJFKK90gPmeqgDg
         zHLj8vVtpLfImD56VPQXGUpv/uG7TIwxrTk0Y5sDIf/Qh1YK6TnYTyzYE96OQGq2N6Lh
         PENfPZ2XVlQekiA3U5JPMs5ubaXTsvypQvFasEk/iHiXwm2lWqvWgImOov1pn7k1nA5E
         ZkomD80tVeIZjCjviRX62Rxg5iT55myMT5aqyQ93C63qEVZ0LhJ4l+YEUp2qNMl7S1e9
         Hvl/pInGe12GgG6iaeBFpe9R7mqCCWzs+e96SKH1zQNBXsGLKizXNtwM2eioSShnvyY/
         69EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792296; x=1728397096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsFwKLOGlPvFEBxHyR86cL5eojW2dIOejDjQT5SGeFI=;
        b=Ian62ZN6M7uw3zS1mr2T+Wn/8RbIkz9OHVfIO0Dgv5QTn1I8Wb/9/7LIHY+tyHP5bN
         W3/b+gZQFfrE8kjEGitTd2jJTX1n9HDgSd4L3iWOyIozyKDnood3R8vvh9VEmbk12LgU
         nrub07MyyXEy98it4ddBhBfn0UE/t4JD/myI3fuVDW9f9TlpDDSQ6rqjVWnRSsHy1FGT
         E0XTu9pO2HeFDi/WM5enoL/nfrLKAP078dtx99dMbjPxYyQW2ENWbNZ8/mz9flsyc+43
         CYnFblOLLLdcszritXhjyRamOIw4j9NipxmzjtY/6pIG4JbPpEe2W/kgYl87MVmyNifi
         rVeg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+2MJuLOzMumbjxU4tzeFGpw84YgJg14SLRonlvoPk7IyjnkCXvSswbn3QQFJgaJkp1qkbmQWtMhTicw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUSMXRxVIA8Xd7Ghvvf/iPiXgTK+pdfh+8IZudUHYjyhxk3QX
	A8S0LJq486dxOrpAQbTuv1ZVGxmiFKT9647KeAdVR/lqNNsuOgfk+KiuSv783YZiB2siKlO2ozI
	BMF62NDNQpoUA9/8NxM2YZP6fMQ0Yk6Dj7TPhZgOqRaitDnk4
X-Google-Smtp-Source: AGHT+IEfMH8uk4RIxkOdO5Hy2blq4o4vWNOnpucH3GZ2DnMbaYnX3CqykKYsypLP7wl0QcmQrA0dM4xIL26aFEV1xAs=
X-Received: by 2002:a05:6512:1155:b0:536:568f:c5ed with SMTP id
 2adb3069b0e04-5389fc32b18mr7413043e87.1.1727792295331; Tue, 01 Oct 2024
 07:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com> <20240919094339.2407641-7-billy_tsai@aspeedtech.com>
In-Reply-To: <20240919094339.2407641-7-billy_tsai@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:18:04 +0200
Message-ID: <CACRpkdbFD9CiqVwQ5xxZ9SfQtVvDJGCr=8spxBG4u-JQ0PKJ3w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] gpio: aspeed: Add the flush write to ensure the
 write complete.
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: brgl@bgdev.pl, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	BMC-SW@aspeedtech.com, Peter.Yin@quantatw.com, Jay_Zhang@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:43=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> Performing a dummy read ensures that the register write operation is full=
y
> completed, mitigating any potential bus delays that could otherwise impac=
t
> the frequency of bitbang usage. E.g., if the JTAG application uses GPIO t=
o
> control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the application
> sets the TCK clock to 1 MHz, the GPIO=E2=80=99s high/low transitions will=
 rely on
> a delay function to ensure the clock frequency does not exceed 1 MHz.
> However, this can lead to rapid toggling of the GPIO because the write
> operation is POSTed and does not wait for a bus acknowledgment.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

If this applies cleanly on mainline I think it should go into fixes as-is.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

