Return-Path: <linux-kernel+bounces-514736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C42A35AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5B83A282C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BAA25A2AD;
	Fri, 14 Feb 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/8soyW5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A43257420
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526985; cv=none; b=iBFQLBncVemmh2RsHfQGPfp8IGLZD0vp4M9hNgMLxh/cVns3zv/53l1W4fxhBlaZfOnAJs1tZu8JTBQGgXSNzrhAaDKVRGhagoCe0mRpQ47be76T+RsEmTqi7xUBmgBzIcXPOV1OC+wamsDUP+jnRcDujliUk7e4i3Qm5fbAcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526985; c=relaxed/simple;
	bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0TpEzVjEFXhyD21CN0z9elePztMtU7HFJCZX1cK/njE93dKdVz73KoYqDKsxgezYaVFFnfz+goaIJldhdGaOqU2NR5rPFhhHR7MreqBoKHkzzRIxItJeR+PgHfaiz/IZ60JLKM6xTmrFTAY/AGZr3A5kTHUggyFduaT7uFHyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/8soyW5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-545284eac3bso461602e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739526981; x=1740131781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
        b=y/8soyW5CwNUoYqNTFX6lyGU8Qk9Avts8muHSffQeW/9/dTMOKJKVOg7Qok88c2s1V
         5nw4+Yi/2I18rJ727ag4Cpn1hS+I4uomvGEziAnRkXTRLM+TwzH1xW8X/zNtUQj8n7u5
         5Tz6GLZ0MnZlJJzbTRuEkPYhz048KOmgTgh9QngV9W/q9Mb+/x8+/o1OwBAAmT5QWO6L
         njNdK+QjD0AnWIttmNTk+qYIn7Qr1H+5nK/B0DZdHW4CQMA8yeGHO4eMyFAikSFo4TN7
         bCdquKPd4jaOl6bjjCWt7qpw53/ipnoEJ/6xD33MAGBCd/Jfi2fmt8gbX6kdrWz2lT9h
         YBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526981; x=1740131781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AsCrWbVyGKPdXvfmBx4a9snB6Aw/WrgC/hdNdtKs30=;
        b=Z1nDe+AwVXXKV7GTWKCXNXb5U8alTvLjQXSFV6T4IT/0hZBqrZVUM2IqgUlKUVTPAR
         2zhyl3PSYwOv8ANtMZfTf1apw1gDh9rz221UIU+jgw2bL7qu0pXBgifcJoZv6V0hs5q1
         bPtIwPUNlcK2skB2T8NFJfF4ZVJl9okjv4lNgzdJc+qM6o4R+I8P9KRebZrTXLf/hw1r
         7wRQ2LO/dq5mWNnfq2DvOEmZtKJ/hKFdVD4sv6aNJAe5pv7y7pBJgvDG6oxfaARzlMMH
         FEuSQ8tR4rtfhP516/aK1Iwx4TMIUoDdyoBfXZDXxceWjoKgf+KC0Pv4ZrItdR9onEe5
         9EGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiRaFS/HWi6ViQOucIz9tt6cThJsRuflsoeph+eEwxkt1E9hmtVC9aG12Mrn9rd9LKXhIjUZzyMlokS2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qGfkIwqINxw2RIbVa5NL5rlVhlHSNTCOxNjIEDV7uf7hxG1J
	UBOUOOCKAy7xFqbbAyAvr39klS9hlUP9DZRQJTgRRfBSUp7lQvwbBw52pNFvS0FmzQ0lw7fFjrW
	ad39QQofIzf7zUeVD449KuFq1F7d8eK0jkhwa5Q==
X-Gm-Gg: ASbGncuByi8ESxYemzvaAosAB4gr2nKor2rKMZufet6H0DVRmiRAqo4/iHLsOzNNQ6s
	m9CglWbiYGZ+n0mJeIu7suxyMe2aMR7V3ksXU7m6rfd/1ZjW8fOjQ0BU4pX1boPBy0v+BBwB2
X-Google-Smtp-Source: AGHT+IGBcbrZEU3WtspasRr8y5DGBmF7RSzDcVPvB+A0GtrhyVirdFfGoibdROQWEv1N6aRSxdNWZYR6heUIRHTOP7E=
X-Received: by 2002:a05:6512:138f:b0:544:ead:e1d6 with SMTP id
 2adb3069b0e04-54518178efbmr3191247e87.38.1739526981311; Fri, 14 Feb 2025
 01:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
In-Reply-To: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:56:09 +0100
X-Gm-Features: AWEUYZmo1A8kyC_1nRo1MhdajxMnD6e7V4G-rNnAAebgBMCC6AkDlJN1o-MAiIs
Message-ID: <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
Subject: Re: [PATCH 00/14] gpiolib: indicate errors in value setters
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> The value setter callbacks (both for single and multiple lines) return
> void even though we have many types of controllers that can fail to set
> a line's value: i2c, SPI, USB, etc.

Yeah this is a remnant from the design that was done of gpiolib,
at the time (by David Brownell) assumed to be simple MMIO register
writes, so not much could go wrong there.

> This series proposes to start the process of converting the setters to
> returning int thus making it possible to propagate any errors to the
> user.

My worry is that this project will be another one that stalls at
85% completion (like with the eternal descriptor rewrite project)
but I guess the upside outweighs the downside, and I also trust
your proven grittiness so:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series +/- minor nitpicks I may send that I am sure
you would address anyway.

Yours,
Linus Walleij

