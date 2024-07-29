Return-Path: <linux-kernel+bounces-266429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCDF93FFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C441F22509
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667418D4A1;
	Mon, 29 Jul 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IW+NTzJG"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECF18732C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286247; cv=none; b=YmT/tqajEsP6WuBjFESnRSlQedJxWFNF+aZnB4j5N6AIV8BjbEwgpbC8Rn2I2pIbShVaJhkEI+ZCDJYAgCiuVOm1cbCsPsOVvqaxPTdJEnL8bpM/S6EWVvtgohDcham6edlG4AZ7kg2MEWBpjyiho9tJclGgD+AMQFi5Ao9XtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286247; c=relaxed/simple;
	bh=vkgW6uSkTrdq/a10IhVcXIlyy7ZpLz6+wi4VUooJ/G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hb+M5gpgm4Tz0NSMkYfWsvIbh3obJbp7kwpTtCrkaGLtZB8kh4LlGA7mSgk24xwJhBaC5F9RGl3wT+x6is27hvEmQisp+VE5o3mvYJISal+j6RjUld1e/P22oGvyOAARQiccfatV/NguYB/5vp+9bSBXjHll32Wbaj2Ll/Mfz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IW+NTzJG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so2568751a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286245; x=1722891045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YALcHE45yFBd6B8M2GwV44w9Qj1q3iq9UvV9zldTY8s=;
        b=IW+NTzJGNS66CMEy2hxtmCVsFofHYJr9VBwBe7hT2eBx/fanQXB6iOyG6QV+NNgiYy
         tplw7RNiCELwI8viif7oBZgatlw2fvolPGBPgFaNcuGLLWY7bs0yHNcGr/puFeZSDrVL
         QUYfDxdDpgBYa8SxQ2RjRcaJyv3nSc0tGjENG+7PaET4ut3Jde1NEPQGnWzSkdmCIioC
         qYDHhqwyEWQRsZOt7Br782lr8ovWOVSxuKawc/ETESmwEalCzVoktq2RVVEgHHwJDkR1
         UQaQYMCsw7OV7vWR5ODJtRxw6aUOxZYIia/Qy+DrxuEnuWXo1wnZksSuliqt7ufxsTh1
         KBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286245; x=1722891045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YALcHE45yFBd6B8M2GwV44w9Qj1q3iq9UvV9zldTY8s=;
        b=fN5i/ygU8/cb6HGNUpIIo+VGPeCKA/oVFlqb4GKTuUpw2L9v3MKzVA8D4ipwKEe43F
         Eu0d0rM4oEAFywtzoC13I+WdPu1cBfRvBHAjIlEqeTSaP7/6CDJVfibPAGF+vHdx2Afs
         O6wqgQW3DeWfhD7nkfJj/DqGbp/4U9mNOHyyGvrWl0BLPjd9CtsyMRz3fEDkKCMyc+Mw
         DAzCqbijRdKSaoRv4OlxjVTOKhQvvvVeEYgsqp3nzrmIT2u1velj+K+f5FP9f/T9a/ki
         TNW+cB68EIdlwyVVZycUApi17MadpxvRGoyXOPMCqjnCBNc2B8Xex39EU1l8BNrBIsIw
         vxiQ==
X-Gm-Message-State: AOJu0YyH3Fvpdn/mrxhPj/aU6X+nI+usPRFqiCbqgiiX4KEc64Tzx/3d
	zhDaSfR+vPCodL4cOCoJxb03IWvVr5AF2mFtDNLJk6DqHTNUPT9m54NSy6mTCj4=
X-Google-Smtp-Source: AGHT+IEDXOv0oX/69rDFZ/8mFt51Yof+gUeyqD/AVuJdZ/wo3n5UfYRR5ZPswAmeUMRaOEdviGizbA==
X-Received: by 2002:a05:6a20:9f89:b0:1c4:d4b2:ffe5 with SMTP id adf61e73a8af0-1c4d4b30374mr3193080637.54.1722286244829;
        Mon, 29 Jul 2024 13:50:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ba2csm7454541b3a.93.2024.07.29.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:50:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 13:50:36 -0700
Subject: [PATCH 2/2] tools: Optimize ring buffer for riscv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-optimize_ring_buffer_read_riscv-v1-2-6bbc0f2434ee@rivosinc.com>
References: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
In-Reply-To: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286240; l=920;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=vkgW6uSkTrdq/a10IhVcXIlyy7ZpLz6+wi4VUooJ/G4=;
 b=6aHzlAFODxv03rehQH+ihSsrMnz7sWZc1A11YVvX3P66jucVnPCsnJUrMqSjNfcAEEr1HsL4F
 h1j5DqJJcehCOzZfRMxGWt+WNuh5aB190ykVgIfGSl6pAtDILpmMnaI
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Now that riscv supports optimized barriers, use them in the ring buffer.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/include/linux/ring_buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/ring_buffer.h b/tools/include/linux/ring_buffer.h
index 6c02617377c2..a74c397359c7 100644
--- a/tools/include/linux/ring_buffer.h
+++ b/tools/include/linux/ring_buffer.h
@@ -55,7 +55,7 @@ static inline u64 ring_buffer_read_head(struct perf_event_mmap_page *base)
  * READ_ONCE() + smp_mb() pair.
  */
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
-    defined(__ia64__) || defined(__sparc__) && defined(__arch64__)
+    defined(__ia64__) || defined(__sparc__) && defined(__arch64__) || defined(__riscv)
 	return smp_load_acquire(&base->data_head);
 #else
 	u64 head = READ_ONCE(base->data_head);

-- 
2.44.0


