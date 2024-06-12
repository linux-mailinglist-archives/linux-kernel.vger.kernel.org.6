Return-Path: <linux-kernel+bounces-212226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47547905CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BA82877B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035084D0D;
	Wed, 12 Jun 2024 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+TE1hq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437552F62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224359; cv=none; b=m6kduk2cJ1SPrl0qTbf8EZqZvScE1eX2cj0zOaJB/h31JS4tE5Ii4kPTsx6IZppRQv2/WNQHckXTPKyMKMS0uYvPZByS1kRC4qybQ/PJbdEe6/HYSdtdr2hWlNUywpCrhMMWEeIN2zB0cyGeWQM/XPaORd4h+BBp6ofLgd0Lkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224359; c=relaxed/simple;
	bh=9IdeTemBZcFn+eza7Th10FBeF3X9Au3MQePWWBpoZag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcmepg1m0V39ttyQZP7ChASR0xodgumi9AF1DZjzgFDyMsM5L8sN50Q5q41H4NPinqSImk4f+Vno0sjnVa9f7+eHCn9am2vCtTmNhwmwWCtjm0v9ix3T2ZwiRfvFsxvTVPyhSp79ARrGrMiN0KvTv20qtfJ0LOBhh1YIEPUb9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+TE1hq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718224356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBcfmifnqAR8qklw82vumrXeiUswj4bsQ8QdOVoBb0Q=;
	b=N+TE1hq/L+orj+QKI0uVowniF3utfZYwu7RR3SIerJh4dgtQSuJNTG2XeYKZDhxKSv81Ft
	oiB30XWuqLe9EZBwCtIsXwBQekR9NF6adDaxjB2OOOIE73P/mKKe2yoT0FkVLHejQbaU47
	3HyPQuLXQkPiucttNrj42jpWeNleoxs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-B0wM7vaTMkapof3mOeCSmw-1; Wed,
 12 Jun 2024 16:32:32 -0400
X-MC-Unique: B0wM7vaTMkapof3mOeCSmw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACE8C1956080;
	Wed, 12 Jun 2024 20:32:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6E0DE19560AB;
	Wed, 12 Jun 2024 20:32:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 12 Jun 2024 22:30:58 +0200 (CEST)
Date: Wed, 12 Jun 2024 22:30:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Message-ID: <20240612203052.GC23973@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
 <20240612184148.GB23973@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612184148.GB23973@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Damn, sorry for the additional spam, but if I was not clear...

On 06/12, Oleg Nesterov wrote:
>
> The patch below seems to fix the problem.

Of course I am not trying to propose this change. This is just
the debugging patch. Which can hopefully explain the problem.

> Again, the changes in fpu__init_system_early_generic() are not
> strictly needed to fix it, but I believe make sense anyway.

...

>  static void __init fpu__init_system_early_generic(void)
>  {
> -	int this_cpu = smp_processor_id();
> -
>  	fpstate_reset(&x86_init_fpu);
>  	current->thread.fpu = &x86_init_fpu;
> -	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> -	x86_init_fpu.last_cpu = this_cpu;
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
> +	x86_init_fpu.last_cpu = -1;

Yes, in particular set_thread_flag(TIF_NEED_FPU_LOAD). And x86_init_fpu
should die after the next patch.

Oleg.


