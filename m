Return-Path: <linux-kernel+bounces-423890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539C9DADEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8181B22674
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E1202F89;
	Wed, 27 Nov 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe3Vtqbm"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33949202F82
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736187; cv=none; b=sXN2yLdtiv19MeWWt9q8+KXvCWN0ARyqglckfzGlfd9GPPwph3g/LASjZlfgbuek04pji+NzEEbZ1TQYEslhjCoZcj9xApeETDXZ4s5BXqhQ5leW+KtpKMupPWx72WgUP0/KpY45igsf6y0KVtq0B4/REqQ5km7g7Mj6331ax5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736187; c=relaxed/simple;
	bh=oKtZKcmXb2M6spKPqMefrmKou8p8fKIrTlFjEhi5x+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgeOr3ImJo+XKwq7AtzxPsJGBZAqxCm4m5dzTiNYkehesbsQ2PF4afdtDZW3ZsfLVfek48jEprHTOxHMKQhyKqcQQVewEYPuoLA4VDKMos4ssww0U0dUl/OIyoavAt2hupuDuQrGDRGNSU+hIJGUek6m3tOQKmKB7LmGMakmMsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe3Vtqbm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so890441fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732736184; x=1733340984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKtZKcmXb2M6spKPqMefrmKou8p8fKIrTlFjEhi5x+Q=;
        b=Pe3VtqbmuJC7efp8ulABu3cSWCGp8PGmjxISI/eFBAsjczjKNYof+HQq/5oXN/U/RV
         dTML6A+EWa9BmdPK32/oLrZ2aXjR9csT0rnGVmWuxmsUAN4xFARiOqws5GTsj3TotEJm
         y6wYf6AiL0T0aoMXWwjT5avDmzMcJUlLSYzzAeKWYdwOaGySKsjPlbaO4x8xOxG2N1zq
         8Fv5uiWTkK0bCdmBGCLr2tmufnTFxD5zAeojAOAvaCCxsj50DwBUT5tO/K6IJ2frffTo
         oOOTX8RE/ipyGysXRGMDrGZuHBAfkALuh9+QJuXHt3Lg7E/yUnLgZTvsY24EhT8QztsH
         TrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732736184; x=1733340984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKtZKcmXb2M6spKPqMefrmKou8p8fKIrTlFjEhi5x+Q=;
        b=o/7g3BqpUpGpKDv3QD219KYjTEq22fAh072XKwquR+eelQPDilcf7FvCD+CBqvJgHT
         a6oFle3AIw+bgSFtN0TQHqMa/VEhNp4On/6HAI6ctUcirR0bSEEYw/7Vwr1hOQ0TbBlP
         nIN8Hp99rMYI4Smp46TIlKsOhkeBMc2HLwpFC1ct1zLYGSd4KszgdhBE//i2H1KKOr2Q
         VMbWyV0zVU5X7YgPDIpQFM4gniCjMyO1Ex99FtQcCJMvPmgsHoW3Tg/MHOw259hEkCnD
         gxXlKdTkF6FI/r30P0SelZ6gUfyDSIElx8+hy+NkwmwTDpwmgMyZmVvDKxr2zj95TmtB
         IsFA==
X-Forwarded-Encrypted: i=1; AJvYcCV1i6D+ByS8X8NOoGWgNe5HIcIuqfHy1hNNpYaEVNxkMkPR0LzPWfHr7G13ioeq5tv1vSNQbFOVsblj290=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cUHKBiZDxWzeRcrG0UpahfF0VJnOzoDGToEntgtzHOppPakj
	JuB6/BdLdI4HUNX9I0jxt/r/q00SX+iWeaVcwxG2/fDYvkNOxR374+rAiOM2Xz5ObDFi/jNlSyj
	0SXduSzLg0SA7ltRrJ9knbjpd+QQ=
X-Gm-Gg: ASbGncsRYFyNsmGGBn264fbd7Idmk6ehQna3m52Sw92SGFT3mzE4kGV6JMiO5a14cV6
	LCsSMOW5Q5G5HrDGwe8OKL/fP6M1YWjGj/egJwderyOCo3SuyYUb4fJvvEf1rzg==
X-Google-Smtp-Source: AGHT+IFPeS8nF9rsPbtVwAeT0yJgfR0bmbDXQw0nAIv58Wn7uVNgUUVKZ7ZtSZ3kSyKequY0RNGC6L25fA0S8ZLitnQ=
X-Received: by 2002:a05:651c:2119:b0:2ff:a8dc:6fb8 with SMTP id
 38308e7fff4ca-2ffd5fcc1f1mr40204551fa.8.1732736184044; Wed, 27 Nov 2024
 11:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-imx-pinctrl-enable-v1-1-d3431a98253b@kernel.org>
In-Reply-To: <20241127-imx-pinctrl-enable-v1-1-d3431a98253b@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Nov 2024 16:36:12 -0300
Message-ID: <CAOMZO5CbgmGpJvurf0Ctomj5dDOt=dC5X8XvwaqsM9Ce_uXhUQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_*_defconfig: Fix i.MX pinctrl enablement
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Esben Haabendal <esben@geanix.com>, 
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:25=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> When the i.MX pinctrl drivers were made user controllable by 17d210018914
> ("ARM: imx: Allow user to disable pinctrl") the select of pinctrl by the
> arch code was removed. This change means that for the i.MX specific
> defconfigs nothing enables the base PINCTRL Kconfig and things that depen=
d
> on it (eg, audio on the i.MX6 UDOO boards) stop working. Explicitly enabl=
e
> PINCTRL in these configs to restore functionality with them.
>
> Fixes: 17d210018914 ("ARM: imx: Allow user to disable pinctrl")
> Signed-off-by: Mark Brown <broonie@kernel.org>

I submitted the same fix:

https://lore.kernel.org/imx/d718ddd2-d473-4455-b21a-15024e46787c@roeck-us.n=
et/T/#mc71dc21d99e0b013c5ce46c0d90940fd8806ae9a

but as Guenter pointed out, there are other defconfigs that select
ARCH_MXC, so this change is incomplete.

It will also cause regressions for people that have their own
defconfigs (where PINCTRL is not selected).

Then I came up with a v2 that simply re-select PINCTRL as a minimal
fix for the regressions:

https://lore.kernel.org/linux-arm-kernel/f65d65b3-b60c-4c5c-a002-81370821ee=
1f@app.fastmail.com/T/#u

