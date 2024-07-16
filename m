Return-Path: <linux-kernel+bounces-253791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33593932707
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344BB1C23173
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5919AA7F;
	Tue, 16 Jul 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsYw/NSe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD72AE6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134864; cv=none; b=gO7acwwqjVzCJjj7ACJyMkRf8P9xU9SqPCx1mVic50XSrf/ExY4NQ8yUHELaTS/lSjel5w2iiRdNuIYVV8IxLzLJGXrxADr0Y21qfAfn//0roDW3G2oKyK52OAzNYimctetaUB3HXV/sLqhS+UpIxXZgtfPEdNnXHICcxr1t4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134864; c=relaxed/simple;
	bh=CLPfij7IZVgzVmWjsrYiOH32P720/VZIcUyjcXqCYU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrKzHDVMp8m2AR0BbanV1HeF4MwbfdFiOXXKVbyctclEDFvrZW34XLVUVZhY2jcSmDs3MUFBRnIDQYSqaZxc6dF60QAecMS9kMFH/BOG1LmnydyLKajUhLas1Ok82zbzdmqtoGbEE1aduv+8bNBUlU3d5KTA/X5c1pOUewN3foI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsYw/NSe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721134861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZvSWaX1TPcD8FswYkTcZRyEwsLFrSaMZFL3KicKSQE=;
	b=RsYw/NSe5yhuf4E7Tyd23y2r16YXzaTUuOrGTWcER+pEkG2AmFfQGWgPzLHbgThnkrp0Jy
	goXQbuVOdIAi5kWwC3NIMzPrciXAsh4ybsgGJWjnQdZsq6UDSdzlKBNCxgRvJPeVzxg3qy
	Mi44MhfUh01KAbUeVvIx1qkDBckML2I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-GcYB1eJoNs6GtuSXaJpOCQ-1; Tue, 16 Jul 2024 09:01:00 -0400
X-MC-Unique: GcYB1eJoNs6GtuSXaJpOCQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b60b18e8efso97385426d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134859; x=1721739659;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZvSWaX1TPcD8FswYkTcZRyEwsLFrSaMZFL3KicKSQE=;
        b=DRAp+8XPJ3LTJCSyo331cLyc228ULVYUfYc+0KycQxV0qyCJeeLdCv5iex+0eMSBTR
         A9XKOXVgHQIaq7zkfL9VRTbxQWsRMtFqKm82i241RPk5sndxzMMqRZN165dp8t9SxPlV
         KmSF1Yte4HR7BZtbQdVHavL3z2hEbKZJBduIOeslXDj3AQBtU1Isr7Oi2SiTjifn5T9J
         n2r8+JEZ/KUo8nEe9jzyerNF/MEqJ9RSTDySWe1TKVLSQerj5hi/EttB/TXVaa5+HWYo
         w8jE0OFK+KwVUm6iBses4kLy8H2vOgDIwNEA7762/OFARHg4BvWf1UDxYjfcrRtp1kf2
         +s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTJ+zLmy4fe+4TUrRW7S8Tqq0HYEPYBipQXO0hXpzWqgg46EgeZSMoVA0iFBmc5iNlURpx5wUm9NNHtyMAj5or7muVbBQ9SFtMpH6t
X-Gm-Message-State: AOJu0Yy8/3luCUAnSi4CGt03Y5X2uOt58SW76yHSaIWlBy5rlYFRZNde
	7R9OXogIC2Di2XzRGl2oDxk3A8anJ3hjx7CoJ9coLypOVhPNdACxZPvEaZ9ILn620zzK8hbsUrO
	rPOPyO7nM3cqKQKe0r00hi9lVNmdaW4ZxyKy4opGchuSnEDgaVTIrdiwsYJ0IJA==
X-Received: by 2002:ad4:5ae8:0:b0:6b0:68cd:6fc3 with SMTP id 6a1803df08f44-6b77f3ba038mr27347296d6.20.1721134858691;
        Tue, 16 Jul 2024 06:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER3zd1Ma3Z4e3HRqFbNxCOuysXj6Tf+K633hfNoUk7ErA4vBoCOQr7oXAvZFxMA4KS3VTJPw==
X-Received: by 2002:ad4:5ae8:0:b0:6b0:68cd:6fc3 with SMTP id 6a1803df08f44-6b77f3ba038mr27346156d6.20.1721134857231;
        Tue, 16 Jul 2024 06:00:57 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619b3414sm30405846d6.69.2024.07.16.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:00:56 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 2/6] sched/fair: Use task_work_queued() on numa_work
In-Reply-To: <20240625135244.20227-3-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-3-frederic@kernel.org>
Date: Tue, 16 Jul 2024 15:00:53 +0200
Message-ID: <xhsmha5ih1ofu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/06/24 15:52, Frederic Weisbecker wrote:

> @@ -3456,7 +3455,6 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>       p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
>       p->numa_migrate_retry		= 0;

>       /* Protect against double add, see task_tick_numa and task_numa_work */
> -	p->numa_work.next		= &p->numa_work;

You'll want to get rid of the comment there as well.

>       p->numa_faults			= NULL;
>       p->numa_pages_migrated		= 0;
>       p->total_numa_faults		= 0;


