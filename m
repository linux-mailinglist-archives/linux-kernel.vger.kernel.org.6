Return-Path: <linux-kernel+bounces-174420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F62A8C0E76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AD11F224A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE7131752;
	Thu,  9 May 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vX//XXhg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C0130A72
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251713; cv=none; b=K7MupkPE+nFaSQaE3htFYTfJLTFtYuNHWKjxDwD0wgTH1kCWXhaQMRXnC4LEPKZ8PDKcPWtznWH3rGnI1LIq8d7KJzWxnqBzN6Ev335r5sOZqpjHVoemy/aRPMcr6YJgRBUrRY2ZI6Bq+wZMAlIVmL/PIIcLjfu7+4AmVqaxKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251713; c=relaxed/simple;
	bh=PE7mtrBUhQs6eNS3JaxNEqj6Z2nbuCS/IxoNn5x0NOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4AUYYyYjTWbIe+mq9ae798kYiE7568I541om/laHNJ65iTS6piFzkDI9xXUjuc9R1pVSQ6GERot8wE0fR/jxLrZ8+w2xXv+YXbsNEReoyM+DRdqziS/AfAvPYSb2Vs95UF0gwUlSw/SNjx+wW42HFG+EE/hNPeBog5YDk4ylWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vX//XXhg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so166233066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251710; x=1715856510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw88AqXpf+K411T9WDpv8hTZt78Cn4Kd72UqXrKuG4o=;
        b=vX//XXhgLqg+PcAKzhasLOzR+i+Pr9pnj/+HEKFbIyAa+JkK8tA2l95gEWvrDpYe7d
         njPkOr5UYCYd8aUPm9ojY9dLgMUbxdvlFT92lfE/eQE262FCPt1BEt37CyFtj7Dffiht
         97CN4VSp7kkdZK5H4IHxNu8Bz841IuaNtiyEvZpTRC9WOdzD+f6Cymnv3JlFSrLvO7xs
         X2wPKTOM/3YG9hswY7WaJCS7xHD0oe4dzU+3YmdBlyyBYU6WRQM3D3Dr90KPmNbRT1Mz
         yPqx1vBFCBbceEQRchjs/4hhk4DDIdWN/FaXnNr+ibUK1QZpB8PXiHqttocvDflEcsW4
         9kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251710; x=1715856510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw88AqXpf+K411T9WDpv8hTZt78Cn4Kd72UqXrKuG4o=;
        b=mtHNUSYS613zV8ISbTwWQ/3X4fvXiZoOduoyqbaCQeORH9yPucTHcsdxa0ZyyuT/9H
         xFUY8Kza/mJ61dbHCT3d3XQHFcqCRnzCWrBLl/ZR4GS3j63OKzaEQmPVZ7W8Dl5Oj5Kh
         Q6k7PTcflv9+lMly0pZ6n8E1xgq9KTYv5Nw5IacN/PN8NEyRHD3x+ATuTU/7tR5lbY74
         WGhobJ0xJ6bzOwISpgDPlIdz0WT+ZeCpMBxDemgkTmtWbCYoEaWfnLmcxnLypWVRm/O0
         oUyDE07CxZBy/xZ3ODd9VFzrLDB2gUMCBh5/2XmT4XY/iGzl5NdeJwAbimyPa+XKus1t
         HyBw==
X-Forwarded-Encrypted: i=1; AJvYcCX0zf4hIVJRl0jYyIUrKGWRQMzLISUdp4aTBgU+ukXKlAFN9o2emOKmdeHbhiWvMCbT4CG8MHPbnOJKJdtWpndURQBRYqDQ7gl8xqxS
X-Gm-Message-State: AOJu0YwzxOkVzEDpGsbbCBAhd+jHmv4+9B4X2qbbDdX/wBofwgZtbu0Q
	OkApTYNmB5NcAjFdm/JVk/M31WIqjWZZAvtBjxOnbuuCTBO73X7dum90DrfDSuE=
X-Google-Smtp-Source: AGHT+IF6Kj+Tt4zZZKJYOj2wwBFnuIMUrXZiJwepWhs31vPShiC8E4zlHD7+UStZt1UhbvPPwqJd/g==
X-Received: by 2002:a17:907:2d26:b0:a59:cdc9:6fdf with SMTP id a640c23a62f3a-a59fb81a21bmr402912266b.4.1715251709434;
        Thu, 09 May 2024 03:48:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c822fsm60017666b.138.2024.05.09.03.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: cirrus: align panel timings node name with dtschema
Date: Thu,  9 May 2024 12:48:25 +0200
Message-ID: <20240509104825.216696-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects panel timings node to follow certain pattern.
Linux drivers do not care about node name, so this should not have
effect on Linux.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/cirrus/ep7211-edb7211.dts b/arch/arm/boot/dts/cirrus/ep7211-edb7211.dts
index 7fb532f227af..808cd5778e27 100644
--- a/arch/arm/boot/dts/cirrus/ep7211-edb7211.dts
+++ b/arch/arm/boot/dts/cirrus/ep7211-edb7211.dts
@@ -30,7 +30,7 @@ display: display {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 320x240 {
+			timing0: timing-320x240 {
 				hactive = <320>;
 				hback-porch = <0>;
 				hfront-porch = <0>;
-- 
2.43.0


