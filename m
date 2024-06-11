Return-Path: <linux-kernel+bounces-209873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE65D903C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C671F23C49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03017BB25;
	Tue, 11 Jun 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvpxiKyS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEF1E52C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109842; cv=none; b=rLV+4RqrdGcAky/k3G3PMJvTcjb2geX7sPeBoEMLcemJ5QaAuSu267AOIAoV74mRQiLN8VNsw8eb8N671qgoqNRUccpZR9ftpDBT+6hkx+ph3j/ZtSGcVAQUoRSo4gWJMiYseahXeRuZZbbG25dTCtXR84W6f4OpoU5PVahGvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109842; c=relaxed/simple;
	bh=MuOJwV+9Yc1UQEBs6z4DSyYpDf7Mqx1hxFfBGpbsP4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of6VQ5SjB12v4hOGCEfdjILZBvVz09SKkEbt7smxWbEOsFYrcAzkumrj8uVp8YcXqOt6fk1VnHQGDvsnlEqSj8ZqLT7Dq3wSG4POsKW5YK8Aos4PIsszpky8WiLmyTT1dbjivBMDi6x0PSLKnuRmosMAwBD5XvhnO1CnQRINlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvpxiKyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718109840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knkjZE86f+ZfffVsyU6Yxq5jex0lAYNJ+eM4bSj5EqM=;
	b=DvpxiKySogt5ySJ2VmTe7n1H0E+8QzVYGHAftclvkyrdMf2nF9Gx+UMq+dofHrvQdo23cw
	9xj2suSVWIJDWOVzH9eGWlnSUFCI3Jobp9d4joDKVuNWGfWFycYgF2Q01hbuAWTxaLoxGc
	QvHcyp5dydug6tihOmJ0CuHhl6VnzoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-tvRSx-m-OeemEjtwoSlr6w-1; Tue,
 11 Jun 2024 08:43:53 -0400
X-MC-Unique: tvRSx-m-OeemEjtwoSlr6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6462C19560A6;
	Tue, 11 Jun 2024 12:43:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF4111956048;
	Tue, 11 Jun 2024 12:43:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Jun 2024 14:42:19 +0200 (CEST)
Date: Tue, 11 Jun 2024 14:42:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Message-ID: <20240611124145.GA26798@redhat.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610211350.GA1613053@thelio-3990X>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I don't think this can explain the problem reported by Nathan, but.

On 06/08, Ingo Molnar wrote:
>
> +static struct fpu x86_init_fpu __read_mostly;
> +
>  static void __init fpu__init_system_early_generic(void)
>  {
> +	int this_cpu = smp_processor_id();
> +
> +	fpstate_reset(&x86_init_fpu);
> +	current->thread.fpu = &x86_init_fpu;

OK,

> +	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> +	x86_init_fpu.last_cpu = this_cpu;

Why? I think it should do

	x86_init_fpu.last_cpu = -1;
	set_thread_flag(TIF_NEED_FPU_LOAD);

And the next patch should kill x86_init_fpu altogether, but keep
TIF_NEED_FPU_LOAD. It should be never cleared if PF_KTHREAD.

Oleg.


