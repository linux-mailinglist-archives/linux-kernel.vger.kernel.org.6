Return-Path: <linux-kernel+bounces-257462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D2937A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B1D1C21C11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714DF14830F;
	Fri, 19 Jul 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bpLWz0Qd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD601482F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405384; cv=none; b=SthtY0HdF11wzwQb3higNWrSHmxGMQ2bhFgO8Y/Spkkkf4dCTJEu7M703Trd0A0Q0roJv+TmDuRhDXvuYjWDNzFui6aPsg1SD0s7vozm6rmEi0nsxqX1ETUMHli/73fbT3B0c96Or14hMih1uHybAjPFnoLUYzQbXjyiJwuByjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405384; c=relaxed/simple;
	bh=kxv7Zl+FX0hoOLyz3hTtflMC3nokv9NW+J3BKk6ZJnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8kkE1o5DlhoRkG29gn+ZmyTDsa3u3v1r209n3KyDi7yAb4IImlYG3UDCjOlH5tXSv4CnPloSLuTg33eQx1DzV0bQdy6RfMymb5x8AhC1VnwE1LAiYZ4xzCASko1Ugl+JHBoLS/YSCj+PsrrVj8zfhxwP7n/j7o2FpehjzS/NqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bpLWz0Qd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc6a017abdso12510235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405383; x=1722010183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQYdxy4I3d97ZA3Gu7a5XPpIu9ZgexRW3zods61Iwf0=;
        b=bpLWz0QdvIe0FzbugVSo3nRrUnS3pzGOg4WP76xhXSldr1WA27ApEOGX8ia6E7E7uY
         wZr5fV3rZyW9N3XPp4tJtmZPHRTrwdqCd+wYLgm+wnj7Ezh/CS0H63WEdkg6PE41WIqj
         Z06XDToltMv1tsE40g/4maQ9VrDDFQnSbNHUljBLYLjbwg3fO/oxM9dqicnsv4mNbqfC
         Z3KcuFEDYf/XBHpPIMev21KmViso3NqxU26l48r4ipmhg6ouqcePBGrVQx73JpnbpSWg
         wfLyiNn8gbCwu2gWPILvrl5EhsSBsL4WEAF1o+XmXWfs76Qhc9OkTSZ7t3c4FS2Kuocr
         vOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405383; x=1722010183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQYdxy4I3d97ZA3Gu7a5XPpIu9ZgexRW3zods61Iwf0=;
        b=YoRYVXxSNJQ9jlm93gg0+RpkYxzGNl7nFYGKvpOvAYgQvXZGW79X53noM5tuW3s/Io
         06nLTC0HVx+6FcNHfanq5Vo8snd8nZW9uWQJ3aAaT/unelzqcnARrZfSjUIgsPQWqwl6
         iOVu5L2eyyM5Yqsp5Y3GuioOnLdwZffRixBY+fvz8AFaFUyBC8LzTpkF9SBTDFt430bI
         vFBqgb0HDmFzkIpvYLWyidNh+nXo1AG3peEUfGszFs0XjJOIccTUiFRc9OK1eAzaGrgN
         WpEMylyrfpIyi67ZaidPW9R7Si6nHrN6+hpqSqvKuzSSxkgXZon92W0kiIm2DlQx/X4/
         ZBxw==
X-Forwarded-Encrypted: i=1; AJvYcCVy464n4nJW2ZaEqyaHHDjoJP5og1EpmfsGVtHQlVU1ocRmzR+RANzi4DjRatfLePaFv7i6uTYVoD+wkvZ/zxf0/fv3d1v8pWZMhvmq
X-Gm-Message-State: AOJu0Yzi+Hjqqyt1+z3hI4YiEeNR6l0tHeJDq7t/jNzbj++7WGvIriJe
	q8UwNcdpch5omGTDiGdVpsHSnecrvwpoCQoDxadeS//LCTL7qWaqcS0k6fDfXMU=
X-Google-Smtp-Source: AGHT+IFcQ7KahPwLVADQu0Jr4SJQkcqdSHgky/PzW7byERWwoXyqIuaKO5JrsOXY2Zp2DqwfDtDsyQ==
X-Received: by 2002:a17:903:41d1:b0:1fb:4d84:f461 with SMTP id d9443c01a7336-1fd745f626cmr3062385ad.37.1721405382435;
        Fri, 19 Jul 2024 09:09:42 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:09:42 -0700 (PDT)
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
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 05/13] RISC-V: KVM: Replace aia_set_hvictl() with aia_hvictl_value()
Date: Fri, 19 Jul 2024 21:39:05 +0530
Message-Id: <20240719160913.342027-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aia_set_hvictl() internally writes the HVICTL CSR which makes
it difficult optimize the CSR write using SBI NACL extension for
kvm_riscv_vcpu_aia_update_hvip() function so replace aia_set_hvictl()
with new aia_hvictl_value() which only computes the HVICTL value.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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
2.34.1


