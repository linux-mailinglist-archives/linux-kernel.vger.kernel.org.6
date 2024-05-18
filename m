Return-Path: <linux-kernel+bounces-182961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B408C9243
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08299281F37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9E6A8DC;
	Sat, 18 May 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiF2F5Xq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8F56454
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716064770; cv=none; b=AyWCAJMNP66zcIplQUN4L4qD7D7iv/xcCDyP2PT1+r4wOgIDCBhcW3n6G9UcUKtg5b6XdVisFmXttPjK4rtx2wSqtHzKdcwdORs5UZH7IuKpuXiN9bXY0NE/LdF5QfGBbfnDAQgsgHbTW4IfvZGDjserDuSdjRWuF7lha6xDt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716064770; c=relaxed/simple;
	bh=b1Z8oyoRoqggQVQBdDGJcy3Hy1kDnA5yXdzm1sO/0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxGKa0DyDiEofGM8JRNMErU1XEdE7HifNTLUk4ORZBeHDPFd09OF6+zh09fpqbxLdLCFexdCnVH+b7cf2luildqRXArY89vbdD1dgneJ3omPdHGQXntGx52+TzPJhWTMR/fVu6d/H7FnkFyp9A7Vd8xkY+23mUHNiJIx0/azoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jiF2F5Xq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b097b202so450006766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716064767; x=1716669567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyuvjp8sxI6GAbBY6i1paMWee54WjCXFX+m3o/u+49w=;
        b=jiF2F5XqqWZgZY6mPRhZD3J78Q99Zw3Ofor5PP0aUNXJsHQS7CB6JQQwxU93x08cWX
         2U2q2uCBynCDzE7Voj7K1Yj8mO4A1ieGBj+Z5zvDcbexMZ8FcEYBGmNkSsdK/T6SVRzO
         vSwJxfwR56rYqV64ezinrjtJn/z+I99q3KZvNaJjXqTtrCxqBKZPEdkB9zm3UTvoMR0Z
         FCJ/Bm/A1T67+1WXoYclNkQHinKeoe9ryTo7sl+pw92aNVgTYwoRZQa3Gx6IeJBTqj5O
         FthGWtg4UG5HVO9ETBrq0w1rQmBXq+ZPuR1X1kV94PMyZ+KDJiLX5OKv0L5aHfKFHOZh
         53rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716064767; x=1716669567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyuvjp8sxI6GAbBY6i1paMWee54WjCXFX+m3o/u+49w=;
        b=bqTvOQ65qzXOyKhWEnYL2b0CHb5teHHULm0WqFCpBMR3TrxG3KqTCSiSBDyviaJlf4
         E9LWP2RKKu+VB+8wiFUwYUySMWae0iUt4mT1IJoUVxl3pZlfBaiYqojK4Mty8MyGsDi4
         8smrUXD0KVVivLZbAFOUU6jgSBN0UBY6WqzMNWSuh0uiHL3t5wsT6kUi9yqc9GD5Cf8m
         8fHRUy9oZwONpVGZywUA/Uiyzrub1QxqZwDBNc9vjN5QXI98JjIeHK4o4XbuZXTItUPm
         C6T6x/VQqSO1Ybo6x/Iz6ACeGFPXmgDLRNtMSO31CopBOkBPIG5KFKTPNPwUSoBW4+hk
         4d1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXPtIIq4ohyz9PEy31AH4xawjviFIc4vvgGJWkdam1X0yYCDiwnP5h+NF0K2QpIks1J7/vj3KkwSyD55FlsoPz+UIXMSppo78ODHGt
X-Gm-Message-State: AOJu0YzhFJ85XpkFVfTHw0JhKYbK7lrfG5pqFClGv1ouoOKnoZPjsB7P
	lTCnVCGNq0zc4uWp+U78d0dkmNgHVTpOF4SY9IXXERGFOs8VeLvC0zQ9tHJjYv4=
X-Google-Smtp-Source: AGHT+IFmAaJlVwRteEECl5DmhNyp25lyL6ct8KI5P5ZBAGIXVrtR/R+jrwf/V9O0lNpRj9x6NEwBeg==
X-Received: by 2002:a17:906:bb06:b0:a59:b490:6e62 with SMTP id a640c23a62f3a-a5a2d5c95bemr1763678766b.40.1716064767145;
        Sat, 18 May 2024 13:39:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm529625866b.85.2024.05.18.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:39:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] arm64: dts: juno: add dedicated FPGA syscon compatible
Date: Sat, 18 May 2024 22:39:03 +0200
Message-ID: <20240518203903.119608-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each syscon node must come with a dedicated/specific compatible, which
is also reported by dtbs_check:

  juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index be42932f7e21..6ca73f41408d 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -158,7 +158,8 @@ v2m_sysctl: sysctl@20000 {
 				};
 
 				apbregs@10000 {
-					compatible = "syscon", "simple-mfd";
+					compatible = "arm,juno-fpga-apb-regs",
+						     "syscon", "simple-mfd";
 					reg = <0x010000 0x1000>;
 					ranges = <0x0 0x10000 0x1000>;
 					#address-cells = <1>;
-- 
2.43.0


