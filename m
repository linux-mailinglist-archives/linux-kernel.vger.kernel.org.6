Return-Path: <linux-kernel+bounces-390451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E39B7A19
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1D0B24021
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15FD19C54E;
	Thu, 31 Oct 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG5qthLY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69819B5A3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375864; cv=none; b=An3+92kBj3ellB0GnPaKzdoD/rppAL3vr5PIxSzTUNcZWiiHbmHJaIPaTh0cVMplnSfrc5IY2+1T7+B7w6LUbgwHbLhUB047sWAu8zj1FrHsLTdn4Nf+bc7/DDhI+IPv3v2b3QvSVKfwQ0LuQHOqVHKX8K8ASs/L90p0XUE5MFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375864; c=relaxed/simple;
	bh=zZKWGwiMvhDwQja/mevBFJq2xE2C8PZjEb+Ypk4ZvzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJCJzs6ccfyXvDnoorfm0XDwO4IbTFstQImO/2f61Z1rJiZyRYle2OgwaAvzOJrjs0nxwX8mWL+rHa/OF1f5wjBY6S4awygR9yG3gD8ucxj+OroWOFpStfJl+cqdItb/Ht1MKuDAgJ9PknITj5gBRWwD7H6afYC23G4Z5JbgvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG5qthLY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730375860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gO9cb0YlooU8sygRr/HovquupewbjtkPjySJ8kfPvRg=;
	b=PG5qthLYAG3+QhpV2UcvJJt5Wd1g8iGqhoEax/Boytbg3i38klpy5Tqsyzxx8+GluW/l92
	Z1aXlA7x51vnuKo4PeiqTvYrJ5xil2pRk2Sm+QbCPLM8o1AQl5jxMJwd1WS8mcklejxdtO
	VFklzwgxOFp+tDFDOanHYA88mBzQljY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-19KnJbPkPayZXhj1P4Y4EQ-1; Thu, 31 Oct 2024 07:57:39 -0400
X-MC-Unique: 19KnJbPkPayZXhj1P4Y4EQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d432f9f5eso465255f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730375858; x=1730980658;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gO9cb0YlooU8sygRr/HovquupewbjtkPjySJ8kfPvRg=;
        b=VqrxjRhEv1WpdpfK4b8Lu4iN+5BQgDYJezci4FfqRGC1a7Me6FaCQqyAvntZXrvYK1
         BlRtee2PiQQpEIYwUtARj1OYtxMEjo1S2zzY5rS25QB+QRgh2/i4VV+U9FmlTg9qqjqk
         AVD/X33LG8DRsSSAaTWf5EK049YCQEn23HJV5ab3OqqJcDzNHzXfeOgdCdwijl5KwNSX
         ippIQ+oJDhmTUI+NigSOQDQWHqspJIj4qT79OECOxjVzcZMmST3L+waGyMBI5JE6BL+e
         NXtsjPuLD61+lgXZbwMZPGzzupC3Ocy//MuEr3OjQboRwWAW87jZaJCP7/0l1yM95zRI
         ttRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLL1Zdk41TnMeYmaFG2Z96XSSfIggLrPVvGlpyBo9soyQVCKi62/cGSKrSgcUeIodE5sEdln9bzqlPx3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6QYC6RRODcJjv3AiyoT5PMnOlU+1wOyxwKLMn7HbqiOiv4hs
	fhg7efXdtAaEj5cuKSay8gNfqCUgK761dSgqkdH717zU/GJO7hVrJhRUIOO/7ooT1b/qpEh7Wew
	r+HpjuIoCidLn+yy7VbJFbvNMLsMMoK3yxCGs3hi8YRNyi1EHSBXxKPQsLzwhGg==
X-Received: by 2002:a5d:4489:0:b0:37d:454f:b49a with SMTP id ffacd0b85a97d-381b70f0802mr5046424f8f.43.1730375858525;
        Thu, 31 Oct 2024 04:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvPg9OoklPkC7XD5CO2UqfNm1GBNIcJP1KBM9R11xEmvHkoaWokdbmagf6xD0zwrZ7mtP1hQ==
X-Received: by 2002:a5d:4489:0:b0:37d:454f:b49a with SMTP id ffacd0b85a97d-381b70f0802mr5046410f8f.43.1730375858184;
        Thu, 31 Oct 2024 04:57:38 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c1esm1910589f8f.12.2024.10.31.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:57:37 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH] KVM: selftests: Don't force -march=x86-64-v2 if it's
 unsupported
In-Reply-To: <20241031045333.1209195-1-seanjc@google.com>
References: <20241031045333.1209195-1-seanjc@google.com>
Date: Thu, 31 Oct 2024 12:57:36 +0100
Message-ID: <87froctrgv.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Force -march=x86-64-v2 to avoid SSE/AVX instructions if and only if the
> uarch definition is supported by the compiler, e.g. gcc 7.5 only supports
> x86-64.
>
> Fixes: 9a400068a158 ("KVM: selftests: x86: Avoid using SSE/AVX instructions")
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> My big ol' AVX enabling series ain't looking so bad now ;-)

Smaller the change, bigger the troubles :-)

>
>  tools/testing/selftests/kvm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 156fbfae940f..5fa282643cff 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -249,8 +249,10 @@ ifeq ($(ARCH),s390)
>  	CFLAGS += -march=z10
>  endif
>  ifeq ($(ARCH),x86)
> +ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=x86-64-v2 -x c - -c -o /dev/null 2>/dev/null; echo "$$?"),0)

With this test, the outer "ifeq ($(ARCH),x86)" check is not really
needed anymore I guess?

>  	CFLAGS += -march=x86-64-v2
>  endif
> +endif
>  ifeq ($(ARCH),arm64)
>  tools_dir := $(top_srcdir)/tools
>  arm64_tools_dir := $(tools_dir)/arch/arm64/tools/
>
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e

Reviewed-and-tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


