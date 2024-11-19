Return-Path: <linux-kernel+bounces-414510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812279D2933
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB011F23812
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADF81CCEDF;
	Tue, 19 Nov 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiI8NOr9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3A1CFEA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028782; cv=none; b=IykCmeyVAEp9Ptl2/M2SmN0yxQ/B4CQY2eKwoUvRBq73yqh73zMAZ9FmzByy7K+9Q3Diercf6/EKoyRLvVoVmMXmfA1M0LvMFgucGQqZkKLJFaLlTQro/n8uTomgCRFyQnP5eOZsq5CUhfqPptUZgES+Lw6HPye06WLXvGI7SUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028782; c=relaxed/simple;
	bh=FZLAf6JzU7UVrUrLeZZ5hNC61YfkfTM+rPG+dHCTTPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZVGijqvrqzysClZvNl3V6oqe0uTW9dLw4s/EdpBEnKko74t64WAC/9nqhvVqKqZGxDbqFhRwce1xZM+FMxEEczCVLti/do5jBav0oyTZMc35U2hyjYVLvLAuuVQyqfs7f/1K5MNpOXZGMLsPTkz5DjuZNsedJwQmRjRsHFTKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiI8NOr9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732028779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0coLw9579A3HuRnZcVDWYq6IWH/MGKBf0cfJQO4fi4=;
	b=HiI8NOr9aHVO8S7a0zWz08zMjLQp7V4nrRCiuwOL8CusizQyNDUwEwJVA7ruW4d1qIOfHy
	UgtWbUdJhpeSMUqh9J90g1Y2w6RmxIcuBXppG3Uhn+M1xCSncoiWprxaFNCAN92HJ3mRiF
	0Vtq2uQMofi0Fy6VoOB7vFzAmETlPxw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-QFVs5QGCNYO0CmyTVo9moQ-1; Tue,
 19 Nov 2024 10:06:14 -0500
X-MC-Unique: QFVs5QGCNYO0CmyTVo9moQ-1
X-Mimecast-MFC-AGG-ID: QFVs5QGCNYO0CmyTVo9moQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA17D19560AF;
	Tue, 19 Nov 2024 15:06:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.173])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4645B1956086;
	Tue, 19 Nov 2024 15:06:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Nov 2024 16:05:53 +0100 (CET)
Date: Tue, 19 Nov 2024 16:05:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_task_exe_file: check PF_KTHREAD locklessly
Message-ID: <20241119150550.GB2240@redhat.com>
References: <20241119143526.704986-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119143526.704986-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/19, Mateusz Guzik wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1500,12 +1500,13 @@ struct file *get_task_exe_file(struct task_struct *task)
>  	struct file *exe_file = NULL;
>  	struct mm_struct *mm;
>  
> +	if (task->flags & PF_KTHREAD)
> +		return NULL;
> +
>  	task_lock(task);
>  	mm = task->mm;
> -	if (mm) {
> -		if (!(task->flags & PF_KTHREAD))
> -			exe_file = get_mm_exe_file(mm);
> -	}
> +	if (mm)
> +		exe_file = get_mm_exe_file(mm);
>  	task_unlock(task);
>  	return exe_file;

Acked-by: Oleg Nesterov <oleg@redhat.com>


