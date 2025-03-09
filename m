Return-Path: <linux-kernel+bounces-553226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D4A585F7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B216A0D7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A5F1DFDBB;
	Sun,  9 Mar 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STbiAfli"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C92AE95
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539824; cv=none; b=MdW2lv7ov26Lw3GEBXRK15wnTMHfxG3Acp7AMm3kSAIw6zX/4f48zN8r8w5R++lO602AAXs7lAcX8X8gtk1Eum1scnAQMMuJ6vRjNnAK6eqUIoqTryafVB2DKIOEy/Nlzt5Ye5Ue3yLKmdmOUG/2OhezW+5WGPUCmB1/ZkCupTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539824; c=relaxed/simple;
	bh=Xebeuqu2NCll/QxTOuP2+yDIrcMb5fDPbvy0SjDDUW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4qyoYwrO7rQdLgCPvYpUGq6FhQjF9fSG0CF3jby6gmIwhNfh2mht+JSjOZDj2ro6pyumIgHStH12X3WD0KB66Vo8ewhhzFVddxa80vcvPPyKqjv8MNxB8q82ddOzw2erqxeEgoKb9+E4N+BAT4X+3iS63hncv69QRSyrjBqopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STbiAfli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741539819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktY/l692hvd4FyeZKYppmC3JFEBwvK+7WlKmHAB35/c=;
	b=STbiAfliuNFc6zQ+ZbUXL6VSlX6rTbgF0AMrfw2ZWV4lE/ZZ5cHBv0mfygqBsA7fQcvpH5
	pJSTSaRKrO+FwNG1HSDLTs2GdtbmawwOtga9/Gz5TnkbiBhYXXGozTjjZH1XUv7Ogeua2S
	bGzH8tpzOPAQWCnX/NeHpZvPY3KiwM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-GrQZytcxN52AONNZWmiozg-1; Sun,
 09 Mar 2025 13:03:34 -0400
X-MC-Unique: GrQZytcxN52AONNZWmiozg-1
X-Mimecast-MFC-AGG-ID: GrQZytcxN52AONNZWmiozg_1741539811
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1C1718004A9;
	Sun,  9 Mar 2025 17:03:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.34])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 167D71956095;
	Sun,  9 Mar 2025 17:03:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  9 Mar 2025 18:02:59 +0100 (CET)
Date: Sun, 9 Mar 2025 18:02:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250309170254.GA15139@redhat.com>
References: <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307235645.3117-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Well. Prateek has already provide the lengthy/thorough explanation,
but let me add anyway...

On 03/08, Hillf Danton wrote:
>
> On Fri, 7 Mar 2025 13:34:43 +0100 Oleg Nesterov <oleg@redhat.com>
> > On 03/07, Oleg Nesterov wrote:
> > > On 03/07, Hillf Danton wrote:
> > > > On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
> > > > >> step-03
> > > > >> 	task-118766 new reader
> > > > >> 	makes pipe empty
> > > > >
> > > > >Reader seeing a pipe full should wake up a writer allowing 118768 to
> > > > >wakeup again and fill the pipe. Am I missing something?
> > > > >
> > > > Good catch, but that wakeup was cut off [2,3]
> >
> > Please note that "that wakeup" was _not_ removed by the patch below.
> >
> After another look, you did cut it.

I still don't think so.

> Link: https://lore.kernel.org/all/20250209150718.GA17013@redhat.com/
...
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -360,29 +360,9 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  			break;
>  		}
>  		mutex_unlock(&pipe->mutex);
> -
>  		/*
>  		 * We only get here if we didn't actually read anything.
>  		 *
> -		 * However, we could have seen (and removed) a zero-sized
> -		 * pipe buffer, and might have made space in the buffers
> -		 * that way.
> -		 *
> -		 * You can't make zero-sized pipe buffers by doing an empty
> -		 * write (not even in packet mode), but they can happen if
> -		 * the writer gets an EFAULT when trying to fill a buffer
> -		 * that already got allocated and inserted in the buffer
> -		 * array.
> -		 *
> -		 * So we still need to wake up any pending writers in the
> -		 * _very_ unlikely case that the pipe was full, but we got
> -		 * no data.
> -		 */
> -		if (unlikely(wake_writer))
> -			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -
> -		/*
>  		 * But because we didn't read anything, at this point we can
>  		 * just return directly with -ERESTARTSYS if we're interrupted,
>  		 * since we've done any required wakeups and there's no need
> @@ -391,7 +371,6 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>  			return -ERESTARTSYS;
>
> -		wake_writer = false;
>  		wake_next_reader = true;
>  		mutex_lock(&pipe->mutex);
>  	}

Please note that in this particular case (hackbench testing)
pipe_write() -> copy_page_from_iter() never fails. So wake_writer is
never true before pipe_reader() calls wait_event(pipe->rd_wait).

So (again, in this particular case) we could apply the patch below
on top of Linus's tree.

So, with or without these changes, the writer should be woken up at
step-03 in your scenario.

Oleg.
---

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -360,27 +360,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		}
 		mutex_unlock(&pipe->mutex);
 
-		/*
-		 * We only get here if we didn't actually read anything.
-		 *
-		 * However, we could have seen (and removed) a zero-sized
-		 * pipe buffer, and might have made space in the buffers
-		 * that way.
-		 *
-		 * You can't make zero-sized pipe buffers by doing an empty
-		 * write (not even in packet mode), but they can happen if
-		 * the writer gets an EFAULT when trying to fill a buffer
-		 * that already got allocated and inserted in the buffer
-		 * array.
-		 *
-		 * So we still need to wake up any pending writers in the
-		 * _very_ unlikely case that the pipe was full, but we got
-		 * no data.
-		 */
-		if (unlikely(wake_writer))
-			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-
+		BUG_ON(wake_writer);
 		/*
 		 * But because we didn't read anything, at this point we can
 		 * just return directly with -ERESTARTSYS if we're interrupted,


