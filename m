Return-Path: <linux-kernel+bounces-535431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA642A472CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154551889369
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEDA236435;
	Thu, 27 Feb 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEbgBKOh"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A7235345
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622797; cv=none; b=qPn7tyKAjK/B5GUdePXx1KiLt1o1xX5LZ8qDZBVfhhDF75QXxg4mN8neG1gP/zyY9VjG1TC053nsf/BO2bq02RwpyYWDCCZun7VhakgdX1ERoIPxaGJdTM6kLG7Vpfo9NEezVq2q0QrOQeebaopiNZzBqllbmX5O7dZj3zhNi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622797; c=relaxed/simple;
	bh=9PNQlaFr17QsW09OA3IEH/cFSTquMC7pYNcyhSay2n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYscxsRHDWYLP+zB4FwmDdfA7YTE6k0/Cg+dwPXyKse4Efzkm6YGFgXL7CvHdruGUaeGKwF0vm/OyT16hTDYVfQ3o5DIn90Ms0P/kz2lihRA9Ej83Kifn46OOocu2uu2hmfyWgezD3dIJV7whxE6xMKHWiftsQNEIykhpKDnG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEbgBKOh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so1064523a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622795; x=1741227595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3F6YIZD9bSIlkGuU2KG3Ao1xkSJhhKmqbmLiePXFSIM=;
        b=UEbgBKOhDxMYxMoDIIGBV5uWU/Tnmn8nsHyXriJImPHhu0J0q/06xJVRquOlcg1V5K
         jL538nlnF5PiO95x4DhiJAIz63+eT/PmtCiiQ1OCc0h5rXnN0XLrOdrTUtbA/OILqljq
         RURh6o/gjgofzE1fD0MgXZyG1aH7sr+ak88LGum+GhqLSKNGv62kStd+75zMIYXX7OV3
         zhuPjdcwkYo9af3YLGjTgCEzColLONbqBDyHtBH98Kvrw6hNbu2M3Of2BEejO3D3Q6jV
         hU9NA3sLP3vXNJAStUWDxeNP5n/nyiWGVMaokES++xGuNfu6DmX4kagAdtwhrAF+Icq+
         ZNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622795; x=1741227595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F6YIZD9bSIlkGuU2KG3Ao1xkSJhhKmqbmLiePXFSIM=;
        b=arEbW8sVrMlS9ma+dehSaMqDx7uXxEPeiJt9TR53YMaXhfkDrjI9pvap0sxmTdd5x/
         Ao9X5shSKlST4dJ+Y527Ttyt8sqOElErfY9lS+49BIkLJD1mOsUro4z06S1+nvIntEzt
         WeKn/FkId92jBfq6hptylNyR21aCvxH4J9kWp8zVMMfd0w9wdl1LkwR/6BWYNB7DWWi+
         KAEQZpvWB3Tw8h7jJMmC+g+/hAFFg4KFuL48EDQCUrKIVoxLn/+pGhvdB90tY6PL2ndf
         Zj0IQ2WIFWq/r3b7xA09TwwJOBK8IArZY7n++9LOlXhyyvxmm4j+wz2h1pDO9dG0freJ
         Fadg==
X-Gm-Message-State: AOJu0Yx0OWdBAwmlkMIFJzF8nPNiCqubbXT1bQnI9OF/1/LnFLIWGhE4
	vaSdCD1fsKMzuu1VQkcR/FauX+g0/h8FV+DoKbunva8p49Kfm/zClvz/XsIIno8U9N6gFCrEwYp
	SVw==
X-Google-Smtp-Source: AGHT+IGJ6z3saIzRbkZlSBZLnZw7mlbnCfDCjtlOA/kyHI3FVoB/Y5gfMuQ1H6WQ1/ZAhh6gzh0XRDRpGl4=
X-Received: from pfbfb4.prod.google.com ([2002:a05:6a00:2d84:b0:732:1ead:f8ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1509:b0:1f2:e2b0:dd91
 with SMTP id adf61e73a8af0-1f2e2b0ddb7mr3698859637.21.1740622795028; Wed, 26
 Feb 2025 18:19:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:46 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-31-seanjc@google.com>
Subject: [PATCH v2 30/38] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/paravirt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a3a1359cfc26..c538c608d9fb 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -89,6 +89,15 @@ DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.48.1.711.g2feabab25a-goog


