Return-Path: <linux-kernel+bounces-310992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DF9683AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9DB24167
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFD1D2F72;
	Mon,  2 Sep 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ch8SYlDd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C61D2F76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270707; cv=none; b=Dqjo8MCXsLIE20PWqCMxZw6fShnvRET9m7SEdB8bcVVK72wb1GedwF1xuuu4aPCEL4CbCujHFd9C46fATVsm/1jNwdy57/zEC9nqxrqCkwT8tTESHIxs0akJ+8aCJWJ1BOVMdOKjSSx4edVoHhcMgTcEkkimyFtQYMGKvF+akbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270707; c=relaxed/simple;
	bh=qmsZkQ4ZxF52i7LYuHENnEzSp1FV0CuFPl/eYLGnvZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP7P1nrSQfppA3YXPF24d/gdipK8XwJ0leLtu8SFBa6mAn+8+SsbhVw5zAk2Zw2uwesw4On8zcEfe/EMlfW73QquLujlTyOVBPGQy9Q+g+yzRhFMsdxY7jXtDl5iItHz0yAuZkk4GbTK6HMrcGrkNeFvqV6RofoshOWS3PuDQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ch8SYlDd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53351642021so4258248e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725270704; x=1725875504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmsZkQ4ZxF52i7LYuHENnEzSp1FV0CuFPl/eYLGnvZU=;
        b=ch8SYlDdm9MZk4v20v7MEqra30612bwDcCE1/0Fj/Bf3AgTUXrvvw7uHKQzzMr7Pcn
         oTq13O9npfg/d+RS7IQKjKdISAeFK9nwATgb6mCi6tZ+HkyYYfiF3vqHlcIESvR9f5H1
         GI5dauRTCHNGN/jP68usq8BvUPCwHrCPgxqXis82VBpKGz5HT9gK3PytBfALo1af0xZ/
         Jl0/ORGxlCX6ZL6vgz/gqNP4WLUoMQVC0Z8cFzbFRCeovkVWnzJGHYu9viAz5eaqbpzt
         RQehNmyn+YmeFvPAUYyCCxyptYzaNIzg6CEEYsYgBJZTgIZJtAVWhUZ808i8bqqU1Myw
         J2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270704; x=1725875504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmsZkQ4ZxF52i7LYuHENnEzSp1FV0CuFPl/eYLGnvZU=;
        b=qLBWwZ1ciw29v+2gwtCIHXcECg51TR8BoE2V+IzDCFHkbzgSONBXMz439Htar+k0YW
         uU8a//QUMH0fJYPx7jOEdvQPmbR0iFlDlHAJuvXhiS0vKB8TN1DK4WzkPSAlTMtmQs6c
         aRtZu0bN3ysNnIlPK+xZKbgm+Q/39fB3kTTdJqyJuWai9HGqk1adsJx707aZdLOLqaPl
         CNReCLhtLEX4bUQGmcugcWRZS7iJ1D8M+CpW8T+a8ecAOzOrSF6VY03HdUa9zv7bJCzq
         xOFbF/Z+7Gc9wyn/2t3Mr4AMQ+sjTNA8ZRuT9w9edzZ0VubI9IZHDrPNZ6FqeKDEZRIH
         QTCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6wZIMrvLOBxHjcoafrP2FtJkGKzQoBxhMISETxnc8BTS4pnSHV+8equ8y1hcNAfygWYttyt9rGl8amZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGhtfKdH19H+8wMaNhmbtFSEi1rjHRcFlz+OstQI4oyfrFv0M8
	gxp4wkXNP1CB1d8PNYR14xkKus9+YtmBk+5cfKQMkH7Cych45Z0sfbmYWs07LQiFVjhqTI8MO/q
	GUudca7wgPIQOt6GliyjvZVTpvOY3CgZ56vM23g==
X-Google-Smtp-Source: AGHT+IFqfLvZ8mKMDJqoWKL8m+Uh85ScKbEqg+TuVzZr1GdHMS+OsFqDlasVBn+Gh/2ybEBwe2mEjcHCj8mZ6Tu9m+4=
X-Received: by 2002:a05:6512:68c:b0:530:c1fb:51a1 with SMTP id
 2adb3069b0e04-53546aff14dmr6365059e87.17.1725270703170; Mon, 02 Sep 2024
 02:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org>
 <20240828-dt-bindings-gpio-hog-v1-2-63b83e47d804@linaro.org>
 <CACRpkdZzF5yJQnnDsjU8cTr9Fpe7wZZXoW3K-wFYuAq2vv8XxA@mail.gmail.com> <CAMRc=Mcv9nfiG7N-ttS_A=Ay-5Wv2mYpT+41G1u8G4GrMQAuEA@mail.gmail.com>
In-Reply-To: <CAMRc=Mcv9nfiG7N-ttS_A=Ay-5Wv2mYpT+41G1u8G4GrMQAuEA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 11:51:32 +0200
Message-ID: <CAMRc=Md9+pmiDSzjhNXBOzZeBLCemvxCzFMAyfFH_Qi329jG9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: qcom: add missing type to GPIO hogs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:50=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Sat, Aug 31, 2024 at 12:32=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > On Wed, Aug 28, 2024 at 11:36=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >
> > > GPIO hog nodes should define type, otherwise "dummy-hog" boolean
> > > properties would be allowed.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I suppose it's best of Bartosz applies this to the GPIO tree with
> > the rest of the series?
> >
> > Yours,
> > Linus Walleij
>
> Ah, I picked up the GPIO changes separately. No problem, I'll pick
> this one up as well.
>
> Bart

Nope, I cannot, this doesn't apply to the GPIO tree.

Bart

