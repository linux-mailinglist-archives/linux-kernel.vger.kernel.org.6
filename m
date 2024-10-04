Return-Path: <linux-kernel+bounces-350071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B344B98FF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11BD1C21E77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14168146A63;
	Fri,  4 Oct 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6UH7z+6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DE13B7B3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032970; cv=none; b=oCDxZZO2hXLdu7IpThjqtU5bJBH+t6QY1dx9Ri6Mwt1QeQfo3NFgyuJJdEobDzjv2lqXuQbSvQFdbU69jYSa7hCwI8cwBmxIICPpR6DdfanZYmMmwDepl+M8QHGPRi6AMCNdQbwBfzCagQ1Z8itjTyA1YeHbSp2Lb79h3DiJ6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032970; c=relaxed/simple;
	bh=T5PFGD9lEASkGh8bORm3ne9WwDEVHCvoDd0G7Ax0g3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unpXZS6FCmulBFQPvsnGQsPlYBP/j2jNrv5uSWrQ/cqIIJDw3PZaNXFT57Z5StVAWrMSStrvFbXche/CdDjkAj7armpSHzvFsVAnGWEVS2ei1AH3hQ3xVbAUfG3l2q833zItls9kiMiEil1AoCENu6OZ0OBPuL15cTqqD1oXesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6UH7z+6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neCYU8HXwagE9MPcXvxpVxLYneIMF3Zjo4mshTJi9L0=;
	b=X6UH7z+6UlVU8DCURTOWyr6p5RYqXtv95ehkCl3LcBhRePTqr1gnt7f23kVfEGGp9i1oQq
	WhvyFfTIWgsIgyHeALxq1uIsSuLP7CVVaUbf9eqtbKO8RQMA+2FU5GrYA+J27rh0JqFTw8
	H81fS4Ifv5bjmVycHnkI0P36s0cu/+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-VPieQ1I-MnqtpK2zSMOcwA-1; Fri, 04 Oct 2024 05:09:26 -0400
X-MC-Unique: VPieQ1I-MnqtpK2zSMOcwA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cc4f28e88so1368816f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032965; x=1728637765;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neCYU8HXwagE9MPcXvxpVxLYneIMF3Zjo4mshTJi9L0=;
        b=V4iO0iU5/6JUphG003Oh5HJI8GFj+i9jstJfMxslAWeUHWefbmRO4YEkM2zwJbzRwU
         ijhzjAdTocPYzRp1RMqK90RhKRf4Sb9HF07tqUw6SUjwCvPp+7ClhymTydI+H32kpwJk
         U/TdiY0YmtV5JaAf1kdW1CY1QLzJjwX/CGPtaFF4d9Ws8kZoTD7RwgACzS1myDQ4anFc
         B3O+/lwwoDusXcFmbMLqoWeb73EV/00KgUdcUamqBVEwPjdlBGl9FamoTC2KOZvpxtK/
         es5c7+z7qtZqdft2+vaTek7Jxctglf2UjL3N2xRY2z9p0jDSvSpJM1HhELKSCUPpnNkG
         Zeug==
X-Forwarded-Encrypted: i=1; AJvYcCW6tbNqTOZe62lJTu7xGxC93dePuV4aBkwGSCKigi8QFder94gUnH/iLUfUzqadugI93b44A2Neza3qO4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFJzcRQpBO2RQjSN0enbAQf3oZz/b3Q16242d1xfJupTHZUTL
	Aq1XEsQrnN0H6UX7us0s4E1en1tzBWe9Tmht6p0B3/mJMzi6QuoRxdUuhf9mFu/xUaOqyRdLu/k
	FnnzG7y2tyPOwgequZ/WDgZdNbgqtjLi3r80Iz4J9ffKZCvjPfuKT+rKDiWciwRLWzuGW10rbNj
	7EM6i/RBjV01d5/8KaVyyHSYziTgjRCFh1OOxMYIWJCsic8Q==
X-Received: by 2002:adf:f9cb:0:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-37d0e6eaeccmr1856775f8f.6.1728032964854;
        Fri, 04 Oct 2024 02:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcUTMnW4Js5lQ3/pyfi2sjn0jS6HEOK3lCWiPJoEUDunJiB1hCDRW0LzxTH+vmRe+s3pYbDA==
X-Received: by 2002:adf:f9cb:0:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-37d0e6eaeccmr1856742f8f.6.1728032964446;
        Fri, 04 Oct 2024 02:09:24 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0821633esm2839096f8f.32.2024.10.04.02.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:09:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] KVM: selftests: Drop manual XCR0 configuration
 from AMX test
In-Reply-To: <20241003234337.273364-9-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-9-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:09:23 +0200
Message-ID: <87iku8i69o.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Now that CR4.OSXSAVE and XCR0 are setup by default, drop the manual
> enabling of OXSAVE and XTILE from the AMX test.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 23 ++++---------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index 903940c54d2d..f4ce5a185a7d 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -86,6 +86,8 @@ static inline void __xsavec(struct xstate *xstate, uint64_t rfbm)
>  
>  static void check_xtile_info(void)
>  {
> +	GUEST_ASSERT((xgetbv(0) & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE);
> +
>  	GUEST_ASSERT(this_cpu_has_p(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0));
>  	GUEST_ASSERT(this_cpu_property(X86_PROPERTY_XSTATE_MAX_SIZE_XCR0) <= XSAVE_SIZE);
>  
> @@ -122,29 +124,12 @@ static void set_tilecfg(struct tile_config *cfg)
>  	}
>  }
>  
> -static void init_regs(void)
> -{
> -	uint64_t cr4, xcr0;
> -
> -	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE));
> -
> -	/* turn on CR4.OSXSAVE */
> -	cr4 = get_cr4();
> -	cr4 |= X86_CR4_OSXSAVE;
> -	set_cr4(cr4);
> -	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
> -
> -	xcr0 = xgetbv(0);
> -	xcr0 |= XFEATURE_MASK_XTILE;
> -	xsetbv(0x0, xcr0);
> -	GUEST_ASSERT((xgetbv(0) & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE);
> -}
> -
>  static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
>  						    struct tile_data *tiledata,
>  						    struct xstate *xstate)
>  {
> -	init_regs();
> +	GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE) &&
> +		     this_cpu_has(X86_FEATURE_OSXSAVE));

Maybe 

        GUEST_ASSERT(get_cr4() & X86_CR4_OSXSAVE);

also (or instead), just like cr4_cpuid_sync_test?

>  	check_xtile_info();
>  	GUEST_SYNC(1);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


