Return-Path: <linux-kernel+bounces-561263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB10A60F70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C171B6330A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A01FDA6A;
	Fri, 14 Mar 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVX0aRkv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348331FCFDF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949771; cv=none; b=eVA+YQ9e6AToxWVsIMQOXJKEynApQiD2ODDpp/1cVm9X3E0wwnt70GqLpxEwzBiBBdHMZmgIa13Vr1bZVLrKwgDDzFf9+s+BVbc4FuQ55I6KPq/MwQvuSSS5SZvU2S1LhXSo88eqZmKz8KguDRAkYkWC0w79vDil/LtvYTxZ++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949771; c=relaxed/simple;
	bh=6x5r7ZlOvAteRywsjJfA0j4CTDLQAoLtsYBmgsz/cWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX8C2XXPfOU1oJ9g1qOW2PZzz2OIESkSHmVRNPcnqFc2ualwjUw4e+zvGqINX6XSCJreInSzr2TYxTqLMnEum7tymUycM5r9+zJu0645wFaQfjkKH7XXXnvFZ1MLu4kZcH5/9w09wGe0EygE+nh1q2UjYcoMo7u//LlJlW8LE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVX0aRkv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2234752e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741949767; x=1742554567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6x5r7ZlOvAteRywsjJfA0j4CTDLQAoLtsYBmgsz/cWw=;
        b=ZVX0aRkvyxuSl6ssRUd/aoEagEeVG5Nh/ydmyvs0jqw3K+nvJ3cCFbyuK307zr1WAm
         BpvOPqxEYQMP2yLU+mWDMtELg6rh6V9Hn5WAXkzuTgS5Y1z7MuO5i0Sh0lGymeTXLfGj
         L6D64hPRcAIXOL332qkkAHrOG2SmQ2SSC1hJNCPQxuyfMa54VtA+XrZK/SqCNIittspv
         2Nm9Ljw8Qq67IKoLyU8o7B9TToScEsR74PiE/4ECnzYwLAyh6XcTskblC9+jOGzJ86TH
         lcNEWbOEnIFs6eZCDJIORYC1b9HyqxHEF4IE5HlIgMsLMCTXEo5H0w/QLPl/1vrZ661z
         +W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949767; x=1742554567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6x5r7ZlOvAteRywsjJfA0j4CTDLQAoLtsYBmgsz/cWw=;
        b=Xg9dh/T0if/QRS5HOIZunfXhqPa4lrwtycBfjYRg7GXN38UkkW3sRLVH7nqQqP5ASR
         Wkm6EPPzi9PifnTLgQH2/rUwnE6774Jdj64L7r/eBPCn5wpZl+Yu+N+Io05eVWmY3bdH
         hin6Ix37hMkAGvgrscpl67XCv+u7PGDOWIEvD2jmxPOiibVL7vAAV0MjwL0Fd6VjtcKg
         4ftuwe+ePKqwzQFS9lMjAqZAuANotxso62pIXkj+s9BT+lwKXFdaFkMl2S4jy8w3ul0B
         ToGE+LrNdcmB5YZpmFfeRL+EXwaOtn0l3jgKMIs9p+bLVz3zsi4nPxceCwZ3EtacaIQj
         iGFw==
X-Gm-Message-State: AOJu0Ywm0sGwgMInilLF5RpcRTfMxwxcHP0uPxrL3n+3uZDJxuYB6qwY
	xFsWrQHcHRfJIuft7NdFFL3GTM8yyLrdFaXKSyrLi7Jde+kMj5IhYdibqCz5IC0UIlM1tH+UK1X
	gHh2NfOtT8RZl27d/ReCVZMvR0fLxZpJO9tMOMA==
X-Gm-Gg: ASbGnct4rNnCb/u1Rq3NPzPpPwmGFWlSMdh/sj2T2oZ3AuJ80VQQmB7fL0jRaOErQZy
	Y5N7FZ5rvxCLeBaHIK73AGJI2feo20qVYAghAIQlO4+4s2X0d5UbUcmY/wDCjBO2vsOwQrXEhhJ
	9FXDpoAYuSghrWMj644790SFo=
X-Google-Smtp-Source: AGHT+IEZEVK3le3TkgARlKdYz3SXwZoSNp/7fg1Zl9pfZrMp7mKUuipb156H1aMKQilFkyMHYWNIgWnOjr8y8yBFNDo=
X-Received: by 2002:a05:6512:118a:b0:549:8fc0:bc1c with SMTP id
 2adb3069b0e04-549c3989e9fmr580063e87.53.1741949767320; Fri, 14 Mar 2025
 03:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313142404.896902416@linutronix.de> <20250313142524.073826193@linutronix.de>
In-Reply-To: <20250313142524.073826193@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:55:55 +0100
X-Gm-Features: AQ5f1JrLpxUFKx-xgc9VbeDD_vSJUrqf0AM8XBuTGc_UTfcBcdhjz3OhObIP09w
Message-ID: <CACRpkdYb5wPx18Y06CKzbqS0CS6KLkN+9YAun5XEXYfjj+c0uw@mail.gmail.com>
Subject: Re: [patch 2/7] genirq/generic-chip: Convert core code to lock guards
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Talel Shenhar <talel@amazon.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:31=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:

> Replace the irq_gc_lock/unlock() pairs with guards. There is no point to
> implement a guard wrapper for them as they just wrap around raw_spin_lock=
*().
>
> Switch the other lock instances in the core code to guards as well.
>
> Conversion was done with Coccinelle plus manual fixups.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

