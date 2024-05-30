Return-Path: <linux-kernel+bounces-195718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E936A8D50B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA41C282DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4145033;
	Thu, 30 May 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMUz8mtr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91F44393
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089164; cv=none; b=WEho+kWxcrBkUXSF+FkPE4EFHbBTS2DGzZzt47ot82ReKqv/dC+abLPr3mEDUxey0Wa9Y3mm8BL2YFIlgCVs2OtOZruL8wE1VFOAfBvw3t9thAWCWKYj/AX/VdBik2i3M17QdWrgh55I3kTBnbGfJyeu3gNI8YCV/XI6n/IkcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089164; c=relaxed/simple;
	bh=+Tpcy+uaJJW8E5UNAROhyUdF9rN9CrJwMeloPLsLaws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOV2oouLcjD2AHy5oY9Mm4Qvtlk8U4ZiJlAKyjWImxBaF7uPmmEfc973MCSChq9M1UigLynKGGG0ISc4fh8KTx9SfbfqU7+TiqDUArIG9l3vWYBhdiotxHahUhL1K04Nb7mV/TbAo6at48t3q6mD3zE0oOOqd2Krp/Za4Y0hI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMUz8mtr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9WNw07QJ/U1KAldkvE87rPuzzR+mHCX4xM2Z6mjDg8=;
	b=TMUz8mtrBB6hfpG+IV8WNtxaUet9Ig6HqBujWjE9pSIrRAxmzCOBIhd6irbrLIa2aBCiUw
	0UetjtwQzEqhWgBxgjAEEkE/beHViAMGRCEmpV5U8kjLGAwzqR33ODSjBCmkE+jseRnJ38
	krELReriQut/msuyIvdcRnSo4vsJZYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-HeENdz2pNYeyEv0PayXM4w-1; Thu, 30 May 2024 13:12:39 -0400
X-MC-Unique: HeENdz2pNYeyEv0PayXM4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 559F481227E;
	Thu, 30 May 2024 17:12:39 +0000 (UTC)
Received: from fedora (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with SMTP id F194C40C6EB7;
	Thu, 30 May 2024 17:12:37 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 May 2024 13:12:39 -0400 (EDT)
Date: Thu, 30 May 2024 13:12:36 -0400
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: shift tick_nohz_switch_to_nohz() from
 tick_check_oneshot_change() to hrtimer_run_queues()
Message-ID: <ZlizhBuU3tVWW2Mm@redhat.com>
References: <20240530124203.GA26990@redhat.com>
 <ZliaSISeFxx_FQ6O@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliaSISeFxx_FQ6O@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 05/30, Frederic Weisbecker wrote:
>
> > +extern int tick_check_oneshot_change(void);
> > +extern void tick_nohz_switch_to_nohz(void);
>
> tick_nohz_switch_to_nohz() is only built with CONFIG_NO_HZ_COMMON
>
> You will have a build issue with CONFIG_HIGH_RES_TIMER && !CONFIG_NO_HZ_COMMON

Hmm. I naively thought that a dummy definition below should be enough...

Thanks! I'll recheck and reply on Saturday.

Oleg.

> >  #else /* !CONFIG_TICK_ONESHOT: */
> >  static inline
> > @@ -124,7 +125,8 @@ static inline void tick_oneshot_notify(void) { }
> >  static inline bool tick_oneshot_possible(void) { return false; }
> >  static inline int tick_oneshot_mode_active(void) { return 0; }
> >  static inline void tick_clock_notify(void) { }
> > -static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
> > +static inline int tick_check_oneshot_change(void) { return 0; }
> > +static inline void tick_nohz_switch_to_nohz(void) { }
> >  #endif /* !CONFIG_TICK_ONESHOT */
> 


