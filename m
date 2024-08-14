Return-Path: <linux-kernel+bounces-286092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8398951662
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FA01C21657
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551C14AD20;
	Wed, 14 Aug 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zt0JGd+l"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCD149E17
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623294; cv=none; b=DvsmvwfyfwfBoljOgr/B8D16aIHqj3AvAFmJhCUrz3qrs/55yBFqA16fHv3UtlGHpbJjYUw9getLZTsu3a9fxExzyRoGjbBdbHvkN6oqFxzeE5NYs8o0U1J2/WQz+hm4jfFaLO91xoAoxVsVOfldWjtHsQcI4Gztqlypheb2o1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623294; c=relaxed/simple;
	bh=+scFAUbZj8sK364kS3132r0hQe6Ylfl4c9kSHDThWLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBfAhe4kt7i5s5FLIX1dIyjqoL0ijgdJWB0JBGCKk1lOZ6wRif7HyPazIJztdkogRr2IlQG7Dtan/okfZRVKKTb+TYNmfusGKMc/Os9+b6uoyIniFCQeBd0o4oKjMTdvTx7NBm4WvEkyqHeq4U55oaw911DloqSOVn0CKGtNTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Zt0JGd+l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201cd78c6a3so13811215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723623292; x=1724228092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fidSIArz80o0wKmWpcFbdk3lLWLuSUf3Uv0hxlg4FbY=;
        b=Zt0JGd+lJWextR7fsWn2DTl8ZxLvOuopckZGcAUpM55Dw4hNMAeuiPeLONXiRJ1aSb
         di+/T2vKBE/Q/HlgErcmjaDts+CH9t1KIECZUVXaTSTGLvcOtwHxiAoxU6w9GNK06pDE
         3/tHqpwVW0wuCtAQugPXuQDj8wcYgPzITmLw1OK3z3Fa+5kl8h5Hwd8Kqy3Blh2jPEzu
         BNVOXIB8hqkiDRMkWgqnxo5vti0SFBRd/b2nAiU0MXbtV/9o5V8BuOfFySsjz8e08sE5
         g8avUX39CSqk5V5vXYGEVz0jeygn4bysZ3yp097kSk4GWL7uC/Ln5CPbz5M5K7ZSfr0D
         71/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623292; x=1724228092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fidSIArz80o0wKmWpcFbdk3lLWLuSUf3Uv0hxlg4FbY=;
        b=JhUC9S46BicGwLGwf9alckeGKYb8WK1xVHaA/jUo0S0RGrbu00hldLgzaFFlkRKSyd
         uS1eqyaV4Z3+WD0mszdmBWUTHl2QIv0gL7DB1rT+MnymToPpGvHPWa1zeywMpCbobYYJ
         zf+MEhtr4/VWjsZaVcEtZk1DLSJ85aLaVZ0coBp6t819Kz8MwCDf6C87Mnh3NAPqtr+K
         DXhb9BlHi/9rZ0NbEqbGuW27jdxqiRQnKxHPcP8FqTAmz554tO5cxzPpwmqolm61AR4T
         5RQQgwBRNO5PFX4LnhFIS5ecrZp3sRg4jg/zvcApWuh6QnhmqDJRfi6r5Fs8BeKFOq+v
         Xyhw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIY9N9b66lfOL/ZkKkEfq5T1KLSv+BysYNAuyjCjrjLlXdNgdCM0IeMDFiK2uuHkSzTbJdUPxSziynNeC2FVQwbCKbkbnA4CCCZvV
X-Gm-Message-State: AOJu0YwgOVDGOuqi0v1NPq2hGakrdYw2R1HS8rN4MiF5gInsowsZS4dU
	LFQCCzXTk/L0IcTpIyjOdprXkerEErGUhUZpcz4UNo3qKPPXlVirmGlu66F0pcc=
X-Google-Smtp-Source: AGHT+IE8UNnN8LORA79EaMC36UpDVBceh0b55OXrqwIIrmTy2qwD1a63dvxtqWFfyCcizXrljF0Gew==
X-Received: by 2002:a17:902:ea12:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-201d64c5c41mr29498095ad.54.1723623292590;
        Wed, 14 Aug 2024 01:14:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd147ec4sm24868335ad.85.2024.08.14.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:14:52 -0700 (PDT)
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
Subject: [PATCH v3 08/10] riscv: hwprobe: Export the Supm ISA extension
Date: Wed, 14 Aug 2024 01:13:35 -0700
Message-ID: <20240814081437.956855-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814081437.956855-1-samuel.holland@sifive.com>
References: <20240814081437.956855-1-samuel.holland@sifive.com>
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

Hide the extension if the kernel was compiled without support for the
pointer masking prctl() interface.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 Documentation/arch/riscv/hwprobe.rst  | 3 +++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..a6d725b9d138 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -239,6 +239,9 @@ The following keys are defined:
        ratified in commit 98918c844281 ("Merge pull request #1217 from
        riscv/zawrs") of riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
+       defined in version 1.0.0-rc2 of the RISC-V Pointer Masking manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..6fdaefa62e14 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8d1b5c35d2a7..b6497dc0e7f1 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -150,6 +150,9 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
 		}
+
+		if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
+			EXT_KEY(SUPM);
 #undef EXT_KEY
 	}
 
-- 
2.45.1


