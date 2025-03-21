Return-Path: <linux-kernel+bounces-570824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FF3A6B50A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0544648794D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F461EE7A5;
	Fri, 21 Mar 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSmjAdzt"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5681F0E37;
	Fri, 21 Mar 2025 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542126; cv=none; b=hlSDL1eKhzNXsvpbXFixIWR5dZ++330Pru3bV1A4oFAGARnIgl1Wgg5+Cojai+MSZfHjySKTfsNlwyb1CDXtIzf+h6vN8ljFoREsgJNkCAGxUPpky6ozClba1JdkOBTLB8lHeP++Mz25EiggkaNPFEc3h0QlNwUmrA/fEgug6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542126; c=relaxed/simple;
	bh=sycCkrcM+LJ9UbAjzsXD//ULjcrkdN+dexyZS9F+cjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koqZnM2c5V2oJMNWfq56HzzoXU8YbnFehBMLuzu+lG6wvy5LML4bX2OSUWBExfrY9RPWvFqEUozLFGVIBkRbn9ufdbhzrB276ddqPhyMpE9PogG0vSRkZTpdhmcM3z2zgDZtujvgpE63zWA+Jt6yjtq5Jusi0UAIPxTfTpzrCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSmjAdzt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22548a28d0cso4109315ad.3;
        Fri, 21 Mar 2025 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542125; x=1743146925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLcbKMhYk8uxEh3mrmQXm9xuYwIoSY7sWCRiQyf3y4g=;
        b=mSmjAdztMtO9fXQKSvSCEVbjB1W6VoJzT37UifRJaj8ROWUmqdXb98TfyFnRQeF27O
         c+vtlPAfF2Gp7x7ebVyAy36l0I97XhC/w1yuWwXsiggimgkchEmajmQPDn2aVkT6/03O
         oIPJx3ooReqeAss/6v4rSrOZZodnGK6A6Ltb3xYPe81ZDsEN2baE9SMS5+5mYtM81oSx
         oLcH9BNmSuw/GaAlEQdIOIwskxP2jxfUJZhOs4VTfQ634hpBBUv8LCMsYu7cxuz7VVdg
         Ce1173fmEDETlOx+mCq6sp5SJQi4nV5TCv+bhBWPYeXFHF6FQQbynSFqnB4xLhuMDahr
         PR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542125; x=1743146925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLcbKMhYk8uxEh3mrmQXm9xuYwIoSY7sWCRiQyf3y4g=;
        b=VTda6+RJbyIAtaKalMq3CucDlSp9sNZgkM4H7RfRjUVQC1SLlJRWWsG+l5Uy1REi0N
         y7mCyCe4GMOXxgjHuv8iKpj7+lPwRyKNNUnhWo6wGPhmuMzeGeEAX3nb/JWn0hG9vo96
         kDmYyzReN5ZUttHVo1S/2VzZ15WyJwyAy1wYghR4Do0tK+e+OuBE1gtauIMBhllCq5nI
         2F3Z0UcPnrcfc+4qc1vL35Hg4QNtQMNtWL70MsJw+It2Wm94XK4vcErByZC9XN04fUkv
         dGbKaRHFafCCFt1sVaxcV8z/5oP2DBj+iQng68FnSzI2rYWQIGVHDuMZLl06xLCUXWCx
         SGkw==
X-Forwarded-Encrypted: i=1; AJvYcCWshb+tONbB6hXgzXOPjZ43fQRtZ+O/LBarpNhBBDGyj9ZQXRfw8Y8Flcg0AoxN+Xl1Mx4eayqvwntuGNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomLCwVxLIzPg3+juR/qRbUpqTv+vKoOe4tewIfuP3ifarYRS7
	YtOU3vkQEGFbYpigwKqVUQEwY/zJdphERuSjpfvAu88SLMcaNqWk
X-Gm-Gg: ASbGncu4ojURTV38gy9tu1mnDKo3Sl13bjNXSdeO9gkGaQY1UKP9iGUv3i7ee+y0FGK
	o/ZsrN97l8CNqT8w0qv47pZ2FLAWxkfSD7/HcypXLmnxFAlYstkndlTEcZ4o1i2gABJQeZlF+ua
	geSSpiHFlBVVJcegUSpdHZiEirXckF2rBYFAHVp7vuThaBmzDtszhlRdoHXoRYYb71IZcjsHTns
	K4z214KDhqK50z9UA2s4fqDAZ+IoyLg6pTX8SjCPjHzi6LTa6n7TKAafdvGOYE5ey7TBLWRxXOK
	OF+N4h1J83w6UL+Vso4S2AhYoCQneah+pO3Ln3OQbXCrvVTMX7gRpqWOjE8EI00vg7Yo9bHPAaZ
	Lm8R/4MQJFe/rIVKj8/mPfQ==
X-Google-Smtp-Source: AGHT+IF4SxgsnT3zZvci0/PSg+6Xigby8O/vjqm4K8plyaDY1Gq1sOSCHgwXKkuKrYcIMeMR2ARBvQ==
X-Received: by 2002:a17:902:ce08:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22780e08cebmr41057985ad.32.1742542124465;
        Fri, 21 Mar 2025 00:28:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:08 +0800
Subject: [PATCH v6 07/10] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-7-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2083;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=sycCkrcM+LJ9UbAjzsXD//ULjcrkdN+dexyZS9F+cjc=;
 b=y0hZDVQSCXSdKICSxhMEFFSAzXsUl1jHR1wnRdOkOfCt4z606ExaBcSEhg3Tzf+RlwFrf4eTv
 +ipSBlhcpZkCH4nIMLqR08XgykEPCqDxbSAwtV/ri+dxAQqz/obeh+/
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove INA238 and INA230 power sensor nodes from the device tree (DTS) due
to incompatibility with the second-source ISL28022, which shares the same
I2C address.

Move the driver probe to userspace to handle sensor dynamically.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 45 ----------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 306931c08cb0..6702be32918e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -432,35 +432,11 @@ power-sensor@22 {
 				compatible = "mps,mp5990";
 				reg = <0x22>;
 			};
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@42 {
-				compatible = "ti,ina238";
-				reg = <0x42>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina238";
-				reg = <0x44>;
-				shunt-resistor = <500>;
-			};
 		};
 		i2c1mux0ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x1>;
-
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-			};
-			power-sensor@43 {
-				compatible = "ti,ina238";
-				reg = <0x43>;
-			};
 		};
 		i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
@@ -753,27 +729,6 @@ i2c5mux0ch7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-
-			power-sensor@40 {
-				compatible = "ti,ina230";
-				reg = <0x40>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@41 {
-				compatible = "ti,ina230";
-				reg = <0x41>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina230";
-				reg = <0x44>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@45 {
-				compatible = "ti,ina230";
-				reg = <0x45>;
-				shunt-resistor = <2000>;
-			};
 		};
 	};
 };

-- 
2.31.1


