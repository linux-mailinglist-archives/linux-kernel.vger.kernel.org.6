Return-Path: <linux-kernel+bounces-417360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E69D52FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571E8B278C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943161DF977;
	Thu, 21 Nov 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Hirfohn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924E1DF26F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215210; cv=none; b=t96s9fHX2P3uTburVvKs/JFObCbyJwfKeUtD1u9xZrjUlkys5KzUco7GbUgspexW0FLl1MotLha6MmfQsNlnuQ+dS8/VrbB1NqY+tk013ZwekBtCM5NM5+rUezuyFlhER9uJrU0yyOgWuiN6yaUr04EVB3awe7X33RI34M5PBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215210; c=relaxed/simple;
	bh=SxrvpTqqakO+SE1JSfeW2dZ+qSHPbHK7pKymKVP/ZXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkS6idNHtyNU17mEtfB5bjYXMKDx3YCRC3e7i+5r2xcbxdkDAwsK3UgDgvKJV5OMVCbDKwXcY2XVxYJZ3ldydwNtwJe2kCbpSmB/Hlu6ppQ9U1eeLw/vMcnVw2ewgAdzndNJvHvAxBabJ8ikIge7VHrEY9hwLva2zu18QLjP+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Hirfohn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb754bc7cso20466877b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215208; x=1732820008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+b6W97BMpWzJsRkR70E8bmCkFexWmOp62HeJxz267S8=;
        b=3Hirfohnw5OR/d6y1tUuuQruToXiIzqE+NYWUoNDJQrLP2VQqsbreE68+fd9kLwfXL
         0+zqCw8gktyAgpONx00PVqaJMf5boSxD5ffnGZVDiA4/q9z6vd9vIgoEl1XItwAMIxiA
         /ZAfoQADeaal9BKGF5eqCIVJJ0FTop+qjX/LX4lqlK05SgM+YNak8KkZlSR3XYzzuKSb
         jYJ7+zU2ZVxiyMCeJiMW8z15HQceERfGfz3yWAfsAYJniFZ5J5mM5dErHDkxfPaNJ64X
         wY4tm+Cwb8kRHNKPBqX+evyLiQICl8b8eZxii43Y3ZKQ2sgNZwqxFEYxKSYMtSiRGuNK
         pb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215208; x=1732820008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b6W97BMpWzJsRkR70E8bmCkFexWmOp62HeJxz267S8=;
        b=SIoOLhMadJS0KzMUNbof2lse4dVOQAG2VAqT7M2XWZ3Af5Y93ogEsK82gIqjxvM2UL
         jRVD89qF1Pm0XP/nH8KPeslshUx6/IPzm5w2zXF6IvGS5erJWPbmp7S8KdDYiym8yEvF
         +8NOsoIc0VeVARktjkQQDwi/xYTgxu3vgqtPyPKLk/zC6negB4SIsxIAanTfaBXeos0+
         /RxksvQMIKgmlfBVo9PPPzVXH5gXIGVIBmHKiZdne9AXXUx+KQkdjEPFFvCnNbduwvbJ
         UV5+5SEBH4RorJOlWMfNn38DIw1l86J3POtGsxG5puR8/GG2KjR6zKpa6kr+ciS96djY
         ikXg==
X-Forwarded-Encrypted: i=1; AJvYcCWUOPVhGoO1xOD09h5KbCD9Kaj5iR7yxh4+VLRdgmuCyW/MuhA2bYlDpycs8Ny1pVZLC/zRYZBipktTJ1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyA9HTcAcV0wXl1c6/6aaoQBxsMySot1SqNg9R52jrh4KYvACD
	+j3c2Xd4YzwyjFM9hsS0igfWNZmqaA+omWn6R4TFCH9U+Wr5NaUg6lUYA/EnwndqDgo4OGwSrAf
	k6olyQA==
X-Google-Smtp-Source: AGHT+IHA/LlqfVC4cB578a8wvHBObnhD0lyB5qPv6+RAzcNl/mZXGlIBsUax3fhUb5PzQtIk0zmfwsAkpA1H
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:690c:6709:b0:6e2:1713:bdb5 with SMTP id
 00721157ae682-6eee0a39166mr21687b3.5.1732215208089; Thu, 21 Nov 2024 10:53:28
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:58 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-7-mizhang@google.com>
Subject: [RFC PATCH 06/22] KVM: x86: INIT may transition from HALTED to RUNNABLE
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

When a halted vCPU is awakened by an INIT signal, it might have been
the target of a previous KVM_HC_KICK_CPU hypercall, in which case
pv_unhalted would be set. This flag should be cleared before the next
HLT instruction, as kvm_vcpu_has_events() would otherwise return true
and prevent the vCPU from entering the halt state.

Use kvm_vcpu_make_runnable() to ensure consistent handling of the
HALTED to RUNNABLE state transition.

Fixes: 6aef266c6e17 ("kvm hypervisor : Add a hypercall to KVM hypervisor to support pv-ticketlocks")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/lapic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 95c6beb8ce279..97aa634505306 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3372,9 +3372,8 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 
 	if (test_and_clear_bit(KVM_APIC_INIT, &apic->pending_events)) {
 		kvm_vcpu_reset(vcpu, true);
-		if (kvm_vcpu_is_bsp(apic->vcpu))
-			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
-		else
+		kvm_vcpu_make_runnable(vcpu);
+		if (!kvm_vcpu_is_bsp(apic->vcpu))
 			vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
 	}
 	if (test_and_clear_bit(KVM_APIC_SIPI, &apic->pending_events)) {
-- 
2.47.0.371.ga323438b13-goog


