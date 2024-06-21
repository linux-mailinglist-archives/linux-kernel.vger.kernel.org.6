Return-Path: <linux-kernel+bounces-224164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8101911DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D8FB23DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BD16F859;
	Fri, 21 Jun 2024 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SHKdsebm"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA016DEA5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956676; cv=none; b=lXw2QDW4ePST+D309MvtrBBcTe0ohaAadQUI8UQv+JI24ACUlqrMkVHoULw9QRaXmdv7Lw6caFlealC+pUIZCKXkAWrMVhCy7NM6gMuVgtK4ZEFcFCoAYFQh0AQ46qFpPNxQpu7Y31bvD5p3MPZs6ADXRtJCaxKlT7DUMZWULw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956676; c=relaxed/simple;
	bh=C+qp9GPyHh1N2C2oYj2p5PCzaBss2KIjhII2WxLRLcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+gIqIdfhG1YJG9ahuYEfOlHvQdUB4/sx0WWnUam71NXBQU62aNOUMZjISsp4ICbkovRYP+RzQ6Z2q6igJI0kf9Fs/vtJPi21ZlVEbhv8Kcq5F3hmNs6qy5YjvEsHfUZs3fWPCmWnCj4F6qe3drjTR6vy5XsmFs8NxBROf5KlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SHKdsebm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so20500381fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718956672; x=1719561472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhsKIUpVs1TdSA54MS8smHb/osJ9XEePDMz6uc60+M4=;
        b=SHKdsebmDqPeSKdTZYXEc03ijG56SHulAvXL3YkZ5iyc+lOJdabilz9vbS05JwAl1i
         tdm/wrLly19zYULdJQa28XfHWzK4KEpu2+F63hyhccKtjcOrTMmty6mECVibktWb6lAQ
         EzBGBIQB7oHQFqrRNn91pyJhZ5YgRGuRwUUechh3vwOTuB0bvz+IeJCVUXfOnpi84Be4
         IJeArdMpW5uNYDqVFVtbY5rKm36YkLEJmcccfDCuRNTprHueA8MSLgVa0/MiHOkaeQPq
         YvkRPwkrg4taQwQklhLtNxDO+w8R8ewac9dRfMUUD8uE6fWqnsarl1ftOXtXwp2DNNBY
         2PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718956672; x=1719561472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhsKIUpVs1TdSA54MS8smHb/osJ9XEePDMz6uc60+M4=;
        b=Apvfx5bsarhoq2NmPYlb/+yIRZJPkuTiJXGRFKl84MYR/kzl1QBPiBoHBRoWnkNzf+
         auYOWCcXJUI4L+dthWRW8LjzvnVvaElTx6zbPtQ40tIYWOhzW4224esMWn/yUPOl2Yj1
         bn2GG8/n46nNo2mNshyj5tf7Tspx2i+z0/8MZTthy9KFSADGLaCVWS0TMnu7ztRZ31ig
         cjPonI0MFqyMc1EJ+o6fSxHU5z/gbnZZvykQFp/+pmWOSdvvmp6E155YZJ1MJRmeh1vo
         7a5113lvC3No5NM9E2TQ/H93eX3+cA/z/79+Za7Kz/JJR96uK67/8YVCvGSzrV11Ctij
         w2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUu1b61tkbgBOI8U0HvuvWWeCHV9dNloPX1fUkCJL26Fvua90lMX6FHN7C+z3374Kq7Hsn7md1wVhOBOBUZ0Qp0/S/I7io6+7GpkGrs
X-Gm-Message-State: AOJu0YxzJIYsC/mxlr9vKfFwwoV5yxL8eqVl47jMhDvS5ZKNBYN5R6Wa
	7bNWEjp8mEpOs+kMW4y9nQjSL/FIu95cyoVY4U2WReOO0698BHHYt+Megp2Vrrg3CUOd8GveiCp
	l
X-Google-Smtp-Source: AGHT+IEGvQBKmN8D7BaAeOSyvISpb51HpJPvTwb871KJrb0o6vN4Rdh//iJ0n4JpwTkO40g8tJemcA==
X-Received: by 2002:a2e:99ca:0:b0:2ec:1d30:7303 with SMTP id 38308e7fff4ca-2ec3cfe0ccdmr50952631fa.51.1718956672410;
        Fri, 21 Jun 2024 00:57:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b053dsm811824b3a.85.2024.06.21.00.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:57:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:57:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com,
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com,
	aubaker@redhat.com
