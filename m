Return-Path: <linux-kernel+bounces-434192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825B9E62EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D0A188534B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03DF13C69E;
	Fri,  6 Dec 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRA/L3Er"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568F13A24A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446976; cv=none; b=BHZm4S1Oi20R/cFBErq1mBn8WobcLCRtbFwv5o1AFO/FRT75VHcDbJb3ECLGedgADuU99eh5YpMUWckEeyPzxmMU1MeE6Zpp1c+XoUKJIRuvpsSH9nLemZRR0SIdUMvC1fkuySAbZQylcNpF87ytdbnZgX4JL736If2qa3Mgyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446976; c=relaxed/simple;
	bh=p3ayRHOyJ37cYdE5ih5cbVRLX2IsH/iMc+NXkzKTL5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5NDujcuQ6uG4TvRcLkPESy8zkwUOcXdMyTt698k08DiXG2C3mJSAmRqvjnu6WS8W4tafKl4+ge3Ampbdtc/yZq1QVl+6+05Fz8TiA1vVaK6/iYfX7KPV2E9d+umVzSZMGZGP4ASBfXW/NBId8wcSlruRXqSr5JIRxjFzyrQ/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRA/L3Er; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso1561259a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733446974; x=1734051774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=odFeXfqtlca+kvw0AmBBC4wYZf1vb1zFbu4qDCM5v8E=;
        b=NRA/L3Er5i8mGdWywOoxP72zMRsg0DTlEmvuMN4oy35CY2J2kHwKa2zoKyJa/WwhNq
         0J8qrhrk63hhIolLt622xin5AwmOKJuLJ0c81+TrsZMaw2Up9Mfedh8t0JzNvt4mbAbi
         Mske48I8z8EfLpq50VyIYyFYU+7aY0h15qBH0ofYrKayttRz2F7xBNUSNxviP+e3I0tI
         OsLUSe2w4tSK2Xy5MRkWZ5YLpFLYVHYVdqlsdm9cN/Y0jWao9uFr+HqV/CugBI8CJqts
         mGg5u/Q8HG5noOJDB5D/4TLLSEf0l2FVUgsJeJAIVcuTEaVY6bRPN2OE+GE78xuNGj/5
         hA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733446974; x=1734051774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odFeXfqtlca+kvw0AmBBC4wYZf1vb1zFbu4qDCM5v8E=;
        b=gY63jpLVQ2Hjkqp5U/7GYqDibX++cszZf1ONswHFs3tYDna5btEjD590jWzsMYMOik
         tlarS9AqRM5BHOzE1VOHa2DtqVL47tXAc2JmJrBItKXp5YOyraOpJtw0Hciu0Aim4IAz
         aUErJ/TTiLOif3ovt10jVA4ils1YaGgzyUuJQJ2/Qzkyy0v55QpaRs6K7bVRjCCB7oMT
         cswrATClV42ZFVH9crnEwLpKBX3oD0kFyeevqHCkFnXtu6l8IoiSkJ1mX6t64R7FWYLf
         jMBR4cOYwewDDFKtx7zJwO+1V8wEme1fD4wxWEC7Y+hOo3BEAbhxGv3PimjPljAJsdDY
         FEuw==
X-Forwarded-Encrypted: i=1; AJvYcCWo7jgvj4VxwbQyg7EOZD50L52eCW47O6z/5WBo6EnGarQ8wfBv3vTp7fwr8vu0d+g3UFf/ldKuGkeg7lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KtmJq4OVXSZJdLwlmQcGdCYlPrZyIrT8uNj8/6yjiL9Gk1Ax
	22sz6M0Sefitv4x3mpTVq9wArquh/GwQlligJ3eyNeTv7vOx8wOrEgR7NhNq73XfGRrZ8WD/Mfp
	zqEpLzgH6Kg==
X-Google-Smtp-Source: AGHT+IG/xsuehHtVKFEvmGgFIgshQ+B4zAUcgF8mwEzljCVlVfmJ7/hjNhV2sOIJea1Ftx1RfhpzvhzzdrXv8Q==
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:2e2:8d64:6213])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c07:b0:2ee:d024:e4f7 with SMTP id 98e67ed59e1d1-2ef6919952fmr2142759a91.0.1733446973755;
 Thu, 05 Dec 2024 17:02:53 -0800 (PST)
Date: Fri,  6 Dec 2024 01:02:45 +0000
In-Reply-To: <20241206010246.40282-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206010246.40282-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206010246.40282-2-jiaqiyan@google.com>
Subject: [RFC PATCH v2 2/3] KVM: arm64: set FnV in vcpu's ESR_ELx when host
 FAR_EL2 is invalid
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Certain microarchitectures (e.g. Neoverse V2) do not keep track of
the faulting address for a memory load that consumes poisoned data
and results in a synchronous external abort (SEA). This means the
poisoned guest physical address is unavailable when KVM handles such
SEA in EL2, and FAR_EL2 just holds a garbage value. KVM sends SIGBUS
to interrupt VMM/vCPU but the si_addr will be zero.

In case VMM later asks KVM to synchronously inject a SEA into the
guest, KVM should set FnV bit
- in vcpu's ESR_EL1 to let guest kernel know that FAR_EL1
- in vcpu's ESR_EL2 to let nested virtualization know that FAR_EL2
is also invalid and holds garbage value.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 arch/arm64/kvm/inject_fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a640e839848e6..2b01b331a4879 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -13,6 +13,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_ras.h>
 #include <asm/esr.h>
 
 static void pend_sync_exception(struct kvm_vcpu *vcpu)
@@ -81,6 +82,9 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 	if (!is_iabt)
 		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 
+	if (!kvm_vcpu_sea_far_valid(vcpu))
+		esr |= ESR_ELx_FnV;
+
 	esr |= ESR_ELx_FSC_EXTABT;
 
 	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
-- 
2.47.0.338.g60cca15819-goog


