Return-Path: <linux-kernel+bounces-535438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9DA472D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580D23A40F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8DE2475E3;
	Thu, 27 Feb 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBDqtGIv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE4241CA5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622810; cv=none; b=XbX4DFxIhOSmO9y0QRlV+SQyNBf8IfpJW3eOW4mN6uaVDX+Ai0PIRdtLKJMjtNi5iNFDqX8kO5nS6qgx3chTqivE8VO2cbqfrUqcPe1nODkIpBDg8d+V98xG09KDbqCELRS3TyyRBSR2XHKcX/j1bjY6g4IKjeer/ylR95BP4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622810; c=relaxed/simple;
	bh=8tMxUjf29DV5ZoAnNO0UTJZHJbBzjdRYlL7FtigAdUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NK6bF/KjOf+dFtEcvO2R/M9Kn5IXI0Z7gqPNGRXjALKax55LdjOS+Toj9CkP+IGqQlS6+pmWHUusV0rj+YyRlzbSgTQVro8Di/Gkx3ZXsBUCftrWplPKQ1JZ0K5ZzYHjcn7fU5anpLtrJqbz5j++VTu4KaB/lws1/b4moYA7Rzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBDqtGIv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc0bc05c00so1509763a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622807; x=1741227607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KI0queLIxZnghHgRHs7xWlDt+M3CNsR2JqWjVaFF+mE=;
        b=pBDqtGIvdseibNlSC2xxFsNKxOUMOixkWOZrHiSWF9VvxGM5wYxMz38pXHJiOSBfpp
         WtPOMpn/QEksEHUxgkwgxLjNTesfRvZqEX7p6nuBcY22WdtRpwoYaTfxLQg7mfk9Uo0/
         0arN2z7cxw2uT7H1OPlTYgcBDXgT5CMrgMfFTc6Ph1wZOL4uWrrDw6Mqr8xSxdQYcifH
         t9m1G+3dPqBu8k9U1wl+deJu1l6B2VsYmGNzGha6wShGAmHU6jOCR4mOjLPwxnxnGaZ5
         7a5lhZGXnmKMz33HCEKO8LSlkOhW2vIjiLM4Vd8gvtnsUsVVWY/oKbT+3CpDmLf8SMz6
         uJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622807; x=1741227607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI0queLIxZnghHgRHs7xWlDt+M3CNsR2JqWjVaFF+mE=;
        b=WwlPXFt2xF78t6MWhCKDb+wVUQsFEYsgdFF/85oenHeYUYIOuQ92n8BC4egXPv6taN
         PAj2GvzSlRv1y55bTWUrCryG0YLg93DjhWY8X9vsFGsuBhI1gh57GFEI8pFCJIyTZ5q5
         QCvJEI1U4FzZ0rYiajfR9h+wJCJ/6afr3hPpzBNKiaRiI+1YLfAhjb/ogsnr3BEr2rFJ
         ljAM/8z4vtFzXkxhxLLZngO7I+WBUFL1jNishD2oizPTTbnnrMvjqNOpDM8SIyi6OEz/
         D3ObkBRfQGRyHt5MVrH3VjbXvjU7jft7YuGUinFDpOkD6Tx/yhNMK3E/UcoEHMwVOKST
         x3qQ==
X-Gm-Message-State: AOJu0Yy9H6pDT7YUVryC7vku/quEeR9C9xOu+4OBVKGhlf25Wxtfh3PT
	99PU6p1TicogSoZhCuROAn4RakRvPtCruvo7sM3ULfs7eAErtPJeXKT72vFQ0b9ltFGV3tfwaZy
	kNQ==
X-Google-Smtp-Source: AGHT+IFuRPRb2/rR+n2YIE9T1JgT09dE9pwcHYDYXuVdPUREy4VCpJNwziBTuQzC841m2IS5b8M/SH3vvo0=
X-Received: from pjbsf13.prod.google.com ([2002:a17:90b:51cd:b0:2fc:e37d:85dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d50:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-2fe692c6c47mr14798005a91.30.1740622807422; Wed, 26
 Feb 2025 18:20:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:53 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-38-seanjc@google.com>
Subject: [PATCH v2 37/38] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
nonstop, and not marked unstable via command line.  I.e. use the same
criteria as tweaking the clocksource rating so that TSC is preferred over
kvmclock.  Per the below comment from native_sched_clock(), sched_clock
is more tolerant of slop than clocksource; using TSC for clocksource but
not sched_clock makes little to no sense, especially now that KVM CoCo
guests with a trusted TSC use TSC, not kvmclock.

        /*
         * Fall back to jiffies if there's no TSC available:
         * ( But note that we still use it if the TSC is marked
         *   unstable. We do this because unlike Time Of Day,
         *   the scheduler clock tolerates small errors and it's
         *   very important for it to be as fast as the platform
         *   can achieve it. )
         */

The only advantage of using kvmclock is that doing so allows for early
and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
broken for nearly two years with nary a complaint, i.e. it can't be
_that_ valuable.  And as above, certain types of KVM guests are losing
the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
needs to be decoupled from sched_clock() no matter what.

Link: https://lore.kernel.org/all/Z4hDK27OV7wK572A@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 80d9c86e0671..280bb964f30a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -431,22 +431,22 @@ void __init kvmclock_init(void)
 	}
 
 	/*
-	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
-	 * with P/T states and does not stop in deep C-states.
-	 *
-	 * Invariant TSC exposed by host means kvmclock is not necessary:
-	 * can use TSC as clocksource.
-	 *
+	 * If the TSC counts at a constant frequency across P/T states, counts
+	 * in deep C-states, and the TSC hasn't been marked unstable, prefer
+	 * the TSC over kvmclock for sched_clock and drop kvmclock's rating so
+	 * that TSC is chosen as the clocksource.  Note, the TSC unstable check
+	 * exists purely to honor the TSC being marked unstable via command
+	 * line, any runtime detection of an unstable will happen after this.
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
 		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	} else {
+		kvm_sched_clock_init(stable);
 	}
 
-	kvm_sched_clock_init(stable);
-
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
-- 
2.48.1.711.g2feabab25a-goog


