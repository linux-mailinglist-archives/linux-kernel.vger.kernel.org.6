Return-Path: <linux-kernel+bounces-221881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DA90FA06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEDEB22AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BF16A927;
	Wed, 19 Jun 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nH6+2ZQu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39416631C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841463; cv=none; b=FOeJTj8eCEmDSkY6czpBIiGW2etICb2TEhvMf9j5FGLkYjOnZWtcrJJUk/ntAymD0i/eOVpzsKvZdtL548VSq5sgXTdaxZuc+LA6HVHmtuEOgL3OlQXDLa1qJ0nAynNyz5OuACg44o6WHSzj4pljywcL7E9aL28FFS48z67vego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841463; c=relaxed/simple;
	bh=xBHaFe7VLcuLpxsCjlsn/XmzjfLlJdrvGHOT1OyfrwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvgljPPCE3YZKbr7s/mwof2tQbXvpzg1OMQlztQ6Un49U9i/upL3+0ziH4ZkLbVyFafKYTkiY/9vxIkkTh45oN6HXADlgBSM9p7m+iFpi+JvRsQZMgu34W+gl0RSN7KQL5r1WSDiOreMqxyXb69s7+g4bxddI0acGq5g4JISXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nH6+2ZQu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47f07acd3so2503215ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841462; x=1719446262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px8N27AOqmnwl/KnT17601Vv0G3wj5EYnZpDzUGAj0Q=;
        b=nH6+2ZQuxoRsHpGxk4lIGHjM0MFTe6dllHRDVdMksG2Gi9L1iVd4wwCm9XaErRsdK9
         9yVaVcuNzi7meEGR2jiqKIKQsawAlHAdqfS+qcvluNbvIr2a+UUl+Ns6QiIQN2v8lWZG
         d8ww5lByb2zgbjhdRhGWEqDYVcwFWFzMIcE9keh6c/TDA9mSdAPGqNdAXFChAtXQydQI
         BjUztGO+TN3RfFUt7C6NGBIXjFHN49jFqlX/GdH9QRhR1tWXpNN4ySHjKKFfJ++WCbxH
         OrJVSs4SnAQ3AeMkvqiR74h01AlXq5y6649TrEuEAkg0s8rPJuLfdT+OXn0BmQGB2/Dd
         Tlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841462; x=1719446262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px8N27AOqmnwl/KnT17601Vv0G3wj5EYnZpDzUGAj0Q=;
        b=lFOdwpYjRwKsdqmXVy1OIqo1yAU3GG1h53ZKAVlVGuxqkEnOfuoQtSJLrsuIc1ZFwT
         6jZBJY/Yub5IBVrVznYswdK6lfp8QrHDYewE7QlhKQwVKZ2V88KQvVs6lHYS/2ThomPi
         5I7HIRrQIUZHUCG1rhHSvLITm+I4pslqaQDmC/jC2AWEpelZso3zE0vJXnbEpxC8hbXa
         sasNaO2MGw0IbKcLZ37Zt/+wR8RIWuW8xQCPYZ1Jdga0vpqaCbQL5DPEJZNOhX69nGeI
         SjSD01d3EeIpiA9RLPv2ZGeHoNVf8Ob1x9+OSINJWfY2SvnTL7cv7QlHmF5Lv9ikyqtc
         Ds3A==
X-Forwarded-Encrypted: i=1; AJvYcCWq/+uAGZs61TgQq4t17YHt0ct2JRq/xm0OOAyNGXJctAeH1BHY1ambKmaSstl+kvnebJS9O0nTAuqNj9RTRcHaRALVbJ1US8wIyt24
X-Gm-Message-State: AOJu0YzxL8gvGFWQHwMtiEy+L2e0Zq7pqCyz8pNI1QpkV6plr6t6QdjQ
	87lTuXe5gZBX1msBk/4Jv1Z7kHteN81J2wk5vNiaDOoq1g8c5QUVZhJW8Yp7bcs=
X-Google-Smtp-Source: AGHT+IFURITgIHUXPIWfZmHbHQG5F2+TL0ewnmECwvcXqCwzHJzZyz8b56abtJ31GhWKd7wdcoVjcg==
X-Received: by 2002:a17:902:dac6:b0:1f6:fbc2:526f with SMTP id d9443c01a7336-1f9aa3e74a9mr33490725ad.32.1718841461778;
        Wed, 19 Jun 2024 16:57:41 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:41 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:21 -0700
Subject: [PATCH v3 08/13] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-8-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=1957;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=xBHaFe7VLcuLpxsCjlsn/XmzjfLlJdrvGHOT1OyfrwA=;
 b=U7tzWwho/N+CYyjv6ycLZuv3v/0Gxvil3l+cEZQaFfxVErRfFZmSmrZhbTwGPZz2eqVP4HVTg
 hIdYdYDPg0oBDxYwrCdKYnpW+bmBtpNSw9zJjs1RETRdIys5x98rJY/
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

xtheadvector uses different encodings than standard vector for
vsetvli and vector loads/stores. Write the instruction formats to be
used in assembly code.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions/thead.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/vendor_extensions/thead.h b/arch/riscv/include/asm/vendor_extensions/thead.h
index 48421d1553ad..27a253a20ab8 100644
--- a/arch/riscv/include/asm/vendor_extensions/thead.h
+++ b/arch/riscv/include/asm/vendor_extensions/thead.h
@@ -13,4 +13,30 @@
 
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_thead;
 
+/* Extension specific helpers */
+
+/*
+ * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
+ * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
+ * vsetvli	t4, x0, e8, m8, d1
+ */
+#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"
+#define THEAD_VSETVLI_X0X0E8M8D1	".long	0x00307057\n\t"
+
+/*
+ * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
+ * encoding as the standard vse8.v and vle8.v, compilers seem to optimize
+ * the call resulting in a different encoding and then using a value for
+ * the "mop" field that is not part of vector-0.7.1
+ * So encode specific variants for vstate_save and _restore.
+ */
+#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"
+#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
+#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
+#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
+#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"
+#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
+#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
+#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
+
 #endif

-- 
2.34.1


