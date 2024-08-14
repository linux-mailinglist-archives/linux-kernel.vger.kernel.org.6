Return-Path: <linux-kernel+bounces-287009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91364952185
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D1828409A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBA566A;
	Wed, 14 Aug 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRw/mpkH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F311B9B2D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657813; cv=none; b=djPNZIxSIoF9st7j0ZHy7RVf5IhUzbSiaE0i59x+zhIGTEuD19fkleBF54td3T2gB1HDIqhHwHQ4fQcIhy4bEHCzHwMXTPuWbr8IMV7xcJId46JJXj45Ib+h2Gbanhgl6c7n6fwkRzcytbhFoiEHWBW5kP6Wh6/gx5TUUWMaBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657813; c=relaxed/simple;
	bh=o7UnWKGC5ImuqDKd0A+y4X+zbi4zjYGIUvZ598GJQx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc9A+Jlsm2be1p7u0Rujb2eq2ImWxN2kvJKwB3flgYwVvdi+mi+T5dPmYyYJ3MDHmTbkCEOUfEUwNEi1bqgOe0s1jTD5Au5RBDOohDBhjxiRpgiqax9Sr6Gl42EnTISGW0mfMkcngOUADbTsDWaW8H7HjlkrwNGi2rE8QzCKmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRw/mpkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723657810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D60tbrlKP7Gw+YlhJwC85uUtehBLMwc9/zsHx1WY5pU=;
	b=GRw/mpkH+kT796eyTe8bB5jyk9pwfpItSN79O4Cmf97J6VNaraPJ5nSTpbnn2JV4pu0Eva
	8tIQJonISs9yQ3wgox9lyIDlRwRpr2gCM3zpATdvvFkOjWCGYymHXVQsGenIRJzl1E+xzH
	DDmMivBIXGF0xab9VhZGVrYq1osi2qk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-vrluelwyNsOEipLlijuJ9A-1; Wed, 14 Aug 2024 13:50:07 -0400
X-MC-Unique: vrluelwyNsOEipLlijuJ9A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36bbcecebb4so124847f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657806; x=1724262606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D60tbrlKP7Gw+YlhJwC85uUtehBLMwc9/zsHx1WY5pU=;
        b=jcD1+OR2cqEpJ8bycUSt5XFhBoBpOeLX5JH+bBFC3cF/ruLDg74QKyK7aVYcq5Vl94
         5c0bEfZLhFEjEA0utFWxi5rkTxlI0/O7DXlmXwB1pt7ajXiJNIe7y8u4p51OudbwucYn
         xbQpon2iFzsb0PQ59SZvwRqYIFdzzsjdNKh9ZtwRGzIHC1hkXCbJS4gUXoq3tSDQQzZh
         uObKTBaBYPVNiEnrlYIgv/2z5pf2NP8yNqbYEew1joTn1kattIHCm50g2hh3Y8TmcKTX
         N2S5ZTxNg3pI4APlH0BbFm6P2S3Fym1YPADdcAuOr5poOwLEN9y6ZegKnhWEfSXzOK6e
         oIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSSd5MS1nzjo13gn46sRWYwR3UYuB7CDbkjxxaPoKc93C+XPVGsJU+qvtMboaI3IPKcm1J5PgyaI11pR86FlCR3LrpEiQD2fp+Ye6e
X-Gm-Message-State: AOJu0YwJjZ+6LQa1dwM6ybqjh/agow/+Yu4R4C2BP/FetEKHTS7LFnZS
	3fXUSx51TBGCYaSOPwb14GOLNhHLzf09e8yQ2m93lczRyp1coT0RJABRa3FGvTgKNqB2nHu5BRk
	VkB9+0IvNW8JRnokrrZrXbPC37ORiy7G0COqYxz7lb4UM4hYb6cWhy/T/Elfzxg==
X-Received: by 2002:adf:fb4d:0:b0:368:78d0:c240 with SMTP id ffacd0b85a97d-37177785ebemr2965847f8f.35.1723657805845;
        Wed, 14 Aug 2024 10:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5RNDAtSjrNSf17qwEzrd6g2TkSGUK2wx5/qSGkwfZKkZy0bGLK/2llpLIbYk1QHtZWfCfOg==
X-Received: by 2002:adf:fb4d:0:b0:368:78d0:c240 with SMTP id ffacd0b85a97d-37177785ebemr2965825f8f.35.1723657805330;
        Wed, 14 Aug 2024 10:50:05 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371874c7e1asm151669f8f.9.2024.08.14.10.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:50:04 -0700 (PDT)
Message-ID: <6530eb94-b937-415c-8457-f5c598d94e7b@redhat.com>
Date: Wed, 14 Aug 2024 19:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] KVM: x86: Remove manual pfn lookup when retrying
 #PF after failed emulation
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-17-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-17-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> Drop the manual pfn look when retrying an instruction that KVM failed to
> emulation in response to a #PF due to a write-protected gfn.  Now that KVM
> sets EMULTYPE_PF if and only if the page fault it a write-protected gfn,

Pointing out where this happened will likely help a few years from now:

With the introduction of RET_PF_WRITE_PROTECTED, KVM sets EMULTYPE_PF if 
and only if the page fault it a write-protected gfn, i.e. if and only if 
there's a writable memslot.  KVM will never try to redo an instruction 
that failed on emulated MMIO (no slot, or a write to a read-only slot), 
so therefore there's no redo the lookup in reexecute_instruction().

Paolo

> i.e. if and only if there's a writable memslot, there's no need to redo
> the lookup to avoid retrying an instruction that failed on emulated MMIO
> (no slot, or a write to a read-only slot).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 18 ------------------
>   1 file changed, 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 771e67381fce..67f9871990fb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8867,7 +8867,6 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>   				  int emulation_type)
>   {
>   	gpa_t gpa = cr2_or_gpa;
> -	kvm_pfn_t pfn;
>   
>   	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
>   		return false;
> @@ -8887,23 +8886,6 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>   			return true;
>   	}
>   
> -	/*
> -	 * Do not retry the unhandleable instruction if it faults on the
> -	 * readonly host memory, otherwise it will goto a infinite loop:
> -	 * retry instruction -> write #PF -> emulation fail -> retry
> -	 * instruction -> ...
> -	 */
> -	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
> -
> -	/*
> -	 * If the instruction failed on the error pfn, it can not be fixed,
> -	 * report the error to userspace.
> -	 */
> -	if (is_error_noslot_pfn(pfn))
> -		return false;
> -
> -	kvm_release_pfn_clean(pfn);
> -
>   	/*
>   	 * If emulation may have been triggered by a write to a shadowed page
>   	 * table, unprotect the gfn (zap any relevant SPTEs) and re-enter the


