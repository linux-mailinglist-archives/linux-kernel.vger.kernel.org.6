Return-Path: <linux-kernel+bounces-202728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE88FD012
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8A298D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6B195392;
	Wed,  5 Jun 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlfAMr8Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B118F2CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594788; cv=none; b=jIsBhyLLMAtKvaj3/Y9pmlvhfB7cV0TbDrzr2Z2Koiao3GsvcN8hS0q1yTgoX73lwA6Uv7WP/vEXRwTnpeZ+aF6BvdEPgCvRR5Sxv4n9Ke8Ye/VsX6BT979dwA0NM20jbamzuDaM5i4Rr2zdm6/pvz755QPp2uRXvOgULmSKSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594788; c=relaxed/simple;
	bh=KXUlGvJxH76Dw1mprNtT8VriPC1GoqJaANXsGiwAP1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll5kb9SFdeoaQbrpxXTEzNsBJv9iyjb4PbsEZRHzilYM4z9cLHP+WivYgWlhi4ZIYMPun/LoXVJzw2SbvrDnmMO6GC0gtr/7f1fdsOUk3lJ1aduCdO5eoex5eXVXrnPe6xdUjf5nBQAdUlluqWVWFdt+flIDmjv77NDOJOmvDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlfAMr8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717594786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hq5dFgzzvJ7XxAlZCAf3SVqsfwdgE9gzlqrR94U8+M=;
	b=FlfAMr8Qr9Pvjh9xqvrGra1fID1ZgM1ezrNuLdx/CuEJx3+oJJwWWdhCRS6bsbF2tPWZN7
	LbUVfZkyBUqbH0qbByM+qCmKF38/tJhcZLuLWnMcj3GAkLamhvhgemsffqe7SP0/SUF5/X
	vLP5w4kMyGGt1RNRc/nu2BQBp0SIOXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TesUs7_COgSJTGxJHerPAQ-1; Wed, 05 Jun 2024 09:39:39 -0400
X-MC-Unique: TesUs7_COgSJTGxJHerPAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E8AC800076;
	Wed,  5 Jun 2024 13:39:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 5D8C31C0005E;
	Wed,  5 Jun 2024 13:39:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 15:38:09 +0200 (CEST)
Date: Wed, 5 Jun 2024 15:38:05 +0200
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
Message-ID: <20240605133805.GB25006@redhat.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605083557.2051480-3-mingo@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 06/05, Ingo Molnar wrote:
>
> @@ -591,13 +591,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
>  	 * This is safe because task_struct size is a multiple of cacheline size.
>  	 */
>  	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
> -	struct fpu *src_fpu = current->thread.fpu;
> +	struct fpu *src_fpu = x86_task_fpu(current);

I think this patch can also change

	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);

above to use x86_task_fpu(dst).

Oleg.


