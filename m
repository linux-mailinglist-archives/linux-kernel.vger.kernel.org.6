Return-Path: <linux-kernel+bounces-407640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8B9C7069
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0041F21EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC731DFD82;
	Wed, 13 Nov 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPZg/52t"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D11E4A9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503947; cv=none; b=oW+2Glbapcjivu1l0it6mQKcZ7ClA5g38PilXv/PLTuXTmYoKDlGTgiig2LKKG/4jNp15MAO63hPjT8t97NV8Zm1PNs/FG+Cv3soxl7IT6XW9STsiVN48zKBNMJC4DJeEpjL9rrj/hhnzr+t+EVhVG8rg9obRSaV/UP/9e61bgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503947; c=relaxed/simple;
	bh=yW187HMdqhX91+UVSPVQiglv99YzbI/8VU7veIuuY+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAATThjoh9+eSXtFX9jgKpx4uBzodFMp/vU+lvIXt4IdE0y51ohisYU7s5WU1EoScNb+qLxBfD3VsTi1QmgNd5fdUN96zgukMEJowMD9DuIwMv10V/TmqvvNuX1rO3ilTLkC2nLYoXExZrCW4a9dRZulcMQsTbZ6pBLOEMiIp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SPZg/52t; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so36088101fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731503944; x=1732108744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsPliL2Adhiej6IN3mvc/qYdmMZTmDs6ihxNty8s1sg=;
        b=SPZg/52tPMZdw63imNJiaclDxxXyRpCaXIyNkuJ3+0cBNYqOfdFjhBYw2ytoITRvVu
         HK4QX/PMMgoBckKPdkhB0d/E8OJu3JvPh4ntZUknIOQczkDI+MlHax1IhEsh4jv73Z30
         Rn0OgDUkPkt9b8wzaI6MCJz712MmekyPm0tDfmyjlCZ3oqxpgWkljWZRIz+e67e5EPNS
         HkANsEhgI9K/iMrhckI6B0dhzll564vHw2xaYmACX8CdxNoYZwesLBLBS/0nUuzysgVU
         SBbyCbdx2fk3ZaB6sYh5h12zZ4VpY9BlXMHsTatpqA+bMelABh/PWXgLXlo7zXR3zNdk
         V8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731503944; x=1732108744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsPliL2Adhiej6IN3mvc/qYdmMZTmDs6ihxNty8s1sg=;
        b=TN95+kBF9em1RPoR7t2r0C0sv/kTj/Nxq6MnN4Fk/ONWlUB66xrDg3SsaK2IanJgK9
         ioEoKKN3KryRY+hb6KU5pSpVKi7+rXUNeYXVs/6PVp6BW0rboMBE8ycnaonu56YGiSY0
         84kdwsjcrzUN04YTYAmknSMIrk2rSM/yMzi4bvCRd40WoywDJACsMW2KxejEJZ0rsqqs
         k5BWJre2vbp5LsgjPNqtOHZ5PtWvZRQDfkqfOK4tpnDQfUS85FmOLye3jEWK1JD9f6JZ
         zfH9TL8ZsPjSdeLPlkeGzAxFXPSGIMr8mmE+pbC3ma7434A9Gw6JwXQjNoLmuJiMBKMi
         ryrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2f/NFs3CDi6eIrMO1QXszKHKUO+k7seHCrXcr2A6oZS1ICOFWuc+G2CVR7MPUaoBGcb/JppNAp100q7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gj68uGD14l75GKJMwfo/h/6t3MvOOHw9bnBC4YWXC7pY6kCn
	BT8sa4HXwNFTEkThggPf+8JuLLvBhUEX+se/kmxWtpZOnVoxyPzV8k2dQ4gmCTi79VNvrrTqO4d
	El3czYoLFiJrKsmTE0WOrQbK0uEjtSPd3xZb5Lg==
X-Google-Smtp-Source: AGHT+IH1Ezhe06hECeOAxkOJw8qhjLAtYUad08jXgtHDzXnvnn/CQgHXruYF2NTQM2STEiYtOjqCE3guD2io6f+uqcw=
X-Received: by 2002:a05:651c:1145:b0:2fb:6198:d22b with SMTP id
 38308e7fff4ca-2ff20185968mr83746331fa.17.1731503943562; Wed, 13 Nov 2024
 05:19:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110210040.18918-1-andy.shevchenko@gmail.com>
In-Reply-To: <20241110210040.18918-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 14:18:52 +0100
Message-ID: <CACRpkdbDq4zCwGcTzH-51_2=ucc7we=8P1GAzq3mypezjwsR+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] pinctrl: cy8c95x0: A portion of cleanups
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 10:00=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> A portion of ad-hoc cleanups to the driver. Saves a few dozens of LoCs.
>
> Andy Shevchenko (6):
>   pinctrl: cy8c95x0: Use 2-argument strscpy()
>   pinctrl: cy8c95x0: switch to using devm_regulator_get_enable()
>   pinctrl: cy8c95x0: use flexible sleeping in reset function
>   pinctrl: cy8c95x0: Use temporary variable for struct device
>   pinctrl: cy8c95x0: embed iterator to the for-loop
>   pinctrl: cy8c95x0: remove unneeded goto labels

I really like the patches so I merged them so we get some rotation in
linux-next.

Thanks Andy!

Yours,
Linus Walleij

