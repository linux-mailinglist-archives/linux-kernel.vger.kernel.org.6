Return-Path: <linux-kernel+bounces-230773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424449181C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC5E2853D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45083186E44;
	Wed, 26 Jun 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpPErsDf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E825186E25;
	Wed, 26 Jun 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407149; cv=none; b=Pt7GvA2v3UpeceVtVLh9oaV8JZFNzUCjhiwM8UwVUnEnBbZdFnvoOu/+B8Q5TyauKnkraEczFKotu1DFE4UwE9ziiakFsMmwjrX43c3bTihyraflDOL/9dz67vhAXkQMp9L27xnGy1QlO4JKqxiI/hjF6OCMoPcQaBXi+ksqji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407149; c=relaxed/simple;
	bh=5z4i2c6xXhZ4H9qEGKlaMRrLO5kTDDkGYfbT8siPIas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ilRr6nyPGbQknNFN0+pTaFjqm+b5MqwFGkeOqjlJVcRBB99IhZaYfzZThTsnwY/gQiA/mxjtS8tR5hzd92RXyz/tWFsccUXi5/JOUh9q4U/nCdVDUOsq3J4XoVXwn0ibWKj+kwn74mft5vHoJ2enY8Xgpx9dvZ+TMHYOaZBzWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpPErsDf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fa9f540f45so1898995ad.1;
        Wed, 26 Jun 2024 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407147; x=1720011947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvuY3ldSDbcqRp6kVC4EYjFVqjffzG4NqWLDYEbzrrs=;
        b=fpPErsDfH+8TX853tA6lHZcWSpr6VcjNGZ+Sm50Pcdny7UAtU6hA9vCv7Ut9Rzy6sk
         xgwEFb/hEYuLFaJgETmwE5S+We8K8AZXeDLiXilsMGOvxdAceP4JXUX+pbjrENLKABZr
         yoBEHVSOaz0yxHkKk8K5jki7Ct7drv35wTchVAeGnC3j38v92DBfVueG1f21RVLaGpdV
         QiEe4yRWPEOB2Cysew2EHx4UIVLmD6L7fHKpDtiwoXSsv/stsvw+xuVsVI4TfBFgqtOy
         +ZIo2ZjIs41snLnSEr/H1i28hnyfT0EszAI+9nU1wJrvAlTbxjnb7JZOzaIK0qMHy6KX
         Dh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407147; x=1720011947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvuY3ldSDbcqRp6kVC4EYjFVqjffzG4NqWLDYEbzrrs=;
        b=c9dHdDVdkFosb9DXFKzRjCKwVvErqV470TF2UlLFcsbw6WldoPdFtCsT7aktDmLpKa
         mX2hVCKVNSXKXEY3tRF5xsPWpVYeWeKINi7eip4uS9IbQn++ARp3wrJThD3mY7zZXA7c
         T9lAjDoa76idk2yn2vBmjWp4vq7eDxWtft74nHU/V4YrCotmNI+pgym8mScqQCLKp+A9
         eWxLEsT+RwbVeneHOP5s5mjY6i6tnLq5Aej4rHPS4Ws0U0wf82fcQujxG5gW+SbzkXSB
         RjMSs/HPLxSyd8QvYDmX87KsY69cYhN/FaaklqAPNZv1ED9szrcSUi9WW0P4cD67MPhD
         XTyA==
X-Forwarded-Encrypted: i=1; AJvYcCVasmDRe5uNIctveuFSxykPVhf37gY4V3H1jEZ99mp34S4ZLQZZOf5jXBx/E5IckHVd6rz5AMhZUcSWJIqUj08yPkW9oJdcVQ4rjfE2W4SF/kPA8MVMYDBb/HGfFg/+M0x5lUULxsk6zg==
X-Gm-Message-State: AOJu0Yz7RTzTzZUmnujIxtdmhBd4L9/BNM6/hc7Sig6mFJ2zwScTx1to
	2TlBnHhuWwppjI7fflqkOBGTrb/28LpiMRrN2+XT2+GTNm9HXe3csf2QI0Sa
X-Google-Smtp-Source: AGHT+IF7k8/xopSiQnMd+dDRd1AFXUiY3Twnz1eQs9MwN3NWMKhwtdROWWSZT0freSQdfdUJPpI80w==
X-Received: by 2002:a17:902:e751:b0:1fa:2d0:f85b with SMTP id d9443c01a7336-1fa15937c59mr109719655ad.49.1719407147474;
        Wed, 26 Jun 2024 06:05:47 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:47 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 04/17] ARM: dts: aspeed: minerva: change RTC reference
Date: Wed, 26 Jun 2024 21:03:19 +0800
Message-Id: <20240626130332.929534-5-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Change the RTC reference from on-chip to externel on i2c bus 9 and address
is 0x51.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 60002b8cffc6..cd321482aa09 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -95,10 +95,6 @@ flash@1 {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -308,6 +304,11 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
 };
 
 &i2c10 {
-- 
2.34.1


