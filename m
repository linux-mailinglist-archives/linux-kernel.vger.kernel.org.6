Return-Path: <linux-kernel+bounces-228826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B591678D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB5628908D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC715FA88;
	Tue, 25 Jun 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oswxccts"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1315F3F0;
	Tue, 25 Jun 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318052; cv=none; b=W6EQZHLGZbd/c8qHogH5MTtQsR1YxM+Mowz/lX4+Ul3gTxE0KcgwkRKEoJeBXBGiN9Df7zewektmjU5IScRBa3H/QHVfZDz9GkZY7Ak1jKyaHTJnnGKTeoua4CBxy9k+NqTm65JEDXImYawgfwpbcWYf6qWKc6YNLOkEsfp5iGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318052; c=relaxed/simple;
	bh=V8QC0k0CYCinzomK2uZLcvyZ56VKOV5e/tgkizW2I3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJjcEmvcB4UaapgZzgRtx71sP9B5r3v4XNDhbkM6Y3nFzHGv/B3u5ZJwQrv0BMYqxaObAt4WJERYNBJsWnwMd3dXQ13q4EhY6ZHJWRqmEvNZj/jmZil5MgGEvVHY3FKpZ32fUdi/AKh7wH7znrOclSIthAo8o8LIvkmWcTc0ZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oswxccts; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c1acd482e4so2922623eaf.3;
        Tue, 25 Jun 2024 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318050; x=1719922850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYpMdLUZ8Pu5PErgyvvWAR9vFZoKUmmawdaOP6axHDQ=;
        b=OswxcctsrZAIwCGdMDELMPzl0f1hdxbk3LE7psEBvOjvDYw1d2WgCor64BudCy2kIu
         7GJLCCgxHabH+9Ey3EC0UoQL2ha+tSm9XXQqzFEW/Easboy/woBjja4NhJqxUiVXobHD
         TYcwA6mhGF+fTqEJm2nIUlDvNKu4fVKBBbHwAWKAEyXAAFegpH0q+ogVY1xmzUmnwZcj
         Q7S3T7dwgVXtDCDVYGdrEDNiDt7uMfDu71ExWOoocC2xxZq+FCpvKF0fnmlbrYuMsIVS
         ntTOOrSfkD5Tl2Hvo5GcYraFVOdmVM3j99Urhy3gaEU/BcEyDwctHHSuMYi6bKFTh4ii
         nCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318050; x=1719922850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYpMdLUZ8Pu5PErgyvvWAR9vFZoKUmmawdaOP6axHDQ=;
        b=uQtHqcgrTi13suoCnOZ8nggyAqbUfJ+OBQxKkDI8s9rmvSgWDnt4MSyFLQ8FfKwU3I
         EAhgoNhMEqVEYP2YDsf3n7ShyEBDeMgOacIwnagzdJ2lGmZMS8QzYzcqvz9adJRYbH9X
         mr3UhX5a/4PqTgOCHRtwq5XdpXAbJFcloPrhjFIbig0U/v4BGt+yvuju3CJlrGOjPLp0
         HFWGi0CYGrZTT0bLaJzYT9/l1nTR4rk4KsMGUkd3dwbGmNnSc4PeNkWhElaNFsyi/HS4
         ELVLj4BzoN+JsPJDaF5XDhprlLzQfZvGkLt0+/n6/OKftls51mLOahethuYzFzfjfk3y
         Pk9g==
X-Forwarded-Encrypted: i=1; AJvYcCVAv4mXfL8NLaUI3MJiXMIhDswcVNMFTIu2VU4DO7Cwr+FV8DNVT3ZlHRh7PUnQjMnrWGoTv5AmAlRuFEZAvjH1WZjpEvMg8TRkdBFW3992M8qfvLWPK4pqEgh24Xtzv1ZkpKRyk9hdkA==
X-Gm-Message-State: AOJu0YwUiXQAKiXbjBbHYX2aWi/Del9DdKdCIoivXTDLOxqyQUZxvbIv
	ODowHRx1PdE3amrTq/yZIkPXvkvEPgpHrCFUS0YaRvOQIvMp9t7A
X-Google-Smtp-Source: AGHT+IEhiFkBr36kLcBUT5z+d5IDZ9KKHvfkPFh4qleoUCawh5QS4Rc8+ecYPGqAh6Lk7GcoQZfzZg==
X-Received: by 2002:a05:6870:1791:b0:259:f03c:4e96 with SMTP id 586e51a60fabf-25d06b793f9mr7726194fac.11.1719318050237;
        Tue, 25 Jun 2024 05:20:50 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:49 -0700 (PDT)
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
Subject: [PATCH 05/17] ARM: dts: aspeed: minerva: change RTC reference
Date: Tue, 25 Jun 2024 20:18:23 +0800
Message-Id: <20240625121835.751013-6-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
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
index 19f609cfd026..32400284479e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -116,10 +116,6 @@ flash@1 {
 	};
 };
 
-&rtc {
-	status = "okay";
-};
-
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -329,6 +325,11 @@ eeprom@50 {
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


