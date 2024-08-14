Return-Path: <linux-kernel+bounces-286164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72D951768
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EEC283E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0755143C6C;
	Wed, 14 Aug 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DYEnPUxS"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C7143C40
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626610; cv=none; b=J14NoRHt7TRYkP1+5i7Z5BKd2ZT8tqIQCByk/mvEEccVsx5YqZrpziihG8kO7b1qOLOsUYRr+bDu8tVVSgbd/bqWd5YLaAkET1DqXiYC7RttOmC7iU/TlltljDEmDXJemXAR9XjvVL3vBzxWP9B0yFXEUo4Y5RBnjE4hx47gVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626610; c=relaxed/simple;
	bh=H8vj+snF47a3dKn/++E0R5ZZubm/ooXr9fF2Isxx4vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZVRctDprPQix60jVlr9Tz7JIyCiu0mnZC237qPBbOv4rNK9+pLoQkXL9yc0oKWFiM9GFAslW/X8IGVLWA74ZY+kwUxfyiTHAGSI4oc46GTbCVcrfqvSeukY0ofy94Q8QwuNiog/s2pSrjhQE28cYF1NsXCBaB5DJuk3nSsiaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DYEnPUxS; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093c94435bso2379724a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723626607; x=1724231407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu1jHSLXuAowuIlG199J7T3IbhFclzyq7SeJSyjAvvk=;
        b=DYEnPUxS5QhdnZQB0vbwPpAUtrv9pvmS1JoCJ7lRUQHWG3nju5k8GW9nsvj9XSI/7G
         /SRIz1B/MkP6bTP1kIlGTjpvbL92iSuf+2gpXNRj0yDtSLyU+kfEiExNlZIzKGON6paI
         fNFKWP7+4CWHZolCM85tYvMP29iZmpEg2yJwWzjtsczS+uJJK4vin1z+WIMuwWTBMVSr
         4oDLPlixwgvuVPFdhJb0s5ZrWKjY6D7gLJBHcR2X8vOK0By1Yeb+TFW0tLgPg9a1vuNX
         iQfPyJ3mVZLp34pzqR1UogYuNb7pteTe/R45+mduy1EDP//2QponaAfLA2Q5lxQ2A6kQ
         sz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626607; x=1724231407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu1jHSLXuAowuIlG199J7T3IbhFclzyq7SeJSyjAvvk=;
        b=P6CqGd7URYIdW7RxopBr9v1yvIftJoeaflbsCP1n5cYcj+QzYcDJuN+zRsSlQpRUBE
         61RvNeUTcPc+02oVVTE7HKY0KJJbyzigLuRvI6DF6m9QDgmpTheK88YXgJMK71U3IjYf
         yWD0xKTkJr+fSmD+Nv+e6VmRLU8ofQNL3hoyYDeL5kaVelS58gmAsYUhsWWQ/9vudsv9
         lUTgj7WuCwjhexpdbetmjl+zpQVqcEqN2pWr4p1DNrHcqLUPEPycPdcZHqpTeG5nEDPg
         UcSkNStPlYWVQUZD2nKAhaqwPkQ2SEjQMQoCCZDe1dt+wyLDBKP5xmmczC8lOkhQOaby
         7hFA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ED+5BJNf2l/yRHtJQMTyLP4LRdde1elrLquXiohFfccIszWGYzkTrQGNptwPxL10LMpxYIW2Qy47NtTYUylLgbqeyWgEdpgMFKqh
X-Gm-Message-State: AOJu0YwmBJlzfMmAsFmhb5e9rldqO1I7MLV93Q0Rc3Tt9Ahg/jKjgiMf
	eINfQ94kzIO3IrBMTGGorh0q1aQj1baqXibowa37YMuk6FORDIRuTinjAHl9Hgg=
X-Google-Smtp-Source: AGHT+IHUP8SjxzYXdB9aH7HE/2FgWgwqAyUwnJC7ylng8Zw9pj5VO5tT/oMV6jtiNv7lHO2RA41KVA==
X-Received: by 2002:a05:6830:490e:b0:709:4a6e:a567 with SMTP id 46e09a7af769-70c9d933298mr2430927a34.14.1723626607602;
        Wed, 14 Aug 2024 02:10:07 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-712681419d3sm1008802b3a.13.2024.08.14.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:10:07 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Shaoqin Huang <shahuang@redhat.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Fix KASAN random tag seed initialization
Date: Wed, 14 Aug 2024 02:09:53 -0700
Message-ID: <20240814091005.969756-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kasan_init_sw_tags() is called before setup_per_cpu_areas(),
so per_cpu(prng_state, cpu) accesses the same address regardless of the
value of "cpu", and the same seed value gets copied to the percpu area
for every CPU. Fix this by moving the call to smp_prepare_boot_cpu(),
which is the first architecture hook after setup_per_cpu_areas().

Fixes: 3c9e3aa11094 ("kasan: add tag related helper functions")
Fixes: 3f41b6093823 ("kasan: fix random seed generation for tag-based mode")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm64/kernel/setup.c | 3 ---
 arch/arm64/kernel/smp.c   | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a096e2451044..b22d28ec8028 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -355,9 +355,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	smp_init_cpus();
 	smp_build_mpidr_hash();
 
-	/* Init percpu seeds for random tags after cpus are set up. */
-	kasan_init_sw_tags();
-
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
 	 * Make sure init_thread_info.ttbr0 always generates translation
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 5e18fbcee9a2..f01f0fd7b7fe 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -467,6 +467,8 @@ void __init smp_prepare_boot_cpu(void)
 		init_gic_priority_masking();
 
 	kasan_init_hw_tags();
+	/* Init percpu seeds for random tags after cpus are set up. */
+	kasan_init_sw_tags();
 }
 
 /*
-- 
2.45.1


