Return-Path: <linux-kernel+bounces-352483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF2C991FDD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B62C1F215FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3717CA1F;
	Sun,  6 Oct 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7fpuEFP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430EF9E4
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235342; cv=none; b=XhdxMKA6aGCUdVtkvqM0dlHtNbxJB+pPHTutzpLXxpAcAt1aAHqqGwH0JH2X7wEveX0iI4AMB8ji408Lfi8OmWC/WJ3Pc/V5XaZUvAeJSwqAmFF0KCFuM6J7Ouz/CUtRJs9LLkPoZRR2mePWuj/Ei6+gAdm1MpBOIvRyUuqx5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235342; c=relaxed/simple;
	bh=K6N1EF3xhCog+S7h7WlWjUwT2cbJ5VWv196p/F4koqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey9gTQsLVFsUXDm/b6/YZZtfLHu1KEv2NOOamY5s3lFlWkHEzGsJSmvntLe73FbHU0KLkmnodqDEdP6s42i1v42TYQZarxvuPfzUyXsvco+GNyt/xF7aop2BpGDhNTe/+/PLFePxgnu9GgP1/bkDE1mJXJXJimStJejtkdrYHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7fpuEFP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728235339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uq3CJFZBcpXK9/Lwo/LR5+ZaMFau2KufOMKen+uoZz0=;
	b=F7fpuEFPxsnEKzIqHHuIaVIZCKYR966o84mNDTlYlSORcoHzW9u2dIKE9o2q11+lpL5xxG
	lut9WqKXEQ9pNbFhtfxhU40MXiR/LbQeqn2yLo1H0HoIp6DODhuRn3o0w1/xrUcWfrF+lS
	OSIXkzfT4DNp4bpn7dXkKeZz9mCKmRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-8fcGQRYxOjWQIG9B_TcyFQ-1; Sun,
 06 Oct 2024 13:22:17 -0400
X-MC-Unique: 8fcGQRYxOjWQIG9B_TcyFQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B781964CD3;
	Sun,  6 Oct 2024 17:22:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7279B19560A2;
	Sun,  6 Oct 2024 17:22:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  6 Oct 2024 19:22:02 +0200 (CEST)
Date: Sun, 6 Oct 2024 19:21:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: luca.boccassi@gmail.com
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
Message-ID: <20241006172158.GA10213@redhat.com>
References: <20241006145727.291401-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006145727.291401-1-luca.boccassi@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/06, luca.boccassi@gmail.com wrote:
>
> +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> +{
> +	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> +	size_t usize = _IOC_SIZE(cmd);
> +	struct pidfd_info kinfo = {};
> +	struct user_namespace *user_ns;
> +	const struct cred *c;
> +	__u64 request_mask;
> +
> +	if (!uinfo)
> +		return -EINVAL;
> +	if (usize < sizeof(struct pidfd_info))
> +		return -EINVAL; /* First version, no smaller struct possible */
> +
> +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> +		return -EFAULT;
> +
> +	c = get_task_cred(task);
> +	if (!c)
> +		return -ESRCH;
> +
> +	/* Unconditionally return identifiers and credentials, the rest only on request */
> +
> +	kinfo.pid = task_pid_vnr(task);
> +	kinfo.tgid = task_tgid_vnr(task);
> +	kinfo.ppid = task_ppid_nr_ns(task, task_active_pid_ns(task));
                                           ^^^^^^^^^^^^^^^^^^^^^^^^
The same problem as with "info.pid = pid_nr_ns(pid, task_active_pid_ns(task));"
you used before. You should use the caller's namespace, not the task's namespace.

	kinfo.ppid = task_ppid_nr_ns(task, NULL);

should work, see __task_pid_nr_ns() which uses task_active_pid_ns(current) if
ns == NULL.

> +	/*
> +	 * One last check before returning: the task might have exited while we
> +	 * were fetching all the data, so check again to be safe. */
> +	if (task_pid_vnr(task) == 0)
> +		return -ESRCH;

Well, this looks strange. It would be better to kill "kinfo.pid = task_pid_vnr()"
above and do

	kinfo.pid = task_pid_vnr(task);
	if (!kinfo.pid)
		return -ESRCH;

at the end, but this is minor.

I don't think we can rely on this check.

Suppose that pidfd_info() runs on CPU_0 and it races with __unhash_process(task)
on CPU_1 which does

	detach_pid(p, PIDTYPE_PID);
	detach_pid(p, PIDTYPE_TGID);

Without the barries/locking CPU_0 can see the changes above out of order,
so it is possible that pidfd_info() will see task_pid_vnr(task) != 0, but
report kinfo.tgid == 0.

Oleg.


