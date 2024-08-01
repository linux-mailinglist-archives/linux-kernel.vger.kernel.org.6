Return-Path: <linux-kernel+bounces-271559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828A945006
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C7828542F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8251B4C23;
	Thu,  1 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbKT1jG7"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775E1BB69E;
	Thu,  1 Aug 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528247; cv=none; b=c5E7+nqy/bOLEp0583zoKkH+klBQmv7/CLE+wbEsgF+/lQIv6FweLHxtzR8d2f9RFRCZEtA8lWH9ci3COcreyyiWi0oBmUg74qxwYTDnUcbPCcahshOc2icXNvxAsaLXrzxIkAeEW7IVxDqFCnehCZaAsaa2VOKvmcCnENEqlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528247; c=relaxed/simple;
	bh=deTe5yBj/aIe1eSH9PAeVb4xbfDI+OExfQQ2xqBivwQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZE+i/sLeIG0GXSASvgptHZfbiqZ1ao51VaS1js+O5LlKwQ07AbPC4ycDY1pNz9KuMPOcs8NpYMNlosBzE/wjtzp7JTPACPzmsbU8G2q/4EY14eyJY3qXliBEJbG3DglmdyidY8B/Tt62vxytEBdsHG7/+QI9mPW1VhWSwj0f0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbKT1jG7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd2f89825fso4928882a91.1;
        Thu, 01 Aug 2024 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528246; x=1723133046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9MVRVw78cAnGxBai+z1t3GEr8C1bFmf/TOYviQnigs=;
        b=PbKT1jG790uxJTyy5XMDQPMrnO47NcXNnz6qmj0o6f6TgpwEDAUDOri9lAeKtEZ36E
         50SRfk4ICykqBrRvy97wkCqvcURiipDvMpb/4Z0vYkzYIYA2DFMt7g7LBntys0KRyNL2
         O8jRVUcB/i+p0imRVZgzUwIm+qd8lNvxycqGNxPmqKr5EzPx9mUmy64ByrqW+MLFmNIu
         VucQYKPPq0yRbck42jxCy/rzPZlV34K14gf5YmgBDa+4Z5k4I+ywZJvBTmjViZbzK8/E
         6iS59ZSMtnoer/8+UNkP5t5TxEBaeXTMtVgxLdscAuMFimUUIoVI+4Y2m1jVMz7dbxDO
         6snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528246; x=1723133046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9MVRVw78cAnGxBai+z1t3GEr8C1bFmf/TOYviQnigs=;
        b=o2dbRWBt8rJr0+y/WJTKNkeEpEROuT0dJNOKbXhYwPnGUWGyNfVL6F8CJPxlXCJ7YC
         wN68tZSBM2MSDH4JKUMfQNP7AvlFPSJmynHpp0tUpeusOrxb6CFDa1oOKWqPIikh50Dr
         3aw6uIoJLsBda5XLyo0kKRhbelCusI16ACZrbNa5JSNJw5/SUvltGgdnA9C7oZ5wO0zj
         lz3KLmwpYou+yAIZLDyMfjY5zeVEgcrNsLjW0yrX8r3x8K7oWh5W/MLttPeER6GCUQZQ
         rGjWOiTu9tO9O+klaVfeso5Ycvdy/fV+0P7Vo6uVbmEtW01akNfX6nAUsrKGE2Lh+2KA
         mnBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxDBBvjGI9LhML98J1BH6yfcVVXMWANBnLA1i5mek4Cxdo1IVzCkqvGPh+bNN1LpowRgW5tzBtMboixGFVtPjdpk5yU71lN9z6aVYAQO5xzXQgrAsJsmh8BZQg6sFEq1Lw6sQfeQ2RNA==
X-Gm-Message-State: AOJu0Yza4ZlMtSShqfet8NBvWYzFB5uEWZLAg1PwIqwBZi3NUgth07yi
	zzMOvwRpQm54Qs5Wli073tYnPXaeUAEN/8WeITnyAUKhcAxv81+X
X-Google-Smtp-Source: AGHT+IEHZrIuu9OOWAbdOXoUsSvEIMIF2LGmw91wiJQnNRv7S4gMKbaWOSTWTPf1B+BWzPSqb6QiUA==
X-Received: by 2002:a17:90b:274b:b0:2c9:5ecd:e3c4 with SMTP id 98e67ed59e1d1-2cff953e8b9mr833249a91.35.1722528245351;
        Thu, 01 Aug 2024 09:04:05 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:04:04 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] ARM: dts: aspeed: Harma: enable mctp controller
Date: Fri,  2 Aug 2024 00:01:33 +0800
Message-Id: <20240801160136.1281291-10-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the mctp controller in i2c9.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0455475fbcff..0dd0566bbf27 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -382,6 +382,14 @@ &i2c8 {
 &i2c9 {
 	status = "okay";
 
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	gpio@30 {
 		compatible = "nxp,pca9555";
 		reg = <0x30>;
-- 
2.25.1


