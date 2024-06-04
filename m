Return-Path: <linux-kernel+bounces-200629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B18FB2A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CFC286703
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4F146A99;
	Tue,  4 Jun 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0fp3s8ST"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F61146A7F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505218; cv=none; b=tR18hkGwjxmGsSfDdsuypdaLQ38UuIHzL82PXn1/Yp8UNiWLjMWZOQjh8AzScX/vbIuFWzTYH95qXCMZ3e5VomqrZEHqZ4f9FI4zwSorwWLnR9P5bCoNcc6z/grYrpfCgmFJ/8I5IR74XuKNcIM6y/wFUBbxtwJQzAGUu08b8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505218; c=relaxed/simple;
	bh=aW8pNLZ1Jf3JaJoJsO6vnqWCLK5aM6JqJGzpfqezBLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK0pZ6qigbPKmSGz8hV4FiMZ0b+qpacLcKiHF4Hrci9TksrF66dxBCi5XSVpZy4yoazjQOt9laLOWaDj1lvWP6CTIuZqeyJrBwk6HX+diWe74p9EnbfPu/fUw4vsY1NDgFZqSi9BMI4SHlmLpBWPlFWxuaHJXYmMZzvQcSbGcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0fp3s8ST; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f61392237fso1690585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505216; x=1718110016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mFZhmlMUdGr00o3b1f1nxWnxsIbMQJnxaGpqqSRdZE=;
        b=0fp3s8STqm//Oj5YSGDrSeRKerpvJdKKP6qKz3z5cdZzab/QXXgweEpc7dnSRvETrF
         GWEY/yAq4vU1DjMNZdWVOUvhkaQRVQPlh3Z5epQnlVdza5igAne5TdfVXKb30w9NcGcK
         +SNZsA/wEJUrpJFGq0jahqlLKn86IenNNCcQSoN5ztWU5BjGZspaMfdkqv1kv4i5nMzK
         RoLCMEYIm2Itp5dvmZ3F+/AO7HdfuO9d5VEfFgdJ10N7MO8ZNy25YawtfBk08lOJo/w/
         4Ej5Enut54GZ+0E0aHx+AWL0+dEIoRd/kQz6NyLv5MCjc9CFqY8KiVojCRGfVoGVyZdT
         FMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505216; x=1718110016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mFZhmlMUdGr00o3b1f1nxWnxsIbMQJnxaGpqqSRdZE=;
        b=lm/rNh+23/bpGwWdGUKxjjL/t7KnByEDRTBVHO+AOVV6SxIL8GODxJH5bUSU0bsK10
         Wzo44JGFl7X0hW9Qq46FzBW023h38/z2U9S/Euk1LrjaatGiWSm15I6qXSnjHOaEveAb
         buAkbF9jcEPlVvmfZI8wcZZWk12wrMABXDNmAMLKP/kkaij50Nw8P8tW1yAeNJ4HwJDQ
         M6aFymMjfivEap3QE8WYROgIrSt32eQRAacb6kGEAEZWr1N85kP3uQ3Z5sQqXrFGN9Nv
         Vk++8bY+RTFy8W3KO7mvwwaQn48kw3RYv02Slq34NZLDUVwQkdedwBvS+kifN7GFprW1
         J/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWMoL/nP1VjlsBIaTCEDSMwROo8ide42jYbO5ADpJc6K8bQRZE8oTWfGIsC03MNjXomaZo8CSyWphJmVt16Jm/6akPMruH3y5Q/sB2B
X-Gm-Message-State: AOJu0YyMsbcPz6t3YcyWatO07Z6YmEKRtZWRpeJkqh0Rwi7P/d1jl9mv
	0cSs60oMIE5CB4o1lGgb6S/3TfiLNBplK4TxLiEhM+krSUyx9h5X5qZhcMt8oVQ=
X-Google-Smtp-Source: AGHT+IFM41pQHUuJV2gzPwT4wOW9apDVDvAoHL8KWfUvAyFLfhBEBPDzezVMzHLJE7/SomhB0oFg6Q==
X-Received: by 2002:a17:902:ceca:b0:1f5:e635:21e9 with SMTP id d9443c01a7336-1f636ff9877mr138756065ad.2.1717505216018;
        Tue, 04 Jun 2024 05:46:56 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:46:55 -0700 (PDT)
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
Subject: [PATCH v6 04/16] RISC-V: KVM: Allow Zimop extension for Guest/VM
Date: Tue,  4 Jun 2024 14:45:36 +0200
Message-ID: <20240604124550.3214710-5-cleger@rivosinc.com>
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

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zimop extension for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e878e7cc3978..db482ef0ae1e 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -168,6 +168,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
+	KVM_RISCV_ISA_EXT_ZIMOP,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index c676275ea0a0..09f0aa92a4da 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -61,6 +61,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZIHINTNTL),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 	KVM_ISA_EXT_ARR(ZIHPM),
+	KVM_ISA_EXT_ARR(ZIMOP),
 	KVM_ISA_EXT_ARR(ZKND),
 	KVM_ISA_EXT_ARR(ZKNE),
 	KVM_ISA_EXT_ARR(ZKNH),
@@ -143,6 +144,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_RISCV_ISA_EXT_ZIMOP:
 	case KVM_RISCV_ISA_EXT_ZKND:
 	case KVM_RISCV_ISA_EXT_ZKNE:
 	case KVM_RISCV_ISA_EXT_ZKNH:
-- 
2.45.1


