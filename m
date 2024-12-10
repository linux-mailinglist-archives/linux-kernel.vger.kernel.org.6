Return-Path: <linux-kernel+bounces-439817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9339EB450
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C5D1676ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CAA1AA7A3;
	Tue, 10 Dec 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssco8VSf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B323DE87
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843166; cv=none; b=hSka/tPf5dkIbWuIl6oq1C6SxsSXn7fyBYnhK+YQ0S4jfi+Fx8KHFZLeA9njMEWDhRoX0LbNkuFSuropnH+YFfmn75bfE2mmaqpcNmMcjbb9igrAlDyYaOkmVHaaIpPpuUsI3R4snmPCksi7dKRDJRDUC6yfL7u0kDihtYgiyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843166; c=relaxed/simple;
	bh=4/+WUdKpk+ARnDD+HpUIu4lUCzl2ggQRiCY35wadzLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUI7PoYMDpZBTWwR5ql3Q7E/S3ENsrv1+YdIVAp4LGxTym59vlL3AQhpwww7b+nzpEh5Gnl7fFD+rDhrX9Oo7NmhTRSzZMmHXOO52toY0Us31pthdpfCHhmp4VrFQvRQkt0quMzgPs2CNfCuoaFgjUavHVaW0BoAXTiorjnEiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ssco8VSf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733843163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFDGw5CUUJOAizHZiI+bpfEz7cJP3GL6f3AyTr6K+v8=;
	b=Ssco8VSfMQ1AyZ443CcIWTLwQHUttZIMCvWqzy62rtmqjkoqP43SK9/fTpCe+mLzWeGZjU
	bpxWO7HGbq2s9ggPCwRVUpQmFqrMLyy3EGJsIJFLghx86xWk5HAA5B3t8tc2zikMHxX9Ev
	MBBDeYbMABtE5LCmjUmBeqEqlSlz/ZU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-KnybzgjdOXWpwierOZYUtQ-1; Tue,
 10 Dec 2024 10:05:59 -0500
X-MC-Unique: KnybzgjdOXWpwierOZYUtQ-1
X-Mimecast-MFC-AGG-ID: KnybzgjdOXWpwierOZYUtQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 878B11955F28;
	Tue, 10 Dec 2024 15:05:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A00C5195605A;
	Tue, 10 Dec 2024 15:05:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 10 Dec 2024 16:05:34 +0100 (CET)
Date: Tue, 10 Dec 2024 16:05:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, mhiramat@kernel.org,
	peterz@infradead.org, Jann Horn <jannh@google.com>,
	syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <20241210150528.GA31266@redhat.com>
References: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
 <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
 <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/09, Lorenzo Stoakes wrote:
>
> (As discussed on IRC) how about moving up the dup_mmap_sem lock one level, we
> can put the mm before the rmap lookup in build_map_info() is able to find it,
> which should avoid the whole issue?

Not sure I fully understand the problem, but so far I see nothing wrong in
this idea. However,

> @@ -1692,9 +1690,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk, mm->user_ns))
>  		goto fail_nomem;
> 
> +	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
>  		goto free_pt;
> +	uprobe_end_dup_mmap();

If try_module_get(mm->binfmt->module)) fails after that, dup_mm() does
"goto free_pt;" and in this case ...

> @@ -1709,6 +1709,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	mm->binfmt = NULL;
>  	mm_init_owner(mm, NULL);
>  	mmput(mm);
> +	uprobe_end_dup_mmap();

... we have the unbalanced uprobe_end_dup_mmap().

Also. Perhaps we can change dup_mmap() to set MMF_XXX before uprobe_end_dup_mmap(),

	fail_uprobe_end:
+		if (retval)
+			set_bit(mm->flags, MMF_XXX);
		uprobe_end_dup_mmap();
		return retval;

Then build_map_info() can check this flag. I guess we can reuse some of
MMF_OOM_ bits? May be MMF_UNSTABLE...

Oleg.


