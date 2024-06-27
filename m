Return-Path: <linux-kernel+bounces-231883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D339919FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB299B2294C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F4768E1;
	Thu, 27 Jun 2024 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAMQWfeL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A273477;
	Thu, 27 Jun 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471639; cv=none; b=bF/MwbsGnmK45n21NxWkI4gyHOKf3m/RrmjKzrDY+PfBadtwvpl38p58Oy5XQSB2TkbCVvUqYOmEJ6zaiAvOe6pf5PT9QmGwOUkKG3Yetjtivz6A/vxaVmYCaC+ThmYUVMtDLH6kh+CHz9nxPVtjOwc85GgMnHx50no56R37A3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471639; c=relaxed/simple;
	bh=TN/b/VHX6EXvmp4zVKSMP3spReApYVkmps71pTjjR/s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GOTS+Kg79T/D6gRGaknXPcr2GUkenpfMWI4NI7Ngcax2ePaMf4Itvh4gyempxpA23NykPymA2hf1RjTnbWp1RT/2Xo+J4esV8zseG/FZk0Tv/4NHvq2HtaQ3vGKGosuseD97yzTwkNr9ewAWQnjZyqjqu88CI99b7RuMDIwvGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAMQWfeL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fab03d2eecso1327725ad.0;
        Thu, 27 Jun 2024 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471638; x=1720076438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajViM2jGRh1ABanPLV3vCUCQ26Ko5QKn2UQG+HIRUz0=;
        b=XAMQWfeLtPjDtHM64/chxHr8qYxDoqNoF+CiCwQyil1K4UU0vSBU6JSzJG8gZ7gBnX
         02TUm8YvYwWcllLFeusYeZoCzQmdXJdscktCwkH+dWXlEPQRQ3IWavxNfwf9yPFOm46r
         DnK79Uz0p/nasmw8+ARj3i3nXKQEngxAa6ctyHk46sZBZ/LYc5DVUhA8Bmgk9pA5Fzqk
         l/Gfaj6nxf9NE/T4PxczRH6trgk9thLZlAkLf5spQIktBd9VhQlxQUAFA5e2HPosxwtu
         J9A+g8R4Ix/Y1EI52ptUDqFV8sio7tOFLjIWvlotsmaZc0Jx3XChJtpGEJGOvdQglU5s
         nXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471638; x=1720076438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajViM2jGRh1ABanPLV3vCUCQ26Ko5QKn2UQG+HIRUz0=;
        b=nDozF7q13lrQ+LLLGiApo/iPEJGy8kzhgJQt8zZn5PJ+iwvQsdkhD0APdwyZ9o679E
         T/M2S4mF1itRi3WZ3fC7pB6dQWctaFzj6S98e/vFa2c5Cdj/tNiWhjVK8pxDg4mQEOFk
         So5cRYrapRN3Bqify5nzl9mNPbXodmIPE3Hs++DFlZS8A9rY53v233NCk8JAxTggdu4f
         2YosfJBs5Floq1QyFDBVVYCDekpNHsVdEpfj7x7g36FqbmM1rguZLVD+EI73gZ5jCvju
         vNROPuNdYt+0eyJW1dghR/gpE6q+NQfAyxQPGkjQhuczuYd+6o2y7DBoiJiDlMqP2VUU
         E7cw==
X-Forwarded-Encrypted: i=1; AJvYcCWfmqZzgWVxD6DnuPPSOZVOVwr2bvDOqC9MYtBIlQU+gxSDWQHqeczhxXvOEWxRZJz2mfO4PeBXhZYfnQ0z8/DVYXWOIhTGZ3njfeOZflOZ2DKvVEMNwtb0hn30yI51AwP8m4kPuLiHOw==
X-Gm-Message-State: AOJu0YyT+zVfOZlMWeYdwexmmJzG7unZzONVho93cxgY91Th/PRBaAHK
	/wSKEqQ68P5aCFZmwXhxflSxr9nDImdQSkXcnyGTevZ67inRZu63Jo/AGQ==
X-Google-Smtp-Source: AGHT+IETBCx5YCEJZX39L9A8AQb9JDdAOM+gY+JVJVtM+N7VYMYx/ch/4bo//zcOjJzbBVgkPHRJ2w==
X-Received: by 2002:a17:903:22d2:b0:1f6:fbc2:526f with SMTP id d9443c01a7336-1fa1d52ac13mr158017315ad.32.1719471637939;
        Thu, 27 Jun 2024 00:00:37 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:37 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] ARM: dts: aspeed: Harma: remove multi-host property
Date: Thu, 27 Jun 2024 15:00:08 +0800
Message-Id: <20240627070013.2509150-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harma is single host, so remove multi-host property

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 77eaa89b5eb5..e10ee54fe472 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -137,7 +137,6 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mellanox,multi-host;
 };
 
 &rtc {
-- 
2.25.1


