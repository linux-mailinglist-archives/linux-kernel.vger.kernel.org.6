Return-Path: <linux-kernel+bounces-514150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA07A35327
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEBA16E7B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869345227;
	Fri, 14 Feb 2025 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iw7tTwYI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593A29A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493655; cv=none; b=UhV7xKqTkF5eak59JAY0cweEBu0+pVaOKsjmfHALTm519oKOhiOrFyFjFvYdWj95ayqkH2XgQIaNQPqO0B+cSCtr+NG121QyD8Oxe+p5iyyGwztVIW+rQPJizYPqhIk1Ic+XMlVMr7tOlbhKdVKgaQ2RrEfPBvikkksjAF2tFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493655; c=relaxed/simple;
	bh=oshhADdaU0DK/NrnmxgfGzcl8lJQMDH7dEKyxcJmwTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ql/+NPYBTtWpbLdnans1AefYp5DxV1lMjd6ZeK+ivNibW0TnuDbmk0Xk/orFDrJtjqo7QG3LSBMoQf5oyPTSP74Ou980wYj6VyFWVF4hO+a6wBLUcPWX0gOLi6CIlTKPAF1iLycftZE2Idx76B6Tb39HYMS1hYIxggIGebGex9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iw7tTwYI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f7519ae0cso30228265ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739493652; x=1740098452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x45uHW/9XYP5wRbdxJaBIYSa/pl3u4cjGPLtpEx1xbY=;
        b=iw7tTwYInCI9jERD64QFCM19YBnDMKKrVbrH4IK6J2/NmwloceLTqp/ProHOezpDds
         sboaSk0Hom3Vfzs2uEWq6jVFRVCe++sK41YeokOhHudzSA1y+3FMCGvqzfWgEE4uVWy/
         uE4wkAA5352VvZB5aQpUrRHLHrloRzGtzcg4elylIRDuxGWz0JfUGEFT8GAUE7KANH/R
         Mjab5Z8uL2t62V2kRtJ8p2pI9LKbx9jMdLTnzGGIqdKCkhdE8R73tm4L6cKNJ7Dev32E
         D51sawS7fkG/clcPRphHewgjrFmZLcP4bkL7T1FONAqTQuUWWQAlExPY0F57tkPmFR4w
         7GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739493652; x=1740098452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x45uHW/9XYP5wRbdxJaBIYSa/pl3u4cjGPLtpEx1xbY=;
        b=gjZyP21nmiJF3h2zIqBpaNWzXlPnh8hSQjcq7HA5uSI1euLLKeorF6kJppuGqPDgPB
         c/45uBFJkrxKLIpXLHvG3Q6eRlMZVVczWEEJBH0XU4LiUbsFmFHt9yc0IwP0rA12wkmH
         C+BSEV+SXSLCKYhYCH/A+CY5njbJAcTNWRSxyOy95+qDbx/kCh2lUeVI5oxVERft1HB6
         dOl9wEEAF5Tr6zjASzxbPdld4zST9xW8fYEy4YMFiP0e2/7Ra4aHUm+2pkGMDHpQww5e
         O1tCiRg0F1BGq7QPh6KGxzYTjkwrb9313qrb6vb9xfz5pbjzNb/E/5fQ/nYUl/xXKQQL
         4vrA==
X-Forwarded-Encrypted: i=1; AJvYcCVhG5qJne/ChOajxtvVAxrcIyvRz+l89HR7HTrVVO8+sNEQqPyoRmxIRgwYaZ9oTwTFl0FccqMWMdyoEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0N/fpTiJNO8DYoOdMc97OulIti7ab86761VnI6YgfIcc0XCV
	p2VoiJ24zOjrS+yHY3wIA1JvlM7yCtzc30O2YuTj+N8rQWGqellXUERq25NiBFM2Ap6Vpse4WnO
	mgg==
X-Google-Smtp-Source: AGHT+IEORtIoq0mZhJ9ZLmmQyLs5AIcdD1Z00r/nxGW72T49fVbNgVu/I9z5KFMgKaZoX1G1ZClI9WaO4yU=
X-Received: from pjbli9.prod.google.com ([2002:a17:90b:48c9:b0:2fc:11a0:c545])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d543:b0:216:501e:e314
 with SMTP id d9443c01a7336-220bbafa000mr149170335ad.20.1739493652206; Thu, 13
 Feb 2025 16:40:52 -0800 (PST)
Date: Thu, 13 Feb 2025 16:40:43 -0800
In-Reply-To: <CACZJ9cX2R_=qgvLdaqbB_DUJhv08c674b67Ln_Qb9yyVwgE16w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CACZJ9cX2R_=qgvLdaqbB_DUJhv08c674b67Ln_Qb9yyVwgE16w@mail.gmail.com>
Message-ID: <Z66RC673dzlq2YuA@google.com>
Subject: Re: [PATCH V2] KVM:x86:Fix an interrupt injection logic error during
 PIC interrupt simulation
From: Sean Christopherson <seanjc@google.com>
To: Liam Ni <zhiguangni01@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 30, 2024, Liam Ni wrote:
> The input parameter level to the pic_irq_request function indicates
> whether there are interrupts to be injected,
> a level value of 1 indicates that there are interrupts to be injected,
> and a level value of 0 indicates that there are no interrupts to be injected.
> And the value of level will be assigned to s->output,
> so we should set s->wakeup_needed to true when s->output is true.

Neither the shortlog nor the changelog actually explains the impact of the bug,
or even what's being fixed.  I rewrote it to this:

    KVM: x86: Wake vCPU for PIC interrupt injection iff a valid IRQ was found
    
    When updating the emulated PIC IRQ status, set "wakeup_needed" if and only
    if a new interrupt was found, i.e. if the incoming level is non-zero and
    an IRQ is being raised.  The bug is relatively benign, as KVM will signal
    a spurious wakeup, e.g. set KVM_REQ_EVENT and kick target vCPUs, but KVM
    will never actually inject a spurious IRQ as kvm_cpu_has_extint() cares
    only about the "output" field.

And that's of particular interest because this fix uncovered a latent bug in
nested VMX.  If an IRQ becomes pending while L2 is running, and the IRQ must be
injected (e.g. APICv is disabled), KVM fails to request KVM_REQ_EVENT and so
doesn't trigger an IRQ window.  But the spurious KVM_REQ_EVENT from
pic_irq_request() masks the bug (I didn't bother tracking down how pic_irq_request()
is getting invoked on nested VM-Exit).

I'm applying the patch in advance of the nVMX fix, because the PIC emulation goof
only helps with fully in-kernel IRQCHIP, i.e. if the PIC and I/O APIC are emulated
by KVM.  E.g. the vmx_apic_passthrough_tpr_threshold_test KVM-Unit-Test fails even
without this change if it's run with a split IRQCHIP.

That said, I'll ensure the nVMX fix lands upstream before this (I'm planning on
tagging it for stable and routing it into 6.14).

> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/kvm/i8259.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
> index 8dec646e764b..ec9d6ee7d33d 100644
> --- a/arch/x86/kvm/i8259.c
> +++ b/arch/x86/kvm/i8259.c
> @@ -567,7 +567,7 @@ static void pic_irq_request(struct kvm *kvm, int level)
>  {
>     struct kvm_pic *s = kvm->arch.vpic;
> 
> -   if (!s->output)
> +   if (!s->output && level)
>         s->wakeup_needed = true;
>     s->output = level;
>  }
> --
> 2.34.1

