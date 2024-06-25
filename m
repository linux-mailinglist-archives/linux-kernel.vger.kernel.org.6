Return-Path: <linux-kernel+bounces-229713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C01917310
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D3284CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3D132127;
	Tue, 25 Jun 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JWbV4MEQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373C181B80
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349791; cv=none; b=jgcsIM0GPvF0644iq/Fl3yQR/QKf7XfxPNTy2z5KYFy6etCpw53xUVuEw5/1ZkfR82wxvsekp68/JD+DMObFilSvHRUmbl6G+YbKjx7eC85LP2htQnDnQQ163kh20R0OheNN8zKePkb0lnOnDV+ZpqcaVNSkW6MPZh+RJmSQDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349791; c=relaxed/simple;
	bh=TXLyzC0+V8RJB2xHJ6LNBHt7N3KLU50FXp7SipRdFQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEsciBsZuBROhlujpyLuzHaRxCBpMTl+fjtTdhVo9PEbGSANC8vZrwe104rTs6KIPkIsDygxtsJrdhYU99pXKuWHwQaW2nPp1xfugMdwASBnStSvDxmSohXm9mKL37e9zE34l/bwOC1YgB6WNlpczkzhV1y6qXav+yWv+fS2rEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JWbV4MEQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fa2ea1c443so24279195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349790; x=1719954590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfPM04Pyb/lGY9Q7saAL52HDlLyxzOizf7aq1c4K5eE=;
        b=JWbV4MEQtPTQ03u9VAp1J7oHbfnfYDAA50Tv9xKFT4B5AGqQpEHt0G1P4iNIKC63Aa
         wYjL5Z/FXgjj4xFjB8r4TToHYI+kZhYd65whlMKMf4b3LmmnT78UBtHcEhPHrJRcaDiT
         VE9LlqQ1vTT4cqi8pwDZWMm0SmdMyQnQvrUAjER/B3fISs7y3zAM8wrdwbB7cbwiPY6v
         Cj/7BI7D9uqxxYNqucsT2fOnJ0JUPyba6PY9jYWTzS/JIp8EfEeHmtp5KxuAWEmLxwqm
         vwwPdd4mR6My3wfSwhuEcrnqL2WtGZyZx9RZZN8E0x88u1e2bfDeuyNlWCZwFtIWxNSS
         RfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349790; x=1719954590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfPM04Pyb/lGY9Q7saAL52HDlLyxzOizf7aq1c4K5eE=;
        b=ektvaYzSuflB6WH9MxAOCF0/6vnentR6yTIi09G+kiilgUZy+JB2mc7IshfJsmmrYG
         chgYtwOyUj7ekXQehSz1Pi7xI2ThuTE+wdI4RqlTSfqI/5L9BsWo9W9aFD+T3r4Su1l0
         vhMrCxeskXc8Xy5sYks4QvgeK6618nXcMipH4I8zEjlvNMXuQktqjqnf9cp7PywNbgcz
         WxaiLPHXzC/6bnu3ohaLd60EVol9rNYuQBpIG2v18nSqwGoNghf/Jv25R2Le6XFE34+C
         pVVyq47D0fR1mdisayGcng6hANyTZMOrr6QHjfeR5Kjj2eyhi0RTQ7/+ZbVCoyGaM7eK
         qB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe1XS7Hi0tNFauPoMbeXgGwTWLxNBZI2OuiC/8qchuv34P13fzsQkVcGeYlF02mYVnhXxhIK+wZHqTu5KeiCoIogG2QsDZDtMtXhXw
X-Gm-Message-State: AOJu0YwrCS5+US2q7y/uTlOD0mRLU6FIl5sL33mFnge3UXBR0qR6JbCi
	++s3lYdcQ5SF8x2QOfYpfzcMwIfuiS9HQC9XrKtHigxo9CxGa6zRWG6dO+yFJNU=
X-Google-Smtp-Source: AGHT+IGeWKqd97hO0c2XIDZhD2hlaWhB/xhaoVBtqBOKtiSu9iE5NhFqVkg/azBhVzCaS3o6lABNTw==
X-Received: by 2002:a17:902:e5d2:b0:1f9:c8cc:9df4 with SMTP id d9443c01a7336-1fa23ef7f7emr98497255ad.45.1719349789879;
        Tue, 25 Jun 2024 14:09:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 08/10] riscv: hwprobe: Export the Supm ISA extension
Date: Tue, 25 Jun 2024 14:09:19 -0700
Message-ID: <20240625210933.1620802-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240625210933.1620802-1-samuel.holland@sifive.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supm is a virtual ISA extension defined in the RISC-V Pointer Masking
specification, which indicates that pointer masking is available in
U-mode. It can be provided by either Smnpm or Ssnpm, depending on which
mode the kernel runs in. Userspace should not care about this
distinction, so export Supm instead of either underlying extension.

Hide the extension if the kernel was compiled without support for
pointer masking.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fc015b452ebf..75fbefa0af26 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -207,6 +207,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE64D`: The Vector sub-extension Zve64d is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
+       defined in version 1.0.0-rc2 of the RISC-V Pointer Masking manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 7b95fadbea2a..abb7725fd71b 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -65,6 +65,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
 #define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
+#define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 42)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 83fcc939df67..b4f4b6d93c00 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -142,6 +142,9 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZFHMIN);
 			EXT_KEY(ZFA);
 		}
+
+		if (IS_ENABLED(CONFIG_RISCV_ISA_POINTER_MASKING))
+			EXT_KEY(SUPM);
 #undef EXT_KEY
 	}
 
-- 
2.44.1


