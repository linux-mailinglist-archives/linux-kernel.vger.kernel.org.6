Return-Path: <linux-kernel+bounces-550987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58CA566B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B460B3AAD63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941221770E;
	Fri,  7 Mar 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoexAbJm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFF21767B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346827; cv=none; b=ZK3T2G7MZqbRzWGikLJDZeHjKvhiTCwTUTU316bJfOQUd9izxnwiPkjgjP56SdCGvTEaEa4MOQuSJNkzS+LxK7Kc0D08MJ1tBAfubvqAae8HxS11+LTA+u+r/oFn2gdIWLHHVsT5IiTpaYU4QZ0/Qa0NcYciUU0ahRUTcatZfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346827; c=relaxed/simple;
	bh=sTDwWbGNvYSg3+yFfHFk1I0CTOwe5y52yKszzO7Z5SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYLmt7oRq8CotxH/Yk3dcFFhKl/J0v4nlTtNd7Z6s2dy0weRHpoWUjUCWkTdd+pyaJypnjeL0PE8OeosnbScgBe9V+OIcFuDdyrJICNmwkQPwjPgq5gQZcxAh2kSVBnWnlcS8At3f+Eu+TxVDQRbf4Kzzhv4/V75QfCEWApLjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoexAbJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741346823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+6uMQgQ57mtgNlyjlDjpNt3H0NEA7p032v4Ic5GZ5A=;
	b=SoexAbJmP2Gl5vEqwvav0EjZk4IZIxhcDwbw/SwbcW8+4kdsiJn2ryeszSwtHXmp8TISXh
	jv4H9Eezu83jINw6vLI7MPT1bt0aW9yMjTN6oQ8vr8lifvnWCvcrLYIIkHaymBjxYpyNtr
	foOT9vR67prPOJI1/6MlUkiMV6tJHsA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-idiLffsVNligza2laa-wzQ-1; Fri,
 07 Mar 2025 06:26:57 -0500
X-MC-Unique: idiLffsVNligza2laa-wzQ-1
X-Mimecast-MFC-AGG-ID: idiLffsVNligza2laa-wzQ_1741346816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1D1D1955BC1;
	Fri,  7 Mar 2025 11:26:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E07E418001E9;
	Fri,  7 Mar 2025 11:26:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Mar 2025 12:26:24 +0100 (CET)
Date: Fri, 7 Mar 2025 12:26:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250307112619.GA5963@redhat.com>
References: <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307060827.3083-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/07, Hillf Danton wrote:
>
> On Thu, 6 Mar 2025 10:30:21 +0100 Oleg Nesterov <oleg@redhat.com>
> > > >
> > > > Yes, but in this case pipe_full() == true is correct, this writer can
> > > > safely sleep.
> > > >
> > > No, because no reader is woken up before sleep to make pipe not full.
> >
> > Why the reader should be woken before this writer sleeps? Why the reader
> > should be woken at all in this case (when pipe is full again) ?
> >
> "to make pipe not full" failed to prevent you asking questions like this one.

Hmm. I don't understand your "prevent you asking questions" reply.

If the pipe was full we do not need to wake the reader(s), the reader
can only sleep if pipe_empty() == true.

> > We certainly can't understand each other.

Yes.

> step-00
> 	pipe->head = 36
> 	pipe->tail = 36
> 	after 3d252160b818
>
> step-01
> 	task-118762 writer
> 	pipe->head++;
> 	wakes up task-118740 and task-118768
>
> step-02
> 	task-118768 writer
> 	makes pipe full;
> 	sleeps without waking up any reader as
> 	pipe was not empty after step-01
>
> step-03
> 	task-118766 new reader
> 	makes pipe empty
> 	sleeps

but since the pipe was full, this reader should wake up the
writer task-118768 once it updates the tail the 1st time during
the read.

> step-04
> 	task-118740 reader
> 	sleeps as pipe is empty

this is fine.

> [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]

118768 should be woken at step 3 ?

Oleg.


