Return-Path: <linux-kernel+bounces-231880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E5919FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33AD1C21ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB259164;
	Thu, 27 Jun 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSfYVnP+"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4346522;
	Thu, 27 Jun 2024 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471633; cv=none; b=r6icZzZNi1gdpPaX+i+/h9mjwrGvCX8W8SToNfaH87yXPAgvPAZpdp/Nmd21HfnbtJOqk+4WfOGuF0rQH1p1qd7WOQfBFc859dzoZ+1rzVtf15lzLku44RC9LkMRZHNS2B+8OQ/IF8qL51J1smCivsCnrCuglpprvgrylLHJPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471633; c=relaxed/simple;
	bh=Cydcsv2ltnf0LJ2LpgXPQ7O0U2J+6JErIHN6q9qdqvQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foKBcQF9POGv49vnDatmBzgqp3biKpkKMmDDoarzh5XUjDmnI71GJttM+lWu0Q6ydMF3a7NiPsfEl4oHhi5jMHC3mwgelVSZGH8sNmfXZoJzGe5yJ6O9rAhHPgbkiq9afob+mmdONnr4qfrmGxho31yXH1+mtfDy23qGJ98J/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSfYVnP+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7067108f2cdso3953435b3a.1;
        Thu, 27 Jun 2024 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471631; x=1720076431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gix3DBO+oHGmr+N4AH/BAu7/Kk6dQdl46Hkauc/qyS8=;
        b=TSfYVnP+jjCXfVZbHJNJtvnptjZO8jfu0/CwlBTMjMPxXpt+2TK626d2qmb1XycLgl
         px1V+Q0gnm9q78dLxgOcc313jDGKKpXWW05L39ZnDz0DNghlJ0nbd08auf5168u3Jl3Q
         FCDdYWeQJsZYZaj2R1+vU5ih5Mk0Prua0KqjYW4qgrNpqn3g8WtCD0RVzx8v+VCkIypv
         2+8fzAzMUXEkcI4LUSwkcQa8WB4Jv/1+DQAost3ovPfvZtp/FlpwA5YFWbf6ocxoD7nm
         bCxi07TFmPQWxYiAYgrIfKZaYPUfK9aaKdmsBE1BOJAHKLUFS2HrGZXGQ40miymg9ye7
         NP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471631; x=1720076431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gix3DBO+oHGmr+N4AH/BAu7/Kk6dQdl46Hkauc/qyS8=;
        b=URUya0KFEXyIE2xMbY8Qya9uFcoDKKAzY4QxoqQQgHUMilmR29x5NUgJ6hjKTrj9+c
         DVwvcuSVh63/p/YyxGl99vsNDgpLYHWLux3CvyKp1ti2pumCsOlMC/9ZjhCQHjYg1Rah
         Dbm93/4RrdMWK0OBo92hyZFjnpwdn6ykyISb+9ndtkvjwfobCjLoXyHQA8p5Q9fiyOZb
         d24g+NDBSjKFxay167FFR15AmGE7wDI95lm3H2sB63DM528PyDk3h4xvM+KYPsPxX5gq
         Tp5yN9zmb8kR7XWqnHmJdUQ5p2yqhP6gh9NbK078/KwQkdkH1gixV2P+iLdHNfvQjWG+
         jHAw==
X-Forwarded-Encrypted: i=1; AJvYcCVu9TyAGDYu0nkzHxzKg4jqmq/FnzTGGib9Y9PJPAblj4LKSUTpm2HXHoZ2r0lMMb9I/Gp7FZEfybF1REu87p4obrf9fGgoQLVoZxquCMwqv3Buo2JG2rULNFcLrWLAjz9rOUYfdiq41w==
X-Gm-Message-State: AOJu0Yzd0mcmJ0ke8p5s2GPHabhPuRJjyiWeXBht2khHjhbcuJ+Gkr7r
	Q7nnRUT82dEK6aF28ONoSMxpbfDCzLxVmS3LaAVx4sU5keOA5U3+
X-Google-Smtp-Source: AGHT+IH1VSEO3FBILEDGjF/Yh9fc2gMEtCGImbtj63fNk55s/XnWpRnild7z5Ferw66s1lJJ4Xa+eA==
X-Received: by 2002:a05:6a20:551f:b0:1bd:24f6:576 with SMTP id adf61e73a8af0-1bd24f60623mr6231502637.48.1719471631467;
        Thu, 27 Jun 2024 00:00:31 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:31 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] ARM: dts: aspeed: Harma: add ina238
Date: Thu, 27 Jun 2024 15:00:06 +0800
Message-Id: <20240627070013.2509150-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INA238 power monitor for Harma fan board.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0c4bf165d0b0..7d809f1636d6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -198,6 +198,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c1 {
@@ -224,6 +248,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


