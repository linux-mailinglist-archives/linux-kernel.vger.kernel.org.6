Return-Path: <linux-kernel+bounces-325987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A59760D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED36B238DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C90191F8E;
	Thu, 12 Sep 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wiyY5qi0"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F91917CE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120570; cv=none; b=UufE7cdJn9pie7VBDonYt9VCEvxzjotM8tSkwCDI3WyT5/2182e0NJkc69RglcvTVe2exsc0KObwkd7U+wtU91QluX8Wp1puWd3LCoWnPNsrhJG3sWmxLsB1euYS0wwsMKmvFCYbweqyCZb+AiiWRaS64W5WPQCsOEFpNSHE5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120570; c=relaxed/simple;
	bh=R1ruP19VNMYIJ2t74sibaC/YoWJ+uh82rPlu1gqwh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvL044x5v5yNnp1cr5FF/yHSbJVAesG85xG05t4N7Q1V+hDp643zu9nfxkeqk/fNZaW5TT/AjHzZq/Bs7ITqW1lfE+wJyMtd29kvCtfBBEoXas+650vawDMzraxHD1zoTPhBhboll6QEWfjzfe/fJIrwEiY0L2gv8yEx2s9Fwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wiyY5qi0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20551e2f1f8so6098975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726120568; x=1726725368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzA4CLrN9c04I0TkiHjILEnLnNrrRfsvuLr439lHPOs=;
        b=wiyY5qi0BgKPpmcC2sYG6K6jmjYwYxHudvxIZicqMgUQew2H7/1A/eb1DHXjIoifvS
         Oc1/A1GfNqUv+ugZOIXkcxBe9FAgl755KK3TJU6L/wtldRNDEsTHxG5/0PQJL79TGACh
         iRi3rHeUPWNUL1Qg1AlSLLft6HT0IRuERlfh/mOR81LkjJ5PujOKQaAByRcuId25EU+L
         lK61ulq5qMyNG15PB4d0Td6YXUuZdu5pM+75tb3Kc9ExUNDGuRqe9rtFnWD8ARseiwap
         Hl7H9EUDt2n4+7SrG0ZiJb05nWx2giIRQ/trv39dFL8C3Rm7PkzapenEQpe+i3OowxGE
         k/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120568; x=1726725368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzA4CLrN9c04I0TkiHjILEnLnNrrRfsvuLr439lHPOs=;
        b=j+KZL4hdESLUdZSf7Jq/jnpYUxqH0z8r31XzGlDc2RbzFulEBf9AlAx/tFtmReBFBH
         WkXgYAuyXRPdNXqYOw6H9DX2hIo8rztj5Yk1RSznS5cCjx6x3ywxiYMuwTWot9o8l32K
         AnwTyxBO0Y2tEXfZTeFkbiQexfEiRLkGYyNc62TfcJ3IJcZKaNwFozfx4/0XhUb5bWyT
         Ea5/qYpjal9Cvlhl8FOYteJ2WPhGsbFHFGiU1bf9hvZ3ztLHs6jecx/okWlLhcc0TIYv
         tc8oHDDnMFA5h34wbYD0VyXCq1Gi3c1ZsWvnicIE17wlHvk2zhRa22X0e4UgblhsuyL9
         n7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXtkcvu0w2u6fTHC5kdm5OQ/mCSFLnbWUtwN0tEHUdvaZkniDrSwvfWgQ/4hWrvuBrdkSxW/DZDnptXFJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWZz0QxgA1K9ktqn+ZXkqn3RKvMruOI30vkKyW3BcRSvKTiAm
	PuonpujuI8cU74BcrMupNSUylS6Dou9ecSe5t8NQp9NU7qykaMC4z/7hVL9bzP4=
X-Google-Smtp-Source: AGHT+IGAuCccU07DZqdkiMWs0Ena2Nnk3dSiXEP2sYQH784oXf5a8ibel1CZaIU3Cgs5q7SC+nXlTg==
X-Received: by 2002:a17:902:da8a:b0:205:68a4:b2d9 with SMTP id d9443c01a7336-2076e4150famr25682015ad.48.1726120568364;
        Wed, 11 Sep 2024 22:56:08 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe99b6sm7870465ad.209.2024.09.11.22.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:56:07 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 11 Sep 2024 22:55:19 -0700
Subject: [PATCH v10 11/14] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-xtheadvector-v10-11-8d3930091246@rivosinc.com>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=R1ruP19VNMYIJ2t74sibaC/YoWJ+uh82rPlu1gqwh/o=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qjpljm0+eaN738l85uMF36i+LEa+wXNIQaszqzX2xan
 Wzwst6so5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIl0KTIyfFf95Nteqhx7X/P8
 DuUjS9qEgl7qbb1ybo3LoWPHqvhZ/zAynCvdIxn/d0l27MM1l1UiWNIzcuvPtW2QWLHppnzMlsJ
 SVgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Document support for thead vendor extensions using the key
RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..400753d166ee 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -266,3 +266,13 @@ The following keys are defined:
   represent the highest userspace virtual address usable.
 
 * :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `time CSR`.
+
+* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing the
+  thead vendor extensions that are compatible with the
+  :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: base system behavior.
+
+  * T-HEAD
+
+    * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR`: The xtheadvector vendor
+        extension is supported in the T-Head ISA extensions spec starting from
+	commit a18c801634 ("Add T-Head VECTOR vendor extension. ").

-- 
2.45.0


