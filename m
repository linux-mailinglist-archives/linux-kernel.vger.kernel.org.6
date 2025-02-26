Return-Path: <linux-kernel+bounces-533880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914CA45FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6663AB85E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DC1E1DFD;
	Wed, 26 Feb 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDf2yUN1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DB258CD1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574291; cv=none; b=sQ4w6TwfJgIxEufQu2FYXOyQ7mVoh+eyGrIdZ0Ng5ztCYGWKt8S6Yxpb+U8l8VPD+vSzTtZ82lWTaR2oGP/d6Ca7kLlQLXrYJVGyeE5/07hXNcqy4p/ykW17OHmh/1szHqLsa897MIwMaHFORBl0TdRmOaNMyo1vQGvmVQZ0jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574291; c=relaxed/simple;
	bh=gLgtRdYXRFEO9G9Ax4yxK0U6zVjbthiZ9FuqZisBCIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph2SnuPgoKaFTL934znFg5/MO3M6D2XyoKiZjZeh8lT+JHThc0iXTRXYSaa7DKkg5DxjG/Ig/EIDnb3gPrZp/PnGBtrFSlhUTLD6DMlNr52MijwkMcufO9GJ18J/JB0vmzyCMAus6KjeBCii54TKcXlna/QjuOKJ4ZA0B8+YEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDf2yUN1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740574288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF/R7p8PMiEr0VAjoxkpXagHEzypvyA54y3GVLAB1Tw=;
	b=TDf2yUN1O7hHI04JEd3gAXYpPsYmUkWTuqUvKZICvjDmDi2TnLEQk2Bn+oKbx3XZIuRH8S
	o2wiqPXTlo60ERIX3U8tuXhY0W3ZpeesNLcpY51k7TTjKeI6bri70RW0TNZnKCCw8LVLDt
	5jE4fpBfOEy8okaUbta+t0Q5P2iyxtU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-PL7Uh6A9Nkqz9ZoiQYkNaA-1; Wed,
 26 Feb 2025 07:51:24 -0500
X-MC-Unique: PL7Uh6A9Nkqz9ZoiQYkNaA-1
X-Mimecast-MFC-AGG-ID: PL7Uh6A9Nkqz9ZoiQYkNaA_1740574283
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25C3919783B6;
	Wed, 26 Feb 2025 12:51:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E5B421800945;
	Wed, 26 Feb 2025 12:51:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Feb 2025 13:50:52 +0100 (CET)
Date: Wed, 26 Feb 2025 13:50:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <20250226125048.GC8995@redhat.com>
References: <20250221170530.L3yMvO0i@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170530.L3yMvO0i@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/21, Sebastian Andrzej Siewior wrote:
>
> Yi and syzbot managed to hang the task within task_run().
>
> The problem is
>  task_work_run() -> __fput() -> perf_release() ->
>  perf_event_release_kernel() -> _free_event() ->
>  perf_pending_task_sync() -> task_work_cancel() failed ->
>  rcuwait_wait_event().
>
> Once task_work_run() is running, the list of callbacks removed from the
> task_struct and from this point on task_work_cancel() can't remove any
> pending and not yet started work items.

But can this patch really solve the problem?

Suppose we have two tasks, T1 and T2.

T1 does fd = perf_event_open(pid => T2->pid);
T2 does fd = perf_event_open(pid => T1->pid);

Now, both T1 and T2 do close(fd), call task_work_run(), dequeue the
____fput work, and finally call __fput(). Now suppose that both perf
events fire before T1/T2 call perf_event_release_kernel/_free_event.

Now, T1 and T2 will hang forever in perf_pending_task_sync() waiting
for each other. task_work_cancel(current) can't succeed with or without
this patch.

No?

Oleg.


