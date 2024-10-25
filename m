Return-Path: <linux-kernel+bounces-382076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3E9B08BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E391F22C60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3F02064E6;
	Fri, 25 Oct 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vm5YWckm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B26170A31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871014; cv=none; b=Cky2YI74+CY4v3Uyj+0KFS7sn3T26cx1uaoI/oJ8utleUp/2VlK2bsxPO9AdJsTzBjWnXkASlwYebwjRZnqP5pDWaGBQzOT98+bIBdZZeXiJaZn4kHDT79r9VsD40p5/20vU4ygCkx/oJb4tiYAwVnGsrLDHQiySjKxs39w5QeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871014; c=relaxed/simple;
	bh=TMN6JMU+ELU22RUJa8s8JWinmYlzk/gPVjsA1IINEX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeFzAWwB/49ekKO0gwr5FpqkrK7MqNgobvHy3Y2qDi9s9GEqvGQcDsULC4PXNXWAQDg7Qggkp7kHpMrz7c53jUgZsaAih9RicszOrWeIBNX9y0YKbZCX2mMLv2ritI3eOpdB6qeQNJhteN2dj6G9vsTqSNKIqMJbb3ztM/1mf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vm5YWckm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43155afca99so22364235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871010; x=1730475810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz9JTv90G0UOH7uV17u38cReSx2fSx8hhjMRt1/SqeM=;
        b=vm5YWckm/UPkV0d27xqGuQHzAYu4s7Anhqnha0egQ2Y0goqQBDQSfDZsXldT8+kCw+
         iduWZssGPbhC/wvXusvm5auasLrKadpwf1POIWW0mwE3yCcUmZLQFPjyGDSxGrav0KLB
         EuEMK+X4DaM+TtE8nLG50WQSkLFCkaMkRuxrPNpV78ySWTTPWwKPhiXMN6Mvu5OQsw6z
         nD0z7dTGtu2MCnHY5tztz4skPPjpE0+avEKq85cSf7HqPaI8FDbSrwNU7Cg6RScq59zV
         6cLggHjDrkQ4xIEP3i6ccTglFO/8FQPSUwCaNdz1CoBUdbMdorPBnNzYGwEnW4swAdeE
         3wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871010; x=1730475810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz9JTv90G0UOH7uV17u38cReSx2fSx8hhjMRt1/SqeM=;
        b=Yw7I39AjNabaZgX1TZFSCX+jKL/pbk87F/SHMcDptwgCMKA8hguJoJrYF3VDiGVlY0
         yOgIQS7qJi+bOG9MZPHaAbAcohmuUaUPelZ31cky5f/iUu2SPT/qV5kefAPykVpEfEr1
         VIgsD7aT+i5jrWg9Kl5IA0nscDYaFqJfzQ10FEFlaBbFSUB9v+C7WI/sgfVluHELlucm
         Zx7hOkSvRdRJ3tJcFigZdtkUPSE8Hgtp4zLaXKGg4QQyIp1LoiC1BcUYRgrhcV/Pd76U
         YTkIoTAz3cF1smCeqUF7BWXXMT7T9xRaTeqa6mHqJrnS5ZSPBUshMopAiaDWQ7AxHHZ2
         JYXA==
X-Forwarded-Encrypted: i=1; AJvYcCWSzqKbkdwvACrmbhKpaXiPmFI48Lut6v28mDl9AkKnzyJS1sJGJnRWp10v4uY55QNvhXTXp9NfX9Fs7n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnkip8DkG6cU3sa7cSV4M9FKrpUK0KKIWY57zLhe5kAD+x6c9U
	R7fY7VVeSf84TE+susxJHAm6g0TuR3ubLNBq5bge7gtsPtdTwIQ6f/IE+nWmaX0=
X-Google-Smtp-Source: AGHT+IGPOU4o+DdUjVCWnL7JS9IH7HmxvdfwDDU8AOfVGJ/f7IhYz6MufADd7A7e87RHCOn1hSIJDw==
X-Received: by 2002:adf:ef8c:0:b0:37d:3e42:be32 with SMTP id ffacd0b85a97d-38060d9c088mr9410f8f.0.1729871010150;
        Fri, 25 Oct 2024 08:43:30 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:29 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 25 Oct 2024 16:43:27 +0100
Subject: [PATCH 5/6] arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Add
 cma heap for libcamera softisp support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-5-cdff2f1a5792@linaro.org>
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
In-Reply-To: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>, 
 Vikram Sharma <quic_vikramsa@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

libcamera softisp requires a linux,cma heap export in order to support
user-space debayering, 3a and export to other system components such as
pipewire, Firefox/Chromium - Hangouts, Zoom etc.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
index 5fe331923dd3cd31ff2be047a2228e1c4104e80e..ae256c713a36078afdadc67193f381a19ea8e5d3 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
@@ -9,6 +9,17 @@
 #include <dt-bindings/clock/qcom,camcc-sm8250.h>
 #include <dt-bindings/gpio/gpio.h>
 
+/ {
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+};
+
 &camcc {
 	status = "okay";
 };

-- 
2.47.0


