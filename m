Return-Path: <linux-kernel+bounces-274997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63416947F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1991F1F2311D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1215C14C;
	Mon,  5 Aug 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qY6MB4L5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04C1547E7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875173; cv=none; b=JYTq06I0DkyaxxhfXMXyUWKEoeMBfG8KN/UQKYzWX+bQB4q7TI2qVNozZbHvlW9zzB7DrMsV5A1hyPMfLJvR9bc1uyAEZadSElMOIf+Oa8F7tG88JLBWXZExzGO2DKCGo9zmTD49S2aw2fqgzAgGF9Cpa39PBV22AN4S27VBv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875173; c=relaxed/simple;
	bh=V7wy/IY78ADKe6MCQ9wGcOxH7LMu1vqwY8ggZZNETsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBXa4kXHbzsx2xVXp6fJ5p4d8sqHNF+UD36V/aLSw8xxzOxHTLUYeXv/jqmIISAlREFrV2feGFtHsHS3pRVjSFcgnsp8YpPrdkbC1juZThSa2rl27gBGuiSejgN20AjfEEpr1oPwmUPYJsBXkFlKklDXykFLoz4vv35Q/Aesyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qY6MB4L5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a30753fe30so8264936a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722875171; x=1723479971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LTrtRaPSzzv6povC2MZbVu/ikbGDz5GKGualsN8e2oo=;
        b=qY6MB4L5Lwi31rkl+bvZzaYqBl+XPnHuBcWu5CE/d5szt00UxkuBzG5B57wDEWIu3t
         LKHInBSXlHPHHBGu/pjLj7TcU7pxyqA6+Yzvt0ZyRdzli5o134jHG00eYiuRTbrS/egD
         ej9nZUtxAEv0zwPXH5nABT6eC99x2dTFkIiLfG7AS3OLOnEOzrFK/fVgbtmKve8jKmfJ
         rI68daVLPCdmtx84mBWJiXYGbImLInBKB+wf6zAfcEvuW+pykNoqAcq0TMX/ACvSEi9H
         zZxJHYXJFf3BUAz0PLu/u3WtF46zY63dmR/mU5+As4zbGHyIQ8PMHJYlsS5HT30kDbAj
         L5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875171; x=1723479971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTrtRaPSzzv6povC2MZbVu/ikbGDz5GKGualsN8e2oo=;
        b=J0XTjZMjbYrpxC4uMxLsLflOYeonzViqDehX4VIGRKapbUmJPNgZBcIPcOfQvmInoD
         dyL96lbRyOPHYN5kxy3Ey8PoeXfD55dX000sCST9g8nPSL/VwraUFVyVVC2qO6d25Eda
         MQvSlv9udnwJmmGZqe3RAOtcXSoPtb1vXv0p7WynEMnu+kqyp9clATQhsEfk7oereEeC
         0A7dW/w4Fx1IAit50BptHQlcQYB9Pf9VODNjcutAc7YjaKQFKI08fzQrWV+FEmPt4xp3
         eMH6JS4ghXTnbpi4Usp6kEh8Wmfeei4r3N5tZleihOzpBnlZ+yBxhI6GVNGzmj2WWvdU
         5ctw==
X-Forwarded-Encrypted: i=1; AJvYcCWauIaYFS7tFfONlE8Q5P/hb5kruW8HQXuh27gDz1vIXI3jHwYOlvWHZjxC1g2f1GLLvr46swynmcZqwA70TJLiLLYZ68A6OFe6uaaI
X-Gm-Message-State: AOJu0YxXT/v+HIe0PlAy4jTkNvNZFYqSTkdFTARX9MMSf1YagV0P0p1k
	/P3ZNE4sd4H+58/JCaPYFcOUlOB7Eo9UgnyJUIivH7kTy3nYnHw1NsRhNWNRT70VmqBGb2QbynE
	YMA==
X-Google-Smtp-Source: AGHT+IEw6cjRWnePzyF97nk0/YCd4IV9HttqCP5c4LXLKTNvkvgZNp5EEi3fIHSWkDuAjgZYuZu0HrMv3+A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:3f41:0:b0:7a1:2fb5:3ff7 with SMTP id
 41be03b00d2f7-7b7438b1dc8mr27331a12.0.1722875171415; Mon, 05 Aug 2024
 09:26:11 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:26:04 -0700
In-Reply-To: <eaa907ef-6839-48c6-bfb7-0e6ba2706c52@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802202941.344889-1-seanjc@google.com> <20240802202941.344889-2-seanjc@google.com>
 <eaa907ef-6839-48c6-bfb7-0e6ba2706c52@rbox.co>
Message-ID: <ZrD9HHaMBqNGEaaW@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Make x2APIC ID 100% readonly
From: Sean Christopherson <seanjc@google.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Haoyu Wu <haoyuwu254@gmail.com>, 
	syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Aug 04, 2024, Michal Luczaj wrote:
> On 8/2/24 22:29, Sean Christopherson wrote:
> > [...]
> > Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
> > calculation, which expects the LDR to align with the x2APIC ID.
> > 
> >   WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >   CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
> >   RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >   Call Trace:
> >    <TASK>
> >    kvm_apic_set_state+0x1cf/0x5b0 [kvm]
> >    kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
> >    kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
> >    __x64_sys_ioctl+0xb8/0xf0
> >    do_syscall_64+0x56/0x80
> >    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >   RIP: 0033:0x7fade8b9dd6f
> 
> Isn't this WARN_ON_ONCE() inherently racy, though? With your patch applied,
> it can still be hit by juggling the APIC modes.

Doh, right, the logic is unfortunately cross-vCPU.  The sanity check could be
conditioned on the APIC belonging to the running/loaded vCPU, but I'm leaning
towards deleting it entirely.  Though it did detect the KVM_SET_LAPIC backdoor...

Anyone have a preference, or better idea?

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a7172ba59ad2..67a0c116ebc0 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -352,7 +352,8 @@ static void kvm_recalculate_logical_map(struct kvm_apic_map *new,
         * additional work is required.
         */
        if (apic_x2apic_mode(apic)) {
-               WARN_ON_ONCE(ldr != kvm_apic_calc_x2apic_ldr(kvm_x2apic_id(apic)));
+               WARN_ON_ONCE(ldr != kvm_apic_calc_x2apic_ldr(kvm_x2apic_id(apic)) &&
+                            vcpu == kvm_get_running_vcpu());
                return;
        }
 


