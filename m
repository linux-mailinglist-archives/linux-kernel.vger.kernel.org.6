Return-Path: <linux-kernel+bounces-200645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AE8FB333
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF94B29A08
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C814A4F3;
	Tue,  4 Jun 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oQH303wy"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F4146A8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505362; cv=none; b=Yg435VPTR5buQDEGHWMbWKkSsEr21LUifupdfU5hLkJhI5ztFbifWVwxo1Q3GrWqACwoADeU3XhUHObEH2VwzLgOw7HyOegxwZjligBO6dN/MSkrf1wIhvJHfbvlo6S5aENYD/pyGyEaIC7+LzGarapTpWDVH6pqrhENzix/RWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505362; c=relaxed/simple;
	bh=9gi4a4wTtOnHVdD3VSLP7Qeg3BmFkZjwDMVlBkbQhKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pu67aKwZhmVpvaUoOvlfuxy8ikD64go0kQTAr0qzDIVJOoCUMF/37ZhfvEX4DqTLoK/rSiu20Jf8rtPHmVv2S2l+Nr9bF7gkD2C3QCVsjMU29+r/GxyiDTVgttzc3diObL0seIBz76oKMUiOgSqKb+pkJsU/TKTlNfwl81M9ffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oQH303wy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso648989a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505360; x=1718110160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg13op520E0l7vmsGSXJjwrEXGfoFkLadNxxD6X23VY=;
        b=oQH303wyl92EQU98nM0yovW2mIBSccaLRA7ij57ulHx8t2FlEbiQ1qTvyOSfGrP497
         gIVN+re6sV/T/9QEL6AR/6eU04npXIa/2/jZcqBKMX7y4Y9PQvF20i5NfVXYHUqUNjzB
         RCyj+PCkOikcW3fXK1wCgWPsNX3Zom+46mE1OjcIZEm7JRLwQas9cQ2XKR7naadL1wvo
         E9rKy8gjMhnIx08xX5/cMk+eNjbC5+MYLaCXULMWZRvMAC3m7U8PYJtlR3hF4jzLOsVv
         fGYU0z7+q1b6m3FkSImGVb1FhvqTcj8qLqVHIOf3tufVsNpPmiuxXkd2NjP/HHwJfzBr
         8rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505360; x=1718110160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg13op520E0l7vmsGSXJjwrEXGfoFkLadNxxD6X23VY=;
        b=HdyV/VV87Poen3GT9G7by+Tyl+TG5R0B7PWQ5PuZFKF42LOvQ9EvFF9EmIaxDRGuxl
         ohfEADhf5vmKAWLWAH7G7DsgTCzmGsegG3wP6ZgjnxUJC3kRXBJhWpVBP3wD6NUBwyEu
         Y1eAm7mJvvw9zAtbCid1WB45kMFKbEYsobNl+vALMQsRMR/Ii3q3haFtyodDsnR0txeP
         ARW230lot01Cbgwe7ogQCZtmePOaLAolOTkMb6m0t01LnnWWFIPBLJixjvuYEE+GpOEz
         2fEZ5uvr9b4TOBb+pGlU5Yfzx2BHQwQ3vgfqcNe7Cw9a8ikefCfaOx2fHmvB1pg+gCBA
         zSOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfSVStfiDEtnUMHe5Oodjv/pv9T+nwLj5dKrw1/n2AFtFlJOQeV5hoU9fcu806+4BpGgMa7ZAs5FQKUrHEaANpJy2SexSZiM8Z3U/J
X-Gm-Message-State: AOJu0YxpveC71UfsHK8Y8OhBiAR4HfkyhK7pT3nQ3kxPhXR9VYT+LBNB
	JQ6CnLEPQEGW6Tdob57c2SNKIuH0qPe/EvQ+DsvDOmUzlw8AiZgs9qaKnhuuxoU=
X-Google-Smtp-Source: AGHT+IFjRaBoryIbYEQtignrxN6JqLYXY8gztujl1ilZT6KvEZR3UOMAvujw3x8ToyklOBgsdusl/Q==
X-Received: by 2002:a17:902:ecc6:b0:1f5:e796:f247 with SMTP id d9443c01a7336-1f6371ff41amr134960595ad.6.1717505360188;
        Tue, 04 Jun 2024 05:49:20 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:49:19 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 16/16] KVM: riscv: selftests: Add Zcmop extension to get-reg-list test
Date: Tue,  4 Jun 2024 14:45:48 +0200
Message-ID: <20240604124550.3214710-17-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604124550.3214710-1-cleger@rivosinc.com>
References: <20240604124550.3214710-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zcmop extension for Guest/VM so add this
extension to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 864a701ef6c3..1a5637a6ea1e 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -60,6 +60,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
@@ -431,6 +432,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZCB),
 		KVM_ISA_EXT_ARR(ZCD),
 		KVM_ISA_EXT_ARR(ZCF),
+		KVM_ISA_EXT_ARR(ZCMOP),
 		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
@@ -960,6 +962,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
 KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
@@ -1021,6 +1024,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zcb,
 	&config_zcd,
 	&config_zcf,
+	&config_zcmop,
 	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
-- 
2.45.1


