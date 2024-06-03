Return-Path: <linux-kernel+bounces-199239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08898D843F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE99289A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0312DD8A;
	Mon,  3 Jun 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acmdbPFN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD912D766
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422160; cv=none; b=PWJSb2THq4GeDA1PDyWgCjVHvyjI/51Bq1awYEWcK44fAXR30olSU83PGe2eElug00BcRuv5Ttg45W0icPwthJ2xNweWbHThm4SQr1eSy5SENCK5dJYh0e9/eCts47UppsR+llsLEG2PoVUJiD5BtLWUBj20ucPLfKxS29MLa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422160; c=relaxed/simple;
	bh=fucPh4NT8afq/yJKF9Csi293Nc1OxsYl4BBLX3mkZgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgu8BhcxIHurrmQ802sZuXkJSSje8cRDrlNyG4U+INUbiB2wPpkfKkcnvTtA0Js76HPQDBESatX7kTGDbnPTXgc0YcbEHZoC9BV5JyHXtmPGA3Ee755DGxCDcsFCDY90/D/Wj7LPUv8mLCzeskQT3r8wDNbTdDkH9XniKoIWJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acmdbPFN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717422158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XiDMYcq96Z7HWc66TmciFozG2sGDtvjwN27J1yBx8E=;
	b=acmdbPFNBEppepSlZCniWH1t8w8HBMilHLFaUbdyOsWn9zY/onkyGzstJkBBLgZrZnnsnQ
	BgG3HFr+wlOsesInihjgl+lRXuEoadjxq0Y8UwYE+g9uBVY59a8MW/igo601PROwjy3G21
	grQw1+sHb08au+F2rH1FM166AUKI4cE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-HxOPD2R1O7ylb4JT3OAfXw-1; Mon, 03 Jun 2024 09:42:32 -0400
X-MC-Unique: HxOPD2R1O7ylb4JT3OAfXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F697800CA5;
	Mon,  3 Jun 2024 13:42:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
	by smtp.corp.redhat.com (Postfix) with SMTP id B788E2011C42;
	Mon,  3 Jun 2024 13:42:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Jun 2024 15:41:03 +0200 (CEST)
Date: Mon, 3 Jun 2024 15:41:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <20240603134100.GA388@redhat.com>
References: <20240530124203.GA26990@redhat.com>
 <20240602102007.GA27454@redhat.com>
 <87jzj6789b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzj6789b.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 06/03, Thomas Gleixner wrote:
>
> On Sun, Jun 02 2024 at 12:20, Oleg Nesterov wrote:
> > @@ -1891,8 +1891,11 @@ void hrtimer_run_queues(void)
> >  	 * there only sets the check bit in the tick_oneshot code,
> >  	 * otherwise we might deadlock vs. xtime_lock.
> >  	 */
> > -	if (tick_check_oneshot_change(!hrtimer_is_hres_enabled())) {
> > -		hrtimer_switch_to_hres();
> > +	if (tick_check_oneshot_change()) {
> > +		if (hrtimer_is_hres_enabled())
> > +			hrtimer_switch_to_hres();
> > +		else
> > +			tick_nohz_switch_to_nohz();
>
> hrtimers have no business with tick_nohz_switch_to_nohz(),
> really. That's a strict tick/nohz specific thing. hrtimers do not care
> about NOHZ much. They care about whether they can switch to high
> resolution mode.

OK, lets forget this patch then.

But note that the comment above the tick_check_oneshot_change() says
"switch to highres and / or nohz mode".

Thanks,

Oleg.


