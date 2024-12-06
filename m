Return-Path: <linux-kernel+bounces-434457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8EB9E6720
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9127282CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D841D63E2;
	Fri,  6 Dec 2024 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSakyflq"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3461D63C7;
	Fri,  6 Dec 2024 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464768; cv=none; b=XVkJQsu0+q3jaAMZiatS0ol0zl71vAmSF2tSU3HBuAtygsxomfYqM8CAdOFzrquiWhms2wbpcJZ7IbeDIW/BaVu+Kqt26RodLvqPw0ai0KQ5Yhp6uCjb2VRzDDICcMIk4KMyAXk6F7Gnt1oXNWGQAngAhgXDnQdj/fppO5xMonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464768; c=relaxed/simple;
	bh=tDpwZYAE9tf4E+swcMCoCKQ1HH9z7c78fAnnZ1X0K8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAU6HTA+wAmmiB+bI0jJi/rg4ezWtT5gQboRsEgYLGsVDsv2NGsmdD9uCg5y5UYn7AVLIh9UyL8gkY3vOj4OYoTiCY653tq/w4dfW/GSJCSIf7UHYBXjkwI/j0xxRtBwqqwlPp4ZaAxPPnVGy/STil12Er+r8cFUHFEn+wLqWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSakyflq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4668f208f5fso15994141cf.0;
        Thu, 05 Dec 2024 21:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464765; x=1734069565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99+Mfl/GHyyDKmDCEIDfOnHV+iERdk7X1PZjrxCa1IU=;
        b=BSakyflqO2nHc9jk5rNCM+IU4v/hkK/9O9gy0SA5HDOZRgOjPEb0eB3+HuRVPPImUF
         bif9Jjatf3bThgiaaehUo/z4k+IorYrIXthRtlsPBSTQeawarqnmG+72CRrbsEkBhjZn
         eiMdjLZR2RvAq+mvIYuHOBsDo4QIOY8vztLSe+cN9ztnRoUNWbtC0N4Sk7o2c+d7EYmO
         MCj2+BkZp4hqkx4wRnJynz9tdvvTYtCVo9jbkZ3fSu5123J3pOIyg7kt2OtRWt/aQxm9
         jGzpfUZbMtEBF/8FWSM/VFm8Xjsx9J8L07pXjt9rXnjGoB1biwcQ0NcMpN9aatDQiFYC
         +jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464765; x=1734069565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99+Mfl/GHyyDKmDCEIDfOnHV+iERdk7X1PZjrxCa1IU=;
        b=pDfflo+ONWK/uyE8SOLOjNHzrm+n3CYyUnxP38/K8x/ZnTYDVdbyvbmpaQ/cmmnBmI
         QSqI6RQp4w4yV39ivsZKOkS/AzF1X5ykGdA331vBom9dG50xknbIuczes0qoE7Nrlmsh
         yyvrImkMD+H+8ibmrq148G2bcsvznY4PL611CUHkVpx7zumI6PoVjHw4709RnHKQ3VIS
         mzLcQ87o1KtpV7EwOT+2cM+xNwgV2QizEoYldEFw0gd2TxVwm1oiu+EzyO38xAprio4+
         NfQpnadExDqx1n1obKss90EWCQw2vudb8AQ959pFimoxydgf71b8p9lyE37ejLj5QZOU
         gm0w==
X-Forwarded-Encrypted: i=1; AJvYcCVakPMKNm5wzNEiHudb0Oky/J8uq+JgRznRJoaLhOb5Di29wxM8wc0swE5TExDKPDrxrgY54waY5Hp8@vger.kernel.org, AJvYcCXx/1aIsPvog6cn+n0UBg9VFoA1CB3hbhLh5Az/j1cVdtBIxD5jMiDrSexNKshqG/qMs7bo5/GUOqRPWwTr@vger.kernel.org
X-Gm-Message-State: AOJu0YyqChRYuvoX9X1kvfi0ouxRIOoNQ6QmnncymA6P7gjt3aZF+XFJ
	skGbyFeneIdj82WjFAR1J2Ci4eGv4MFrZUSqYCUujzB6GFiuh9fN
X-Gm-Gg: ASbGncu1WcGnBSjoVXpsUVd1kHwazZ3RTaKTgkp+FD9lsk3Dp5HCjQNzg3H5vra8TL1
	w0VynKYJoiyf7GiqnjSwtWE3/uESH8s8cc2Tegd/pkOMbErCIPTH5r7SE95EOYXjTAulvOPkgI2
	rMRQRpJsucYz84s75CGXvqS7h0/ZhB/NLZmmBoNKzfE+nsEQBFUZQZ066JahU+Y6tR3ElKJIIFz
	YcGErUiYYTjPtB7q/s8qGkAVw==
X-Google-Smtp-Source: AGHT+IF0kNksBAetSJdav341ahruff6KWAb7ZkcXBJa+STsOcvKmHNoEQ+0qcg4RzK0XD/H9bZ0JMw==
X-Received: by 2002:a05:622a:199b:b0:466:a61f:9ead with SMTP id d75a77b69052e-46734f7d305mr32306181cf.36.1733464765105;
        Thu, 05 Dec 2024 21:59:25 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46729793741sm17182941cf.61.2024.12.05.21.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 21:59:24 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 3/3] riscv: hwprobe: export bfloat16 ISA extension
Date: Fri,  6 Dec 2024 13:58:29 +0800
Message-ID: <20241206055829.1059293-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206055829.1059293-1-inochiama@gmail.com>
References: <20241206055829.1059293-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
 arch/riscv/kernel/sys_hwprobe.c       |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 955fbcd19ce9..a9cb40e407a4 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -242,6 +242,18 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
        defined in version 1.0 of the RISC-V Pointer Masking extensions.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
+       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
+       ("Added Chapter title to BF16").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 3af142b99f77..aecc1c800d54 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,9 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 51)
+#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 52)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cb93adfffc48..bd215f58bd1b 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -131,6 +131,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVE64F);
 			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVFBFMIN);
+			EXT_KEY(ZVFBFWMA);
 			EXT_KEY(ZVFH);
 			EXT_KEY(ZVFHMIN);
 			EXT_KEY(ZVKB);
@@ -147,6 +149,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZCD);
 			EXT_KEY(ZCF);
 			EXT_KEY(ZFA);
+			EXT_KEY(ZFBFMIN);
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
 		}
-- 
2.47.1


