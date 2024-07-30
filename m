Return-Path: <linux-kernel+bounces-267790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005E941580
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939B11C22991
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9C1A2C0C;
	Tue, 30 Jul 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E9qHEYSF"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCE18A92F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353762; cv=none; b=nQPFiRCWsO+Uy2UZDSOtoFigsEHSIyoHVBxdu4JED51dZWhWNcTwzluqA4ivOVdwfbkXdtum2cxOCH3raeeX8iu4KCmb6uCWormKiNpWq4MPkz2ik4xj5N6ShgyPaVgYDjjdzwGwmofEFs9e79LURVuz8kv8qzY2a+Ebt2Ft6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353762; c=relaxed/simple;
	bh=fMeGkm0jV5VbKOVTBkVGxLAkp0QX4Z44Tr8ZKwhjE0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTj0auy89AY95Et/TjcnIP/ij8T9sPB+8xyTpIG0yyTbhWDQv7LwAKlvCcMsReczWaOJra4//AvlwfXPXTKylFaRitz00CQatXbruJj0WO9aeAi5k5sakj64KE0YaNCoNabn6OwhoOa6qYDHT1ojZjzYWOjyRFCECf1akGv26zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E9qHEYSF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efabf5d7bso5686877e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722353758; x=1722958558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgm4tMXjeK45j0cH4gjo52YvHllV/PKSl7WdTE3xniM=;
        b=E9qHEYSF3kqCD+d4mC8mhN9F0k28SsDJCBknCEeT5QhavgdxgrRRQPsmms38dKnhch
         IBzSbzpOqiWJhE5GjhnlO/ferXV57cP7V0BmrNCTRoRFu0s3vQGy9BY2jRuGtwrXIMvo
         /FBAztpPQsB+4LhHVJHkfq228/0agZlmj2WGH+LaNTfO55lbYlYu92LMWukLiOQWPsXT
         iT6V/IfSbz8qkKzOOJHHSQEJYR1EdC9iOIpheiUjtYC4hdvxILtJzVc5kbmyJmlg743+
         vKeZgdU1g02eb7LYgyvYBklHakSgnHQlSUkfQjbqlEoEd2gxS3IJU5/a+Lly8/wdi6M/
         apcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353758; x=1722958558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgm4tMXjeK45j0cH4gjo52YvHllV/PKSl7WdTE3xniM=;
        b=QGf9IkNY6uRVhwnr1QKf+bHeIep5Ckl/P1f4sADD9oYWKLiwo2RZw4YSFMC1ltrgWm
         b06Qt9mlYDRzuFDE8LJE5vIQIPPqWrxxucd7J7D1iLoTLrCQIHQnsY+WchjZYLTgOUi6
         JhPqvptquAGYtK3GhJrNOFR26taauot0iNxiDTmqfnnFkTcS5y9tgRc/ZeSqVBNzopom
         aCEhgsbGtUNQqKtURsvTq/K4r5hUjirXMiHUQLoWKnpIfYH0aOCZwl6KLb/RLhVDS2iJ
         rXOr67kvumCqwWjTe6IqSPTgL5RgB2y/37XTCIKhUPLANKAB+cB+mzKocV3vEaQAa2pY
         9dbA==
X-Forwarded-Encrypted: i=1; AJvYcCX0TtKLTnIeUzIbrFkgdA9HAamSC/sPBQvpqLWYuVz6loDcmh3BsAPHdFN+z5vj6aow+6cLMCEHaucUXJ3bLmiooiP2Yg0qn8ETNgPR
X-Gm-Message-State: AOJu0YxwvJJZLtKoLyv720zuEQXGaQQ6A4fTa5mPOlJM9o7U1jWBmQ4O
	9H6t7ZBLw3x0NVz20lc0Ta98IcAnZY1hEat/RZcnllRKM5CtBPsWsarHdUsXUXw=
X-Google-Smtp-Source: AGHT+IFwgR/FSUJr5vYWtEToIUcR4XvSH2t1D2BZwYpAQ7Db0hrW06isM4fSK90pVXlhlmt5rElwCA==
X-Received: by 2002:a05:6512:3e1e:b0:52e:7444:162e with SMTP id 2adb3069b0e04-5309b2e0ae6mr9549185e87.55.1722353758305;
        Tue, 30 Jul 2024 08:35:58 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23654sm662678366b.32.2024.07.30.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:35:58 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:35:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 10/19] printk: nbcon: Use thread callback if in
 task context for legacy
Message-ID: <ZqkIXP22C7ovP-dn@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-11-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:30, John Ogness wrote:
> When printing via console_lock, the write_atomic() callback is
> used for nbcon consoles. However, if it is known that the
> current context is a task context, the write_thread() callback
> can be used instead.
> 
> Using write_thread() instead of write_atomic() helps to reduce
> large disabled preemption regions when the device_lock does not
> disable preemption.
> 
> This is mainly a preparatory change to allow avoiding
> write_atomic() completely during normal operation if boot
> consoles are registered.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Well, I would update a comment, see below.

> ---
>  kernel/printk/internal.h |  4 +--
>  kernel/printk/nbcon.c    | 54 +++++++++++++++++++++++++++++-----------
>  kernel/printk/printk.c   |  5 ++--
>  3 files changed, 45 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 12605e0aff11..bb02788acc7c 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -91,7 +91,7 @@ void nbcon_free(struct console *con);
>  enum nbcon_prio nbcon_get_default_prio(void);
>  void nbcon_atomic_flush_pending(void);
>  bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> -				   int cookie);
> +				   int cookie, bool use_atomic);
>  bool nbcon_kthread_create(struct console *con);
>  void nbcon_kthread_stop(struct console *con);
>  void nbcon_wake_kthreads(void);
> @@ -174,7 +174,7 @@ static inline void nbcon_free(struct console *con) { }
>  static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
>  static inline void nbcon_atomic_flush_pending(void) { }
>  static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
> -						 int cookie) { return false; }
> +						 int cookie, bool use_atomic) { return false; }
>  static inline void nbcon_kthread_wake(struct console *con) { }
>  
>  static inline bool console_is_usable(struct console *con, short flags,
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 69cecf97bf24..233ab8f90fef 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1294,9 +1294,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
>  }
>  
>  /*
> - * nbcon_atomic_emit_one - Print one record for an nbcon console using the
> - *				write_atomic() callback
> + * nbcon_emit_one - Print one record for an nbcon console using the
> + *			specified callback
>   * @wctxt:	An initialized write context struct to use for this context
> + * @use_atomic:	True if the write_atomic() callback is to be used
>   *
>   * Return:	True, when a record has been printed and there are still
>   *		pending records. The caller might want to continue flushing.
> @@ -1309,7 +1310,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
>   * This is an internal helper to handle the locking of the console before
>   * calling nbcon_emit_next_record().

This is not completely true when @use_atomic == false. The function
takes only the nbcon context. But also con->device_lock()
is needed for the non-atomic case.

We should either update the commit message. Or it might make sense
to move "con->device_lock()/unlock() stuff to nbcon_emit_one
so that it actually does all the necessary locking.

BTW: We could use this function in nbcon_kthread_func() then as well.

    */
> -static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
> +static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>  

Otherwise, it looks good.

Best Regards,
Petr

