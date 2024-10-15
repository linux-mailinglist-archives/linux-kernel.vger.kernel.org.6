Return-Path: <linux-kernel+bounces-366792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4C99FA79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3F1F239F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBE1B0F0F;
	Tue, 15 Oct 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot/bE0Go"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285241B0F0C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028609; cv=none; b=g/dBN89XMgEugIsqb+2OZFkNWJx6AjtsIA9BU23l3b0AUGrNRtf021GqOsxRv+lJJeGeG1NzO03m7gNsYhGWiy6f76DAhlEjNQRypOm3r7PaTZmRtQllQG4GQI3CgF7Y713uLopJKC0ngxBG46EBwp+RW7m940du9MLSdvFFBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028609; c=relaxed/simple;
	bh=UAocfkXQ1RPqdmiQZbBlkDnEJNGgmKJGrcniPmvnozU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZGzLJE+cZ52J8JsLspHuvyVl9nfQDk49HJkErtvpZdQ/jFg3IAkF0XjXB/jxS4s8zPHgSfMu6uNMvA0W0/VMSh+RMvikZ0GD80A0u1WasWJe8/FjoqtN/zLYkCBpdxJ+Fuok0SIirqel0mbjXmmKML3+hqh+PwhRL32x9lfcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot/bE0Go; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso54411291fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729028605; x=1729633405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAocfkXQ1RPqdmiQZbBlkDnEJNGgmKJGrcniPmvnozU=;
        b=Ot/bE0Go5eP5XQv3yg5dMccCo4KdHIwNNjOt+uGel3jve6jwnDknml+NR1v9RtQhxr
         7A1c43Z6XKjDsUx8fniAAo64dtcGrBHBAz7wtvA8JSBDnErTYUpQFvD/USolHSqxII3r
         wnbHb4TITh9Wru+WRSJ/1IC51LwKTxqQgAdzgQxKZfj4IUrL7L1tc+rLgsG7/r73UBBB
         CJUJUFfsXNAlzp/u5ySMjZXPQrGLX5JeSB45+KUaPp4O1gyyB/pkybYdRB2aEfBM4TGr
         t0S6QMWNKb17KfoRyA/77Wok6NkmB26eXrt34///DQdz/bMt2w3B/piaFYrWmE5/L/mb
         P/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028605; x=1729633405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAocfkXQ1RPqdmiQZbBlkDnEJNGgmKJGrcniPmvnozU=;
        b=A3PQNxdW81h2obb6FINkuHPYlhG4qY+l17T57uMFUXL17BJj0hDWzgavh5B3YvX/iu
         m+6Gn9nFweoO3SsTE5AiAA8/nnqrg9P75VYLn0y5WgircOFwN14vkFktG1qAzQp+FvGe
         CyU+ilUTTqvs5B4y9vqDKfdIVdvUh6aJMxeI5arQtT/lpJd9urMa3ZXEmmQrIJe3UMwf
         v1PPrVW/cAuDE5NQmcuk8+g+3tYgeBQH+xoG3Mmsw8H2RSDtSbboUkDJo2w6VK6q7OTi
         SnOECKd3wRWhKi3uIWvgHp2ooKCOamWCXDu6rh2KTxs8Rs+fCb3lb00DoXC3vTbgsLNE
         oR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiJjpJI6ZnrshL7uhviUicaDAXaejgBCAffIzqhu4Esx/N0EddTumIYd7hY9JictlCBYpBoym2Pp4Yei4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwz6qQxuZl2QUbPlbWQ1CswmqOXsEHDXJEcbT422yJ4K5Iybyv
	1RAb77Fku50a7hivDD0/Is8tNfRt0+SbkEvIrSJ+hGB1IrAfEjY8ySDCu4Q/LqFCxa52KbAWEnz
	9v+si0wyFrFCetDNgSgjIgyi0LOL+M88ie1CFJw==
X-Google-Smtp-Source: AGHT+IHcFZjjWlAFiGgDJy1iCFs9nmgUCYhCnPRRLVYBx8tgkTIO5wjNRXsFMThYHYMpQBvlpgTUbBolK0yS7+ZfOGE=
X-Received: by 2002:a2e:b892:0:b0:2fa:d354:1435 with SMTP id
 38308e7fff4ca-2fb325d4154mr75684441fa.0.1729028605199; Tue, 15 Oct 2024
 14:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015162043.254517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241015162043.254517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 23:43:14 +0200
Message-ID: <CACRpkdbYF5WCy7yc3t6VSU8CK-MKpxQnVWmRE-YCSKJ1hJDkug@mail.gmail.com>
Subject: Re: [RFC PATCH] pinctrl: pinmux: Introduce API to check if a pin is requested
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

thanks for your patch!

On Tue, Oct 15, 2024 at 6:21=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:


> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce `pin_requestesd` API to check if a pin is currently requested.

What kind of function name is this?

Do you mean

pin_requested()?

> This API allows pinctrl drivers to verify whether a pin is requested or
> not by checking if the pin is owned by either `gpio_owner` or `mux_owner`=
.

There is nothing wrong with the patch as such, but it needs to be
illustrated by submitting it together with the first intended user
and show how it is used, we don't add upfront APIs.

Yours,
Linus Walleij

