Return-Path: <linux-kernel+bounces-182255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C98C88D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8EE28744F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD56BB26;
	Fri, 17 May 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WmM058JE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AF6A353
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957619; cv=none; b=ZG29BTNmSqFHISVpsVG7M1C0MPZVLPpZs2MAcSRhdPWrprQwH+S21PEJvUE1scRXyWayiUsHETo8bm4+vjkVMzD8IQ5CcT5gdf6zJa3/Fr8xOSCZYCUdbJj4Ucx1r84vh/st9tOADcMjdWiDPatL2CIHIBAoZFTPYNzBiQnrUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957619; c=relaxed/simple;
	bh=EGRDfMh2SVfhcOaGJVOkgRqDiFwCscmPw9tcW5SPCcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4Utor5MaqDh/SOYMT9myy4pUqHmBGIvXqMFR4L5tFSOuOPIe5f1ng1SKec3wAjW/+LZmHPZBiFT4UNzX3H3An/4SQJ6QRGznMPWOOEEPmvq5NHDWXwCXQoPMdw4iONscrNxjqnqwLvFtAwb5RbJ/Qi5dknIMO6hEA9iCK4ddKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WmM058JE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-351cb099fd7so39750f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715957616; x=1716562416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9KC0tuSdit7TUVEzTpSp24//kOo0UeQXa0Z7JvTEow=;
        b=WmM058JEtw06IAtBA0tIQ/Yj40FoneIqCaX2MaeHFCKClC7N+TuNLpUc0hOkopwqMZ
         iRvQp1AnzXT1UUn+e69T9kgw+vCckNosyKEvLozEWBPkRJFwQoJK9ZL3LSzOwVHIRNm+
         jsjXCKPlpPn1+8ToR690p/53ozNAbNV5b0qI40Qxj5RKnen72D2wC6cvgNxS6olatwA4
         xoutzhOh+QMnpUUods4vP8/N5/28/JQnTziV8vFinyFmhNXgYLBPLN+amKzGlJWICbqU
         l3Zuq82vSudOgyICFy8syffO0S7DloHK0IV3ipkUQnqyJ3g2yf55Mk/vuKI7iEhcnf5G
         32LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957616; x=1716562416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9KC0tuSdit7TUVEzTpSp24//kOo0UeQXa0Z7JvTEow=;
        b=rnI/9QZ5g4NtrDFyeTqWO0alBMEkHSmSLuV2xHjbe6DcEGfu5KOFAqDdtNt8wBYMu9
         DQztpgWicgf0RDhArncfbK06OTmVobfm9FybnsMtiSGY2EhUGBVSSzOr3vV88yUJuzmn
         kDgXa8EcdkgMjbbp2P2pYTdk0tm5t9/suD8F7uyJj43P6abunz9CwEYhtFy4dI2deNKa
         yRlbGTWyHcyVGGLzuoG0aw5k8+ibtYffsVY17q7gQ2Ik0vgQPYibATuuS4lWJGErZIyK
         DzSSlIrfspX5HgvaT2n+XfRpg3xFZoSH/slFlm754LwcsG59cBzBeL6ZQYrr2wpnuSEw
         LZqg==
X-Forwarded-Encrypted: i=1; AJvYcCVE/y42WUGRFXpkQvVb2PQsYs2S3G+1kobdbX5d1SQdj5Qw2ZBRUzzRG0KqxkpuWvhmYMLY07qj22/Ao/ztlvD43og24EuVHDotjhQs
X-Gm-Message-State: AOJu0Yz4coW1oYw+5sWx+c+/GE7H1Ytw92/opyxjQ/MBT5yXE0wPiHBa
	+CLpsuYaQ9fIssbsf7cRPaYiA6/5bwNMkFXn1Q6xSuEV6xxjpeq5vLqJvLFa3Ak=
X-Google-Smtp-Source: AGHT+IHzMauOaObmH6bJHd+GEHQtwrBkXzklFT3v/zPDqrR2YcC6kkpEK8DoADrBqc2G886rfeUyUA==
X-Received: by 2002:a05:600c:3b26:b0:41f:cfe6:3646 with SMTP id 5b1f17b1804b1-41fead6b0f6mr159820025e9.4.1715957615814;
        Fri, 17 May 2024 07:53:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:46f0:3724:aa77:c1f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9431sm301723695e9.28.2024.05.17.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:53:35 -0700 (PDT)
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
Subject: [PATCH v5 15/16] RISC-V: KVM: Allow Zcmop extension for Guest/VM
Date: Fri, 17 May 2024 16:52:55 +0200
Message-ID: <20240517145302.971019-16-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517145302.971019-1-cleger@rivosinc.com>
References: <20240517145302.971019-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zcmop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 57db3fea679f..0366389a0bae 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -172,6 +172,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCB,
 	KVM_RISCV_ISA_EXT_ZCD,
 	KVM_RISCV_ISA_EXT_ZCF,
+	KVM_RISCV_ISA_EXT_ZCMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 7d47fc910bd9..af4fefa189af 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -52,6 +52,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZCB),
 	KVM_ISA_EXT_ARR(ZCD),
 	KVM_ISA_EXT_ARR(ZCF),
+	KVM_ISA_EXT_ARR(ZCMOP),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -136,6 +137,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZCB:
 	case KVM_RISCV_ISA_EXT_ZCD:
 	case KVM_RISCV_ISA_EXT_ZCF:
+	case KVM_RISCV_ISA_EXT_ZCMOP:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.43.0


