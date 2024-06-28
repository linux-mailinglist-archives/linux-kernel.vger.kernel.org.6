Return-Path: <linux-kernel+bounces-233932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2691BF93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4EAB20C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2B1E4A1;
	Fri, 28 Jun 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TJ0F5hAf"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367251E481
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581585; cv=none; b=Y9ZQuQcmDYX5P5kXtBLACX3ZQQd2cE1DfFinYKoa2LTDktEMwQ86Ec4UpLw78T+40v7ht8zifpp+JdoMbgLkjinQhZLm6dSW1jSCDFItkNLiF5wv/lPsBgNhkIXd0d1h1WajmRAiuKBld8Zs8zQ++lfSIyCI4LIBuF4Z3FUuajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581585; c=relaxed/simple;
	bh=n9kWTMTK7JCDbkID1J92euC/9dyjlUgau6is7eksbls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzBH76RSo+Txixf1Rr9vpXSrLeW9Y5uvAPh+jmWKht6JkCAnFQoNC/zONhzO5MQtd+uXZYyJRT3/8lkIgx3FQVY8UJR2SuuKpo3J2HfK4CB7Oso3DjnhcFkvD1XOSnMFY+Lsa7s9B+ags+bbPkrMw7qRzkty84IfGA1dvA7PPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TJ0F5hAf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so6759351fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719581581; x=1720186381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6rPZUMuSi4ADyF686OqBZEn8J7FK8w8TCFqb/kA/fQ=;
        b=TJ0F5hAf/CWMsuBu+pHK5rymbzj+5NK8nhN+GlqL5+M4LGbvsHv8xy3jEpXKYRwefH
         wfMQM76sxHpEYzdLnQ8Qvy53crYa2wzbGgzDfYbIBjQgoBcyV0aRbEceleBj025HxMsm
         ds2pnzdH7rNZOpA30rAKjM0oXJyG4GaaJL8jTlW6JTNCmZVF86kIKgTlKXWD8aPkcccB
         F1I5u6RwYTanD1yM7pYiJqy5eg9LEiRhHyxypZwqWe6GXdJsjQWuzX5mR40PEHGVmkj1
         KPsBihNcOeR+TA4h7vzlJcEbQ54EUL9YqyuL4B/QgcP0ACCFSV7xCIeylw5hnQ44R6Jd
         xhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719581581; x=1720186381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6rPZUMuSi4ADyF686OqBZEn8J7FK8w8TCFqb/kA/fQ=;
        b=jhmEgpZn1SJsAp254SGdjCU8KDcqNB88zadrTYF9Qjnn9v8NlHIBj26AqxnWSZhLx2
         4C+yV2Jvf9syRkzQllaznAbgrbYhrEk3wepfcg4Qf4j+sXkPh+OLMYHB8Ig4c+t/xtzT
         gzhRgdZ/aVUZFJTovshJJQehlrAJBjhtfzbTcbUzJrZYctwuQaj4qh9jGIElAz+fxdIu
         mhB6pC/dbUvrOFDtO2WAbma9EBQAnZQNQQxHIreUgy6c/B8c2jW3lt9aSGB7xwJ4wGjj
         hLqpweEAM9RNfUa7+y+aQqS9T/G+KajRzvFiUIm6EpAHd4ek0JkbMs1AsS85/AUULcto
         wDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOW2u+/tVzgoiZXhOJlKZM7RyJVuXXdrgQHSeF8BgCUTSvhX79D2yiinIFStR/Jo/Aj63Oeq7jWdArHNpK1TO6ndoDGoet9rKgbLQR
X-Gm-Message-State: AOJu0Yy+B1zjAUoa3tbFKX7DwKJV2TT0ezSrPPGbZig7aPvqSDjK6zuB
	QgHi1DOaujbrNTHXBRc/4Hx/sAaquvfjUBUjxWcmrJ2hru1vyI3Et/Pt0Plel58=
X-Google-Smtp-Source: AGHT+IHj8ml0/+ZNwtzeTk8oDPn2OvJgKXPj6vFkFsJMm4VtCqspX8b0C/ll/qiA7gnoj03Bp937nA==
X-Received: by 2002:a2e:9d88:0:b0:2ec:51fc:2f5a with SMTP id 38308e7fff4ca-2ec5b36b1eamr103308001fa.4.1719581581261;
        Fri, 28 Jun 2024 06:33:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256af5asm1568816b3a.56.2024.06.28.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 06:33:00 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:32:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <Zn67hDCEHdgtYPv3@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
 <87cyo1xnmw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyo1xnmw.fsf@jogness.linutronix.de>

On Fri 2024-06-28 14:28:47, John Ogness wrote:
> On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
> >>  		 * to handle it.
> >>  		 */
> >>  		do_trigger_flush = true;
> >> -		if (printing_via_unlock && !is_printk_deferred()) {
> >> +		if (!force_printkthreads() &&
> >
> > Is this correct? We still need to flush the messages directly
> > when the legacy kthread is not ready yet.
> 
> No! If force_printkthreads() is set, messages will never flush directly
> except for console_flush_on_panic().

But this is an _emergency_ context! This would be inconsistent with
the nbcon consoles where the messages are flushed directly.

Is RT sheduling quaranteed when the system reached emergency state?

In fact, we probably should not check force_printkthreads() here at
all. It would be only for NBCON_PRIO_NORMAL context.

Or the option should force the kthreads even for nbcon consoles.


> I see that I implemented get_init_console_seq() to flush since it is
> known to be in task state. But that is wrong. Also there it should not
> flush directly. It is not about whether or not printing is safe. It is
> about deferring to the thread 100% of the time except for panic.
> 
> >> +void nbcon_legacy_kthread_create(void)
> >> +{
> >> +	struct task_struct *kt;
> >> +
> >> +	lockdep_assert_held(&console_mutex);
> >> +
> >> +	if (!force_printkthreads())
> >> +		return;
> >> +
> >> +	if (!printk_threads_enabled || nbcon_legacy_kthread)
> >> +		return;
> >> +
> >> +	kt = kthread_run(nbcon_legacy_kthread_func, NULL, "pr/legacy");
> >> +	if (IS_ERR(kt)) {
> >> +		pr_err("unable to start legacy printing thread\n");
> >> +		return;
> >
> > Is this acceptable for RT, please?
> 
> It is not acceptable for mainline. For the next version, any failed
> thread creation leads to unregistering the console. In the case of the
> legacy thread, it will mean unregistering all legacy consoles on
> failure.

It means that the system would become silent. Is this a good idea?

IMHO, we have a fundamental problem here.
Are RT guarantees more important than printk() or vice versa?

What is happening when the RT guarantees are violated?
For example, when the scheduler detects a problem?
Does it panic() or tries to continue?

From my POV, silent system is the worst solution. The user
might think: "no messages, no problem".

Best Regards,
Petr

