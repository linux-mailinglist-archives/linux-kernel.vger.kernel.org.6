Return-Path: <linux-kernel+bounces-246078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5592BD58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD9E1F23408
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93D19D060;
	Tue,  9 Jul 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPs9GLXo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB019CD09
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536279; cv=none; b=JpUvzB03ZvKaApkTH4O62QOZRNtIb3jgPdAbES5QNDUBU6FqMZ1rx0w6cQbMYzhVuXF44Q5lwvAmgF7x0RHXF93CmpnD99AL8HuGHWEp1ci9YCl1FjdYawhunySmvPXUpMD5ifQWjaiuQcER3Iv2qWvWZlSjXKdW1V3N7477hSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536279; c=relaxed/simple;
	bh=z/HOlnAjVOJAq9jQBAX+TjbVTpO8+2NA70MV4Yvy3+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WohNsWA+dWUrzdbpvJe1iYxvdufevkU6Xnjsc8IAiwJKP1iscm+QULinLZ4cuS1bl/ddfhdh/8M+BmFdvQevUo8MnhKZ4I3Ndv0oG2zAQVLHusfzVeUSctY87fptvHMNOUiMFXliIn0DAVFe6srth+nN00vDUIWd5D4qDs3TtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPs9GLXo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720536276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aKQNagMd+/kQwCZ2zdj+xcm1JmpHTDklELtSI1+6xsw=;
	b=LPs9GLXoAi4SJrARr3HEGGlOH/dBArKDxK3M4SX50fM2u6f351jugKejLz8JS9KUzGH+zI
	C9527Bdi1XSNgf2tCqFb3by5HWPBLeoEY6k681REWVm6onQlZUF9h1gBALvRRoDTjiF9ay
	HwVc9NCGcv+mL25mdU0toZQUJynRcGg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-eWb0xB66N0CoHfYEjm1UEw-1; Tue,
 09 Jul 2024 10:44:33 -0400
X-MC-Unique: eWb0xB66N0CoHfYEjm1UEw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B00D71955E80;
	Tue,  9 Jul 2024 14:44:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E8B9A19327CB;
	Tue,  9 Jul 2024 14:43:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Jul 2024 16:42:15 +0200 (CEST)
Date: Tue, 9 Jul 2024 16:42:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Julian Orth <ju.orth@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/2] kernel: rerun task_work while freezing in
 get_signal()
Message-ID: <20240709144205.GE28495@redhat.com>
References: <cover.1720534425.git.asml.silence@gmail.com>
 <149ff5a762997c723880751e8a4019907a0b6457.1720534425.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149ff5a762997c723880751e8a4019907a0b6457.1720534425.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/09, Pavel Begunkov wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2600,6 +2600,14 @@ static void do_freezer_trap(void)
>  	spin_unlock_irq(&current->sighand->siglock);
>  	cgroup_enter_frozen();
>  	schedule();
> +
> +	/*
> +	 * We could've been woken by task_work, run it to clear
> +	 * TIF_NOTIFY_SIGNAL. The caller will retry if necessary.
> +	 */
> +	clear_notify_signal();
> +	if (unlikely(task_work_pending(current)))
> +		task_work_run();
>  }

Acked-by: Oleg Nesterov <oleg@redhat.com>


