Return-Path: <linux-kernel+bounces-316155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F096CBDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D89A28BABF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BA747F;
	Thu,  5 Sep 2024 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lh835aTQ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5F4C8E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496661; cv=none; b=jGe1bjbDCSBaakUc7T0z9onluK41JO4M4cOf5pdtggLCP8oh+BjZ69wuK6VM77JrtDSyxQi9eDx8DPqrNnE72/JwfjuJRomX5VnFcjEPalSmXhHruJkcw2vkGNj1EJ88kvgZAr9nueN8DW3B6kZHFR04H0fsjGDN3G2ZAajGaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496661; c=relaxed/simple;
	bh=1mR/XizSAffZYNSQEEdkk+e/3GZP2oBbIepU2NDLsOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMHvWPSEIigxrsYed/9RCpNK3h/fVHJbJjbeTX3Jb1lQB9moMZZ6Vtur3F3LzTt+Xd2fWX7dzqXIls9Kg0RXiXdrRZTn2x5yb1ENmWK9OeaT4hBJ6mO5fx+2T5kwqugjYRVlWwTaY4YC9qnNzf906RMdeMnFGCRE3RChfpAg26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lh835aTQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e165fc5d94fso576276276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496658; x=1726101458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rITaPZ6UiIfPp2fHeRO7mrGcOK1zaJwQGYZJffIWCQM=;
        b=lh835aTQLVYnfooRvnZGnhUBQOwedxO3yPMBfuIksJsxdFjlEsrFi+3TL2F8etkHWP
         sekHPQ1UWJl5ZgSCFyKUFTvrazchEb/myRUVq/AlwNMSOWzTqMOwuTFREnonElQO9CIT
         nk5H9wqXGCzawS+3wUHxPZBejBdWPHe1fWEtIiq2G6l8DYRxACzLbacFoxXBrV5Lcd6E
         kZxe7AHrvg7ZiTItiXNrEIsddFHSRypaMN/b/eHypj819TW8ZfxAVZaArWx7l2F6tjsW
         m46X+v9WwrPgvYHjhqs7yJ8WTUuxhriSbPaFgzOt9YwvTdn5wK2ieC494tArcXzVIpyD
         oeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496658; x=1726101458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rITaPZ6UiIfPp2fHeRO7mrGcOK1zaJwQGYZJffIWCQM=;
        b=vUjBrXU7uWKDa9BonLx1Qd5sww08Vl9E4tn2oSVQWr+Lu2m4b6O3WOPNws153fqQC7
         IADMyeki9z6nISU6jjcIBxfAf3EroVMqQXWhQFXTP66MXNndtMCaQImFdN+oq0DZr2N6
         Zzjv66tGCwku/SZ02O1WVB+Jo6ftiwu0KlLvibljJHcUJAEnzwwXzyJqcUXsvGOgCbtJ
         HG1u2bknSNwdiJIJPZBIqWvG+7EaFKDTcaCbW45bY7AXd0vxXACYineeeNmdzyqGusZK
         9Xs71kp6uUbnJ18ykqwxyX6zMVUngBKa7Z0j8PdYRd7wtxdKgSKRioigVKM3J+GmCVCf
         yaAw==
X-Forwarded-Encrypted: i=1; AJvYcCX+BmBXyJ3c6II81CPE6GGxHnESOhItIxRy6+xn0YlWlXn6F7LmcC3cYtYx+L9icjAMJ99fKYG0CJXRl/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7OoERBlYxXvSLlmTX1kdk1cHVQ+viLNQH5O38xqkMUyolrnQ
	3jUO3fcNX4YjdGPZiXXaG53l6FDJGkJqXgDPAITsE040g1vt1EbCK/dee0798lkssst67OFnT6t
	7YA==
X-Google-Smtp-Source: AGHT+IHZC2XEUb4ioXVclZSCIgL52vTvgN4+uCKL3WqleD2oGabBDGzuOf4WyNZ3NKKyBu2IMNs8Km12CZs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:8:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e1a79fdbf1cmr88878276.2.1725496658533; Wed, 04 Sep 2024 17:37:38
 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:37:37 -0700
In-Reply-To: <Ztjj8xrWMzzrlbtM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com> <20240720000138.3027780-2-seanjc@google.com>
 <20240904210830.GA1229985@thelio-3990X> <Ztjj8xrWMzzrlbtM@google.com>
Message-ID: <Ztj9UWc_K5qRTiUy@google.com>
Subject: Re: [PATCH 1/6] KVM: nVMX: Get to-be-acknowledge IRQ for nested
 VM-Exit at injection site
From: Sean Christopherson <seanjc@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 04, 2024, Sean Christopherson wrote:
> On Wed, Sep 04, 2024, Nathan Chancellor wrote:
> > I bisected (log below) an issue with starting a nested guest that
> > appears on two of my newer Intel test machines (but not a somewhat old
> > laptop) when this change as commit 6f373f4d941b ("KVM: nVMX: Get
> > to-be-acknowledge IRQ for nested VM-Exit at injection site") in -next is
> > present in the host kernel.
> > 
> > I start a virtual machine with a full distribution using QEMU then start
> > a nested virtual machine using QEMU with the same kernel and a much
> > simpler Buildroot initrd, just to test the ability to run a nested
> > guest. After this change, starting a nested guest results in no output
> > from the nested guest and eventually the first guest restarts, sometimes
> > printing a lockup message that appears to be caused from qemu-system-x86
> 
> *sigh*
> 
> It's not you, it's me.
> 
> I just bisected hangs in my nested setup to this same commit.  Apparently, I
> completely and utterly failed at testing.
> 
> There isn't that much going on here, so knock wood, getting a root cause shouldn't
> be terribly difficult.

Well fudge.  My attempt to avoid splitting kvm_get_apic_interrupt() and exposing
more lapic.c internals to nested VMX failed spectaculary.

Hiding down in apic_set_isr() is a call to hwapic_isr_update(), which updates
vmcs.GUEST_INTERRUPT_STATUS.SVI to mirror the highest vector in the virtual APIC's
ISR.  On a nested VM-Exit due to a IRQ, that update is supposed to hit vmcs01.
By moving the call to kvm_get_apic_interrupt() out of nested_vmx_vmexit(), that
update hits vmcs02 instead, and things go downhill from there.

The obvious/easy solution is to split kvm_get_apic_interrupt() so that nVMX can
find an interrupt, emulate nested VM-Exit or posted interrupt processing as
appropriate, and _then_ ACK the IRQ (if a VM-Exit was synthesized).  It's not
really any harder than what I did here, as above I just didn't want to split
kvm_get_apic_interrupt().  But I don't see any sane alternative, and in the end
it's not any worse than plumbing the notification vector into kvm_get_apic_interrupt();
either way, we're bleeding implementation details between common x86 code and
nVMX.

Luckily, this series is sitting at the top of `kvm-x86 vmx` (yay, topic branches!),
so I'll just drop the entire series and post a full v2.  Unless I botched this
new version too (haven't tested yet), I should get v2 posted tomorrow.

Sorry for pushing garbage, this should never have been posted, let alone gotten
applied to -next.

