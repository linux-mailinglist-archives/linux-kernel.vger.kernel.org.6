Return-Path: <linux-kernel+bounces-378349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0479ACEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42261F22DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7871C9EBA;
	Wed, 23 Oct 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5iJRAnV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DB1C3318
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697206; cv=none; b=XSAdAnsEG8MN5VLidMxrhhPKxyrX3oyc5d6yvP2FKbynL/7+0KPivb3qOoEfpm2krFtcP3ogPbmxSc3TLzIyTF/kh43S+pjCE7RhW+4JWxqstWj97b7Lp3xplDiRzakcaHQN++elNbnHuo6C50tGLJeO5zEnuqFThK+RZ0ExCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697206; c=relaxed/simple;
	bh=3W9iajvimea6YrR9U732pMuKRx3PZLGRnnVS589DTvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WrVWjMZtvdr0SntVCzkAxgLrSqAB7tB4rodHYM8wAv6j6oxIs1pgy2m+Fkj3R1rb3B/1wpSv3WXEIz3DLtKTQP349ffc79++/UsmFPKPNUVOcmQykuqMAurGSb+tnK3zFYV8VCMwIVkg4xPTefdojQAvHTBRZ8afR/8ioXiO2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5iJRAnV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2971589916so12014083276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697204; x=1730302004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fFBeTk/ypl/mbwDh0gs/JhAq5wRwgc/prGa+mqCvt5o=;
        b=c5iJRAnV3Fi4lYXeoXbKQPKWwovOzhYCc7sZo9bpxAhvPLbExgqWjK/KFIIiKQAuBU
         cls+xavghVNYuH1042htv/kbU2HgDQT07ozuJ6M3fFAdqT8s6OE7z+iLVixM5oGa8ADJ
         pIoRkf5fIbv1l7Ot/HWh36gR8vPw0b1kpmYi78aa+/ONsNBRXWe2gqwjWzX3Ov6ER02J
         WamC9Fuc/rTkgOqRjcLJIpbzoiBPXocjThvzeRKc8PeneZyreuX22clYk8US5MYuSxkB
         97tKfUIQv1xo1BIWOm38vuPNnSzeWnsfa8y3wlrdt0jBfsu2NxeXsl+xKTGgbBRJlUlc
         OgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697204; x=1730302004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFBeTk/ypl/mbwDh0gs/JhAq5wRwgc/prGa+mqCvt5o=;
        b=JoYGUcqM8extbMHHevnekKkcWl8d7PDVk+8YRsWqFVDjMpIhgJlJ6x3RfHnpwTChaf
         wh5X8mYKpn28mWuwkXfhjyidMJHIIM99DYB7mVOzjjTkeafG/st3y3T6cG5PJzvY03Hf
         zEORSCzstt4NrvM5pTmGOEjtGx/VqHsjgDUUOfEoSvjvPCDEWmP8Go6i1ZhwkWHH1Ycs
         k8goIf673G3r545cqbPOfNAWqD/Dff7vjxQ3S5Ir/ce0GF0IOoZvsNRPeIhQ7bmQRBIW
         WDdiwSJ2XIjkdWuexX/gnI8YoghfAOI9aK7nOcaodsEPlrz9+C459ZSsyhp6q4EiSRz3
         H03w==
X-Forwarded-Encrypted: i=1; AJvYcCVkaikbT5Sn+N3RW8mUswKvw3asye1fb6mHUGjNQ1DORvvc+Ev16JpXuVVhdgKxuxuxJBvuYC8sKfueWZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8/QlbVQ1TwvKrzIpfZl1FXuEt8UpmNWgm2c1DKXTJeyA5pxE
	gDGvw9baSEq5+Gp+jQI4wrgNSZO+bXOmu15r/4Q9mA32cTXA1yJLa8uk0rlNgBTvGJ5PyN6ZenK
	ti7p7AQ==
X-Google-Smtp-Source: AGHT+IFh0UYQGtbCtvsET0xrrd1Y/kAJ4FbXvNEzhh8lcJJcZvj2pTt+HaP9rNqWRxjhbRVfontBWLjAHjHZ
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fac1])
 (user=rananta job=sendgmr) by 2002:a25:acce:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e2e3a5f5d18mr1688276.1.1729697204137; Wed, 23 Oct 2024 08:26:44
 -0700 (PDT)
