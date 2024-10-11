Return-Path: <linux-kernel+bounces-360811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA4F99A002
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D1EB2465A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906320CCC0;
	Fri, 11 Oct 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfAv5RSB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BB20C49F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638351; cv=none; b=HWVeOtCEXTexwL/iSb2BKM23jtu1wHtvLN/8JkBtxdl5bPQP0OzID/5abRQRXf12MzyrLsh3mENWOYbShNHV/uSKS8bHPgSxsOQbXOBCUVVQBQ9O3SMxAzFPd+v5wB5jBJit8UbXTMo2kF5EjX8AVLa8XKt34eyc9pR0Fnz+HkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638351; c=relaxed/simple;
	bh=jtVhZWWNX3zX7CwdFolfALYhOUO1vsDRDytrh8+FfTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghq0DPTvb0XzfHQx6OMGK7hsqNrjkaTtZaZiuISnG990q3eCyV3DLive9eKv+ZbAwtBBBxWtJ1CYXbyeYuJPtSShl+aeFHXa5GVos9IOxaRRKPWjkBZQfsxzGEm8NHxmz9inYLP8hsd9i2X2KSg2Y48WRBDbKrf/TRRRTb6xQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xfAv5RSB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad784e304so20142311fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728638348; x=1729243148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtVhZWWNX3zX7CwdFolfALYhOUO1vsDRDytrh8+FfTA=;
        b=xfAv5RSBq1dPqwx4O1H9geUKag4zuOOxK9dpbjgQWNumxT/TLl9G0khO3AvTnJs6Q/
         Fg/q2ldJhTI3V4oBy1BiF458q1ciawRODAKhCxIqx6s4A6emiEY4AqriTYWB6BbcLQcf
         XVPzrt9alzF4Ru1uCJv5QJE3yHPHl3dU2O5d3pWn/17Mqz78ycRZgP9vObcRpmeHJ/ET
         cSc4SIAC8L9IvBFtZKQF+6tFm7KrShhXyfcz8gsQNUg31foj/9bh7yWeW5l3Yio0Q7CR
         sAoNIZjxsXHr5frEI/BL7lOCnzbW+SY2bMarWYFc7uJ/vef1LNPbuU2vwmTmPbRv46f8
         1XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638348; x=1729243148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtVhZWWNX3zX7CwdFolfALYhOUO1vsDRDytrh8+FfTA=;
        b=eWJXxe+FXmImuSTE1/6cgRaGYFDAlvABGKXjGRObw8sbiCPkPUePMOBrj+t2AkgfYh
         D0sSpF4ZEz797y3ci0GfUdTB9rn8BB4mFOCg09QjCWfgNiz617s+sXTB5FUEq2o70QBA
         Jx8aXujtJPRaXpQOq2ECAQ/yJkXzFbHRKjtu/hmn/Q6PEoslBNfTEHb0LXLfXqyqIA/Q
         UR+xJz93r9j12+BLLm7bo8L8G3buYyg67O/zFXx54qN3GZV5waqHH4QLViWdvdYk56/m
         O3WKOtXxHmibZ3huPEMvw32PhskdX1T6DerrvwwResj1lvHGPDtaZJtjdLwS3jMBqhzA
         guuA==
X-Forwarded-Encrypted: i=1; AJvYcCVQgXHbC+P1fF1Q7Uwx6OObKr8da0sBDlSLF2nz80nIpXVcfsQNrWqCkrRHJYdUxxPI+RsBay/z6cmolJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyns785H2wuofugoAZSKvWFIlm8qoAyfEQJLvKVh6lSndJU1w9d
	pWlx2OCD1nXI7uN75pX2fNoSZ+7T9GujS9ewNqlO8kQFmpQTcUw8KJKD3bN2Tw9EU14ohRx4CFj
	3d3sSywHbkRxiof2wZ849tqU/Ldc6HpX2d8Dvyw==
X-Google-Smtp-Source: AGHT+IGr3IbqNBTBBoJpOQ310qlh+g4Oi9eFyoyUCTdl+vSPgY4MeKHHQ6RiGRzDh2lAYpqZ3xVkrjWD4F2c48r6rk8=
X-Received: by 2002:a2e:4c02:0:b0:2fb:2ebf:3259 with SMTP id
 38308e7fff4ca-2fb32709c02mr6280871fa.13.1728638347593; Fri, 11 Oct 2024
 02:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006181310.181309-1-matsievskiysv@gmail.com> <20241006181310.181309-2-matsievskiysv@gmail.com>
In-Reply-To: <20241006181310.181309-2-matsievskiysv@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 11:18:55 +0200
Message-ID: <CACRpkdbJ7xh1qOYaZOh+s+Tj_GgE4LXMFuOgL1zpxBRqJQVx6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: ocelot: fix system hang on level based interrupts
To: Sergey Matsievskiy <matsievskiysv@gmail.com>
Cc: alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com, 
	lars.povlsen@microchip.com, horatiu.vultur@microchip.com, 
	andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:13=E2=80=AFPM Sergey Matsievskiy
<matsievskiysv@gmail.com> wrote:

> Fix interrupt handle loops, produced by spurious and short level based
> interrupts by unconditionally clearing the parent interrupt, even when
> no GPIO interrupts are pending.
>
> Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>

This needs to describe how moving the chained irq calls achieves
this effect.

I'm a bit puzzled by the patch because I don't understand it.

Yours,
Linus Walleij

