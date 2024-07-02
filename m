Return-Path: <linux-kernel+bounces-237451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19939238DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C771C20DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA11F14F9CA;
	Tue,  2 Jul 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nZTrDZVi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856E146D65
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910319; cv=none; b=H5h78DNpYdb/K1hj26xMyFtACR3bn+e0iJgO5N2N6P4BwFUztHP+XtJpMCC0CsEE8dfPlVBFXHGPObbGaxb8x03ngX6O356NffYODAguTqfofhXtigsxbZ1oGcDNyZ93Vkvok+D/MVBvOJzMohfp6Z25DlM9LSpjNQSww/qaN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910319; c=relaxed/simple;
	bh=IwgFq/u1LiwR2cTcDGlaRvzAUTc8kMJC+X6jojjTc2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txshgxSJs+EF4xYfqtjhyFFPYNK7CoeIqX8569tXPnzRQQLVplZP/rO8uMUGZFt9A5OMYORqGAW1YrL+ag212w/ezK5GYU+VVdHJhcilLdw/eFXTncn73+Dv+HgPBFI7OlEQQQbomgYWHD0bQJSfV9+oZkWxAnU7SIvFODyHe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nZTrDZVi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-425814992aeso12896035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719910316; x=1720515116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WccEx9NvT13PoluUayFyEXUnGwkOt/S9EsiCAQXUb8Q=;
        b=nZTrDZViQoQIrn+id76IWxkBfgM86Kgj5LHIBYBvUVlelydbdDNDKWWYxmS1DjCqaR
         fqmKhBhnbHExDsCjzPnjbiyudY0U8pq9KjUc8VFA6pAzO5N2rRtVWzffrzzzx+oyq+tx
         mdN81JypxWe5o2/1XHlj5GgVpUBGSuxG69nPgOwYnH1AGcK6fki48vajEUdNrceAJGE9
         zMwRXKbT32+YCwfuXRIOp3FLi5vJc5y0gUQQuo6cw8U0pLbVBFaBK+61M1WFwJsPEFjK
         NTy/IIJqGmdC4HI9KXLOq3dNGg6sjzq20i/6gWKZaHvH6ScOjF8+U1Z6sHlq3TwScB2U
         QBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910316; x=1720515116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WccEx9NvT13PoluUayFyEXUnGwkOt/S9EsiCAQXUb8Q=;
        b=FM2RGQeyzvO0dojyw7Od/50YJtBaKF0ISOnvakE3khLVHvlwkLjN2uMGSEKtCOiiyu
         +vOEImV+jy/M3qhoXWX+aSGy31wj1Fdhl5u9abiKkr3u0mEMVd09wQuebKAxjEeaC931
         1miBYiOcYabZ4t+V8O6DaAdud8swSZlut7nudUErX9KeW/x+XGOPsX8n6B5HfxeTGWSS
         slMFOlnYl1h1p4t3EQVtkFNdF9+wccR3ekOIBQ1vvyxYZV6MTqf1vjH+RHY3ui9vezTT
         JsPK181Fdt2Y8zw1whYoBQa8Xr+Pk42NO8QhOkACUoPRlBiQcB6ysrYIcE2qmg+0Ip1T
         Ts4g==
X-Forwarded-Encrypted: i=1; AJvYcCU5LlOtPDV53o8d6FSZH10T6BZ71TO3JUw1Hzg/OzLW+q3xWIFNYCm6Tv4wPebR2ygk40qrTgSNm4x6QKvWAiHnIZZZKFjHTQL1H4pV
X-Gm-Message-State: AOJu0YwMD79356ZiCSyD8yHxo0YqsBAsXWknpfezOY2K6297r/X4dbhC
	QnQeZTqnPFfoIAuZjxj0zmML64/fKKy02NlIt9HvFf4UJTp2SbO3SUh44KC3++E=
X-Google-Smtp-Source: AGHT+IGZdzo6PfO/YolAKKEnDj53HZfW2Z0PUTp4sefGD+K9Hrlj3OMHAw8JbSHy8BPMS8+pXPqrkQ==
X-Received: by 2002:a05:600c:19cb:b0:425:6f96:8bcd with SMTP id 5b1f17b1804b1-42579fd0d25mr65418135e9.0.1719910315708;
        Tue, 02 Jul 2024 01:51:55 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e16b3sm12491191f8f.61.2024.07.02.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:51:55 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 1/4] riscv: Add ISA extension parsing for Svvptc
Date: Tue,  2 Jul 2024 10:50:31 +0200
Message-Id: <20240702085034.48395-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702085034.48395-1-alexghiti@rivosinc.com>
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Svvptc string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..6dd0dd8beb30 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_SVVPTC		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..60780d246743 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -305,6 +305,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
+	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.39.2


