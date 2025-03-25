Return-Path: <linux-kernel+bounces-574611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67089A6E7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCE18961DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B415381A;
	Tue, 25 Mar 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vzjgsISD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BE13632B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863246; cv=none; b=a/6iIADx0ZptVzw5LhBMDrC4m+5lpR5wLjLKDa3DjPf1wqDyJbIIBeRRDntvVtB7sHLiY/9CgbCY2Yo0wpYHmmvprbY1obJWQOP0Bwza6XxkERj2UomC6dUqWsIaQB7Lk/99KMeaM+B5lTPaw2OR1za2adGPfeZwDACNrj3NJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863246; c=relaxed/simple;
	bh=UZcog3mRBfgDIVNyVqpr/WZMV5y7aYCguce1QWDBp+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sr6exaJWc8HZwSuv22uAlr+wJKTa/hGrcGnOXbOHz5y9Vuch8u5huZTXRM9n8Q9HJoTbJlOhwoAYly413ujwhABOQibb2KRQqucsGB54fBPVdPZdZ5VNhFlLAwnQGc2SJERHc0Kw1nnFwNOl3XDN7KT59fOtBckdEvBRKQUQKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vzjgsISD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22409077c06so100543205ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742863244; x=1743468044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkzfSG0KriYdqKt2ggB4CIBVtIx+E6Xmjf6eqJhLj/A=;
        b=vzjgsISDbS21tLEVJbOL79zwvgQWiJDwOw6Bw6dTInRioPpS/RdDNHDf9nsFw+8qbM
         tPQeX8boB5Ww8ueip61n7pb7t+e17uC8YQ36KA+qrso2swKeXJQdSmo00CAxqSOkCPWe
         aQjhDX/CVGQtkl0VywJcEZPsdzjdxJI/sGOyS+7GcRvU0AvXAhJzNV+16uXd2HLI0Ss7
         mv77MlF954f1/QBcnu5qBGNbh5/l1m8OC7/8WBPJ7EO3zQq04eAY1YQevcc6XyAbwfwT
         ajL/MsWhG4nWfCT1Dtl5OXF+6QKbXvpgZ/Pbj0hSYieyWV4kjg1QDblrFBD6PgUtXSXr
         yOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863244; x=1743468044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkzfSG0KriYdqKt2ggB4CIBVtIx+E6Xmjf6eqJhLj/A=;
        b=t6letyDKcK5LpJVs205uNZmFl0Eo18mSnZItrMz3ctc52jzObOX/R+RET7gBLMQcps
         FVYYqM4Iz0l8jXcnvLMNmUBER44MlVEKTGgu9OKD7W+bUSvbW/JAy3MDXfJe+g+OlFSa
         4veba9baVRIki+8C9cKxnAh2C6i1uEDNYUmK9KxrR5l4xleKRcTB+iDAtktwJz37qsFm
         VFXjcVlWnlUFfT8/zt80LQB2DWbXxX2qJnnj/coOv9mpY0a68RC53ObEXZRFEluPbEiU
         sJu7sA1vPkP7uJuQCTP/0GxNE0oqUC1/DcoD45fkGrMa7G0Jketk4li7Lonv0ZoCTlzF
         GLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpLpQW2y9YeDW73vxy1QS3dMRhddeVg5i8EjfSjg00aiWwdXqCCHsDHeYg693n8BcLI5hOdblxomGxbNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpABm28SCP3mQ60uKHARQmH4gLSAmndx88QPJWs2D3pGyoRbN
	LdtukoVpwSePm4RE2Ctjk17ldEIhPODuHCgn0ZqlT9XxSHUf062rqUozZbp9TNISmmkJIKhuLs9
	L
X-Gm-Gg: ASbGncsJYPQVQCsoQS8K4/H5wnJq1YVw0qjnoUpMmL0l1VI7JQ1What2BqN/M4m5ddG
	inTRIqzFQoyHGLaZfoeaSjQiNWQn/pHMhk+nsbKRRTgi3FtWn3H7S3SL7ajIjd4CbFXDQEN/sG3
	73OEwsmZlOhCJtJiCzVlaBEloMFPL67YocnxLmYf/ADu4kh/sGba4CTu0S9kDwBT3mN93KvMmmA
	2GYFtSiBmL1OklZceZiz5bI0K5F4mrSIJ7Sgspfftzvf1mVI31bmK7U1Z7okmd2Byl507x7XCwO
	5PkWtWtjBPL/vUsMjq+pnHvX1F3DjgT15ahDSOo3qYJ1FgvUPaQIp+EbTA==
X-Google-Smtp-Source: AGHT+IHZo9yFD5wVvlHsZ2Ob2mdY/LteNi32aWoOs7e7aKFg5g40FhjpBRzw6PFwuzSYjgzfZKYYEw==
X-Received: by 2002:a05:6a00:180c:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-739059b301fmr19822371b3a.12.1742863243652;
        Mon, 24 Mar 2025 17:40:43 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a501sm8705513b3a.79.2025.03.24.17.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:40:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 24 Mar 2025 17:40:29 -0700
Subject: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Save stval during exception handling so that it can be decoded to
figure out the details of exception type.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
 tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index 5f389166338c..f4a7d64fbe9a 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -95,6 +95,7 @@ struct ex_regs {
 	unsigned long epc;
 	unsigned long status;
 	unsigned long cause;
+	unsigned long stval;
 };
 
 #define NR_VECTORS  2
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
index aa0abd3f35bb..2884c1e8939b 100644
--- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -45,9 +45,11 @@
 	csrr  s0, CSR_SEPC
 	csrr  s1, CSR_SSTATUS
 	csrr  s2, CSR_SCAUSE
+	csrr  s3, CSR_STVAL
 	sd    s0, 248(sp)
 	sd    s1, 256(sp)
 	sd    s2, 264(sp)
+	sd    s3, 272(sp)
 .endm
 
 .macro restore_context

-- 
2.43.0


