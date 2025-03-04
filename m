Return-Path: <linux-kernel+bounces-544354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8FFA4E065
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F93A3B0B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707D2066F1;
	Tue,  4 Mar 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foyHauLf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2903204C2B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097287; cv=none; b=kqmV+jnsr7rs8f/EI8kM1+5hMMP+7HRDDvBnvynngwnXdvg0TAwmF7fMsYV2wHRhC7o9z/Ys1UjdqXHJU2WRPGBLoavP57SrellHGCo2BKBJi0p1PEzjP6oB39nczlDVXe3OX28Dltl7ynIQtwLn6Z7zY1HNLn6/U94ldKUCFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097287; c=relaxed/simple;
	bh=KAiXbpu15i47EAqRuiSckrsx67fq0CuxF/yuJFF2VvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HljYyz3hPoAsOIPQerXeyNj4vYzVU4KBkFkmeJVwQNg7ifp2pQqzRCtvkO5S7W1ztUv2qzOEkVeey5IJIY7RYHz6QHsTCEFS8OOAsN4qO6zAgPdYAAe++qcoLsvK6zZDUrg8GTQjAv820LgZKJ5bYxy6vYRdM5l22dnE6h3Qv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foyHauLf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741097284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0duPupBbKbOBmo+V9m3H3rlnyCP4NMm3QenxG8AfDU=;
	b=foyHauLftzeUOEzjOXI+4h3avv0/esDjc2rLlW8SbSZENiWktCjh+W1boG+MA2h3/M8VHV
	tSiPaXbKucbSIlOroxHuHt1yVvm6zUDtPRHXNa1kW3yMuHmzFTXNVsWteKxvyJ5vJKRI9S
	dGGR6yBYO3cqEtPRrfhGofYCTaAhQm4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-9JaBw8SLPneBqvKQmQA7ig-1; Tue,
 04 Mar 2025 09:08:03 -0500
X-MC-Unique: 9JaBw8SLPneBqvKQmQA7ig-1
X-Mimecast-MFC-AGG-ID: 9JaBw8SLPneBqvKQmQA7ig_1741097282
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B874119373C4;
	Tue,  4 Mar 2025 14:08:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C7891801768;
	Tue,  4 Mar 2025 14:07:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 15:07:31 +0100 (CET)
Date: Tue, 4 Mar 2025 15:07:27 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] pipe: drop an always true check in anon_pipe_write()
Message-ID: <20250304140726.GD26141@redhat.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303230409.452687-2-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/04, Mateusz Guzik wrote:
>
> @@ -529,10 +529,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  			if (!iov_iter_count(from))
>  				break;
> -		}
>  
> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>  			continue;
> +		}

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



It seems that we can also remove the unnecessary signal_pending()
check, but I need to recheck and we need to cleanup the poll_usage
logic first.

This will also remove the unnecessary wakeups when the writer is
interrupted by signal/

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..ed55a86ca03b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -541,12 +541,6 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				ret = -EAGAIN;
 			break;
 		}
-		if (signal_pending(current)) {
-			if (!ret)
-				ret = -ERESTARTSYS;
-			break;
-		}
-
 		/*
 		 * We're going to release the pipe lock and wait for more
 		 * space. We wake up any readers if necessary, and then
@@ -554,10 +548,11 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * become empty while we dropped the lock.
 		 */
 		mutex_unlock(&pipe->mutex);
-		if (was_empty)
+		if (was_empty || pipe->poll_usage)
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
+		if (wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe)) < 0)
+			return ret ?: -ERESTARTSYS;
 		mutex_lock(&pipe->mutex);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;


