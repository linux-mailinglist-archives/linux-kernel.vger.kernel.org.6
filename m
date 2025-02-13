Return-Path: <linux-kernel+bounces-512109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EDA33423
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFAB167CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A078F5B;
	Thu, 13 Feb 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLWG+VLi"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414878F29;
	Thu, 13 Feb 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407150; cv=none; b=XPAJLb9QSRgtGK3s6Dd58F29Ad353ddXa6M/2YapjKyguYb6M6eTdUkF7tlJ+ZMTayxeQ1Ylu5bSbeKDjIt6WJfg1qFPUq6hy8zTL9IBs7XIWi50uEaKFToMUvZkkUNTRJ7+toKKrghIVIm1k4REA7fiW8eUvR3jEHQiSU5VxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407150; c=relaxed/simple;
	bh=KDz8UMmpb2nYnrzlVehg8XdfsqjhtiU7EiAGoV39lSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4tP3HmhEk5KoVg8ZxrH8FOY9ag+49js/fPnyDykFQrh73V3jIzg6pQzi4bIk4I7d6zo013ch8V5yzqYTodw1s23/VTP6DnTvH3MeTx5hYJz3KDNjVQNwVQ5dUxDnzOCuupRujll6xJf6cbcobFHIqCmLbbOuZpaT8gKzmSlUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLWG+VLi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471b5372730so3123291cf.1;
        Wed, 12 Feb 2025 16:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407147; x=1740011947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUrtJevhcm0CKbwqKbK4CuYq0Bi82l+4WvPMumL72xI=;
        b=RLWG+VLiDmSpJkYTYhvfwsv8Kojg5oNovBc+i6CW7bBhH5qSaUEQQaSmU3l5+Bilmz
         0fMMovrEjtiToC7lV8OSYNy6CJ6IBKgBLcAC26/IPAYDxLhoxSqR94gGspzAETco7KIW
         Bl7YgeoQlnw7age/eMY/CaEPiGundWihwi+G8mFy0gGdTpyDtKFFLNMf7aO4uLTUgjsW
         NyIPs8DfOo/SA25le5oswOklzrl9Ki3vm5CqoD4Z3p/YK+oaGAxmOCoXQfShx90WtJJa
         7ki+Wp25LbTMSQKu5QQSv4Fsf2AhBqb6tF4gx4dpmdanCs4y76HKbPWmaD9H6fTPoaFH
         tqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407147; x=1740011947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUrtJevhcm0CKbwqKbK4CuYq0Bi82l+4WvPMumL72xI=;
        b=Pv8sQv4bM9MOdiv3Ibhyq1IZRwauY/BcWfSi6A/eeju4Yga81pIk5cs/rV2sicceXJ
         R1+n+SBBqk0WMcUZlohJR+McHWuruWMNDyo/lHxWARdYZY0PcmeJ/iVd+tyI6AmXlcAO
         f70EkITfXEJqc2VLCQaf9JK93z1LWHt81kvTvx3Kn6iANDNhEUpCw5w96g4x3wax7eYb
         h5ula9W//KR6lbsRnIUGYZBYcjhzvkwbYTqsk9i5q5tGGSUksrgyVFSoMztYxfzx5aBJ
         q5gnuUDaKTfcaYeTYSG9NmnE446EezSZLV2sOMjvYUlHLlwJEMo5Zf8W8B21XnPxEPrn
         X2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWdRy7ICCFoGGMrjWMmdtCHlv494zZGptuDJFZW7FDxHZUmu56I5OXwm3KSNLUDHNWsGhNEXgczHXcJ@vger.kernel.org, AJvYcCXPpnYP7IiEAkl9/auXI+/oxBHtHYcjsXIXc8IzrLF9zzOQvfILenXKyrWr0l9xoCi1QokMAlMBDY3uxQ17@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyc++dkZBMnWW1eJn5eL1A8cjjMRfZkYwdZnhq/1QzutxMAQkB
	+lmKZy9geLsqDQDGHE4r3IWdkQlY6ZaThrrwnk+Yktob91KtSUnfQz5mpA==
X-Gm-Gg: ASbGncsJ5OeiCbOUXg/vB4UWpUYxKmUWeHnWY4lJXRdWHkwH7GUC4I3me69A7itpti4
	23UFsi5hkQdQeYVdfrkbmEQQOGneFd9VK9hqwRPXiel2mUz0j70RWolBu5a14gkmsu778JySAnJ
	Lx7apnsiyH8ckwpnBW8wrpLguQvz6puUTS0057iJV6BnfflxJNrH1zINnRwCVu/DbOqqO/Ho0Qv
	RE4UxXnipDxWXJ80tkypumLXaMJNHGB/OFpYSOLW4iaxuFnyJcFAMYUtxZsyuDoaa8=
X-Google-Smtp-Source: AGHT+IH4Lace1X98ZnWBEvY1cymlk72VSYPPy3ZXrC1eukrH19AoRSIo1KXtdbZz9LKA1vAlD6ac/A==
X-Received: by 2002:ac8:5a15:0:b0:471:a602:e75 with SMTP id d75a77b69052e-471bed7567dmr20929571cf.25.1739407147286;
        Wed, 12 Feb 2025 16:39:07 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2b06002sm1152481cf.77.2025.02.12.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:39:07 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 2/3] riscv: add ISA extension parsing for bfloat16 ISA extension
Date: Thu, 13 Feb 2025 08:38:46 +0800
Message-ID: <20250213003849.147358-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213003849.147358-1-inochiama@gmail.com>
References: <20250213003849.147358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
were ratified in 4dc23d62 ("Added Chapter title to BF16") of
the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h |  3 +++
 arch/riscv/kernel/cpufeature.c | 35 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 869da082252a..14cc29f2a723 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -100,6 +100,9 @@
 #define RISCV_ISA_EXT_ZICCRSE		91
 #define RISCV_ISA_EXT_SVADE		92
 #define RISCV_ISA_EXT_SVADU		93
+#define RISCV_ISA_EXT_ZFBFMIN		94
+#define RISCV_ISA_EXT_ZVFBFMIN		95
+#define RISCV_ISA_EXT_ZVFBFWMA		96
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c6ba750536c3..37fb6b07281e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -80,6 +80,15 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, unsigned i
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
+static int riscv_ext_f_depends(const struct riscv_isa_ext_data *data,
+			       const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
 static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 				     const unsigned long *isa_bitmap)
 {
@@ -140,6 +149,28 @@ static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
 	return -EPROBE_DEFER;
 }
 
+static int riscv_vector_f_validate(const struct riscv_isa_ext_data *data,
+				   const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
+		return -EINVAL;
+
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZVE32F))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
+static int riscv_ext_zvfbfwma_validate(const struct riscv_isa_ext_data *data,
+				       const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZFBFMIN) &&
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZVFBFMIN))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
 static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 				    const unsigned long *isa_bitmap)
 {
@@ -345,6 +376,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zfbfmin, RISCV_ISA_EXT_ZFBFMIN, riscv_ext_f_depends),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
@@ -377,6 +409,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvfbfmin, RISCV_ISA_EXT_ZVFBFMIN, riscv_vector_f_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zvfbfwma, RISCV_ISA_EXT_ZVFBFWMA,
+				      riscv_ext_zvfbfwma_validate),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
-- 
2.48.1


