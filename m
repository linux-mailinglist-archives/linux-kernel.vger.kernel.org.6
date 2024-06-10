Return-Path: <linux-kernel+bounces-207743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA9901B60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2C3B21E22
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584DB1865B;
	Mon, 10 Jun 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cvT1k5JL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F42582
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002033; cv=none; b=VFwazb8/Ia9q/wjC8XXiTVRuPxelKzrSaWHaBHeu7L6KP9fhM5GZjsGtMqDBdWNrGX4GUX9Ls71CrzQYIA7rkb3JQdbp0nqnb+D9h2+mSo/Xq5ywWQyjlekoNxi8QstcZQGAVbudsMlB4+bCsz7uhF7GzGQTSSxKkDOuW6JVJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002033; c=relaxed/simple;
	bh=bkTdS5UF9BBXXB3SvVtm1jZQ0RuPc/f1jwO5uRomwNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1EzME/MtDc5CXC0Cc1w70A95srZutDZ2ejjWHhbrlr+bog8JDKLwVKO/ejRWQ87wXlOAK+53kX5PbmrKVx9NxE9WstOEWUA5gjjmWjUrqpq8XtS8/8PO67OHVRD7e+MCV0XbP3V/1NSHVdwHL9+P5ejSPD+IFv5oX2AYznhGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cvT1k5JL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y8mq8NFiBXisZKfoul6E8pG6esRWXllJmw5nWndqT/4=; b=cvT1k5JLmiMm2dcf78WNc4v1Fz
	CkBaFdMHmYat4rVhES8RaQOjpshx3n5PqWFT5LUmYKuGSHUzQlNe/NcEf+TgOhzDIF2vi89/tD6mf
	74OA4udNwUf9jUPR4md5nQJwWdPvkJE0xIKvaS1o6/ERourIuJHE6c6SPmavZOgHNhTnVSp/SSof8
	oM4Ga2tQP0roKeuXlpDvZDXzY2w4jy2fi3Tv+47J0h5XSB3uINnAYPTXdzF3+E+0XDDGGMcf+2OTO
	b4BAbbrMg+qcwvE1h0lGUrPfVvZLzAOtR9enDp3Draz+aHAooiM27g5GKRY600JEbp0zZL465fi8T
	0PE5iO2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGYno-00000001Fc8-301b;
	Mon, 10 Jun 2024 06:46:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4902E300362; Mon, 10 Jun 2024 08:46:51 +0200 (CEST)
Date: Mon, 10 Jun 2024 08:46:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	syzkaller-bugs@googlegroups.com, jpoimboe@kernel.org,
	jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
	Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
	hpa@zytor.com, xrivendell7@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
Message-ID: <20240610064651.GS8774@noisy.programming.kicks-ass.net>
References: <20240609090431.3af238bc@gandalf.local.home>
 <87o78axlbm.ffs@tglx>
 <20240609102530.0a292b07@rorschach.local.home>
 <87le3exfx2.ffs@tglx>
 <87h6e2xdg1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6e2xdg1.ffs@tglx>

On Sun, Jun 09, 2024 at 06:56:14PM +0200, Thomas Gleixner wrote:

> Ok. Now I found if for real. It's in the jump label core:
> 
> CPU0                            CPU1
> 
> static_key_slow_dec()
>  static_key_slow_try_dec()
> 
>    key->enabled == 1
>    val = atomic_fetch_add_unless(&key->enabled, -1, 1);
>    if (val == 1)
>    	return false;
> 
>    jump_label_lock();
>    if (atomic_dec_and_test(&key->enabled)) {
>       --> key->enabled == 0
>       __jump_label_update()
> 
>                                 static_key_slow_dec()
>                                  static_key_slow_try_dec()
> 
>                                     key->enabled == 0
>                                     val = atomic_fetch_add_unless(&key->enabled, -1, 1);
> 
>                                     --> key->enabled == -1 <- FAIL
> 
> static_key_slow_try_dec() is buggy. It needs similar logic as
> static_key_slow_try_inc() to work correctly.
> 
> It's not only the 0, key->enabled can be -1 when the other CPU is in the
> slow path of enabling it.

Well, the -1 thing is in the 0->1 path, that is, the very first enabler.

That *should* not race with a disabler. If it does, there is external
confusion. (As I think the follow up email shows..)

