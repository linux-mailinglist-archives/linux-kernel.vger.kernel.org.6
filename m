Return-Path: <linux-kernel+bounces-570827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D913A6B505
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4353B15BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFFD1F2B8D;
	Fri, 21 Mar 2025 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmB96Ktr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E71F17E8;
	Fri, 21 Mar 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542134; cv=none; b=PXm/h2p8E4T/y825/h6SuxnyE7ZiaDl8aYUt3dzsUFxsO9LCjddXy6ynGCiACqohnbTdrRKRigVL/hbJ1IZGz/FOFYqNaYnjCgbKkSvT7JV8pE6zfqXIwYByAluweCNRjhj3advesztE8GSXj1Ifmp/ydoAy5JO6Lqe2zWci/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542134; c=relaxed/simple;
	bh=bwpQIFwpZpzyzjai+JYBYfCrfZUWdhbKBq8cHgvMUjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLJLasfb4YcBFdE/yqJo8hdwpczlnGHpp3CcIQ7yLvSx8ovHQ/b9oRquy3JjB9O8PA70tsIfJBo/MnQ+0IWftZCJnONe+73SvESVopok7RaSKwJ+QrSj0dVngtslq3jTB0+Ej84NR6xdyqukR+qfG0fJQjjD+LA9ZwuAgE2qPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmB96Ktr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22548a28d0cso4112525ad.3;
        Fri, 21 Mar 2025 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542132; x=1743146932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbhBstTf/rpGE79fQcNaD6V+9Y2DvcY3tvSTTq6IewU=;
        b=dmB96KtrNM7jZPd96kgaigDzw/HpRj0kP5mCgq+vqkBiIpmLyl1+TRyfVp9I1z3IJE
         PxNCQPn4rwrZ07u2qzuaFacC0KIEiYKyNPA4RR03rWfpek+F5NT1tzppvIDjzRvXne4h
         irP5VaKPHPzshHrvWk/RL9ipbwcQ4LLPM+zpEwVAnlssGcyiIxnzWk2vsHS9kLvvqcIf
         X1LUPP9conVqKDKv86VOvFHqtWlIL7c2T4gLRAWrgZsK6ZfpV/dqmEXR560xQbBGKpdZ
         CUl+7Ftc8vadJtUKtodJpE8/8i5Go2G3a4OGxOF+d8W/88qFVXRHQ9zbnPa4e2tty8Kl
         e83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542132; x=1743146932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbhBstTf/rpGE79fQcNaD6V+9Y2DvcY3tvSTTq6IewU=;
        b=bU2DQZZRGwbjZZakylpqKIOdYPpBQE7TgczeLinJKgs/Q4iW3ko5YYFxFvE94m1LTh
         9Yn0k6GxSRqBf6mvTVcOZ4yxQbZ9ZGoNv7c8zMelz07y2Wl31r8k6hIK+pHGkmh4Mbau
         l3+5OOMSn5Lo9rVaYEiFuf2gtSOkZrrwBjY4nDR+x1Ihmz1DPX8KCP1qa8CSl/z04/mT
         +DB10hCSndcwKIPnTcVW+vqdBylVv9h8/noeNIR04E6eh99rRkCbkrJ+soFNL0qEgucJ
         DEiKWY+gRQC5hxsqpLhuXP7B+Af6taGMWC4I4SbH9KfeQZxbqC7j55Qs0CsBnZNZDc0r
         SrdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVMEW7UZHfYNwCd59mVxDFv7ojwN8OEij5QmE+BF4gDGd9Kkk8PFDij6hFxpsMK2FDDOAo0Z2AGjmUzbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUkqrapxrQDJMOKlMtDqfvpoxrxJutx8dkfyrRH/aAWYq1ynk
	j7uVYXQ0QRHyi9D9L2RZdKMZMGT2kuH2OCMzkzb2jXktL6yIFJqQ
X-Gm-Gg: ASbGnctliLvr9pQrGazqYYgCsW0vbZ+LjqtyLvBuLGd7wfLV07OveXW4zNl3MvtUg0o
	g30HffltcvaG5QMubD4AQYZ5m2XhLimnX6xAnGyR52FhoneTkm1JNXNWO4u9fdIUh8lQEjDgBqa
	4eaXA54so8J/Q8AbtfIwr8o8G/6REXplIxo2hFQmninB+ibnFbIo3X2B9C7CfT/VIbI/p+gcaI6
	0WpoKijbnQazfcMwj3UoOpavBakjPLEA+0jb+8qI0bB3do4qNBweb0wGEXDdaHlhJH5vw3aXyw6
	tsymTyr6VEYiPfg9UMjjS5VhzY4Vfor6kF7MkYJVnc4e/Gz0LFxoDJBtJCf+cLUw8FryT+Lmsgw
	f14x7ze2hDuf7LGUkGTim4A==
X-Google-Smtp-Source: AGHT+IEfn10cVp0MmL9KAA7HT1bbZ8SZCvI7q9K72uD16FVBGG7ET0Q39wXEka05fFezPLWLFC4AYA==
X-Received: by 2002:a17:902:cec8:b0:223:668d:eba9 with SMTP id d9443c01a7336-22780c5587bmr48813795ad.10.1742542132085;
        Fri, 21 Mar 2025 00:28:52 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:51 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:11 +0800
Subject: [PATCH v6 10/10] ARM: dts: aspeed: catalina: Enable MCTP support
 for NIC management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-10-4bd85efeb9b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1803;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bwpQIFwpZpzyzjai+JYBYfCrfZUWdhbKBq8cHgvMUjA=;
 b=oDGqxJIBbfZ7/afAwIsvVjkBfZM66AC4NAU3Nl/DKHdHlrLPNSwK60RC1citbXPc1kcm284Lf
 OCMuUPbPXxPBrXRXK9WJqB0/QIZT3wAgnO+MLqFtqts/SAYDRTGtqX1
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `mctp-controller` property and MCTP nodes to enable support for
backend NIC management via PLDM over MCTP.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index a6a2dd725266..5fb67ad2d777 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -186,18 +186,23 @@ flash@1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB0 NIC0 TEMP
 			temperature-sensor@1f {
@@ -214,6 +219,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB0 NIC1 TEMP
 			temperature-sensor@1f {
@@ -305,12 +311,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB1 NIC0 TEMP
 			temperature-sensor@1f {
@@ -327,6 +333,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB1 NIC1 TEMP
 			temperature-sensor@1f {

-- 
2.31.1


