Return-Path: <linux-kernel+bounces-299250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B695D200
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584831C20CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9506185E4E;
	Fri, 23 Aug 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxuRE89G"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287A1885A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428093; cv=none; b=NL0v8fL3uS4KgnKdhOLjyPvJFfRO653VBKrw2F0mFuF5wtv2ZQt5JBzb0Sh7LOHL2/sypUtPXnUALkyjbVq0CixCO73R+3xuB2edDuaUJRybLteohmUPbPNprkyYzE+xSItyqOBBmeX43C/MU1eVz0PKgClcuAQsNEwufYbihH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428093; c=relaxed/simple;
	bh=LmPjT004Pu+b0lGXNhjt9mxzluLGxiZs+Qgq47unh9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4IQKonBM2Uvf9rfvlHTQL1EgmxltCVutylXnbns7WVPE/WoKyhThNrP6jKMBp5q0bgXefZKGDowVWGZ2irisU0KF2LBLuI3S5MRARRoRS1gA6CsUMGW3K9ET4DNI7QBv4iAN9tJJWAaOIZEQdSeXeceArhfjnKGOyxZQKNxevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OxuRE89G; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso2698878e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428089; x=1725032889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmPjT004Pu+b0lGXNhjt9mxzluLGxiZs+Qgq47unh9M=;
        b=OxuRE89GlU3SEWYQpWlwh5UrcHuh/xEyEGicpZHNvWmbW5BSSEgMNh72jWOMPtEPlq
         tQXi/9JvQTugSgUDmnjHvzE89vWSyu6VLEFxC1tvEyVDvcSe+WfckfHd/J/N8djZaw4Y
         h0g1CJx60joy5/ERAqNPmbHldffa77rSI4Obj+4pIGGseW4jB2gIxHZAD+ZljUzfRXOq
         p7A6w0oFKMdqJVVamEsv/K0Zgb1B92j7by1HCC+ZyR80iOp5rQsQq89h070t4F6E3IeN
         cv7nales0LHYXO22IGLgZKtt6+vwh7nWaCNCnrnfRiIBjqCMiMCQYeDlUX+1gtDbmlks
         i1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428089; x=1725032889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmPjT004Pu+b0lGXNhjt9mxzluLGxiZs+Qgq47unh9M=;
        b=mHj7w9Gistkswl37L+bo+a98AQYMfrVV4pVDeu9qx5KUBHLAqm5jlHeOYvn46c7WBU
         SmLyL81CFXa9HKtwalmFYrNMnsxJUc48FisG7vxAiHj72PpFReRWujHVLhzJG9ZoRnSh
         oAqUCEA94StTLnPbctDp7dy5i8psyRNcWnYEZCgIF2x/8RSLOUuIFLHb9M3dlJyz8Aj/
         rFzee9Lro3U9js8F7X2Kca8PClGi0V9Vn22HVXiM8cskL6N3GnRBsbc2adAX2WOtkJWN
         X9YsFpwS20L4pGsFkxoPd4uWzIQgaBdZrZHu84bbhjqdmN60yTulsC6eux0jAwImJ3Yq
         6qQg==
X-Gm-Message-State: AOJu0Yyy0P6aeCF7SNTQZrVf0kVHGLGHeo4HI3XWA1KJI5+9ELoPVA7c
	6gFqEOInGij/wn3qRyGvJ4Zb9iCntjIsrJRJu7wHQGVE4gMi2sVrVJ0BwjZCfKxC0t++6kLKvCO
	HWX0as02ctqqAMYIivAmG3Csozs/gMUxnWpYY4w==
X-Google-Smtp-Source: AGHT+IGPIsPltYDrMbENTRG8ZR5qzvz5WC80feYuFQqeN6sGzjfgHPtnsMGj6lpcAU4PIZVuuR1kVHhNrtGIoL9x7eA=
X-Received: by 2002:a05:6512:4016:b0:533:ad6:8119 with SMTP id
 2adb3069b0e04-534387786e0mr2117298e87.14.1724428089108; Fri, 23 Aug 2024
 08:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822195706.920567-1-detlev.casanova@collabora.com>
In-Reply-To: <20240822195706.920567-1-detlev.casanova@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:47:58 +0200
Message-ID: <CACRpkdZW+g4_szvMhuYXFHCjoekYKdux8s9u6zXkhDSDuF_i1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add pinctrl support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shresth Prasad <shresthprasad7@gmail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:57=E2=80=AFPM Detlev Casanova
<detlev.casanova@collabora.com> wrote:

> Add support for the pinctrl core on the rk3576 SoC.
> The patch from downstream has been rebased.
>
> The grf driver is added support for the rk3576 default values:
> - enable i3c weakpull SW control
> - disable jtag on sdmmc IO lines
>
> Changes since v3:
> - Set GRF bits through the GRF driver
> - Drop the rockchip,sys-grf phandle

Patches 3 & 4 applied to the pinctrl tree!

Thanks,
Linus Walleij

