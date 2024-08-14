Return-Path: <linux-kernel+bounces-286944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C49520A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2C21F26BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203B1BD00E;
	Wed, 14 Aug 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AU9T9J+P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA071BBBDA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654899; cv=none; b=Ww8oL6bL728lCRXyFuSSE8n8FU0K3MihzVERpaiwmjXKzmkemBKimtOQ3g/xlqHM1wl7ZKsXOkNXat+sPiKHZ7Xv543kIqB0vIO7qz3oNBypwQvAZz8UY3BCj1/y6R2PFLndtnTiZgJRq7bK4Vk70zLO9fHa+nV2oHc+faJRcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654899; c=relaxed/simple;
	bh=VYRgcHXgXzeuVmjIOafMI9c0OXj8WbW5U/Iv24AO13Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkyfS7wBYMK7GffQDCAhjfE9xLcz9u3J8elQ6x6HYqDFMRFNKBloqI5iCbFJZa9aVbZy/MqWCVS6gp9T27RkmETXBXGCnWFkq243mf9Fa+bWhfK81yZzsCUiJ+6cTSEYd25D7T/foJs3LWZ1HCiKf3Q6fBh3er22+X8pT435jyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AU9T9J+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723654897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MjXCGxatlDZ1KNyi/7rliCZsGvSUn9iond2ZEL8Yy0I=;
	b=AU9T9J+PuqgclTwt0Jt8xrzWSb7/aAvN4suTNvNlAwonS4wOORTScU0GPpYwZG/RDOxFsh
	6z5JUEj7PJvWLN/rsAZogJnbSb/sJ6oT3InKiHtsIoxBADX3xBT4vcFVjuefFmMKuLQCp7
	nqazCcGbMuJu8y3rtsrnEfE7fGlamCc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-8PwpUusFODaSzR54WV-JHw-1; Wed, 14 Aug 2024 13:01:36 -0400
X-MC-Unique: 8PwpUusFODaSzR54WV-JHw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so383945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654895; x=1724259695;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjXCGxatlDZ1KNyi/7rliCZsGvSUn9iond2ZEL8Yy0I=;
        b=jaKeDkKdPLH+T/nGRlkoAvB1P5bRKoZd/8IchBFpufNzUIW33DJuJQOl96Rhm3Bl+G
         1Y4w2N7Ddz71S/yfpRQtU5ErgK7KjyoYe46QwD0zfpflXiE4xA7uYj+dCA2XaV+L7XW3
         L+ubYj41sNK9e3cY1fMnMF74TGKHEkRk7eAEsPgEYhWFK4XXka5rD7ul8vSV6U8rqdKd
         NyPBpZqc3fH+Yy3fVsLuMhNMsHrkcDafR13Wl9ya4pV0bvbhCSsbUKN8/E96TBSBFvvl
         ZAesb3ePHP87yUen4KcCYKZldc9EfH+9GNk78IPDY/Cq1up5iis2Zt/IRQ490KwOqEwd
         6A0A==
X-Forwarded-Encrypted: i=1; AJvYcCWLwRVXhOcg5N3u9okoM4mn/6mkt9yBWIleiK7GZpeRHvYajM0VXyL5gv5RJpc14tLTmjJ/4Y0BjlIZiIkmhg9/Ef8VRBpr4DaJqp0g
X-Gm-Message-State: AOJu0YytfMHZhUISHOG8TRUQi+tfYkbSRFfnpDH+cyQIYhCuFC7qCNO7
	9og+KF/mhASBk/yqF6Yj9IgDnruhlepBzn9+w1pwBPzihgaDsL5eIk/Pmu6RfL9gsSWuL2Sxh05
	wkfCSkPM1NrFtkvSxE7UeeFRsTZCfBzwiASVuVyKdnEXWBHdMTl5g4JSfoZ0H1w==
X-Received: by 2002:a05:600c:3b93:b0:428:9a1:f226 with SMTP id 5b1f17b1804b1-429e230f2e7mr2316395e9.1.1723654894455;
        Wed, 14 Aug 2024 10:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH255Ze70YisByTklNwfmLUP8xftXys8uoH4zx9jFW6l9aBRCJCBcaWF+0B8g/kYTlGKeJQHA==
X-Received: by 2002:a05:600c:3b93:b0:428:9a1:f226 with SMTP id 5b1f17b1804b1-429e230f2e7mr2315955e9.1.1723654893866;
        Wed, 14 Aug 2024 10:01:33 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded1ec28sm25136585e9.5.2024.08.14.10.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:01:32 -0700 (PDT)
Message-ID: <d4751f47-c5ca-4aa6-b114-086df25c4ce5@redhat.com>
Date: Wed, 14 Aug 2024 19:01:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] KVM: x86: Get RIP from vCPU state when storing it
 to last_retry_eip
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> Read RIP from vCPU state instead of pulling it from the emulation context
> when filling last_retry_eip, which is part of the anti-infinite-loop
> protection used when unprotecting and retrying instructions that hit a
> write-protected gfn.
> 
> This will allow reusing the anti-infinite-loop protection in flows that
> never make it into the emulator.
> 
> This is a glorified nop as ctxt->eip is set to kvm_rip_read() in
> init_emulate_ctxt(), and EMULTYPE_PF emulation is mutually exclusive with
> EMULTYPE_NO_DECODE and EMULTYPE_SKIP, i.e. always goes through
> x86_decode_emulated_instruction() and hasn't advanced ctxt->eip (yet).

This is as much a nit as it can be, but "glorified nop" would be 
interpreted more as "the assignment is not needed at all", or something 
similarly wrong.  Just "This has no functional change because..." will do.

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2072cceac68f..372ed3842732 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8973,7 +8973,7 @@ static bool retry_instruction(struct x86_emulate_ctxt *ctxt,
>   	if (!kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa)))
>   		return false;
>   
> -	vcpu->arch.last_retry_eip = ctxt->eip;
> +	vcpu->arch.last_retry_eip = kvm_rip_read(vcpu);
>   	vcpu->arch.last_retry_addr = cr2_or_gpa;
>   	return true;
>   }


