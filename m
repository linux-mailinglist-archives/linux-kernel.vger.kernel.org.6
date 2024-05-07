Return-Path: <linux-kernel+bounces-170713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5398BDAE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05237282D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E160F6CDC2;
	Tue,  7 May 2024 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1D5JRpK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953826EB5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061286; cv=none; b=ao1a2G7gz1L+C8vGm388m0t9S5WgN5JX1Wf28lta7yJPLVZhM1i3f0Vx0ECvyztULMz9eGOypS3Igvq3lJ+objJyApBI8XNeG71roEHBCSdx+HfI//KH3c6e+btoHzaFlgh9upk6FoHNp2LRAibdCwNvNRnyVTXHlJGm/Nb+wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061286; c=relaxed/simple;
	bh=zycI60GD/v+qvEnAFNouzBUTO1V9JiQnJpX3TM+77ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHMqD+jAHN5gHqjM6me2+vS+WXdbfrdlwA+HHmK9McN4XBSjmtlTWa2uhy1e62loKSTm5hWODGkyFdsrxukf5femO22kaNqaloi0PMY0OLQiKt1ugEfSGkXILzivtsr2Z6LOTjCVVCmRe5usb+/b+8YPt2XqG3QEM75EhGpmySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1D5JRpK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41e79ec20a6so29295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715061283; x=1715666083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2+XprmFK+IYeTTDNzHuz3jEWMm6Vi+YQ+2eFOmblGY=;
        b=d1D5JRpKkTlwZ78YKt6XdJSGZbx8mJ17drPWi3dD2y3eMZUteIveYLQdva3oli/Y/7
         vc0+lhaIa7pCwiRzTIUeKHSYnJpEvr1nCk41EEBgBUxmkZHqbvcqylG5ybutmOE3Ci/j
         asn4xu+WOrqv5g4wEyvk8PkArpFC3Xk9tW+49hT8S4DMNKCK0Y+vx7XBLwHXnfrrmdvT
         ve0NK35L4ucwlTR1YKJdYD3wmWyfRYJbVFyjsrF5YSoj24CNU9cdqLtQTnCAfO0QawbY
         4uzSN1bvDo5tWNgLd01v5eE8mWBla0MjnmA+7mREcg+AupEzlilU5boDGCoIgF2DQ3FQ
         MLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061283; x=1715666083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2+XprmFK+IYeTTDNzHuz3jEWMm6Vi+YQ+2eFOmblGY=;
        b=Dnu+3y0BsWo+qCPdX81b54WkyOBpDh1r4CWeSTQIyqYp51nBWu7PrYIj5rqB1OgJhK
         avG7tI4Ug/Cf4YZVv8ZkXxpwc7FkR2JELi6OcGyN4u/gVQlJWl6OP427m7aia3ala6BC
         fKo8dz2+npjU9jHqUIZ8j1Pn24Cy16/NpniN5Os4qUM6KgPrImMvxtmx3yjZJ0evx7yh
         cisJ4wz3gWjrD8xWiirmqDCcBYUMrgCRo+e308PZ/xuPUASRG2Qhprd93yeP3QGdvDTW
         t5844e626XWDd2YLI9tLiskLBh2ZFUbFqSmQfKaBeOOv7QZOsjZqdmJpZsYR1qSEMxPw
         Co9w==
X-Forwarded-Encrypted: i=1; AJvYcCVU3LafUOdW/UgnyQp7kkP9vMnwpz2HtoVCbvsbittpI2PFfhtx6qt6BcSf8I+D37Apu2681oySQXAz1G3OF5psjaWjsYv/N1Tobqnu
X-Gm-Message-State: AOJu0YwOP91V0CBphHZIi0BSWsf2p/6AwpM1ixEYLCecrHHFarwJh9n4
	UExcDvGPBpqmiJ27CWyfG6QrcIfLu/QAcEvKHYUhbsj+kfi2Her+g+BnDkQEd4CwBJBGyrHL0/b
	VkrW5G97RfCR3GcIObqOqcZi6A8QELj2oTFQ=
X-Google-Smtp-Source: AGHT+IH9BUY3Ybiuaq2U0mzo8WOYrWHauZfCI6q8FsareAMFaYi33OS8f5Moj2dq6e2fcauU1f/k5k92JiyJ5b89cS8=
X-Received: by 2002:a05:600c:3ba8:b0:418:5aaa:7db1 with SMTP id
 5b1f17b1804b1-41f3b8affaemr886575e9.1.1715061282789; Mon, 06 May 2024
 22:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
In-Reply-To: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 6 May 2024 22:54:30 -0700
Message-ID: <CANDhNCqQPGjhSDnCOvHFqQx6vaPb1U-nyaacJSNMxcoKWwRi-g@mail.gmail.com>
Subject: Re: [PATCH] ntp: remove accidental integer wrap-around
To: Justin Stitt <justinstitt@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:34=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
> Let's introduce a new macro and use that against NTP_PHASE_LIMIT to
> properly limit the max size of time_maxerror without overflowing during
> the check itself.
>
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/354
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  include/linux/timex.h | 1 +
>  kernel/time/ntp.c     | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/timex.h b/include/linux/timex.h
> index 3871b06bd302..976490a06915 100644
> --- a/include/linux/timex.h
> +++ b/include/linux/timex.h
> @@ -138,6 +138,7 @@ unsigned long random_get_entropy_fallback(void);
>  #define MINSEC 256             /* min interval between updates (s) */
>  #define MAXSEC 2048            /* max interval between updates (s) */
>  #define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5) /* beyond max.=
 dispersion */
> +#define NTP_MAXFREQ_USEC (MAXFREQ / NSEC_PER_USEC) /* scaled to microsec=
onds */
>
>  /*
>   * kernel variables
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 406dccb79c2b..19027b6d0827 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -454,12 +454,12 @@ int second_overflow(time64_t secs)
>         }
>
>
> -       /* Bump the maxerror field */
> -       time_maxerror +=3D MAXFREQ / NSEC_PER_USEC;
> -       if (time_maxerror > NTP_PHASE_LIMIT) {
> +       /* Bump the maxerror field, making sure not to exceed NTP_PHASE_L=
IMIT */
> +       if (NTP_PHASE_LIMIT - NTP_MAXFREQ_USEC < time_maxerror) {
>                 time_maxerror =3D NTP_PHASE_LIMIT;
>                 time_status |=3D STA_UNSYNC;
> -       }
> +       } else
> +               time_maxerror +=3D NTP_MAXFREQ_USEC;
>
>         /* Compute the phase adjustment for the next second */
>         tick_length      =3D tick_length_base;
>

Looks reasonable to me.
Acked-by: John Stultz <jstultz@google.com>

thanks
-john

