Return-Path: <linux-kernel+bounces-189021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F948CE9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F177F1F22B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0943AD5;
	Fri, 24 May 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWhowe0b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF2433C9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575918; cv=none; b=ufqBxEnsmOEvCBrUwOujjzwicG/P1/an5hWmrNC7JjrBMM5sUZo5+JpsWyuyYKoPpnb0R04Zi4nOSbA4uvknjthtZb4peSmZHIbwoVz1VoE6sCA4I1pPidND7tx7y7V6768E6XF7utnEfVTFAUxwXGlCrwb+z0C6VOg2yJpWpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575918; c=relaxed/simple;
	bh=qkmiCTDIp+RlY9SVudQLTucZW/DhqQCY5MQH29yXiSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6HjpVd+h/5JB4aFEdo6Q5dv9Q+lUMDFa03vKCW9mxZBZYBJt4eyGL5BkBLeXrEFZWp8sqqAtFLGQcUq9j2r604mel2cLtk/FZBiCUp/B8QiVEg+uBAPqlYN41/4g0wfkL455r2a7DaT++x/YcSdvfyQiVZv0+xcom1gc3jJqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWhowe0b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716575915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWsJyQ6rLMkevxfFKkLWUkPGRkXnJQrmFjIwpW29V3U=;
	b=DWhowe0bSwLOoYa8OqUbh6ukQZK5SRvVfXQmsne6H2E2wU7Yjs47YCOw1upbI4nTfmepao
	Y5nRb+N1yMvuYWnvsNxnSOibsy4ghfay2Vl47GeXlyazHp3zROuWwQstvxbiaho5FOqT7U
	HlUpDbGcl0LF+Fc7cy4LygX9gTBUcmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-MINCGCs2OGuRWCsTmzrC9g-1; Fri, 24 May 2024 14:38:30 -0400
X-MC-Unique: MINCGCs2OGuRWCsTmzrC9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A4F8058D1;
	Fri, 24 May 2024 18:38:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id 15A5F492BC6;
	Fri, 24 May 2024 18:38:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 May 2024 20:37:02 +0200 (CEST)
Date: Fri, 24 May 2024 20:37:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240524183700.GA17065@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCwKk65-eL0FrKX@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Frederic. Thanks for looking at this!

I've already had a few beers today, I know I'll regret about this email
tomorrow, but I can't resist ;)

On 05/24, Frederic Weisbecker wrote:
>
> Actually... The boot CPU is nohz_full and nothing prevents it
> from stopping its tick once IRQs are enabled and before calling
> tick_nohz_idle_enter(). When that happens, tick_nohz_full_update_tick()
> doesn't go through can_stop_idle_tick() and therefore doesn't check if it
> is the timekeeper. And then it goes through tick_nohz_stop_tick() which
> can set tick_do_timer_cpu = TICK_DO_TIMER_NONE.

Heh. May be you mean, say, tick_nohz_full_update_tick() or
tick_nohz_idle_update_tick() which check tick_nohz_full_cpu(cpu).
Yes this doesn't help during the boot, and this was another source for
confusion to me.

But again, again. tick_sched_do_timer() says

	* If nohz_full is enabled, this should not happen because the
	* 'tick_do_timer_cpu' CPU never relinquishes.

so I guess it is not supposed to happen?

And. My main question was: how can smp_call_function_single() help???
Why do we actually need it?

Thanks ;)

Oleg.


