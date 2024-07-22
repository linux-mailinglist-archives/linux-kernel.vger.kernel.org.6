Return-Path: <linux-kernel+bounces-259424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C229395D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1179A1F2216B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813277F2C;
	Mon, 22 Jul 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S6JCyKDt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E00260263
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685505; cv=none; b=UJVbjsc8o8wqWhqf64ZvgLqZcoGhD5XBU+halCiJN+9EEhotosIk7PDdisdF41NiMQ8jXElRq8l1CL2Ujlz4z3peGS7QuzuWOSVl/HHjVSl/1Bl8WBkTfDz/47jhENjgXM3RQOO1iftj39CUAyOlF5dHtQW2xglclNUEW+zEcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685505; c=relaxed/simple;
	bh=wrX0uryyy89vYlAinvVr2O6QBZz257uuEBuSnzas59I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DC+VUluwIqX/PQb3AXEsiEHr4WyL+jCCvJWYoWoY1eJR0m0jmQUtH/x3YPqB5WlyhrRbk1EERz1WnkO2yh9lQ/YnP4ejUgiPD2hiOQPKONlvHwrPm5QizN5qHDM0Fdu5PCzDPEBECtGNeZpcqiswxGnCJWrXDqtFfUPzC1WtysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S6JCyKDt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb53bfb6easo146095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685504; x=1722290304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=S6JCyKDtlTjCD2AVeql+DLdmwxa2fIcfB91V8PCvJnhxBaQolx5ebx5XUIRtWWvNbu
         b/lzk3NHPvPY/27Xnq0g+AJqC6yZUT5tIriSw+KI9tusARIDSrtumuBZNpsXbweNlY66
         vY5TBVXEl33B3/L84qOXX4YhxuQwJvwCTJiFtFLpGZJO1GjnbAwxFiYNJuS0BTLflDlq
         aU/YmGcojeHT35ucXhK9dc1+PvjsF7RM2B7vrvM+shxIqwyEUTyKPe+W9ZQC6EQUfnt0
         iFDhqEyuoHCRLaHrO8wl16YULePcqPGNB62nCHvq1vyqF3M98CHaHzAHQjyR3ZjcmlXx
         /teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685504; x=1722290304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=CgMhkrd6otcLek7sFpxYcqVM0e3vlByaHkx+tJ8z0TAaBHpSONPuCZxGmWUE0A2W3y
         rJ/HLgOrwSGsogM1kJNl0ER2AJvUIpyVj6M62+05tYOQUl6LKpw+28xZY+AQpFPJ5ofI
         cze8U1qmILZYwSPDyDWgMv/g3suFmyrA64+jpI+nGQqjRR4DknkVcE77yeiEJ5m1mZ4u
         HanXUdT/iNfm8FAWt1xijV+VqbzYMuv1+JcZv+l7wr9K4o5E6JK/QewjMwTH6yHDATRh
         Zd35OpaLu1NwohoCmiOv5X+3meOt/fhzv1qX/BqaELHfuDET1oDkRECdJ99vLWgNrC1J
         UGBw==
X-Forwarded-Encrypted: i=1; AJvYcCVHk+YjY8jIb6xxO2R54xytooMN7PH0MHlsFCeeQHsnvjM3Gd1eIX+kH5cnOI6+kvfhUNTjkFjrUDdiD/NVDxfH9eENtooNcD1KLzXJ
X-Gm-Message-State: AOJu0YzVbcgGPw8AhxJFBmg1Lp/I8IKh4x1qXbJ4au5bGhvf/FnFww5V
	wKwLASZTcuRhKIkdJNY6ycwS3AvHBYam+7xp3osD+7lJhTCW+6Q/1d1b5hBmlPQ=
X-Google-Smtp-Source: AGHT+IEoJN1pCcgoeebixEMdeRFm+lX7Fz51AAK3F3aCHBFtjYtz91oZywD8oyA7iNOCpmg2SBax6g==
X-Received: by 2002:a17:902:e5cd:b0:1fd:96e1:802a with SMTP id d9443c01a7336-1fd96e181ddmr34308645ad.59.1721685503730;
        Mon, 22 Jul 2024 14:58:23 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:23 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:10 -0700
Subject: [PATCH v6 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-6-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=930;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0jkC45FH0LUvSVfvCEJuCBZ027fqPbAipPAnc4zFoN4=;
 b=0RZc5Y7+dPFte3RfQycOhdYrS0o9oSHCnJx5nucXwKbADyIcT6a8rMi+tKbs59EJDNFM7h/IW
 hf3xB+tD++5AswmTbacfCC/pWDHRloSyAPnBD8iVQF4NrrEQ4Jj9uG8
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

From: Heiko Stuebner <heiko@sntech.de>

The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].

Define constants for those to access the elements in a readable way.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..3eeb07d73065 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -300,6 +300,10 @@
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
 
+#define VCSR_VXRM_MASK			3
+#define VCSR_VXRM_SHIFT			1
+#define VCSR_VXSAT_MASK			1
+
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151

-- 
2.44.0


