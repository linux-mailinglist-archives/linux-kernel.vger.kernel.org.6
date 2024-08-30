Return-Path: <linux-kernel+bounces-308739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374F966119
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AB282580
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A0199FBB;
	Fri, 30 Aug 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K43oIYq+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9119994F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018970; cv=none; b=UxNF+2cUgrz7vOz8ggvk1tZZaeWDwNmTVV7ux38H0ZqGGh/dHHZD81XbVrSE87r/Iojx0zQCraHAj2T2QOPfQrixD3FttVDliyfSn0c946HUPjsT/eEAXr5dGCCuujm12H0U+d2kK1E0l91TieUvLv/Es9GN9PD3Z8YyBdNjIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018970; c=relaxed/simple;
	bh=g0qYXdweblof+d4zDg0csLIusMtS4NAWZKZItJ2G/hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfS0uTuh+lXHcxr0aJxazuTHQa/nW7jmL3LZEuqLH0ImHiWuHqOWv2qhp/29eCp8Fwar+00RE4tkI0dAId266h8V/oVBUs/1QgXFIQwfPLVF4vT3GpTSq/MMyXP6rSMplqjJgWh2Lscyn5M6SpXMbLDiczuT8nqon8vmcpm02sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K43oIYq+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so1776261e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725018966; x=1725623766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0qYXdweblof+d4zDg0csLIusMtS4NAWZKZItJ2G/hc=;
        b=K43oIYq+FfJsFMjjg5nndElG68IoSrOuMZfmij8JKMRBPCWwF01IcrT84A+YIo3jm4
         BpvWUIRwcUWArmtoSe0+gnKFWUwqr1HIuumvXij+o4iVGlaynYi46eIjiVM3c1+RRkp0
         +cvN8jg+YJ02k1FUPxLWoFLVl43N+4YL/4PDwKVmERdIbWcFtmlOiTcISsi3t8LqlxDP
         xi5ZHwBhmclBybHUPbRlL7fhq9lAX4a+TNWuWFx7Q9ZVIcKwc2IzURSayZjzDEmXB6xP
         gT2jne04hMh8eANrGD0KIpZfFDt8csdqJ9FkBF+ABRok0J3zjvx5XC8f2gYuuuXmu4N8
         az5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725018966; x=1725623766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0qYXdweblof+d4zDg0csLIusMtS4NAWZKZItJ2G/hc=;
        b=WpZWiH1AnhLgGxeGE/MHUDf/MFA66UZlIczx1n93erKuCOejEEg561v+43Dq2Ujzm0
         g7HesqzXHJWGXfUbZd7rqG3tsjv8T9k4f0Y+5C+xfcpcNvr7NSbb/iPsBy+uDw4rtweb
         odmmEtecOzOtvpWabMHhPYcb5DDgday0upy/koBYJoBcrVageKrtQQSDK+yLAGwJQh38
         zUrv+PANLlWJI9FwQHgKXfONxi0ebhMM3QFk0jcXdHpm33PvIlPH1eGq3GYCinbevfSM
         w1DZHK1vxrAHBbYUTEISuRQFPjzVID8WNJv/vP83U5rsSHvU7ttBUVL5PKx3pwU+LSRi
         Mtvw==
X-Forwarded-Encrypted: i=1; AJvYcCU9kzBwyZiQK44u1Ol6UFGKbTiJq+z0uxIbmH0dtJeZsxUarA7SU2RJyIGJtmgo912PvRQxq6ST/c1RToQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71tDSTlQiv1ktqB6qrFVh5rD7dtUxoqvIr+gce7BgLJrJ5hl6
	wIBrl0LQZZJ3BBGUcWwf1zeXF8IcqLX9YuqftMEXry/3pW05+pG8IZ74xCgrCJ1kEYbwbWeWs9a
	B9tEwaAU9CQQdzeTKrlRSr0aqM0yum1UeIGyBcx1e3pci4RFi
X-Google-Smtp-Source: AGHT+IEhVXXIgwo/6ASpdFFF5AZjaTOeKyyZK0GOqTEt+wGYPxxNJSILIeAnEbT6DYaa/jQlNjiZpOVwSqoK7dzPOr4=
X-Received: by 2002:a05:6512:e94:b0:533:483f:9563 with SMTP id
 2adb3069b0e04-53546b8d711mr1185811e87.45.1725018965745; Fri, 30 Aug 2024
 04:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814061315.112564-1-manikandan.m@microchip.com>
 <20240814061315.112564-5-manikandan.m@microchip.com> <275606ea-2740-471c-b998-353ab6808591@tuxon.dev>
In-Reply-To: <275606ea-2740-471c-b998-353ab6808591@tuxon.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Aug 2024 13:55:54 +0200
Message-ID: <CACRpkdZbGqy+z+JoMoMXt0jmCCjuHUVj0q6p7QS1VBAKby57sA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: pinctrl: Convert Atmel PIO3 pinctrl
 to json-schema
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 4:35=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 14.08.2024 09:13, Manikandan Muralidharan wrote:
> > Convert Atmel PIO3 pinctrl binding document to DT schema format
> > json-schema.
> >
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> Applied to at91-dt, thanks!
>
> Hi, Linus,
>
> I took your Acked-by as an OK to apply this to at91-dt. Let me know if I
> should revert it.

No problem, as long as it merges just go ahead.

Yours,
Linus Walleij

