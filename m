Return-Path: <linux-kernel+bounces-189404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3A8CEF85
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80A281A70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4899259154;
	Sat, 25 May 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9iLSHSk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EB5914C
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648783; cv=none; b=KbVubEuSwiHVvDYoijwJ5x+RDU4igkhk9uWaHUrqPKhIU5ReUNVMyHm7ijiWNThD/Pa4UueFwZ5fjhqlmVWXpKDqj4eGftLsl74aB8TczfkL1i7GQ30vK+kL1RSMlxa88ztKlUSFffILyYJhMVT8UW3oYgnDrjvqIYHSqMQGggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648783; c=relaxed/simple;
	bh=CHMHccaLfupgHFYAlYD/4pcYQldMV+GyUWHQKdmwPUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwyG67kpwJ8HCPmqCvu53i86usYZBbjqUl9Vuu2XG4qOpKPlxes7icmwPMfSAk+LQqZ5VvBjPQGpI00NqtCjMid2k8WEIOPmBWzAbZEbcgwt2//ubny+OimefLz+oLyQ//Seoc2RKXpZ9uCr2t1pn6sgIFvocmpVP5hXUuiP4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9iLSHSk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b5c07efso9410321e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716648780; x=1717253580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHMHccaLfupgHFYAlYD/4pcYQldMV+GyUWHQKdmwPUo=;
        b=l9iLSHSkslv+21off7qfxzKG5VyAcNauDmmSufvnYHn6HjPVZI3ocAz74Nfev5K3YL
         ht76D4HuE3QArDk0llIsIf+kh5RnedZTCmWPbQw06/ewgH837nj+iDyUw3FdubjmQm6M
         O/LhySQ3Lxs/yxKdoxN0Sthd99tMamTxVoVfUtWCxn1N2SGFb5N7qjlslRw9/P4Va1v/
         sGzqWTwMO8UyjCbchMJdsHoUA003eu90vPn/ilqD7urKEyvjXdnHO4lDctbJVxnSjBVN
         G86ajzBuGJ0qDTqhFAAJCZeXDgMDcq8F3evAQbLhz1hGvmjfym9jUN/BBSIjGph93pA0
         /4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716648780; x=1717253580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHMHccaLfupgHFYAlYD/4pcYQldMV+GyUWHQKdmwPUo=;
        b=C+x04cHxmQwaVsrt014jKkOVKnGmoFs0dhvE4T9CPqHYs2r2j3cMZ49m1UDnDqwqpr
         8IEc56Xe2YRoA5nbdfZ+MT8y6IZA7xEZIY9RGz/V9L7bXQF8kaOaZgyskphxxvjVkymU
         aSwSQgxzUv6qTGNHQLuQdAMXtnJ7n45y3yz8ASN4jT+C4hzUyhTEGSYmbfaXWSpK5Gav
         ptv1H+1yFFRZV0pQzIkR5OSlF00Pxkcfkp96qKlYsSmapkYbA0Fs+UcJZMNykbGxQ5bY
         sb6n396eIY6IM/7854cq/aEzOQ3ZuK86z3YAJGB3pwoBZySr0YDX0ElsAzeQmGOzp5gn
         aWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJCzqyR78VyKqnxT/6DfwjaN3MTiwPvhzriXEurYjlkw4Kw0oeH5RvHpbtYQHuL9lESVsWIMI+YKl6Q9SdkIxqUsg4QN34vzPj2yIr
X-Gm-Message-State: AOJu0YyqPuvnagR+8CQzCGTSHtYb/FsdIwWth9x2pnOC9LkfDDFGLFoY
	PP8R5zgOeuPnuN5hDQOxKt29962AQuwwAAkxYWvVZ5wJSvTSmZxYMilwRdpmZjEU0I69FcFP8En
	19YdP0zDYovU5L5QP7ErCkLwz0T4q2sB7
X-Google-Smtp-Source: AGHT+IEa6FX0X8TXIZf8LxHPqgicb4smemcHxDpnIiiqjUNcFRxGofmPfWpg6TMnsbgB0yG00QfJztpPabc5GkGv3Rk=
X-Received: by 2002:a19:9103:0:b0:519:63c1:6f45 with SMTP id
 2adb3069b0e04-52966ca8debmr2780578e87.61.1716648779859; Sat, 25 May 2024
 07:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523170745.92166-1-hdegoede@redhat.com>
In-Reply-To: <20240523170745.92166-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 25 May 2024 17:52:23 +0300
Message-ID: <CAHp75VcYk_7Wb2bas2Z0db3gsCQL5Qp2sKzj=sJjp_WdHxoRpg@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for
 the PWM lookup
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:07=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The primary use of the CRC PMIC's PWM is for LCD panel backlight
> control by the i915 driver.
>
> Due to its complexity the probe() function of the i915 driver does not
> support -EPROBE_DEFER handling. So far the pwm-crc driver must be built
> into the kernel to ensure that the pwm_get() done by the i915 driver
> succeeds at once (rather then returning -EPROBE_DEFER).
>
> But the PWM core can load the module from pwm_get() if a module-name is
> provided in the pwm_lookup associated with the consumer device.
>
> Switch to using PWM_LOOKUP_WITH_MODULE() for the lookup added for
> the Intel integrated GPU, so that the PWM core can load the module from
> pwm_get() as needed allowing the pwm-crc driver to be safely build as

built

> module.
>
> This has been successfully tested on an Asus T100TAM with pwm-crc
> build as module.

a module

Makes sense to me and it's good we allow better modularity as not all
x86-based products use Crystal Cove PMIC.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks for this good patch!

--=20
With Best Regards,
Andy Shevchenko

