Return-Path: <linux-kernel+bounces-213536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAB7907697
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80D4B22567
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7431494D6;
	Thu, 13 Jun 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiCOtLvc"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46044149DFD;
	Thu, 13 Jun 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292397; cv=none; b=vC1p/+gz6vz3NsAnfTfGAuUudS/0O7Z2TtQv4vFOS4BqeJwP8sphIJml/urR32mNZarZwBjMgROm2n9yf5P2cZaLpR3ZWtPpUxUczN1bE/rziUMlgqKhGu55FV4AA8Dp8sjHyWmqpNg5IDp5ouE96Y9H+JBs8CVkNbHz6yWruPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292397; c=relaxed/simple;
	bh=Dcrlkn9iZ76oeFB+jW6vFS9sWO+KMT1enVNwW7fkPmE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zy5LAW7MCBkcQrr3hwu7uxsyccuZ0/QHNevCDZpPk3JotmeQv5rlW8ZltLPKHowMWFCCkf8dc5ka1+Xpkyiug7Tu0/0ByDPEu0JMvJwaIMS7GjOvpHaN/0Ob1as2rkIEvaEZIpNf7nAPPMb5e36q3BzM7rj0SREg4d70EzdV2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiCOtLvc; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9f9e7176eso583419eaf.2;
        Thu, 13 Jun 2024 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292395; x=1718897195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Fc9TZXsE236e5GqF1+goY1wiMOdU1srHkjJ5LtjJyI=;
        b=CiCOtLvcfB2j3zkmZbOOuJ736wxYQ2FJ6ajBTpHOK8trHGSXzWe0odqUetMlzqQv76
         7k2al2eN9E+3tFuVsv5cdpjfa9UGq8Zj1qs9HeU596C1Kw5wUiOY08SiPU/nZ+b3P/jj
         ww6Zn+ej671sHX+FMI3I9/liOp9kID627vxvQHA2cjQk+R14QCVJJDgdSRqi2mYltY8O
         L7CWNj62HgY3VuGVVQ9g8sQW9eN6ux5rlaiCeHRHPHJrZXjSLwIj7Q6o88eDizhLbToU
         uAGJOUFQhDD9gyu6sUi18d/GxQ0EJV2IKWlJDpnybXK+46mgbxbqz2aeYVcEq961g2OJ
         0iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292395; x=1718897195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fc9TZXsE236e5GqF1+goY1wiMOdU1srHkjJ5LtjJyI=;
        b=Z32pZqDs2zyhuDpAHluSWLfJMUhawrIRexcjl+3/MPIAdoa1eqQn6kKAU8i8zqvczy
         AJYsaQ1ovBYTB0ga16QAhZrgiflIh9XboSHKyZ3hIM+dvVNkQdDQ7NKQRKKsV23zgVB8
         cO22iFpMA2Kv9smLOlltB784pWYWIaeYHPHrZVeCE5JE/0mQtMfu+8SQwT/MmLflQr/m
         8Dhbj4lEZT60oIJiVf/R2x0wiUemT/QcODRGaj/uj+L4uQInly0VT2Z98YLooaJEXAJE
         fACXD+k/WG1C1GHDwSUtUVx2gyHXI72F1u0qmkXcxk+2KNAbJL4Q87Vnz4Lu92s2wp4u
         Tniw==
X-Forwarded-Encrypted: i=1; AJvYcCX9rrrZwYZnSvqc4Tni66zsTKcSrfBmQHfPo4+nnXxkxH+QqvwxXP5pCuk/NlmlH6XACVEI5HTXClK880DKK6de9rqAHArjeeEECKiJI4iGJTMkUkwQA7NYffEV7wPii7N8nGsw9sqyxQ==
X-Gm-Message-State: AOJu0Yx9nrnlLSbwzm+fzukYJRgFXViOE0dFRpS85yr2rTclEW9O0fus
	mJeJibwK0OiASsQf/lD0779HqBuErV3G1PMSpC6vlPyBLMdOL0e3
X-Google-Smtp-Source: AGHT+IHXk6+NGB+wlv3K2wgPenwKml/Ptt86KSEMMpXMNRhhb/1ZjPkonhAwss/lf2RD9vI4xmBw9Q==
X-Received: by 2002:a05:6358:e4aa:b0:19f:4be7:435a with SMTP id e5c5f4694b2df-19fb500d5d1mr8865055d.25.1718292395197;
        Thu, 13 Jun 2024 08:26:35 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] ARM: dts: aspeed: Harma: add VR device
Date: Thu, 13 Jun 2024 23:24:20 +0800
Message-Id: <20240613152425.1582059-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add isl69260, xdpe152c4 device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0d349ce1f3e6..ef5ffe190445 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -398,6 +398,30 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-monitor@61 {
+				compatible = "isil,isl69260";
+				reg = <0x61>;
+			};
+			power-monitor@62 {
+				compatible = "isil,isl69260";
+				reg = <0x62>;
+			};
+			power-monitor@63 {
+				compatible = "isil,isl69260";
+				reg = <0x61>;
+			};
+			power-monitor@64 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x64>;
+			};
+			power-monitor@66 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x66>;
+			};
+			power-monitor@68 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x68>;
+			};
 		};
 		imux29: i2c@1 {
 			#address-cells = <1>;
-- 
2.25.1


