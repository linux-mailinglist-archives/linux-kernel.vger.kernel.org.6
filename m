Return-Path: <linux-kernel+bounces-247667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45F92D2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324EB1C22A84
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B8193096;
	Wed, 10 Jul 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkf3JSeH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBA192495
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618160; cv=none; b=FrorD3fKPOthv5u7oeTqNy1MQenUIOHMtmChJYeXe3ydsxcrLzM84HMV9U141wifi97WTaM5pk/BRRm2oyRc+s2e+TC1+MF/dakTTTegNA2wD4ABAoGDpEUeHJ403Q65raBUNeL2jpzq8kkf1DxKfQ9jYoZEctZwq+yn85mhqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618160; c=relaxed/simple;
	bh=AKISzd5iyKCiNSgNN74C2eS4DaC2iGHXlNn55yMvsmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OY8foF0S1ZTmTNbA7BoswRhHbZ44KYjgBg2pKBSqg/Bm9AeyHD+nI2vGGyYSnrcvuyNu0OnwVb6jhs8hwm5RMMChE3dyjh5ldsJJ0ruDJTF7HA1nhRIzxtf5dZfwxS7gKx6Dz0ul6BEl4kn8jepx2yKUtIesdk9xwwg2L6wUafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nkf3JSeH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so7562909a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720618156; x=1721222956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXpfd2wmtmBO96JF5yDlmVCc6EbK2CgZGn/Nuo/rMog=;
        b=nkf3JSeH1I1DFNFUTre5FkhoyHn9SKxwZE3oKyo0JM60ZJ7/YHLH1E5osfOmgB/LEC
         TB4DwIk63lTcnaFa/52dIU0mi/R8FpLyKNaD1vpYwVdrXOA7zHHH9qji+Phxoes3eRct
         N+xARu4+dS4LzV9VwEzrHcp5OEZInxpDaKM57cYhUS/cgZh7SRjh30gII4BOqMiCgqJq
         W/MOa+SGO5kWxLGQKvnOo9WIW2cgqLWex1j4UTUPWXeQAVwbNdMErXVGZGUnUnyxEXSW
         0fJlTM8i4S9z1tKCpue9Psh4T3xzIpGZM1hB3vv8llcMn0cA0lAJlSN8IA0GAM7b7FDw
         EyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618156; x=1721222956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXpfd2wmtmBO96JF5yDlmVCc6EbK2CgZGn/Nuo/rMog=;
        b=voQ9OosLk8JLHSZgk4AN4MxE50XinlhRCr/qKm79u2JdbC00rkPepy3tg0bI3vcUS+
         dA+CV7Cl+FmN63e2lQgE8PukRzpVAJY2crbrTjnRJ3GMshZwx66r082u2y55wbTe/fc1
         h0/s1ZvEgZnGE1bznUcVHgGAW4e8w46a/6TusC22tsVGBh0OUbNFlH+Hgz0Qy9mw/4/G
         xkv+lr9IiiLurxDwAb8LiEKYisKgbwinReBi8MkatYCZ4G9szpfehLd9lXZPqSIbfEK/
         zOz44Koglg+AWO8ugDpGFeG95aY/RMipmukrRPXJ8JvJaDkBv/gEZXiTdRtFbJOxChup
         wBEA==
X-Forwarded-Encrypted: i=1; AJvYcCWHRHqZng4IlYMlMyZk42WmpXIyOHvBiibYcNyliDJeBo7YkAGNe4HYj/NPD4+2YYXE+F+z9WD4nsPaUJC2DG5z0+LT6hhU2B5h87rk
X-Gm-Message-State: AOJu0YzkfTIprr4facTyDMVwB1Y5VoLITOUPx2Pojy2ESNJSkuBnIBei
	u0B6gMw0of/50ulOG1hq6RFqsrxvCVhR44GSazX5XqVWK3gsYBWA/xNC4Vm/hjQ=
X-Google-Smtp-Source: AGHT+IFdiZRQ6U4xwH4ESlWOcT7tTqHneAgzJZJftzH/4QoiYntL7Tm+hCt6+4O1lTffIWQm0nWIMw==
X-Received: by 2002:a05:6402:34c8:b0:595:7c14:18da with SMTP id 4fb4d7f45d1cf-5957c141933mr3328492a12.34.1720618155985;
        Wed, 10 Jul 2024 06:29:15 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a162sm2204844a12.68.2024.07.10.06.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:29:15 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 14:29:14 +0100
Subject: [PATCH v3 1/2] dt-bindings: serial: samsung: fix maxItems for
 gs101 & document earlycon requirements
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-gs101-non-essential-clocks-2-v3-1-5dcb8d040d1c@linaro.org>
References: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
In-Reply-To: <20240710-gs101-non-essential-clocks-2-v3-0-5dcb8d040d1c@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While gs101 needs exactly two clocks for the UART, the schema doesn't
currently limit the maximum number to this and instead the default of
five from this schema is applied.

Update the schema accordingly.

Also, as pointed out in [1] before, the hand-over between earlycon and
serial console is fragile due to clocking issues, at least on Google
Tensor gs101. Therefore, document the clocking requirements for
earlycon in the description for posterity, so the information is not
lost.

Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/ [1]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 0f0131026911..2435c3d92158 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -145,6 +145,20 @@ allOf:
         - samsung,uart-fifosize
       properties:
         reg-io-width: false
+        clocks:
+          description: |
+            Note that for earlycon to work, the respective ipclk and pclk need
+            to be running! The bootloader normally leaves them enabled, but the
+            serial driver will start handling those clocks before the console
+            driver takes over from earlycon, breaking earlycon. If earlycon is
+            required, please revert the patch "clk: samsung: gs101: don't mark
+            non-essential (UART) clocks critical" locally first to mark them
+            CLK_IS_CRITICAL and avoid this problem.
+          maxItems: 2
+        clock-names:
+          items:
+            - const: uart
+            - const: clk_uart_baud0
 
 unevaluatedProperties: false
 

-- 
2.45.2.803.g4e1b14247a-goog


