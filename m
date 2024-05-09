Return-Path: <linux-kernel+bounces-174367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18358C0DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9953F28391E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7514B948;
	Thu,  9 May 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8nGYgy0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C814B082
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247784; cv=none; b=e4n0HIeO6j6g4pi8tsD2BAzjQocn22RirFHBLfEQrfoeXNoxyOCmWzcS8EdsSObBwVm3gOM8BHhf1yLrzYOaBs4u0aGAeHVRcjHnuC2OmFL5IFy0f9MkHWVuNJMdf5Z4zqPar545C9tcXtux47d0ixqfj7yo1VSW3SEf4hAP5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247784; c=relaxed/simple;
	bh=gjCs0DV7B7RR1j6936MwQyQwFKJMltSF9sVmZwvdZPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfYbmEhHnEdEVn9FdAL1crbQtKBlUmdZQGRR8pkfAjj0rz1s/0f1XhTBzU1l4LQ6u7oVuyMjfKiEw8xNtN4d3qVg+QMtXGsDFc1lGwNavzLpyzhTpGrGT5sLlvjMMd1BXApFiKgKCcR+h234y/qjKWZ7K2oDwI7wYkMDQi1QPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d8nGYgy0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so155927566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715247781; x=1715852581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXToc41FJ1K1jyZaFJj827r0wMrkwnVZ3gTS/QEqFfk=;
        b=d8nGYgy0z/r3Blns7ktyIvjGYKvKPLJhWD7M0trh0d4O09vVZ1tiObzP2wzzsBbcOe
         tMOP2bGN79W3XNji6e9l4UCVNNY0Wn6e55SO2xzNfpmT+FxSKIomEpcPIv8Qm1bwktr7
         BfCTqD7V6ogtlCBIuS5DCQt8O+R+TGdtd/bZFQ8T5ZR4JsYi8ZEpuUD8paPZT5oUAXaB
         ScSHVbbO4u6A9NudnId97ddnSF+vSyhDnZjAOSJ6u/XFqj7hUc02hjKZCQYnED52PKTp
         Y/+ygZMZ/lIb0J6Ai67zbotbDkQgaDPmIH3VDWoEgf7t/ZbGyra+i+mcHY9vEgJYRrvj
         EECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247781; x=1715852581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXToc41FJ1K1jyZaFJj827r0wMrkwnVZ3gTS/QEqFfk=;
        b=lfkDK3aheH1lGkMe34UvZpeNiu/1+Ux+VOOuFDG7O065AciN7ZFXs1OUU0GxSk8kW7
         EmTLgprgCYpNvvcaiT5R7rNCkX2qKgi/LkBnhSaZg4v/bF0+2UPFVB43JdeZx5TJqxb1
         +vaCcRO8u84nenPgq6JWLaJfNqjFO3+O0aCq79Jqz6FAV8mQwnc2vGlrxbawaaad4+Tp
         AzzJTdUIQXbMBMxSiZ1JqjhS4XEFlQP3Vwj51SCEll+sKJVVWq9VcAdkImXWwpnXReFo
         Xb7WEeIbQFnphHK3lnBMkA9KTkSTQJ6RK0P/XRNBT5g/4eojzm1rcLXB5sUE79/u+FYv
         fKWA==
X-Forwarded-Encrypted: i=1; AJvYcCXu4SJJu2zNAKIRgevN1R1Ioap4uS/aT2UDoURcFJyfmp8CxpvVwy2jAKW0gH39YnVuZI/taFPuF7Vh+KHmbvHKNFvzFYWK3lwF1In+
X-Gm-Message-State: AOJu0Yz2DisNP0g/19F0FqBbkeB0Qd5dIvI3WJTvxM3fPuw+sb/AViAO
	y/4oAGAJTSoNO1I4Calv5zVxLFSevvluFV7MxKKxJ5+ppe0sElsD/h6k03UWI+o=
X-Google-Smtp-Source: AGHT+IGXROeW0KH1SDJKVClcQZYZh6a7R3plP3x7ydci5rtTGkV/8BOhrB2UWJ5um9j8RF60mjnBQw==
X-Received: by 2002:a17:907:1c09:b0:a59:c3d0:5508 with SMTP id a640c23a62f3a-a59fb958791mr596004266b.35.1715247780581;
        Thu, 09 May 2024 02:43:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7deasm53835666b.103.2024.05.09.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:42:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 09 May 2024 11:42:51 +0200
Subject: [PATCH 1/3] dt-bindings: display: samsung,ams495qa01: add missing
 SPI properties ref
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-dt-bindings-dsi-panel-reg-v1-1-8b2443705be0@linaro.org>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Konrad Dybcio <konradybcio@gmail.com>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryskov <dmitry.baryshkov@linaro.org>, 
 Shawn Guo <shawn.guo@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gjCs0DV7B7RR1j6936MwQyQwFKJMltSF9sVmZwvdZPw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPJqdOM3LXjtcBIPKLbQXLjsQanOWad6C3iAgV
 aMXLVevr02JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjyanQAKCRDBN2bmhouD
 1ybtD/47ueiz6JsAgTGEV+DVeVn6zEvjTIKNZre2ojMqTXekMWCISRS7B5MyObQCQvOHMY5rA1J
 /lBLSVOeP+7lnyE3LfbcYO+yCcHNtxn5496WnBBiGnjgzSq18fuwwfZlTeJinNar8R3vr84Sb3M
 nWVv1yT55ZFTPtUf5IjcDE18xRGZVZPwm53Uylbjml9r+KSfJUHc0BLDmAS2bO+AeNdbaEe3upn
 sKBddMIoKXMo7zvCRDSmu9oXT33URnIunXKQhUk9bwvS0c+6G3iyQeSgnOy+JZwGjoavjKWasah
 TXGmgsxq8zkYSC67ZmJF8Wzki5icFzgLA77n4muRP2TxDExDEJcmA5Vfy0wNUreg2B5nGmEDabm
 2OraygdJPmYP3y6gb4+tSRengY67XafwsnJFgrYkRRcPWLLNl999UAPsWvAu8cIGQf3H8iJT+6r
 zNgdhTgVy3ddV+CxBOhb/kPLZ8o4j0CPGiR5a8KBB0OtZZsOSsknhDAV7wLkbMEKwA6at7q/S61
 PFQx0anPvD8q41vHvCNk0KZ7uza3VDvA83p/uExA/MAdzZlD6xfxrI8DiJRf4vsMOqgj5WOzo9Z
 APkHwUGGEtKU1+giVbE0hHJ0JcAPgEPUPJgbOBbYL/PFF/NRb94sqDMCR8OY9BZiIPqryJjHXUc
 Cv0ohzDrUmUfVBg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung AMS495QA01 panel is a SPI device, so it should reference
spi-peripheral-props.yaml schema to allow and validate the SPI device
properties.

Fixes: 92be07c65b22 ("dt-bindings: display: panel: Add Samsung AMS495QA01")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/panel/samsung,ams495qa01.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams495qa01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams495qa01.yaml
index 58fa073ce258..a5ff4de74a15 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,ams495qa01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams495qa01.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:

-- 
2.43.0


