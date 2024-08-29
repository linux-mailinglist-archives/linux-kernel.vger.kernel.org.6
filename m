Return-Path: <linux-kernel+bounces-305975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A858596374B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E6B239F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099B4E1CA;
	Thu, 29 Aug 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bHuIlB/6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFF13C8FF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893332; cv=none; b=JrQZIF4C6yxKkWZN3HiFOTQzlvzs+HlMQVTMTw2J6JUXGAsU8hc77KDbSSdYB19Mi9zyMEuLqYaPt3nn7vRv6rGOThs+UKrAnUS1dWkJlcXrs7gXPjMBsMV1Ub/iwZu958cr8J5SS8D6maPVP0lnkou3mPDL4WEQOWqMPLjWFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893332; c=relaxed/simple;
	bh=/w+c93Hw/JiHQhqpwIk8i+Ew5DeNXn1I9VLrQlq8hyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXKmXcPnTAt9PdNLfE+mlBy/1OhTISNwZWk30gEQx3g0az4aHb3TFhd5CKLpTsbWcGfIMMPTAgD3jc2fKgGj4wX/Vyzy/CiEPLTp9zhbNQ8iRB9awg0IDTi1CmvdCzT07IciQn+OLv/EeGVy1xmXD1OK3pespwuysECml+EeAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bHuIlB/6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71423273c62so114866b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893330; x=1725498130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ85hK5DD6/7RMQg7pUyZ001ybckvLWjPJtkX5mnwuQ=;
        b=bHuIlB/6k59ZqDBn9JGgyWba6yxlWN2M57w3jM/W9slQIxfNAuxfj9h8S7qArZFKPy
         /VbyddsRxpEMDbOPdKM5XDVeP76H3+6uTWDbbJBWw4fk9OfErdc1YEn2mgK++d56fJu7
         u20J9fAmHKYU9nz5f8uGKNeXRwk5RVTqgvemNjygZZ6Em6HZ1CRR6FMn69hNPCj8ZkvH
         jTF7Q3Cj5EVB0Ig/mScZDsFPHMgG6WwoWyYYbxqY3ghgCemVxtwF1CfSfLjeIA1WSzhe
         UfxGyHMVyH0LYC6BNWIPfZ23fWZaVeyKamrbHIuzS88a1zjuDOvejmT9PjiyJbApqwSP
         AkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893330; x=1725498130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ85hK5DD6/7RMQg7pUyZ001ybckvLWjPJtkX5mnwuQ=;
        b=DqrJsEplDsiW4RKbdAekJRblYT0+YzMnW/wu4HtPC0p1o8/8PgPHjKv2yUccJVAUt5
         ls2ws8CISNPEDfWH0pLJhTzcE9uH185PZqffy9o2f3d5B9KUHdMd64ZvXbO5EyBzXQqn
         +D9hdg5FcREbrFRTetbdeHCLDd+L80T311wTkdw6DsIFg4v52XKeaHqvDXbrrrh/aelv
         ZegwBhP3HggsClTkPn6iaFXvAEIiaQmyuNsFyz5ShuAGwxmWhKFZv1Ydsf4YLlt80Y+z
         gcz56v88K8MhmIz/a4wIvI3/0kOgwUORsKuPgrvnNwpHqR2hM96fOfR29CfnUNkej4pQ
         d5VA==
X-Forwarded-Encrypted: i=1; AJvYcCWSE9/uPaGna5uQt/VbcCk2eI5M20HkSWYTVgY1pOKWds6DCo1NucSaknG02ewNN2H5SsSzbsjEhy99X5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7m3cmNDDZb1sY83jTNmQdw7aDi4+I9BecaieXhkLIiS4q7BSI
	hDZaUsAdWeYzPSUayDNxfalRLqTgQIfdqtsCEI/VzRu+NqUG/IeqHYX9b+moWag=
X-Google-Smtp-Source: AGHT+IHtPqetJTcS8DJjyTVqTZf+ptUYcRum3naxhEpRfuBLTylIE+8MNrQmk7y3vEqVGl/I7s74+w==
X-Received: by 2002:a05:6a20:c890:b0:1c2:8d33:af69 with SMTP id adf61e73a8af0-1cce10a3b9bmr986022637.41.1724893330253;
        Wed, 28 Aug 2024 18:02:10 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:02:09 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 10/10] KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test
Date: Wed, 28 Aug 2024 18:01:32 -0700
Message-ID: <20240829010151.2813377-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testing for the pointer masking extensions exposed to KVM guests.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8e34f7fa44e9..54ab484d0000 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -41,9 +41,11 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_I:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_M:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMNPM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
@@ -414,9 +416,11 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(I),
 		KVM_ISA_EXT_ARR(M),
 		KVM_ISA_EXT_ARR(V),
+		KVM_ISA_EXT_ARR(SMNPM),
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSCOFPMF),
+		KVM_ISA_EXT_ARR(SSNPM),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
@@ -946,8 +950,10 @@ KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
+KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
+KVM_ISA_EXT_SIMPLE_CONFIG(ssnpm, SSNPM);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
@@ -1009,8 +1015,10 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_f,
 	&config_fp_d,
 	&config_h,
+	&config_smnpm,
 	&config_smstateen,
 	&config_sscofpmf,
+	&config_ssnpm,
 	&config_sstc,
 	&config_svinval,
 	&config_svnapot,
-- 
2.45.1


