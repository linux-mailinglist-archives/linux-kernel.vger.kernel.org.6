Return-Path: <linux-kernel+bounces-367984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA129A0917
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5D0285A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FD207A2E;
	Wed, 16 Oct 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz0ItiI2"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD24207213;
	Wed, 16 Oct 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080820; cv=none; b=DWh2VQtOZSjNfrPAHzTPS5Jcnr5rVqlCVm9R3/Y6Jstdb1Jly2mQVAKQmmEzxHwP7Ml44K0eh+/yzfi9T0yOkEs8QPh17ecswXUQ0oKNIzOCGNEHIt/7Ry/eqwO51FRqrlDwjTXcFMc3fmwnmwfv3WBmwwo87iZl60wYySUSySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080820; c=relaxed/simple;
	bh=LxgdIJ5aCbhAA0tGanzlSPOGnkH0GsTgoJLehp28SbU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC3DcA7y4k7ZLtXQAHF7L2pBE2Q+wLZ8AMJhsDlEvbeLd0mcwJ6ReT5kGNb1C8XkxI/ckGKCfTUz8Qf13cR23hrD4qtaw+CeE2M4BYL5eyqY5rzRgQeq8tGsUdnJvCb7Vj0IqM2EsbOQrEkHh6jM/hwFh8uZ0UohV3Y9fvI2RJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz0ItiI2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fb49c64aso4532059e87.0;
        Wed, 16 Oct 2024 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729080817; x=1729685617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+oPXcEcbH9aP+tlGF1dqJ/DUloPMeXfoEkppJgD36k=;
        b=Iz0ItiI2CQM7PsZ8TqryaZKpeJaKgea3WpACDTiy4VKcx1YgPAPi9GGZHXObA1QKDP
         /LTOJfG2019v8kJFIQFlL2hNmlvkJpefSDzf6F8Mqw/BNeBvlXwvO3urnYVAaV1ZYWgv
         3pjmqHPjNEkdZcVgYt0NNCycZm0MdAqQsiKDoIIJ4sViOYrnWPAMsMwECoJ7jIaSPcRY
         ynYIKRV+tG5jJt68Qk0DdbAMoTGQvI/Fuj02YmDfQ5PRXzr5/Hgl4pMYgx720IjY0JUa
         GY9B0jS5quRRkmhgZhET4nCzrh3kqMxx/C4WoqLrfcfGqLYrPF00OqD81lOZR6jRe7NL
         Ig1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729080817; x=1729685617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+oPXcEcbH9aP+tlGF1dqJ/DUloPMeXfoEkppJgD36k=;
        b=AIZbaCFTi0LBplFl6wtIBjc4NXMQlS794oqRToFYrTVkTAiOidOBLTI35VsBVqfFtf
         koxCkkoW8MGdvSbiWD5Nhf0omImKeCc9Ufk8FcX+qEkPGa3ixbrITvmd5UFt6pfgDXqK
         e0HSVaC2qNEyQSMJTDdfiEx7IaBwT5tYWSeSyNHOWKBi0J0AbmydRyQFXrrN4+euDzXA
         GHccTrb/Cjd+/ou1hrgBdZexNPABQghTxUawbFpJDNi4ZSQv5zuLLPlvwryAUEPIX7OD
         lFv1c+vW2no3lay2H8ENqSrRTXjS/duhbATcGjMsIz6TZjX2XuiAvIKLc0WwYXndXm3v
         PDww==
X-Forwarded-Encrypted: i=1; AJvYcCUhH0udU7idt+xDiZIC7Urs+TN95CwcZsnk6hsw2dEp2zWGlQJfni7236oQsFU46iCUpnBTrXi3pTgytf+S4hU=@vger.kernel.org, AJvYcCUmg92L0Aa5hxLhrIYqDEkkwyjYwcI/JwqrXMBmHLh35IFuHOf2ukAgKRGIju58BFIoAY3ck1X88kN2h/tf@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLJwdhi6YUo3AB6uf4FDKWmuKsSU1+qA3pDR6MuzMOiYyPy46
	L19Y77giV7CyT8Wf26VycRmljK9CQLRI/ilnWs0qz9O+t5Ovm5sC
X-Google-Smtp-Source: AGHT+IE7+Vrr4DQRMCtFomjskN6sCQK08l0TB1AG0hKY9SyjVs/V8C1+nuKcCxMOUw9t+7ZmSvDQwQ==
X-Received: by 2002:a05:6512:3402:b0:533:4505:5b2a with SMTP id 2adb3069b0e04-539e5515238mr10424931e87.28.1729080816220;
        Wed, 16 Oct 2024 05:13:36 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007193sm436094e87.229.2024.10.16.05.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:13:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 14:13:33 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] posix-timers: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-ID: <Zw-t7a2M3rZGdZei@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-12-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-12-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:58PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  kernel/time/posix-timers.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 4576aaed13b2..fc40dacabe78 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -413,18 +413,11 @@ static struct k_itimer * alloc_posix_timer(void)
>  	return tmr;
>  }
>  
> -static void k_itimer_rcu_free(struct rcu_head *head)
> -{
> -	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
> -
> -	kmem_cache_free(posix_timers_cache, tmr);
> -}
> -
>  static void posix_timer_free(struct k_itimer *tmr)
>  {
>  	put_pid(tmr->it_pid);
>  	sigqueue_free(tmr->sigq);
> -	call_rcu(&tmr->rcu, k_itimer_rcu_free);
> +	kfree_rcu(tmr, rcu);
>  }
>  
>  static void posix_timer_unhash_and_free(struct k_itimer *tmr)
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

