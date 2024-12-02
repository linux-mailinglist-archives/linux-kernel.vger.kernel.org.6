Return-Path: <linux-kernel+bounces-428084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0659E0A00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CBC281D95
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE41DA60B;
	Mon,  2 Dec 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnCRxrkp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893270818
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160727; cv=none; b=gEhzViAx9ONN6PodYY2RMaLti8zJksLzf7YRuwA0d0jCn5Nbx+p5V550fq29FifMFDmKjzrhkF2Kpm5pRO8+pjfq1+mCr4KPAhduwqeJvyc7P7SNFPB5iJygAMA84F+37vt9HqA7lY/CwHf8qX/Pyg9kTxeLzo9Q647ZiBgttmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160727; c=relaxed/simple;
	bh=ge4vmChn7JDIw1vDsNN9rhilNtcMOBZuMkdztL/nxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4JEbILng4OhR4E+Zbdy9DdXFPshJvx0QG2eNYJ9b5jvZa+RtQINzrYxOLQoVGPd+YnTu9KTyEzm1R0bRKQDhLRt1kWW9ZVx0MwSnsI+F0dn+36C3M48K+B596NG2iQ64KvTxOdYgwpygqsdMXfOrryCRzjQ/Yuy2zC0RNoIOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnCRxrkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733160724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miJn4Jjmfo+oLh/QgzQ2o8vQrAcU6wdSdPVjC8R5cv0=;
	b=dnCRxrkp0RCsTrhGROb4bIjsZk6FIHnDOYdjGBmeDtz769i9ZdTgB7iVDDoxv3OjBNfQ2V
	sn1rUHikoYp9Aaip5SSxqAcdHoofALQl7TRdIiJECOtRf1hwmi2wEXRrulJhL3NUfL7EOg
	zvx0uauCVyAmWoMXrzoizImBHgt1Ng8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-2WKFHmjqPzOgj0Hh1ax4Xw-1; Mon,
 02 Dec 2024 12:32:01 -0500
X-MC-Unique: 2WKFHmjqPzOgj0Hh1ax4Xw-1
X-Mimecast-MFC-AGG-ID: 2WKFHmjqPzOgj0Hh1ax4Xw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE4B31955F3F;
	Mon,  2 Dec 2024 17:31:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7E7551956052;
	Mon,  2 Dec 2024 17:31:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  2 Dec 2024 18:31:36 +0100 (CET)
Date: Mon, 2 Dec 2024 18:31:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: akpm@linux-foundation.org, brauner@kernel.org, tglx@linutronix.de,
	frederic@kernel.org, richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/fork: Optimize by avoiding unnecessary locking
 for kernel threads
Message-ID: <20241202173131.GB9551@redhat.com>
References: <20241202091055.49551-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202091055.49551-1-zhen.ni@easystack.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Already in -mm tree, please see
https://lore.kernel.org/all/20241119143526.704986-1-mjguzik@gmail.com/

Oleg.

On 12/02, Zhen Ni wrote:
>
> Improves the function by checking if the task is a kernel thread
> (PF_KTHREAD) before acquiring the task lock. Kernel threads do not
> have an associated executable file, so the function now returns NULL
> immediately in such cases. This change reduces unnecessary locking
> overhead and simplifies the code logic, while maintaining consistent
> behavior for regular tasks.
>
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  kernel/fork.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index e58d27c05788..9fadde6c7c98 100644
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
>  }
> --
> 2.20.1
>


