Return-Path: <linux-kernel+bounces-279471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588A94BDA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AA41C22C09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775718C914;
	Thu,  8 Aug 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XidQiGbk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2C63D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120710; cv=none; b=SVWczBeQNsguM2Ijc61XrMo7wPqtNjZOGCcYBHrAQ5i63A77cn1zmABhB10f5xTyAMPTfEw4q8SCm/GGU1OTe+hriBYCCYY1jb84XJIDIgAIC55ASMGTAxwQozjZrwkTfXzRuzD1C2yShDH0a3gPAJW+0CYgqFIVgOvzeElUW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120710; c=relaxed/simple;
	bh=tbqlXNcU54JKvWg9fRG86InMvI8uZs1eqaXYU+sxBMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpyeZc2YY8Z94e2ZnulM1PaL2N3obGMagWu5YcKiwiWRzJHqdSQnQAUi2EwqTFBTRdj0B3IxVxoxyw64RGtBoBk53Ne8sDIkJjeToskOvMYnvIZWvfidxqiyNbnWSZ7tvQpJg9D03zjnKulkaYM5G/aIh0rCKA2dad+mmx4UjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XidQiGbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723120708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoevIv2ikjCnuBMBRnEjGc1ljajZSFHLBZXm9sJUNDQ=;
	b=XidQiGbk95wCND8Cs2syYBnqbKzOgQoRqFDHTihfvVrnxEfbTLFRQjnAMZTZc2TD2pavTq
	dA+meJqVW0oaUp9ozlxxKd7nZLFlWFRubvZ3L1+h2cd8zBWmXMprSOBOKZamLqEnwtwnmO
	Vo+jNzc5i12znza4xbSMuXtMemSA6Qs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-s2hL3aR7NR-IvI_HVC6abA-1; Thu,
 08 Aug 2024 08:38:22 -0400
X-MC-Unique: s2hL3aR7NR-IvI_HVC6abA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6FC919541B4;
	Thu,  8 Aug 2024 12:38:21 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.9.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F79019560A3;
	Thu,  8 Aug 2024 12:38:19 +0000 (UTC)
Date: Thu, 8 Aug 2024 08:38:17 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Improve logging around
 enable/disable
Message-ID: <20240808123817.GA89141@pauld.westford.csb>
References: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Aug 07, 2024 at 02:52:50PM -1000 Tejun Heo wrote:
> sched_ext currently doesn't generate messages when the BPF scheduler is
> enabled and disabled unless there are errors. It is useful to have paper
> trail. Improve logging around enable/disable:
> 
> - Generate info messages on enable and non-error disable.
> 
> - Update error exit message formatting so that it's consistent with
>   non-error message. Also, prefix ei->msg with the BPF scheduler's name to
>   make it clear where the message is coming from.
> 
> - Shorten scx_exit_reason() strings for SCX_EXIT_UNREG* for brevity and
>   consistency.
>

Thanks! That looks very helpful.


Reviewed-by: Phil Auld <pauld@redhat.com>


> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Phil Auld <pauld@redhat.com>
> ---
>  kernel/sched/ext.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 60a7eb7d8a9e..eea2fda8e099 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4004,11 +4004,11 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
>  {
>  	switch (kind) {
>  	case SCX_EXIT_UNREG:
> -		return "Scheduler unregistered from user space";
> +		return "unregistered from user space";
>  	case SCX_EXIT_UNREG_BPF:
> -		return "Scheduler unregistered from BPF";
> +		return "unregistered from BPF";
>  	case SCX_EXIT_UNREG_KERN:
> -		return "Scheduler unregistered from the main kernel";
> +		return "unregistered from the main kernel";
>  	case SCX_EXIT_SYSRQ:
>  		return "disabled by sysrq-S";
>  	case SCX_EXIT_ERROR:
> @@ -4126,14 +4126,17 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
>  	percpu_up_write(&scx_fork_rwsem);
>  
>  	if (ei->kind >= SCX_EXIT_ERROR) {
> -		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n", scx_ops.name);
> +		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
> +		       scx_ops.name, ei->reason);
>  
> -		if (ei->msg[0] == '\0')
> -			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
> -		else
> -			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
> +		if (ei->msg[0] != '\0')
> +			printk(KERN_ERR "sched_ext: %s: %s\n",
> +			       scx_ops.name, ei->msg);
>  
>  		stack_trace_print(ei->bt, ei->bt_len, 2);
> +	} else {
> +		pr_info("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
> +			scx_ops.name, ei->reason);
>  	}
>  
>  	if (scx_ops.exit)
> @@ -4808,6 +4811,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
>  		static_branch_enable(&__scx_switched_all);
>  
> +	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
> +		scx_ops.name, scx_switched_all() ? "" : " (partial)");
>  	kobject_uevent(scx_root_kobj, KOBJ_ADD);
>  	mutex_unlock(&scx_ops_enable_mutex);
>  
> 

-- 


