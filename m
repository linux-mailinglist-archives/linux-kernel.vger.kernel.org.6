Return-Path: <linux-kernel+bounces-237511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA54923A14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA01F21891
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29C150993;
	Tue,  2 Jul 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ek5oh6EC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955717741
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912649; cv=none; b=hqUl2L1fBtawYHsMok6bxCIGHDHiZtuoRZpahG2X00BIaMb4/pQQjnhXBIChG4b89Vnk25BB3AYqOHivm7CPZx/8bFlWYLi0sbAYVQ8YP9jDIJYH4Ayqw73Qd3zTuU8kf9Ltho/5Un5TbaNjqse2dSInc+jJTFgfbg6OejIpfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912649; c=relaxed/simple;
	bh=9wZMt4XIKtzsHJGnA6q+tBhSLGvVzwp7kne8YAJ4ON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjTq2doxYs/T3yoQCnuDJ6lpVuA3exBHZglNTzkxfA2JjQ1ear/29w8tfzn+sSD3TP2X6dY4gV+lg48biWDqKl13/t6jug8r2qYq6wiuFYVsP/iS2iP3Kqfd5OQ3M6AJh2KNe8wYS09tHKOZwmK4Aek93N/NGFjZRFyK0zfQ4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ek5oh6EC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee794ec046so1749651fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719912645; x=1720517445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuIsxk1T213WYy8gsWuEjbMwN3Poo3nOOrSb0iGSbOY=;
        b=ek5oh6ECv3ojeOT9KAD6eQVsl6bZFv2RPUs8Fj8+qWrzZd3vKX8Gv27gPRLA6YLLLn
         nk/4yRC83X432Tu0LRtpNzWRGcaUpDENGXQsTU8V3/SD3gOa7dQZEZygwsHKsvOlR4bw
         rOxMskN5le3kQ6w6nK1pWxOR2ZdjkvVDkuDLyOTaaljmZ2pmULlHCoyXZgeGQBE+s67N
         EfCtu/jI8IL5ed9YoMCSrTomOIikO90U9Lul+PoU9P9WAUjvVdxy+Ab5WSrHHn5zFa4P
         tJ6EaBYsjZ7NXnhwmqHCiwwfUGWo/X7C3AFMeaUmj5/Udn94TJrMn0RT4cjiNgvHqnVZ
         SalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912645; x=1720517445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuIsxk1T213WYy8gsWuEjbMwN3Poo3nOOrSb0iGSbOY=;
        b=oPN6EfMJX8eGqpB1GCcLejpI/oXslulTPkpKfsMiey63l7G5bUyeUfvuFudKB0A4OU
         yLIj0hl1KOm5nqvJE7a0+vynSAW+Gy6pfYJNfr1SBX661O7ivuX1KUatjGGh+DNk3q55
         WolpWXikM+xgbYbrMMsTBVk7HjZvu9xuskjsZXPjIgbd/lU0lxdGebkZKmTQoaw3tFVW
         lVR1jBdP6GhpUXGyDxDivMsirQr/1NQ/piaxdI1LE38zofFf3M6ovjCIExD3KVDN2R3/
         Az2PXM2AoKWpfdcMj7Nq9SpBjUgqQsnq5Sn8VtHhYviTzSAxJbOCO4eu8yLzAvhUyUdQ
         zm+A==
X-Forwarded-Encrypted: i=1; AJvYcCWaPQnYxWvn35uR535NbjGBeT+quEz/CQTWDbdmylQaK55Uyfh5E71U57ZjT/zFnfRSTlUdjfjtAYFcl/NfTmXQQJoaaybKHlNR8Nq5
X-Gm-Message-State: AOJu0YzGSBntLMhN408UQyStFJBICTK8kjPU2c3hFc4W0yYrXM9VR3pE
	PWjCd/P4ofzueOMt6FeUcW50pqEh4L0ysAJyD7r2udZyzvSgxQ+NTpGfopa+x48v6mHCnknplOG
	Q
X-Google-Smtp-Source: AGHT+IFyoXc0eDp9A4bdmO+DVOA0xE9bWlJ17XsgQKXgjzpgCx/c/dZZ0193bS9tXJ9JaLMJmsJxVA==
X-Received: by 2002:a2e:bc84:0:b0:2ee:4c72:204e with SMTP id 38308e7fff4ca-2ee5e2c7592mr68018441fa.0.1719912645184;
        Tue, 02 Jul 2024 02:30:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fafb9c3fbfsm8788475ad.12.2024.07.02.02.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:30:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:30:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <ZoPIvPtN1rmrds4a@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
 <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz>
 <877ce9xim6.fsf@jogness.linutronix.de>
 <ZoLCLfcIjQ6FbgR0@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLCLfcIjQ6FbgR0@pathway.suse.cz>

On Mon 2024-07-01 16:50:31, Petr Mladek wrote:
> On Fri 2024-06-28 16:17:13, John Ogness wrote:
> > On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> > > On Fri 2024-06-28 14:28:47, John Ogness wrote:
> > >> On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> > >> >> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
> > >> >>  		 * to handle it.
> > >> >>  		 */
> > >> >>  		do_trigger_flush = true;
> > >> >> -		if (printing_via_unlock && !is_printk_deferred()) {
> > >> >> +		if (!force_printkthreads() &&
> > >> >
> > >> > Is this correct? We still need to flush the messages directly
> > >> > when the legacy kthread is not ready yet.
> > >> 
> > >> No! If force_printkthreads() is set, messages will never flush directly
> > >> except for console_flush_on_panic().
> > >
> > > But this is an _emergency_ context! This would be inconsistent with
> > > the nbcon consoles where the messages are flushed directly.
> > >
> > > Is RT sheduling quaranteed when the system reached emergency state?
> > 
> > No.
> > 
> > > In fact, we probably should not check force_printkthreads() here at
> > > all. It would be only for NBCON_PRIO_NORMAL context.
> > 
> > On PREEMPT_RT, legacy consoles are not allowed to print from
> > non-preemptible contexts because they use spinlocks (rtmutexes).
> 
> Ah, I see.
> 
> > This is a disadvantage for legacy consoles on PREEMPT_RT. If people want
> > a legacy console to gain the reliability attribute on PREEMPT_RT, then
> > that console _must_ be converted to nbcon.
> 
> Makes sense.
> 
> Thanks a lot for explanation.

It is clear that the legacy consoles could not be flushed directly in
nbcon_cpu_emergency_exit() with PREEMPT_RT. I thought whether we
could/should allow this for other preemption modes.

My opinion. Let's keep it simple and behave the same in all preemption
modes. force_printkthreads() is enabled only in PREEMPT_RT by default.
Users would get the "expected" legacy behavior in other preemption
modes by default.

By other words, let's keep "force_printkthreads()" to really simulate
RT behavior also in other preemption modes.

That said, I still suggest to rename the variable/function to
"force_legacy_thread". It does not affect the behavior of
the kthreads for nbcon consoles.

Best Regards,
Petr

