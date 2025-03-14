Return-Path: <linux-kernel+bounces-561212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C75A60ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444761892A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169891F418A;
	Fri, 14 Mar 2025 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jq0KWvbC"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E41F4192
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948097; cv=none; b=VMb3e8Tww8MoRY3fyNqop8E3ZDMh1KRI47BMoN3MjAnmSJHSaxzvA4lHcGZDWeeTFAwskVmI3IfdrrA6Wdjm2vmPn6gStfFCnz1Y18wOCOqjva9j7gJUaegfdFF2Ho/69ajjv+vvkyxMuCaBzPicYOAdwfG4XLTl1zNrPxqjXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948097; c=relaxed/simple;
	bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej88ZCiegXEsXkcCeOVzufq3hea6bQr2/UFmzYIpeSlJlV+L2F8Vi8sEHnrkUIKr0GLuX31nXRU6e/7wqW1F54ZY55+lJ9aH/7nF3DT0kQWABtg1G3qA/c72cNMf62XhPitv2K3LwhjZwPWSefMDFZGndlO+rwtilC95DYL4HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jq0KWvbC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso2033176e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948093; x=1742552893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
        b=Jq0KWvbC+RGapBxE/79RV0BIeD9VvGdw1Fpe1TB3FQiE3Mx7M1ug74I43skmk/ysed
         pW0eyKCVeuPLLFbAr8/7rZaVq+ypvWIqqp98ONbAm/K0er06k802QP0sKmwApc01jN5E
         LJkRPCM7GjMxbAZVdkkbB+WFpnQ3yeovdkzSGgBhRM8hxbnIqo7S1fIfuHXiO9Srwm6f
         0krXnLDsipucb1cr4hOpq8EflJ5+JkQWavCGVohox/GL31nKFJGEb3tY1JskSboySuXw
         evvwW11mE8FMNJVAwglnLWQuelsD1w2tLYtm1nHAHAZQlQ3gbq3yJ1khhhuBRD+qlb/f
         Bh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948093; x=1742552893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lhUJ6eiiWP9IJ/FYhzjbXh+LAJRJWyTLSUXs2Uq9+Y=;
        b=ooMsBMdc2qowZGQd2NRjoEjJ85LrSRZgDxDySTdL0RsNJgBv/lpF6yoI117MyFOmlS
         871jUQyzg2g+ebYoRWbMxN5v6ij+7lWjLcAM1Okgu8eWbOMUF4YUaS9vpeibiF8SFQaN
         uPn/1InsvrRsLAcFTL+JcrSwFgzP64GhU1wW4zc24RsqYLc8wmzNKwXKZAKdtjkS+ED8
         D1yNOCKL+jsdBz8cu5+RrIo8BSrqjEI1H9yggvCR+7wTBASyAb/6Ng9h0ZUjMNV32A5u
         yARkTv0+gf9cbhzzH+KZi/6frutuVIdhiFkCrpT8z3VfHEPbON1/GdU3hFs839h0K95w
         gJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGZH3RYEw7x7V1MPwz9wu+W82hbPY72YIkrQaS5f4ONVlEVhq4B7+7xE/2Q7Js4OhEm6EQIbYeTxmAk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPimRoC9DaWQnDrLH8qoO+lUs2IDwgUZ+2ZNqZTjvLnSWi7IJ
	2eS8wsyf9lbP4bqwLPd+L/FOKKlHM0F1xoeQCMzZVJGsI8DQQlHPZFYtvBKltCYEqTQTmchh4BX
	6mDxCBcukJvW65FUQxxuyya5iA6iACpKQngjpbw==
X-Gm-Gg: ASbGnctZHQEd0kKRBgxLq1zq0AnrTPurqPFwNEMqw+MD37g0V7dvaa6tRJncH5WKhuf
	vC0UcwX1cij9NVgXnKlYWvGIXIss+pyCHYO2o3tDpql7s8OQa3hNA4ybhbteuMyu7Wh8IHYMOm0
	+18r3zs4p9or/AsgzKw8+13Bs=
X-Google-Smtp-Source: AGHT+IEn/Zc2evX7ABWKYXK/Rs9IfMZdPR9tSjfOKy1a8kRLZcgdXcqx09hfLow4+l9JiJIqttYJQGRGb5b/H78iKJ8=
X-Received: by 2002:a05:6512:3087:b0:549:7330:6a5a with SMTP id
 2adb3069b0e04-549c3913d63mr621103e87.23.1741948093287; Fri, 14 Mar 2025
 03:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309193612.251929-1-linux@treblig.org> <20250309193612.251929-5-linux@treblig.org>
In-Reply-To: <20250309193612.251929-5-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:28:02 +0100
X-Gm-Features: AQ5f1Jo6nSq2AFqXUDepXvu8J8Xduf-drgRoP8FzPPUsiMaA2xVOQZlsv65trtc
Message-ID: <CACRpkdY2oZtu4vtTwHRMFxaoYWu3B5bfPN==thz=BT2F6BHQQw@mail.gmail.com>
Subject: Re: [PATCH 4/9] mfd: pcF50633-gpio: Remove
To: linux@treblig.org
Cc: arnd@arndb.de, lee@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@bootlin.com, 
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, brgl@bgdev.pl, 
	tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 8:36=E2=80=AFPM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
>
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

