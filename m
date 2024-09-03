Return-Path: <linux-kernel+bounces-313935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF096AC89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8301B22203
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE61B9844;
	Tue,  3 Sep 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l3WPnQTM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235491EC01E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403962; cv=none; b=Z5xQwRTbL7MQfzF5ucgAnVT7BJXM9j6pvLatCqqL2XefAyiVKjsEjokI4pjjQcMCyL4yNB+jmcgigm1pHrBQbCfL8yMhIKUx5GFszdJ9myBVl6Yo6iCJ8vZBG6K8yM6nJMYt/2d5R4j2otcsFwkRNJ8Tf0prsFoo4uKc7q3eLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403962; c=relaxed/simple;
	bh=CB8edBfcGqRK+ymTERIGqlxIoQY7nhBdPrqLUxfx3VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E51YmW+M1K6wOWHIa5SZbQ/jbUmSiqXzCQ90WO/jgPdF+sRzCbASaGWCDaejl5sMmuG31nHfWeaDBjPHukt+1SD1jbdA+/R18F5pVm0b0GYX3hGBwae+ZL96uiV7yBpp+KcjxOk+4RD72fNaiBdSGzppMHwaHbOsqQP0OwVlsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l3WPnQTM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055136b612so32715415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725403959; x=1726008759; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ53qy9u+Z9FvKtKiYbSHpKJar2Bzy6zkKwdYDcaxRI=;
        b=l3WPnQTMzHPQY/AkBRmM7tibwchGfRGtq+2YMYDaIxSJ8Wibe6DZozqhTYc8q+VNGj
         8G7xyjKhwHT8Bwg7Gfve5T+xU2c9fr24qd2lLhg0Y/+6zEPWDJAGr2rpij9xmHMPT3xU
         gWZQhFkaxxqoB48a+D15aMDUU+119SmxdoypqzvYYCUqKMqH8Y1c5szLsEaYI9+B6Stk
         oqouEDpWWQXONyhOBUZ6tkc6AXHqr2St1BZ36nY3x8hie4YyTxcm/yiY3a1RpkMWDXoq
         6kulZCnG8DUKSML4r0/jd1NJoySXFgbiu6SeHDP5+jA6gjIQ0Q3yiVNiG8VSsID7ouCp
         mDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403959; x=1726008759;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ53qy9u+Z9FvKtKiYbSHpKJar2Bzy6zkKwdYDcaxRI=;
        b=R+Zw9/DxLcZrx6ZroHOGtTFFqb/l+qKWI1K2YmP1GNK9aMfBdUByN7qK5OHqjikkgp
         /l3sIiQ5ML5UnvqF6mX4b+q3bz5OCZngFwe/f8gxbZAfydXxygGhzecpLAskcV+l2+WY
         YWhOkYnUiErmvgW8I9QN1/gSkX0Guq6LQalVPrpy8g4e7P4znaxmtoiCOO4MCT/IIUvW
         VJKXAhAlZ3n/wD7dJeHmMbe2HlclBJwJJ1QbS4lkLdmIj5olvtzp9jaIWtWWooVChTMD
         G5Q86oi11FqLi0CMcgsFWa4t2JQ4HBJkjpqbmXcxBLNIuGSJ41EkuCQb9EouNDhKxCBH
         uTYA==
X-Forwarded-Encrypted: i=1; AJvYcCVb+qjlDIcQ+D9YIyhcXlPAD0bFjpueu5szOBbQpVx4HhMFwb0VO1LFtt9NHqKEZ0OH9NatLn7rKpVbS9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cTjZnm+rOREfxyxKx0/uDx/L0Xd2ToJR9VmlhS9gMi/qMukt
	mcPn8c58zZdCk3s19URjSaigoNOTAI6vPlhUewyvpn1p1D+nON44hoBAgC3cf4bSdbjpIfW/J52
	7
X-Google-Smtp-Source: AGHT+IF8A15Mix+1zHN6ImpXiusw6agLPCqjlEwFi3BIL+tJMr9zxAN5hukYaaXfepI3wzeUzgOC7A==
X-Received: by 2002:a17:903:32cb:b0:205:88ca:9e24 with SMTP id d9443c01a7336-20588caa05cmr93509755ad.19.1725403959355;
        Tue, 03 Sep 2024 15:52:39 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b24sm3207605ad.12.2024.09.03.15.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:52:38 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 03 Sep 2024 15:52:34 -0700
Subject: [PATCH v2] riscv: Disable preemption while handling
 PR_RISCV_CTX_SW_FENCEI_OFF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-fix_fencei_optimization-v2-1-8025f20171fc@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADGT12YC/x2MQQqAMAzAviI9O6hVQfyKiIzZaQ9O2URE2d8tH
 gNJXkgchRP0xQuRL0myBwUqC3CrDQsbmZWBkBrsKjJe7slzcCzTfpyyyWNPbUztu8o6QmyxBa2
 PyKr+52HM+QPabkXyaQAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2866; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=CB8edBfcGqRK+ymTERIGqlxIoQY7nhBdPrqLUxfx3VM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9r1yabsibc2PpC8Fz5lTtuBLqdHkUsXmhe4vWxTtzHuP
 29Zx2bdUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQWqzP8M2FReK927GdObf7r
 u1d334+5mrFDaUvYztKb1VysFgs9NjEyvPF5wKlToPzt8vy12h8ZDXZUfJ5zeYUS9/7LL77yev0
 24gcA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The icache will be flushed in switch_to() if force_icache_flush is true,
or in flush_icache_deferred() if icache_stale_mask is set. Between
setting force_icache_flush to false and calculating the new
icache_stale_mask, preemption needs to be disabled. There are two
reasons for this:

1. If CPU migration happens between force_icache_flush = false, and the
   icache_stale_mask is set, an icache flush will not be emitted.
2. smp_processor_id() is used in set_icache_stale_mask() to mark the
   current CPU as not needing another flush since a flush will have
   happened either by userspace or by the kernel when performing the
   migration. smp_processor_id() is currently called twice with preemption
   enabled which causes a race condition. It allows
   icache_stale_mask to be populated with inconsistent CPU ids.

Resolve these two issues by setting the icache_stale_mask before setting
force_icache_flush to false, and using get_cpu()/put_cpu() to obtain the
smp_processor_id().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6b9391b581fd ("riscv: Include riscv_set_icache_flush_ctx prctl")
---
Changes in v2:
- This patch has been  split into a different series from the other
  patch in the v1. This patch is unchanged.
---
 arch/riscv/mm/cacheflush.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index a03c994eed3b..b81672729887 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -158,6 +158,7 @@ void __init riscv_init_cbo_blocksizes(void)
 #ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
+	int cpu = get_cpu();
 	cpumask_t *mask;
 	bool stale_cpu;
 
@@ -168,10 +169,11 @@ static void set_icache_stale_mask(void)
 	 * concurrently on different harts.
 	 */
 	mask = &current->mm->context.icache_stale_mask;
-	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
+	stale_cpu = cpumask_test_cpu(cpu, mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+	cpumask_assign_cpu(cpu, mask, stale_cpu);
+	put_cpu();
 }
 #endif
 
@@ -239,14 +241,12 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 	case PR_RISCV_CTX_SW_FENCEI_OFF:
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
-			current->mm->context.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->mm->context.force_icache_flush = false;
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
-			current->thread.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->thread.force_icache_flush = false;
 			break;
 		default:
 			return -EINVAL;

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240812-fix_fencei_optimization-3f81ac200505
-- 
- Charlie


