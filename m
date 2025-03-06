Return-Path: <linux-kernel+bounces-548552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C682A5465E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DE318960F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9A20101A;
	Thu,  6 Mar 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctRJsl92"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1D146580
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253477; cv=none; b=i1b/pNiTISfWf5g9Y2KOtNJ0ofxy8J2e6v/xteX3dOFJ4DOopIbjppdUTbUIagbmz6hD0lkz8voHQiYtCJVshFKuNauD7cRNE81+MzaP78hdFcjYNvSe/WOeYCb+t1hUcepU78qGHB+tHLvlA13RDGG1O0RRAcs9eZQwoh2SJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253477; c=relaxed/simple;
	bh=7AWyzaoRNX7pBPmkkgAhqvWqkw5zPYUp7ZguMwwhrpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9ugzYqZNGSSl4KK2CH9J2PL0EAy8EtOttgAmpIzyTIrBIguAFOiwYWEgIULOaxm67DFkd8TBGHtwo3Woa3vKH3nZexv8lMrlTan41Qoxa0SNIXdrlI9vaI/zz3GnRLIXgkHtOP+VRl1JyCvjaR8xgInoNVP8i9NwJHcUKjb0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctRJsl92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b3+ZzLyvyNemOvRu/XqHRTaVSt8GcD6sOCsL+LMgwo=;
	b=ctRJsl92kFp5vsIAGnZfbQNZODOswTOqf/j3NTusj8/xo7xECjipnrRvOQvTPxPKDm1Cys
	H3Xt06jfsIng3M4N1zbq9LpqYIr4pgat0dXwzpZCSkOjoiM8m8TaPVsYbk92JhPR2qjDHj
	AvywnAGo0S7ae55uozJ+fLJW14UlMV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36--3E89iakONiQoo4YS72d3g-1; Thu,
 06 Mar 2025 04:30:58 -0500
X-MC-Unique: -3E89iakONiQoo4YS72d3g-1
X-Mimecast-MFC-AGG-ID: -3E89iakONiQoo4YS72d3g_1741253456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D5B3180025A;
	Thu,  6 Mar 2025 09:30:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AF9518009BC;
	Thu,  6 Mar 2025 09:30:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Mar 2025 10:30:25 +0100 (CET)
Date: Thu, 6 Mar 2025 10:30:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250306093021.GA19868@redhat.com>
References: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305224648.3058-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/06, Hillf Danton wrote:
>
> On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
> > On 03/05, Hillf Danton wrote:
> > > See the loop in  ___wait_event(),
> > >
> > > 	for (;;) {
> > > 		prepare_to_wait_event();
> > >
> > > 		// flip
> > > 		if (condition)
> > > 			break;
> > >
> > > 		schedule();
> > > 	}
> > >
> > > After wakeup, waiter will sleep again if condition flips false on the waker
> > > side before waiter checks condition, even if condition is atomic, no?
> >
> > Yes, but in this case pipe_full() == true is correct, this writer can
> > safely sleep.
> >
> No, because no reader is woken up before sleep to make pipe not full.

Why the reader should be woken before this writer sleeps? Why the reader
should be woken at all in this case (when pipe is full again) ?

We certainly can't understand each other.

Could your picture the exact scenario/sequence which can hang?

Oleg.


