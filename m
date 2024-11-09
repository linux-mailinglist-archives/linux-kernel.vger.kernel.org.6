Return-Path: <linux-kernel+bounces-402730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C69C2B15
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B8F1C2104A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A4141987;
	Sat,  9 Nov 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoAwuPib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE1A55
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731139425; cv=none; b=KZ7l7/bCzas8EkOYhedG4zgFqfrKBjvZ795a4S+uTRSMiLSAtlj6olMZQt/JvmjL5kLknIEVpquyZGgFnTz52oU4YBXa7Dvui8XOwMZYp8+rkFy+oYT0Ac+lpZq04C+Ok/+zzStxHNcAv7lkqnuV/ZkQnM71x0N4J89I75dduKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731139425; c=relaxed/simple;
	bh=GeI0fLaLpvtlK4dSf2XgYceyeXUb/s5dtmXKiEb35vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QejovhT9AF6egCxNUyCPjFunPoc+lGWE6JbIGI3CruT11lK9wXMhhCoIfbfSTNyhiOQEg8U8g8hvJU+hosDRr8DaiipLQ5KkZk2ESgUNT1Lm2L2S9ICYKASV1g/sGSbLSuxpasU2DO5QA0T2ZXOEvNu1nB8nRMjWJqgAKR/NaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoAwuPib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731139422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=81ghy7S7dc5f/N+uypQLKpiw/fytQsX5RCCqjwiTGGk=;
	b=ZoAwuPib8xyg3MuTeit5VKreX4xYDB86Ztr0BJ0X27iRSe4CWhj5uhbbulTtr7LqCiRmuj
	ADptI6W7eH5hnbpPXqcZNuB3DaBmej6Pt8LLfCA9DAaPbwnaiAUsHs5z9cqVzIKeYUzy4k
	8vCCVRIfrbKuzhz/c2gBJSxSjrPxbqU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-PxA0EePHO6m6U3YDgQHTTw-1; Sat, 09 Nov 2024 03:03:41 -0500
X-MC-Unique: PxA0EePHO6m6U3YDgQHTTw-1
X-Mimecast-MFC-AGG-ID: PxA0EePHO6m6U3YDgQHTTw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d662dd3c8so1739235f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 00:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731139420; x=1731744220;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81ghy7S7dc5f/N+uypQLKpiw/fytQsX5RCCqjwiTGGk=;
        b=BRsCHpS8MI5W9AEN+llOZf6a50dr1FZOaSPU8Ist6IgEjJC++sXuYCrwliCLtRs9Ms
         ZrPZTrlGUHlx5PJsS1Ii9UxV9DHDT+TXn9XiTBNHu9xVMG+Fa+Oi11+Oz4tb0dzhgBBF
         kmhQzeT7lVUC+C9bGIt+8LlqtqOvLRl4MSrJlQkRZRlyEZ5COgqojbjbRiSuvEa+wuXz
         kVPu0zBZljzGiHyawfPBHyYMIfqbSWXXvkCc5QKpyLyg9bsVxiMcyrZb+vD25GLpZmxj
         sGr9Zed3VJ267zkei4j59gKBzgtDuPcMEAz1jGHLjeT7TTHW0+w5HneqqfJBEC4UkNdR
         xw+w==
X-Forwarded-Encrypted: i=1; AJvYcCVZvg/PSfTV4R+XILr1tzCPv7iflPmGi1T8K6e9pPdOuL5Zz4GFe8fI007wj8NSy1u6o4kBsqnG/928Y3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpyA8bkKd3qBprXuLknc1+xnvscgN1WDcmmGh7y+qjwRmZpNc
	s5/RESTlErd8+vEt3whN9xwUhF0TL82mnKOZpFGNlN4wgV2dBM5kAXjmUpB1mPfltPk5mim+8hL
	TgGsekBvoQHTtr+f9iaA3bF0wtjoAkLzGIrlVzUQnrkk4zD9S8vCorZl2o60q+Q==
X-Received: by 2002:a5d:64e5:0:b0:37d:41cd:ba4e with SMTP id ffacd0b85a97d-381f1852777mr4965968f8f.48.1731139419856;
        Sat, 09 Nov 2024 00:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8S7g8siMD06Jm9yyDKzjNGFVN6mNFTW8PqUM3PNN28/3uaOERCrz4N5w754+99qs60tKorg==
X-Received: by 2002:a5d:64e5:0:b0:37d:41cd:ba4e with SMTP id ffacd0b85a97d-381f1852777mr4965934f8f.48.1731139419457;
        Sat, 09 Nov 2024 00:03:39 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05673d0sm95925885e9.25.2024.11.09.00.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 00:03:38 -0800 (PST)
Message-ID: <54f44f6a-f504-4b56-a70f-cf96720ff1b8@redhat.com>
Date: Sat, 9 Nov 2024 09:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM/x86: don't use a literal 1 instead of RET_PF_RETRY
To: Sean Christopherson <seanjc@google.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20241108161312.28365-1-jgross@suse.com>
 <20241108171304.377047-1-pbonzini@redhat.com> <Zy5b06JNYZFi871K@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zy5b06JNYZFi871K@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 19:44, Sean Christopherson wrote:
> On Fri, Nov 08, 2024, Paolo Bonzini wrote:
>> Queued, thanks.
> 
> Noooo!  Can you un-queue?

Yes, I hadn't even pushed it to kvm/queue.  I applied it out of a whim 
but then realized that it wasn't really -rc7 material.

> The return from kvm_mmu_page_fault() is NOT RET_PF_xxx, it's KVM outer 0/1/-errno.
> I.e. '1' is saying "resume the guest", it has *nothing* to do with RET_PF_RETRY.
> E.g. that path also handles RET_PF_FIXED, RET_PF_SPURIOUS, etc.

Gah, I even checked the function and was messed up by the other "return 
RET_PF_RETRY".

If you add X86EMUL_* to the mix, it's even worse.  I had to read this 
three times to understand that it was *not* returning X86EMUL_CONTINUE 
by mistake.  Can I haz strongly-typed enums like in C++?...

         r = kvm_check_emulate_insn(vcpu, emulation_type, insn, insn_len);
         if (r != X86EMUL_CONTINUE) {
		...
         }

         if (!(emulation_type & EMULTYPE_NO_DECODE)) {
                 kvm_clear_exception_queue(vcpu);
                 if (kvm_vcpu_check_code_breakpoint(vcpu, 
emulation_type, &r))
                         return r;
		...
	}

So yeah this really has to be fixed the right way, after all even 
RET_PF_* started out as a conversion from 0/1.

Obligatory bikeshedding, how do KVM_RET_USER and KVM_RET_GUEST sound like?

Paolo


