Return-Path: <linux-kernel+bounces-568437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD3A69568
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7663B8D33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29381F09BB;
	Wed, 19 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2hENHmP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2381F09B7;
	Wed, 19 Mar 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403006; cv=none; b=MP9zQP+n6vIcwF2ggurj36Cph79MILgqPJ1xeEIRuI1jMehOxIQPN/o7VaH+qSiJifUEgONYO1qIKdXgSRrXu7h9Sh402dcqUNNWNOVdBEusgpdj4tVDaTXXw8ojMHXj4rWJ1dBnTIcFDhy68iiGcbqzQzSeArpyXcpMMgnb0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403006; c=relaxed/simple;
	bh=h3bH8SXx0sv5QPMnsoufX0caq8JBi/sA4S632p7NQak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0YpCPZ2E2JxesJ4HT03mwgiosX3FTnYd8fGII2kAPA2zLLVZhMut48wKupo9v4CZLwv9hckrZ7xAXltEI54draLCQmZ9o2C5ZB/MbVkqzTDeRNM+3SdowguFvzkc5UX/qL3vgbEDMnVFNrDQHL0cSILBtcEzuc/DcDYktin4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2hENHmP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso1628952a91.0;
        Wed, 19 Mar 2025 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403004; x=1743007804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtDV2qePoVhIO7myU7o4OO3ITr/ClHLDVz8qgdkxKAk=;
        b=B2hENHmPoW2wDDOfEopODur1D3V6uKSyC8fH+eMwK9fe4iQRQhk3L22sqMRqLMQs3t
         dtR88JANx9zEZXT4R/mrZ9NfJyOcbuPawVEUaU/Rjfh9PwWEEx5ztllQsWu4c6GyZti0
         /TRaiwKDH2wm+trBg2xjoN+Xx8udlQG8UzIPRma+UfB+2h+vjCyAltxQWAvIteUoc4se
         DhSDrPpzf9T0czFMmXAeHAZ3U1Kv5fcJZI6yqrRuVQW6oGkt/ZJ6aj4xcNO8Sv0w1lZw
         Hax2+89p/rrwXdZfzJxIFjGrKlDumw1OIRZIV4QwStn32UbyOm7kUPmM5VX+Uh2sfEOB
         v35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403004; x=1743007804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtDV2qePoVhIO7myU7o4OO3ITr/ClHLDVz8qgdkxKAk=;
        b=mblyHz6xXoeBthGKaXjsh2tTxmnshzYOXFor5YvfL372DmjbtryRMH3G6kp1HrqiJV
         7tGX5PPBm6qAhUmuUlnkb/kw2/8bWIx/hopVOwSBbnw0i2XalfALb5JllYiclOpaZaMT
         rk8Bm7iO6uO7Cenz2e9MUOxkxLOFfCNSC7JdkVbgdMt/pkCihLPQ25lBms52plZOiBVQ
         OWd0lrgufD0I2FKvT+qOR9WyUYu6g6Jt+4aBd7zxALx3OJv7Go8tIWjTSb3jWq42C/8H
         g+i8YduVsRfE9xVUBS2x01SKcvRrkQ1jd4n6AdJx8SgpOwUvYy2yip6hCYhmzdoAEYw0
         V6tg==
X-Forwarded-Encrypted: i=1; AJvYcCXah8rv//0bYZYUl648oJGY9/VBghXwkUfR5O7it5Jpy6+piW2AVTVsm8h7S5gfiVgOgDQEw8sF7Lzr+Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7oI2z1PQUes6R1LabGQSHf+WyaP7ymC65eRKLv0nVkAmjGIZ
	R8JYLE/cIVpUXxVu1QsXwmCnu2Sa2cBrnIcypG+8y1kMyXCeneLc
X-Gm-Gg: ASbGncthnZI7cSIB6MwPKxLiYdXpM422Ky/DWs+8LahAJ2s6PVU1i9hCNKrURKk1vOr
	yjykKrMx+E0S3T6HUEdflfb7Q5hWGfwWlH3riTW8YG70Yfc5pWO8brHrE9OFtt8EdmWABahFys8
	YE8YPcHbFD7DPgW14yGDEQDOa3jmxxusJNDnAJWFRT37eLqdm4v12jLTbZyZiGvtl629ODpaN89
	Tjzzpl2onrhmJ5ayS4Sbi3GrRnzJV4cTcSsr7fKJX7vfUdOFkC73a18FbGUVUBh3W0VRBER8g17
	4zv8PpEGKjNa4XNWzGBbQ37ByStnGTUxUTqHtzidA53N7ClFvpGhqZAWbghzIN5MXn9N6ECTaGq
	cH2K2GJgXq+hjEPXFE1IZqwcNGhG3mm/S
X-Google-Smtp-Source: AGHT+IFN4xqZ1OLU99SGczgLx2oieKzcfT0iY6TvB3Y4MQWRTtuA9YjNQIktJCnp+uH4ztiFhzc8GA==
X-Received: by 2002:a17:90b:2dc7:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-301d43a269cmr281466a91.12.1742403004071;
        Wed, 19 Mar 2025 09:50:04 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:26 +0800
Subject: [PATCH v4 5/8] ARM: dts: aspeed: catalina: Add second source fan
 controller support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-5-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=2445;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=h3bH8SXx0sv5QPMnsoufX0caq8JBi/sA4S632p7NQak=;
 b=FByKFEmN9gtAF1PY9hztEVRBx/ZpnMOF38icLce2VbtLLN3YjWOo+vR6jPl0ZMfIInOn+oiMg
 xOHUPTmqUKEAHo/98tsXfXF43X1ak7YIUHl+IJ1W2/Ac0Z4hscbZBn6
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 0b513829f2de..e11be815a6af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -527,6 +527,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
+			hwmon0: hwmon@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			hwmon1: hwmon@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
 			pwm@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1


