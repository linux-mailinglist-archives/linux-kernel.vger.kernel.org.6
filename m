Return-Path: <linux-kernel+bounces-401227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BA19C1766
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953CC283444
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040F194120;
	Fri,  8 Nov 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+DfAR+v"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CF1ABEA6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052979; cv=none; b=tN0NE7qH+3pn/6rnAbX+DwhOObTxRRToyu2sQbD4WzQ3vj6S3JAX9fAM6LLfsgjXBq2X7oiozOTvbzpq87cAxgnQBIQxPkOvh8pnLG+x4OWk8eGiOQtM5j4sf0EFxnm27U8bRcu59RXHkuJEGt1g3T3gVjqH9gu9EmFg5aodO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052979; c=relaxed/simple;
	bh=dUTRSMTXrdg5Zyft5yF6+XKivEJnOQQBelPLhQbyq08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYUhF6dMa7HVzyL9UicTVzbdQ3D7YBQNKfjabGBHCHx4kDx+uLeCZPl2XvdWIiWuzWSoKa/fgGU9X3/kixmCNl6JLC/FokeNomZHgqIFufDX7135C5zbsVbYCbm/XHnibqRSyj2ZYFbvw0udbo7YoAo7zzG131yv+bq+UhlHlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+DfAR+v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2575680e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731052975; x=1731657775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUTRSMTXrdg5Zyft5yF6+XKivEJnOQQBelPLhQbyq08=;
        b=l+DfAR+vndpMxpYhRy8VqptIQ54GEpn0doEYqzMrkNzWPZp7yvYjMkl+You36tfCS5
         2/I4eX/bFpIwim37svG/08ymFcZyn2Zc87TS264R4lSW6VK35TqkVOUmd52d0a3aTdRW
         LKjOji39FRwBPTY6FVup3upq79VSYMTS3KA1T5fMk33soccfK6L2jPh2eXwZ44BJauyy
         P1E7IWOgZAZmrNk2tQWSxpvJDTzlGW0e8/CxrhrNW+W/S3KSauB0pd96uYz12xarJ8Ui
         ZlL2DHjOM4FXUMR2VIUFMaYoyZtUb+ugQAcUG7sTGUyMOUxXSSNreySONUUAY/NmNvTs
         k68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731052975; x=1731657775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUTRSMTXrdg5Zyft5yF6+XKivEJnOQQBelPLhQbyq08=;
        b=lRqg8F+sozeli6Nu2jRSbYPFGhSbpb8yJfqj4ddTz8UzhiSS6OCU8Hr9Gy69am5pp7
         0blzC5UL3fdrwiJ2eTSLTlRB/j83ne3vouFdFgCmANUIrNAw2R2Yr6So23lx4gz0Nn+c
         DBO0sNYnSmoNLF9XUlOL2hns8bZrYytxCBqD6XgjKZRaGWSLktrJB2A4unE6TKQRKHzb
         9RFkE29hhBAD9FIWZyM1C6BM5tBDVovSwHpTIOs1NVe+AdixhMcM7Gov53UoHKLpmxeg
         sVceBzYGl28k8sJxmsJwyMFuTEaPQl++g+FijdaS+vnLV49eDmbZEiFkbS7ST5J5QlvN
         cUgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Uw0RRYQqlVyigaZvQ+MP2bBdm1HDpFZ9eA3PDRVa4JbJSrbRTm0aqY7UOwgTmtgJQLEojC/8sFYE7+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXT3ZJn8BSJZgWo2OTsDIIWFizLtJtnOM5gcxFSJ2o+KxsSdFQ
	ywG/kClHdszPlTxMIL728RNajzciZs0dSMInXRsG4wHWhmF0DG+LymzTJ1Wfk4H8YD933RS/yyi
	0xrtz5OTPREhs2tYUPsYfecs9BdQaOQejpO+1Rj7/hn/fOxe1
X-Google-Smtp-Source: AGHT+IHU/p5ucmbmja2ZUVCS8fngsFc6zkmCp3xSAKppUYK59btpa33qjaOf6+2FVOvM6vBZDak2yrRRRPxlKbfHz7A=
X-Received: by 2002:a2e:9b96:0:b0:2fb:3881:35d5 with SMTP id
 38308e7fff4ca-2ff202ac3ebmr11214621fa.35.1731052975268; Fri, 08 Nov 2024
 00:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104194437.327430-1-robh@kernel.org>
In-Reply-To: <20241104194437.327430-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:02:44 +0100
Message-ID: <CACRpkdbiAKX-o3GYqVP5bz_o-GhbvgHLkSDM4ZMXgMMteaoKTg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_property_present() for non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 8:44=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Makes perfect sense.
Patch applied!

Yours,
Linus Walleij

