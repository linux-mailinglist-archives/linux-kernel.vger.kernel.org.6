Return-Path: <linux-kernel+bounces-192280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4788D1B00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBDFB20CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86AA16D4C7;
	Tue, 28 May 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSND4zGG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290373465
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898844; cv=none; b=T1TzsPPmdMtIYCFt3yPUY25AhfKsggLLdwHCxwQfZ9s+etRQ1QiPKbGX1q3mDmmTsTtPAmzfn3bTNNhGWHrnmFwZTCFy70fd6INSZFnBQXMpvZA49qijKgQDyCZgbu8aAbhaXFiQY3QHuhcrJAUDiJCc1oSLw86DwUwIVhjDTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898844; c=relaxed/simple;
	bh=gnb7l7Zqs9bKnVdTMfb7gTGhZomF/iQ+TFVkZCMl4fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3+R8Pvyb9564IwMdao7wEB09yPoj6ER/AQzSZizBxb6fk6C4jwYQ4dePM3WzSZDfWYIpbFe5d1yzHqQkADfc/12rjEtuMVjI0hrQMDCEUqnRPiz3JhgSBqpa/tq67U7JvlU9v4dqrJBbtp6JN+iOfgzf4QT/6z//5aUM6y5XZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSND4zGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716898841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnb7l7Zqs9bKnVdTMfb7gTGhZomF/iQ+TFVkZCMl4fs=;
	b=QSND4zGGdTxoIDSovtZMK4tYzQwaczAKNSVLmbc7QXnegvxpCMDo4U/FK8NNEz+y+H1SjF
	1W9xV+UtW4bwM1GdLPW/S7hr0RqTiJkUovOMjaQIEKsauUmtUZM5YuBbgoyFdyJn5yTL7k
	fzkomFh6Vd9d2G7qS0oCPsZNBuSMkW4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-NcRN_a9_MgGWNuH_VVt1pg-1; Tue,
 28 May 2024 08:20:38 -0400
X-MC-Unique: NcRN_a9_MgGWNuH_VVt1pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D10D629AA388;
	Tue, 28 May 2024 12:20:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.131])
	by smtp.corp.redhat.com (Postfix) with SMTP id BDFC72818;
	Tue, 28 May 2024 12:20:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 28 May 2024 14:19:09 +0200 (CEST)
Date: Tue, 28 May 2024 14:19:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240528121906.GA14593@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
 <20240526192758.GA21193@redhat.com>
 <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
 <20240527155739.GB5733@redhat.com>
 <D1KVETKKSRHL.18ZTVKAN8JS3Y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1KVETKKSRHL.18ZTVKAN8JS3Y@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 05/28, Nicholas Piggin wrote:
>
> >
> > So, Frederic, Nicholas, any objections to the trivial change below?
>
> Since Thomas says it's alright, then no. I guess I added it because I
> was not certain about taking the tick_do_timer_cpu while the boot CPU
> could be running a timer interrupt.

I thought about it too, but didn't see anything wrong...

Suppose that WRITE_ONCE(tick_do_timer_cpu, cpu) happens right after
tick_periodic() on the boot CPU sees READ_ONCE(tick_do_timer_cpu) == cpu.
Does this really differ from the case when tick_take_do_timer_from_boot()
waits for the boot CPU to return from timer_interrupt() ?

> I would take some of his comment to explain the race is harmless and
> put it in that if block.

Yes, yes, sure. See the patch I'll send in a minute.

> Out of curiosity, you are getting this going on x86?

Yes, and I didn't check other arch'es.

> Any particular use-case?

I have no idea. I noticed this problem when I was working on 5097cbcb38e6
("sched/isolation: Prevent boot crash when the boot CPU is nohz_full"), see
https://lore.kernel.org/all/20240411165936.GA20901@redhat.com/

Perhaps Chris who reported that problem can add more details.

Oleg.


