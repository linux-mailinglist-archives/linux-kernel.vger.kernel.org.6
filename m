Return-Path: <linux-kernel+bounces-241773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F18927F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A502C1C21B80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595EA955;
	Fri,  5 Jul 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dhpo6eGD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6D5C83
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720141125; cv=none; b=Hf1A9/6JPnS7wuHPe9A7S+iFvd+T8YTzWogJNy1zhs6IFGc24RFtE6iC+bUI5a1x+xerLUHOoXrCHnd4PjcE79D52fmQrTD68RR86MGkPfRxuR1MVn8ZprCEYmEaLPi9s5VdZ/K+20YuEVxomfNleT8dcwpU0z4nrXGeygdVfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720141125; c=relaxed/simple;
	bh=VocEeIcd/FXfuJ+JYbUhdbxRAvE4uj34aaDRIeuJFwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yeyesfs0yuA1X1ZhFoqjSJaQGZxoSjDb9NExAwU0bBlywzDFL7RP4+uMl5RqIc0qs9avWeym3CqYUFWcENPHeK08EsDq62qJXwEpaTwTamZHC+uOYAHUtmuDYHz9AnsM7rmZX6g4HPVXWOd2uc86depeR82bW1Oeq2F212OZimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dhpo6eGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720141121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBft8HzPsKQdo71AmXPwgwDDSRvuWQe++1hA5/bW3JE=;
	b=Dhpo6eGDKP7UYTjm+BhYG+N9F3ySu92KTyUBgOOxg81zQ/R0OXXl/gbKccK3ShWo5Vk0/1
	z3ibgKhK8r+SsioltHOfVKcBV/MgPgLrWA0xc6ed72InZx6usA9fT4K/svCQgnA+/YvGmK
	+KaDo8wOteBJrBi9YoRweh0MREadnqk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-TN2Wrsl2MciPf59T4tLXRQ-1; Thu, 04 Jul 2024 20:58:40 -0400
X-MC-Unique: TN2Wrsl2MciPf59T4tLXRQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4465aff370fso15103291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 17:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720141120; x=1720745920;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBft8HzPsKQdo71AmXPwgwDDSRvuWQe++1hA5/bW3JE=;
        b=k2isvbxSlmAEM1e4i1yr35CeC/Np+CcyxduVek+XTBfWjODZvvB1sdXP6hhwI8pZ5t
         fW13Fzl72bMuA5147KHFjWgxIZc+nxOBhaxt7THPNp3owcnHFHd9CZVZZm8qh8CQgym7
         DgX2p2qMiNB/Ryvaximm/KfiIGgayrAUn+xBCOOXKK6MgvNuJjNIomwZbTQGHLX413Td
         eIQ3aUMjd1frU2tQjwdngol0yIUTqkFBlFpeXkdJek59nZHGHbB6OoDLpV7Zr9LnUc81
         fRYxQwL9r/mkBcGDj/Agb6L13fdy1XWB2xoh2yVQn3D4wFQl6wwNwCGtfrS93NTbQ5FF
         BbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXWOSpxwkgdtjYGqrwRnGMMAeFQ0V9BSU26gzV+6oijzkR+L5Knk/hRj1AGhvfBQPigJeYB/CIzVboHSjJ1ZlRk+mcif5qTyoo8i/HF
X-Gm-Message-State: AOJu0Yy+flLUv6ZwaxQRXdO6UZvgDnEgFKddStD0UKwJfoc7xLE5WGxy
	2CzQmyv3+tjLafyYTuAdySRklRpreskUu2aQXvD31IdpNOXFN4rA5vLiUutmeXdEX8z5CQXrQZJ
	tp/OBXxNK4Y5qG2Zuxzga2Xbed6C5ubL8QpKF0n69t+LTJPy0CV/wHK2rVcrXHQ==
X-Received: by 2002:ac8:5851:0:b0:446:5fe5:5e6e with SMTP id d75a77b69052e-447cbf0276amr38482571cf.17.1720141119683;
        Thu, 04 Jul 2024 17:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0J29caQaADHKA8b8iQ6B27XY+0DYEZoK133EmNU8wXbtUhq5IQscTDcaOotdzR+1HPGcO9Q==
X-Received: by 2002:ac8:5851:0:b0:446:5fe5:5e6e with SMTP id d75a77b69052e-447cbf0276amr38482421cf.17.1720141119282;
        Thu, 04 Jul 2024 17:58:39 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143ac82sm65015101cf.43.2024.07.04.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:58:39 -0700 (PDT)
Message-ID: <6a8aee9425a47290c7401d4926041c0611d69ff6.camel@redhat.com>
Subject: Re: [PATCH v2 05/49] KVM: selftests: Assert that the @cpuid passed
 to get_cpuid_entry() is non-NULL
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 20:58:38 -0400
In-Reply-To: <20240517173926.965351-6-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-6-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Add a sanity check in get_cpuid_entry() to provide a friendlier error than
> a segfault when a test developer tries to use a vCPU CPUID helper on a
> barebones vCPU.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index c664e446136b..f0f3434d767e 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1141,6 +1141,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
>  {
>  	int i;
>  
> +	TEST_ASSERT(cpuid, "Must do vcpu_init_cpuid() first (or equivalent)");
> +
>  	for (i = 0; i < cpuid->nent; i++) {
>  		if (cpuid->entries[i].function == function &&
>  		    cpuid->entries[i].index == index)

Hi,

Maybe it is better to do this assert in __vcpu_get_cpuid_entry() because the assert might confuse the
reader, since it just tests for NULL but when it fails, it complains that you need to call some function.

There is also another call to get_cpuid_entry() in kvm_cpu_fms but this call can't have this issue.

Besides this nitpick, looks good to me.

Best regards,
	Maxim Levitsky


