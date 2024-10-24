Return-Path: <linux-kernel+bounces-380723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA579AF51F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E6D1F22AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1EE217911;
	Thu, 24 Oct 2024 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt+oIaVd"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1F2170C5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807989; cv=none; b=fjF3wW2o41QJBWFVNBpTxXPc7pbNI4vRfPC0MjONyqOfM1Jm3losrssa2us/U+PfV+UdLmthaCx87Uv76neiE9mfP5xiOnFNIXhb2hElv/+9JU5wN/I1qCERer9PDMgVTMzqukk2hjtZxSe0Hp5k9a/k0tk16AFQHF/NqjMUXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807989; c=relaxed/simple;
	bh=qcL9+ZlcHChw9I39yL7aZCjBxyhLqJgCTbbwDXxMymc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rrs4+2E/fB3FONuH3TdNkJ6kuI9w+q12shv3k7RJJ1kZZ+v55h1QhhHfxfLMxcLkP2DLQ1w3njarcjBjaq21ERPvA3O7MItxG5STaya0e9l+BXa6ZEuuiegv3kDMp888hkh5iDFaq93GQjYuRcbjKvOiuLYxoj1scsXSoiRt4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt+oIaVd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9aa8895facso212753066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729807985; x=1730412785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+KsuGSLk9hwEP/LVz6TAbcNAQPELmdgGLuMvktV8lc=;
        b=lt+oIaVdpGyaawLNeJWy4BT8YVzuGTI57CIcVY4pLBdrJt59WKUna6894IQflJ8PTf
         BJe8zvfBUVzZucIzsW42nk2iz+u+8kQcQBDmHo5Jkkt4eZIzTaBMxPL2zGfKLSyyF+UY
         e2XjjSYKqHT8m1ZMJGOcwGGg2Hs887pNoZIbQpUiEKtpvK0ujF6+XCVzrmf/V+BWajQL
         VHb7nbjQRKqypzCFIsDm2+qG9H3XgyrnjALvef2ogTb0/y4+WiRtQR8t/3TvMQWoQqcA
         rZQTg2cmG8qpwOC6unoZdnagt6lWtsK+0kKSnSqiAyHCaR4s1sRcB3RAqRkTuu5D195t
         ahuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807985; x=1730412785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+KsuGSLk9hwEP/LVz6TAbcNAQPELmdgGLuMvktV8lc=;
        b=uLGlSLdtgc1QIASNW1CbpTXkAU9K56PrqwGYNqY++NhmAKzEuAtG74MZsuLyiJBYE4
         ttGJrP4zdSdfdjiPaaA4DALTewJxOlY5okzSiMSChz5hp7ctu1WAmYxWCtPuB4/Dygep
         D9eBjSw+LmC/+I0H9/hj2rq6m8VmUK9yFg+ugHIbhFdmuQfZU+YBitCejEzrQRZ307SN
         SxNDr4VXLf8FYqW7p0g1+bhJLk+qNdYeAzrh7xqR7tfSPIfZZsDKZ7Nf5YRpBvmlLFgv
         Fp66J0C3Fz7/NFx1vbrQrBkqCcvisYQAQ4aU0B6bXJsqV7m0BbmxuYbjdc6htkpcingx
         +JeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxukD66T2sGZL+R8dTpSdYJbOM/H5iWo3lFcDBBjqHiYrBMIDjwOhFDRl3cvAAJZ2H7/WljWAzMSRYwls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPWWLPh4nBBaEDUMJ7MS7ZbNqtJwlOibTVZTeb7TKHWIfzOKF
	vvxCo5rI/lCP/+0bfEPzqw9FYvGX04iKxn9YEzRRh3H8NKtkuDGFAx1yZF6rV4PkC0obJuKBOR9
	vN42/T2N6EJ7l56DHziCV9Gn/wMH59OBjpWc=
X-Google-Smtp-Source: AGHT+IETo2LeFbEr+Q/wtTQYIcWMa+cws2aI5m+kZmFeitc7mhqIswS4t59K+/46Xt485HjQ5AfBa4sAxYqF1bCTtq8=
X-Received: by 2002:a17:907:7d8b:b0:a99:4e07:e6c3 with SMTP id
 a640c23a62f3a-a9ad270f630mr327016266b.8.1729807985183; Thu, 24 Oct 2024
 15:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-14-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-14-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:12:53 -0700
Message-ID: <CANDhNCpDySwAsx20Wwm3_Np=e2venKx16a0BYVmq9j_XmpEjUg@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] timekeeping: Introduce combined timekeeping
 action flag
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Instead of explicitly listing all the separate timekeeping actions flags,
> introduce a new one which covers all actions except TK_MIRROR action.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index fcb2b8b232d2..5a747afe64b4 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -33,6 +33,8 @@
>  #define TK_MIRROR              (1 << 1)
>  #define TK_CLOCK_WAS_SET       (1 << 2)
>
> +#define TK_UPDATE_ALL          (TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
> +

Hrm.  I feel a little wary around having a flag mask called _ALL when
it doesn't actually include all the other flags.
I also recognize the "TK_CLEAR_NTP | TK_CLOCK_WAS_SET"  arguments can
feel repetitive, but I find having them explicitly listed makes the
code more readable to me.
Combining these common ones together just means there is a 4th option
one has to keep in their head to translate.

Further, as I look through the logic TK_MIRROR could probably be
improved by adding a direction (it's easy to mix up what is being
mirrored to what). Maybe TK_MIRROR_TO_SHADOW?

But these are mostly just strategies to help my scatterbrained state,
so this isn't a hard objection if you disagree.

thanks
-john

