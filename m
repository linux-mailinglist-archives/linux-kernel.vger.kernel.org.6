Return-Path: <linux-kernel+bounces-238916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34E92534F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68342286F17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B314513A240;
	Wed,  3 Jul 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="use6td3t"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8C137904
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986230; cv=none; b=LbcgxrjcHRFTQzJTEtJZDz+lyek2TiGYnqujHOT0mYkKr9EHkJPA+akpRyaz9CAfYZFStRdofiYjxwzlbYLupkq0+0bUP0l/vdtFYCCD5pAuQUyUw6BG9RVJAdYlKIOGpjK2lZKDqrJGaUc+B7Kq9o8lI9m2crVuooUteN11+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986230; c=relaxed/simple;
	bh=wrX0uryyy89vYlAinvVr2O6QBZz257uuEBuSnzas59I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOBhP0dF7B3bRPHkbdZrtCicbmYHWeS+TTrEUW4BFR2P7Yrh/7rBqS4MmgeOeQd5aRVK/AIiJeUuyTpDHoo0feH9n+xb2fAak+iOQXee3/+Qpq0JOL/dThfu8MVVomRKzBNOONlJtXy9eeMsFYiGlst2gw5KbEfs/vTejd1OB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=use6td3t; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80d68861bf9so1255926241.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986228; x=1720591028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=use6td3t7+53lJD1CttFBgI/fI5eIiOtq5n/UxIIj+FbAkY4d5GOoSMRU4U9+OIP9T
         847jbWuXnWMCtUGTgF7CTjo3ypemz8CHMzWJr4OQhM+6hiIJpaIeFN690SUSWxWzIY8M
         BVDKMfossffNzV3d78TVnEwnbnLhuKJJn+dWcusLazwcVu925c0Yj0llOsGpY6L3JT/a
         IUr4fxAQnyufPi98cxaPtPicVh10fI6jnYuHJubAlrZD43PwD/pwpoxVlEFPIEw9HndY
         F2vGD+9fnxdfkNoLamCBg4Fzxs5wlGMFvSfpmwRjtQoOimo6V4gq/F5gtFuIiEIwTEcd
         NPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986228; x=1720591028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=425S2jEpk/4yk63j4Ow9jwZmOCFjeEcHZbKGmEqnWN8=;
        b=rHu3/fYL1bMp4yIGLwmueYNEjfIQLXSh3wcnSLRBsg+8eWxfIk333y71yPzE//QEcz
         s5S1jBWN7Za99FKb0d8jXs2Mjpo89h8F/N3u/dcopvXBj5bqDzy2St/AjbtpsCjc2ku1
         JugUTEoeyh1Tedox15h7nl7/dPoE8LA1CKRAK8Xs3azqu2JXZKUB6s4Mgf4v4FyGq6Gz
         fS1GZcuGQJKt+NSEH6iEWfy/hurkABCAfKEn1QNf9Ct2ZTgf74USjat16LscFbSvj6hX
         oHwP5ZjDNHEDxwH7ML2JU3iXM0TOoTInXzj47YBZvIebRAjo/ekZdVvQJpBM5/VydiXM
         4Lyw==
X-Forwarded-Encrypted: i=1; AJvYcCW53zanY3QUV/cdLMUq6v7zV/1G47t909MwbYOYYlhrnBQI1+9ikltsH58DG6XwHtTGo9uTNdZnosxKKUSAm3JqWVDKsyJh0b/FIEnz
X-Gm-Message-State: AOJu0Yxq87V8KlTLlksJhCEl/zCB6z/grf+OoRSGx1FNavqrmUjBtX2D
	+MmyA3yD45C9S9KKWrkAFfEz0sfnYSEEHv/V7aDYamkcT1N8ctyjg/BDUEzQG4Q=
X-Google-Smtp-Source: AGHT+IG88slojnrcpUylTggNpN9VQexHVaXRtFlyPKNtjShl9oJwn4L30O8Mo2E41agg/TiMHNr5YQ==
X-Received: by 2002:a05:6102:19d8:b0:48f:95f5:507b with SMTP id ada2fe7eead31-48faf152008mr12485438137.31.1719986227984;
        Tue, 02 Jul 2024 22:57:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:07 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:26 -0700
Subject: [PATCH v4 06/13] RISC-V: define the elements of the VCSR vector
 CSR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-6-2bad6820db11@rivosinc.com>
References: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
In-Reply-To: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=930;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0jkC45FH0LUvSVfvCEJuCBZ027fqPbAipPAnc4zFoN4=;
 b=6Q+Z3FOZMBsstZLmmdhAH3prUYL6lUJSpkZmRi1OCw/CqyP477CvmFjgXyaBRVaw08PBHr89t
 09L71Bw1E29CVgH5H7DhHsiOvvQT73JXK39wJHe5PiVuX48TVJ9yNEa
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


