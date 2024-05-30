Return-Path: <linux-kernel+bounces-195667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64C8D5007
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE03285B45
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6942B9AA;
	Thu, 30 May 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RMbYVeyh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60263187576
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087512; cv=none; b=unFfpG717grYaOB5QA8uQPwtwa+Z9cEcYKdmHfwQTDIhBjeNHkQHFA68kSR8eeAUpM0mdiW/thCi1/wpkWJw3GTkRXpeI1E0rlmHV0tQ/K0qDp3NPMY3lUtJKPHY4dAmH6Vo0tuHrzL5l40rPXJrM6kpgCrlFvaq3Z5HfGLFyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087512; c=relaxed/simple;
	bh=jaOnjIsa3zYdoKF/Q2lphz2sDuejOa+Pdpx933cy7jc=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=FHffwSQrbBT6Ga3sJs1XjA/V1+vXGcOYS3SW7r84dDwArdImD8QNt2eC4MWtyC2FExd+yPVTHLYwuFY2cqFXhbgCejeGQXLewJRpADwZCfDMV8GU3q+ozTHPjaDdMQ2w2RU5F/ZP4aCkmKjnuuENh3zLYqs5FPqWN7vIUPPByFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RMbYVeyh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d0fso8926035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717087509; x=1717692309; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=xOzegM0vd+pENLEU3lhD32Gn7D6Mcf1VzkpF3e85750=;
        b=RMbYVeyhzSK6PKZ834f39L3+SXK7+TailuwHAfaaKm60Jf87DjEXeviIgscmCmwr32
         Tya/oNqlJV1xWbuu9a72UomeJOTyC5DV0qYE+QUcABTGmWSrc98mSFiT4EUh/4As0Qj/
         5pEHNhklkKiLGNqrGQAqzrbr/lpeEYJPrHr9Z2JJLuRkiErodvXuzgWuKEE8EFSgVMOL
         cggnGNQMW71gjpHtheX5bt1jO8UOzaGV4pReihaLKaBabsCPxq3mxonNlKSPgcix2DhB
         5lg3B3WIWYxsMHq85eXJiddCVEOUeC3yUcFLTTmV7GdvckW83N9VlirKXLRuk/UdDILT
         FVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087509; x=1717692309;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOzegM0vd+pENLEU3lhD32Gn7D6Mcf1VzkpF3e85750=;
        b=YDo2pq0cQq0YAN/JN6RD3VlgxQtzygQnW0d5TzfASTM2+hLqluhDNnN5qlvihJ6C4o
         WJ438RFb85avMCV0s47HFjJF6YvcPdXeekXZQjDN5iuJtvE/mTVS6XsxmzgXcSr94Q4+
         uWXy9hRncT32n0NEeIiL5VcAjJN4zJwTmtgWLAusIZeCfDgOpMN/RWyudIPQCEaMM9jk
         N/DHn9YCWxK9Yl0cpLqkeaIa8+7Z2qBsQuihiYBMBbh1DOzpT4WpW6ZjKKQTc5LOTtCz
         O3skeopG1WRkhVJqF/442ajeAbV/qQCARds0v9eYb6C93aMCG3EIf+yXLhKx32WXeYxc
         Q7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUdpQrq8Og4Sfuq+/1EyYnw0lO1096t0v1oZRhi37HemPwwwDMVWtPHwA0mwJFS6dgP+knbE9TzElGRf6Uz79AcDI+P8D/GahGpPvz
X-Gm-Message-State: AOJu0YwKLIusQvuwJmaSfIu89B1T/rqcUKEXNGCEGXwNEcUt47PcyODc
	RjcyLZ7jR9CRXu1hShW9tElVcO5cJc8bYN7L5I5HI57Qr53ncq4XiDfbRSvtMAs=
X-Google-Smtp-Source: AGHT+IF5ZCUTHA4RbuWZrUM95v4mHrXe0BsCSWZE2Kc+Ge5l/lR0EiQ15vA/YZsp2wheVERfoRTC2Q==
X-Received: by 2002:a17:902:cec3:b0:1f4:8190:33c3 with SMTP id d9443c01a7336-1f61962ed55mr31844515ad.40.1717087509402;
        Thu, 30 May 2024 09:45:09 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6312b1fd5sm472665ad.172.2024.05.30.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:45:09 -0700 (PDT)
Subject: [PATCH] Revert "riscv: mm: accelerate pagefault when badaccess"
Date: Thu, 30 May 2024 09:44:51 -0700
Message-ID: <20240530164451.21336-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
  aou@eecs.berkeley.edu, surenb@google.com, akpm@linux-foundation.org, alexghiti@rivosinc.com,
  wangkefeng.wang@huawei.com, jszhang@kernel.org, ben@decadent.org.uk, Bjorn Topel <bjorn@rivosinc.com>,
  willy@infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I accidentally picked up an earlier version of this patch, which had
already landed via mm.  The patch  I picked up contains a bug, which I
kept as I thought it was a fix.  So let's just revert it.

This reverts commit 4c6c0020427a4547845a83f7e4d6085e16c3e24f.

Fixes: 4c6c0020427a ("riscv: mm: accelerate pagefault when badaccess")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index b3fcf7d67efb..5224f3733802 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -293,8 +293,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
-		tsk->thread.bad_cause = SEGV_ACCERR;
-		bad_area_nosemaphore(regs, code, addr);
+		tsk->thread.bad_cause = cause;
+		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
 		return;
 	}
 
-- 
2.45.1


