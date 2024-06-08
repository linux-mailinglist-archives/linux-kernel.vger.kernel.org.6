Return-Path: <linux-kernel+bounces-207034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4C90117B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1117E2826CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982246F30E;
	Sat,  8 Jun 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqW5w2dE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D9F9C8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850660; cv=none; b=Omh/hErPU003hb7DmAaHY57HEPS945Wad0m2CDtoOUhwrM45b1ZB53RqzJnpFKyh2iVP6MaigasOA0tn39/c6RzWQLtoT/CvuyCdx3c+2xj5fN+48QtuE87oL1zimSqY3ErC/V1euFyMP8nXPrGBjve6OzNuvcs3AoTrD3Csk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850660; c=relaxed/simple;
	bh=W8F12haHfYCyQ4HIdNKmmvskxpuwC0L38ijQvXG9O1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLkodIfwD57iddv+/KBqYsmvKyvAO9eu1w+Ol1Ok1UGGDnJrChITfaHWfys6lQZqpX1uUTnOvZnLkoZjlEWQPtwqELAXS4x9V7pzMg4jQzQaOP4IZFMNb53oUHeC9MHj9EMzse3WiJ1Ji2XheqQg2RgrT/ECASryBUz/U/n0m0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqW5w2dE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717850658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8F12haHfYCyQ4HIdNKmmvskxpuwC0L38ijQvXG9O1M=;
	b=TqW5w2dEOw4nEjqFeT/GCyz8qUsHstbVvXEKxAnz+MUH6pfkb9DpekgO6+YpxnCIdwhWt9
	Bg5VsHh4plcqqZ/aInc9TQo75rhOnnirC+VfCET9iQ4eMIYped8evsCiqfCl+tq8ILQuBy
	frr6XQAbkaxYtkB2MnkjWONkezrynMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-whCyCT8YNZi7IO53CsbSEw-1; Sat, 08 Jun 2024 08:44:14 -0400
X-MC-Unique: whCyCT8YNZi7IO53CsbSEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 507E9800173;
	Sat,  8 Jun 2024 12:44:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with SMTP id F104CC15BB1;
	Sat,  8 Jun 2024 12:44:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  8 Jun 2024 14:42:43 +0200 (CEST)
Date: Sat, 8 Jun 2024 14:42:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Fu <fuweid89@gmail.com>
Cc: Sudhanva.Huruli@microsoft.com, akpm@linux-foundation.org,
	apais@linux.microsoft.com, axboe@kernel.dk, boqun.feng@gmail.com,
	brauner@kernel.org, ebiederm@xmission.com, frederic@kernel.org,
	j.granados@samsung.com, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang1211@gmail.com, rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Message-ID: <20240608124237.GC7947@redhat.com>
References: <20240607062531.GA30954@redhat.com>
 <20240607150443.2096063-1-fuweid89@gmail.com>
 <20240607212116.GA7258@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607212116.GA7258@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 06/07, Oleg Nesterov wrote:
>
> On 06/07, Wei Fu wrote:
> >
> > Yes. I applied your patch on v5.15.160 and run reproducer for 5 hours.
> > I didn't see this issue. Currently, it looks good!. I will continue that test
> > on this weekend.
>
> Great, thanks!
>
> > In last reply, you mentioned TIF_NOTIFY_SIGNAL related to busy-wait loop.
> > Would you please explain why flag-clear works here?
>
> Sure, I'll write the changelog with the explanation and send the patch on
> weekend. If it passes your testing.

Please see the patch I've sent. The changelog doesn't bother to describe this
particular problem because busy-waiting can obviously cause multiple problems,
especially without CONFIG_PREEMPT or if rt_task().

So let me add more details about this particular deadlock here.

The sub-namespace init task T spins in a tight loop calling kernel_wait4()
which returns -EINTR without sleeping because its child C has not exited
yet and signal_pending(T) is true due to TIF_NOTIFY_SIGNAL.

The exiting child C sleeps in synchronize_rcu() which hangs exactly because
T never calls schedule/rcu_note_context_switch, it can't be preempted because
CONFIG_PREEMPT is not enabled.

Note also that without PREEMPT_RCU __rcu_read_lock() is just preempt_disable()
which is nop without CONFIG_PREEMPT.

Oleg.


