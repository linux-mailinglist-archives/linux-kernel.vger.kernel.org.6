Return-Path: <linux-kernel+bounces-384962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A029B30AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752E7282955
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6B1DC1A7;
	Mon, 28 Oct 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRgn8+Qd"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DE1DA2E0;
	Mon, 28 Oct 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119340; cv=none; b=ddef5CQKJaaH9iP6epJO5NHkZM8UKcp/6K0PO5LGDPyYk0sYQ3sUacR8ZSQNi/wVn/lDGFcBL8Maay8WxTQm9s3xEiIzhDeEH2N9fAZn06IKdze46B2IQ6JVSUst70VY0o7L8Mz5DZUhw8LldrgNT+hzY1PyxrYygCHdI3v06J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119340; c=relaxed/simple;
	bh=2z2vAZJSINxFgk04FZyyCBPQt6tnf3YvM+5pNdERrCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOGPh9xzE0/xUyTWTKi1iy9EvpAGhiHUx+0l/obl9w4MLzXdogzm26FMSk2R+JVFyeg0/LEzsSp5gUR6oW5247/1qRNXdY86SrJuY88HCEjCL5gYYAcH4f8ckXu1jEtN0qSn7VX5govFlbZoxX8vl22dhp+ApPJF2rwQWohNSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRgn8+Qd; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d18cdab29dso12999456d6.0;
        Mon, 28 Oct 2024 05:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119338; x=1730724138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPDTP6OcnSRUiLPs44+AfRECa7TiYhhPi6crVGIBcxE=;
        b=mRgn8+Qdi9pknUBFVxKjx3xsjIMKXWO5ZY7Fj9tV4BBlJQprmLl5nEqRCZYvlOGeoN
         WFVjmwItRjglEGqAKUK1WWaIRJLGBnJg8wOTmzfbU+fllfYvjf9QfUB/1aTYMmjyEbSU
         WjAPFjbz7bxuIaQHxB98azHcX0SwP46dPej6xUpZrSuwN7Tzbd8dRQfjECgtkxbdw7C3
         rGAmkV8XPd/9r/ZWrCC0pH3rj7bAGjom74iOjp1l4LBt+9UCuF/5qcU+FAHZReG9CWUg
         zsPfMkf38MaBVugaDkcfSrnVigggKN/cf3A/dYccbETDNzJOWu7kGhxiU2ukbdj32Hre
         6hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119338; x=1730724138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPDTP6OcnSRUiLPs44+AfRECa7TiYhhPi6crVGIBcxE=;
        b=phayPrGPVSUhLILQnW68F/LNaBvy1uh098LaBqlS0obYPIs0OD7eI59lAwnmp3cOnZ
         DNL3tPKmuMy49GKb1RrEdnqWMcSEhvzWkfkAw2iLxbBY62yLK+fNzA4+nIagY1rKgWFl
         UJH71Kc2BvQtg9k3N41dPUsMw0sBGlxLF/4WYYLW11pKQwIZnBMjIMT1QcBPSbQ1pvCl
         Q3LaKzVwUotid8XZis9w2/p/svQykZlXWNKPQ43rOHxjgd++0vf9Kp6CXC/q0yv2q7Vv
         yFQqLFJE5SrdNje4+22RjBDUsAyGo7MR3CJIm7UOAuHzx+mz9lbD1Er7a2nu9AHhX5DY
         RGsA==
X-Forwarded-Encrypted: i=1; AJvYcCUhsN9Gl0+umx47Jg8cWPO9uFmr9dtqW3oNBFFNVSJH2AJHRly4vD/vUdCb3lvVse0RgTJcMQ6PKf1hVBA=@vger.kernel.org, AJvYcCVL1NsMPwuYUMHHs2hN2lK2Bc07CxvxaE6UYP8KIisvR65bNnzJqAhs+q2pS4gGytB5jrZ4iUH6p/5D@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0luxNwDltb4rUvrgxicmSCu7e+E9D/fjaaCX2HcikzLUiIxZ
	v9rTfoM6IpRP0PlVkTVWXAh7mSVzs5TxHr5f9Q5r7zlReLa6sIjwkjR3OpiaU/Th+csjVJneldF
	pV06qvncRUq1Y82CKW43JKWvWO88=
X-Google-Smtp-Source: AGHT+IFu30iVXKwfWOcaOmTLg0tzryyCqD5zvDtTitfx78e0NqXH+jxdsHIG/Ij1k8Kyf7CVM6WHH5Ee3xjuLN4KbnA=
X-Received: by 2002:a05:6214:3292:b0:6cc:74e0:4fef with SMTP id
 6a1803df08f44-6d1856744efmr108892196d6.1.1730119337611; Mon, 28 Oct 2024
 05:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
 <20241026080535.444903-3-akinobu.mita@gmail.com> <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
In-Reply-To: <ijdk5uuurnfd2shnwwj2nm64bno6lmrhdyqp42pzjc3i2e5cyh@v5ljkrsgo6ac>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 28 Oct 2024 21:42:06 +0900
Message-ID: <CAC5umyitFp7oGR-eYXMVaS8bY1AGe3QwEuSPoEz3DxWwH=dUsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: pwm-fan: add
 retain-state-shutdown property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B410=E6=9C=8828=E6=97=A5(=E6=9C=88) 5:38 Krzysztof Kozlowski <kr=
zk@kernel.org>:
>
> On Sat, Oct 26, 2024 at 05:05:35PM +0900, Akinobu Mita wrote:
> > Document new retain-state-shutdown property.
> >
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Doc=
umentation/devicetree/bindings/hwmon/pwm-fan.yaml
> > index 4e5abf7580cc..86a069969e29 100644
> > --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
> > @@ -40,6 +40,10 @@ properties:
> >      maximum: 4
> >      default: 2
> >
> > +  retain-state-shutdown:
> > +    description: Retain the state of the PWM on shutdown.
>
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

Is this description okay?
(Reused the description of retain-state-shutdown in leds-gpio.yaml)

description:
  Retain the state of the PWM on shutdown. Useful in BMC systems, for
  example, when the BMC is rebooted while the host remains up, the fan
  will not stop.

