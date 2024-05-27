Return-Path: <linux-kernel+bounces-191179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C778B8D07B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0092975EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8261167D90;
	Mon, 27 May 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhvEpwpp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AF16728E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825527; cv=none; b=jIZn+h9mGAM7A1kwnbDqce5xqzLDGAqPp3y0oIc9j4HjUWxTC/lzV0k9DP1oEql8pJGlTCnV+M4vrNjuVM7r15353NPHZaxGXCS5leI+hYmmxr6o7wyz71d5LtqqkW9NhdHC/xEZBHSKTRqWWXh28YxzdlAeLcGi7J77pGVVDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825527; c=relaxed/simple;
	bh=4EUBGrUVhm/r5cBtJVBlRDWc/A8E3//UXsSF13PgPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDQ7om3mxK/BOaGUbqhuDx4eGkM/xzAGGwwsLagS5aSJE2WYdzu9kZOvnrl81abu42CoGZ4+NebNvxTalczyxmx9S+XNonVHzW+fcnrWQM8pV78E6HJimf/Eac67a8qL9BPZkwIrJjFnFlD/XPOCVCTrQjWqvT/CXYHgvhBvDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhvEpwpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716825524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwxKfYS2pCvrGUMtybHaN+IODPR5mz8KIAEhCBULf0w=;
	b=fhvEpwppXo7mBswY4LSR3vRtk6tA1isvUjnhGkwMT1SZyJvFUt743tZNT9YHOPSE2ZaJOI
	0wlmDm8CEuwNs6rcdrWkt/OmYCCVCQYvYsWH4YHo58i8/Y04av7KVlu9WDjnnJAsSi08GN
	oLCOKrcOL+tNfCwL5sqMCIsgUP5CFiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-tH75msrNPIqR0b_GMtyP3A-1; Mon, 27 May 2024 11:58:41 -0400
X-MC-Unique: tH75msrNPIqR0b_GMtyP3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A538800169;
	Mon, 27 May 2024 15:58:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2C4AD2026D68;
	Mon, 27 May 2024 15:58:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 May 2024 17:57:12 +0200 (CEST)
Date: Mon, 27 May 2024 17:57:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240527155709.GA5733@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
 <20240526192758.GA21193@redhat.com>
 <ZlOhDiqomHlumd-u@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlOhDiqomHlumd-u@pavilion.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/26, Frederic Weisbecker wrote:
>
> Le Sun, May 26, 2024 at 09:27:58PM +0200, Oleg Nesterov a écrit :
> > > So up to this point the tick is never stopped neither on housekeeping
> > > nor on NOHZ FULL CPUs:
> > >
> > > tick_nohz_full_update_tick()
> > >   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
> > >     return;
> >
> > OK... But tick_nohz_idle_update_tick() doesn't check TS_FLAG_NOHZ and
> > the tick_nohz_full_cpu() check can't help at boot time.
>
> Yes but tick_nohz_idle_update_tick() is only called when the tick is already
> stopped. And for the tick to be already stopped, TS_FLAG_NOHZ must have been
> set.

Ah, TS_FLAG_NOHZ! Indeed, thanks.

> > And I still don't understand why we can rely on can_stop_idle_tick() even
> > in tick_nohz_idle_stop_tick().
>
> Not sure I follow you on this one...

can_stop_idle_tick() has no effect if ->timer_expires_base || tick_nohz_next_event()
but I see another email from Nicholas.

Thanks!

Oleg.


