Return-Path: <linux-kernel+bounces-238918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C849925357
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA9D1F27BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF947137904;
	Wed,  3 Jul 2024 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l/PVBJ0a"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809521386D7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986233; cv=none; b=KjrlnMMqyuspVYVdVhufh8FzSi49xDKHDOwIg8US8kAjXAa/SdY6sD1HTNyuvy/FyDMUSfMkQNWG+HDdQte0j9dBSe6gW0ONqBFYQCcDVaBH5jumFSCiRuHr8XuJXZFjX/pg3OhOchu2wehMVnbrcSSf+lJGHasoc27yQJYPcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986233; c=relaxed/simple;
	bh=L3aaRS2j1B7ly0GhgM86XDS3MRCOslmFg/ArzwGxzO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZO4b0S7gsi0ZErnJv41S2S9VZu6P1jJZT9XmIAOSjeU7S/Ijm3ic2awvKom3mj7J53J2A2YTtwoEdnuyTTXkMGUlOrnwpZW9TD+5WTGCe/9NezGw79x2tUUCmnoTH7SM5CJO3Ww30S7nlfiKdr6S6Z8uKdjNtNA75U5s29D0cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l/PVBJ0a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70aec66c936so145602b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986232; x=1720591032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhITSSlteAMwmsPUv9TpJ8KEJQbK1ok0BXYvmwnIXKY=;
        b=l/PVBJ0aF5RsOTwvHr7UTlxGj4ukd61G9xro+qpQPZUgFnnxMApKHLJvnGy6vobnLF
         ArIo1Gbesn7iywjG+rJLNfy6QdIxMn9rWHISy9UF4tODN53HdhWmBgiZ6yJDAWnSBpXX
         HuQYOplH4C7OpRIcXFpM566aDgqnoa2eIPt2qJwStsBG+y6UToVFKH95STMetTRZxTl/
         4lcyj+Hzllygn0Z5Fn5wPz6mkBadujo109S9uMwA9lPpdjATpLOIM8K09sy/EINoWObJ
         B5BFYGArG4448iLRUyw3LEku1nBMFlAt8GnJSMek1gIXVdb2xRScVhJNxhP8gzJNJTxq
         vM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986232; x=1720591032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhITSSlteAMwmsPUv9TpJ8KEJQbK1ok0BXYvmwnIXKY=;
        b=FT8hNigf+rhk6kFW8PkGb/Q+AqYYUYTGOPbeYqhufTA6Yyf3dAG7vCCD5/p+0oT0j3
         98TYmld6oWLZEwtddQY/3CyO3rRcEB3ZRkopz7xN40hUTwLF/Nz7lnNUN2YKOZ/W3Svi
         i8FKZIiyX1Be97a0k6Gz3ljvLKeaEyqlTY8xgdLHXZEep8Hi9fr31SFcmgya1zw6x8JM
         4VepbLbK3gzTLff2XfsUZ0bNK7CEmhGEWDY9ym84en2w+/pzMHlMQGyCzEwUtUQtZCjC
         KE07HRT773l1HYCi/XTNKOf7Ez5c++ZFhmCXRsjsbFHjvRpmnOffabxVwYGS2Vz0g8Jh
         zHFg==
X-Forwarded-Encrypted: i=1; AJvYcCW4FAURq6+UyGKf1SNs3ukUpFXtVEC1fMucTGOpBvlAXZdNb0SdU7quRJNKQSa8tUKvAivUf6dxwWtcOn0QDBHq9rnP80u1QERp0xge
X-Gm-Message-State: AOJu0YxyDc4veBsjZ8iWQkVaFvyOIwWJ+XZDyu7lNMNqEoZUH2Z21pY2
	nMp8NMhtxt38X4dk+uD82oRUtbLXdoTOvIfduFEhWpu4XFTMvCic0CDisu3CP98=
X-Google-Smtp-Source: AGHT+IHpwFVutQV5bD0qc8ckbUJ1hgf68O54SV5uCNZDiu6Lj8fD2bIReshuqA93ROnVtsuvcW+iJA==
X-Received: by 2002:a05:6a00:3cc6:b0:706:aa2e:fc4d with SMTP id d2e1a72fcca58-70aaad6f9a9mr10699215b3a.16.1719986231828;
        Tue, 02 Jul 2024 22:57:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:11 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:28 -0700
Subject: [PATCH v4 08/13] riscv: Add xtheadvector instruction definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-8-2bad6820db11@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=1957;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=L3aaRS2j1B7ly0GhgM86XDS3MRCOslmFg/ArzwGxzO0=;
 b=8lywCVM8UEoyiTaUOO1WlkKStMLhnLjNmIQBfPGf3FufVm1Mqo69xHqmn0UTcpEmOyN0wJWKZ
 yoqNjk/xI5xCo2xZyqo6QIDXF3j3gh/7+S827QcaciEZ6fYpZRyr58A
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
2.44.0


