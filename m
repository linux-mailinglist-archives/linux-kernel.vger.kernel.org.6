Return-Path: <linux-kernel+bounces-373421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B279A5678
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDC51F218B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D2B19993C;
	Sun, 20 Oct 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GTqJfJ0f"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172A619924F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453676; cv=none; b=ct1znXahQhr58ARfYfIRH0SYhLS/KfHlVvg/vZ0EoJWnCxFjxb9tCAXado/DdbPUuUoKmWGJizBMJvt+iEXn4B4jGjilROLzNAh8iOHn4xFbex0ahFR9wRt7oqPoRI9R39IuMSUf4OfU6pQlPTE+96b6vMNVj/RP5ZKItRXZaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453676; c=relaxed/simple;
	bh=oE1Zu8aEJgqleyU7ZpYqwEzohbGPuLf2NxIVozUTJmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+qjn6fV4Q4Do8Qc0z7O0VVg7jEzWdUJU5iQDoMt/JYuWl/i2/72NUZBA/gsTitIarUZvsXOk110uCT/+ycQB7fjBxPOFOgSgDa/DqjKAmDR8/m+BjpLf+/mz1hnIYkVV5Btj09zxigRCvcsdP5rs0sTs4//7J7IDi2cJwxTFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GTqJfJ0f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so2534658a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453674; x=1730058474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEedsq2JUKhoGmqZGJYyzFicNOwkAdZlkiaTwr3TF/o=;
        b=GTqJfJ0fZETggrR0u/aUBB61ACCeFCa9QThO1XaytMATZ+7loIn2EDm3ywg9x2FvOa
         AgUQjM+OevitoWqhV6eEFxHn/368BmezDORP3CP1Mo6VngRj8X8SDRG0+Uc7LXqLaOWd
         WjuVW+eLcrG4UUFjHIGLRT+hOT6p4lM4142HihPs72qk4FnJRKiAzSHgC1nmjjlQLVBU
         5B0vKA0WlQ5sMMu/+Y4ZnkHyPDGiMdKSgmsV4bg39ZlaFdeKkPJtwNjySL7t4dgTn67D
         u9LNWSHBl2l1KTcgoCih5W/j17rIu23BMcgpB1MKFJQGnU1ekLPztqdndj5WH4OsHHWi
         n+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453674; x=1730058474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEedsq2JUKhoGmqZGJYyzFicNOwkAdZlkiaTwr3TF/o=;
        b=EGENEbT6lFVvPocWBfWW98IWhehxznTnMKkUoWySvTmd1mTtPSuW/ryxd/08EXRbEz
         mNmAAJ1hf05Z3KxVhb7p3SBiOAqJ9a1oMuYDS3rKyHyUhEH4ekJsyb3Nn/WL7Xu5vbR/
         RjJ80ChLU0pyOitFFXpDPD+5F06pN5EpW0Q+y2HazbCwZ2cWYi4/Se6p73z3jm/nOP1d
         j9PbnQnRwcf/Zx+cIM+jcpC0raGw28UUxL+inmvTj8cDkpNgmBE/2Nqx9Snm7HpzPa+3
         vO/Pfab0oTmlyUiWudykO0sVhkGOmWO9qHw+vpsXQVBbHvw2em2VZEjCdc1EiBn+zQ10
         ONag==
X-Forwarded-Encrypted: i=1; AJvYcCUXmj13TiB5OTMsFiH7eRuqJlc6EQoBG63kwCxsxzz7UY5IFo+0tXByRgygPmkjv5gOz7Mvyjoq83SHVPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSjRtgw6I+eFDbxilqISxnAS0Bb1aXoxOzZ9fnz+ugW/xIov9
	fdu9CrtL2lxkU3qHkFb7mxv3togScBc+yTaqFf4VlM3e5RqL9CKO/nUtgGOmoS0=
X-Google-Smtp-Source: AGHT+IE/fRzVoS+fVEWIeoAKQcgXW0+uJTsQHmeBuYcXiEzRwc7/fSmVJvcmrtukYOBuAWj6RtlBvg==
X-Received: by 2002:a17:90a:a586:b0:2e2:cd22:b083 with SMTP id 98e67ed59e1d1-2e5614e5da3mr10891971a91.0.1729453673108;
        Sun, 20 Oct 2024 12:47:53 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:47:52 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 05/13] RISC-V: KVM: Replace aia_set_hvictl() with aia_hvictl_value()
Date: Mon, 21 Oct 2024 01:17:26 +0530
Message-ID: <20241020194734.58686-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
References: <20241020194734.58686-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aia_set_hvictl() internally writes the HVICTL CSR which makes
it difficult to optimize the CSR write using SBI NACL extension for
kvm_riscv_vcpu_aia_update_hvip() function so replace aia_set_hvictl()
with new aia_hvictl_value() which only computes the HVICTL value.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/aia.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 2967d305c442..17ae4a7c0e94 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -51,7 +51,7 @@ static int aia_find_hgei(struct kvm_vcpu *owner)
 	return hgei;
 }
 
-static void aia_set_hvictl(bool ext_irq_pending)
+static inline unsigned long aia_hvictl_value(bool ext_irq_pending)
 {
 	unsigned long hvictl;
 
@@ -62,7 +62,7 @@ static void aia_set_hvictl(bool ext_irq_pending)
 
 	hvictl = (IRQ_S_EXT << HVICTL_IID_SHIFT) & HVICTL_IID;
 	hvictl |= ext_irq_pending;
-	csr_write(CSR_HVICTL, hvictl);
+	return hvictl;
 }
 
 #ifdef CONFIG_32BIT
@@ -130,7 +130,7 @@ void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_32BIT
 	csr_write(CSR_HVIPH, vcpu->arch.aia_context.guest_csr.hviph);
 #endif
-	aia_set_hvictl(!!(csr->hvip & BIT(IRQ_VS_EXT)));
+	csr_write(CSR_HVICTL, aia_hvictl_value(!!(csr->hvip & BIT(IRQ_VS_EXT))));
 }
 
 void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
@@ -536,7 +536,7 @@ void kvm_riscv_aia_enable(void)
 	if (!kvm_riscv_aia_available())
 		return;
 
-	aia_set_hvictl(false);
+	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);
 #ifdef CONFIG_32BIT
@@ -572,7 +572,7 @@ void kvm_riscv_aia_disable(void)
 	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
 	disable_percpu_irq(hgei_parent_irq);
 
-	aia_set_hvictl(false);
+	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-- 
2.43.0


