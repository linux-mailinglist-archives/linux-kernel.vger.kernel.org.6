Return-Path: <linux-kernel+bounces-265872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D042193F712
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE111C21C80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477D14F115;
	Mon, 29 Jul 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhKZrnP3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECD14B07E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261222; cv=none; b=oYBBrnIUttZ4CNRu6LMxnIJBkmNL4wT2HwzNJRpjrvhYw0uQj2i+nT95sWfYik9PNC0MbxTVsk1P0QTTz7eWFkyBjCRV+3v/eqxYWc0gn1y5IM2NtZFXOJOxdjGqA8ggFvVoKA8tc9715IqgdBPWLkcNx7qx1WcMo3us0lDKMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261222; c=relaxed/simple;
	bh=zevFigggh9gav77vOeUqQEZLN00S3klYyCxmhPrpO0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMBqcsm1ESG07uQuCXzf6N/kxd84hBijmdJNN0a8MikMBOGV/dRh3RqrBldCDCwwHfsgoybjy4ID/Gvn4MuuWm8fV5VLOP58KA06DKXoBEaQVzNnm62vwXYtZKmeJ05vjp4alNiia9S2wdHxxSykt08pTudyGV0WHAXUrDrSFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhKZrnP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722261219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yEq5CChoNdWngYsHC+lDcujFG99veLH/xTIPSOMsNE=;
	b=DhKZrnP3TxhUnvl5fLyd12xOmSxvn4skU5fsVqsQEV2PT8pCCWG/snxQSYP+VTDtLyRo90
	Gpjvpz1poJL9YSYjHOXtWRY8rEVO6jkk+BtlifOZvFf6yzfjiYvc+00vnClJDauvtOWjqT
	W+zda9g/c/ZUCPEZV6kUQdqLMPJVYxs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-fgaIHUdIO5itErucwhmKSQ-1; Mon, 29 Jul 2024 09:53:38 -0400
X-MC-Unique: fgaIHUdIO5itErucwhmKSQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280c0b3017so19521165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261217; x=1722866017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yEq5CChoNdWngYsHC+lDcujFG99veLH/xTIPSOMsNE=;
        b=FD2VOq2z/MWyx6T8pz+DfojPQIkmqCmp23RqHkG+eIsCTL5C6MZY19BnpfF96SnBPI
         FrXDeh9/euwJ2kn1idwaI6NrR2EJsEDpXvoA5ysk9sVJkZpAtF0JO+mEqRz80f/SSkcU
         xggMhPqg7YzU0yRXl9DN+NQRB8B1WlYolRo3No9lHv+m3z1mI5t+NpVtTPuUOkL3j+CW
         GOPB7w9sXmraD8Q1xwzNZlagylwHGlNuY9VbIwXVZ3CiUufi+kKBfGf+uHQUwIug0GLg
         j/93H06XJc+/5U1oLM/bOFD+g4KOuyHzqOfi+bMKEyStbezVTOGysEsMeASHq30gZfPa
         6BEw==
X-Forwarded-Encrypted: i=1; AJvYcCWD6BL/RaYKKykHpXeYOLii/M1khaAcko1Wpbb4V6vQaNhnPCIrvrPx+Klw/nzda1CajxVJt1RpvgDQq8njD5OwVyaNjiDwasnNcZ/n
X-Gm-Message-State: AOJu0Yx1F/tkThi4XTo/vJGCPTeuPPsYneMKL+rZp++kBmGHCaUhT7Z4
	kWianFflGv05ZduiMNAVG0hgUaD8cGaOxPXCWCb8r5kaxvS5+YQIYbVbheKXRzLzvl9iUPWRWTq
	qqihpVRcGZzj/aO7WSz+ARCrxytlt1z3rnM/6cSTBt2viUc0U8B/5Syfr+vlIjA==
X-Received: by 2002:a05:600c:444d:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42811d83c38mr50666375e9.1.1722261216883;
        Mon, 29 Jul 2024 06:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ34nlwG6HFfNMqNvetJJ+pbG8/TxeOUBuPfISPhjduWTs2MRaELaUuF0Pc7fNro9Ocof+NQ==
X-Received: by 2002:a05:600c:444d:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42811d83c38mr50666185e9.1.1722261216359;
        Mon, 29 Jul 2024 06:53:36 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm123111095e9.7.2024.07.29.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:53:36 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, graf@amazon.de, dwmw2@infradead.org,
 pdurrant@amazon.com, mlevitsk@redhat.com, jgowans@amazon.com,
 corbet@lwn.net, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 amoorthy@google.com
Subject: Re: [PATCH 01/18] KVM: x86: hyper-v: Introduce XMM output support
In-Reply-To: <D2RVJ6QCVNOU.XC0OC54QHI51@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <20240609154945.55332-2-nsaenz@amazon.com> <87tth0rku3.fsf@redhat.com>
 <D2RVJ6QCVNOU.XC0OC54QHI51@amazon.com>
Date: Mon, 29 Jul 2024 15:53:34 +0200
Message-ID: <878qxk5mox.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Hi Vitaly,
> Thanks for having a look at this.
>
> On Mon Jul 8, 2024 at 2:59 PM UTC, Vitaly Kuznetsov wrote:
>> Nicolas Saenz Julienne <nsaenz@amazon.com> writes:
>>
>> > Prepare infrastructure to be able to return data through the XMM
>> > registers when Hyper-V hypercalls are issues in fast mode. The XMM
>> > registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL and
>> > restored on successful hypercall completion.
>> >
>> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>> >
>> > ---
>> >
>> > There was some discussion in the RFC about whether growing 'struct
>> > kvm_hyperv_exit' is ABI breakage. IMO it isn't:
>> > - There is padding in 'struct kvm_run' that ensures that a bigger
>> >   'struct kvm_hyperv_exit' doesn't alter the offsets within that struct.
>> > - Adding a new field at the bottom of the 'hcall' field within the
>> >   'struct kvm_hyperv_exit' should be fine as well, as it doesn't alter
>> >   the offsets within that struct either.
>> > - Ultimately, previous updates to 'struct kvm_hyperv_exit's hint that
>> >   its size isn't part of the uABI. It already grew when syndbg was
>> >   introduced.
>>
>> Yes but SYNDBG exit comes with KVM_EXIT_HYPERV_SYNDBG. While I don't see
>> any immediate issues with the current approach, we may want to introduce
>> something like KVM_EXIT_HYPERV_HCALL_XMM: the userspace must be prepared
>> to handle this new information anyway and it is better to make
>> unprepared userspace fail with 'unknown exit' then to mishandle a
>> hypercall by ignoring XMM portion of the data.
>
> OK, I'll go that way. Just wanted to get a better understanding of why
> you felt it was necessary.
>

(sorry for delayed reply, I was on vacation)

I don't think it's an absolute must but it appears as a cleaner approach
to me. 

Imagine there's some userspace which handles KVM_EXIT_HYPERV_HCALL today
and we want to add XMM handling there. How would we know if xmm portion
of the data is actually filled by KVM or not? With your patch, we can of
course check for HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE in
KVM_GET_SUPPORTED_HV_CPUID but this is not really straightforward, is
it? Checking the size is not good either. E.g. think about downstream
versions of KVM which may or may not have certain backports. In case we
(theoretically) do several additions to 'struct kvm_hyperv_exit', it
will quickly become a nightmare.

On the contrary, KVM_EXIT_HYPERV_HCALL_XMM (or just
KVM_EXIT_HYPERV_HCALL2) approach looks cleaner: once userspace sees it,
it knows that 'xmm' portion of the data can be relied upon.

-- 
Vitaly


