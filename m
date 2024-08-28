Return-Path: <linux-kernel+bounces-305503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B07962FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FF3282AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700FA1AAE0D;
	Wed, 28 Aug 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blo+EBxD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0941A76CE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869035; cv=none; b=EIvKGnbMc4IzsrDRt/4V1ElrF6qWc9FI03P03yidPMIh4DA+QaPQu9tcc1M+vC/LtLTNpm5eDCXX8ZukFwgLM/fwTPnnuoJlRFk2QBmeOpDbgVobk7ud0w3/f2XOmDhTEjg19nlqfnPLYdn5pZIkWhCxU5C3ocMA6yo3kWkdKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869035; c=relaxed/simple;
	bh=FDVcTJV0BXbWzV5YbE4APsTof7/49Ez4Qa7pfi2wvLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oj5ejp/pxwmKOATMqJKPmcRIvFrNJEmqU6GI595N+OGUW+7lbzoHyqh62A/2iU9oZpa9+7EScftumODF0n6S7Bu0ldIfWOCfP41NvPBHinafAdulpwz+xuGjkLKYWBAMb8JTyy/1XFHqyZjgbsKZbJExk6MfvpdPz8k3Ig67wA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blo+EBxD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724869033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPcSd8zJJKxBEIyv9qutLiv0SREJjU3bqjzWOoPhTSc=;
	b=blo+EBxD/BvB4P/F71QOm9SiczPeNw93CyinFIhwbMQ5x+eM0ZflAxNJqQ3v8gxwQKW2Pl
	O+JhNr73xNJKM+Kw0nhEgznbLzCO4rv/FUbPoTUnwDZxHvn4kt1O1lnGEZnsEycOPlLnMJ
	SXIQUQ/ukurM0j2oMq7BkXW0Yme20bQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-R58tulB7PliYRQvO6-OStw-1; Wed, 28 Aug 2024 14:17:11 -0400
X-MC-Unique: R58tulB7PliYRQvO6-OStw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-454ec6a4b72so84225311cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869030; x=1725473830;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPcSd8zJJKxBEIyv9qutLiv0SREJjU3bqjzWOoPhTSc=;
        b=a1pr3fjZmokqiDOok2er2HxfVzcXoKfGsvMg89TVWOOYUhZ142kI4U0o54x/Ju0e0I
         xJ66vO3ceke5hk/nNFxLE2CH5xbzDrKabSnYqyKpSCx9/xo9tDhgyoRqCBJtDrnDvqSW
         NU7mgCTzvCrRHFBwwdvbxKJL/eMzrK773bKJ6MynzFeK3rFlwKdj19pnGwFdn/pxun3h
         aEJgAfHq48THrI+mZeLGThEFy2Q2oL7o1Ut4i3PJ4rrHaKKXzZRZIo0EIymwsl0QPvTC
         q8symB+Vh6Jq6HOYJa5I8AqLrUyWBMQLa4PnYSOB39iZSxBHJYg/kFsTOVvtpMmz6cH6
         w6NA==
X-Forwarded-Encrypted: i=1; AJvYcCVgGG/NUw2ohUEHm1eskO5B/7dBnJZdVubj653zr359Bnf4tx+Kc7zGtOBLXZbfyOwITlAGwYwlfkHkWxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+uy5WJbaBIicECSTeIzeKQXiv3eYI3faWIt4RpW2MaeRhfRP
	ROPKYj0gyJoKbNQt5+zXRpckFM8j0odR+xfZd00ehugLwE11+tfBwsP6yBzOxPxvAGJw9MycG6g
	qLgOVi1Q9QyoHbKfsUN4SKe7pAhfN4OvwJvx0NwJCLjygCyFnTW+FP9pWCtYF9Q==
X-Received: by 2002:a05:622a:17cf:b0:44f:5eb0:ea76 with SMTP id d75a77b69052e-4567f707fecmr3374151cf.60.1724869030025;
        Wed, 28 Aug 2024 11:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFryRd0ObHFoM12Zfr+CDdLF4P/ACJM0CBkkshMWhr25Iwdqt3C1EdT62DUFAZlRzrEhrpXMg==
X-Received: by 2002:a05:622a:17cf:b0:44f:5eb0:ea76 with SMTP id d75a77b69052e-4567f707fecmr3373731cf.60.1724869029416;
        Wed, 28 Aug 2024 11:17:09 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196bf5sm64122591cf.76.2024.08.28.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:17:08 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
 linux-next@vger.kernel.org, kernel-team@meta.com
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <5ea3658b-5aec-4969-92c5-49a2d23171c3@paulmck-laptop>
References: <b1824f4a-f5cc-4011-876f-8a73cf752067@paulmck-laptop>
 <xhsmhle0inuze.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhikvmnfb3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <c83028db-55ad-45b3-a27a-842ed665a882@paulmck-laptop>
 <103b1710-39ca-40d0-947d-fdac32d6e6a0@paulmck-laptop>
 <xhsmhcyltogin.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <a19308ed-7252-4119-b891-2a61791bb6e5@paulmck-laptop>
 <xhsmha5gwome6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zs8pqJjIYOFuPDiH@chenyu5-mobl2>
 <xhsmh7cc0ogza.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <5ea3658b-5aec-4969-92c5-49a2d23171c3@paulmck-laptop>
Date: Wed, 28 Aug 2024 20:17:06 +0200
Message-ID: <xhsmh4j74o6l9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 28/08/24 09:35, Paul E. McKenney wrote:
> On Wed, Aug 28, 2024 at 04:32:41PM +0200, Valentin Schneider wrote:
>> On 28/08/24 21:44, Chen Yu wrote:
>> >
>> > One question, although there is no DEQUEUE_DELAYED flag, it is possible
>> > the delayed task could be dequeued from CFS tree. Because the dequeue in
>> > set_schedule() does not have DEQUEUE_SLEEP. And in dequeue_entity():
>> >
>> >       bool sleep = flags & DEQUEUE_SLEEP;
>> >
>> >       if (flags & DEQUEUE_DELAYED) {
>> >
>> >       } else {
>> >               bool delay = sleep;
>> >               if (sched_feat(DELAY_DEQUEUE) && delay &&  //false
>> >                  !entity_eligible(cfs_rq, se) {
>> >               //do not dequeue
>> >               }
>> >       }
>> >
>> >       //dequeue the task    <---- we should reach here?
>> >
>>
>> You're quite right, so really here the main missing bit would be the final
>> __block_task() that a DEQUEUE_DELAYED dequeue_entities() would get us.
>
> 50*TREE03 passed, yay!  Thank you both!!!
>

Fantastic, I'll hammer this into a "proper" patch then. Thanks again for
all the testing!

> I started a 500*TREE03.
>
> Yes, the odds all 50 passing given the baseline 52% failure rate is
> something like 10^-16, but software bugs are not necessarily constrained
> by elementary statistics...
>

:-)

>                                                       Thanx, Paul


