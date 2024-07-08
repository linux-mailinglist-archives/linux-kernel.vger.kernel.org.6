Return-Path: <linux-kernel+bounces-244843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984F92AA38
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FC01C2082C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5E14D71D;
	Mon,  8 Jul 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUeH6fIJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29A1DDF4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468396; cv=none; b=gZYkKflVVUhhepCO7HZzFU8Fy/qOAiV7iIynv0bqjojtole6fs7StsETnRyBXNXBcbi+1sWxOJYOuJqQP28UemNKRn+t3xxbRp9XAfLX0/iPXyLH6WsiClP/RMbYWNrjDRVr7cofCcODJ9LWGylju3Rj2cc0Rh5YMu2NQJvj7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468396; c=relaxed/simple;
	bh=UdPcTFdnPq5cUnmAcqLzeBtibr0PYL1r3/INnsLwMlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K4+SHDvBSfqeJQPPQi40jG6iJgqw+V8QyP6x5fu0zsg5PPJnkAenIpuFPMSVA/YWZhnbNfWgGIQOIAOIS3HRVhy/mBtOGQMgT00w4VQ5u1j5U+yAOHPxsF7ikb9YuTI+utFocUP0ao3n3Bv1h4/mqUnunouLXuOEqJ8A8++5ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUeH6fIJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650fccfd373so65800767b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720468394; x=1721073194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FVs20HAAeRIAgt4d10eMOBo4cisazmWq/dVb1Yk1U4=;
        b=uUeH6fIJngjqGCW9QU0AxIPfzPc/9Au6nbFfOTZbM+YKbZ4cRZ8dyELleZmNV718Fg
         cmdrg1yByPlOfIRzknT3gcP29gXAxfoR3HtFpQNoi07wO0SQgpXy224G/1zujnfXP6oD
         NnMifbUSH6cVrDKx5M0TswOvqZzSfyOQuC4PUwXAQfGQvfH8L1fEmDVpGJvQ5wDKFudO
         qFMCca7cSpol0FoLBl0TEdy1/ZlGxt266N3qC5/I9PVFd6Plo6LnqArBwCrDncULY+/z
         l5ktWI2jk4yQKNSlEbBIqT86px4CPihBZSYfUCRSgxstbbre69/dyTOmbNsBXvC75Lx4
         AiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468394; x=1721073194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FVs20HAAeRIAgt4d10eMOBo4cisazmWq/dVb1Yk1U4=;
        b=WZjRslTF1KWM7uWNvYHFqKz6ZSv29JKTnlZgSuJnR+KUFKDAlsiU9aAfj3Q6XPSPji
         8MEMx5luR+kDfVIVmlRqwCZVQtP5ZE1WNVfqVBg2KZcaRxAQjEJhC+WBQ+fIe7I+VsXU
         P9SkSpyWDIbQygDykGGVFHcZW7KXKxRIXQ2sGZW7XCy0ywXW73ljt7BW/9XPjaFT5it4
         /tSGbBKuoHLJsKB9sfVQK+ZkXILrPZ2J5nP24FRV6MAoHPSQ1zMlHePCdyQ1dj8ImT8W
         soZfdecaCIWzZwJf4T15aw+K3JkPWJ/D23/97i0FbgrpuBbIM+qMt9V0I3K52ci01SoQ
         +g/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlsD4Hx3xGRp+ZbGJy4i/zt/JS+uML9hs8IvczS0Xoo8Ik7wkshPFAYXHynUNYhaNRAbnQMoLdsoeUEJdIC6dJI5TQWSoAJZ4LCwGs
X-Gm-Message-State: AOJu0YzJpZ9P2tq2hNyxGtrfhlCUafjiPcrP3aO1XC5Xf+TSI9XwxFj6
	pXd64KfH4VXUXJ7PubDC+ftt4wc1BGGSvICFQJhovBRDqOzr4sC/uDJ8x3FW6BVI6lSI2L6zlqs
	SvA==
X-Google-Smtp-Source: AGHT+IEOjBhmlwVDMl817R9D6Dee9vc0jmEIVO0vwMnwyKkKcmbKJczlN1dp/+HYO/6oIysM+bVAwUK5Mqw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:338b:b0:62f:a56a:cee8 with SMTP id
 00721157ae682-658eeb6cf32mr117137b3.3.1720468394227; Mon, 08 Jul 2024
 12:53:14 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:53:12 -0700
In-Reply-To: <ccbed564392478b3a5bb51b650a102ca474ba7e0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-11-seanjc@google.com>
 <ccbed564392478b3a5bb51b650a102ca474ba7e0.camel@redhat.com>
Message-ID: <ZoxDqKdh37qpm-HQ@google.com>
Subject: Re: [PATCH v2 10/49] KVM: x86: Drop now-redundant MAXPHYADDR and GPA
 rsvd bits from vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > Drop the manual initialization of maxphyaddr and reserved_gpa_bits during
> > vCPU creation now that kvm_arch_vcpu_create() unconditionally invokes
> > kvm_vcpu_after_set_cpuid(), which handles all such CPUID caching.
> > 
> > None of the helpers between the existing code in kvm_arch_vcpu_create()
> > and the call to kvm_vcpu_after_set_cpuid() consume maxphyaddr or
> > reserved_gpa_bits (though auditing vmx_vcpu_create() and svm_vcpu_create()
> > isn't exactly easy).  And even if that weren't the case, KVM _must_
> > refresh any affected state during kvm_vcpu_after_set_cpuid(), e.g. to
> > correctly handle KVM_SET_CPUID2.  In other words, this can't introduce a
> > new bug, only expose an existing bug (of which there don't appear to be
> > any).
> 
> 
> IMHO the change is not as bulletproof as claimed:
> 
> If some code does access the uninitialized state (e.g vcpu->arch.maxphyaddr
> which will be zero, I assume), in between these calls, then even though later
> the correct CPUID will be set and should override the incorrect state set
> earlier, the problem *is* that the mentioned code will have to deal with non
> architecturally possible value (e.g maxphyaddr == 0) which might cause a bug
> in it.
>
> Of course such code currently doesn't exist, so it works but it can fail in
> the future.

Similar to not consuming a null cpuid_entries, any such future bug should never
escape developer testing since this is a very fixed sequence.  And practically
speaking, completely closing these holes isn't feasible because it's impossible
to initialize everything simultaneously, i.e. some amount of code will always
need to execute with zero-initialized vCPU state.

> How about we move the call to kvm_vcpu_after_set_cpuid upward?

A drop-in replacement was my preference too, but it doesn't work.  :-/
kvm_vcpu_after_set_cpuid() needs to be called after vcpu_load(), e.g. VMX's
hook will do VMWRITE.


