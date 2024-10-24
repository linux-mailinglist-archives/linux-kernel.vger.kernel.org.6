Return-Path: <linux-kernel+bounces-380711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3159AF4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8F61C2192F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1792178E1;
	Thu, 24 Oct 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULUsBNqr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5F156C74
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806845; cv=none; b=dVNwgPBxE2dPPMRPx1AMW17jHMN1qUyQbRD5pGbKLPzDfR5QkXbn3sEU06Ed5Uw7ocDbEyqgT7jjjZ2t1Hydt3zj09hRKu67N4qXUFU2fARLn1Hwl1E/I4xDmGdYFtt9LIu2x3XSVVNYl2vyuAvQWRvxp1PPYV0dtFniOXOxofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806845; c=relaxed/simple;
	bh=w2hrqYL0dfFGyNKEC2x3dHp+AUu3NDRYjQVY6MrdJZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTAN6brucM8qyygaMfPJyldcZwlsoHhlUgy/bzCZ+u3shFj9mIESKkIRaQbAiKkmOsHRl2YDE9/OjyTQdUGmPea2ZQsBY6qBV9MRTFWGS+0KqVRwJlzZrXVuPUIkBtmwncAFJqRckC70TxAD8XoXizuDtcWdWGUbLfsooeZDzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULUsBNqr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99ebb390a5so467673466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806841; x=1730411641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uqj5jZN1Y90JeDsIqONz5XZYAyScvhWiyvgeMsTBY4=;
        b=ULUsBNqrtODmz5vlAkP8E1r6Y42GnAYiM0R28eEC0llfUXiYAFAysLOs0OfmIPdyXY
         zsN255GMhIhTU1MGxvCnpRsUkmD32/m2Pf4EAlRGxdANTWPsEFXWLUHwUSVtAtg/Wvo3
         DC3Z0EQfNkUW9SoK4EIbLlYQBM0nePO92J/LXfjzNEe3ZP78qNQ6xUMdQ0fTXYUKkYDo
         +rRb6nAS+Ycf3CMGjo1+hnqrFQqwR4OXyazL9VjT3eFtmkxLIixiLHFFRFOnFNjtFRUo
         BxaHsp2OOUDzaqpeO8oFerTDcADjANjIkf/mmTK6xGfC+ZvBHUVhwQeZNO1TJfm5CuBZ
         vKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806841; x=1730411641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uqj5jZN1Y90JeDsIqONz5XZYAyScvhWiyvgeMsTBY4=;
        b=V8QPE9QSD3fYfbe18zsUe77e1R2jRw8OdNSczLnQTG5ie7QlGNiisCdpcQDj2ZUsnw
         WBmsBuPZ7UqQiserT+ebM4jCmkbJ/GpWNxCsH1Om6aVsX5A4NF//EJG9bGuZndDWVW41
         fKBWIYQY9WRmFlHHqg6GWVVOo3zYijpXMO5nAlj/WOHB/Is+300Eq6QPZ6qJJSProS2o
         gO5b96vWkrSC/Uz8ZJBahdGo699m/PJRkoOFJiMb5/J02LK1Oy9w959mtLw+mwNX3qwV
         4hrANyz651lXSFDdEQz3vdEvWcVQVfUNpX+boOsb0J2oAr6qq3G1hE5gwuCshUXEu45c
         EbXw==
X-Forwarded-Encrypted: i=1; AJvYcCUeblVyHSmGfMpYigzRI22OjpEdueibeL6VXDhYNyCh+LTloAmDILZq8v4dZLTB5KGsSztUjfm5wPenuZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEioHxXl6VmZp4jVVypJNsGqVzqYPZHihs9WcEMNsOtdVeIRjM
	g1rv0DwI1TYAAQgxqjedChCYXErIIUa/RhDjixtOzNvYmqT4n9xPA/fUe7eWN6JRKK3pDS/BvLJ
	5qdHvUjU8PePal7GmBFEx3gRkb7apEwYx5R0=
X-Google-Smtp-Source: AGHT+IGQAKH+6LruNyHsxR3lLmS1Tz/jDv4PoTdTHhvEx85gf+hu0Oj39rcemdrvL8ZqcaMF+Oh9xcInVEspw7T4oS4=
X-Received: by 2002:a17:907:2cc5:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9ad1a02e6fmr389581566b.22.1729806841245; Thu, 24 Oct 2024
 14:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:53:50 -0700
Message-ID: <CANDhNCrTzUODaXyVdX2t+d+0s3cxWi4KV4MxJNjJrGh+0WxEEA@mail.gmail.com>
Subject: Re: [PATCH v2 13/25] timekeeping: Split out timekeeper update of timekeeping_advanced()
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
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> timekeeping_advance() is the only optimized function which uses
> shadow_timekeeper for updating the real timekeeper to keep the sequence
> counter protected region as small as possible.
>
> To be able to transform timekeeper updates in other functions to use the
> same logic, split out functionality into a separate function
> timekeeper_update_staged().
>
> While at it, document the reason why the sequence counter must be write
> held over the call to timekeeping_update() and the copying to the real
> timekeeper and why using a pointer based update is suboptimal.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 43 +++++++++++++++++++++++++++--------------=
--
>  1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 878f9606946d..fcb2b8b232d2 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -780,7 +780,32 @@ static void timekeeping_update(struct tk_data *tkd, =
struct timekeeper *tk, unsig
>          * timekeeper structure on the next update with stale data
>          */
>         if (action & TK_MIRROR)
> -               memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, s=
izeof(tk_core.timekeeper));
> +               memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
> +}
> +
> +static void timekeeping_update_staged(struct tk_data *tkd, unsigned int =
action)

Minor nit I realized as I saw how this was used later on:
timekeeping_update_staged() isn't super clear right off. Maybe
timekeeping_update_from_shadow() might make it more clear?

thanks
-john

