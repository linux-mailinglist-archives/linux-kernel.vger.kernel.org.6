Return-Path: <linux-kernel+bounces-271555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656D944FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689861C20F56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA531B9B3F;
	Thu,  1 Aug 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUTO4/Ty"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6A1B3F16;
	Thu,  1 Aug 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528236; cv=none; b=MCIznzRDeOQmleJ1qBM5ayxXObECg0omTEXTLyf34EzBS7pMzx8oNE4rDMGwZZw7aOW6XLjWYrsHbBmvpG9wwmo+BUMLtd/UJ3uqi+92c4pLCXa8x5kYjxV6QTlNaYVbh9c5vHoUiYFZLmtibew/y3HYxMoo+2ETUeQxtr1gccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528236; c=relaxed/simple;
	bh=qD5mKUPsOffm3Vw4RvRq91ySvZyMyi8SCo4G6Vl9FFY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaX7J48XSPvsefnT4aAwAHFOd62aMR49M86X2TDmCTgJYT93JTZ3uhGKZHmC1YiiHSkYZANsX8vFY5M0ITjlZezL0x0NG3rM+F7lBSqvFG+EHlaJABI9XyL4Ube/0ZMNj1AW/OgGNcFpRScPPSuWovxcjoQnEVmHZvaIHPjd9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUTO4/Ty; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fee6435a34so49945325ad.0;
        Thu, 01 Aug 2024 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528235; x=1723133035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i53cLyoOWskUbqWkTIcWB8akUWR3OQ8O+64UE165czU=;
        b=XUTO4/TyRLzfggv/epzvgDJhe1pXSGu/kWyfwVnBByAOjiRNGuiS+wkSaYUi6Uo7Lc
         3VHgQXqr6GNEuzXrr6tSoyG/HWhWq+BoYFJJDY7I6GJLJsEZ4VEb//eXeqPTas1ZO6pv
         DjOzEGfYJGvcwRzh6rdQjTPsZcadlc0IZ5N+9CpzGKU56/e/Cu2wphO+PwyCk7yCfAJ7
         uEFzAFifuDUJzl+poK93NlwXrsx9iK77HUQAFOUDUH1gB3PBOhFhu8R2Te+bgI5VZfH5
         QGneep8LuUtAMe7JFAzRpNwBrr2rVEYf/bIvH89/BTgkbulOQJg9KzsvKS6rEIyQXz7l
         MWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528235; x=1723133035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i53cLyoOWskUbqWkTIcWB8akUWR3OQ8O+64UE165czU=;
        b=crbuMMTpYSJjt87pkMcY/5My4Wt62Eeo05w40fF/EEatTIOhsEB9aib0J3Hyu8X/Vf
         0F6csCUmn2tDfW1pl3JaxnoOGpMf2Xz2WpDp2MTO4bSIBDSQ1eNjFsipQ+LfWtVBfUn0
         T7NzCKJnrdQUxSZvRzKhG4KOdjNvudUsSR+Bfb3Mnj2iUiX9Bmkqk+3SA0jMPAnLN4rr
         78w3zE8rPntUdUZGsYs/U+kKUF2bzZNAR6yXg7CCPA6weFt6rTcOePGc+gtCxK4QT8z0
         4RHf6SQJIydoKBwWjy0N8Lh0gg+Xt3OEffXYe6/LisKjA2TGJihu0L76/gTuVUNqqRIk
         Ci7A==
X-Forwarded-Encrypted: i=1; AJvYcCXL/Vrn/GqvVB9iHpc4n416lNtItYyITP7iRFTzoYhnPLjIFYzuyy6CXXdxRwRRhQ21yT3U//y9fD8F2cN0nImzcBugxAyJrmTu1fkiNWuZHE092hhS6o8svdi+ICSvTUGiZcEsyBD0yA==
X-Gm-Message-State: AOJu0YxU14e/RvNeiGQndFhqoQZdOUvERCEhlB+HkSE6+xRi2qObJROS
	6XItYBia7DCTSzx8iWWGSuDqj31poWnXC3rPypk++PB5ma3IGYw0
X-Google-Smtp-Source: AGHT+IF51Wm1Fa27JRzifXEOI/YiZwqF2TWAqItZdy9cFpwF/EfTGbqgQ4b7xHAjLtWCOT8kI8J3pw==
X-Received: by 2002:a17:90a:1bc3:b0:2c9:6ad9:b75b with SMTP id 98e67ed59e1d1-2cff9559d82mr668031a91.40.1722528234347;
        Thu, 01 Aug 2024 09:03:54 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:53 -0700 (PDT)
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
Subject: [PATCH v3 05/11] ARM: dts: aspeed: Harma: add power monitor xdp710
Date: Fri,  2 Aug 2024 00:01:29 +0800
Message-Id: <20240801160136.1281291-6-peteryin.openbmc@gmail.com>
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

Add HSC xdp710 device in i2c4.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7d809f1636d6..77eaa89b5eb5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -329,6 +329,11 @@ power-monitor@44 {
 		reg = <0x44>;
 		shunt-resistor-micro-ohms = <250>;
 	};
+
+	power-monitor@40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


