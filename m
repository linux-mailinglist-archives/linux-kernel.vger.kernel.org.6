Return-Path: <linux-kernel+bounces-534104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C2A462C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DD9189D317
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438022170B;
	Wed, 26 Feb 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXjiY/pR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634633EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580197; cv=none; b=OgRgzBj0myubaIHrOqwMG16CzhO+6X15VvNZnjmzK/LG0uZ9HIQDLtz8MBCA5Mz3GcnFi2I8h5zwnyQwK8ySnZIDy2PGPlW694+7EZst6l2Ids3SSl5LF8VQ11g7gvZvUJxcqcuNFcvRN8XaezepfPEEYNP5Y+P2yDztcVFTra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580197; c=relaxed/simple;
	bh=Jo3BHYyduZAmEWf8mHoWcMQFegvpBohhWbEH+f8gg3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq3L2qDH+oUnFc5sbgSCzjPWX2pe6VhvZheg5ziZzW6YgqI3tmUrvRDyya2qNGK6qx5Pd+IjOak5odzXtGdW+eKsa/OfV/7po0mrV7pNgoO0F/h3bjVvCqySMJv9wcKUWyKLalfbsPCgaHxAImlyt/tRSin455sP815K7kbT6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXjiY/pR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740580194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jo3BHYyduZAmEWf8mHoWcMQFegvpBohhWbEH+f8gg3o=;
	b=IXjiY/pR7CuqJaSdC8Zv8HM74pVjCWNbxSe5zNEEHFzGjx4+asnexJOPHmO9ebtubj1oF9
	xAYe8K1qCoOvdPO3HbKnOQz3VUWwwDnHO2DXWEv2ysuyzrnmcyRJI8naukbGtFqBxGGSwZ
	ADueGgA02AHUmtWkkEDIPh8hnYRACHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-WHL9b_OPP06l4SvJEm618w-1; Wed,
 26 Feb 2025 09:29:51 -0500
X-MC-Unique: WHL9b_OPP06l4SvJEm618w-1
X-Mimecast-MFC-AGG-ID: WHL9b_OPP06l4SvJEm618w_1740580189
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662021800876;
	Wed, 26 Feb 2025 14:29:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4EF4819560AB;
	Wed, 26 Feb 2025 14:29:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 15:29:19 +0100 (CET)
Date: Wed, 26 Feb 2025 15:29:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226142914.GF8995@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
 <20250226141601.VBQ91ZDb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226141601.VBQ91ZDb@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/26, Sebastian Andrzej Siewior wrote:
>
> On 2025-02-23 23:40:15 [+0100], Oleg Nesterov wrote:
> > Well... I won't really argue because I can't suggest a better fix at
> > least right now. Most probably never.
> >
> > However, let me say that this patch doesn't make me happy ;) See below.
> >
> > On 02/21, Sebastian Andrzej Siewior wrote:
> > >
> > > Oleg pointed out that this might be problematic if one closes 2.000.000
> > > files at once. While testing this scenario by opening that many files
> > > following by exit() to ensure that all files are closed at once, I did
> > > not observe anything outside of noise.
> >
> > and this probably means that we can revert c82199061009 ("task_work: remove
> > fifo ordering guarantee") and restore the fifo ordering which IMO makes much
> > more sense.
>
> So assume that turning around will fix the problem because the cancel
> callback is run first followed by the clean up.

Not really, they can run in any order, so fifo can't really help.

But this doesn't matter, please see another email:
https://lore.kernel.org/all/20250226125048.GC8995@redhat.com/

Oleg.


