Return-Path: <linux-kernel+bounces-221371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47590F294
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CA61F2657B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A515AD9B;
	Wed, 19 Jun 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kUX3t+q6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F534158DD9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811679; cv=none; b=jgJdXxkxyzU9v3mcNYjtvFLzU6UWo3lOdFsbEUdKifPswGPsyOC+OcJvUZrNxDGJbksTKsX5XIeyDXf+eTgH4fZrWdCqkwErhD0YbY1AgYc2C0IhofqQLODZsr9hbOFQVTAokrAw/Unbr0KH8sk0EV+p1r2rzp0IKJKagTkuzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811679; c=relaxed/simple;
	bh=qQty25/2IPJCkenVM9tQdvdenEgFf8HeohkJI9e0LVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM524omPJgAEHrJ+gCtz1d7X48Ejmtkdko6LposoDlSR0iC0e80C2jt9RLnr7n+veRJWbT764I+iw57GdVkraCHU8g2h9Zd50RhgMF6IX0fnVFOhxqyHh22z78CR6Dv3cNKTNCWhSWmZzUjqloHG0DHI3t1KP/M7bOSLQnvGJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kUX3t+q6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42479dece93so336275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718811676; x=1719416476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhmrjq4H2Oq8xJPevOPzXZFQ+Nl3u1sJLUiSeD49DFE=;
        b=kUX3t+q64FPwaPYM8on0dgo8kRCTnk5mx2OHX18w1EEJxk//PT9R0GXQI7sP+UW6B7
         RKmrd232eHLzOApxzDlxKlXUafQXaBAKWKVOKk/lltVZseGXtFqLU+/Nvyg1SG2kQ1D4
         lTQ01GC1r6n6Cx9Q6unb17cKFyeW2n33xuG+LWwDQ67bCQ86MzXRIY9h+CHoyJ6ai+o3
         BE4qEcwVi3iYWSR4BOSdtAploNF+4CgRXvOVFAyCNPdRwI5e3JED/P+KOUjpnY9BWUUK
         AtL/GC+hZ1dsshyXP5nZIQ+QRouScvH6hfdSiPh1gb9tmTzLyg8bkQ5rXxETXiDwiTct
         RdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811676; x=1719416476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhmrjq4H2Oq8xJPevOPzXZFQ+Nl3u1sJLUiSeD49DFE=;
        b=bmEgGGT7A3rDMecqkKq1hQZSanqnaBk0rh6AUu00mCfU2IgJombZg2fuJ4YSmFPkMQ
         0m6crda0c6AHp818STe1nCkXgErLYCRm9ZHteVgbAE0pZ2Hz4EoeEXEJxlceD71yRt5g
         Rk5DebRQbXZ2gsoUItMDRdJ9YALw5Z5Y3Q6KcHfxS+/CjFAuXkiMaBpolvpovywj59U3
         knselVNXcDvena6HeSMfhlZFE4aBhX1SOUOHn+EO6xzBpla6bI/6Wg+eVZptq/hKWivG
         hJUjg7DnOUrESHAVzF78Z6DdLTfz7Tz7A4TWRdvSAl3yaGiVgzVd6V/aG1NGtcRK19H9
         8mSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAJxkyKROT+qWk76gdR1TZO4qz356Egxzq4EVaYbpJdHG6R17ow9rq2VrNs58rEyKqgtWJnO8Ihmi4tqcIQ3ffEczuq2yy8JWtn2OI
X-Gm-Message-State: AOJu0Yya0yR3Ox8Fc9gRgE9ME4AfN0wZHV5yI8/Qpucul3jm0i781/FF
	DBgkLOAUTGApjEVxteDHyLT4y9V/EOgDUL5HKiS/3ctwUK4xemiM7tQKoo/LGME=
X-Google-Smtp-Source: AGHT+IGjwtUZf3kMWB9g1O1qJeQzBRQZ0qEbWnfWNveuCVuurscQ/RMRjo/RFMkwbrEud2Tb1Hd71w==
X-Received: by 2002:a05:600c:1d09:b0:422:2f06:92d1 with SMTP id 5b1f17b1804b1-42475296800mr18928745e9.2.1718811675796;
        Wed, 19 Jun 2024 08:41:15 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:819d:b9d2:9c2:3b7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c785sm17392292f8f.34.2024.06.19.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:41:15 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] KVM: riscv: selftests: Add Zaamo/Zalrsc extensions to get-reg-list test
Date: Wed, 19 Jun 2024 17:39:12 +0200
Message-ID: <20240619153913.867263-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619153913.867263-1-cleger@rivosinc.com>
References: <20240619153913.867263-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zaamo/Zalrsc extensions for Guest/VM so add these
extensions to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 1a5637a6ea1e..70216a1760c3 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -48,7 +48,9 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVPBMT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZAAMO:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZACAS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZALRSC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBC:
@@ -420,7 +422,9 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
+		KVM_ISA_EXT_ARR(ZAAMO),
 		KVM_ISA_EXT_ARR(ZACAS),
+		KVM_ISA_EXT_ARR(ZALRSC),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
 		KVM_ISA_EXT_ARR(ZBC),
@@ -950,7 +954,9 @@ KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
+KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
 KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
@@ -1012,7 +1018,9 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svinval,
 	&config_svnapot,
 	&config_svpbmt,
+	&config_zaamo,
 	&config_zacas,
+	&config_zalrsc,
 	&config_zba,
 	&config_zbb,
 	&config_zbc,
-- 
2.45.2


