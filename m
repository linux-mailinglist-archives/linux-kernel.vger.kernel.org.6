Return-Path: <linux-kernel+bounces-202767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D08FD0AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F5D287A47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3741A291;
	Wed,  5 Jun 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKU2cmfz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1D17BCD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597156; cv=none; b=Dt6l32YeAQWomfN6X+qlkt3r4kgsw6J2U9rBuXY2Amhk1zjkxTxzRK5n/CTboXJDGA6S9tYvoEZiBEfLdxyovMmhMbcLbObPbHJ530VrvuUjEMfA/ywyHCK5PaJ02VNPFEZuBJFV03TcGEAZmFO3YHL6UMMtsPeOEdfMxtZ3HXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597156; c=relaxed/simple;
	bh=r1W5V48P8us/oKRdqlb5UGa1+dmQCutjwcz0nQAc8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG0odshqEbTWPPIJqYhvHjtSVeboQ9nidr+Lvs1YskHSjCYLDqDGWYXl3FwNVi2QEIAATSL1HZS85fb6lyHV1UfOo8TdSk3n7KlcK3d16g8uC5VXhlfGw5h5bwUR1is+GPGjbLAlMc3G5DS5DlRJ1FPHRAhxnsIxXqelU33NpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKU2cmfz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717597153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwI8FIOILkq/9/seZsMfaaMjELj3eDiG4Kw43Y0phXk=;
	b=EKU2cmfzPSATZ0bM2r+1GCkbCKBr7B76Rs48cwoSDEpZsy2Y93Q+UguEgEQq3Yv+bFgVR1
	CafrElZYdaJWqmuFYlktKfWgQLVv75XUDN6ZLKYdzm6rQfG5l0BkeqLp9ZtucmcAVfU+ZU
	Dwp0nNupHD0XL3t/aIEc3PgHxFbZsJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-3AYg_4XUMVuwoKfQnTfmFA-1; Wed,
 05 Jun 2024 10:19:10 -0400
X-MC-Unique: 3AYg_4XUMVuwoKfQnTfmFA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C17A19541BB;
	Wed,  5 Jun 2024 14:19:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A217419560A2;
	Wed,  5 Jun 2024 14:19:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 16:17:38 +0200 (CEST)
Date: Wed, 5 Jun 2024 16:17:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies,
 add debugging warning
Message-ID: <20240605141733.GC25006@redhat.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605083557.2051480-4-mingo@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/05, Ingo Molnar wrote:
>
> But the init task isn't supposed to be using the FPU in any case,

Afaics, the same is true for any PF_KTHREAD/USER_WORKER thread?

> +#ifdef CONFIG_X86_DEBUG_FPU
> +struct fpu *x86_task_fpu(struct task_struct *task)
> +{
> +	WARN_ON_ONCE(task == &init_task);
> +
> +	return (void *)task + sizeof(*task);
> +}

So perhaps WARN_ON_ONCE(task->flags & PF_KTHREAD) makes more sense?

Although in this case fpu_clone() can't use x86_task_fpu(dst) as I tried
to suggest in reply to 2/3.




This is offtopic right now, but I am wondering if it makes any sense to
make arch_task_struct_size depend on PF_KTHREAD... I mean, create another
task_struct_kthread_cachep used by alloc_task_struct_node() if PF_KTHREAD.

Oleg.


