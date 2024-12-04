Return-Path: <linux-kernel+bounces-431002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B39E380A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34766285CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0C1B3945;
	Wed,  4 Dec 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vu6mQD82"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80181B21AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309821; cv=none; b=VytPV3oIf/WcoAhKxsKjxkGCsYvkymRirDL6cJIdLdVZRbF6Qw+T4RwcY04kf22zA61gbDazEMWbUGnRu02QnJuDiwChn6/3rt2BdJaXVFHqIsLEALwjk9DPAxS4Ugn2S06r1yCQEYN5IpXT3ksy4m5VPJk4yngtdMH28vwu3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309821; c=relaxed/simple;
	bh=9zCQPGWbbtOrQGItKo94zlUyzqF3jXY/VuyEQsqsAGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maaZsEeHwl9gWwvMCgWIvpU5q4DGJAFtkswiKYa5BKwVRbazESE++AZNJZfLn72TFCSXoViMsnBUYm0OX8ss/g5eWE9yW36euM8NboPRbdNIIYKjo67Zj0LzzEhljLKYNmynhr6hT47aHMFtzJdlThqS5bf3Z70oXh/HO+RJ8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vu6mQD82; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ea29eee1so2786642f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733309818; x=1733914618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUW2XCyWmw1iPCgZkGbC0FKwKSs27Riura8jo764vG0=;
        b=Vu6mQD82P2aP8hZuVqXl4kjNqxzMW3xqoNGAtCHZr0N4KPsJDkwS5Z88GA/L46ReC1
         lyIq7F2Ups7s0uk2nF3uTMyfMkhJucpPIloyMr+LykDYDTtwo70xxEFszvT5aW5pFQjG
         w0Ab2YROXPQRmG9No63Am+dbrOLFyFOKnN3KqyEecEptGZkRwjOovxWj6dM9YBNpUSVM
         Bdf1fuF3bD8chBBrfMzrJmruMlpYMVYwUPDpNj1vex8aBidO29DB4s7D+ZJJEZRNmkdI
         fF9IIRNwBcswnHLU4bJBEpADzHdKyebM5IyHozGVPHLS/WkHAy0fJNAjtKjLBjmj5U/j
         Uhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309818; x=1733914618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUW2XCyWmw1iPCgZkGbC0FKwKSs27Riura8jo764vG0=;
        b=bEuHAl0ZkH7EQZBuz4tuYbWfJx+WeETGmNYZbWtFlrtje1RiLAPJhE8L33aVefwNZ6
         kNw/mgT4AGpmzKk9zc4eL52N/lWC3RzPLFDVJhA/WtJk9ERQV+RUgc9PHkmGVuvoHYp7
         Hkod3+lAoM8ukUEihiST4vfq2H8aTQCLwkwnzB7q/22vKKr0aB1x3ktlWUjnB8zPSXLe
         JHjBIbTsAXuQPNbPcqkkEgWthD9YIv70rDmjwSyb9WaH+3Who9vAQKo5Wj+C51S1uMfU
         wU+UZ0h6wg201YiLmATfCB2eGJHy9U2oNUS4wqXQVaaaSrrT4yWybkBWOWRYO6JxjQMe
         Tm9w==
X-Forwarded-Encrypted: i=1; AJvYcCU1sAFNW/NCP5APqmlmEUdwpmhC+bzLdGCjNP0iJyStLK0wcrUUP70Vd2YIbyEKBks4KM7fpyMBCAbYb+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqhylh3xJTZmrZcHxdloQweQ7mX2aOgpFdyd1h8xH021pMkDN/
	FqXC9SmYwARks+Wt8LtYcNUHdHIFdFR9uIbVL1wxbZXSp4YCFfAfgTwa2mPyFJ4=
X-Gm-Gg: ASbGncu5hvLUpla6Qsg5dZv7CHoCBCuqGwk0SUYW5T5So9tzzJiL6o8cWHaaM9oUPBl
	NTQB5u6c997I2DPIXgcJU1ci89b62rtX9GreBfQBizhcvT5sdQR6FurP/5DOEUzmK5b5kM9OKLK
	tfZpU/6bzpvHahMKhhCdfAG22J+m1ZnhqfxmJtwUpGACuIc/54hJhmZgvVZScT86R4f7NxwSIHo
	VXLHPHjLUstXMfUFXDJRbJGNvP69komK33Qg8VdjDsQLXtoK+ZGZTE8J2lUCbHfOGU09PA=
X-Google-Smtp-Source: AGHT+IH0QQ0GaNidP9wzDojxgyKHpijAqkmxmojjF+pLnJ7cu6XoaMA2+6NRIYX1LdnwHBNlcMGCLA==
X-Received: by 2002:a5d:6d87:0:b0:385:fdc2:1808 with SMTP id ffacd0b85a97d-385fdc218dbmr5175425f8f.40.1733309818412;
        Wed, 04 Dec 2024 02:56:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm18459063f8f.77.2024.12.04.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:56:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 04 Dec 2024 11:56:53 +0100
Subject: [PATCH 1/5] arm64: dts: qcom: qcm6490-shift-otter: remove invalid
 orientation-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-topic-misc-dt-fixes-v1-1-6d320b6454e6@linaro.org>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9zCQPGWbbtOrQGItKo94zlUyzqF3jXY/VuyEQsqsAGY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDV2u3sl+g9N2CFbmNHmFha1Xqq5cMJM7pL+c5nS
 lW760jmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1A1dgAKCRB33NvayMhJ0f5hEA
 CpSSnsPnTiUzBNxexdPFhIsMLSOT3cHKpwA3W7ZyMuBwRRzQfS1/cn4jRtKlfZQSvoFRuRqn93Ig2Z
 NRXl0T3DTTeoXiC5/aCQvUPIKVfgaULvbMD7m03kzKbd01o3XDsPw27aD5QgSaBMOrFzhokCNiKMt4
 sRG2Pt1eAE7RcuAJmJMI2J1qK7A3uzcEL9WTsl9ljrAzLodgDYmJlI/z6eheqGYL4f1Cum5r55teyt
 FQdwVl8+CXeO/2ubIABrD3OdILtXMOJfujeAERXavCZmDsIIVsmX4Wc7an2U+pJuRaFQGyPXr8d3ax
 5LrNRYB+Stchzbm6ntJ4Up9s9v58jNOVFUe7dLfkfJnpm3ZenZDIKGONiIxYbPZ2f0zW4yh3j0EZLB
 pHzrs244F28Ra6By2jmTLKZP3JNSW/IPEN6teeDJ+p5+JgoTofFGJzu4tLRLH4zCZjaMc7mOM6viZn
 HmvuAsXVRDvCqrVm1IZ4/XW23DcqhnT+JXg8YhXCDE1uiv3w5fvSs9q9AiiKTo5FGKwolP1QFATa40
 /amghn3XKrpE7s0GKuSLlT8GnxpZNa2+a6Lb8DFPwmdV26TjeEEnHKHRX7leoUzQan9ypr8OJ2QhBe
 rjAxx6z9C3ZrgBJLs9WJcvWuAo5mray3YTMms+wXLlWEFLuQ+hkV9mu7VvBw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The orientation-switch property is not documented in the PHY bindings,
remove it.

This fixes:
qcm6490-shift-otter.dts: phy@88e3000: 'orientation-switch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 4667e47a74bc5b0f01a53beb49993d238b13c4ea..75930f95769663f6ac3e2dd0c5f7d224085dda40 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -942,8 +942,6 @@ &usb_1_hsphy {
 
 	qcom,squelch-detector-bp = <(-2090)>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 

-- 
2.34.1


