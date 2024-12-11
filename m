Return-Path: <linux-kernel+bounces-441510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C749ECF73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6487816616F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2051A4E9D;
	Wed, 11 Dec 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HmJYUxy4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAA139CFF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929986; cv=none; b=Ed7jhnBFKOHe7HN2iABs9oIBX9MO2DsJ5qy/qUMCjuAcs/npEY2abqW9m2hrRXnqZtygV/3NgMVV5Y9PUGQnwj9ghK2X2hu7ejqr9lMhfyOjt6YFVNLiPCt3vpYNRNBuxnGLH9SYJhd5QznkOH7pDzHRcxloTId1KviUK5IyWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929986; c=relaxed/simple;
	bh=Ida9K9R8M/eaxDjCcpy5xMIip2V7SZvxCRqxCUBEADY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGeNROUi0mJgmRbxaBDCsfviOzSUyUfMwr5nFzCwyLZYbNzg1n4uaLAVAy4iDtfJbRkMsJXHD9vUT4MT0uML8UHxOXoHTALHJxIgtSGRb485zBC5pBJoqUue1aZ6uSN241cEmyYkoRNn4yyOYPmeVavCptgrmTKJ9aFclmLwHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HmJYUxy4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so843595e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733929982; x=1734534782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpf6MN4Rww7TiJcGNQaPz3mB5lzUzQDMBTu0stTBwrQ=;
        b=HmJYUxy4QnggwmEGXGCthODcfkjL8vRUE1he+oY3948aS9jlWP6NTFUDxoFvZPLBJW
         BvaQE096TzJa2UQuujdOq0d6tCIi06Gj2obyfwoiwBNMR3UrkAnJfrI7DPTUQikbgM/W
         HORe8YUrDtnzBILhK/cx0GOr6+47azUtWDeztYb0N/cIZsiXV6/pQGsY+vqCgg8UNQTf
         FV/DX76/f4hjdDL5hyNCG15gj2DIy5jxEvyZayJLYwQg05eoNuxOE3A6MhXV0RKuyBfO
         5FXWaLARsFIUWqNRQubYyrPI0tfQ5uUCDFj/Hq5D1fKgZRBgUXxFvWi4stS4yL8yPD3a
         N2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929982; x=1734534782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpf6MN4Rww7TiJcGNQaPz3mB5lzUzQDMBTu0stTBwrQ=;
        b=uJ3KOncAVT04ZpxM5k5cj+svZc1wxtENF4cZ5CIbKZwSf5AiQaYTXR9LYlCZgdDoI/
         3VZ2FwFiV8QW5/2xIqu+uTvyD3QUWYTmrfne8HY3/k+U+AAaGnfFcob3rkBftPDj1pRJ
         0bVqeY43sE8boS7CmuQVJEc/QEJ2CMonFL53y+8nb4er1uY0vv/+cb5Qf+5bpJbSVQsp
         ryUZAKGMHgp39AJxgfnJAZ1RAFtEKGUEL7rQ3Ic0QDXHy7ajkjYgl2Nu0Ain6eqpA5dR
         pnAjMEIw1TN70QubXuDVVLSlWMOPFOCO/rQoGOr2IbGm49HOR3D3zoZfIcKuhcoh91n6
         eWPw==
X-Forwarded-Encrypted: i=1; AJvYcCUEoEp5QNKVFaUMoJwTThK6MKEkrvPOsrJaI9bL4Ii/dYMDK/jl/zC94/pXk6XhWEtApc4WAmGxzG9UENk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEc5UxU35yITRjI+aegxTufoEW+fZGYK0Vec5wL/cdMIT3hSJ
	JPuIWDaQ4rnFj5TQZ92mi53tegEjWgmCtT5I1zjEcazPne6HTIUhsF4bYvxgB4DPNyyjMphABi7
	AkbtLHSUHdm6gbW1QntfG4HUgGRMCG24r8JEFZNMWZ7IUxDhU
X-Gm-Gg: ASbGncugKvHqxnZ7kTqkJ+nOKs2NysO+De5jtFg6aYQcqw6Bsa3xpIrMPNFJL342rsE
	Akj0FCdjYvDTpqjzh2+le+YKBR8Dz4QkftYMQ+ltI5uYeh3dYmJodOhmNREEwoSkmT9I=
X-Google-Smtp-Source: AGHT+IH+Jy4Uk21qsc5YzWudoL6hjyjthNl7P9QvDhnQSipuCMSu21KcIdlDiOTA3wmwamf4aliqsuP+gFUib7QtVts=
X-Received: by 2002:a05:6512:68b:b0:540:1bd0:347a with SMTP id
 2adb3069b0e04-5402a783b95mr1075836e87.26.1733929982528; Wed, 11 Dec 2024
 07:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733739697.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <cover.1733739697.git.matthias.schiffer@ew.tq-group.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 16:12:51 +0100
Message-ID: <CAMRc=Mcw-r3b_a0XmpfVbF04MuZYnmM05AZqGav8GA_PM0-ozA@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpio-tqmx86: cleanup + changing directions
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux@ew.tq-group.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:36=E2=80=AFAM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> This is the first of two series adding new features to the gpio-tqmx86
> driver. The first 3 patches are cleanup/preparation and the last patch
> adds support for changing the directions of GPIOs.
>
> Once this is merged, the final series will add support for new TQMx86
> variants (SMARC and COM-HPC) that feature up to 14 GPIOs and full IRQ
> support on all lines.
>

It's not like this series is very big, what stops you from posting the
entire thing right away? It would probably add more context to this
series.

Bart

>
> Matthias Schiffer (4):
>   gpio: tqmx86: add macros for interrupt configuration
>   gpio: tqmx86: consistently refer to IRQs by hwirq numbers
>   gpio: tqmx86: introduce tqmx86_gpio_clrsetbits() helper
>   gpio: tqmx86: add support for changing GPIO directions
>
>  drivers/gpio/gpio-tqmx86.c | 135 +++++++++++++++++++++++--------------
>  1 file changed, 84 insertions(+), 51 deletions(-)
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> https://www.tq-group.com/
>

