Return-Path: <linux-kernel+bounces-441827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F689ED49E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA4168A15
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6C2010F6;
	Wed, 11 Dec 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1KBqYF4"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD024632E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941184; cv=none; b=GIdW9i7yShjG4D1EGXx6NZsxeEyYfcqmIHVqdbK2OePsCn1RWXo7LoLg9p0x7NRx0CEi6p501ZS+0CAvFBf722zZBm9rTsK/qy0vNBLqXarm7JaVShE9GT/W4FfPgXaTGQPXv0vJg29XbpYIW8kDZfPpPY/FbU+kEdpDbUvJKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941184; c=relaxed/simple;
	bh=ZbCbmR5jMjwAnZZJyPRIhcuLAcSixii4vmbFPSCb34E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=avsY7kfp/TtLbDE2xLRVLMED13fIh1n/35+yCGrkySpoxrv3yn9iYEQDJM+lmPHx/iWUolcDae1eWvaxt9BWEZ//9rEkzTrlnnxKqC7cEUjW6yAvSobAqAOq1TyBjtioCqF2kqxP1KI5QCH4Mse71CcsQcIXwfba10Ozrq/HRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1KBqYF4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso3713167a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733941182; x=1734545982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRvlwWxZGciZrSI2v4VPIECYyumLg4e7Uoks/odo7g8=;
        b=x1KBqYF4CpAI7Vlpul6bsyBLkkmzPiDAdJ2ueBbeUM3QdWkcplyYFvhUrekbehWxlb
         fBCAMBO5EQJgrtG24WoOertvLDPAP2p5ZCq4JRLckQPcxxkPPZ3LZeYMDjhippvl6NPF
         YaTsEGl/nGMALv6fmcWlWrgsht2jgsS5ugSBoJh93+29W9/PKuUh9ftsztKR81rUpGRB
         1jxX8PfiXxIIVq3LPTAfFMVJZgNGJXnMc3csPGOW8QG9C0aJjUw4dWaby7y1WMA6cM8k
         PvV5Syi7Lwo9Zp3LXZKmnBD2+6xf7L279Mny0f7BsHxRFDZy4xNuE0itUJ5s+1IH3ssn
         2uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941182; x=1734545982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRvlwWxZGciZrSI2v4VPIECYyumLg4e7Uoks/odo7g8=;
        b=TUvDxhnKFOG9lKzXEfdauAKpCER+0vgtdGVI6OqNWAiC8u7hSW03tfLpuwFesqB713
         0gDZ58z9UC7YyqzzoQHw2pTkj6Ma6gtXP+v8eRuFQGUmmHaa09vija/PDMIWI1WxNWdq
         zVcpdGKlk/qahbgI3fBasgSG93q3LNprxNBbt7z2Mzh89cGR/T4kh0N4HVi6RcgTXtt1
         Rp+tCQo48w5f4Vnw1Cfqxq6/pQYObY+2SgyND4RoFurKIJ7FFBDYoKhagUZNQfF6wCkt
         HHuCmwOrhl2yQSmJPrXEWuiGg8ZHfz6PNRkBrdO/ab/10ZC34vFPD5MUqMjHyoX0Bvch
         t54w==
X-Forwarded-Encrypted: i=1; AJvYcCWYNv4h3MtvsxXfkmr03gXfGqbBN7XcvZ+/8RYHYP50HfCGS9cNT8Qs2qoOIzNg537m3QnI4LPmtS9CJaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeplomkGgukKkXjeYoRoaLceROqSru5NJxHjsS9NNpnSMSbw9F
	ygIgNphgHfd9RzAZP150VZ3YBGIahDkv0ZKlFggpso7d31QHKubvaCBf8VXYH9/8MBtoDnKgO2a
	7SA==
X-Google-Smtp-Source: AGHT+IGAQad98x+9buqedyejzr8w3DIDOOBuC1wPAHcLmV8x5kvdALMYM6oNb2Usre2fXUAEDTniyhyr28c=
X-Received: from pjbrr8.prod.google.com ([2002:a17:90b:2b48:b0:2e5:8726:a956])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d06:b0:2ee:c2df:5d30
 with SMTP id 98e67ed59e1d1-2f12808c011mr5454846a91.26.1733941181703; Wed, 11
 Dec 2024 10:19:41 -0800 (PST)
Date: Wed, 11 Dec 2024 10:19:40 -0800
In-Reply-To: <20241111102749.82761-7-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-7-iorlov@amazon.com>
Message-ID: <Z1nXvL05VXShYpYR@google.com>
Subject: Re: [PATCH v2 6/6] selftests: KVM: Add test case for MMIO during vectoring
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> Extend the 'set_memory_region_test' with a test case which covers the
> MMIO during vectoring error handling. The test case
> 
> 1) Sets an IDT descriptor base to point to an MMIO address
> 2) Generates a #GP in the guest
> 3) Verifies that we got a correct exit reason and suberror code
> 4) Verifies that we got a corrent reported GPA in internal.data[3]
> 
> Also, add a definition of non-canonical address to processor.h
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
> V1 -> V2:
> - Get rid of pronouns, redundant comments and incorrect wording
> - Define noncanonical address in processor.h
> - Fix indentation and wrap lines at 80 columns
> 
>  .../selftests/kvm/include/x86_64/processor.h  |  2 +
>  .../selftests/kvm/set_memory_region_test.c    | 51 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 1a60c99b5833..997df5003edb 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1165,6 +1165,8 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
>  /* If a toddler were to say "abracadabra". */
>  #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
>  
> +#define NONCANONICAL 0xaaaaaaaaaaaaaaaaull

Uber nit, I much prefer to place this definition at the top of the header.  More
specifically, it needs to not be in the middle of the selftest's exception fixup
code.

> +
>  /*
>   * KVM selftest exception fixup uses registers to coordinate with the exception
>   * handler, versus the kernel's in-memory tables and KVM-Unit-Tests's in-memory
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index a1c53cc854a5..d65a9f20aa1a 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -553,6 +553,56 @@ static void test_add_overlapping_private_memory_regions(void)
>  	close(memfd);
>  	kvm_vm_free(vm);
>  }
> +
> +static void guest_code_mmio_during_vectoring(void)
> +{
> +	const struct desc_ptr idt_desc = {
> +		.address = MEM_REGION_GPA,
> +		.size = 0xFFF,
> +	};
> +
> +	set_idt(&idt_desc);
> +
> +	/* Generate a #GP by dereferencing a non-canonical address */
> +	*((uint8_t *)NONCANONICAL) = 0x1;

Now I'm curious what happens if this uses vcpu_arch_put_guest(), i.e. if the
test forces KVM to emulate the write.

No action needed, the test is a-ok as-is.  I'm really just curious :-)

