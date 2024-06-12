Return-Path: <linux-kernel+bounces-211259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E68904F30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABC71F26585
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9416E879;
	Wed, 12 Jun 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P/piD8iE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6F16E877
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184278; cv=none; b=oRAJ/3mZr1f7UFMwixMN4SiCrIC/TI6A8prqJ+6FZHGi8tnWJzLu8KYpNE5LxjDFrrHQmoiuYhQmR1E06/QMje99oDX0D8UOIxy+c6xBEC9IfMnS79+iFANpddXGblUxzhZc1LxHTZ3iV6d8gpVRE1KhelI/6VWPIoFgkPGXEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184278; c=relaxed/simple;
	bh=L1eYFsd2ZgDDc2zAssruJiNBzTzfkCoqlRXj8Y5zH0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7bkfZ1v/tSbMP0BEUrLTUCHnv06817cvDiIUEe5AVkgBXBJR6O/qvJy4w/Ehyufm/zzli/5KBWbCDa9vjOZXrs0je1zsp6gZDLCMgp1jwUN2GNErS6G8c4a47IBC0mQX3BJHnn5jOiC7Ca+SDlqVauwZkX+Dz8UaYmS3GdkOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P/piD8iE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f1da33826so274484866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718184275; x=1718789075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDuh1x6nDx2yqhwN8jMaJp/Vu3DrJ767UoGOq8Ogv9s=;
        b=P/piD8iEDYQboKIRa/lXleOQpWgVatrddvKLr5s2EdAx8lSZI5uBswfkcRYprcCGbQ
         SUT0Ih18pUHZpKtSet01Wo/XU7Pm3r5M8/mru6XQ7L0L3YzvEfHryD0it3Z4Po+1U7Dl
         QD9J20udmbSX67VtUB5t2W7V7B0EP9k+SBrCzT2HLhhzYJzGa/vK2fQl8LjfYX0r3hJs
         +Zcivt3ZLRKwxZ65fBEGn2n8np1Eb4C9q1zP7tNKliNRsDE9mJv/jv0gzPR59RDjnEkD
         TPW4iRNLH7ZAZHGaKZk9r5nWjt2hSYhxYprCGJjN/VSbKDoNYut2DpSYhxvwclyL88Ne
         wrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184275; x=1718789075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDuh1x6nDx2yqhwN8jMaJp/Vu3DrJ767UoGOq8Ogv9s=;
        b=jfyAQG0R0kfO4/rpbEyOTeN5RhPbx8KSzwzvuIpbl3lt2jC/heiq8xCOoRDP6Z7HMw
         vYDNdXbNtsAYdqM08OD0qiJ563pjy+VbGLpChD74BoOaJ1BTuJf4V3uB17uC68koyxJR
         EtHvtpfnB2gbB5XRLxtfkgtl9wyxxxlqX0enZKQH80DiAfCh3hk4cZ0vaTXzTLRbm1eF
         WEP4XHjgrr7gPbjDEE5E3Vs+ydDfSJgEsBkoYIfXJaulvJL1KcySabM4H/oDcwOAOzrJ
         sYhlfY18P68eytXnLGKYlbtXYIrVlnBN/RlMH9p4GXWCw+VOTk4Qx29KIKCChf1nQ/cg
         ErEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9VOBoocynepS/ii5zPounIZnGvmPaRXwo6IJZRnEGLc6fO6xKFKPhzs1MMDB4r1H3QUshxoWPYzq5xRsxUncmQYYD6XObuSkG1O83
X-Gm-Message-State: AOJu0YyXGtcxIxBjVK2hWq7cUi7DWou7oYq2ai5r0vJ+mq5K/3Ad+R//
	OwXzfAWiOLjyC7ExSsUFMamE3y/7Cqvh11CGS0aXGFMEPGBKWI3X1kFpiu0KnIU=
X-Google-Smtp-Source: AGHT+IGywukrXVrgPfJuE6gJFMPhIIJp5jgER+XVrwFbw38D+FLyFqrjFx604EpzXCllNIp8efxJCA==
X-Received: by 2002:a17:907:1186:b0:a6f:e93:f8f1 with SMTP id a640c23a62f3a-a6f47d4eee4mr103265366b.14.1718184274688;
        Wed, 12 Jun 2024 02:24:34 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1d8369casm389439466b.225.2024.06.12.02.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:24:34 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:24:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing
 kthreads
Message-ID: <ZmlpPucSy8Topb5h@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz>
 <87ed95j8yh.fsf@jogness.linutronix.de>
 <ZmhkVAC_3FMohrEr@pathway.suse.cz>
 <87sexipmrk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexipmrk.fsf@jogness.linutronix.de>

On Wed 2024-06-12 10:57:11, John Ogness wrote:
> On 2024-06-11, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> The thread failing to start is a serious issue. Particularly for
> >> PREEMPT_RT.
> >
> > I agree.
> >
> >> Probably it should be something like:
> >> 
> >> 	if (WARN_ON(IS_ERR(kt))) {
> >
> > Might make sense.
> 
> I will add this for v2.
> 
> > Honestly, if the system is not able to start the kthread then
> > it is probably useless anyway. I would prefer if printk keeps working
> > so that people know what is going on ;-)
> 
> OK. For v2 I will change it to fallback to the legacy printing for those
> consoles that do not have a kthread.
> 
> > After all, I would add two comments, like these:
> >
> > <proposal-2>
> > 	/*
> > 	 * Any access to the console device is serialized either by
> > 	 * device_lock() or console context or both.
> > 	 */
> > 	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name,
> > con->index);
> > [...]
> >
> > 	/*
> > 	 * Some users check con->kthread to decide whether to flush
> > 	 * the messages directly using con->write_atomic(). But they
> > 	 * do so only when the console is already in @console_list.
> > 	 */
> 
> I do not understand how @console_list is related to racing between
> non-thread and thread. kthreads are not only created during
> registration. For example, they can be created much later when the last
> boot console unregisters.

I had in mind two particular code paths:

  1. The check of con->kthread in nbcon_device_release() before
     calling __nbcon_atomic_flush_pending_con().

     But it is called only when __uart_port_using_nbcon() returns true.
     And it would fail when nbcon_kthread_create() is called because

		checks hlist_unhashed_lockless(&up->cons->node)

     would fail. Which checks of the console is in @console_list


  2. The following check in console_flush_all()

			if ((flags & CON_NBCON) && con->kthread)
				continue;

     The result affects whether the legacy flush would call
     nbcon_legacy_emit_next_record().

     But this is called only for_each_console_srcu(con)
     => it could not race with nbcon_kthread_create()
	because this console is not in @console_list at this moment.

By other words, I was curious whether some other code paths might
call con->write_atomic() while the kthread is already running.

It is not that important because it would be safe anyway.
I was checking this before I realized that it would be safe.

Anyway, the information about that the console is not in @console_list
when we set con->kthread still looks useful. At minimum,
the check would be racy if the console was on the list.

Does it make any sense now?

> I am OK with the first comment of this proposal. I do not understand the
> second comment.

Feel free to propose another comment. Or you could ignore the proposal
if you think that it does more harm than good.

Best Regards,
Petr


