Return-Path: <linux-kernel+bounces-227781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B32915683
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42EF2814E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE319FA91;
	Mon, 24 Jun 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4I6WcIX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EB1E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253854; cv=none; b=dpykuvGQrCQO7Jqp7StmZBPRBdomc7ON2zBSDqwfpZEcn7pJWr40Z6j6ex208dmb7pFJKo1V6nOLEjAp3ROjBXUaayekDLBz7emM7eFB7aQXy0ZpOtNv8IDtDc918xNhf/dWvuHFqbjx4G1u4qwBMaIRuZBOPK4bsz49zE2nkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253854; c=relaxed/simple;
	bh=S7VKDTR3Xo56GU9aYED27fx09bgfKjd0JPEhRNyWZWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4J0rW94tx7e5/EBW0Nm3Kmh5Rl2Pd9dpHkgf9Iy7qrHefEVKiSww2aQ7Dky26zTFK82T1k0LwIs65eE0YmIbpH06bSQjbcOG+V+4URXvSZBal1JY5jNuoBYAATDnCRFsdv154PatNRHPRxBqx1EdxM8PSVDDjqDhb3aJ/wDklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c4I6WcIX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-422954bbe29so11365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719253851; x=1719858651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Shn1gNr+ZSKDVx7UmmEnbrdkHfvlVC51T81dg1zeh4=;
        b=c4I6WcIXE1g3xte4Dz4ZxfIEHIWaMKcYyEB8z0XYIaG5RTfAliAQDLvwWkKpwvce7T
         wG5qQE/pp4ZgKCVp9EwX1Wq4uVeLPGzta0gc5nG65ESSOWIyw0JxWnyeBBF5+VSsNXza
         NdjCRlZ6vgcOwIEhPoXDPalE1QP4tOc9qUz3y3Z4zYGyeoBH2Ymqb7n/mPD53zziW74N
         VszVysPlNkvBBtyrhKyLcSzO4VKcCOslqiyHU4++j+ZJZwfn5p3LAX4Ap5XQ6oEALgmA
         mHweHTPT5tzejr7ZqYq/uILGH56GOlZxzIROKeUD1B0m+Ycy3Jo6kvS8tKHg+r8KQom5
         hq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719253851; x=1719858651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Shn1gNr+ZSKDVx7UmmEnbrdkHfvlVC51T81dg1zeh4=;
        b=cvp+AUAO428wQH6iWXCtsnG9tdM8Wo7hjbjx8u47/1b6K8WhLISGUkmJySH9kOyZo2
         0fvNnYSbofJGgdmf7bxtCEDCbteQA9eFgtryPXQSODzP+R0Xi7kp6omEKCA0kaj8q8wp
         e1W+xXyvQcPdP0Y6M1F0a6rifelihmp6CC7Dkh/hDO9ICeeM0oTJne+3T8b1qjNQKKMM
         UlK86yCuAxdvUiliquYL79wIkDC965m4ii2OKJnkTgkFgX0i5tKo6/RK56rYZIxRIawJ
         pxK3CTm9GB/p39QqRQlT4H00+rwfQQ6GlPcdSnZgxY898zdEKTmgKnMvMMb/3YK9atT4
         lv1w==
X-Forwarded-Encrypted: i=1; AJvYcCUnATqIhpvHSmmG7F9IuNxG/OsYkhTfMNamCWdpcPvhWtWiWCMgWzBDPUlyYp2YHPVfSTTfpMB1yj4M7z6Pg7PgMsiM67hQPG99awKS
X-Gm-Message-State: AOJu0YxgjT0qkx4A6/AQqnR68TQprBNg0ClyDRPHYYWp6EcZkCLKlfeY
	YYuvbjq8uHbBvURNuMpy4Jw/mq1QVbOQWGSsm7geW30HPj0Cvv20zZvGhFZDhcFo260aGayWtSQ
	SfrWIOAzb5MHoO+M581XZlf2+rpA2CbczE4W4oo2vfzbEu86Q
X-Google-Smtp-Source: AGHT+IHepXwvl9I2Vy51Ew0cew4SEQBEx2TpEphb+SaWX+dky28XVIaOS5zH9O6qWSzNE9zj3F3c5bEaAEs+Sx8zWH8=
X-Received: by 2002:a05:600c:4e0d:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-4249a203161mr201775e9.1.1719253851111; Mon, 24 Jun 2024
 11:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624062411.321995-2-thorsten.blum@toblux.com>
In-Reply-To: <20240624062411.321995-2-thorsten.blum@toblux.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 24 Jun 2024 11:30:39 -0700
Message-ID: <CANDhNCpHfnhfb8zox5TKQLAH5636xzHk1W2zBDujhmM11sshsQ@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:24=E2=80=AFPM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>
>         WARNING opportunity for min()
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/time/timekeeping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 4e18db1819f8..f1a9c52b7c66 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -799,7 +799,7 @@ static void timekeeping_forward_now(struct timekeeper=
 *tk)
>
>         while (delta > 0) {
>                 u64 max =3D tk->tkr_mono.clock->max_cycles;
> -               u64 incr =3D delta < max ? delta : max;
> +               u64 incr =3D min(delta, max);

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

