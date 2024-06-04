Return-Path: <linux-kernel+bounces-200640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430568FB2D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E379B213F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF72149E03;
	Tue,  4 Jun 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hvU3PicD"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8C146A9A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505298; cv=none; b=S5NpNj1LFy0ywwPHw9WyJZrTAJIt9VsALgE+7GVC6TljhXwSEcL8E+bisix/JH2ycD6tRaU5ati+fnF7hZ4AWho5ZmWpu9lx4wjOPd1vv6vXktvAj2KuS09syTSY61tnlz5OKLpL9kQ2L0yyiJSJ355FJZmaoEP+hyNB5MRkw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505298; c=relaxed/simple;
	bh=aJAliq5CHA/MVkbpTKH/IWMG7oopOra0amDyV4wWYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOwqqmmgF4k+m+2dTI8tL5R/0LAqrtDNo4cVUJvAsYoX1bXH14tg/7QJpzggcMAXQ1K2qKXrWPiNNTY7HxgzF33ABTPsruEP7M8GOH45wGdqOfN/yHwNvZZlVoB3wqlRSQc4y0hfeQqBYqf1Y3psLAD5GkHxikUSfEEU2TTGQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hvU3PicD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c2d04b0833so485624a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505297; x=1718110097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl7e/Uw2TsjVm5w2UCcg19dOQoVq7golKlAiO1RXFLo=;
        b=hvU3PicDb8ENc72N536T3QiFtkaEf+n2k6QysprzcJ9RScb+0Izm/Kp+O8nBiHfV2P
         6z6yk00m+oA8XCjVyQ5k280S5Pv/RzsEQXo5fCzNqhYWg/6kZXfKD7+Vtcr+zr/6mox7
         qdjZfPeiumtYPj7AICMzX022rixJXh0hgs2k6sfPJjCjae/GrX90d9WlYmAyHB8QucWt
         5ZseqGZHGLaaFRY6Fme3V93E8xmykDqyLNECk4etFeS+lEbZy+yjV/krX0ScUcs6DgDo
         818Tk8R/ZGy4FbcXuDLrmvDUpAZTttmeBCDO0mQ9ltziN9yW3loHs6eBqrFM4zrQ/ou2
         5LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505297; x=1718110097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl7e/Uw2TsjVm5w2UCcg19dOQoVq7golKlAiO1RXFLo=;
        b=EDONYOk4wISzqml4Aw3GBbKfcuVUpURt6qCD3zWWXqYmnHlFgTiVFMBemVXu6izQU2
         MpVJDTpAhglI9fhmuzbFtyAQ4Mtqd+ZnZV0ZAncZaezNzSoAK9yXir54cvHNi88sWXTN
         SFtRtq75/S8H0kWH3iNcsgY3b3u39Dw6nosFkM0OYvyGOy3Thub3VWB+EoTyg45wx5e6
         Ak1SqK5frlKte8lbg2AQL9edhNvSuJyJ01yqH8Q9ZD8k4V6kjE1evF5eLwM+FY//6274
         GaclgsPRtrrdDuXkRVRF3vSEhqJIF8QGGeay3D3SS8xjr7JvYqeWkBdaDscsP0Dz9x+S
         FFjg==
X-Forwarded-Encrypted: i=1; AJvYcCWsjTBX25XxJf0cW8xIKgihe4s3VgROyGrdZ9C9MZ8GX2n69WfhLB5n47dd8u2C0+EY7RnJ+1iHgm75mhMkhATGiJrGBV1wV91h65cA
X-Gm-Message-State: AOJu0YyOjEzJfHxJytqacfCSR64ibCN3cLLI3GJUjv/mOSkQHRVfJ9on
	C3/Yy/8G+5VJwoA4mwwrxAb0BbnwW2KPtLsTJ9kdCgpOw4Z/tf3j6tVPGTiVyYA=
X-Google-Smtp-Source: AGHT+IHDavkX6lYzEzmyDr28AhE3WeR2xg+16B5HaBHrs9r6naCfkGg0GyGTT03skFYsojMtzKntzA==
X-Received: by 2002:a17:902:6541:b0:1f6:226f:cc50 with SMTP id d9443c01a7336-1f69425b1e5mr23526605ad.6.1717505296634;
        Tue, 04 Jun 2024 05:48:16 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:48:16 -0700 (PDT)
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
Subject: [PATCH v6 11/16] KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
Date: Tue,  4 Jun 2024 14:45:43 +0200
Message-ID: <20240604124550.3214710-12-cleger@rivosinc.com>
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

The KVM RISC-V allows Zca, Zcf, Zcd and Zcb extensions for Guest/VM so
add these extensions to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8c8b109ce3ca..864a701ef6c3 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -56,6 +56,10 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCD:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
@@ -423,6 +427,10 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZCA),
+		KVM_ISA_EXT_ARR(ZCB),
+		KVM_ISA_EXT_ARR(ZCD),
+		KVM_ISA_EXT_ARR(ZCF),
 		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
@@ -948,6 +956,10 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
 KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
@@ -1005,6 +1017,10 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zca,
+	&config_zcb,
+	&config_zcd,
+	&config_zcf,
 	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
-- 
2.45.1


