Return-Path: <linux-kernel+bounces-230774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9A9181C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7A81F2391E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937608825;
	Wed, 26 Jun 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKR/l4E6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1F183088;
	Wed, 26 Jun 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407152; cv=none; b=fEPdUC6qINALd0genudTvu5t7yuul2BvqZESVvaOraCo+UYE8tetr4YC7RsZQ5viZEpuu+a/iZNAptbIZEFZPQpx9AEXNGG21y7+ShuHFgOvoBXPJKsibYh2CCJGxC5M7IHJdrAL22zObtEJPUTooW6o9a16yYvs7LuWD545JPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407152; c=relaxed/simple;
	bh=vL9eGb0/XSl28YOX00a9vdD9i9Z8fg2+WV70SaHNYJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWd8azqqt3cjqYpl6nzMcUlAldQxnHpeQRt8Atu9j5gaK82PIN1Kqndp2/FEZJAz0KhhqtlOR0Vgyq1G7hzUCqN3NjsQzZUXepHI+a5a3sijZoUE60fZptuBcgZS1eE7cgfbKWPNeocy0srC2Arobw3LAzxvjlxNKc2VhwsQK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKR/l4E6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f480624d0fso53102485ad.1;
        Wed, 26 Jun 2024 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407151; x=1720011951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2tr1hBMLOFEF51USZXCVOmyouauly2LVBpam53aFYQ=;
        b=KKR/l4E6Lni8/GSvfIjdxD1GK+ojFOfCK6XmJQwYbx5lRCGNDzvQT2h403DQu/nbqY
         WWbnXOYh56seyaO9MlFPrqTRMmHiLSjIFKX9+/07QGoJH+UVwFjhsLyLsJb/Nb5ys6OG
         pFLVUdyhSUtqkrRtIImiGVvc5+451mt30ctsEoO9aouUC5QI5oAVdPLIQFkWUxZ3qgwW
         RYiu4wag+WLVo9qZQHt2LovGI6wuYM/STYuN6gm9qwr0OHxmBXR8NdGI8FTB+dkyTHQO
         WSWOiquMlHXqvyy55KlkHF69hjKLAMJ1Qm/s4tddJ5P3yIYV50AYzXWd8rrFU4uXi1yz
         7R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407151; x=1720011951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2tr1hBMLOFEF51USZXCVOmyouauly2LVBpam53aFYQ=;
        b=fPQLVv7YcXv63nzH18bEdw4D2k90wE0deOo/ZZrmizCsOHidsAEJY8LCz5dvRBlUyy
         raRLoGg8vo94b3i1NDbxCvridHdUMzwe+3j4Yv2GIZhMpDZPGeZRl0hh7G4OXU1qmCsW
         EMdHwwn7Yz8p7np9IetnfdoWvqvkusgrAx+qqhWRxGyOqVq7gPYA/sRNl/R1UD3sJJum
         cJVx9cQ8avUlVwkN5ROOAVQK/AGi+p2wJFNCL/lMW5mJy5rZYp+tFCmH7YUKJqBxKxBQ
         btt5VVjkZN/lNuwMvUG++g8YgRS/3bTLxV8LLRpDuKiNIaMeOWajVteHq2Ht9Wfr99AL
         rq0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdJfgqfOZnUSiVAxmCMQMilTNsLLUtfZ/9pYhs66ratKMfes962JbBdhc8FObo6HbbrEO8mc4ILhHFHg2kfWhMMEmtJGarln96m2lodr1cc7O5myiTVoiGtjGEU3RPqk2vMP7hBurXfQ==
X-Gm-Message-State: AOJu0YwRaN2o6yn4PAZYKnzFu6EhjMYASJfIggBhc9EbTlQC7npl+AmD
	SUy970AK6KdqGll1fw8dGHjX2FMzuajCpLllf3UQRH56S5Kaq9JtPCOK3m/v
X-Google-Smtp-Source: AGHT+IHSfeIrTbbzVMgHrBphxY5MvfF565Sp77JHt0bggXN9+n/m0mIZHPPoEx27M6p9TIY5bzs3/Q==
X-Received: by 2002:a17:902:ec8e:b0:1f9:d6bf:a678 with SMTP id d9443c01a7336-1fa23fd8c48mr121483215ad.32.1719407149911;
        Wed, 26 Jun 2024 06:05:49 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:49 -0700 (PDT)
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
Subject: [PATCH v1 05/17] ARM: dts: aspeed: minerva: enable mdio3
Date: Wed, 26 Jun 2024 21:03:20 +0800
Message-Id: <20240626130332.929534-6-yangchen.openbmc@gmail.com>
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

Change usage of I2C bus 11 to mdio3.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index cd321482aa09..13819bc166cc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -78,6 +78,10 @@ fixed-link {
 	};
 };
 
+&mdio3 {
+	status = "okay";
+};
+
 &fmc {
 	status = "okay";
 	flash@0 {
@@ -315,10 +319,6 @@ &i2c10 {
 	status = "okay";
 };
 
-&i2c11 {
-	status = "okay";
-};
-
 &i2c12 {
 	status = "okay";
 };
-- 
2.34.1


