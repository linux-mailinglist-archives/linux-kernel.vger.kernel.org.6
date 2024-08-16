Return-Path: <linux-kernel+bounces-289762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC3954B65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3351F24934
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A811B9B27;
	Fri, 16 Aug 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iKDHoXK"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233AC1B583F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816323; cv=none; b=b6QMEjweh3hY79Sc3fNBU497fyK4ZZqJge39Gurc7Wpc00rt982K8aQqMBmDhEMZr+OYgggJmTB+YuEfesrzFB/vTxvSPanNoNqUVT/bP8KzVhZciJNAl6py7XkCrnMosKZHiqS3A4l6XxX2YON6STI18iMV97g13u/tkRTt8n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816323; c=relaxed/simple;
	bh=0vMnJeItITEKUhZ+4B6u6aLPzmgxLi8GhPQvynlgOeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o3vrSlvckwQTt7UNV+1o1PJwgw+dnef7Ao7RUWCjvOFR87HF/rQBShRdeFgr7u0nJOM8pvF8tKqG8j4WLE3mtft/pYRlwJC4X9SqX1MCF/ITISpIw+p/Zv0j7ARRqc/YprZgDwi9c9YxHwea/r2aqIbUZPiJ4jwDXyJ/1uWhD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iKDHoXK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d24aead3eso1724386b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723816321; x=1724421121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BIM/YN0EFHp0lGV/J6CAgo0gM9QaqgZeNQr3CGSECg=;
        b=4iKDHoXKZJ47WrKMiK0STaS6i/UpnXZN96uI1sbN0giA2KfJ7+DuVsQyuOpNLitKyb
         UqUrbzHqWDAaQbSA8mt+nnWu5/w78QrOn1wI7e0+wWQVX86EAuCJbD90sszD7Oc4m4Gv
         /7lOQLUYsl9JZoPSZKSxJqSkWYE9G/EObA0SSQjjxI/U9ehUrB1o+I4+6s3iLl6AVXVG
         dRynkg0S1x7j7rm3QQGkhJnxC4566EI+Y85YrhF6dCyc57qD6FEVX8ZfQpUv05syZzXn
         N2igHw9rhM6/5iZm7u7/VXTGfJYggZBkV7lVizeg6QcqsxzJtOpa5UW69VuYx+6XqcF5
         tdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816321; x=1724421121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BIM/YN0EFHp0lGV/J6CAgo0gM9QaqgZeNQr3CGSECg=;
        b=IRIyx4oHOqBHlSYM4AMuA3XY1P9NMUgDrHbQI2UkCcmLGErNbywTgoUR/2yy85K7Ri
         YPfCBi8lTdVjF32gyh0PXlGYuCt41aW9hW6gR/Qn8j2miGt5MIRIVgQ0g+UaRj0nPjXn
         96RcZBy6YTWa2Bj0sdqbs0sL2EnOGEYbuc4uK2GjRQZJmAICEcnpFZpDz9KYLnCK0gE6
         FTShApZJkV7zFhUqpOlpsTWBWqPyV2fIgT9YC8lL1slbDzTH5fwXmrNp2jkFn8IbnLQh
         w6bIvRMh2nljaEjVxdZIfdAOEdXKzYB867tx8CcbA6krh9MjSz9TGTvEmPqN+gB953bA
         y6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXytIOVFcGR/524rnZ8+6yoK+LYdcI6Djt+TlolAotCKetBN5EKrzVYkgHRTIk1nae1a5YGwmf3VbIOIvYbLZJsgaR22wNhMPURvxoc
X-Gm-Message-State: AOJu0YzDAcdTYA8pcJffV+XDc6qcU0jt/nChrg8LCqXZiMOBSGT3ojqJ
	KgvfcJbj5CkTx9/Bj1/RwcmLDKRjXSiETci2ui5U+knxGkmopaFNtC2ttwQui2zIHS3pXMWiyYF
	2GA==
X-Google-Smtp-Source: AGHT+IH8a8qcXJJW+Qp3bJP39BsD1Cyr84EbX9y+L3n28Q1J2pBP/8qUIq8u5YL+mnRxlhFVVdYB1lvysvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:aa1a:0:b0:70d:2547:44a with SMTP id
 d2e1a72fcca58-713c528e49cmr11004b3a.5.1723816321203; Fri, 16 Aug 2024
 06:52:01 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:52:00 -0700
In-Reply-To: <20240709143906.1040477-12-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-12-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9ZgDIhUEzUlOFa@google.com>
Subject: Re: [PATCH v4 11/11] KVM: X86: Use common code for PV IPIs in linux guest
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

"x86/kvm:" for the scope.  "KVM: x86:" is for host-side KVM, this is guest code.

On Tue, Jul 09, 2024, Jacob Pan wrote:
> The paravirtual APIC hooks in KVM, some of which are used for sending PV
> IPIs, can reuse common code for ICR preparation. This shared code also
> encompasses NMI-source reporting when in effect.

Please state what the patch actually does, not what it can do.  For folks that
aren't intimately familiar with FRED (read: me), that second sentence in particular
is wildly unhelpful.  I had to download yet another version of the FRED spec, and
decipher the poorly documented software-defined encoding scheme introduced by this
series just to understand what this patch does.

And the order of patches in this series is broken.  Overloading the vector *before*
switching the PV IPI code to __prepare_ICR() will result in KVM sending garbage
to the host.  I.e. _all_ IPI implementations need to be made safe before the NMI
source reporting code can be introduced.

> Originally-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4: Refine comments, no functional change.
> ---
>  arch/x86/kernel/kvm.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 263f8aed4e2c..a45d60aa0302 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -516,15 +516,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  
>  	local_irq_save(flags);
>  
> -	switch (vector) {
> -	default:
> -		icr = APIC_DM_FIXED | vector;
> -		break;
> -	case NMI_VECTOR:
> -		icr = APIC_DM_NMI;
> -		break;
> -	}
> -
> +	icr = __prepare_ICR(0, vector, 0);

Rather than force KVM to throw in junk dest+shorthand, what about adding a
__prepare_ICR_vector()?  Then KVM doesn't need to arbitrarily pass zeroes, and
even __prepare_ICR() itself benefits (IMO), e.g. this is nice and easy to read:

static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
					 unsigned int dest)
{
	return shortcut | dest | __prepare_ICR_vector(vector);
}

