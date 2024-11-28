Return-Path: <linux-kernel+bounces-424430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF609DB443
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4248EB23B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223D15443C;
	Thu, 28 Nov 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjU+7hgc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0F150981
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783892; cv=none; b=lXbRi0+lzgmp+0F5l6dspsb30qFqYj2kC/KnTTre0Nvko4QbUwDJfxMXCNKUwMU08NU8LfgTNzEYG9MAK+gbez6K/Qr0vONICyTwCaykSuDjUpUJPT46GPWRxuLFqmpx2siTObvTKLybpAE01QqTcx49ZaWPDGuYK1mHCL/imQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783892; c=relaxed/simple;
	bh=pekj7ECgVOlQRe4vr1N9uGVIr7LGMONNx11ziceMBM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iQ068oSKvjQGigQ7Z6Da7rFK2Qc+UsLOi62RsapYHTjWecmLEAyA6C/TupqQu0k6JUbF8eUvRJNPdtlt2WW82uuZ/Iyy8/HcPkY8xxIRxmuhQs+fYJS4trJUwdLnfXQX9JO0ytE1ePrtu5ou1fsM6g0Ch9z/rsybZDe/x32scAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjU+7hgc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso71963166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732783889; x=1733388689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svMXb3youuDFGL6heC/yYUXnD+Ef4KL/6L2Ux/La5Xs=;
        b=EjU+7hgcUKik0obu3+xJUnTxKZlHidGDoxF2c3OeaxuJ5/aUtAUgxuDecfMizRQNzA
         MNyKyn1hn3N1NGMWC+9O0jHnBudKtc16i8fC11rPfehPmwnqys9qt5UTANMjZH8wir4X
         PAX41xujNd0HG1gNnkfjBCsjzENUooP/wZBelnuF1kqgaLEEwNVeh/TCLfhuztNL9oEk
         2apWfD0GlNBs+XUajemNq655a2cNBYEFKojzx1p6rltQcnbUceED7R9nwOYPQETc+Cdw
         Na4WTjbLFfeLJzkbq3UmyHIbA6U3jNGQalmXpm6p62uvtnS9g7f3rMQt5lFYHrO/wO+n
         6UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783889; x=1733388689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svMXb3youuDFGL6heC/yYUXnD+Ef4KL/6L2Ux/La5Xs=;
        b=f5FzqGevc4AaHvoZrwvRkCv4PKwQwU1KxKTl4/6XGNHD+B6UPMpEQlJL/kLBko9ChO
         aVNJ0v3AVM6SzjmkqASSZ0XyvRRdnkgBHPAZ8LPDo2snPWjIFEBu7wsoFVcegucpjFJd
         piudxVr+0B3YxwSXcmIHuXkCIfxzSXkYXKheLz0Rh7RmvQAgYujeIZVgeEDj/3VP32MZ
         vwtjw+Q1XY+JBhsxri81X6H0n+JiFIFgMz8Y18qWeWVlTebHNd8R56mTEQ68VkfDYwkO
         7+Tkgo3UkirVfXxCLHKsO9BnZM6hJbMdTY6wHXjGOMNlre2kwcPeepAl0ryfX4DYRMe1
         HQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQtF6gmjp8ZXDbuLzPFOqrWP/1POIiX4ruJ6z7nanb2kMsoZAFnIIKsH/FWfg5Ic+SMHzXDt2EggqcbO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDblQaL1Rb1H1kQ/4lk41jkXXytvPVO+i3C+uKEvEs+OcLyDH
	uL+fsG6Ai3w8C9kiMzLMif/VLgG9O2vfw29B+OziuYSuPPQclo30kXZwJzO8ffY=
X-Gm-Gg: ASbGncsUM3baos6yXM2pSikSEc0MGlSb9NuKbbphzo2VXUNmH+8kuKwoJuKG7wRXdZv
	unze2Ce4U8m/YRjbuVkFHSUwMPjYVnYloCdQ+W9UKMNek7Gmbh9ozb1cvpEyW/mNzcyPF0I96rO
	P8SA/dczYTmHEoLJZkPn2AOtJrJc2FPqJlbAnZDZHMCxFrsal5NUX7sZtwPoaj6Yr1IWiFuFFFh
	AWq+xNAjJ4jUMYTbJt8NpXqVJ9d8Lawvp9HXQs49rmDvW0wSj6S1zH3RLfB0lr2YTfVPTgW5p1z
	J02SwOzqdF2+Vu3jBxNpNI/Z1DtlWofw0Q==
X-Google-Smtp-Source: AGHT+IHx8LJTIGLe7CuREVHaEYs+SJeA2ZjAsRSIj3tP9WdyNMZcBvOS/lqhSV9U2pCag7lZx5Y7xQ==
X-Received: by 2002:a17:907:775a:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-aa580ecbf60mr506696766b.5.1732783888949;
        Thu, 28 Nov 2024 00:51:28 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a7cesm42131566b.162.2024.11.28.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:51:28 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 28 Nov 2024 08:51:04 +0000
Subject: [PATCH] dt-bindings: usb: max33359: add max77759 flavor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241128-dtbinding-max77759-v1-1-733ce24c0802@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPcuSGcC/x3MQQ5AMBBA0avIrDXRKsVVxKI1g1koaUUk0rtrL
 N/i/xciBaYIQ/FCoJsjHz5DlgXMm/UrCcZsUJXSUqpO4OXYI/tV7PYxxjS9cDWiQ9XqRmvI4Rl
 o4eefjlNKH2C8F75kAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

On the surface, Maxim's max77759 appears identical to max33359. It
should still have a dedicated compatible, though, as it is a different
IC. This will allow for handling differences in case they are
discovered in the future.

max77759 is used on Google Pixel 6 and Pixel 6 Pro.

Add a dedicated compatible to allow for potential differences in the
future.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* collect tags
* split out from original series (Krzysztof)
* link to original series
  https://lore.kernel.org/all/20241127-gs101-phy-lanes-orientation-dts-v1-2-5222d8508b71@linaro.org/
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 20b62228371b..e11ede3684d4 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -13,8 +13,12 @@ description: Maxim TCPCI Type-C PD controller
 
 properties:
   compatible:
-    enum:
-      - maxim,max33359
+    oneOf:
+      - enum:
+          - maxim,max33359
+      - items:
+          - const: maxim,max77759
+          - const: maxim,max33359
 
   reg:
     maxItems: 1

---
base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
change-id: 20241128-dtbinding-max77759-b3ddbd264544

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


