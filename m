Return-Path: <linux-kernel+bounces-546713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A45A4FDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76CA3A51C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA4205E0B;
	Wed,  5 Mar 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRGX/E8z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF492E3372
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175125; cv=none; b=mG2v2d+7okAI66QFYjEKszg8FbvJOw2oaSHHlZVznZHIn4SRD8TY4prvOEkfIK0nWVclevtaDbrY6IsTgUXutnR2pbiLZEV6bIVIRVCElnx3RRWrNOoRyhpLjP3nnq+KM/Pq+8eTy1imtL9z5+XFZMhAnNw/ABg2ToQypcqn23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175125; c=relaxed/simple;
	bh=u0hEknQ9hTFAii0HS8u3f4nOxaeXPEum4fUgkLc5fxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5ocbQ0xVK7N0LYephIEZzo7ckEsU3JglxFZFaU8Igb57F3OlCMVS+5hnhdYJpFtJiQIhRDifLXufZxxNR71l2krPcvYijkmlfM/VV+BGQjmkUemzkfhGOat9HSOOCFd4UaW9+JSfvEtH5X3S9f3vDm4pJa6sVEbVgfbgJ3uMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRGX/E8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741175123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0XedY1oOf4u81I2FwEXBwOLP3sf5v1jn3pZdidv6lk=;
	b=KRGX/E8zJUGT13QM0LesbXUGqRYCf9i36dsvpmk/qk5putLkxVQvbUaX/5jod6NuPD3G9Y
	ch7R80ZqXevUM6MrbUEGz3HmZAbfnmHa7Rs8gR9oE494smZcaONqhkoXlKcW94XDfYC0Jc
	jrBeDR8kHuX6Va+nlPUuKEEEmbXbs1Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185--VGzdjFAOl2lxVGVcRp2zA-1; Wed,
 05 Mar 2025 06:45:11 -0500
X-MC-Unique: -VGzdjFAOl2lxVGVcRp2zA-1
X-Mimecast-MFC-AGG-ID: -VGzdjFAOl2lxVGVcRp2zA_1741175110
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 092F11954B1C;
	Wed,  5 Mar 2025 11:45:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.66])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 828E11800265;
	Wed,  5 Mar 2025 11:45:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Mar 2025 12:44:38 +0100 (CET)
Date: Wed, 5 Mar 2025 12:44:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250305114433.GA28112@redhat.com>
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305045617.3038-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Hillf,

again, I am not sure we understand each other, at least me...

On 03/05, Hillf Danton wrote:
>
> On Wed, 5 Mar 2025 00:49:09 +0100 Oleg Nesterov <oleg@redhat.com>
> >
> > Of course! Again, whatever the woken writer checks in pipe_writable()
> > lockless, another writer can make pipe_full() true again.
> >
> > But why do we care? Why do you think that the change you propose makes
>
> Because of the hang reported.

The hang happened because pipe_writable() could wrongly return false
when the buffer is not full.

Afaics, the Prateek's or Linus's fix solve this problem, and this is
all we need.

> > more sense than the fix from Prateek or the (already merged) Linus's fix?
> >
> See the loop in  ___wait_event(),
>
> 	for (;;) {
> 		prepare_to_wait_event();
>
> 		// flip
> 		if (condition)
> 			break;
>
> 		schedule();
> 	}

I will assume that this "// flip" means the case I described above:
before this writer checks the condition, another writer comes and
increments pipe->head.

> After wakeup, waiter will sleep again if condition flips false on the waker
> side before waiter checks condition, even if condition is atomic, no?

Yes, but in this case pipe_full() == true is correct, this writer can
safely sleep.

Even if flips again and becomes false right after the writer called
pipe_writable().

Note that it checks the condition after set_current_state(INTERRUPTIBLE)
and it is still on the pipe->wr_wait->head list.

The 2nd "flip" is only possible if some reader flushes another buffer
and updates pipe->tail, and in this case it will wake this writer again.

So I still can't understand your concerns, sorry.

Oleg.


