Return-Path: <linux-kernel+bounces-389587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EB9B6EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028E01F219FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92221500A;
	Wed, 30 Oct 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DN1zi0nr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE82144DB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323317; cv=none; b=OwVWPgdCNbSjpDtO/ApLd6DAY/Bdt+iziRUvJrLbQVuniYFq2nDNRolMlPT0qKwgOwKsK6K6tNt6lHf/x8v8egkvCFFOwpsZ7d9U1B16if2T1VO1pLslKsW/QE9FhnmZPqPj/7SPhWts9otMTtMTTJ52APUXgrOOy4HajWPfHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323317; c=relaxed/simple;
	bh=MbbCCbjq5JrUGConaTKMydDsYPgTDYUDt9hl0GKh/J0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDkUV8ccYzIcz7uLp0I/ytiD6DC8MDY+meWZqwwt9pe7z/TD02T4NM6kITQoMQicsrd4ZrfOVU6l1FMVL0gsA4ZNnA77Ojhoyd1USfiS1raN2WMBw57QwS5dSIrikwrmuMSN4Ks1NzuoHEcawM4rsjXF8a3h3IaxPiaT6PaPdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DN1zi0nr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730323313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fImY0tgPhU7C7Gbsu2PvJitaPu6EoaPbjdriZ08AJg8=;
	b=DN1zi0nrYcA/nXT0JYO9AjrC2LsbAgi/NqY3cyrUZjAkKG9g0R6L60s2mgz2nKUtVlahot
	Wc0DM/tfVER6p37m8D4Ar5dlV8U6uI+yB9DENd5r3xyH7ONGZlxzqD4TLfx3Ue3Q1Tpn8+
	TjxPPOZ7sSDiuIKLKeStIc2HPhaK53g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-uCCV9T5jOvKfFVSqQxcj9w-1; Wed, 30 Oct 2024 17:21:51 -0400
X-MC-Unique: uCCV9T5jOvKfFVSqQxcj9w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe4a123fdso5431156d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323311; x=1730928111;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fImY0tgPhU7C7Gbsu2PvJitaPu6EoaPbjdriZ08AJg8=;
        b=cmdlPLtZAamcH7G88NAeTw8eXtpJSmWul5qetQXtyAo6wBGD770Q6v322L5PplKHs9
         VGdjd3b5stBzy9dT0pkzh45ZtytotM351NFu8qsGK4kohEkZYMSP+HFeWmXKuklQ+oaX
         Cc8azKO5ZDsUX14/uykMCMwP5AM8lTfjpqwci7I+CSNf4Ff6SeGI8inzfgeZPXnemcZW
         /PZlj8DJ/1RYHUoae8xZJmHRAwgMM5UHZIQ1I+tdh5QzhbrHyFQ/vXT4XzUWYBILNQdt
         6rYDNk1jTDr5FUpdkLg6k9vWt0GoD+uvG016Nj0j3jj1bFjN5jWjPHlpa9gn37rTZ/L2
         p3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtu4G7eoyt0rf0ipUnOPkA49DbTKR6tMY5dItrkm6rCG5Qa4FlrNAvbkYHMtcdDDCVq9EkZZPhtq+5Sng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnt6FimvUtDXVekbfzNCGCVYJ8gylGmVRLxHCaaybVOrl/3LT
	vR7JXMmTq3RqUSjg/y+E8RNZZp7ct9a3QOumKIwCn/UmPG8Z/VXcN0I0igUCEkVLwf6hpOwEfpH
	XmfNbnji5+V5D4d31mQ+/F+JWg3WiPArcT9atAL0kFx0Gh1BR9R84ejHRPKcCqg==
X-Received: by 2002:a05:6214:419a:b0:6cd:5ff4:cb1f with SMTP id 6a1803df08f44-6d351a92c11mr11401316d6.3.1730323311316;
        Wed, 30 Oct 2024 14:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr0fgtvMzz0D10iM8abFx6F7KGhICxqqQgW6cfSToB9LfZyBq1dF7BOnv89yuukqJXIUPsDQ==
X-Received: by 2002:a05:6214:419a:b0:6cd:5ff4:cb1f with SMTP id 6a1803df08f44-6d351a92c11mr11401186d6.3.1730323311045;
        Wed, 30 Oct 2024 14:21:51 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354189baasm486516d6.143.2024.10.30.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:21:50 -0700 (PDT)
Message-ID: <d59b923ebd369415056c80b99ca4e0f75d60fa84.camel@redhat.com>
Subject: Re: [PATCH v5 0/3] KVM: x86: tracepoint updates
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Paolo
 Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Sean
 Christopherson <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2024 17:21:49 -0400
In-Reply-To: <20240910200350.264245-1-mlevitsk@redhat.com>
References: <20240910200350.264245-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-10 at 16:03 -0400, Maxim Levitsky wrote:
> This patch series is intended to add some selected information
> to the kvm tracepoints to make it easier to gather insights about
> running nested guests.
> 
> This patch series was developed together with a new x86 performance analysis tool
> that I developed recently (https://gitlab.com/maximlevitsky/kvmon)
> which aims to be a better kvm_stat, and allows you at glance
> to see what is happening in a VM, including nesting.
> 
> V5: rebased on top of recent changes
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (3):
>   KVM: x86: add more information to the kvm_entry tracepoint
>   KVM: x86: add information about pending requests to kvm_exit
>     tracepoint
>   KVM: x86: add new nested vmexit tracepoints
> 
>  arch/x86/include/asm/kvm-x86-ops.h |   1 +
>  arch/x86/include/asm/kvm_host.h    |   5 +-
>  arch/x86/kvm/svm/nested.c          |  22 ++++++
>  arch/x86/kvm/svm/svm.c             |  17 +++++
>  arch/x86/kvm/trace.h               | 107 ++++++++++++++++++++++++++---
>  arch/x86/kvm/vmx/main.c            |   1 +
>  arch/x86/kvm/vmx/nested.c          |  27 ++++++++
>  arch/x86/kvm/vmx/vmx.c             |  11 +++
>  arch/x86/kvm/vmx/x86_ops.h         |   4 ++
>  arch/x86/kvm/x86.c                 |   3 +
>  10 files changed, 189 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.3
> 
> 

Hi,
A very gentle ping on this patch series.

Best regards,
	Maxim Levitsky


