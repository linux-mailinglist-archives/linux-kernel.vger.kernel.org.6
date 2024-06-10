Return-Path: <linux-kernel+bounces-208721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8890287C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D73288E98
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A0137747;
	Mon, 10 Jun 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWWh6qhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZ2OuqML"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419F15A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043314; cv=none; b=T+JoQl/BvXS2nrflo9UeCdTKGzF47qKBWDG3mbZpx4rVJjuqT5S/FSpSUV61lPfUqkeS6MkAONZBW7bAdeB/ApC6dc+aV+EybCNIvYrJuKTVND1RFC1vrcXUhTjh1c/C175VF+leYxIU42RFafRQLpk7AupLwC1TTQtRthQCJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043314; c=relaxed/simple;
	bh=sD/bjF2RAARHIGuNZ/Q/kDWVIckezuEJvcWCW1FNczg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jE6TxySwpjG8z2jxFjItOyzup8t3PyRzliANxibIPeShblCeXMBq4gpZDBWaVTVKuSQGuEiiYnO7hYq+sifbZLXMzum2Ecmu3Gbm5JiYLkOr2CN0CgIiYAgUP7JjmxOt/FHsxw24AqDr7+n9ScsMtFnSkwfU/Cr/C07AN71dyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWWh6qhe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZ2OuqML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718043311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKpSaBS2J5QNi45aNA+4lE99CInNxMob04aROs5f4ew=;
	b=eWWh6qhe6Dpz4oyJrwoutQlpCS2A34eX1lOALVvffqR+qGyg7vxUGVJSsHY1v2jFsgVBrH
	JuDfB+WYbpGVUu2PBimy1NDYd0OCIXjChlenkY9i0T7AjJrHgfYn+I0AyEzAg8tnWLjV9G
	Ci6zCGUEMIU4Mr89As+W0AJ1L8d6vfWpRHqHyRvL5gccxDRVaeImnHdumm9k17AYr6JWus
	h/33WboV3uiHwQ/D+3ckkQ9xKUc1CEzDmJkumRa/+I8C7T4TXsCYgnWAgkqEK8im06DJCv
	RV9WUwOrakFPgLHdzjKDsBHPKCNXLNN2oZBKXqpD4K5vlPTuWtAIevrFvawCnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718043311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKpSaBS2J5QNi45aNA+4lE99CInNxMob04aROs5f4ew=;
	b=KZ2OuqMLgjM1VIw6HtQSccnXx89SaSzfIXzN7fJBVY8WozTJfR6hiU5/302D8p+th1qn34
	lLXF9P1wuSy6V8AQ==
To: Oleg Nesterov <oleg@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Phil Auld
 <pauld@redhat.com>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PING ;)] Re: [PATCH] tick/nohz_full: don't abuse
 smp_call_function_single() in tick_setup_device()
In-Reply-To: <20240610155505.GA24299@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com> <20240610155505.GA24299@redhat.com>
Date: Mon, 10 Jun 2024 20:15:10 +0200
Message-ID: <87a5jswtox.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 10 2024 at 17:55, Oleg Nesterov wrote:
> should I redo and/or resend this patch (and the next one on top of it) ?

I lost track of the maze in this discussion. As the patch is obviously
correct, I just apply it as is and any cosmetic changes can go on top.

Thanks,

        tglx