Subject: Re: [BUG] printk/nbcon.c: watchdog BUG: softlockup - CPU#x stuck for
 78s
Message-ID: <ZnUydTAC9lbTvF9H@pathway.suse.cz>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <87msni13lv.fsf@jogness.linutronix.de>
 <dtde47mfm3amxg4mbrnbct53ehpfbekdvrjhhd6j5tzl7lulwj@zwdsvkq3orag>
 <ZnKo_n9LJnMCPSCA@pathway.suse.cz>
 <xt5rhuygy2wwugsbdxemfrlkfcj6czfsmdkkjlqpmf4lcvc4pk@o6j6errohzfs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xt5rhuygy2wwugsbdxemfrlkfcj6czfsmdkkjlqpmf4lcvc4pk@o6j6errohzfs>

On Thu 2024-06-20 12:27:12, Andrew Halaney wrote:
> On Wed, Jun 19, 2024 at 11:46:38AM GMT, Petr Mladek wrote:
> > On Tue 2024-06-18 17:52:19, Andrew Halaney wrote:
> > > On Tue, Jun 18, 2024 at 09:03:00PM GMT, John Ogness wrote:
> > > Just in case I did something dumb, here's the module I wrote up:
> > > 
> > > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % cat kernel/printk/test_thread.c                         :(
> > > /*
> > >  * Test making a kthread similar to nbcon's (under load)
> > >  * to see if it also has issues with migrate_swap()
> > >  */
> > > #include "linux/nmi.h"
> > > #include <asm-generic/delay.h>
> > > #include <linux/kthread.h>
> > > #include <linux/module.h>
> > > #include <linux/sched.h>
> > > 
> > > DEFINE_STATIC_SRCU(test_srcu);
> > > static DEFINE_SPINLOCK(test_lock);
> > > static struct task_struct *kt;
> > > static bool dont_stop = true;
> > > 
> > > static int test_thread_func(void *unused) {
> > > 	unsigned long flags;
> > > 
> > > 	pr_info("Starting the while true loop\n");
> > > 	do {
> > > 		int cookie = srcu_read_lock_nmisafe(&test_srcu);
> > > 		spin_lock_irqsave(&test_lock, flags);
> > > 		touch_nmi_watchdog();
> > > 		udelay(5000);  // print a line to serial
> > > 		spin_unlock_irqrestore(&test_lock, flags);
> > > 		srcu_read_unlock_nmisafe(&test_srcu, cookie);
> > 
> > Does it help to add here?
> > 
> > 		cond_resched();
> > 
> > > 	} while (dont_stop);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > static int __init test_thread_init(void) {
> > > 
> > > 	pr_info("Creating test_thread at -20 nice level\n");
> > > 	kt = kthread_run(test_thread_func, NULL, "test_thread");
> > > 	if (IS_ERR(kt)) {
> > > 		pr_err("Failed to make test_thread\n");
> > > 		return PTR_ERR(kt);
> > > 	}
> > > 	sched_set_normal(kt, -20);
> > > 
> > > 	return 0;
> > > }
> > > 
> > > static void __exit test_thread_exit(void) {
> > > 	dont_stop = false;
> > > 	kthread_stop(kt);
> > > }
> > > 
> > > module_init(test_thread_init);
> > > module_exit(test_thread_exit);
> > > MODULE_LICENSE("GPL");
> > 
> > The touch_nmi_watchdog() caused that watchdog_timer_fn() did not see
> > that "test_thread" kthread did not schedule. By other words, it did
> > hide the problem.
> > 
> 
> Is it reasonable to consider removing the touch_nmi_watchdog()'s in
> 8250_port.c? There's some rather old ones, and some new ones with the
> nbcon transition, and they sort of made finding this issue more
> indirect.
> 
> Could be some valid reason they exist still, but to me it seems sensible
> to remove if we can't think of any good reasons.

Good point!

I believe that they were added because of flushing printk() messages.

This is the case of commit 54f19b4a6791491 ("tty/serial/8250: Touch
NMI watchdog in  wait_for_xmitr"), definitely. The others were added
before git history so that it is more complicated to check it.

Anyway, I think that it is not necessary to touch the watchdog on
every operation on the serial console. It should be enough to
touch them only around writing single printk record/message.
And it is better to do so in the generic printk cycle than
in particular console drivers.

Well, we need to make sure that the watchdog is touched in all
cycles flushing consoles, like console_flush_all() or
__nbcon_atomic_flush_pending_con().

Best Regards,
Petr

