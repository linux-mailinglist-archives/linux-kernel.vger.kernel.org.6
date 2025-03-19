Return-Path: <linux-kernel+bounces-567914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF581A68BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4747A4454
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707FA25522C;
	Wed, 19 Mar 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="zd9NL1P+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61643254B1D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384346; cv=none; b=WHRZ0okhL6qz/ngnU86TFf9RihLKeHo8o0dmTjKgaXqI3si0U5QHK2TEpLl4MxlRDQRlGz2Meb9hk4BnrA710jB5JVv83ucYwtBH3nvlViLL4YDaGeS7SwGhO9p8iyQgtrdWcatF891BhYZU/T48FGJrw/vhBhjKlw1nsFpy9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384346; c=relaxed/simple;
	bh=/ViqIW2rQ9pRcpWe1ja+iMw9gioppsGYG5b7wTCDJeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1+WRzZdOLkvMeekThQM2CkTEh789v0hyZmxiUB/P8YAKiY4Lk0+d+Gnphu19H4NCI+NR7WrBFnrG0T3SmjRRKxFI11lEOj+S38NatCLT1e1IO9PYC2dRgfTi8Hm5mernUPSmhT3HHZALiRZVzawA5jUs8EvSn6LoesEjGCcl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=zd9NL1P+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so37657875ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742384344; x=1742989144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oc66l7/d0Jjz8FMmOmNrv+ltKHYwWToN6Hiwa3da7k0=;
        b=zd9NL1P+4ywYlDJ63dfHRsO2AwDf8hX7nrwIKHAMEE5MfhNe4dSLPe84Is1/fucQoS
         NsBXqfVC1AUdxfoz6flEoqftiqx43HVtH01JdbG80K1zAhA+elDqG2NUvon7cyPre0wa
         vuTmOfP7TCV5eD7wPh/dWHoTuogKF3PZo3f/UzxEj2XhsQIGJeUnyhHd3Ze7jeWZROiA
         1CzRU5XiZX5qph5UW6ughOlDsYYr/KF1XTJC73ORncAqL+Pymcj5VvHcMylXtHO/ueaX
         BuMMoBNDJUXiggYu5VkKsI2SRlgx5ZZFRnyoBgt/x7fXaG3FlM9yTWLde56dZmI1Oka4
         4s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384344; x=1742989144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc66l7/d0Jjz8FMmOmNrv+ltKHYwWToN6Hiwa3da7k0=;
        b=wAj8AyxL8OD95L/icQzWKprJmb3+xSm/KPCQoePDY883CipfK+EDunLVLKXV0H4Is6
         WilV/ovNXvI9ZepBsUg5LhORKSkInu0S6QtSj6mD32jRO4EjZvvWAu4VjdZuZ//ov/p4
         LSWwMnywYOTuBBR/oGLhOHXCDSKzQNfV5KlIWNsCsCyTPzIZx2WEevAPp9YrHGDa/Tky
         R9TjG02OvCzWA68kkXTBmeXfkkkN28AazWlaARRtxOpqrzonyuR9Om9cNI+Kmo9q6rt2
         rAFj+oVzBSKVmxb/cQDrWsB0bgjUpfFZUXZhJBbAfLGRi6zn9+z/83tm3vrXDUZOZJ4M
         XEmw==
X-Forwarded-Encrypted: i=1; AJvYcCVe4FrN8z3b93SdMAoBlMWcI+I8GtCP93Uyrrk7iyvfA3Ilxq1lWFDsVfbNCGsnaqDDJf+WwSG7kG0diJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbqfGKacz36UzXER3zp508zPu2Jn6MLLnjp7EVOGW5rv+IryY
	qci0PKWNZSwbf2HUvyzBMWFHGHf9YXFvkW7H88qAQY4mWpoxoli1UoBOX3g+z1M=
