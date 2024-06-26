Return-Path: <linux-kernel+bounces-230782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0C9181DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877491F21AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFA18A932;
	Wed, 26 Jun 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHbxrTLC"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68F184105;
	Wed, 26 Jun 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407168; cv=none; b=cGpzpxzHLts0HvJHU+logZHFPx67rrQP5tDM8zClyTolA6PpTHDvtkphCFmUeZ/OQ5B3ZZ6YAl8ISDkzoTSu9owHgn4C8OVv2KlMdtNGBQlUfF0L7gMq/jvOSj1KR6vyGnfYHHKnySi0EPHKo8JJjnFcoZxetWVGCxaNTliq+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407168; c=relaxed/simple;
	bh=Y30furkV+cMSEv1GGvBYubrYp3wihc3Azqh0Nsma9mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOGEuuv1Lwl/pycxGiZG6XGiZB2zqR5QrZ59AnsQbwexmApbnch8GKQVsua/pLsMprdY+Kr/f3AqEX4ozupMgCP+YcIFrqee6kEY09+zTR9eENVWM1piGzuLDyFnOgPKTx4Khg4H8HQ5hKIjP+y6gNdMGjzjcxYSmxSupwanmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHbxrTLC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9b52ef481so54429715ad.1;
        Wed, 26 Jun 2024 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407167; x=1720011967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QMNZrdOhBJtXo/ncaekHBRhjTvNlqY+hHR6bexm0Kg=;
        b=QHbxrTLCMpSoebmUz4lZL+qbLPUCmEX+xrjG6RbVsNbelhSvP9BVkolc2vut07O83h
         1w72TSHZ3s95gB8oX6L8/tfqm/hTmyX1J6jH4gfM7U3CLB7aGuA8jd2srfSMSCHO2uHe
         rfUWSgn9BZ2GrVVEsKK3O/oHMcYv1IlSsyg6i465/6tlSCqyKMpHLeB+CLE8QdrRt8+2
         h+OzMcFoTFLHoqElrLZFipJrAnUEFNORM2rNqogJ7pAc7B0w10GwKVrO6SWbboOl3ow7
         XSm0Qalk42WknsL/SlAoB2qLzYETOfOBzZSCa2Z1iMrIYcl9FU6Qv1lT2FL/Csd7tVxX
         BqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407167; x=1720011967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QMNZrdOhBJtXo/ncaekHBRhjTvNlqY+hHR6bexm0Kg=;
        b=YOAdC+QHkOtvFRAc9MY02MgEQ3COC9lOOZJ0Qo1fnzPXtJoh0/fRUIbdd8expUU4aG
         LyJkchHlYbMBKvsLgozsflZ2vns0L+yNNBdEm2CikAyxqDDU5x8i/rBf6p4D3RWY/RYV
         GFaLTAHfUvQ0gygIJRB5vfHeQyPa/s4ySrLFp0jxeawK4wDDxc+I1yCk1SOfWlHd6V4j
         Md0pYnqM+cF+rc5Sr3HjRpObdWWz1nh4rBg5rl0HoS3gOG+TmPtkeiYwbzMHO5QkgVqN
         Vt/s7/wDOFWVP5r4XGhRhCjgVsemdiVDN3mhs6LGFdwYrhG6KWSBEYS7xbUQ4qEHcdHh
         b8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUv9kPWBLcjHCC6nJ9rLdKwmrqhZm+SeaqHVCu8/Lsi4KZD5WLqV8ykwQJS+gRcgVN3OGflZT3m2CaHsfnNZ+6nRyjUyb4yGOmVLMX2Y4Pb7yA+QmbRxSJg6g799nQXOwy83VjIhAzYfQ==
X-Gm-Message-State: AOJu0Yybu6RPvyPpk6/CEx5Jt4WHEsa/Gfe6iTs0pgqu1vAh8DjzdApf
	wgm5f1pf1qmanpuxxX+eMB60nboB0pMSOozd5z1LZWFggsqmE05n
X-Google-Smtp-Source: AGHT+IGXLyzlC236sq7iVFAmdM7iFDnu3HHVf2NPqgOoGr1Q99dC/Kt2LUa8EVydJPm2vIe9lGvA2A==
X-Received: by 2002:a17:902:d483:b0:1fa:2270:450d with SMTP id d9443c01a7336-1fa23ee0fd9mr106842485ad.27.1719407166681;
        Wed, 26 Jun 2024 06:06:06 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:06 -0700 (PDT)
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
Subject: [PATCH v1 12/17] ARM: dts: aspeed: minerva: add power monitor xdp710
Date: Wed, 26 Jun 2024 21:03:27 +0800
Message-Id: <20240626130332.929534-13-yangchen.openbmc@gmail.com>
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

Add HSC xdp710 on i2c bus0.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 3d80993885b7..0c305ddf7011 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -154,6 +154,11 @@ power-monitor@68 {
 		reg = <0x68>;
 	};
 
+	power-monitor@43 {
+		compatible = "infineon,xdp710";
+		reg = <0x43>;
+	};
+
 	leds_gpio: gpio@19 {
 		compatible = "nxp,pca9555";
 		reg = <0x19>;
-- 
2.34.1


