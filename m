Return-Path: <linux-kernel+bounces-544270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D40A4DF86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36200189C75D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A9204689;
	Tue,  4 Mar 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XsnQUsgS"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FD2045A6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095801; cv=none; b=UvMhrt4n1zd47zzjLEwGm0P5u6AteYeOoKgOdGomHjnHKfKNQeSQKUyzdkzYgr5obooOdK71mAIImH2sZG+hSyfU6qarPT5yl3OiHwI5HocvztmKs2wo5t95WvQGfImvjmRFN8lXYrJXzyD1SSqrmqKRnB6utw/RlBD7InBlWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095801; c=relaxed/simple;
	bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp6WayzVUA3J+xy5eu52hPDpZqgcg7OzPfRIswSliWyrVJMwTZpTEExyYV4Gwe8hhP99xGHW5idBh9l6e9fzEMWs+IvmHURKITyIoDUWC1QeD9ImV7H+rwW1+N2HzDMvFIS0X/wpwEqfcMeUxU5d/n2xLRXoEB+zT/plDBeAWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XsnQUsgS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548430564d9so5981740e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741095797; x=1741700597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
        b=XsnQUsgSWo4iPO/7DEA6P6yo1Vd8HfWDljiu7o+GWXt/lAC1/RanTa9riq6LJye4uu
         6XAntWQ0EUvhPkp7FPaJy9I4i7qGNksgjVqXIo0Ivs97pHsZxkUiqRR8J9e2JIPWDkEs
         ty+TehVPr1yoX2Bs4EAsZTMstv9cIi/gtqnLGZ3CWQpRFFXJN4UHWyViK9GgsGPmZ2ME
         LemNwzL5DBbeRqVM16UZVpzMAJbPLnmdXlaXFXaVeSMHjNKJjog2YuV+dPOVr4J9uEiA
         jO+r3Sptp+AgpfMM2+iRc/AyHcfIl+6m30SaAEWPIGU0JcxkRIRDUS8GmwiIibjDur6X
         0n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095797; x=1741700597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
        b=DC8oNlzSDLowqyHP86Unl4nZvhR3lNXXSXIV3bPpON4sxlgKqrGFfSAvypnUrhRTi9
         MB/7AFC/QOar0ZLfJtcfGkOdrzS0L5KF1vYecUMR6+Eu16FZ9gYKYpuM98GN5DIu5oe1
         mYmZ4wXLn+qryHgfzSkBxbLm2vM018rRHMt5IViJ0/mu5b5yScZJ3IfSaZzcz06qJKrH
         HIXXUkbdZLx6XlxR93n9yXCcErEQjb6xRmNId8SEDujtz4lu/sa+76qivEUsOKjw6mfo
         G6jvgXPobEtUyhyePj5sC3jueQxMF8ESN6wqy3denxeuO5L9+N8/TAzg+EfeyvNwipN9
         OLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8xNRnWjTgRphv1a0Fl3pclyw2AzuI9uM1570G2W0nO3rHvBn8fTGNxC0MxA5M/n1IqtsHBNqQ9kCB4FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+7xhTOdDKVxpt+s6QwfBezS8jDYZx4hTKr1tMbxf/gHlBe3U
	wSIDBJ5zeCnIvph0mMvK8Q/x/ZcYD8rfuMvIfORhstydJfALnuB9eoozUsYfwB72lDC2KXBSOVf
	nX5r3KmunoWKwvBTFBVe06erppNtsJl69j2EjCw==
X-Gm-Gg: ASbGnctxmzE+WOeP3boFRH/EFeJLJDJ/2Zcj1OoCyYoxkQu4dPzk8bxlDAbBn68oUXW
	NZ5bCbbuqmPBao+xgRBGhmKtnlwapKO4uBzfaYvqS0FO4KNumgUwIXQ0RiIccilZVQcTGXr7x2E
	cKLrMDcSCdsLq8nvQ/qcpkeOjg6nWYmEzPQEa9v/ruZ+lfLehgkZGk5lBPnQ==
X-Google-Smtp-Source: AGHT+IFWh03wXh64Ao3HRMlhJCKQLtqt910EoDBcwZtN1H8wHZ6DUI6QiDtsoKY7O3tRh80hbzaOHl+pKFDQV/B60Os=
X-Received: by 2002:a05:6512:2398:b0:545:a5e:b4ef with SMTP id
 2adb3069b0e04-5494c31ca37mr7947524e87.16.1741095797400; Tue, 04 Mar 2025
 05:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com> <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com> <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
 <20250304113135.GK3713119@black.fi.intel.com> <Z8brYjfL1yj_BvpN@smile.fi.intel.com>
 <CAMRc=MfsKc+r=uhDZVbd_BW=Gs1BpaidPC1tfF6TGqcq9bgP6Q@mail.gmail.com> <Z8cCQPWBmJXFgKAe@smile.fi.intel.com>
In-Reply-To: <Z8cCQPWBmJXFgKAe@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Mar 2025 14:43:05 +0100
X-Gm-Features: AQ5f1JpqX_GHUguz2RwObiRuAUFX8DZ0DsNPbeLxo7WFuOXHLfYuwvzPP9w3pks
Message-ID: <CAMRc=McQY1r-Ni4buuvhD8DP6LGz22PAxk_QC9ENYBEzYTc+7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> >
> > I'm definitely in favor of consolidation instead of renaming to
> > gpiod_go_set_debounce(). If anything a better name would be:
> > gpiod_set_debounce_nocheck() to indicate the actual functionality.
> >
> > How about first extending gpio_set_config_with_argument() to take a
> > boolean "optional" argument and removing
> > gpio_set_config_with_argument_optional() altogether? Both are internal
> > to drivers/gpio/ so it would have no effect on consumers.
>
> Consider this series as a report then, I am not going to spend time on it=
.
> Thank you for the review.
>

No worries. I applied patch 1/3. 3/3 doesn't apply on its own so feel
free to resend it if you still want it.

Bartosz

