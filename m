Return-Path: <linux-kernel+bounces-350066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C387298FF4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45510B20995
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57A14658D;
	Fri,  4 Oct 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOg8pXuH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEB140E38
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032727; cv=none; b=KbDUWIzCVGBEIyBu4Z9OTe3qeHh1Fuo+X+cJJ6m6X84Sf9T4prrTFK3RPqDZ1G0UoCkaeqaZG3sMNOP/fHDrTJpRPae8WaB7c3aJVU0xqkFCuqlyvJHmzkuBa1AXrnyQV/f7RKdcT47Pkvz0PcdgQJVG7IQ0KI/a0ANexEoVy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032727; c=relaxed/simple;
	bh=Sq4OcjY0EeQRIC1hZSJmdjUw6cPr6dDZEOS3Jwdd+DI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOZaUaKSeiq09Bda7elsQBuAfVXlc5/U17F3SfwaB/3stZ4u9SeH9VS7S3T1RX0yuQycTUXe1MCHfNYhPTJytBkag0O0i+zH/g4qrJgHIx90yDsrul8ifXe+6pOstXWmdLKd2BxC//in+y6H2z2PeJ7C6hKs1KRBJp2MuwB4LE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOg8pXuH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+34TNPttbqJWXuUaZlwkoaWIFsW5o7Y4R1pY/2NowPU=;
	b=OOg8pXuHABwLA0IwJ2MeKMIf5/9SoCKI0RwAwA9dnfDgLSUcSCo7KCUT+cyP7YCgEMHmST
	5Dw9ZTIr9L9DNnOFb7ZX8dqMIZzu4y984IzngdKawM6fdTn/RW4BD7mxWHlrqBQMSbia5m
	G0G5UYeZdRcink/0tBZDxEgF+5FIknw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-oiXSK1yaNqyUFXEG5Uco_w-1; Fri, 04 Oct 2024 05:05:23 -0400
X-MC-Unique: oiXSK1yaNqyUFXEG5Uco_w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37cda7514f8so975580f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032722; x=1728637522;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+34TNPttbqJWXuUaZlwkoaWIFsW5o7Y4R1pY/2NowPU=;
        b=vTwrJAeEGcinEusjoFQaSNN6a8nODFNd4q1y++LlGPS6zgVVtjWzr0DrkH/49YYKRy
         VEm3pWnak6LSTdumXzrrU/dHN2LF+lwR3Moqp7Pl/COa4crtqt2GB69zJThrxnX0M6PI
         Q02qnKA/9+MLOarZIl3wZxWxP0PyunG4IsV2CMmFFrI/vYAKvYDGOq08NQiQUXSpmWK9
         Xtgd8S2ciiFVTQR8d8cFzf1RcGXCpNLEzwU7dw1XZpMTJRFDUhsHLJDlVTiHjUpYOp6Q
         Sjkmj4Ll5U2t8N0e4rg0TC+ocVeQzO/y9kD7q6uz0ThGniY8RBFVbZ+ZpiAb304DbnOh
         vifw==
X-Forwarded-Encrypted: i=1; AJvYcCU7pVpxDCSnJVQcvWKk7lilOREx3aHjwxp2os3xbtF94ThdosJW2qf7G+HWRxDeUlCy1elLhbnGPD7A71c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkWdMie0caYzd0J/12nCwKT1td+1eyKDCyZV0wflSJqY7WJ5t
	5J4oi6LZZWEf3Gh1mjWPdGTesyGVza95P+eghsTPd5csyTb7+IFp7hmQgyoNbnW1k+SI6AI3P8z
	Ed23Wzc8SM0AjA13G1Q4k61j/wBx4xucKLAGweZdGpUiDclna4mo+BaklTClUN3etwN43ws62iy
	1gljv1yT/0IiqiZHDpuzfAHjKhpQ8XZB1HH1rmAVYM0FMJLg==
X-Received: by 2002:a05:6000:1884:b0:37c:cce8:4acc with SMTP id ffacd0b85a97d-37d049ea723mr4822650f8f.13.1728032722462;
        Fri, 04 Oct 2024 02:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZI65a4E0MWEudDsjrxjK4F+K9QmGtEmB+a+SuWRzGXeJWhv4eMOaxMFsitqPTzNLlOrah9g==
X-Received: by 2002:a05:6000:1884:b0:37c:cce8:4acc with SMTP id ffacd0b85a97d-37d049ea723mr4822609f8f.13.1728032721982;
        Fri, 04 Oct 2024 02:05:21 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0afc1sm10545735e9.1.2024.10.04.02.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:05:21 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] KVM: selftests: Drop manual CR4.OSXSAVE enabling
 from CR4/CPUID sync test
In-Reply-To: <20241003234337.273364-8-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-8-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:05:20 +0200
Message-ID: <87ldz4i6gf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Now that CR4.OSXSAVE is enabled by default, drop the manual enabling from
> CR4/CPUID sync test and instead assert that CR4.OSXSAVE is enabled.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> index da818afb7031..28cc66454601 100644
> --- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> @@ -27,12 +27,9 @@ static void guest_code(void)
>  		[KVM_CPUID_EAX] = X86_FEATURE_OSXSAVE.function,
>  		[KVM_CPUID_ECX] = X86_FEATURE_OSXSAVE.index,
>  	};
> -	uint64_t cr4;
>  
> -	/* turn on CR4.OSXSAVE */
> -	cr4 = get_cr4();
> -	cr4 |= X86_CR4_OSXSAVE;
> -	set_cr4(cr4);
> +	/* CR4.OSXSAVE should be enabled by default (for selftests vCPUs). */
> +	GUEST_ASSERT(get_cr4() & X86_CR4_OSXSAVE);
>  
>  	/* verify CR4.OSXSAVE == CPUID.OSXSAVE */
>  	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


