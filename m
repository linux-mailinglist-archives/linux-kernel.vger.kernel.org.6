Return-Path: <linux-kernel+bounces-207985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFA901EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6221F25494
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79F76025;
	Mon, 10 Jun 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5Wucjtg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365A282EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013802; cv=none; b=bUcPyY8seAfT1iH54ClTsBbVfTDbKyzS9y9oA0TNWNClHbkWVyoK9gMF6WWOyEKBdlC34i076q4dE5TzODQboGA8ARLulA0cqoYRsOJS+Vp6B7wfj20hb4cC36gQ2f20ERD/YKTid/RHqJsHrVDveQNE7rc0IbakMdn4XgL2rGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013802; c=relaxed/simple;
	bh=O4eiKS04y/mJNA2a+wGR3xNIR6Msr41jQF9cKUECQDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpPXXimwYHyRjflywGPBQcqwOLyi5tnw7/H+ZY8IOlqjXoJ+eHTmHHMzmE8CiWCQk9MscLiZoSVKqdAw1BHxFSi2U1krjYQffEHnMsChI6B/BXEgUicEgBA60NrgrDesTqaYAcd3n5j4hHFbDxWsLu6YaQ5LzHComoOk7hp6Sgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5Wucjtg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718013799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6SjRN+Ta23NhBrV4wAjIcv/ybzI9M6kM5ZjqQZnSysQ=;
	b=N5Wucjtg/FSp0rFXAcz/YYuxdjkMi0lKS69fpfYHXoEMedR6X7mXDT2XRxPaQKbS3Q1Aor
	wZj1QaS8DEECvNpkfWjiqyTHGZKoqFzOiDyy7pIc0pjOzU2iVUqxMbtWo25cUkfuFFDOwT
	cqGDmt3rorHToU0y8Ih/+M/nI0S4QdI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-UHajX1EVNbi7Hpo5cs4OoQ-1; Mon,
 10 Jun 2024 06:03:12 -0400
X-MC-Unique: UHajX1EVNbi7Hpo5cs4OoQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7E41954213;
	Mon, 10 Jun 2024 10:03:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 764EC1956089;
	Mon, 10 Jun 2024 10:03:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 12:01:40 +0200 (CEST)
Date: Mon, 10 Jun 2024 12:01:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 6/9] x86/fpu: Make sure x86_task_fpu() doesn't get called
 for PF_KTHREAD tasks during exit
Message-ID: <20240610100133.GA20640@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608073134.264210-7-mingo@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The whole series looks good to me, and afaics 7/9 allows more
cleanups / improvements.

But let me ask a stupid question about fpu__drop(), I know nothing
about fpu asm.

fpu__drop() does

	/* Ignore delayed exceptions from user space */
	asm volatile("1: fwait\n"

and this comment predates the git history. Could someone explain
why exactly the exiting user-space thread needs fwait ?

And if it is needed, suppose that a kernel thread exits right
after kernel_fpu_end(), can this lead to the delayed exception?


And otoh, perhaps fpu__drop() can set TIF_NEED_FPU_LOAD to avoid
switch_fpu_prepare()->save_fpregs_to_fpstate() on its path to the
final schedule?


On 06/08, Ingo Molnar wrote:
>
>  void fpu__drop(struct task_struct *tsk)
>  {
> -	struct fpu *fpu = x86_task_fpu(tsk);
> +	struct fpu *fpu;
> +
> +	/* PF_KTHREAD tasks do not use the FPU context area: */
> +	if (tsk->flags & PF_KTHREAD)
> +		return;

I think it can already do

	if (tsk->flags & (PF_KTHREAD | PF_USER_WORKER))
		return;

This matches other similar checks. But I won't insist, and I
think all these checks need some cleanups anyway.

Oleg.


