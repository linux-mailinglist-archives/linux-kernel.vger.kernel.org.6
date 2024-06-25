Return-Path: <linux-kernel+bounces-228831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB391679C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C671C22237
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B316C842;
	Tue, 25 Jun 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YupPcvpn"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC7156C72;
	Tue, 25 Jun 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318063; cv=none; b=GJ65vIEHhUCtLHI0WdNTmzGZiDzMUJW4W3dIAiZhdIbWcFv6auI6M2zoPYqvAJLYliyvmHOwm0ecMb0xpF+bInbABsexFr63z/Ni+5jlyzPMcqte3Xn0su93Qg58uh74zhFCkrAMepi7Gf3KFX+iDES0W6mHVe+xP95wvkB0IkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318063; c=relaxed/simple;
	bh=VwhPShI/W+0YavZZWv1+wIpDyJJzGO+3AmzkFNkgaDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTGKt+yuep3WpECzZxvjyNLBqjL1qg7meqSolwYYt76PzRrWed0FuRjx/Gqu9yUMf41GXr0EYEbhLkcmRPI9pmCrwCNRTXI6XCwzb0y1+vecjlE9u219GCUQUsItRAqPVOS4eZ0hB5bTSSsX1ObmgMCgVwsmsswXjw9r3yK8GEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YupPcvpn; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25cc31f3716so2419339fac.3;
        Tue, 25 Jun 2024 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318061; x=1719922861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+uu0rzbI9pJ3uqj4sfpv2TDkc5Xd8qKMrPrJB5mTeA=;
        b=YupPcvpnPKst5HvRvSsdrSXK5Mk1RSS+OdbfLh0ZGFBOf4kiYyDUhn7PfECII7xEeC
         atqW75xn6ZWGFLRUf2ynBeUuW+tR+/WzDIbP21iwwTKXDRxXARpczTeE0FgYwdhakmLj
         /qZMEp8eow/kAMDXVS8PV7cmmSSMwCLTPSmAaS5GXU+r7jFui3SgNv8fLg4FsEQhoMAs
         yo6YyilYCSzipRgeUdrZM/32xNZKaVnvuLwxu71EKcUnV51T39VcB/S1AD8D0VPs+5tH
         e/nXkOYmaCKaPSP855xrFHmGbau1UsviSgVeTSUKZg5Cn6WGqur5hUTNhSVgLy5HLeMo
         HCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318061; x=1719922861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+uu0rzbI9pJ3uqj4sfpv2TDkc5Xd8qKMrPrJB5mTeA=;
        b=nj2rJF4rTr4uF1a3OJ7Fv9f5atziUq92O2Ydukb8a6Ilh6mGUIxu0qnS5/bYlodH1v
         NHZkr42/4qzcA8rj1fa8sPadrUOGgbxY9oaaGFzbCJHEwChiYWlLMlaFZOkBygZsjVtb
         ADEr2auCTgpjnJJzTEUjrie2EdlV6g90btXP5TkUle6TbkahUF5Y0bqF2srLkRhhKdwm
         YwRg0uSv+9CL6HRqCCpVtlwJ4FTABDoUjAn2375ZLFD8MQIV8wnOKzibnrgoYsYWWsmM
         57pqt3/7x64SrCO2C997yM4VFAatB84T16iRxoUBCAoGUTchrz1/DqaIGchar+nluyt3
         VkZA==
X-Forwarded-Encrypted: i=1; AJvYcCWeAtODx+pbtbxm0zzQsAbr5OdT6SpJ1jfhgssL1M9egBlRxNLLORoMLcY8mBRiObUd7UCOmLxYAZwt8cl1zlr4tkTng7H2KGo2fTS4mg5wtUg0HY4JwwyOanE0bFyCCdNlR02a2C30Pw==
X-Gm-Message-State: AOJu0YytituFTGcSpPcL5WYJNnt9xwd8inPhHJ7FTbh3ZS55plNEebK8
	Vs74IjRpfJeNUgEjECm0eHAiPpzyd06g+46QCgSJXD/qOA3USx0u
X-Google-Smtp-Source: AGHT+IFzlgZ9Z+5jCEawQ1SiycpI5lPWJJJD0pvdaDoBayUOkNEUq+4qzUui5ha/KmND4tslTbZuqA==
X-Received: by 2002:a05:6870:568d:b0:258:476d:a793 with SMTP id 586e51a60fabf-25d06c3133amr6758374fac.19.1719318061201;
        Tue, 25 Jun 2024 05:21:01 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:00 -0700 (PDT)
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
Subject: [PATCH 10/17] ARM: dts: aspeed: minerva: add linename of two pins
Date: Tue, 25 Jun 2024 20:18:28 +0800
Message-Id: <20240625121835.751013-11-yangchen.openbmc@gmail.com>
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

Add linename of two pins for power good/control.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 60beda2737a1..58a083536c79 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -578,12 +578,12 @@ &gpio0 {
 	/*N0-N7*/	"","","","","","","","",
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"","","","","","","","",
-	/*Q0-Q7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","","",
-	/*V0-V7*/	"","","","","BAT_DETECT","","","",
+	/*V0-V7*/	"","","","","BAT_DETECT","","power-chassis-good","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","BLADE_UART_SEL3","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-- 
2.34.1