X-Gm-Gg: ASbGncsLQaB0xeQrVE8RWaAFcUOSVGDFK72ryXI1srTyhSiCWuwfsU/aSXgSFLEYF3l
	R9uGEuEip/O7G/obXkudIRhk2s6akRVshccXZcpXPp7Xakp16LO/46FucPULOLW23GO3mmj1UNS
	SkjYZHoSmdN4m0sNyL0wAo/yFcCzqBNflIICmADJBJHwzBccik8KmEUlchtv7Wstj4qT+FmwnIa
	sZ9d0WpRocP6nzf5zywiQMtI2nw17NPs/WFg8rvE6xMFiHJ9QvIi8Zhfl2JjAkho1QkU+CSXn/H
	R8M1qfFP758H4gmofWlziSMle/xV25uow7zAQjIoeXhVg2Qp
X-Google-Smtp-Source: AGHT+IGSv0AJ8KwpE6fQl4DpNJB/7VkQwjj59TCcKQRqKU8wam5+t3NXf5mYBQBcpLosGuAKvIYqVA==
X-Received: by 2002:a17:903:1790:b0:224:283f:a9ef with SMTP id d9443c01a7336-2264981d654mr33063775ad.6.1742384344597;
        Wed, 19 Mar 2025 04:39:04 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd5ce5sm111657845ad.252.2025.03.19.04.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:39:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 19 Mar 2025 20:38:55 +0900
Subject: [PATCH 1/2] KVM: arm64: Trace values with kvm_sys_access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-trace-v1-1-0fff03204efa@daynix.com>
References: <20250319-trace-v1-0-0fff03204efa@daynix.com>
In-Reply-To: <20250319-trace-v1-0-0fff03204efa@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Tracing values written to or read from system registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/sys_regs.c          | 24 ++++++++++++++----------
 arch/arm64/kvm/trace_handle_exit.h |  6 ++++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 14f66c7a4545..362e2758d101 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3994,23 +3994,27 @@ static void perform_access(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params,
 			   const struct sys_reg_desc *r)
 {
-	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
+	bool skip;
 
 	/* Check for regs disabled by runtime config */
 	if (sysreg_hidden(vcpu, r)) {
 		kvm_inject_undefined(vcpu);
-		return;
+		skip = false;
+	} else {
+		/*
+		 * Not having an accessor means that we have configured a trap
+		 * that we don't know how to handle. This certainly qualifies
+		 * as a gross bug that should be fixed right away.
+		 */
+		BUG_ON(!r->access);
+
+		/* Skip instruction if instructed so */
+		skip = r->access(vcpu, params, r);
 	}
 
-	/*
-	 * Not having an accessor means that we have configured a trap
-	 * that we don't know how to handle. This certainly qualifies
-	 * as a gross bug that should be fixed right away.
-	 */
-	BUG_ON(!r->access);
+	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
 
-	/* Skip instruction if instructed so */
-	if (likely(r->access(vcpu, params, r)))
+	if (likely(skip))
 		kvm_incr_pc(vcpu);
 }
 
diff --git a/arch/arm64/kvm/trace_handle_exit.h b/arch/arm64/kvm/trace_handle_exit.h
index f85415db7713..b0308d95304d 100644
--- a/arch/arm64/kvm/trace_handle_exit.h
+++ b/arch/arm64/kvm/trace_handle_exit.h
@@ -88,6 +88,7 @@ TRACE_EVENT(kvm_sys_access,
 
 	TP_STRUCT__entry(
 		__field(unsigned long,			vcpu_pc)
+		__field(u64,				regval)
 		__field(bool,				is_write)
 		__field(const char *,			name)
 		__field(u8,				Op0)
@@ -99,6 +100,7 @@ TRACE_EVENT(kvm_sys_access,
 
 	TP_fast_assign(
 		__entry->vcpu_pc = vcpu_pc;
+		__entry->regval = params->regval;
 		__entry->is_write = params->is_write;
 		__entry->name = reg->name;
 		__entry->Op0 = reg->Op0;
@@ -109,10 +111,10 @@ TRACE_EVENT(kvm_sys_access,
 		__entry->Op2 = reg->Op2;
 	),
 
-	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %s",
+	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %llx %s",
 		  __entry->vcpu_pc, __entry->name ?: "UNKN",
 		  __entry->Op0, __entry->Op1, __entry->CRn,
-		  __entry->CRm, __entry->Op2,
+		  __entry->CRm, __entry->Op2, __entry->regval,
 		  __entry->is_write ? "write" : "read")
 );
 

-- 
2.48.1


