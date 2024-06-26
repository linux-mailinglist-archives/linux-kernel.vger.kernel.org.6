Return-Path: <linux-kernel+bounces-230772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7B9181C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B9D28193A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54D1862BD;
	Wed, 26 Jun 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxKuNexD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C1862A0;
	Wed, 26 Jun 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407147; cv=none; b=Gc6xkjUMJpbIRYR+dXvOlH0wJTo4fS3VEjZNABug1l6B9NqI8eGonjVJh/d8KJSGocoVEyNInfLkoRN53Jv6crFFkIYYrxcRJhwBl4vlv854YsoxRcGyvYQpg0sRQg6Cm8a0A/VFq2cs8TjA6h2mr+/kM6X3tn+80fWAI1Gic98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407147; c=relaxed/simple;
	bh=HQ+R9be6MwsxvOMJprxusyJk9sCrNiZkf4N9AQXjCCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/ffCuN3WQZre5ev/l/afwCW34kZmCvRkCrrq3m/K/uQZtX+a8OuhK2piKwxwybandyrjj1NI35evPA9cc8L7adWIqlthaT91Hu4elqJu3lNA97PTYtBJgTYFjUi5F1TEm1hKNBanm0pr/QSBD+9GN/IKtnr3K+qp3IW7BzMpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxKuNexD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso4244612a12.1;
        Wed, 26 Jun 2024 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407145; x=1720011945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzrCq55dKnidKKqWO6gxlx5gu7pwGXx0Jy9uGAk4Shk=;
        b=QxKuNexDYhC25Om1D5pI5Nypx89YrEb6H++mPYt1DpRoi2gS+YMhATt0cTQMdMGBFB
         yCzdwxuX6gY90EUOCRGJKctLls4UhmXdnBPJtVEGvKRulquc7xGj7ZudJfSixnq9ZHgR
         yZOwRnVVdVTUxjmjOUBKQHoSAZsOZ39j8Amny5DyUdW153qfUH8nV7TqTYpZ+XZv7zjj
         3aCN2v71kjL7dBEl7/nCzpcN/GSLTlcD7N7FL8K/H2iJK9X8FnJKpwYrdSwJCrjNEWbB
         rpLe57oNYN038p/wH8M4ruKrHh7ZEtgp/uqnDNrrxtt5mPahc7AoHbsSj2SsEvS+w2RG
         OPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407145; x=1720011945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzrCq55dKnidKKqWO6gxlx5gu7pwGXx0Jy9uGAk4Shk=;
        b=XW+4iASssM4ph2/tEOfvWhdinAS8R669ameS2HvPPpo3vEprnM1j1hmzJPi+jaXKON
         O0omtUXneMUfudIr1ktClPMS9VxPebKbqLtTQoO+yCuGptdVY2Bx6UBGiCRg6WezQ1E7
         1kP4DYh6aSVHj/wevRjxhYfHJqpUCIBxk4ZQlfnaEZPJ6D/RdyPtnYxH40HyWqeZIOms
         1Df5XUucecPbGJbjYodrOok5v0CSirMJ5xU1yC/vpehyuV3a3G7z6WJyXnmFZbC3Zrrh
         U9tiPENnj/NGHSWSHgwmLlrsyd6dsLZOaUxKyhK5kw28DDTcjyzPhdhscZp3C7iNbPxE
         ridQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+hKeE7ho6QWP9ZnV5eF1Csa0WhT6QaGO34Hi1aM+WPjOh2apWfQSakZDfP6mBizKELhDPMowVJ5CIC6EgcnS5Kni80BjrQpSlkw33wtPHtl2b5riHmeQI7Ej1UEkBxM+SHDyuFv2Jhw==
X-Gm-Message-State: AOJu0YxdbYqWOfjDRoUfl8CUUc70522UJXIaAKizn4dr6mlZoBlXQwn7
	2bLgOWPuVwCWLaTYKzUBt6oC3BCfLcMy670I8jgLvHyrJnOhyoUn
X-Google-Smtp-Source: AGHT+IHf7+ogxtkMxGD1pJSDaWrkFB7juf0VolxR1uwEtOkvyARWQpS0ooJkVqMwWl6G58i8mN3xuw==
X-Received: by 2002:a17:902:c40e:b0:1fa:2568:5895 with SMTP id d9443c01a7336-1fa256858femr115768095ad.63.1719407145216;
        Wed, 26 Jun 2024 06:05:45 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:44 -0700 (PDT)
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
Subject: [PATCH v1 03/17] ARM: dts: aspeed: minerva: add eeprom on i2c bus
Date: Wed, 26 Jun 2024 21:03:18 +0800
Message-Id: <20240626130332.929534-4-yangchen.openbmc@gmail.com>
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

Add eeprom on the i2c-9 address 0x50 and i2c-15 address 0x56.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index ca3e417d2c7e..60002b8cffc6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -303,6 +303,11 @@ &i2c8 {
 
 &i2c9 {
 	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c10 {
@@ -339,6 +344,11 @@ eeprom@50 {
 		compatible = "atmel,24c128";
 		reg = <0x50>;
 	};
+
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
 };
 
 &adc0 {
-- 
2.34.1


