Return-Path: <linux-kernel+bounces-233538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C543B91B905
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81338284C67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FDB14A609;
	Fri, 28 Jun 2024 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="loJxZlJM"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96A143881
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561129; cv=none; b=NtpIHA+yz8TcNg+95tD8ZrFKYiOrjP+69R+3eRn5Y2M8ej3zm74lMTVRZufA5NjA4kj31zn1gFYJ91aX8ds0ae/xY4A0isDRgRAqzHpFvU1jKVzG1U7AMKdHAz/9IkTHu1o665/mDRrIGOKmTgPCwPRlwxeY4yfB1YGRCdxnAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561129; c=relaxed/simple;
	bh=UYQnyeyH4ohjpyhxmQyUsjOd4jl+wfm38hnpNZUDtac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1GmhPIpTTXikWO31pI072dmhpKOlq9FIWjHR1A5mtlYbsQNEERrnI12SgZqAzO4IyDm8/5qobgkhZvqifMY9BYaNO0aPmLIknMPPjpjdjjRC94p3/oZZQGL4OhKHRrmIsB43b+Ae+ONvU6k+CNwotJOt2tJdXi62QLI2BjaFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=loJxZlJM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-701f397e8ffso202237a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719561127; x=1720165927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QTaOQgSJlRgxGe2DAtbRN63Xb4cFygQnCpr3YrplOU=;
        b=loJxZlJMUieHyNxT02kKCmi4kUOIsRKls+hJFwcSG8KL3vL80Y0mmPNp116Wl8sZJa
         DgRclrjq+bmWkWmEqkfK0ddRCvXF7fNeOg0zne+4/Wi963cXE4z0tVBHfTXXuMiHEbIf
         uYpZChYR0WePqxrRl9IUZ9NrdVTCRDhEI1Uc3ziTGSoTUCyS4hiUIRGOzZzanN1xBy5A
         tmAYJl8xSEc4ezVqIkwFgfBW3+254TnvKCZCNc7CPHCYKtCmjJICu19YhH5oslXMGYt/
         FZt7hveVKgGk8gZDcDuaKQ7IUVYHTvAxI9RCnSTJuLLv/OIm6GotT1y88TNWqFhwoj6k
         ZUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561127; x=1720165927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QTaOQgSJlRgxGe2DAtbRN63Xb4cFygQnCpr3YrplOU=;
        b=Zg+OH8g+jATK++I6t++t7DLvxSkHF5z7jIG8V4WsCCHkbanNZ4zbNvNaAVHoRsWyVu
         67XaomRjTHasyrPyN6MiGL1DBPeroMvnDOdDKrtghUZ1ssg2X0uMxCawsk6oQxPI+ypv
         c1fL3KffEM5u09GmrqDr2/HZ+8SCwkBcHWmcTFnH6i4bSUCoH22ud8bKWMdO0bYBYGOf
         JKJPp2GwC48uN4yEjFgOW+VHAGCguMZiJPUBxHxQtsaWMPbQPs00siCVb3DfkLehxgP5
         XnuXdGzY3ZbwgwiPtEzUIVSzSzGBkpdo+UC6KTEUoNNU6i8R7ruF9iC8UxIluprV2Xx+
         PNwg==
X-Forwarded-Encrypted: i=1; AJvYcCVWP/Ao2zqWCGtxqTaYBIWUn2XmfogFDK6NrXJ3551u4VwjOSdFG30mFG1cad6B1BxxGkEhApp75aAamgoqZrzUa3f6akmRVQVYw1Uz
X-Gm-Message-State: AOJu0YzWTNdJJ3Y+sixbdG4XNFBH7l1AX+/EBJuZgzfaJpWBdFKsDmj6
	evOcl2YO6P4Oi0982DJvAmBYjHdrFh2rmTaEySCSBjkyvSiq7gdpTacgEIfvMVg=
X-Google-Smtp-Source: AGHT+IE5FpdJsgBgjR00qw7HsO4MmvDOUqzWFrZg+uaxB1OldOrplMNqpPJ7b0OBtuxblj+ltyW8xw==
X-Received: by 2002:a9d:7495:0:b0:701:f1cd:350a with SMTP id 46e09a7af769-701f5874810mr3112027a34.11.1719561126989;
        Fri, 28 Jun 2024 00:52:06 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53bf2sm685068a12.2.2024.06.28.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:52:06 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Fri, 28 Jun 2024 00:51:42 -0700
Subject: [PATCH v4 2/3] drivers/perf: riscv: Reset the counter to hpmevent
 mapping while starting cpus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-misc_perf_fixes-v4-2-e01cfddcf035@rivosinc.com>
References: <20240628-misc_perf_fixes-v4-0-e01cfddcf035@rivosinc.com>
In-Reply-To: <20240628-misc_perf_fixes-v4-0-e01cfddcf035@rivosinc.com>
To: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Samuel Holland <samuel.holland@sifive.com>

Currently, we stop all the counters while a new cpu is brought online.
However, the hpmevent to counter mappings are not reset. The firmware may
have some stale encoding in their mapping structure which may lead to
undesirable results. We have not encountered such scenario though.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a2e4005e1fd0..94bc369a3454 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -762,7 +762,7 @@ static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 	 * which may include counters that are not enabled yet.
 	 */
 	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, 0, 0, 0, 0);
+		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)

-- 
2.34.1


