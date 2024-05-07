Return-Path: <linux-kernel+bounces-170720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7A8BDB04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490F9B225F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01656E602;
	Tue,  7 May 2024 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+G50kEC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950506D1BA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061752; cv=none; b=m78ZKVd5ZdBcFjSQQ2yOea7v1TNXIhZFEPc15t9NQdlZF3/f3pqvsmnAQUyj6cfHewW/F6q+5wqpmHh/y74tZSDLXVjZgup1Ao6wDQPNSIN+ZbuaMVm3leE5WHknm/Y3ZH4oE/Fi+QhVW0CUyLUIoh3uO0QlAj7g1r1Ljc622Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061752; c=relaxed/simple;
	bh=6eEciy/4SiqwVexa3/ji17TY6bxHxOC7vE5JCvobeHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLP8E/p/Sulo5ZOdUiLRT/acPEcGPbtT/v5k1HsYlW06eR9zv/ovfgzyqTDn4Gt6buURMkeODRqJN2lN08qvu/iRp73E7ZDeq0oHKWeDj+V9WPTBlOdG/OLMZqFWobHHkoY5FdPlFJL0G/QL9BAf8Tiv67Neq8zs0jITE6WX5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+G50kEC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418820e6effso31125e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715061749; x=1715666549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r27a+5j0jPbKzuSHQx0I4ZiLeBi7lavOITwf6ioG1UA=;
        b=u+G50kECrRoGAKy3SwCuIidjqEgQ2pXzcsVn5sXvwrrZECN4Km3varsI/HlAOzuikn
         8cB5GPUdZecebkCwOzqaTtWAe1AmV6CWd6QQoRXKp2wR0ySiIQoVyTXYLQIV7U0hShYy
         pk/9SE6ccuX1G3XDzd1AwiYeY6iX24ybvAWDz2MkHDxcJuXW4NQdJERj8R6LIgZtPfVi
         djVVqVWr2SG2v84R7Hp1qT5GL2qOwbSEWpNN00YWY/9s/jzBGvDiyNudKIgwdhpX5lzV
         mbobtVc7O70GveXBVdXT44AzHvu5EizxB8DwrrFj2U+WpdWnQcnNXAguNPQdMI4YQtVh
         93Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061749; x=1715666549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r27a+5j0jPbKzuSHQx0I4ZiLeBi7lavOITwf6ioG1UA=;
        b=NItv+i1QqEVOqgI1vfX5iQ/MVh7BV4A60hSV3BYLC8JL/hhtT7V9y7ky6Tqoevak/P
         43HU2o5tBKvk6RSSeUj8abccbqj3HtdYqqWD2mCXjjwCkOFAtkxb6XGrTNW5v/BNcriQ
         eJdc/Q29c9kTFP5phQ1FLGnatfonu7XTBfAGyAKjSi/7Ef465edkE8PBNt+7xekshAky
         T6MaU+1cpqnVFjXGf9Ephs6pY9CLLbVXszzIr8843EJxv96c/uk4zoAOvRkXeKMH1ZcH
         oDWcgH9hoBrql1SrRWul4eBNfcexFGiB0ZAlGzAel/wlBwTdag+7N34r8ayPpBApsBwn
         afSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxSvQcP/LcvF0xQrHu9QvhmanqEl1P1bYaqN2/MklNFV27R4mV8AboSCHgJffYdIHP22YqK6pfTsWnD3GA4mEpIlLqfpVYHUTPaAYT
X-Gm-Message-State: AOJu0YwzBVe/n3XkC16vnxCs1o4zC0Ttj26w8o6k7lUSt4Df/dG1ynVI
	gG+6riEMuKi2HV+NYG6XIok/UuPpYqHPMv9xYxRq98Ek8zW9TcCfEw0IsHoDUTm7s4KtZvaxL+t
	vHmq1N83LMyPpAakp7DdJHeJVdSwBp8faKcpsOWKJAA6GGnPa
X-Google-Smtp-Source: AGHT+IEFTsooy9lTXdBUnPXWeLAjuOxu0cUYFTFhxumq/HmIbzVGnFqUYBuaCwPPtc5cLMJXcfjrnfkuzEiIB2JL7cs=
X-Received: by 2002:a05:600c:511f:b0:41b:4c6a:de6d with SMTP id
 5b1f17b1804b1-41f3bed8783mr780285e9.5.1715061748872; Mon, 06 May 2024
 23:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
In-Reply-To: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 6 May 2024 23:02:17 -0700
Message-ID: <CANDhNCps8qE1a+Vp2HNgU=-vA5RwhrLd2_D0EMZiNv1j_OOYWA@mail.gmail.com>
Subject: Re: [PATCH] ntp: safeguard against time_constant overflow case
To: Justin Stitt <justinstitt@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 3:01=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Nonetheless, let's slightly rework the logic surrounding time_constant
> and how it is incremented such that we avoid unintentional wrap-around
> (even though it is extremely unlikely to be hit in non-fuzzing scenarios)=
.
>
> [1]: https://github.com/llvm/llvm-project/pull/82432
>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  kernel/time/ntp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 406dccb79c2b..a9f039601968 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -65,6 +65,9 @@ static s64                    time_offset;
>  /* pll time constant:                                                  *=
/
>  static long                    time_constant =3D 2;
>
> +/* pll time constant increment:                                         =
       */
> +static long                    time_constant_inc =3D 4;
> +

I'd probably use a `#define TIME_CONSTANT_INC 4` for this.

>  /* maximum error (usecs):                                              *=
/
>  static long                    time_maxerror =3D NTP_PHASE_LIMIT;
>
> @@ -734,10 +737,10 @@ static inline void process_adjtimex_modes(const str=
uct __kernel_timex *txc,
>
>         if (txc->modes & ADJ_TIMECONST) {
>                 time_constant =3D txc->constant;
> -               if (!(time_status & STA_NANO))
> -                       time_constant +=3D 4;
> -               time_constant =3D min(time_constant, (long)MAXTC);
> -               time_constant =3D max(time_constant, 0l);
> +               if (!(time_status & STA_NANO) &&
> +                   unlikely(LONG_MAX - time_constant_inc >=3D time_const=
ant))
> +                       time_constant +=3D time_constant_inc;
> +               time_constant =3D clamp_t(long, time_constant, 0, MAXTC);
>         }

Overall, this looks fine. Though the time_status conditional is now a
little unwieldy.

I wonder if some sort of a helper like:
      time_constant =3D safe_add(time_constant, TIME_CONSTANT_INC, LONG_MAX=
);

Might make this a little easier to read?

thanks
-john

