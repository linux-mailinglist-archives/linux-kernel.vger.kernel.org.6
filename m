Return-Path: <linux-kernel+bounces-269403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3F943279
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A67281663
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF81BBBF3;
	Wed, 31 Jul 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP/vResz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25031BBBD3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437508; cv=none; b=IfvDRASCdNV0Sksu3jTQdXEdZmOXt2J1meg0g8lYX3pjl8KE8URoHt9pSJpCqeqq25GmmdbJzx2/15AefTcYGbMdPjvypsvgq1q7jMgcZMCUDyLyl7vSMn2tGNNVZE9em6OlwZyrlnhecxsqBMCGKGA/gGtwD5L5JQ4pxDlS4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437508; c=relaxed/simple;
	bh=K+L+moXPyRckcJEOPIpXPdO70rl9nvkMMU/SwZ6KEgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE/P/i8ECAZwy7/dVuzuVk1jAsGDK+TbWbqN7qOArgSvD26Tx6z5pMZXZCdFV0mmBZQYIxbSfXOnJMwOBtI+bU+0CW8BmCB62lf74Jk+f40rg5WPPFiV4zFE9Ze8kl9owzfFnCXiLpSLmybwLwo2RO39aF4Zmesqe8kB8VPfTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP/vResz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722437506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Pv+HDvEvOySzEJcwpcEm+6Prwjz4GlxMPdJTpaqB7c=;
	b=RP/vReszefvj0MgguJvo52IpBWLac7ijU19Ez2wPIcczzCtoGkTqJA2vKblAAVXe4JmiEl
	DrCgV65TqUFPVcp8e3WlCzV4mJSf3l/O61/DY2x4e54t2y13vKQZxsiD+AQBcBElh+qMTx
	SiCQ3cIr92DVajEU0p165B/gi43EH60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-_dHwd0tEMuCXIYEWQas0Og-1; Wed,
 31 Jul 2024 10:51:40 -0400
X-MC-Unique: _dHwd0tEMuCXIYEWQas0Og-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71AB1944AAC;
	Wed, 31 Jul 2024 14:51:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 60918300018D;
	Wed, 31 Jul 2024 14:51:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 16:51:37 +0200 (CEST)
Date: Wed, 31 Jul 2024 16:51:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240731145132.GC16718@redhat.com>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/31, Christian Brauner wrote:
>
> It's currently possible to create pidfds for kthreads but it is unclear
> what that is supposed to mean. Until we have use-cases for it and we
> figured out what behavior we want block the creation of pidfds for
> kthreads.

Hmm... could you explain your concerns? Why do you think we should disallow
pidfd_open(pid-of-kthread) ?

> @@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
>  	if (clone_flags & CLONE_PIDFD) {
>  		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
>  
> +		/* Don't create pidfds for kernel threads for now. */
> +		if (args->kthread) {
> +			retval = -EINVAL;
> +			goto bad_fork_free_pid;

Do we really need this check? Userspace can't use args->kthread != NULL,
the kernel users should not use CLONE_PIDFD.

Oleg.


