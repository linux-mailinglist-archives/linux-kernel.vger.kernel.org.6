Return-Path: <linux-kernel+bounces-449594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3FD9F5131
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDB8188B8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7881F76B2;
	Tue, 17 Dec 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GX6MEvbG"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952B1D2B11
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453452; cv=none; b=EqhKlpX01nel0AxiIVfcJg1MdOotk9pvlr1x5zfSUOORandGtMp0aUQceVesLU6t3oh0VmrmWwJqYHhujhZKuBkozRxWIRpmdFniBQ+iivjQcgi9t+okA6p0iqzCmzhZPXLKKW4s5jwOM8xSC239qn7Qg4JqlleFcKDQyQbjd1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453452; c=relaxed/simple;
	bh=UuYiacWN8QtSH2mHpM4MWlPeJcUuwSFGyIDCNPehCvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emy45XXJWEAjDwaAVkti/3jXLizE/QxxK8/reKt3n2XfMbWKqbSnH74DU7LyA1YG5jCFSOJWsA0sB9CyfOGwvGqSg7l0SDhtUPxGH/+s7aZjrpYw824DhSG6iA9kQCUJCJykEotz9rKUXaVkr93KGmT5FA3d2HzJbJgGAKoxFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GX6MEvbG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725cf06e7bcso4496368b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734453449; x=1735058249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4IhyAvHWEe5O+zBPe0HfvbrDbaLgZG1B8nm74g09/s=;
        b=GX6MEvbGBbD+CpnVoBPyDU/AUhQ7wXD975HaseT1Ex1jCcNJw8YfYBK2l2UxzN1gIm
         yamF0OQZLAu4ELjl1SCqSPzC8qJz6HSBtJUv/E9tUw+81jv4AMKKa1WdcurxTq4eRSC8
         8ilPlNsTPivupIPImdXRdi0mF/xHhtt5eOMDhJ89fGrwRBS66ZUAQ6AwqzXECW//PNaJ
         k03jAKmOOZXc3S3uqLLBp5sgvYP3j5XI8ShtLCP7fg9OgapmfDIibwTasdiFYpEeB4nW
         nPlqv+/wJ8XjoEcYVsUtrXYcQoSim+RtkP+iSiLoypOx4JWnuf5Y/6iEePa3hVqGxIiw
         tnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453449; x=1735058249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4IhyAvHWEe5O+zBPe0HfvbrDbaLgZG1B8nm74g09/s=;
        b=epkoKGeKEtX7MTS6542spCloCr0TAiz0p8YXgVDa53jqqDJptI500b6bIE/9TzuOkb
         i9J+zQfLhDyAR/Hu3S/+n0SEdzOo3WOzxydcXp910DB2PbW7Sc1uVnsJfIOFzM7BR90/
         s7KeSinA8J7Xry/m9BxC+YWgiXQPWuN0F2Qnu8csCq3AyrPjH2WFGoETWhv+lV6K4Db5
         qmaSazrlKmdJKyEnXqk4O4H7lXcsv2LskqfxPXSuNpFepifELzmxVVZRZi3QYLrjC04w
         W4FGo/htbCeGPqkqyBkAAnrZNDnbC5stWK8m0AUhrFKAoGJxErh9PtJDlZtsnw5K9OpD
         +Eiw==
X-Gm-Message-State: AOJu0Yx5ib0dnjNKIIMHfJi/SSTlWunPeClsw6ygcDhFLJs6oIwbqqE4
	QljVHpzm20tYXvet0Ag9Emy8EL0x5sQxE5zTFLMdTV/Vnngb665xZkj1D98RjUB8rHOEWTo5E5u
	PYw==
X-Google-Smtp-Source: AGHT+IGnb9feLUAB3OXuRmA4cViAW6/F1SMRVtzhgVWff0yyTvkDJc9grD77balzYK7Z4lA0mycYKnF2iq0=
X-Received: from pfne23.prod.google.com ([2002:aa7:8257:0:b0:725:c72a:a28a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d0c:b0:725:c8ea:b30b
 with SMTP id d2e1a72fcca58-7290c19d89emr23911823b3a.11.1734453449438; Tue, 17
 Dec 2024 08:37:29 -0800 (PST)
Date: Tue, 17 Dec 2024 08:37:27 -0800
In-Reply-To: <20241217070539.2433-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217070539.2433-2-wsa+renesas@sang-engineering.com>
Message-ID: <Z2Goxx27WL-G-13y@google.com>
Subject: Re: [PATCH] KVM: VMX: don't include '<linux/find.h>' directly
From: Sean Christopherson <seanjc@google.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="us-ascii"

+Yury and Rasmus

On Tue, Dec 17, 2024, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,

I definitely don't object to the KVM change, but the if y'all expect developers
to actually honor the "rule", it needs to have teeth.  As evidenced by a similar
rule in arch/x86/include/asm/bitops.h that also gets ignored, an #error that's
buried under an include guard and triggers on a macro that's never #undef'd is
quite useless.

  $ git grep "include <asm/bitops.h>"
  arch/x86/include/asm/spinlock.h:#include <asm/bitops.h>
  arch/x86/kernel/unwind_frame.c:#include <asm/bitops.h>
  arch/x86/kernel/unwind_guess.c:#include <asm/bitops.h>
  include/linux/bitops.h:#include <asm/bitops.h>
  include/linux/count_zeros.h:#include <asm/bitops.h>
  net/core/net-traces.c:#include <asm/bitops.h>

E.g.

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 262b6596eca5..381ca834985d 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -8,7 +8,11 @@
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/errno.h>
+
+#define __LINUX_BITMAP_INCLUDE_FIND_H
 #include <linux/find.h>
+#undef  __LINUX_BITMAP_INCLUDE_FIND_H
+
 #include <linux/limits.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/include/linux/find.h b/include/linux/find.h
index 68685714bc18..d9494ff3126b 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -1,11 +1,11 @@
+#ifndef __LINUX_BITMAP_INCLUDE_FIND_H
+#error Please do not include <linux/find.h> directly, include <linux/bitmap.h> instead.
+#endif
+
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_FIND_H_
 #define __LINUX_FIND_H_
 
-#ifndef __LINUX_BITMAP_H
-#error only <linux/bitmap.h> can be included directly
-#endif
-
 #include <linux/bitops.h>
 
 unsigned long _find_next_bit(const unsigned long *addr1, unsigned long nbits,

> only via '<linux/bitmap.h>'. Replace the include accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/x86/kvm/vmx/posted_intr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
> index 1715d2ab07be..ad9116a99bcc 100644
> --- a/arch/x86/kvm/vmx/posted_intr.h
> +++ b/arch/x86/kvm/vmx/posted_intr.h
> @@ -2,7 +2,7 @@
>  #ifndef __KVM_X86_VMX_POSTED_INTR_H
>  #define __KVM_X86_VMX_POSTED_INTR_H
>  
> -#include <linux/find.h>
> +#include <linux/bitmap.h>
>  #include <asm/posted_intr.h>
>  
>  void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
> -- 
> 2.45.2
> 

