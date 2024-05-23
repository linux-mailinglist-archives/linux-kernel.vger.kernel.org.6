Return-Path: <linux-kernel+bounces-187216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76048CCEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5303B2817BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6D13CFBA;
	Thu, 23 May 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx+jwPhh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD645B5B8
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454838; cv=none; b=AEIEPhqzPJFTbqTvnbYlFZl01WVdvRE28YxotEkYXzOLPZxAv20pEE8aspLcx3gCNN1Xm/XIe8gPvWuKmAs2fBERwAhNdNyYiAqtb3dWF9Sq3nX/wsJXPYGG0RpvqJ5difpzUP1mmgl4UrnCZ5wonw60Wg5psmq3KI/LgCf+9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454838; c=relaxed/simple;
	bh=fx3lnRrdYGSzCWxxWFbM9mILK2AYStWqU56b1FFbsp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvRxrlgU0n18YJc6bxctovnJzZyRkvKIolKKfUaByclprqVuokKoHytqwGOVvaHLGSXW+o4G93soSGx4z+AOai2VWx/ShuHdL+cRcvDIiWQfGLxr5z49O6zOgDWfZIDoU60ew+TvLS8naBnQC8gPiRrqBlMhfF+/8UyT78zyXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hx+jwPhh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716454835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXjX+Eg6UXL149zcQPuNAImukMuIAXQwQcO/3R22CZY=;
	b=Hx+jwPhhifZFxPhMctngln+yjQw2ys4+6FJ2HdqpyXAhgrmSND0pwB0l538JP6ujf69bmF
	mIAfTbOkjGgsviqzliFIB6jMPzkm4+flHIjfLTK0blBer927u30pCn3wQ+vkg+U5d4ihKI
	lISLp+FC0pjXSJqTbRaznkQbSzy8E24=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-azrIwL-cMMK17mfrflUcGg-1; Thu, 23 May 2024 05:00:31 -0400
X-MC-Unique: azrIwL-cMMK17mfrflUcGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DCA800169;
	Thu, 23 May 2024 09:00:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.7])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1316D28E3;
	Thu, 23 May 2024 09:00:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 May 2024 10:59:02 +0200 (CEST)
Date: Thu, 23 May 2024 10:59:00 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] seccomp: interrupt SECCOMP_IOCTL_NOTIF_RECV when all
 users have exited
Message-ID: <20240523085859.GB15163@redhat.com>
References: <20240523014540.372255-1-avagin@google.com>
 <20240523014540.372255-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523014540.372255-2-avagin@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Andrei,

the patch looks good to me even if I don't really understand what
SECCOMP_IOCTL_NOTIF_RECV does. But let me ask a stupid question,

On 05/23, Andrei Vagin wrote:
>
> The change is based on the 'commit 99cdb8b9a573 ("seccomp: notify about
> unused filter")' which implemented (E)POLLHUP notifications.

To me this patch fixes the commit above, because without this change

> @@ -1466,7 +1466,7 @@ static int recv_wake_function(wait_queue_entry_t *wait, unsigned int mode, int s
>  				  void *key)
>  {
>  	/* Avoid a wakeup if event not interesting for us. */
> -	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
> +	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR | EPOLLHUP)))

__seccomp_filter_orphan() -> wake_up_poll(&orig->wqh, EPOLLHUP) won't
wakeup the task sleeping in recv_wait_event(), right ?

In any case, FWIW

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


