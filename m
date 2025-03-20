Return-Path: <linux-kernel+bounces-569933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F30A6A9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C194849E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC622155E;
	Thu, 20 Mar 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahNEsm0B"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEF1EF394;
	Thu, 20 Mar 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484281; cv=none; b=PWaaUec9N3lpXjLWqrdnbl4se8uZKwISZ9myJsU5k+lIwwI+rjTE1DMXMyW4uc+sxElEF1XszizGtmyEgWT6RSDtzaMZ+GI6qTr5m8oVRd+pUf9AkXC32mSMgZ+vGcgLv8WvFxvJoujv0NbPr21q+vcII3pUwiUn9wdG+I8h4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484281; c=relaxed/simple;
	bh=tF3QpIdL5ecs+vvtM26gTlh5RwwxqroHT4QqK6Ir0Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYlDucF8BroJQ5PW0yoAqjXtmXbK5VUuGmO41kwFxpDPZVtEoZTahwl8VJm7msxX9FKP6FiHlFvkoNBKmJhOM/oFKeAirW6wI5He3p91bZDurrcIAgVgE7aFTBS60IILW8rkW7T+TyTZ+R4z6EhA4OialBmX5fGkXInovOgjLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahNEsm0B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22580c9ee0aso19764295ad.2;
        Thu, 20 Mar 2025 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484279; x=1743089079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQzvCjPUeOUJnukhemcSwQyPEPsAauix1Um9a/NqgjQ=;
        b=ahNEsm0BXOopdgNL11mdiu+jpRd2DjSzBXbvWCq24bi8LO86hdwSt7z9DuGbnR5IZM
         1EzdIREKkNzykMxjirQm1FCbUm1N4vENBsaVOlSq9aDmIr3PRsitck8ydA27esWtCJ7s
         5Yj2Tn8bndk/RsiS6/WJg8gnntXGSdok6o0+Ar3dJJd5GNKwOrk8c65snI/f9o/qy+Ij
         n/U03WLXL8zEzvRNvdJDo2dU1UgfQGr2kqw1fnK/4wPkaV2dpoHW4D+69RXI4pfOZ5xi
         rgQU+dgYxaQ0umHIwuDy6CYfbyZByoAruBjaV2haNUI3LNK7ZvD9EoIIK3L3XUNiL92Q
         R7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484279; x=1743089079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQzvCjPUeOUJnukhemcSwQyPEPsAauix1Um9a/NqgjQ=;
        b=JQiJaVJNGvjbNnEgHQnaKnmqm0VthG+vO7zrbRNeKnCwk6iA6PvAusw6zVga8SYGrI
         C5fXJtUUnJ+C8U+wuAEQdvXT94jJmtEUuJOc2WR8PAqu7mc9IqVcq0Cj2uI8lMb6+Pbe
         ERs+EGIQJ0JfuKC1R6DZTCPsUdS7GsDaxanULPxhWRumvHOqyLHEdENPwLNSYFpOvE+f
         yH9sprK41eDik4dTOhay9nF5nhxYukl+xZk4N6dYy2QIaEwH8cT68cBCKF09xG7BMHd9
         Av5Wg9ETediQAKvEoFfAGFIcvIsBzeIMByUtFaJHKNeBK1yZzmxQFkhSEVqmWtN9o4ET
         9/bw==
X-Forwarded-Encrypted: i=1; AJvYcCU3aGt3Q2pOxaehuzNIdP/r8DsZgjmXyZDgJW69dnFYjhXyjh4NNeKW2q+tTd6YjpydTK3soLfOQyBoWiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVrdsIPr6gDsgaL82QqqmIDOCcYEWx0vLF1sa/YbFmUdGoFhE
	YDlTAJ9wn5QZBGgsTIKsvwgQtDKxBIOoeY8WCvIn5I4c4KixpOV/
X-Gm-Gg: ASbGncvvCGw0kUFMG3SUuN5IJRCvmDusfszbHPOKJ4lppIOHpPaeysloOXQdvo0rMST
	U0IgIRaoelGNSxBVVpyNgiCgggUIZZ0NaieXdVnoroh6LYNuw5c7tKaDeQpzvLlT0pAYikFpQSK
	MRA8ohvLhx/zOPbzT7tmAkfAoxA3+RlK7dh533wYfMOddUuUL640XiAhBblGzyzKxMLAPDa9Lu3
	XZItZXIG141UV5qEtoDGEX7MlW6fdck4Sbrqd+idVYn4Sbcj1JMlfyVPXICSETfjbgRU2fy/pZt
	Otts9a5GXGm9B0CbuAom5pPPjd3tpJo+QqAufWqKwwA9gozlwFff5BmiVxOELqFapGEi5Jkzuzm
	LOxBzix9miLXHtpKct+PYqA==
X-Google-Smtp-Source: AGHT+IEWWSWYQnuesBw9k5f26MYFCg+MyUeosBtDDwCduhJQbl6yXVq5xhb2uSlQ3VFKw1iUppK38Q==
X-Received: by 2002:a17:903:2985:b0:224:1943:c5c with SMTP id d9443c01a7336-2265edbbb2bmr58534865ad.15.1742484279224;
        Thu, 20 Mar 2025 08:24:39 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:38 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:54 +0800
Subject: [PATCH v5 04/10] ARM: dts: aspeed: catalina: Add fan controller
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-4-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1019;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=tF3QpIdL5ecs+vvtM26gTlh5RwwxqroHT4QqK6Ir0Oo=;
 b=kiFXK8/gH/YJo/qFRHAElfjdPtoGC2XzQKFNmKfgU23jH0UyyUTD0SljFBP6KSEHH+MbMRgyc
 GBEZb9rT6+rBgUvAvOaS8LTT/r3wVhpMpx+DxUkuO6im9ysNBDbQLfC
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index f5f47245796a..fd22add90449 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -466,6 +466,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


