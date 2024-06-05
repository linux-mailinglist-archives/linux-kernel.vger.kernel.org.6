Return-Path: <linux-kernel+bounces-201817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B697D8FC3D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D591F23BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EC190497;
	Wed,  5 Jun 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpX3MAq/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBD19046A;
	Wed,  5 Jun 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569627; cv=none; b=H9Mhihr87Sj7nYMnZUPTc8DjR1MGGF3f0KR5sLdyC3IsP/5F51qHajUZ6advWD83CGKkwZsxUWaRDVy5+Eas1PH6kj3OBRXZ3BfBuKJsi6rFzqwOCQOE+mKiU7LQyBT24aOaHB/Moh1aMTQDwOqr4tSl1zReqG1qeGLLNGYYqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569627; c=relaxed/simple;
	bh=gh9T2JuXEUq+9FLP5NHawmyCjUp/3wTNGcP4jnyuJno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fg5XbOZyUPE6uv1/lCTzbfJiNrp0KLgnVuhMVrknLceGOjQZ4ZAVrvguEc6GoQmqgoz4ncSQT7xCejq6OUiEKww/i0AW2D7OdMTsCBMF7i4ouTCtjvJfag2yekM4TBlIJA8OSb0ooda4rOUiCjk6z2nfNJitsnB1CNOwYwSpxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpX3MAq/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b9dda4906so3205409e87.2;
        Tue, 04 Jun 2024 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717569624; x=1718174424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3AHSdXqCM99GcM25H9pmDJhtaZDdOJQN/1p0dZfXZM=;
        b=IpX3MAq/KPeK5M4YBOlfQUBEDdeXTHLHP+ZvWHLJSMiNX7GmzpA0cjUr2g+PgvzUqL
         P8RwakAbV3xNwEAHAZM0pcAoL/v3DxoM9oAuuZHNuzJqT/vWG3cNX03TEOZdBOGPx8rh
         2hGq1EI5zmTkdS6a+Hkje1Bqhe2hrDIpu+NVMQ1L7oEzaKTEXJXIe0BkVIiZQvvynMo4
         tw2fQ6N8bQ2TA3scxZVfz/OfwVDF0sn5KNB/bhrE8KCuzlUv2cPArXlZHWryaGiDM0d8
         Yus0zja7i7v9kproveFtlyfnG7wjs/8p+VcXdlidw2SxZnjh04z74bnoS/dPZXlfbaQu
         VGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717569624; x=1718174424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3AHSdXqCM99GcM25H9pmDJhtaZDdOJQN/1p0dZfXZM=;
        b=ZYguKXol/7UPxbxTfx5y3UCPShfPrSoWZ1FnUd4UKbC0QKL7nqN9YXTdjlzgIcM+QI
         EdSVFFIxxqjN6keStbhSB7GdLHzZe7QnFRH+0UT+auhfOQq3QUyNw35FmKHroa7klo+u
         eZ0TVb3YJ2TDziTE8yjPzje3D91DoTvS/RO3O5KoiL+zS0LkJ93GdUku+L1coXu957+E
         +KtxLK402JtCAX716z+g6BtMvX7v94hjwsgYQbRUCr1jDpMs8xpEPRUPEMAFaQfexQMI
         bYNShoElwQMSGd43V0QbQbWOCu8o1RbFChnJPwsW+x6M+N9V+PEPx4lRAzu1DmtPM7Ym
         IRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWblEPm3wHn+kHjp3J8OvpzohiWP8ip1FYt1I84+jftPRkCnajBk4uxVAhR6kLsJhSh85UBgL5LTIXtcf/g1EzgF/aYo5AIhmz44TZrVSAyehf/ZTM8R9uTjPg0pi7veV9OPXyxtlE7gg==
X-Gm-Message-State: AOJu0YxmIG4aMBKlNRwk4lS/2tlseU0FetCS9/QTGYvXpdGeTLUd4Et8
	djpLCfX+HJ+uIYY0lSmhY0Pf5xvoJKmsPOAZ4xbR7pZ9BvC+HOeG
X-Google-Smtp-Source: AGHT+IEpfY5sAFkunQukulbbBhhtaqTviynZT34t5bgBqEeeilrCQzPBzOnCHKlAfbEwRE0vgOwhpg==
X-Received: by 2002:ac2:4c28:0:b0:51d:5ffd:efe4 with SMTP id 2adb3069b0e04-52bab4ceb6fmr1125040e87.1.1717569623871;
        Tue, 04 Jun 2024 23:40:23 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm8665505a12.18.2024.06.04.23.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 23:40:23 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 05 Jun 2024 08:40:12 +0200
Subject: [PATCH 1/2] ARM: dts: broadcom: bcm21664: Move chosen node into
 bcm21664-garnet DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-bcm21664-common-v1-1-6386e9141eb6@gmail.com>
References: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
In-Reply-To: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717569621; l=1415;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=gh9T2JuXEUq+9FLP5NHawmyCjUp/3wTNGcP4jnyuJno=;
 b=75412Pl+dryhZqHgnGfXiKbGo+aYBu1W2CVLUkZDx3R8GEJMJxG3fPwZ8TYgCvcmN4lMOZ42P
 x8W0/DJUzE/Bx0gYRfzfnA7gkur7jdot1mxriR7hp0uP4XZR3P8qvHK
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The serial console settings in the chosen node are device-specific,
not SoC-specific. Move the chosen node out of bcm21664.dtsi and into
the only DTS that uses it, bcm21664-garnet.dts.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts | 4 ++++
 arch/arm/boot/dts/broadcom/bcm21664.dtsi       | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
index 8789fae178bf..4f8ddc1b3ab7 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
@@ -11,6 +11,10 @@ / {
 	model = "BCM21664 Garnet board";
 	compatible = "brcm,bcm21664-garnet", "brcm,bcm21664";
 
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
index fa73600e883e..c1ad5123bad4 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -12,10 +12,6 @@ / {
 	compatible = "brcm,bcm21664";
 	interrupt-parent = <&gic>;
 
-	chosen {
-		bootargs = "console=ttyS0,115200n8";
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.45.1


