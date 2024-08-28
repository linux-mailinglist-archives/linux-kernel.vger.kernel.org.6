Return-Path: <linux-kernel+bounces-305386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99B962DED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699072831E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB61A4B9F;
	Wed, 28 Aug 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h46HjnUh"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED8381B1;
	Wed, 28 Aug 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864109; cv=none; b=JjKDGxDoIxG64yf6iaB+oBDSQG5Nqp9ESAfQqMLcQjUXVNy1bdO+PTrp16kiLQPJyQKylOCv8jWde/txjDUjpV1N62SXCsEdNd9IRF0oeb88tlCUI+L1Mq1U+8De59E6M31TqxGmw2V8AxkRkfH9Qhqs5Lxlqzh180EhAi5xsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864109; c=relaxed/simple;
	bh=LlGCdn4gmS9vKqDqzx5PG7X13gnoxDt95fVagGj41nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgwHHsBBxhvGaC/MZ1aaRaVN4tWcRhA6SP/TjjZIWIBRXXlI9eM4ZQxeTfOrttCLDvj5CaJy9mi6CLVaju34y8Xmdj9XyHb3wsnwiapbcTJCHot+Wa/rekENjviiPWBB1KR9nSOeRaq0YLTl/mW0NtzTCeJk3OJS4F9AcOJpuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h46HjnUh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso83788731fa.2;
        Wed, 28 Aug 2024 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724864106; x=1725468906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzLCaerU2ulUqAzKqCghZCU7wS5Z6un4oXuuL2wHZDY=;
        b=h46HjnUhgGq3eh/6TjX+saCMI9SKdM/WIPzfKP8ROBJAqNOpCQbP7fg0Wx7k/NS9Rs
         fTJzYq7Su8aR4PgW5UDT2esZwgpakj8qSKxHoOGtnPCfAhXAIIQGVLclNXxgk5R6trI+
         4kLMIIcEYr801G4MLrX8oiRqk7+0OzTwortTmNE6CLSRnHGf8J00ntnK24zY2jM/m3YU
         Ks2GF4wVEHy9jtV0VGRjGIWRr3LEcmhW2n1/9bkQKpy0CZBSGGgke3JFMTp+mzCuVZq1
         2thgGpOTgQ4QbX3XvRy2EdYq08ooEWxRhj1/HA3tNVJbKNwxoxldPceB+8X3XrxEIigI
         hFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864106; x=1725468906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzLCaerU2ulUqAzKqCghZCU7wS5Z6un4oXuuL2wHZDY=;
        b=p78glJ0VQMAvUJEsuaqsPKppcwP1TXdgNpd9GVtXccCuWrv47Ei01lgLGLCQsklITd
         UXVHutTBDxMn9gZbMd8Sb3G1dV+iA1NcF3QGhH75W8ddpHtSTkc1tjy5SjIXpG4yBkbf
         ae0rq5gliwysPcL2JzND9m4lxd32A/OJll3xP6xMXvXrLU15uiGo7ECHza4gKjTfvl9n
         +y12GnwItgazb20h8n+s4HYSLES/U/qaGfRkr9Vp1IQTPQa5v8KHiljeekWJHLPFTcRY
         jxZoxLwThOfxE+LBXXh9q3W71LcDoQx2pXF9w/Ia1GWMW38+Sbjj/7pG/jJdd3x6AhsV
         Eb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVx1UI3x+DMj+hcjYnTHMj3AofMMUoYkNNmG+WRtWlJdoowneEcJrQOhft8DtixylWREuHELScB+5/vMROM@vger.kernel.org, AJvYcCXyKBcZZkS+D4JqMguNf5veQSdHTPY/pJ7zABPpeExwU8ru4aSy5ERxnfF0bB5gu28UB5Tulsn8Ec8S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gl4NlNRc+SlR5J8wTqhdbuGib+K71uhqQv0ZQzzfaIjhEb17
	ehlN+FPVakCXhKljG+HJ56VBdEMzedNYmSSi3Y8gBY5tkyHd/dpEtToae9BuMELo3LmxX9y517I
	zH+4sQ8ZqRvCkLepdIMyrEASMO2+klspM
X-Google-Smtp-Source: AGHT+IFszjTy0HBztUxAkiVJbnS9m4A3Y0CgrHfUgDP3LEjN5Dj948b/bGuRY8jMqphFrbvurqJt7mw9kw+accWCagY=
X-Received: by 2002:a05:651c:2112:b0:2f5:7ed:abb0 with SMTP id
 38308e7fff4ca-2f61070787emr2913281fa.26.1724864105650; Wed, 28 Aug 2024
 09:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828112139.2665814-1-lukma@denx.de>
In-Reply-To: <20240828112139.2665814-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Aug 2024 13:54:54 -0300
Message-ID: <CAOMZO5BOCOuf9t5uH1TfcWyoi-ECrw=3HztRVVXi0WR4K6EqZA@mail.gmail.com>
Subject: Re: [PATCH] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Aug 28, 2024 at 8:21=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
>
> New, btt3.dtsi has been added to embrace common DTS properties for
> different HW revisions for this device.
>
> As a result - changes introduced in btt3-[012].dts are minimal.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/nxp/mxs/Makefile   |   3 +
>  arch/arm/boot/dts/nxp/mxs/btt3-0.dts |  12 +
>  arch/arm/boot/dts/nxp/mxs/btt3-1.dts |   8 +
>  arch/arm/boot/dts/nxp/mxs/btt3-2.dts |  12 +
>  arch/arm/boot/dts/nxp/mxs/btt3.dtsi  | 320 +++++++++++++++++++++++++++

All the i.MX devicetrees start with the SoC name.

What about naming them imx28-btt3-0.dts, imx28-btt3-1.dts and so on?

