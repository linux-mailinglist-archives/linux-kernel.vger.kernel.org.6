Return-Path: <linux-kernel+bounces-199335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E08D85B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC571C21CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4A1E4A8;
	Mon,  3 Jun 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOYJ4t8k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5794688
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427093; cv=none; b=Od7VcnMZVcqos2KcW1lVYodZpVGitAOKZIHm+978WL6eJUPdDBV2i51tmZG3P6LCDRZT52mVX65wJDCEWlZRykt1pZX4swLvgNOqiOO13ru3mjM5pm+3QZMDYNRxx5dzj/8jy4jStZyo2ynidWvDqtKcNCD+PMGysZwC8TwgDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427093; c=relaxed/simple;
	bh=88kI+riU9Oh93UNPrHzY+gClgmBM46CaGhKGQnVncf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umUh1IspkhKe5dgzBR38GJhEwO9C4P+ng8tfHYaKoU59c01rc323RQ1i5X5mtQFJ0ec10JhoOubdOZyvq1NB3+5w37jv8IQSepyQ54acc++4OpEWL8Ru/j8bB7lEJdy0Qy2MptMoCGWCKBMtrQ74ZBj3wjDYDAJZLAvbXyscMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOYJ4t8k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717427091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hSP7uT+GwnJuqCrKWe61V7eti5NONprO/a97gKxkynU=;
	b=YOYJ4t8k5eKhuJgkcUtjXZbLW8XXaO6/xibb9z4sZXeqZgCRc0GdTURw2qjdBZsGOTjpYH
	NbImmpnACIyn29jUsaVVG+dTV4/sILG9ShTPArCv+TudjK2gmw6OGFPHFwgkUn6ecvm2So
	4SHBVaiqyy9oojNgoUJaw5WJPeQt+5w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-Pd_58nfsNgK1vb0SKLtDeA-1; Mon,
 03 Jun 2024 11:04:48 -0400
X-MC-Unique: Pd_58nfsNgK1vb0SKLtDeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FB973806707;
	Mon,  3 Jun 2024 15:04:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
	by smtp.corp.redhat.com (Postfix) with SMTP id E8A9F103A3B1;
	Mon,  3 Jun 2024 15:04:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Jun 2024 17:03:19 +0200 (CEST)
Date: Mon, 3 Jun 2024 17:03:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <20240603150317.GB388@redhat.com>
References: <20240530124203.GA26990@redhat.com>
 <20240602102007.GA27454@redhat.com>
 <87jzj6789b.ffs@tglx>
 <20240603134100.GA388@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603134100.GA388@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 06/03, Oleg Nesterov wrote:
>
> On 06/03, Thomas Gleixner wrote:
> >
> > On Sun, Jun 02 2024 at 12:20, Oleg Nesterov wrote:
> > > @@ -1891,8 +1891,11 @@ void hrtimer_run_queues(void)
> > >  	 * there only sets the check bit in the tick_oneshot code,
> > >  	 * otherwise we might deadlock vs. xtime_lock.
> > >  	 */
> > > -	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())) {
> > > -		hrtimer_switch_to_hres();
> > > +	if (tick_check_oneshot_change()) {
> > > +		if (hrtimer_is_hres_enabled())
> > > +			hrtimer_switch_to_hres();
> > > +		else
> > > +			tick_nohz_switch_to_nohz();
> >
> > hrtimers have no business with tick_nohz_switch_to_nohz(),
> > really. That's a strict tick/nohz specific thing. hrtimers do not care
> > about NOHZ much. They care about whether they can switch to high
> > resolution mode.
>
> OK, lets forget this patch then.
>
> But note that the comment above the tick_check_oneshot_change() says
> "switch to highres and / or nohz mode".

But yes, please forget this patch ;)

Currently hrtimer_run_queues() doesn't return if tick_check_oneshot_change()
itself calls tick_nohz_switch_to_nohz() and returns 0.

Oleg.


