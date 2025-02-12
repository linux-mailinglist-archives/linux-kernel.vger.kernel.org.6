Return-Path: <linux-kernel+bounces-511517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395EA32C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114F4160F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83CD24CEDA;
	Wed, 12 Feb 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGI+gaHL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D711D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378552; cv=none; b=af1UQvCFbJM/K/ujHqLNQfrDl2NXyYPAAFpkZBUamESiOmllTleK4+U1Xvd64XaaVnfUVvcG+8h4DIPE98NsQNxcjrVzX5egllipo+jcYntmpQNuvOErGuDQqyG6NB21N87ZoNr0DHFiM1Mc+PXzZAXP3YEflT1etd1Gtl6rju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378552; c=relaxed/simple;
	bh=WQASWieCbIE6kwwSdS9ZC9zn2GZnhcsp9HBAsuV4sJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O/DCDngnqYo6TWnfbsJJRgng8pprjS2vziiiFXYKjGUuurBl+wN/r2Iwdhxs1Y/fzg46hyMvtL0plM1Jq+KtADdJ2CFinPTfqkmRok2fJqKkTV1F3uLrr99Hoz2cC+qhARU7WBMo6uX4SE5JUptvksxpl4bdWpXtU0zsszMIEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGI+gaHL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f49f0bd8fso100706375ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739378550; x=1739983350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QKEnFcrp5IUoXHy+dx+avwVDPBfLMBRhwLtF3yGOSI=;
        b=IGI+gaHL5Qp/IBmsq9Ps7GClO3CPpvFKdmlAfaoa2QkPDS5IFaOsbPpd5WX0n5h2x1
         3lVjUKj5Wy5ekzDIQsQbIyjTg4lLT4b1EBjV+j5Qvjni/57VEGrzYcXSRhleGn7ErYE9
         eRgh1iZof10Zy4zODAwvvu9246y3S6Q2Wy+7anZ90MN/gbCS+i10YF8ec9MxOWwdSoBT
         SbxzlZ+qOPIa3daGbeuVs/eaGM88v2Y3GIGh7kvCEzjsR3l4Iq7pCos6YkeZ84lqTLaN
         r2sTpB9UwDItNSnGs1uS8XLItNR/ljsnvU6HgCjnf4IorOmSMDYxfc7sz1AX7p8CsTyk
         /rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378550; x=1739983350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QKEnFcrp5IUoXHy+dx+avwVDPBfLMBRhwLtF3yGOSI=;
        b=eamNGRXSXjMvyaD7B7vCiqVFKpLIxSsC5gQXDCv6hAvsAqvjxzauAS3LTRWKAU0r/C
         yUmj3XNi46Y2Yczk452ehCvJpDWSjuObfSzwY0wp/lqthB0avTPsexMLN1MZ4JcAJDKV
         jqGfsshPFl3Y/L7Xyai9P0BB5ih5hJFJV13XMDNq8DYdzE6zGjP0M5f7st+nykfGmytc
         h0Omm1XbUAM5CcexxQ6TI1pLY6esrL0M0Y+XU7N2/i4DspDcRq3LpgnCGxvSQtrXIRQr
         4QKOekNpv6rllAEi88Lw/PBOaaOd6t7Y2kI8Vrs5zntVbYUxJbT4WaSKSCespzSVzaUt
         RZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlzrc9ADwWGYU7sPU+ND8eC+9GZ5K1Ha5megkG8oadEnBm27TgTe2ITdwJk9VfF1zJZ9dplIo12yFGJM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44krX/kwgz67285WTfmTJRFWkZ5bqdz3nqQOPlUNK8ZBVKC2+
	Qy/tFOOJA1bOl/OQ6yP45TAlrnIQMwYsCByOx05WgHnEz8K3jyupbjW/BRz+ajjD1ZBzv3Z3y8k
	Z/w==
X-Google-Smtp-Source: AGHT+IG+lXQ0YpWw0NrxbRll2Xo/KW84TuAuafJJBR5ybt9KbK4odBl2EB09na3g10ZEUP1QsZknCFrPXGY=
X-Received: from pfaz1.prod.google.com ([2002:aa7:91c1:0:b0:730:8518:b97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:68c:b0:1e1:b727:1801
 with SMTP id adf61e73a8af0-1ee6b399d5emr279472637.27.1739378550087; Wed, 12
 Feb 2025 08:42:30 -0800 (PST)
Date: Wed, 12 Feb 2025 08:42:28 -0800
In-Reply-To: <20250113200150.487409-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250113200150.487409-1-jmattson@google.com> <20250113200150.487409-2-jmattson@google.com>
Message-ID: <Z6zPdN3vCWmm2Irs@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Introduce kvm_set_mp_state()
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Gleb Natapov <gleb@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, 
	Suzuki Poulose <suzuki@in.ibm.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 13, 2025, Jim Mattson wrote:
> @@ -11288,7 +11287,7 @@ static int __kvm_emulate_halt(struct kvm_vcpu *vcpu, int state, int reason)
>  		if (kvm_vcpu_has_events(vcpu))
>  			vcpu->arch.pv.pv_unhalted = false;
>  		else
> -			vcpu->arch.mp_state = state;
> +			kvm_set_mp_state(vcpu, state);

It wouldn't be appropriate in this patch, but I think it makes sense to invoke
kvm_set_mp_state() instead of open coding the pv.pv_unhalted change.  E.g. if
the vCPU is somehow not already RUNNABLE (which is a bug?), then depending on
when pv_unhalted is set, KVM could either leave the vCPU in the non-RUNNABLE
state (set before __kvm_emulate_halt()), or transition the vCPU to HALTED and
then RUNNABLE (pv_unhalted set after the kvm_vcpu_has_events() check).

Untested, but this?  I'll test and post a patch (assuming it works).

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0aca2a5dac7e..c51499c66cfa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11292,9 +11292,8 @@ static int __kvm_emulate_halt(struct kvm_vcpu *vcpu, int state, int reason)
        ++vcpu->stat.halt_exits;
        if (lapic_in_kernel(vcpu)) {
                if (kvm_vcpu_has_events(vcpu))
-                       vcpu->arch.pv.pv_unhalted = false;
-               else
-                       kvm_set_mp_state(vcpu, state);
+                       state = KVM_MP_STATE_RUNNABLE;
+               kvm_set_mp_state(vcpu, state);
                return 1;
        } else {
                vcpu->run->exit_reason = reason;


