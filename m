Return-Path: <linux-kernel+bounces-230670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6C918046
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F7FB233DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BFA1802DF;
	Wed, 26 Jun 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7MzysBI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6817FACE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402839; cv=none; b=j3i2oAzKKCx8sZuHAmsknO0V5+utPnFlLzv7+rZ51qGvNkJ5CoyzzMU/dSIvLhFFR09UPYWQTwt3UozRUrESIyPCler1uXuOvFwExcRv7TfxNK7drZX9O1j4gxh4NY1iKi6S4kfXURYTiB+7Hvlf6O8hPJ9ss6JmXTQeLZveL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402839; c=relaxed/simple;
	bh=t4QnQiAAvKS4rt9+w5OINOMssi64SFHO6cDlDm4yBRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvsT7Y3lJhGVjJ7VPf2/6kjx+BltDZJvBqmhWCK4fQDFCDqwcqHA22lGQoent1SdB9uN2jUbEjtMv2GveYrM+05ZQaaDX4gnJj3uMJKOB06yLv4ykxyUH893RrX0NwvUjCOa8e95De891Rbf+3OCDO8CO15HNvnP59f6BoXFUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7MzysBI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd8897c73so5489432e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402836; x=1720007636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4QnQiAAvKS4rt9+w5OINOMssi64SFHO6cDlDm4yBRM=;
        b=Z7MzysBIO35fPlQ3y4WF8omYoXMvdMqCx9APq80vkLyeug6M3jRguoa4/o0pya2FsQ
         jIheL0Ywr8RSR3+ziLyOy3gH3/sypkPG2oFw86/ZcFEQzcZCt5mLUJVYQnrYblXGJoUH
         RotHINvv1inuaeT0gxg/+xzV2IrQaEXmQTW7Kqs1M9KSUMv99IGQkmKdZy4hbLNecqms
         TD+tZN1YrSwoPmzr6/T8xaw8ghKkROi45mBFDhXVVS0qQAMkTB63Mr/meamWxyDg9RR0
         1B52+mqwK8W/NTxVSPpxYtR4x2XRKJGTWjub4k//CX3onckOld+qaPLrJe0Lvd1uBJvv
         hxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402836; x=1720007636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4QnQiAAvKS4rt9+w5OINOMssi64SFHO6cDlDm4yBRM=;
        b=NqRIkavDZK2fLF9ts/c4Df/kx1jtyjWt4Upm3dF8NtNiyp4UcUQ1JvZITrQHfzF6b0
         n/V4rI3Yb3UEyRn5Ebzjbxciq2BRkPBW3EtvStdqyUVKM66kUosqPji/1WqprkoyxSUv
         KcFnPrqVwx+adLuPuUJJnZxEeAffVp1KfNf0RylnN4YPRjHxtpOAdeKc9RlJC1Eo7/PG
         yh44dkgtDsPXZy3o8hfb72bD6wpZSQZ/04XisA4eKvT27lDXgp37IfTrPh3PjYiym3Bs
         pDAyAaKsG6MoPiDoWXszeaGk7ktxQ+MaRAYIGz8NtU163Ve1wxkUBzm+2hLIoWl8mZrp
         /zbA==
X-Forwarded-Encrypted: i=1; AJvYcCWNRoDGq8V3vEdn62AYlw2e9yiDfmhO24yXdCeTPsCfPfCx/Wh1FUt1J+WqhxwxFUp8Lwl7GS8D636bTH5i5bazloVmqVvlIwFvjiVH
X-Gm-Message-State: AOJu0YwoGMFdcHmSBam9GlByrtZ6PhpLRVZYR7tB8bXmnR5WbyUqWp+j
	zAgwBpMa6B9NehnUy9afSBIskXCFEDrevP/PdcSLnpwqnD66AxePxBDdYlrgpOQbUckXA3m6xN1
	cEa2p2ktW9VDozYsPxImY7hYSFzx18BNSCVREQQ==
X-Google-Smtp-Source: AGHT+IHfgQa2jdl41DM6WUs5TR/l+YzB0+Zt+uOHmxpLnkmqfkC8JZfrxv9WacloodOw0FsYNj3nJp5iaAX+hw9hdnM=
X-Received: by 2002:a05:6512:3a8b:b0:52c:e402:4dc1 with SMTP id
 2adb3069b0e04-52ce4024e00mr7078665e87.55.1719402835840; Wed, 26 Jun 2024
 04:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-mbly-olb-v3-0-5f29f8ca289c@bootlin.com> <20240620-mbly-olb-v3-3-5f29f8ca289c@bootlin.com>
In-Reply-To: <20240620-mbly-olb-v3-3-5f29f8ca289c@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:53:43 +0200
Message-ID: <CACRpkdYLz3vMbft8dh_=dqd-yB+YUsbP2jbHBXGnUPZq49Mrug@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] Revert "dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings"
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:31=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Switch from one sub-node per functionality in the system-controller to a
> single node representing the entire OLB instance. This is the
> recommended approach for controllers handling many different
> functionalities; it is a single controller and should be represented by
> a single devicetree node.
>
> The pinctrl bindings is removed and all properties will be described by:
> soc/mobileye/mobileye,eyeq5-olb.yaml
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

