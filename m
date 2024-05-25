Return-Path: <linux-kernel+bounces-189377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E250E8CEF3F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F01C208FE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40E4EB3D;
	Sat, 25 May 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYtOO/qu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5D4D9FA
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716646493; cv=none; b=fczTvKL6OOYWNtqjpqKc/mH9WxyyWoZU2fHgapnpnuFQWLQqZIxeOQWuHovwY51WfS53RSDwody4IexS8AFBPXUx0XiSCrx2jgmfnJeFy67xWyWxksjva1Z6cyN9h/FRKs11cp6PeZ7SxPAnQ+9Um/wFJxEu24824ENg794MY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716646493; c=relaxed/simple;
	bh=pHhYDQhaaY66FKKr3DmflctteLE9gs3b4zQGDKxGHvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibRIHs0nwP+jpINVYhR5eim24jBeZxkxuRBbpTa2RqNBCWWb0v3Dc5C0AnedOwoCZBnuIN/TzeEoKJC5zCwhjc3YFX6IIAOol9NEQG4x5gca7SCsFrPGU0mrS+2F89+eCTVyZDmGMF8PrF00el7oGzdIRGqo2VwkZBlF7uNohDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYtOO/qu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716646490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wCH45uTfDya+DL9QJ1iuo8YA4XOLtIW4iKHM6qViqw=;
	b=TYtOO/qu3mSNonrNzSKWCw0a/vf0ydKKgGwXYg/MNCuDwyJE07jpMvEeAXhOP8/KNTcGmJ
	uL3u/u6ZCYrS/szSS2Y9cid5rUogaeHEnZlkqlAo+oYXjynsBY23CA2FVQWZCXpiwptC0h
	bdjv5UTH6Dq72RaWfeXeP1i6+Ya8rGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-3C3P-pt0M--ixJLzZ6rRoQ-1; Sat, 25 May 2024 10:14:47 -0400
X-MC-Unique: 3C3P-pt0M--ixJLzZ6rRoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9414885A58C;
	Sat, 25 May 2024 14:14:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.8])
	by smtp.corp.redhat.com (Postfix) with SMTP id 81489200A35C;
	Sat, 25 May 2024 14:14:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 25 May 2024 16:13:19 +0200 (CEST)
Date: Sat, 25 May 2024 16:13:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240525141316.GB24152@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
 <20240525135120.GA24152@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525135120.GA24152@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 05/25, Oleg Nesterov wrote:
>
> perhaps we can simply kill it along with #ifdef CONFIG_NO_HZ_FULL ?
>
> 	if (!td->evtdev) {
> 		tick_cpu = READ_ONCE(tick_do_timer_cpu);
> 		/*
> 		 * If no cpu took the do_timer update, assign it to
> 		 * this cpu:
> 		 */
> 		if (tick_cpu == TICK_DO_TIMER_BOOT) {
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 			tick_next_period = ktime_get();
> 			/*
> 			 * The boot CPU may be nohz_full, in which case the
> 			 * first housekeeping secondary will take do_timer
> 			 * from us.
> 			 */
> 		} else if (tick_nohz_full_cpu(tick_cpu) &&
> 			  !tick_nohz_full_cpu(cpu)) {
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 		}

although tick_nohz_full_cpu(tick_cpu) above depends on the fact that
tick_cpu = TICK_DO_TIMER_NONE should not be possible if
tick_nohz_full_enabled(), not good.

Oleg.


