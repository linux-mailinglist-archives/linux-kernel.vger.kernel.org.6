Return-Path: <linux-kernel+bounces-570820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D310DA6B4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014847A9792
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168FD1EFF8E;
	Fri, 21 Mar 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDn4YPNW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0441EF0A9;
	Fri, 21 Mar 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542116; cv=none; b=uhEXVqwuxsSNSUBAsqcyZwGvyDymBNjOYSKyR+QVT+dkMZigYHgdcwPWtrI0N7Unj3Bs/rpnr2YyY4yK6MmFly0Zx3tH0KlE4mkHK/DnTD2gkpL6leOWm8WrLDog0KXPdx7Sn+nIO8O0p7F2NAZxeaK7baUEncUV5ghwBaL6uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542116; c=relaxed/simple;
	bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gIkGdP00NCSogTDf/nyWmqeOp8xisWpAVXvbeCP5jz4Sq9roZsIE2XDm0qajtRKSobEjlXamP7Yv6pydwt9NNkR6U6ExqoFL2Xo8gookAS8KaaIbu64qENsmaZu6igXsb7JkkEKdTJBpNko/jO567TxLG/RDQX2Tu3e1BXYC1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDn4YPNW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2235189adaeso31194855ad.0;
        Fri, 21 Mar 2025 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542114; x=1743146914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=DDn4YPNWinAwOKSzKG46csI5buOynMFr7ANkRMhUdJS/a0Ad5Yzpxj0ld4FwiDhFfi
         FO6NZJkSYms9bKj8bMsSvHqAaJwd3xYe4pLbjoK5ZnhOQgH4izMv1a31UNSXJ+6BbyXs
         8KRCY4nAyMN7K+CUjJ2NPIic+CAwZURiJOHnHhPcE3oSOk09ZGlgIUVBr0zZFHpejLQU
         T5V4aKGfiHAWGUWYe/G/bKvuhkLzuXGAXrGP6jOwEgu/2AseCVoCCuL1IJZPx5BWDEnF
         A3oJpbWjKjhOwTPWtKJsErMl6/HdjZqKXf8jKK92PRlxFY7NdiBs2TXaR2mno9tFNqXM
         jH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542114; x=1743146914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OyaXbL0WKbLYpImlnz0xJZmG54ud3JNw7Cj+unigE=;
        b=az4v+IDHHHuICTJD6zyjRuOA3i0Vp10t7pDqLgbVOfKDS5+EqgmeWGCTTT4xDh11zZ
         pRkfnwHadY77jk5XbGZWsFDe1VIAvXhUztZji66HmYuYHrUMfps4hDTcScbj36GQfFJH
         a5zBFQYc/vXB5TOwr+fHNgSANsretf/HMY18+3LTOlrMhV0nv/PLa+stfkG+TBTFjY1U
         o4i8oVBoj+sC3H2RI1AsDBlb4aSAFal9hc5+zK7TJX7oZafQ3Lh6qWHTGfUVxjDBkEMa
         qnO6C8zVbsJ/8SOlFTLHO4Y1Yr3rA4q92vXezSUSG9+X1Q4tZ+kmOnTtA+RB09PP4OzX
         TbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXSPaYE7qp+5eFlWQmu9RRL0tU9DTBmvmu0gvWMyE30rQ32iz1M0ppScmt9KdMcUbgMcq9E960xcqhdeDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEh0eQJmEMDsx9BE0O0MvQpM9jEbf50sXiTl0naNg6O5cvXNU
	/EKU/fvJrLcCbLUWCNNNBMsrfq9weteonAlCS1ZIBwKu/0BTwW69
X-Gm-Gg: ASbGncsFz1EOU06NEPdzueajIzgpCAkQoQ9i4Lj7g2f6uAseG1QMFdvvz7cWfDO7Qj7
	u192zAyLi2WMxbdSqJaK1X3Umiigb+3otDbPMyjSMb3MoA3ruhvMOnOVe/9H5hrfdR61DiKPRCO
	BN9V/maGMMWUnXE1ke6mE0TKoNnRmRnFP62UnYRcSR+9qEVLrGFPpoZNjgQQODZRxIVb3EzTZij
	mrXJKWBhrGmuJmKNlIu3Mg0kVLeyII7mJXBpRhytOQKOzYWkl0O9X3Rt467zjRB4WVhsEnemH2N
	EJNZqA8wuhm60dz6/b/yqFd13NRytbu3sq7VvR5edALG7WkFkeWoc7KIBlcuLx9nXN3B7UoSJdj
	3GFp2waIk4xjEAy5QuInSXA==
X-Google-Smtp-Source: AGHT+IF6B0melgd9ZTHhX9+OmeXv+v7h26IaVqxBaObXnrdTWrN/Qr4WVVvrYpXTWtPK3QkHwoGXhg==
X-Received: by 2002:a17:902:dac3:b0:21f:58fd:d215 with SMTP id d9443c01a7336-2265e6babf6mr99928505ad.11.1742542114211;
        Fri, 21 Mar 2025 00:28:34 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:04 +0800
Subject: [PATCH v6 03/10] ARM: dts: aspeed: catalina: Add MP5990 power
 sensor node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-3-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=843;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=BbOh4hpBKP+yiYoTLN8aSP+ooMjZZlQ3ZAt1eegwZSA=;
 b=2JhrlSHvGwiwqPQm1ccY/be+hyH045aFSjhPcwPOkWU6/+9JxEdpWxKu3JcXk8yp85n579LF+
 KNdtNGtkVReCfztW3E/Ip078gcE0yYTcAo+88IyGSxSDQ0th+cDxzBZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a device tree node for the MP5990 power sensor to enable monitoring of
the P12V supplying power to the fans.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 307af99e833c..f5f47245796a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -428,6 +428,10 @@ i2c1mux0ch0: i2c@0 {
 			#size-cells = <0>;
 			reg = <0x0>;
 
+			power-sensor@22 {
+				compatible = "mps,mp5990";
+				reg = <0x22>;
+			};
 			power-sensor@41 {
 				compatible = "ti,ina238";
 				reg = <0x41>;

-- 
2.31.1


