Return-Path: <linux-kernel+bounces-238913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EBD925341
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0331F24F49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FC9136647;
	Wed,  3 Jul 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZD6LEGZ6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4841311AC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986224; cv=none; b=COakhlPE1q9JrMpxexajGhkcTWDxR7Ls9Oaf1+WhKf+onL8FCfpH+QxyzQmK/vh3jU4ln5Fe92gQA4e5mRF5PGH/LqPR/Zz+pafZnxkjW1LGWc3u+b+JNAARUO8UpQgyKbq6t/VQLX6B9HMOg3TgETTJ+xNkVdotTcDX/2P3edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986224; c=relaxed/simple;
	bh=I9BB6+DSsEot7edtm0hreUvYP0RvytEdbSv790C0uE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K81+G/dF8vZihfeVLP1WDlTa7uckDMBmzFIewSrjqC+7CwE9FdyoSpvnto6kxjkitc0UESsOehIQtyZKrJOcmZjc2KxSmhpkxDZTvFBd+v+gI7wrs4mlmkBHT6aS2Ea0bZ4RKe2OLnA251PdnsNu0VijFhYmd+oblKiyhqCEhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZD6LEGZ6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706627ff48dso3740877b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986222; x=1720591022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g1DxVy9Ij2OMsYu7oTE9l+cI+PV2f969LKgw+PL+a8=;
        b=ZD6LEGZ6LowXMLtfTIo6WxK1atddI23NXXMMTCiYBq41g/l3wCss8RKG8x7u9s86t9
         82cQ/pQjQEmgtYoc8LWAQ+4Rp1RHA0bT79jTqxw5qQ0/ikt8qKA+WWOLZE3qZfD+YHie
         HqjTIvrH1gTlX5X4+aL2eAl50cbkzV1elP4ZJRvOLUg9K4/+f8c0ihb5wFU2atAfIQ/A
         nPKvwHhz7z1feZq7BkvKZH2MluR3xv1iPJSK/qFeolErr7RVvI7YgwQhBR6eXr1pcRCY
         zXqbF+axKvG3iNvtDOLhyL0Xjz9E08l+WVnSV5FbLVcqzumrqyo6WC2n/+n1wD899aER
         LujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986222; x=1720591022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g1DxVy9Ij2OMsYu7oTE9l+cI+PV2f969LKgw+PL+a8=;
        b=dAWuwcdl71E9ATH1WHx3Cp2DWg+D0z797+3/CM3om+/TQ0fdpylvaMe8gUv/DLarqM
         NqoD4XZtaiv7Qs5GOaBPTGt1unFV8bK0LHRE57ZdpYQ78Pa1Gbql6FWgW0Zq2SMVEukw
         vZnVA209x7JrQPVkwCm6ZE5Rp6cipPv4+c6JP10satIHzQaEx4iC4tWdLaTBIUxuNwBs
         baqxEum5Ie4JvxZoKBqnmiglatJz55SKF0SWwE+7NZDpnp6vXEgCG5oxOZ8mO2LsYbzq
         du8YY2zQsSTeKWwfVZrjSNBHesWmcOLXzM2an981Pg/thfaCsX99YwHiRaAxRUVBp6ZS
         e1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRb83etqgBH0+YJajO+R5tXotYuAtqfbEgA14vUV+8SxsHWr9pJZfMchuUuTvodOJC8dFzWXQrR3hB6yy4iKGAaEe6dSdMQ0LIyqpW
X-Gm-Message-State: AOJu0Yy6J1AncFJGPOAgwPeM2shXqRp82rVhgEqo2VPj/msTk2hkAqAR
	6wCYmTvSC+5Qyok5eQ4+RVWgdoCJeR1+9lCe/00hrWWkyBhDLQSuE/JnPWKhIVA=
X-Google-Smtp-Source: AGHT+IFz2hW7EMifawOpqM4AiD3kcAclIq6iiztRCK1L3Y4b6IKCzpZ5P6BWyV3Fbxcd9CTq6SCKYA==
X-Received: by 2002:a05:6a00:21ce:b0:706:6af8:e08a with SMTP id d2e1a72fcca58-70aaad2acc7mr15442207b3a.2.1719986222055;
        Tue, 02 Jul 2024 22:57:02 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:01 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:23 -0700
Subject: [PATCH v4 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-3-2bad6820db11@rivosinc.com>
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
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=960;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=I9BB6+DSsEot7edtm0hreUvYP0RvytEdbSv790C0uE4=;
 b=H8CrljGzUjIOOabCLiAC2ZNGpp0HazfmCxEDWU83VroeOYA6cw7Q1KvMeHXN76EX2cHtVbITP
 JsrlM5MIuFpBDrF5FfDU16a3EB1Ky1H5hrSQoekvqfQ6XWHptRHd8+b
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..6367112e614a 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			thead,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.44.0


