Return-Path: <linux-kernel+bounces-522350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D23A3C8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B3587A81D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DAD21B19E;
	Wed, 19 Feb 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh55lzyr"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4527184F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993917; cv=none; b=QRshIrVfW/sx1ZKYlhi7zmhNqklMwSy3KIJsCtvlBjYu8k8ZUmd7IqdW75LzxZK4VgwhVnZgIyEIqTQBRVpNU0HOpE18/Casuy9+uRGQDeMJJ55MrOjkMhxwCLXKgQj3YFDGsAicej2goh+DYi6zV1IQV2ntjn8y+/eKezWA+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993917; c=relaxed/simple;
	bh=sFzz87xmpa4DBWmRLEaYsXO+yEKSQPufKsStfayypuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULPog5kABBS+SG0qdIu0jyQRoe9F6//HEEJribaWrZk9pM2Q+XwN8Geiuwz77FwZ3z98fLwtSDV2DYci5XEtucEgmaxhlAXH6qgcz67w7k7KPScShpU5ChbsCxovGcwfaMPaKKMurCtuYVPsvwAL2zk2GgS6ptrGjSnwJO7xJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh55lzyr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4399ca9d338so697685e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993914; x=1740598714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfZKZmH5FYTebhsLF0b17MePHU4Jur+WAQAG/XZ3ZWY=;
        b=lh55lzyrQJLtCiHXxW1XYzVZT6YAdAAzRcwmS4AjuSWtEupC+y2s4a4NojPCqwzcSi
         xCzLDfB/MJnxvmecWHD7gZ8rL1wak1m3a6cQPebUT7AFNf8H68gclGmwqLTgSYyo4p3E
         ozDSawdEdpUnjK6upYVimrBXKQcujENiKunL82aTEStaFJyqa9WekSf575MST2pnYy1i
         HmjTGqbtkjd3l1oeb48dIOyn/IsZW9pnhDxZD35lFS82bk3DTUoNAD3YCbonNo9HNdSX
         iwH6/iMAY1qaUgZqlT67k7iF/VWWvfg9Wdy8pt+GKBkhI9+aotU1F4tQQFnacSLshEO9
         s4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993914; x=1740598714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfZKZmH5FYTebhsLF0b17MePHU4Jur+WAQAG/XZ3ZWY=;
        b=bQgVer0m64fkH5v9EP47xplhbc/WIWdMYtuS41qaiEaEU/ijBWUAxl5VD2VdKlM/c+
         getnheDegH7dxSSRhZ+NAYvnXNy93CbnAClQnh61h/CxoqDmmxi36PfdLj+ZXjdeejmq
         sES3tzGm2L/h8XJzuwqdWBi/VZoTOA1XK/cxzCztQ5z+fvgKqwTf944iJhNhkjvnugiL
         2+LJH1ywy1So/8IL+5UXQfxW8a1Fx65Y5tmqY0jK+g9Bstb0OxXJtl6a0JkkhjGxGQw6
         4LM1bgNR6mbikUSW15iwebNK55w4f6LhF5brhEKpwhJimRAedtlcVs6QbAJ4MO5hHMlV
         IYaw==
X-Forwarded-Encrypted: i=1; AJvYcCV2hEgq2K2nAnceVC6lZBDPfTTmtu3rzG9zvOCetcO4GeJgN7NvOi1SY8/NcF778Zi1e+hNgS6zZKyuJ84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mWcRiki0ORPWTSxxg91I0fybFUUpSB+t/QUZErS0Q2zCAF6k
	jRXcSBK5goUUEhn1B3KoQJuQ2b7dUNXnupUJ6A2m01d8cypGbeFP
X-Gm-Gg: ASbGncsZEmTdh9UQRAYjWqWYm1DWenDna410vxQP5hR6gKIhifH1dB/E+bXktyB96J0
	Ci6W8XIkZOYXju6d2Sp+hwd42xkGoC+rPg0kcyTPSWWv9elMpy+DGykFI2+sFxK4rb0b0hUZZyR
	M5h0YklRlSFbn/YDRprETJMdO9OVgJ2fr6bZpYz4D+SDgq15hA4JhWFpnQdTiKRvaCb9PSRb4TO
	Xn4lTXIda05Ml9rhw24roGhIIwf63dvApoJon4KZeseoxkLv0lsl+EKbN8EoVB6L5XTereL3BND
	iSp5pXzPFTOgUs+mFQfkj6e6Lfjaa8NOeQ51n/MBGdd1dbRJHSgDcQ==
X-Google-Smtp-Source: AGHT+IGQ/AW4cri/ewPhu7V0AiejxybGKG+K4nwQWsbfvSJgMa2uzX3mMG75uQXSaEjRg1/F71XNlw==
X-Received: by 2002:a05:600c:19cc:b0:439:9a28:9e8d with SMTP id 5b1f17b1804b1-4399a28a067mr46334905e9.12.1739993914036;
        Wed, 19 Feb 2025 11:38:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm18242939f8f.89.2025.02.19.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:38:33 -0800 (PST)
Date: Wed, 19 Feb 2025 19:38:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 4/4] posix-timers: Use RCU in posix_timer_add()
Message-ID: <20250219193832.6c3fa40f@pumpkin>
In-Reply-To: <20250219125522.2535263-5-edumazet@google.com>
References: <20250219125522.2535263-1-edumazet@google.com>
	<20250219125522.2535263-5-edumazet@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 12:55:22 +0000
Eric Dumazet <edumazet@google.com> wrote:

> If many posix timers are hashed in posix_timers_hashtable,
> hash_lock can be held for long durations.
> 
> This can be really bad in some cases as Thomas
> explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/
> 
> We can perform all searches under RCU, then acquire
> the lock only when there is a good chance to need it,
> and after cpu caches were populated.
> 
> Also add a cond_resched() in the possible long loop.

Since this code fragment has a 'free choice' of the timer id, why not
select an empty table slot and then pick a value that maps to it?

You can run a free-list through the empty table slots so the allocate
is (almost always) fixed cost and trivial.
The only complexity arises when the table is full and needs to be
reallocated twice as large.

The high bits of the 'id' can be incremented every time the id is allocated
so stale ids can be detected (until a quite large number of allocate/free).

	David

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  kernel/time/posix-timers.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index ed27c7eab456..bd73bc4707c1 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -125,7 +125,19 @@ static int posix_timer_add(struct k_itimer *timer)
>  
>  		head = &posix_timers_hashtable[hash(sig, id)];
>  
> +		rcu_read_lock();
> +		if (posix_timers_find(head, sig, id)) {
> +			rcu_read_unlock();
> +			cond_resched();
> +			continue;
> +		}
> +		rcu_read_unlock();
>  		spin_lock(&hash_lock);
> +		/*
> +		 * We must perform the lookup under hash_lock protection
> +		 * because another thread could have used the same id.
> +		 * This is very unlikely, but possible.
> +		 */
>  		if (!posix_timers_find(head, sig, id)) {
>  			timer->it_id = (timer_t)id;
>  			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);


