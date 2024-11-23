Return-Path: <linux-kernel+bounces-419013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC29D688B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439DBB218F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADEC17F505;
	Sat, 23 Nov 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdHDKHtz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038964204B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732356824; cv=none; b=btInK1q/bePwPluXapxcHemSHezC+zrYbDy2jGWG2DKpT3jlSYfBT6Z4NYNZj+iUIgI4epDYSGFjhFJUTWmtNPWg8O86RCmmx1Qvf5s+YcPhX/j5bJhEaR+WpBAeRTghaNY7+yOd1KHHD0JZhLOYXkx16ptKAQ1mrqEn6GXHJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732356824; c=relaxed/simple;
	bh=2wT2qlz7GfJ4nSDYV7O7nBWF9hFh/tHdhlHvOmCJqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcD8/waxNI+ObtyGwpSffEip0IqGEWvAkc9SSVRTNQpPjB2f0DemyUzWTMZ4hjsBAEobJKkSGw0nwQ83FNj3bo8czNBpL1EqIx2wAiGzG8VyY+Wi9MRWmv577o5PmkCKLyZ7nfGLvhyEaCnYnssbheuIWJ6W+uRtI6Xz+PLRd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdHDKHtz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732356820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rzBYGa7TpcdgERG2a4Wk2Fk7SNt0rTDxts7NmI9Ts4=;
	b=LdHDKHtzBEkBbU65ZLQQu80LnnBuFkEctGY3+/G/ZA6RR45p7IyxKJXcuR+bLpE/AsDZOS
	7y6P9hPs7C+3sX0EAuE2JuITyJ39DGiujvZaH6qLSbm3kuHXr5eAU1FwsvmUYus+4hHCUp
	NueS+Da23wiADP+5Szyn/kQW8OOUQTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-8DLIUkGdMfCN1t9GcREpSQ-1; Sat,
 23 Nov 2024 05:13:38 -0500
X-MC-Unique: 8DLIUkGdMfCN1t9GcREpSQ-1
X-Mimecast-MFC-AGG-ID: 8DLIUkGdMfCN1t9GcREpSQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79BD21955D58;
	Sat, 23 Nov 2024 10:13:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CA20F30000DF;
	Sat, 23 Nov 2024 10:13:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 23 Nov 2024 11:13:16 +0100 (CET)
Date: Sat, 23 Nov 2024 11:13:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anthony Mallet <anthony.mallet@laas.fr>
Subject: Re: [PATCH] posix-timers: Target group sigqueue to current task only
 if not exiting
Message-ID: <20241123101312.GA12843@redhat.com>
References: <20241122234811.60455-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122234811.60455-1-frederic@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/23, Frederic Weisbecker wrote:
>
> - * the same thread group as the target process, which avoids
> - * unnecessarily waking up a potentially idle task.
> + * the same thread group as the target process and its sighand is
> + * stable, which avoids unnecessarily waking up a potentially idle task.
>   */
>  static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
>  {
>  	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
>  
> -	if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
> +	if (t && tmr->it_pid_type != PIDTYPE_PID &&
> +	    same_thread_group(t, current) && !current->exit_state)
>  		t = current;

Thanks!

Acked-by: Oleg Nesterov <oleg@redhat.com>