Date: Wed, 23 Oct 2024 15:26:36 +0000
In-Reply-To: <20241023152638.3317648-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023152638.3317648-1-rananta@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023152638.3317648-3-rananta@google.com>
Subject: [kvm-unit-tests PATCH v2 2/4] arm: fpu: Convert 'q' registers to 'v'
 to satisfy clang
From: Raghavendra Rao Ananta <rananta@google.com>
To: Subhasish Ghosh <subhasish.ghosh@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Andrew Jones <andrew.jones@linux.dev>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Raghavendra Rao Anata <rananta@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clang doesn't seem to support 'q' register notation in the clobbered
list, and hence throws the following error:

arm/fpu.c:235:3: error: unknown register name 'q0' in asm
                fpu_reg_read(outdata);
                ^
arm/fpu.c:59:10: note: expanded from macro 'fpu_reg_read'
                     : "q0", "q1", "q2", "q3",          \
                       ^
arm/fpu.c:281:3: error: unknown register name 'q0' in asm
                fpu_reg_write(*indata);
                ^
arm/fpu.c:92:10: note: expanded from macro 'fpu_reg_write'
                     : "q0", "q1", "q2", "q3",          \
                       ^
2 errors generated.

Hence, replace 'q' with 'v' registers for the clobbered list.

Fixes: d47d370c8f ("arm: Add test for FPU/SIMD context save/restore")
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arm/fpu.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arm/fpu.c b/arm/fpu.c
index edbd9a94..587b6ea3 100644
--- a/arm/fpu.c
+++ b/arm/fpu.c
@@ -56,16 +56,16 @@ static inline bool arch_collect_entropy(uint64_t *random)
 		     "stp q30, q31, [%0], #32\n\t"	\
 		     : "=r" (__val)			\
 		     :					\
-		     : "q0", "q1", "q2", "q3",		\
-			"q4", "q5", "q6", "q7",		\
-			"q8", "q9", "q10", "q11",	\
-			"q12", "q13", "q14",		\
-			"q15", "q16", "q17",		\
-			"q18", "q19", "q20",		\
-			"q21", "q22", "q23",		\
-			"q24", "q25", "q26",		\
-			"q27", "q28", "q29",		\
-			"q30", "q31", "memory");	\
+		     : "v0", "v1", "v2", "v3",		\
+			"v4", "v5", "v6", "v7",		\
+			"v8", "v9", "v10", "v11",	\
+			"v12", "v13", "v14",		\
+			"v15", "v16", "v17",		\
+			"v18", "v19", "v20",		\
+			"v21", "v22", "v23",		\
+			"v24", "v25", "v26",		\
+			"v27", "v28", "v29",		\
+			"v30", "v31", "memory");	\
 })
 
 #define fpu_reg_write(val)				\
@@ -89,16 +89,16 @@ do {							\
 		     "ldp q30, q31, [%0], #32\n\t"	\
 		     :					\
 		     : "r" (__val)			\
-		     : "q0", "q1", "q2", "q3",		\
-			"q4", "q5", "q6", "q7",		\
-			"q8", "q9", "q10", "q11",	\
-			"q12", "q13", "q14",		\
-			"q15", "q16", "q17",		\
-			"q18", "q19", "q20",		\
-			"q21", "q22", "q23",		\
-			"q24", "q25", "q26",		\
-			"q27", "q28", "q29",		\
-			"q30", "q31", "memory");	\
+		     : "v0", "v1", "v2", "v3",		\
+			"v4", "v5", "v6", "v7",		\
+			"v8", "v9", "v10", "v11",	\
+			"v12", "v13", "v14",		\
+			"v15", "v16", "v17",		\
+			"v18", "v19", "v20",		\
+			"v21", "v22", "v23",		\
+			"v24", "v25", "v26",		\
+			"v27", "v28", "v29",		\
+			"v30", "v31", "memory");	\
 } while (0)
 
 #ifdef CC_HAS_SVE
-- 
2.47.0.105.g07ac214952-goog


