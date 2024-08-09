Return-Path: <linux-kernel+bounces-281132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7B94D373
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B1B21157
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD53198A06;
	Fri,  9 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUyuLplN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B215B992
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217263; cv=none; b=tcx0WGJKC03nZyBfO9qCtMZYXhv9p6d0BQa1fOYKBgAmq7p+YuPqqLwHw4lYsWl1OCNOVwBxLzp20WHjg13HCz7jZGKH9duON8TZjKa+fugYqIoJhEAfVIwOvXY9NMkNvzXVyu3rvfFtkfA6lluVGF80xhNXMrs9S1EbxF8CrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217263; c=relaxed/simple;
	bh=1dRJw2SR9pICq5nkpp+vV41z3okTR0H8iAqVxW+NaXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTUUbRCLtZ52WxlpPDOBNZaS7bSoqbuzORfLTucYf+jHHK69gCw8Zd3acr7xwo8xpLLEMr6e24VEUVBPiJoWGTKriMyBDrQXdUU6yL3J3l8xb/ni/FErGUtjMGkAclPOIKfX06sBKZ8aw7WuYnYe1X+DUcOIdPmBEDd9h7/ZzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUyuLplN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb4bcdd996so2161805a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723217260; x=1723822060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Si/M4wEBBwQwe5aAxXryQvjtWUj1aZ9qsfUH9WvwCdM=;
        b=VUyuLplN0K4o4gZDmJ8lkXh/mw/TRaL68DDX+1BgHBxQXaV6BOv+2BR1gXLcRBqog4
         HzohN+XvF/6xCON24o8bDqrhVGo6gOpRXRSioqvmHNeamkk8JbKBR2itp8AiikEnn68C
         JKqiVnVxGpngnzIYpnk7VX8f1CtIORdy9HtZI84DZceLUFwKbXkoIKcJ/xndDViyPRfY
         +EIuCqSEMbTF+C2HE9As0k2YLujJX743tRIoJLL51gECH5zEn9ijosYNuidOYsW+OSjJ
         mjAJ+NsUQpKnOzBM+d4z2miv4Vf618rbpKTVi55I4Bs6A+ARH21HQ+glM7563ZVMq4wd
         bx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217260; x=1723822060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Si/M4wEBBwQwe5aAxXryQvjtWUj1aZ9qsfUH9WvwCdM=;
        b=GmeQMB+H5CMjn/Gn39K3m+bFoGqA8CLL6Rc78wqGKn/x9rr4TQZ42TU/3xO+fkXfFm
         49C/8gBdebOVnxEnmUKQbCV1QmoEha8oKr/4uqq21F8hPW2CPri80/OkI6Lke2HJIMfm
         ar5PZTEhIXhUBtw+PcJTmoM9hc3Pl4DEU+/tHewoXReOw5i22us03/iKcCS41iJgqE4d
         KeIaJarGSpaaQlPIAQJBIfEXovZGou1fu7t/XszzfKOcK0ok/3Lk+yT8TEN9+vyJrpxQ
         13qjf7yivoQopYytMgB8wZvXhfDnEt8celY00aCiwRS7XgI/e8X7JbSacMg8lYwHAQVE
         tB/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJZva6OVp/OHSw7VihZhw8npigMyrrPTZsVPEEvic2kdxHloH9tZK6oI9HFpN3caCt4d3YuAKUTDSUu76mauFseWAHD3GmBmqcpMbF
X-Gm-Message-State: AOJu0YwPAjRzCPG9sIqa1XCirwibBb9wxMjW9Go7iJx9phQX44sDX59u
	XQP/I8RLH0nL3pLS7TGC3FCALt2lqfnMZ/aO46jFVYTvQvHpH09TNrd8PqsM6oWsmSN7fghR68H
	A0A==
X-Google-Smtp-Source: AGHT+IFZRO85XufmZ9p0cZVTOEkoSaMkByAKFFn8ce30WRJ0Y9qb2XXBbleL3Ue9aS0eHoM5ytWJoeNDvgc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:68c4:b0:2ca:7f5a:db6c with SMTP id
 98e67ed59e1d1-2d1c4c45398mr40425a91.3.1723217259918; Fri, 09 Aug 2024
 08:27:39 -0700 (PDT)
Date: Fri, 9 Aug 2024 08:27:37 -0700
In-Reply-To: <ZrF55uIvX2rcHtSW@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725175232.337266-1-mlevitsk@redhat.com> <20240725175232.337266-3-mlevitsk@redhat.com>
 <ZrF55uIvX2rcHtSW@chao-email>
Message-ID: <ZrY1adEnEW2N-ijd@google.com>
Subject: Re: [PATCH v3 2/2] VMX: reset the segment cache after segment
 initialization in vmx_vcpu_reset
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 06, 2024, Chao Gao wrote:
> On Thu, Jul 25, 2024 at 01:52:32PM -0400, Maxim Levitsky wrote:
> >Fix this by moving the vmx_segment_cache_clear() call to be after the
> >segments are initialized.
> >
> >Note that this still doesn't fix the issue of kvm_arch_vcpu_in_kernel
> >getting stale data during the segment setup, and that issue will
> >be addressed later.
> >
> >Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Do you need a Fixes tag and/or Cc: stable?

Heh, it's an old one

  Fixes: 2fb92db1ec08 ("KVM: VMX: Cache vmcs segment fields")

> 
> >---
> > arch/x86/kvm/vmx/vmx.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> >index fa9f307d9b18..d43bb755e15c 100644
> >--- a/arch/x86/kvm/vmx/vmx.c
> >+++ b/arch/x86/kvm/vmx/vmx.c
> >@@ -4870,9 +4870,6 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > 	vmx->hv_deadline_tsc = -1;
> > 	kvm_set_cr8(vcpu, 0);
> > 
> >-	vmx_segment_cache_clear(vmx);
> >-	kvm_register_mark_available(vcpu, VCPU_EXREG_SEGMENTS);
> >-
> > 	seg_setup(VCPU_SREG_CS);
> > 	vmcs_write16(GUEST_CS_SELECTOR, 0xf000);
> > 	vmcs_writel(GUEST_CS_BASE, 0xffff0000ul);
> >@@ -4899,6 +4896,9 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> > 	vmcs_writel(GUEST_IDTR_BASE, 0);
> > 	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
> > 
> >+	vmx_segment_cache_clear(vmx);
> >+	kvm_register_mark_available(vcpu, VCPU_EXREG_SEGMENTS);
> 
> vmx_segment_cache_clear() is called in a few other sites. I think at least the
> call in __vmx_set_segment() should be fixed, because QEMU may read SS.AR right
> after a write to it. if the write was preempted after the cache was cleared but
> before the new value being written into VMCS, QEMU would find that SS.AR held a
> stale value.

Ya, I thought the plan was to go for a more complete fix[*]?  This change isn't
wrong, but it's obviously incomplete, and will be unnecessary if the preemption
issue is resolved.

[*] https://lore.kernel.org/all/f183d215c903d4d1e85bf89e9d8b57dd6ce5c175.camel@redhat.com

