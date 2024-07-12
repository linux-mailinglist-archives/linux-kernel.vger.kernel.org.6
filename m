Return-Path: <linux-kernel+bounces-250969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0C92FF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC0B2852D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24517DA18;
	Fri, 12 Jul 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO7lm+24"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427517DA09
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803721; cv=none; b=rVjVYfvY1k6VhcnoJnfbumKkNujMYixRM2LLynNrcrtDZx52uYS0zgCJbJ9op+hLIFneWD7elzF5abPIyr+fBTS+Jkngha+3JHST8/1VYNiilI29thBUZhypL7skyJGHWM0QS6H/9YxyTJzepnU1d3LpPWIbtz+OIGq7YmAXLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803721; c=relaxed/simple;
	bh=K0gFt2zCMOORS0kcEjcT2GtcZt7SX3SQZ5OWDNzK2u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=INsr3zEFDU0yxMCEGgZ1rBMIYfByr9y5qP4jRXIZ3sUFGIHVm6TTDx+75rVMli/gyebIhFiQ/iNW0mz03HahOl/BLNj5yCR0V9YVGGniPkqkilt7HhgcVSnNUpZ4s03RyPpgoKAUTTowjIkR9EGU749B4nCVdhZAYZDrQ1VJK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO7lm+24; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-367960f4673so1771697f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720803718; x=1721408518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvK59wkpmv96YBPTwdu+UmQnFP5VkAZYiTxY4Mh4uQ=;
        b=IO7lm+24kv5ciuOZ7gHxWNridD11c/tzN06UzKBd9ATr7bK5zPmKZfCQhMyzGUZsVq
         iBaE03MU3Fh6QBzBc1Rlf3bH4WqdIWRi/tN6oB9mIYNwKQrdBFbBfGiS6Rpwx1NvW2mG
         gDVKYRHLFUrJSXXzagckK3VeBAO2Q2edzh2F4qQBGbEPwneKjlVOgxmpvrBRcOvxr97U
         lwu23Cbb6M/m8TQXaRKkew1idX5VdUW7fp7S6aysFp3kCPPLCenULgnZ84z40KyYv02Z
         /yBMGzdNYhIh+plgzmpn+ejjGmCndQ3NpATBfthZMP2mrbMV8VtKGIoTDnqbON5mDie+
         EPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803718; x=1721408518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtvK59wkpmv96YBPTwdu+UmQnFP5VkAZYiTxY4Mh4uQ=;
        b=FWKxEd1jkm72ThNgfrYc6v1kt+Z+rnj/ZETPMQgCNrhRRabIBiI4J9HTlrLPtP8XKy
         t52Q1TNAGo3FpHyH+gRvWXKpEAD8UTZp6C7nR7WWpY+v6gvVj4pohg2G0e1IefjByxWK
         t4VTkzJMIZA8vIPwzsp/63n4pS2VzoQxuz56RXfoFGPZvB3JJWTFo14CEZWHIIu5V2HO
         m4HD4UL0lT1HqCq81N06NlsIL136nxjRxKiEKUFhGS412N6IXfzhj/VHwRKF08v8xMDx
         xEz/gyrGjB2xsWTEXFp/vJl8YxqLipI0NRZz3eaMJGGPBD3X+Ihbhf1DPd0KDfZcRXG6
         iP/A==
X-Forwarded-Encrypted: i=1; AJvYcCVEHa5EqHNfHMA/OqtITr6NyUk/eEO3VLqVk1C+whVlGwCOtmmpR/oT72WctelR2aX63ZUwMZTMxIakvgUJyIr7zxNHccAL/QS8GaRI
X-Gm-Message-State: AOJu0YxP4bke6BnzgdY5eF1rdKy4EAXgQWZSE1nE1/TINTkz/+/zKWOZ
	rq3+kIlMa1mkBcA3Y3aYqTWtBbBB455wbMzb+tt+C7W5KEq53ycjqUVKfdIjGOFeSRV9GZTq0ze
	tRyzkQmf/rA==
X-Google-Smtp-Source: AGHT+IFpeHjscoHoV+i7b46AZT6D1f9aKe2Nj5oFbdtPCtyqFA2ot3+sTCgSvjfbQ/uIAyhmtnXZfQlaZ6B1Pg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6000:2ae:b0:366:df3f:6f98 with SMTP
 id ffacd0b85a97d-367ff696f10mr6916f8f.1.1720803717468; Fri, 12 Jul 2024
 10:01:57 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:00:40 +0000
In-Reply-To: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240712-asi-rfc-24-v1-22-144b319a40d8@google.com>
Subject: [PATCH 22/26] KVM: x86: asi: Stabilize CR3 when potentially accessing
 with ASI
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

nested_vmx_check_vmentry_hw() does a VM Enter as a "dry run" to check
the VMCS. It's important that we VM Exit back into the correct CR3 in
order to avoid going out of sync with ASI state. Under ASI, CR3 is
unstable even when interrupts are disabled, except
a) during the ASI critical section and
b) when the address space is unrestricted. We can take advantage of case
b) here to make sure the VM Enter is safe.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d05ddf751491..ffca468f8197 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3147,6 +3147,14 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 	 */
 	vmcs_writel(GUEST_RFLAGS, 0);
 
+	/*
+	 * Stabilize CR3 to ensure the VM Exit returns to the correct address
+	 * space. This is costly; at the expense of complexity it could be
+	 * optimized away by instead doing an asi_enter() to create an ASI
+	 * critical section, in the case that we are currently restricted.
+	 */
+	asi_exit();
+
 	cr3 = __get_current_cr3_fast();
 	if (unlikely(cr3 != vmx->loaded_vmcs->host_state.cr3)) {
 		vmcs_writel(HOST_CR3, cr3);

-- 
2.45.2.993.g49e7a77208-goog


