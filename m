Return-Path: <linux-kernel+bounces-258411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224579387A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C027F1F21031
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7912E4D;
	Mon, 22 Jul 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wgib+OoR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD58F54
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617775; cv=none; b=uGNl/HNFMZ60Rn9GVlzYJSYlDy0lQ+BFo/5b40YO+WQ5R9s7596NycpcQL6092Wh7fiCpd0NUK+s3gwep04OBX7WJQ68ROwCKjxV9lllBTfDtH2WIafUBvIFgN/w8XOFr/WFdPS6JpZbrDvAnHIH+xU+eSDyGMjm1VHu7lOHAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617775; c=relaxed/simple;
	bh=N78WybtYPkcIyt5my0EMie9U5JakpXy+mFWGzPNcVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsesKOPwN9siz6PpxMiYYf37gW5FlnHCt3mXWE/Ysg+lmVk/oMY+hk/Bj5CbRZRZYII6o//n6S3cMw2vLrhruxz1MorNeffvGqbL02DBJP4R/6/C1VgNwHKRYRQG4gg0hu5WMSwxaPSPBs/doVz3fPuni831CeHjQ9PhBYgCyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wgib+OoR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721617771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etqba8606LAa8l3O5OcOh1bnE+W9ImDVfH1gaX+xcJQ=;
	b=Wgib+OoRT/SP4ZiYJGc/ML5Bkab7C3HtR79A+sH8Te2cQxOWxg2XyFD1cyiyPSu0MqvYdD
	p5+DJ7c6R/y4PmRyGRe8j03eLp+hLh1n5KoSTaI8//bWHSaVsY2BPfFQQqpMNLG8ET9Dt9
	SVTXx/ei6IaAnMnHbbybVKUHQ7IdI5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-VZIGa3EQMGW6rcPIHnd04A-1; Sun,
 21 Jul 2024 23:09:29 -0400
X-MC-Unique: VZIGa3EQMGW6rcPIHnd04A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0746919560A1;
	Mon, 22 Jul 2024 03:09:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88C511955E7B;
	Mon, 22 Jul 2024 03:09:25 +0000 (UTC)
Date: Mon, 22 Jul 2024 11:09:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in
 kexec_trylock()
Message-ID: <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
References: <20240719103937.53742-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719103937.53742-1-ubizjak@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/19/24 at 12:38pm, Uros Bizjak wrote:
> Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
> atomic_cmpxchg_acquire(*ptr, old, new) == old in kexec_trylock().
> x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg.

Seems it can simplify code even though on non-x86 arch, should we
replace atomic_try_cmpxchg_acquire() with atomic_try_cmpxchg_acquire()
in all similar places?

For this one,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> ---
>  kernel/kexec_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 2595defe8c0d..d35d9792402d 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -23,7 +23,8 @@ int kimage_is_destination_range(struct kimage *image,
>  extern atomic_t __kexec_lock;
>  static inline bool kexec_trylock(void)
>  {
> -	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
> +	int old = 0;
> +	return atomic_try_cmpxchg_acquire(&__kexec_lock, &old, 1);
>  }
>  static inline void kexec_unlock(void)
>  {
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


