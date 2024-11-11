Return-Path: <linux-kernel+bounces-403817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651369C3B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259C5280BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0E16D9AF;
	Mon, 11 Nov 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXQCjE19"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFB155A34;
	Mon, 11 Nov 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318358; cv=none; b=ATsp5YEx8NzBOcVakvLh2a3D5OsAUYemqXkJQMWQbvTPIQ2+KvhmkkXFH3+lk5tK5HtJLrmNvi7N9Gk2oNAB1FPRmW3b40OOySDfNarS61KfklEtlnFV0cjjBOxulp92iL/krq9+2Ir+9xpJd/AniXOO3mYwdGydfvCP+D9VN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318358; c=relaxed/simple;
	bh=0mMdFNOzsC0U1lp8XyHpp8Hojsli+MusqKb2/EaE5UM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzlt3HUj3DtKrseNlpK3Ix8o98Rjy5hfeQlVGwhdNmweZo2kjF/apXgMkoNRvoHjBU1yGc4SEj/mXHrkZC0+BIOS3NKOOUsXVZ+YFhXZU4KNcT1hSXfNNct29BxOLMY+GoJmACdMJIXfTRCurDwKfiTW4W3wwJuBjvpdVDETvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXQCjE19; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e576dbc42so46825185ad.0;
        Mon, 11 Nov 2024 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318356; x=1731923156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=YXQCjE19+oB3JyYMocUc38qpipdu1KiQO7oHZh/o81N8+oZ9D/DlQgwyG4V3tUJUIn
         QWKO+d26RO1QXLBftEESxvztvXzeykCds4a5pl4g0w3Rqs1NHzCDE266jeDFq/r9QOvK
         yLtcOdBbT+FUPgt2Dp1BmiJlXgcgWpClqmLN30PZubiHkR67JK6OCXDkQ5pHA7sMAGx5
         1odFcfsOgExz7SR8KrvioAqwJTeqOBSekKlUIvH6ftzCACfwp7EecALHjTZi5dMdgi40
         qB2C+g8JUmNIILm+9TT+z0HIkY18eJV5UhZdbGW7oC9Ps5uxIBhVryG7GV1Zmz6mRZmO
         qxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318356; x=1731923156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58c4YWEBXyCwGMl0ggHufA6EWS8/x/3Jjol810uZQ1Y=;
        b=nzg/3w/r38KII7+ndl7zQBT/wVE5ak5Ruezr9teXDvAvlUP4RqNnQzBVvzgkZgrtr+
         Y1AFNAYaisbkvlwlZXN4onJZjWQuO4TqIiPVIgurH6c/KLbdRXJ60033sq000UJbGuhu
         Wt7dC+C4TQdfXBmQWtKR+335BGgcqFGOk61dsXU28PbOCGPI5AH1qRNsTB2bBzBbSh/L
         mPgTmE6otXw0ojcjnsMDR0LN/GsG6wB0lq5oPmhdF2QD1/vfvMyzG8MGtkquzv7Xha37
         hjnrBiCJxduoDP2nagypA/pRescaCn2+zZlURPgDl2idmlHtpgyE7aaRd3Mg0vCgwVRN
         djwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4MlOQ6tLNYFCUQtU/vN1k/ho8dQbj82fzEo+y7hqF6yHSy8pXnvCGp8VzxoGd2YJZXSGyzX0guKJ@vger.kernel.org, AJvYcCVEmFs4QRDNWjMqz0VwwWIRLM4scD2b0KrvcFDl63Hhp0mfOrc1PewN4viVcKnYk0oj/TnMCiZeVmtov6dE@vger.kernel.org
X-Gm-Message-State: AOJu0YxBumrNKkppyZqpTwfP0PEmZef8Yd0xoH8dQzTJsQ84MFaNkKJw
	/o8/jcgHYGsc2h5xgaaS4fff/co1UPoOP6vxzMcicx3sv8q9qQHI
X-Google-Smtp-Source: AGHT+IEX9nBe6zOXu4Czcqkfj3xLinKY8e+SL7CCUn1NiuO6HMbeZ+foSn1y1YJElfeQZ9VKBu9SKA==
X-Received: by 2002:a17:902:d4c5:b0:20e:a2f7:8ab9 with SMTP id d9443c01a7336-21183542c89mr168471015ad.27.1731318356014;
        Mon, 11 Nov 2024 01:45:56 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:55 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: dts: aspeed: Harma: Revise node name
Date: Mon, 11 Nov 2024 17:43:45 +0800
Message-Id: <20241111094349.2894060-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d175e37c45c1..ccb45ca840cd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -183,7 +183,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -238,7 +238,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -311,7 +311,7 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	delta_brick@69 {
+	power-monitor@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1


