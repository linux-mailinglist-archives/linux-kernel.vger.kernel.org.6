Return-Path: <linux-kernel+bounces-545810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF4A4F1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8E3A61A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43072277021;
	Tue,  4 Mar 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJ0PXlI+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BCBA2D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132191; cv=none; b=EkdOe72TI+mT7n748DQ1XDUueLAuRnHEcGWriaiNPPj3f01AmuBBR6jhifCGV+tQiBhb4n2ecCGBQZREQRUirPQXypOV5wlb4FMKTfzUK95CWUmM8fWZ3u1+9TRlZZSRFyrLyzlzO/ODyWZvipcsNS1T0wzOB8hrQEZt6MGA5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132191; c=relaxed/simple;
	bh=iEtB+gCyt8I6YiLzpl4Y3N3BrPvrl3nxkNTaQR2VtHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFId0ec2cnT5rqV9ZtUf+kP7jCJEFYQXU0fRkR6lDqQGrgjBYqVsmZfgAZey5Ujoo9serNnxyXkN7idMY7j6qCZr2Ec2Wwrv34lTl/172j407QAoUfJeOGH2yTbpIFvJSg+NnmW6P5R8dWvwbDIy0a0fQoHtnKX3dyBHdiHEZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJ0PXlI+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741132188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsLjsgiwz48CWElDV+44qdETBMYv+pYUPW3rLAb2CoA=;
	b=EJ0PXlI+QsJj1VCyG8H0A0vKt2Nw9L+d7YBnB4ccaCvsX1/uPbb2Wa5ET5BywFcX5XiDC1
	fGiOOb5m24mvrn8/VXErfiwy0cb+EIz2m1WheVrD5gdAZBahDNWT0USnVmXvePc0QPwwAx
	GO+p6mOr8aiW9f7pQjrDzHPGqmOrG0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-85hpojrxOUGcCCaFuSHlqQ-1; Tue,
 04 Mar 2025 18:49:45 -0500
X-MC-Unique: 85hpojrxOUGcCCaFuSHlqQ-1
X-Mimecast-MFC-AGG-ID: 85hpojrxOUGcCCaFuSHlqQ_1741132184
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A4071800872;
	Tue,  4 Mar 2025 23:49:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 35DDE180035F;
	Tue,  4 Mar 2025 23:49:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Mar 2025 00:49:13 +0100 (CET)
Date: Wed, 5 Mar 2025 00:49:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250304234908.GH5756@redhat.com>
References: <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304233501.3019-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/05, Hillf Danton wrote:
>
> On Tue, 4 Mar 2025 13:34:57 +0100 Oleg Nesterov <oleg@redhat.com>
> > > >
> > > Note wakeup can occur even if pipe is full,
> >
> > Perhaps I misunderstood you, but I don't think pipe_read() can ever do
> > wake_up(pipe->wr_wait) if pipe is full...
> >
> > > 		 * So we still need to wake up any pending writers in the
> > > 		 * _very_ unlikely case that the pipe was full, but we got
> > > 		 * no data.
> > > 		 */
> >
> > Only if wake_writer is true,
> >
> > 		if (unlikely(wake_writer))
> > 			wake_up_interruptible_sync_poll(...);
> >
> > and in this case the pipe is no longer full. A zero-sized buffer was
> > removed.
> >
> > Of course this pipe can be full again when the woken writer checks the
> > condition, but this is another story. And in this case, with your
> > proposed change, the woken writer will take pipe->mutex for no reason.
> >
> See the following sequence,
>
> 	1) waker makes full false
> 	2) waker makes full true
> 	3) waiter checks full
> 	4) waker makes full false

I don't really understand this sequence, but

> waiter has no real idea of full without lock held, perhaps regardless
> the code cut below.

Of course! Again, whatever the woken writer checks in pipe_writable()
lockless, another writer can make pipe_full() true again.

But why do we care? Why do you think that the change you propose makes
more sense than the fix from Prateek or the (already merged) Linus's fix?

Oleg.


