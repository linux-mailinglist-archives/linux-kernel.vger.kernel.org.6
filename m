Return-Path: <linux-kernel+bounces-300077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC095DE7B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4C1C210F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC417A595;
	Sat, 24 Aug 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDMTk9dN"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5868F62
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510433; cv=none; b=EiJRwmOW3gr8QevCRcOQZREhVVoRfQPcYTa7hOEghu/Ws+qekuASCQ/u9Zodck9PmCHbv1PLzQ4Kw1L8+kqdQO0YZ0OX7ElZnTmfsSFKEfYYn+SULlfEUEIjcBnzDi5oSvAWXX3UcPs6I0VnkS+U7s5oy/kN60tNHq7RPJ7shHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510433; c=relaxed/simple;
	bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+8UlMABbN84GzGU15kG5d7t7OKkGmjbnDHUKN5v0LhBunmWc/40jWHxSz9jf6pMQdSVCgNql5lzGSjPbXfG9nIW+D7xoYSnPb0ne6bAO/SvpaJdtxTFxeKNbFLYKdH08xsVpgHXY6Jv/UYnsiZQKlfjWO1h9NssoB/A6zGU2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDMTk9dN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2187520e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510430; x=1725115230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
        b=QDMTk9dNOUy0+i8YYeYxAOhm2q3fWfLYizvZUngq8S02sjpKAIumowxwQQ725rgXzL
         VRb515NEiF/W67k/y8/jF4UHYo4+e22XcW9bUwRIRsXexC+06QXfL7w/DOw8daCXPfS2
         sE0YNMZFJzRP9+52+adbO3cQTkab4SxLymLA/cVd6ThiswP2Fm4suqtEze4CUFchFXFg
         3+g2yu41sTN18vx08KOh9gDv6VXJaLsDT9hurr0jURKFsnwz9b9cv+3fgrXH7ZGLyU2j
         0u0oRnvnXZ77IP1ajyZHhNZqYlHePvG8+9nyH7FKDUKjnK8LPH8Lo+xPpvWF93t7qQBc
         qCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510430; x=1725115230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+00aPqAIJfQiLjQyOBdsrvt8KcSjON06jxPta54+9s=;
        b=PMnFQHpOodlDAVmN8GzWhwskRFQDXnitULp6w2PbixN3Xx4+2SGsqnk3p4zP+iZWXt
         ISS+8vp5uAqWD4aTtexPOfkmhKE+FKilJwXbGqPliFL6YR7G/xN+FxoFuWTG+J2LIgUB
         qE4eNCIxRD+xnwaQpyxsZ2LmsZY4Hg3eow9dNIZPIOXx6C5gOXEIvv7kkdVsAMcX2O+u
         8UdBsZJbEYwFGyWyhAidR/9YV332oeRO/vv5a+/4wTEY0tfVu7wX8d3ha9xEO2QAkox1
         dkFAoH82ybqs/+jVj8by6qe2r5mHtLO+fLEDUeirWhgSzfgm5pbUTkPA0fyGOw9s+lmi
         AxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw3Dws4KqayJx3oeOU8qBshyo7rJ0oMNvw1MErx9SZTLfskLE+saLl5+bg4hAp3ZolhCuI6dUs7N0o+Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzuf1j40VfDAjOplkPbC2cnvjjFGZ8M+X5qavcVSkJytaxoCBT
	VO8kIbZcrN1rcPxvpzCMypiwlw7y+cz1Nbvy2XJG5f5rK93zlBvS53UQcbBNe1/0F5ZhLBofErY
	V6snqAAMWy+b4OGdo5wptkrqN+hnqrdh+w4Dn3g==
X-Google-Smtp-Source: AGHT+IFUWwNU4JjKJfUkk5+b7VaNM9tcGLgDxOphG4oT66UVqnMDc84a+SVvS7/Tom2C/L+hvh4W6uCE9zsb/aWB89Q=
X-Received: by 2002:a05:6512:230a:b0:533:4560:48b7 with SMTP id
 2adb3069b0e04-53438783ff4mr3214329e87.30.1724510429403; Sat, 24 Aug 2024
 07:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709105428.1176375-1-i@eh5.me>
In-Reply-To: <20240709105428.1176375-1-i@eh5.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:40:18 +0200
Message-ID: <CACRpkdaekcM-rGNzczQFFwDcte8cR2D=j6LB9h5W1XRbBtBhJg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rockchip: correct RK3328 iomux width flag for
 GPIO2-B pins
To: Huang-Huang Bao <i@eh5.me>
Cc: Heiko Stuebner <heiko@sntech.de>, Richard Kojedzinszky <richard@kojedz.in>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:55=E2=80=AFPM Huang-Huang Bao <i@eh5.me> wrote:

> The base iomux offsets for each GPIO pin line are accumulatively
> calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
> If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
> IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
> bytes, otherwise it would increase by 4 bytes.
>
> Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
> into 4 bytes space with write mask, it actually take 8 bytes width for
> whole GPIO2-B line.
>
> Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
> GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
> iomux offset for line after GPIO2-B to be calculated wrong. Fix the
> iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
> correctly increased by 8, matching the actual width of GPIO2-B iomux.
>
> Fixes: e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2=
-B pins")
> Cc: stable@vger.kernel.org
> Reported-by: Richard Kojedzinszky <richard@kojedz.in>
> Closes: https://lore.kernel.org/linux-rockchip/4f29b743202397d60edfb3c725=
537415@kojedz.in/
> Tested-by: Richard Kojedzinszky <richard@kojedz.in>
> Signed-off-by: Huang-Huang Bao <i@eh5.me>

Patch applied for fixes!

Yours,
Linus Walleij

