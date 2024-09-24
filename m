Return-Path: <linux-kernel+bounces-336703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBF983F97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AA1F241C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA0126C15;
	Tue, 24 Sep 2024 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5zsaygw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BE1803A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163947; cv=none; b=R2Y96ie8aWf11LCxEksNF+C8uk+B8DEJnNv68aGWowWHhO2b33KOAr9JDLHbdwFktSxFqxlqUp5ZFJ6u5pcxeIwY7bPRLv7s5Af8IAsqvTc/3rmc3ABICjGiybwgfi87+r0FhwjuY5iqmEgtGk1s4UI8xRVcntbAND+AhsjmrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163947; c=relaxed/simple;
	bh=MqhA2gxS9MTxmqX69mbrOYHAL9N8LKtrtunB9LWCxLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quJpjiXpxQwJQ72t88iVu2l4YE9DrTW0cP7cF+kWRJNfmQNojq3Nys1l1E6v8aJtOY3JwXpdRpdOd+TxjYSsvEdLyWHQ8Zuz83qj0sjYYRkNr5anqSmItxwlNfRkq964p/s24z0ociNe67nmRToON5/aCuBC+ZuLgqtFhk1t1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5zsaygw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-535694d67eeso5359365e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727163943; x=1727768743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqhA2gxS9MTxmqX69mbrOYHAL9N8LKtrtunB9LWCxLw=;
        b=v5zsaygw55t6J8yCFDIQpwzyIClLUVNB5Um1Gsxzf1Yn0/QnuCne9JF5yOTK/7q6ns
         ESf8b+0GbBTUAV/NQd2QCRZJAb+Mk2dY/aQPHYX64q9jnb982/GLiXhZ0xVstNPZq0Bd
         5wK0+RoMcoc7Ixb1C9shlMA1jDybIHos+39UVR6OLCEG6D6wn4YcZzom40P27fd3l2Vu
         8Ryoz6RNesjihCKyPeF/p0BIJ73rHX2PkLTYCEqNjgFfjEPCFbiuu67ySj6pl4iiMLEN
         zWUl2Ftte31xs9Pg9MfYdLZiJdhZKGDKABFnzQ/DixyDu6L+0S6Ao6QuR2QlgBJiQSTq
         wTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163943; x=1727768743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqhA2gxS9MTxmqX69mbrOYHAL9N8LKtrtunB9LWCxLw=;
        b=vOEGIfjvSe1BgM9otjQFA2scIn451hMs+6Ac/lVrPYT6zCZ7tPhUK3MAfJP348QyQ2
         lloOyeFw62ced+ngQVe/CaZ46yzeIN5qO7HacJjjqDpHJRQP0xvdvlH3gLgMuRYCK+MV
         QE6p+uLh6yAmqB4vqroYePKhTFEwvOIGSNUFdJHA18IBgekQzLiMNIRUhu3No3FxxXZ0
         W4w82lwHXxqBASXPSgg+my0gZJK4Qj51aF1gi6OCvWI/m7TY52h1q7GZjoR59BF6RzlN
         cn7tIIAfairv+FEl1k7VCda3z0Lditmo6XlQHYh8yHbQMJeO2tHWcFuizKjnVDI+bR1V
         TW0g==
X-Forwarded-Encrypted: i=1; AJvYcCVi5G864n0ezpijdtcir3zAwKM4o6RcFTh+6Y6VqjAHuFkRqAvXm8gVaSSbu0TYLsxzVeWRRVLtwaWKukY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+QZJNJMOPncfE8H9BSf1BCM5/pO5oZ9ETM2Sm4YJQ8NQ1GJ6
	boAqvJqKoPwlTZU1BXBYLkoJ44eh83M+A1uHrbsVb/lZ5lrLeK4VuTYrDb6KxcCHx4AUqm8h4eE
	rawuUnXsWaoMqzXhhrIkysLXE5IFNhqiZyel0LA==
X-Google-Smtp-Source: AGHT+IFSnhi2g8RCS4Pf7Wrz3+5o1CeBJkl9cOue8TFxLcfAoHEaLB+jSarR5GR30yYmfSCZziuzfKQojHEPSL+b7Q8=
X-Received: by 2002:a05:6512:1150:b0:533:1d4:546d with SMTP id
 2adb3069b0e04-537a651ac4amr734820e87.7.1727163943165; Tue, 24 Sep 2024
 00:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-imx-pinctrl-optional-v2-0-bdff75085156@geanix.com> <20240506-imx-pinctrl-optional-v2-1-bdff75085156@geanix.com>
In-Reply-To: <20240506-imx-pinctrl-optional-v2-1-bdff75085156@geanix.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Sep 2024 09:45:32 +0200
Message-ID: <CACRpkdaW14PgLXTRPHUjaLNKfCMRs+hpHrYyMiNaqSs+m0rhqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx: Allow user to disable pinctrl
To: Esben Haabendal <esben@geanix.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:24=E2=80=AFPM Esben Haabendal <esben@geanix.com> =
wrote:

> Making pinctrl drivers and subsequently the pinctrl framework
> user-controllable, allows building a kernel without this.
> While in many (most) cases, this could make the system unbootable, it
> does allow building smaller kernels for those situations where picntrl
> is not needed.
>
> One such situation is when building a kernel for NXP LS1021A systems,
> which does not have run-time controllable pinctrl, so pinctrl framework
> and drivers are 100% dead-weight.
>
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this needs to be merged through the SoC tree.

Yours,
Linus Walleij

