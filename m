Return-Path: <linux-kernel+bounces-557713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D49A5DCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC147A68A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B024292E;
	Wed, 12 Mar 2025 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxmh1xVa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2D1DEFDC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783133; cv=none; b=X2qXKPRQUdP+Gf5hx8CYgj9bR7ORvWpsQG6NeGbjt0PCpCmSDyQoLHup7VomSC6I0jBsNEacW5V1Kx91j2XFrgZ90rNIq4D06ljEKPyQjK0Uxg6O4066qNYY2mRF8qDAuuH5ju+Mg7DSK7ymkFvP0UbbZkqGtNZRc0xFhguVin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783133; c=relaxed/simple;
	bh=M8wJ7MjlXEnNUqPWq2dsIY+0Aq1U65z5dzPWoCfPV4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GOH5j1cVYgmCz4zhhTXdnOQ+WtbgizOvQE2BnF/urhspDtE6hABECyYP1Td6fnDF8JeF64cUn7OgpMqfda1STRIzzPXDx9xnmQCrPunZ4YHnQ/NLF3a3Y7UaF5GSW08AmlBvvTIlDg2L0Z3UxHxEz07l+EswzQtGkK56nXBgWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxmh1xVa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so6895535a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783130; x=1742387930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDbLUy7KRhFK/AoEDqArrp9cP2EsSfj+UKzV6i0iKUM=;
        b=dxmh1xVaWd9Lq7FscHVC+lUSOnAY/IvCsAeIU+qeZ8yww1fBU3721ZcthCTSaV99C3
         mtsI4fxuqJBl5BoxQvkPyen26axFCrq75fILsnMHsH1JqzQh9q0/5LBAajQvKYRz54vK
         NpOZm/N9E5dmXfi++5/5oOqiSOPZsThSgeAFc38QvkSr9qd91fKVrXZ/x8VQN86hAQ87
         tFG3ZHRqfZ8WPcXOnf7pH8nZhVxUU0C7tLE9hnVSZFCmJZ376ofFhOT4ZU2VYyDntYub
         TSt9w0X/PqA2taL9z8ilThnhTetE5CH3EmxztmbFwzADyMga1k0lJ3J8DwF8cY9h2v3k
         fWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783130; x=1742387930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDbLUy7KRhFK/AoEDqArrp9cP2EsSfj+UKzV6i0iKUM=;
        b=KQssnOY+pur7JU5TB+1ZiBK/gZO3QxnvDOiHaNohRiW83T2J2Buw601sfzWs8pI4TE
         Tcd+5jgWqCRZAOOEja4Zs5+JQUf+Ziuo3RwtEWFE8KA0UmqPITnC6A2RjqL/40b3UKN0
         UzwS4y1vNFNMLO1/6/QaIMFqvZt1nBtNhNXAE7wdKDY1h6J2v/xvvfR8inQ/80KCnKlB
         5wIYuiUElGYp3hHGGC7FiJvSFWqD+SjI4ylSyPqXC7VWbo1Hwo08aMyuFHtthV9/qZeC
         lOtahMrwhO5Bx+blrF8KlrnxxtTSZP6FKufQvnJt0xiWVCv6zHcVbGbi7EcwKsLUrH90
         SNBw==
X-Forwarded-Encrypted: i=1; AJvYcCXuX43Ldmw4gOOp5bfcqvsF39Ut79HEqbyPH8gwgM3wtpVjpGtjSZzCR2lia4992/dts/WHdEntBxCCvis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnHxGLMmLQN59l/vydwEOuBp083S/CXqd+HAQvZLFr8mMoIbi
	pS5a2BraH9XFelsIJZMDZdFUr4yOJ6oJ3ps+BX2991iGw3YXa+lU
X-Gm-Gg: ASbGncvEARtWJVvKb7kLniY9wjWpT4S9rH5h1eb36/Ybd88jYkjI3zGRBSHrXGQ0snu
	cYjPVJfB1kAIbSqjpxsQ3i2Nkhou7LZ2BxvKnBJcbHJ4Or/vsEHl9sFCts3op8Zh/RZVu43O6Mf
	WSJiuGF0vwQQC7LbB9yt7kqzdsVE70T3aX7Dhqt4v2CDGOePZYQaGU0Kah95dxDJxyZeRFtu1nY
	R7C5lN/whr3q/iPPEjWeWHDAUaDF33VXRG1F3o7IQZi+FUAUHasTsaZ1m7ngDYVoCni5m0z99m5
	Vl7aW/QKiI8iSH+qYd8B9Y79GYVMl4L2UOor
X-Google-Smtp-Source: AGHT+IE9TLAV7caCA2P8qjOjUAZf4qe9Rr33rrCRHTIgPDB66pDhh2erf4EFLxnA1jfDkYzDfpb9xA==
X-Received: by 2002:a05:6402:27d3:b0:5e7:8503:1a4b with SMTP id 4fb4d7f45d1cf-5e785031b65mr9514996a12.18.1741783130093;
        Wed, 12 Mar 2025 05:38:50 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f4c3sm10077100a12.14.2025.03.12.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:38:49 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 1/3] x86/hweight: Use named operands in inline asm()
Date: Wed, 12 Mar 2025 13:38:43 +0100
Message-ID: <20250312123905.149298-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v3: Split patch into three separate patches.
---
 arch/x86/include/asm/arch_hweight.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..a11bb841c434 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,9 +16,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }
@@ -44,9 +44,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
+			 : [cnt] "=" REG_OUT (res)
+			 : [val] REG_IN (w));
 
 	return res;
 }
-- 
2.48.1


