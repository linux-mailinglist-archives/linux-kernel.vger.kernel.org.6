Return-Path: <linux-kernel+bounces-443926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB49EFDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A35164507
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234351BD9C6;
	Thu, 12 Dec 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DDjfKFD1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A61ABECF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037021; cv=none; b=XQg8ndUGgG7VTfaZWmNsT+Ck6IfPeHlKVPiZwxK20L12dH3D5oHbBFgNRaWa5IaRva72AQsjvb8+QJBQt/rLePoMzbzt7Q9RtOMYv4NFX1S9TDQ+CfEDldSnu1gCCkRTyI8+SPwaaYTBu/KVn2ea4meHMl5brNjWLTmT+I+FCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037021; c=relaxed/simple;
	bh=STe4e+9WEqKYdCIY+5uN2OC0S3vV4Xd+VYk5Fl2odcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eALHrPdIJbt/lSjG8OiBoSkwb3vm3gmF2om6uK4ApAkqa31Gz31NcBpmpWJ2UWp+mVnJs4/5zDGP5xkviXtOTQ7O4TGJnzymt0dqHnA7ziYr2FadTvspbr03hLAs3MLBuS1j5/JRFI1bQZspxNEu2lh09fBfZ03itukmze7NAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DDjfKFD1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215770613dbso7530475ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734037019; x=1734641819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9bocf/te6xqIlX1+3PhmzweHiQ8rAPL41LYUao1zG4=;
        b=DDjfKFD1KbG1l5UEQv/eWLdfaogq7kyuXEijpz7Dm9ftgAGGKtKlA+ZyPCXnbscyji
         8+fRGF50Sa5L8+vnFRBsPCRUXNyeB0KaXiAMVzLzr3C7kfU/zogUCqvtIcBNR1IbymUX
         ziVXgdd1GbMEekEt8e6XPQCSMPMyH/ByyJH0wI1qEHgVcNdiCzUEdf2xW1lzN7YzEKmm
         rDZ/v/QYRXdOndvGew7eLcnnQ/7e5ZUB4frRxjDkoz210sDcLPVLSdmiOK8Sk50k6+a/
         7zNzBvCtfcAubuUUBvTqGKhKk3b27qmh9xRnWI3suAwBVa4Tk5BFQfG6SLH8x/60HSkA
         2kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037019; x=1734641819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9bocf/te6xqIlX1+3PhmzweHiQ8rAPL41LYUao1zG4=;
        b=OIT5QmHCG3IcPOFm9kwTNMaWKoBfVCzsOlohSegXNSPx0sZYVziEZjt43xfT1rstr9
         JHdQiZOgPo6N1GnJmMyqJoceIisSUhUSJNO3Y9eIrW8z7PwqF9cHQGR7r61/TzP9BIUZ
         DHXXHvputapzFsmQjHPBiEZjyRtawkeu9RyjFFOC2F2WnU7h3dkpx1WAehE6avSsO9JC
         9FRb7Ko1dMPy59SoAmdj4BC2Q0puUNc83kFQoEMvzVkHRAg38gQFS6grH6kzrEsJ9RBp
         6zpJlYL5dBr0n+dt76j7TdZsAlVPHvil28X9aFp/UcNozP4tQOaCQqycdfQrc0NmdsfN
         4CQw==
X-Forwarded-Encrypted: i=1; AJvYcCX2toeHZZ0i0zoDf0QisjdF2C7PNovGzV5dluE984f8Dx9qbULDLRIxfou2HAXWFYIbwoRgUSH6hCvJfkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcs7DT7yL0kWG2S43CuJwWMaPQTWQrZxZe0/kLhak11jWZy0R
	VEyVHa8tjd+ey17RF+jYRKUUXxkXmnZfMeoMV98WtSpscUUBMDr6azkpO+Dw8Bpvt8ZiH2xl/Vf
	t
X-Gm-Gg: ASbGncvm6Zh8uUtnKxmr48I5x35QmxBC/8gc/M6/+bzRKpQqmkBhdt93uxHOrz88wIQ
	+faZKoqZ8C2cRvjRFihwUhcdL85UhIfzk6ifL+ywMC/0QjD3ytkpLLOi/pPbiPsZdKRlKZFAujk
	FuaxfPD5s/W7I+CAIQjv/n52W9oteJRr98kCtBRASF4iT9yTYyIX1JUIY5UBwHA1Nv2vBL65ti2
	2Fv6AL1CyrWTBcqzjvj6rZjg8E1o5tbFl6j3LBe78Hfpe5oY1ACW6JJurAA88a1Hr+CkQ==
X-Google-Smtp-Source: AGHT+IFh1FwmitrjM9d4Q6KSLRToIyFObPTDHz3LQbh1hbARG5r4BQI4+oOsAfuzEnKREvzvjAp+Cw==
X-Received: by 2002:a17:903:32cf:b0:215:b9a7:5282 with SMTP id d9443c01a7336-218929c3a18mr2340805ad.26.1734037019285;
        Thu, 12 Dec 2024 12:56:59 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162e53798asm94019785ad.60.2024.12.12.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:56:59 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 12 Dec 2024 12:56:54 -0800
Subject: [PATCH 1/3] RISC-V: KVM: Redirect instruction access fault trap to
 guest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-kvm_guest_stat-v1-1-d1a6d0c862d5@rivosinc.com>
References: <20241212-kvm_guest_stat-v1-0-d1a6d0c862d5@rivosinc.com>
In-Reply-To: <20241212-kvm_guest_stat-v1-0-d1a6d0c862d5@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>
X-Mailer: b4 0.15-dev-13183

From: Quan Zhou <zhouquan@iscas.ac.cn>

The M-mode redirects an unhandled instruction access
fault trap back to S-mode when not delegating it to
VS-mode(hedeleg). However, KVM running in HS-mode
terminates the VS-mode software when back from M-mode.

The KVM should redirect the trap back to VS-mode, and
let VS-mode trap handler decide the next step.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 arch/riscv/kvm/vcpu_exit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index fa98e5c024b2..c9f8b2094554 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -187,6 +187,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case EXC_STORE_MISALIGNED:
 	case EXC_LOAD_ACCESS:
 	case EXC_STORE_ACCESS:
+	case EXC_INST_ACCESS:
 		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV) {
 			kvm_riscv_vcpu_trap_redirect(vcpu, trap);
 			ret = 1;

-- 
2.34.1


