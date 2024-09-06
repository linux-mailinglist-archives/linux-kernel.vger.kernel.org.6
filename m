Return-Path: <linux-kernel+bounces-318799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29296F387
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2697F1C242D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141891CBE99;
	Fri,  6 Sep 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmQCSt0v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81791CBE87
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623324; cv=none; b=SZ2cMq/zkazFU0RgtQ8j5l8iRV7A+l89yPS4BzLV8+AVQalzXnTyg6mFlmomKweCTt9sC5XBunXEiOp8Af7WvJI8QP0EBWxa2J5IOHOjD2hHEhnzsuSvZ7WrkUfWYXpwAQR/p62gjyx2v3nwWWEgdqUCT1vtUo93MpVgFD/gBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623324; c=relaxed/simple;
	bh=fywag2vK7OzxqnvEmpS65cugeG/uRmsTtDvY5+V69A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTMdNhceUS2iV9rxsSuTZYkpA4tooJ1qycjh9hPjyzgJgR+FWZyMWLmfAZm6dx939ELSaQTeTT9WMX7dv0zirm94E02KU6tUDzud51wWQ0a0RRsBNilfIiTeMGvrKTqoxB+bEdwUP7cStNIPmpDdSjTeIlaffnujyKc+jE7Z/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmQCSt0v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rui3JEz9ZYhun7zVk8T0p/50gsRXMw1IJ1IRxY9dZ0c=;
	b=EmQCSt0v1s9ZxPVrlmaP/X+TjZiQP5gOGlZH3eQSG6n7PSF3DmhUViy4L5WWKvW3QRoQhC
	KVqAy1JNOqyNTe6a3g3EyGdSC509HutO1VCUO5nalGiuRqssaqhViMBt1PxLVjCGBpkAQ4
	VwSrXNtjmgMbtCrG+GyDvklSzFth0ag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-nWpJXiOLMDuP-lkOPQf3HQ-1; Fri,
 06 Sep 2024 07:48:38 -0400
X-MC-Unique: nWpJXiOLMDuP-lkOPQf3HQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29FE31953968;
	Fri,  6 Sep 2024 11:48:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C31B1955F45;
	Fri,  6 Sep 2024 11:48:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Sep 2024 13:48:25 +0200 (CEST)
Date: Fri, 6 Sep 2024 13:48:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Roman Kisel <romank@linux.microsoft.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <20240906114819.GA20831@redhat.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906112345.GA17874@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Forgot to ask...

Do you really want the tracer's pid or can PTRACE_TRACER/whatever
simply return the !!current->ptrace boolean? The changelog should
probably explain this too.

On 09/06, Oleg Nesterov wrote:
>
> Add cc's. Perhaps someone else can ack/nack the intent...
>
> This (trivial) patch is obviously buggy, but fixable. I won't argue
> if it can help userspace.
>
> On 09/05, Roman Kisel wrote:
> >
> > For debugging, it might be useful to run the debug trap
> > instruction to break into the debugger. To detect the debugger
> > presence, the kernel provides the `/proc/self/status` pseudo-file
> > that needs to be searched for the "TracerPid:" string.
> >
> > Provide a prctl command that returns the PID of the tracer if any.
>
> prctl?
>
> > That allows for much simpler logic in the user land, and makes it
> > possible to detect tracer presence even if PROC_FS is not enabled.
>
> You should probably move the links from 0/1 to the changelog to make
> it more convincing.
>
> > +	if (request == PTRACE_TRACER) {
> > +		rcu_read_lock();
> > +		tracer = ptrace_parent(current);
> > +		ret = tracer ? task_pid_nr_ns(tracer,
> > +					task_active_pid_ns(current->parent)) : -ESRCH;
>
> The namespace is wrong, we need task_active_pid_ns(current). So this
> code should simply do task_tgid_vnr(tracer) like sys_getppid() does.
> And to me it would be better to return 0 if !current->ptrace.
>
> > +		rcu_read_unlock();
> > +		goto out;
>
> Wrong, this code runs after "child = find_get_task_by_vpid(pid);" above.
>
> And why? perhaps the intent was to check if this child is traced, not
> current?
>
> Oleg.
>


