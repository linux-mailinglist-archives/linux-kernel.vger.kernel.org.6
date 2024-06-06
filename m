Return-Path: <linux-kernel+bounces-204223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7A8FE5FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07D51F23F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120E195815;
	Thu,  6 Jun 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djxxwVVI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7A1953B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675339; cv=none; b=l8V34g75fY6e7vBkz3uWgDly0xwsbQQJi9svhc5IAMNQ7zOWCeq1K2hFwWAnqjauQCAE0xvWHY8H3xl7w9XIOAKfzsAgizRmdMpzWAavzy+A4X+UuHgMgFslYpuVobNMkGb0NNw0+q5QaYxxHmxQzJX6+iAmMZdhLKtOZWAsdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675339; c=relaxed/simple;
	bh=4bUJYb2nU/Uqt7KYEGDi/qFb4SSmyf/7m+E23emU67Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbe7v0pKVHLMcHZEXAV/93GxPdIqAbUfz+c5galIa9o2VQJ+MgfhyDiR+djCTQXH526VZI0XpPufXv8/BJoCMC+4iMIpeLcgwQVGW8l4B4zKMEX+Rq0MXc+J5xOc0LbC8XPnp+29aEMtnETl7gZ5Az0t1uTdEYb7+XYVHxlxns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djxxwVVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717675336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWWTK5qhVcanDQ3qGq7g2oah+h7PvOaUzbsjJCySE6U=;
	b=djxxwVVIa78SaPeREWZMX4uCQq4nnr7NuXCVmPDsjI0GIVvl+BpLH70fYrQoiTKoOZPgKW
	5Py2Oqt1/YtUBkQzbJN9XA8hgVyhN1nuMdPbrVcAUouYTPRmMIeKs3xdDocnKffwm+Aiyy
	MTD0S2Th+5hZBn+xGZHtsBjiqZEwFLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-0yHxYiYcN1akpk4CRgImlw-1; Thu, 06 Jun 2024 08:02:11 -0400
X-MC-Unique: 0yHxYiYcN1akpk4CRgImlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F13F811E8E;
	Thu,  6 Jun 2024 12:02:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.3])
	by smtp.corp.redhat.com (Postfix) with SMTP id B61B91C0005E;
	Thu,  6 Jun 2024 12:02:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  6 Jun 2024 14:00:41 +0200 (CEST)
Date: Thu, 6 Jun 2024 14:00:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/3, v4] x86/fpu: Remove init_task FPU state
 dependencies, add debugging warning for PF_KTHREAD tasks
Message-ID: <20240606120038.GB22450@redhat.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
 <ZmFziN0i10sILaIo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmFziN0i10sILaIo@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 06/06, Ingo Molnar wrote:
>
> I changed the debug check to test for PF_KTHREAD, and to return NULL:
>
> +#ifdef CONFIG_X86_DEBUG_FPU
> +struct fpu *x86_task_fpu(struct task_struct *task)
> +{
> +	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
> +		return NULL;
> +
> +	return (void *)task + sizeof(*task);
> +}
> +#endif

How many users enable CONFIG_X86_DEBUG_FPU? Perhaps it makes sense
to check PF_KTHREAD unconditionally for the start, them add
if (IS_ENABLED(X86_DEBUG_FPU)). But I won't insist.


For the record, I think we can later change this code to check

	task->flags & (PF_KTHREAD | PF_USER_WORKER)

but I guess this needs some (simple) changes in the ptrace/coredump
paths.

Oleg.


