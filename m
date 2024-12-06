Return-Path: <linux-kernel+bounces-434456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B09E671D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA56282F45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE51D5AD4;
	Fri,  6 Dec 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg7hUVXC"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D81B87CF;
	Fri,  6 Dec 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464763; cv=none; b=P8g34zkSZ97L6EN2tEseiof3cWVAUU/Zd+OyFm+wKDyJL3xqtX/vtsmuhVFHWsEXQZ3jUhjmO45kGCzeuw885dQFz0+yIaHdL5J+WwzGAj+s5pPO04LUSNvlHHp2GB8OA1+nyT79D7klJVTAfCn/dgXh2uRVBTY5+iLoA9DXRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464763; c=relaxed/simple;
	bh=ba1AhIdb3txdJBXGCN8JGEaigNGoqMs3l4lTkhuJnRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2G144kyA9helkmkWVUEDlJ6c88Mj2Xcd6gXibqjogu4rj02lPIHZ/FvxOoruXKD8BWgeD+YRMjlhcdLEFW/03/RGQZQCWWeIqsMeTJN6k9sCkcrV9AYW0TYRBvGwfwJBOSu7/3Z0D03HP4oTUwt5bX11ZcdRiGXjAwVB5iPPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg7hUVXC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d842280932so24907906d6.2;
        Thu, 05 Dec 2024 21:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464760; x=1734069560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B2zlAfPxzGcJqLLkasGHOZWMqJHtz0wkkNYHD9NX98=;
        b=kg7hUVXC7nZeKtmRo8wMG0QL1rsikTApT5TA9HKZWFlzDC7hfKWWd2iR8Fzmh3BR63
         1V8CmYKlyI5VKx8D/GSo/OMK3fxN7dPaA9AYqECAtxI6CoWP4p/dlXtMnD2C/8pPSw3Q
         N4HVUm+U2I6BfHsquiuDlJqn/p6slcjO+taZ7WBwLKTm7xJ4HZSp00PHvoLvLqJB07KO
         qGNFQDEPLEwpRH3cG+wGr1ybIdXykABLbD652S3tWuPmI6do3Iq5mhdAaUxqxCNd6C+E
         qk13ioK7G0or43/ndrmjA/E9DEMupnIjGS63lalRQrUh1pbn29ZSptoWTDlcrFQPJb8g
         E2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464760; x=1734069560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B2zlAfPxzGcJqLLkasGHOZWMqJHtz0wkkNYHD9NX98=;
        b=Gpb7y63pD2g2xRhKiHJ9u30shpqEUK7kg/homDGeg+2K5AOLWTk9cNMyv+QuqC7rNh
         lqJYcrQGQ01NOS+wxWXAAnbvOXcGzhS5L5Pa93hb59KmdvEZAEJHO3K5pysukHx+BxAd
         oKhgHtRT56Nb+/9ws58eiUz2Rt6PVMiarblPr2K+TjQFnGuqPsc9yr/asWn9uWakCV62
         turAKwKEZdam4leCqyviJ9Mbl3Y5G0aXOOnsCX+ul6E/M9IHEv4S2ORyFJnGzetloDft
         UjnhMZFZ1jdslhazT3Ag65sMl1HGiCzqdUg79tiX/A4vckspas0hYTXpL0B7q9AbvCkt
         xiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnihfSqThu2twYFZUEu7SfPOPtJNTdDDTHEt5E2+VpHKMrwFAUhyyy0vXBh89M2J8SzeSLzU5OeYu/@vger.kernel.org, AJvYcCWwalzj3VzmoWavm4U7ogUe8CRUUhQwLiXW5x9SZOhgd3luZJTyqEVmstTUBYe/SLkBHuUvPkqG+BZ5bLOH@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHJxd9zwW9ynpisbRzSdtrNGHtTu1B4hno453R/SXArjqnjt3
	lzM9WE48oNT433YqisKag7abidgYo19sII5uW5iKzXTzR5Q5Ig09
X-Gm-Gg: ASbGncvV+5Aqr+60pBXiqN9iVCWBjTG5h1i8dkLTvX8yWQvwctzYYUXUim9bzUUxlIC
	JHqcRegUc4qXSsAXWV2F9tAraD7Kp8FYQHwPRkzEWk8y7z0GNGwVU1EI0rtEbgS6n72oVGd8eg1
	iDLtuHeMc5IBms+H05mvL+1pxsvnVER/UTLgVAGNgKqWEJ7JfyKZy8gCWwdtD1znAHLzhijJLA3
	O7QMltB7Z3HoTdLmoFgMAOMKw==
X-Google-Smtp-Source: AGHT+IHSpUqq5Os4ifAgGNhdw5ThUTTLrj+Ai+/aRacSkXwVnOFqsvWmHLjVYLoRqjraOD4r+REhNw==
X-Received: by 2002:a05:6214:1bcf:b0:6d8:9dad:e14b with SMTP id 6a1803df08f44-6d8e70ca7a8mr25029446d6.13.1733464760713;
        Thu, 05 Dec 2024 21:59:20 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac016cbsm15430616d6.117.2024.12.05.21.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 21:59:20 -0800 (PST)
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
Subject: [PATCH v3 2/3] riscv: add ISA extension parsing for bfloat16 ISA extension
Date: Fri,  6 Dec 2024 13:58:28 +0800
Message-ID: <20241206055829.1059293-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206055829.1059293-1-inochiama@gmail.com>
References: <20241206055829.1059293-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zfbmin, Zvfbfmin, Zvfbfwma ISA extension which
were ratified in 4dc23d62 ("Added Chapter title to BF16") of
the riscv-isa-manual.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/include/asm/hwcap.h | 3 +++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 6 insertions(+)

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
index c0916ed318c2..5cfcab139568 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -341,6 +341,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA(zfbfmin, RISCV_ISA_EXT_ZFBFMIN),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
@@ -373,6 +374,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
 	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA(zvfbfmin, RISCV_ISA_EXT_ZVFBFMIN),
+	__RISCV_ISA_EXT_DATA(zvfbfwma, RISCV_ISA_EXT_ZVFBFWMA),
 	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
 	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
 	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
-- 
2.47.1


