Return-Path: <linux-kernel+bounces-207008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CF901140
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AEB283075
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9871779BA;
	Sat,  8 Jun 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRb+l02+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD6142E9E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717841547; cv=none; b=Z1TQyi7OkXQPu00cn48GheYyBYbgHag44wNculMf9mA+rfV2vCG94Y59RcqwDJyTHHfpyCnJSH1HaXyDcY5S0pgjKyPQa+j/CGryCMY8pedY/xQKqYjkBrB/nnHKfRXajG52RA7xgqOlixQQG88zKjj+7EcH2WFvAp6deLpZcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717841547; c=relaxed/simple;
	bh=Zl/wnclW1YLFdnrLABq5Cmz/7fnj1lvtNYBLhZzgvWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emSdP6Y+iNL/Ono+sz/eEgfo98X3kneHESoGmN8Ufye+Pre8++g3cHN1uWdWUg5WZMw0vExHFD3f9/fff+Z+suy+qdK1ZOYPuUJqtI99qE2Hmc6QBMCILenhJd/Vquk9yZK0WGyh1bn+X/5LAHMAtBf1ge7fQHE3w1xHOGwxjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRb+l02+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717841545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zl/wnclW1YLFdnrLABq5Cmz/7fnj1lvtNYBLhZzgvWo=;
	b=eRb+l02++u/Fjb5gOYhnMtH+iZttky1ux4tg9UICIcdAeso05i/pMlwxpqPXYcv0dBlieG
	tEDfQk70QE8u7s/79mIbDsk3bZVJTxw+XZWqrSI84WeX2ZcGKykOksz1YWbjga9dIATfGO
	ZuaVwYoygv8HZSmU9RRlfncBkeiXNqE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-_pXjUw6SMFeoe_EYgWabAA-1; Sat,
 08 Jun 2024 06:12:18 -0400
X-MC-Unique: _pXjUw6SMFeoe_EYgWabAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AD491955E7E;
	Sat,  8 Jun 2024 10:12:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0EE8F19560AB;
	Sat,  8 Jun 2024 10:12:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  8 Jun 2024 12:10:46 +0200 (CEST)
Date: Sat, 8 Jun 2024 12:10:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 2/3] x86/fpu: Remove the thread::fpu pointer
Message-ID: <20240608101040.GA7947@redhat.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-3-mingo@kernel.org>
 <20240605133805.GB25006@redhat.com>
 <ZmF5IhYp5JiiMHgv@gmail.com>
 <ZmQAZ-REghlJmax-@gmail.com>
 <ZmQHrHqQUVTRtjSz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmQHrHqQUVTRtjSz@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/08, Ingo Molnar wrote:
>
> On a third thought, while more readable, this doesn't work in practice with
> the current scheme, because x86_task_fpu() gets called on kthreads in
> fpu_clone(), which trips up the new debugging code.

Yes, yes, I even mentioned this in reply to 3/3.

> We could resolve it by special-casing PF_KTHREAD here too, but that weakens
> the whole readability argument. I'll leave it as-is for now.

Agreed.

Note that PF_KTHREAD | PF_USER_WORKER is already a special case in fpu_clone(),
see the "if (minimal)" check. We can probably do more changes later, for example
I don't even understand why do we need to initialize dst_fpu->fpstate->regs,
switch_fpu_return() is only called by arch_exit_to_user_mode_prepare().

Oleg.


