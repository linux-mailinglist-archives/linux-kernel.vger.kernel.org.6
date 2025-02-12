Return-Path: <linux-kernel+bounces-511864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6FA330BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A54E3A6F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26315202F88;
	Wed, 12 Feb 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfXQ7ulc"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E9202C2A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391807; cv=none; b=mYK4uz+bbLvf13T/P4uN4bkWiEkB/3SrH/ZfPqu6pJnorsDrLnJC/rbQHRWgCFMabmfdXQBD3Y42mluhzaYTTIGa9Jf0oUEoDb0/Araj6aBbe0rgmvpI3yHK0NQdyJyQ9/K5l6xa/UywLzg6p7AiO8k6d9TnoBbLNEgHI2e9aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391807; c=relaxed/simple;
	bh=Y7Py9ATmugAtvfRo/YsRM3Wtk0WTgGLNgzgMx8AaCBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qU5mfSe/RiyadBwOhISE81C62QK2dQKFdIpeFoiO7LFM3RhIJNvDdP8TBoWH5CW3tTWiIdjIwtaNRa9VdsS3IcNzp6ssSSuHuR3jaH0FEhR9LbvDsRSXn9I5wdJ0KIP1r9GuyL6UDyM1woyqW2Me+oPyy4B1XhTGJ13W0IIstZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfXQ7ulc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7e08f56a0so3427766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391804; x=1739996604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1ktXxniTaO34Ok/Jjo815DE8byVSW3KIGjNme4BebQ=;
        b=wfXQ7ulcmI50e/LZ9KhSWQvCQaIKWNFtDZTtl26SU0xTl4YH3eEr4KYdKaCISHfJ3h
         9PG8wtdVjWpRluVm3RLVTc/s0O567tBx58W8fS3j9x83ZLu1ytmrtdMocXEQWMA79vms
         Yk/6oPusukF0X1BN1sLKbv1Pm0YvVOaYFQw1fY86ufUOwk/dJqt5cHEeeA59ljB8T2LQ
         H+hyZhNmDHFLjn5bskRXHQ8L1mN/+rd4sf4jHv7eJqaHKgJECxQdHg1Rq91yQZymcJIZ
         7uN8195CuRd4u8Uoh46mD5hzXL/BdXLlbESh+AUJW4sr33w6nNuvjqfP00dJpT/KZb+u
         X0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391804; x=1739996604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1ktXxniTaO34Ok/Jjo815DE8byVSW3KIGjNme4BebQ=;
        b=dJnW/wLTsbzvd78doPw88yY5ctK7PGMmMg1j3r9irOCSUPZZJMFcc59uYhawFrj2Fd
         RzbvElocYD/vX0NARNYtZMPsgvdIm9BMIHEAHRW9Ffu5v2aF032vGNFCKxWD/oBYfuGT
         CRJ8/hec5sawhijDEGY5E3S+Wlc43lyC6iYF8+zSU+HmJKh7SRzGEBY3KEUyxNr23zSF
         3gSkX25HQPBnJ8YmKq0nXaKQ0SdiglalPOIj8iZfhvyWIWvE75DwOzasKdtjxps0TTkP
         bLu7CGG1PjxV1EjQvQdGDzQ/iN370phOHDSqT/gcoaS0DvhTY2FzpVjF406O8LkBLI4r
         a+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrxRlWByZdM4KJXWaKqE/1a4pBf2ZCB71Vx4ncis+c3DR/cDkQGaJcdsJbcHfeuapSIaDE9vKYdBmtnmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWjLSX54UcaJCLf6HLKizwNZEwqOHiVQHy9lue5Z+eotSQt5n
	jGJAWKsv0KX6MY5zc4/H5WZLIzbJpG0eIG9RwKkfK5a3iItgtieKng3ZpJBFVFg=
X-Gm-Gg: ASbGncux88zs9Jd3fNr/iwt6ipT+hdvGn/V/s8dkw7x8slz8BQCukQwABXf4GgzAhoc
	XMRDoNjJUpLkGtWaTWuuvMmXHLrH5Fs5pXeIKWm2deoMbWFDcgOY0tBVJaaXt+qiMfo8h0AvCDW
	ZpmvBqlwZYLhtYU24OcDIabW/Qk9y2Z7QEPg4+Crq9ofLTl1ljZw4bazY22W9YUMOxFt5Wo1qek
	V5T13iNabdR+Dv2Ti27M6oIuTxtkGt0HFPwk7KA6ECojvt0/AehM/Qp5bO3KRMBSlUaFFLtSSUs
	fUAhMXR1zXAi7PTRyRrMA5EoK89gg6M=
X-Google-Smtp-Source: AGHT+IFRpSUMYPF4YNEB5Zi/KYOX6fwGnrb6YMONKk+EeUhrI/Id1Fgyz8LuPVonSXr+rPG9JLdeCw==
X-Received: by 2002:a05:6402:270f:b0:5de:a752:3c87 with SMTP id 4fb4d7f45d1cf-5deade10d14mr1536257a12.9.1739391804037;
        Wed, 12 Feb 2025 12:23:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7db5ef658sm419660066b.42.2025.02.12.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:23:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:23:14 +0100
Subject: [PATCH RESEND v2 3/4] can: c_can: Use of_property_present() to
 test existence of DT property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-can-v2-3-ac9a1253396b@linaro.org>
References: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-can-v2-0-ac9a1253396b@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Tong Zhang <ztong0001@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=967;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Y7Py9ATmugAtvfRo/YsRM3Wtk0WTgGLNgzgMx8AaCBE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQM1+sl4wzbdwRrzrhQ3QlIBLfgUojQ55zwxW
 eupbh7bfOiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60DNQAKCRDBN2bmhouD
 13DpEACQXKvVdWqWAnHe5O9+unybcjv9drcuCX0eHxZvFoHPKIx55rPYXwcoHzAMSP3NzHMOYIk
 0szt7ud92zwqvSmK72KZWqucu7PlfT3JkLiCl3N9TU9ab6b2wYb/ikaEPWZDVAoXB586ep878wV
 n5ilpz+mH2Qge5Be06dPutl8ibSusfIQGHNWqBKzRtXZlYHhILb7bCeGZPd68olGmoKl7ejx09a
 PnzFvzEobEIoCNlOH2f0YjqggL+gz/doMfCrR1dek5InTopLPPaqzfO4fJC3YMLuAuMJ2LxaKKZ
 Ayj16Giclynwa5UW5vPbd+/bZi4PIIvic15orK19qpTz0exTWcpumGMExhLJkBVQi9cwaV2BmYc
 3kTWZl3SLBq9zfC97y+gmKCbHggB5MfKpUmdsFr0dKpClwOTYaWWRImGE1nZF4E9ju8ghTSMuhi
 mjUozujX4aFWxmeidUVBTpxNp2uR7h7SpbAumBPDCMt+M68FAeo8jsJZB97cnv3HaiCeO9dVNbG
 F6JL8/bM2uLnMvyhjJqyyPFM/59uT2RGYY6hVo1K5w7uuFkwwJAwQ6BqXpABzpP3W3ciwg7syvz
 L8KPZcCZtCwuLtIUmU6VwopW9YLC0fgqpc9/84aQjyyRqY3g3kgD3m1snqIyyNITqFg8B82MA+Q
 PUpGK/wdYSpXr8Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

of_property_read_bool() should be used only on boolean properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/c_can/c_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 96d1225c41d0a93627015c4582c1ef1565f53174..1acceb097c17fb7c0e2095a43d926d9cf802ebef 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -316,7 +316,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 

-- 
2.43.0


