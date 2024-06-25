Return-Path: <linux-kernel+bounces-229707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4B917305
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD9F1C229F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FF17F4EE;
	Tue, 25 Jun 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dBoddAYm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E817E45E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349781; cv=none; b=Tb0AH0WhED7/1T6bof7TxV1taOn/0Pwu7k/2yuRK5uXc5VyLt45l6tnxxu7rTC7WxFPMX+J3TuaGRzQNZTeFIPMOwjHDgFZOYATYQdX1ToanFAtIh8df2t5jGbm5U6Y524+Lk5Rzgt5B/UiQjZpfNONW9Y3jTvkyjEWqY4rGBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349781; c=relaxed/simple;
	bh=EX3HFj30jYugucsdAFRT/Dn2kOPmnxMGxdjpvz0DfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0ocZwuxORUvbuveWkomu17J+tWtTG5Cckfjb1qH2WWubB++LzL0V17iVNVRzCfmcZ5f0xpx4REz88LrwSG023wo7adKjgbJFQDuL2NZ6+6Ml3vtkQiGGW1PIKzV7F2LlVjkRU+ifpnMEnDAMp+DagEqw4fmT/w7pHM47S7O5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dBoddAYm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9c2847618so50272145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349779; x=1719954579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UOSPToUyaRaOvApUAfkaCWvJhdcwWzca8vHMvSzGJQ=;
        b=dBoddAYm91DxWvm9CYuw64I6KJVCcwKy/sff3EoFR3vltTIMQ+lCbNCxouN0DBEKoT
         6FrZbFzeEPlC3JfEHhzHHC5PASDeSJpfXxRZXusbJjW2LxGlox0KEWPT4SfuDB0Rfcrv
         utg5J2fVmCy7ezvyJiK748KWvOP4CUvqe/taBMVpsGX6gPK8qG7NBRMAgCF8jaoeSnyO
         Nc6+jvpNVCRa38oQ1B5ttoFJwhonMQlbkHxy94RRiU/HDs8y/j0jlswjLB40agnMjQ9Y
         pcdKnd5F3ax5XPJrFbewk4KoYutCT3beqQg/VNBJrscjABcpZxAtOls5dhKn2zNo8Eaj
         VqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349779; x=1719954579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UOSPToUyaRaOvApUAfkaCWvJhdcwWzca8vHMvSzGJQ=;
        b=ki6Tx4e6EOoXeiZ/tdYjVwK6Uy8+GzWjpsuyW7Pu9tZt+F0Ph9oITOYhpSSAmbzmeD
         XKdT1s+b7xmG/uQMZgNHtHAawaGoSZgitlqAO+FS50IWRF6Pg2gwZ4ft0RGQUfaP3QoZ
         DvfJzGe/SCUOTMwc+Cc3EvlWEgpRHX9wdtJlftySRdyb/128Vw8Tx+hvLVK3frN3zpM/
         55TkvVEgQ3ShQey1c9Wh0iHu9C7W3uR8oGRItea5o8nwqQS8p7jwf72lLjx0eJtLe64D
         Ah7IpYDwhN0pnBu+O6qtwG73Fn2fByYM8lmCuazbkCJDz4loYdTCb1dYBfuI3S4/iJpk
         S4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUmyxprVVI8GvyAqzPiChs3BTz8ZCT1RcXSdCtj7dFVwuae9CsZ7fW5GP8ntHXDQGr9O0/rQpeQ+D8e+7k/rErFv4oOR4qhmCsXG+lY
X-Gm-Message-State: AOJu0YxTpzcpfZyfbjKxhxlebaRWbTQR3niLhdEqK6FaYeJ+zUv5ZKXx
	YrsxRxSLWkmzpVFnloar7v+wUSG9KJJPbE3PHh1og8NEJVQ40bFTViABdGjzR8Q=
X-Google-Smtp-Source: AGHT+IHAyd2tBEC0veEAkEFMqZZW11Z0zZSakCryxlScbkhfTIHyKIo9oYRvo1zUng9rMVK0IoFeJw==
X-Received: by 2002:a17:902:ecc8:b0:1f9:fc92:1b65 with SMTP id d9443c01a7336-1fa158d0cc8mr98348615ad.9.1719349779134;
        Tue, 25 Jun 2024 14:09:39 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:38 -0700 (PDT)
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
Subject: [PATCH v2 02/10] riscv: Add ISA extension parsing for pointer masking
Date: Tue, 25 Jun 2024 14:09:13 -0700
Message-ID: <20240625210933.1620802-3-samuel.holland@sifive.com>
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

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Add support for parsing each of them. Which
of these three extensions provide pointer masking support in the kernel
(SxPM) and in userspace (SUPM) depends on the kernel's privilege mode,
so provide macros to abstract this selection.

Smmpm implies the existence of the mseccfg CSR. As it is the only user
of this CSR so far, there is no need for an Xlinuxmseccfg extension.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Provide macros for the extension affecting the kernel and userspace

 arch/riscv/include/asm/hwcap.h | 7 +++++++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f64d4e98e67c..5291e08fe026 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,9 @@
 #define RISCV_ISA_EXT_ZVE64X		77
 #define RISCV_ISA_EXT_ZVE64F		78
 #define RISCV_ISA_EXT_ZVE64D		79
+#define RISCV_ISA_EXT_SMMPM		80
+#define RISCV_ISA_EXT_SMNPM		81
+#define RISCV_ISA_EXT_SSNPM		82
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -94,8 +97,12 @@
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#define RISCV_ISA_EXT_SxPM		RISCV_ISA_EXT_SMMPM
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SxPM		RISCV_ISA_EXT_SMNPM
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d3e3a865b874..b22087244856 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -339,9 +339,12 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
+	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.44.1


