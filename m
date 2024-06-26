Return-Path: <linux-kernel+bounces-230786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28C9181E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF23C284FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A8918411B;
	Wed, 26 Jun 2024 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ynj/fQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A618C357;
	Wed, 26 Jun 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407175; cv=none; b=Do9Nq3D6lEG+pXlXG+iT5ivUSqUc2yAIhgZGgb+aKntJ/2yIzXcnKYw6EfUg64P/q7ehPhz0SseK6y9c4bTtKVJllg4Cilzc0fX2sNljw8eLJB2vegEcUnzPWipjZBjnD1O0bZwaPk8YfeSc7ct7W74bl+mVXVQg3TLF08xH/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407175; c=relaxed/simple;
	bh=E4CTrj9ojntZxlFrrlpyOpRki60byWxSE0YiWw5hhkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UgRZHKFsrby/K2cMqu8WmWYydkd26PwzUqjtnG4FS0iA0KM4hqVlBnSYDRKnQk9RAJtLHXhjLCWOpFPOzWH+QQRpt50tl8CmOUNQrPmYkcJPl7hJYRmtHfVARmEePbHZyYc64ddlwr9a4LgpmkSU1l6Wpsh6XisWrAwXBRURJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ynj/fQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso4864795a12.2;
        Wed, 26 Jun 2024 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407174; x=1720011974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhe6DN+SBff5XTkDHWzhpS9fEwRiEep85mCGDZa7d1w=;
        b=h8ynj/fQyScliJ4ZK4zlJZA+T9xzTaw24wjeyXQ89XBTJDuLid2zqE1HvQPaG0lm3N
         Br7W/hbPFqwOs2ZLq/IZ80UnAcYcC5Gyr34OD+efbyLZDOsaj19kv5iuR9jo3T9iURMK
         V9pEBJ5yY0qIWxCzgAr91I7ajXwvBcjvkLkKJslvE1NAH1NAXOEth9vdR72WFKzad4El
         hhHBifn6DIv0Kx3byU7mEL/0sFOuNrUWY61p8HiXg6z4AqTGpIiq+h+96kK5F9A/6OFy
         aQ9eOxGz/QwTGJZuLHi1ccOP8D259ph3DCaw75tWtnhZhMNBpeckUaoJXipAhnXr6c2w
         8pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407174; x=1720011974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhe6DN+SBff5XTkDHWzhpS9fEwRiEep85mCGDZa7d1w=;
        b=sUh2Qpd08VNERHqEJzqkk+F11yoQcNnLlWUJGIj1kruWFfKXohmzqlXeDCeVwhmosH
         IdIGrQIoSUDAKsVk9coLAxNCj+vhv+WpUtLka9NMa+q0e0iAcaL+JqxFZMq7+vHpXECS
         jiNDXyull0o8rBwKVIDSIpuRpdpEiL/ylVLibJQ9u1xj6icBIy2EWDTfN5Ndnkuzlmip
         HQ4EHcOOGaSzmQ2+OIFT4M+B2S2g/K6DZlXSnLCcp+pPYCvJnT0XCAMIYBA/Wai5+JE0
         cVcRscq31TVzFbRdo2sMHLm2Tueg6fGN9/9BTuafp1/7XizuSizCKv07i6UmO+y7PSrZ
         fPDA==
X-Forwarded-Encrypted: i=1; AJvYcCW0RwiMWGYv/gk28VyyI3kuPVOHo3sXZ0Qg+byhr+h+378aKSNP5OIur/rJeuEzkxnTuakV/vcIUvRgtqhG1Q/XYBaBvoS8uxST7pm0zmbWJB5PMlW4zRyqF1PnNUMvlLvY4POLdVj1Xg==
X-Gm-Message-State: AOJu0YzoZLow+qbyG+EQhIwS6Ifacxz948xqZ5rf9JsMqD8Aje9fKNOf
	fDg3+52n4EEQTBYR/qzyJ64doDNVRXReaaIlRtnURTePvFN74i9f
X-Google-Smtp-Source: AGHT+IEnvR79PM2kbP19MxXJTGNCuQmeLblT5t4YPlM/FBhWqr94KqmbokkHoLxtV/Dx2zTKyZtTEg==
X-Received: by 2002:a17:903:2291:b0:1f9:f3a0:62a5 with SMTP id d9443c01a7336-1fa23ef7dfamr123367765ad.53.1719407173429;
        Wed, 26 Jun 2024 06:06:13 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:13 -0700 (PDT)
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
Subject: [PATCH v1 15/17] ARM: dts: aspeed: minerva: remove unused power device
Date: Wed, 26 Jun 2024 21:03:30 +0800
Message-Id: <20240626130332.929534-16-yangchen.openbmc@gmail.com>
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

Remove unused power device.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 8f3f15a5c148..093305b598dc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -144,16 +144,6 @@ power-monitor@41 {
 		shunt-resistor = <1000>;
 	};
 
-	power-monitor@67 {
-		compatible = "adi,ltc2945";
-		reg = <0x67>;
-	};
-
-	power-monitor@68 {
-		compatible = "adi,ltc2945";
-		reg = <0x68>;
-	};
-
 	power-monitor@43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1


