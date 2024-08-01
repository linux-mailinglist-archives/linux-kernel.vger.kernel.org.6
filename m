Return-Path: <linux-kernel+bounces-271556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED85944FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B55BB27474
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E77F1B3F16;
	Thu,  1 Aug 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzRSVj3F"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F51B9B59;
	Thu,  1 Aug 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528239; cv=none; b=cQeo3ec5khbMYPu6asEuV2O+ycRKxa1gIYz3cacl+5hmsHDiPyjmywj7zPveHu9LYtpY3zRz1CW8YsHA0CaBuSx1ftNyPzizw+jvUtEn7l0Isrc0ijHVUxoSjIzGNlDlqb8MdFdZNyu7tDxMhgDZfkEL91XyR1veP+nFKab02s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528239; c=relaxed/simple;
	bh=TN/b/VHX6EXvmp4zVKSMP3spReApYVkmps71pTjjR/s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcjW+nUD71hHdwMffBiQ48g6XRdZyNjZhW0UguPySWiMQ4GdLhTT8DLKTux0CMxFXnq+XtB0oFHHv/js1WaYXw1mvO+ayTpA2C2sVrvOpfwXK9J2ZTinh0WD9yhS+wGNToszxfL42290gN3/zOwKdKoAvN24VV8FL61jheuL6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzRSVj3F; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so4816495a91.0;
        Thu, 01 Aug 2024 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528237; x=1723133037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajViM2jGRh1ABanPLV3vCUCQ26Ko5QKn2UQG+HIRUz0=;
        b=VzRSVj3Fm5RQOAx4j5tbVJnjZlQGO9S6dzbsjqIqAi2UvkpG5QwX6JW7sXfHsbhgCM
         XQTJ5Jwf/T3pz+YxJL3Pntf55DPgoXH8pa1t4TpVDF686sQn5AY4ajtSSecxpGOq2yNw
         A9+wm8V0pnQ6QmQDwgT+78BdPBKGKDrpHkYWh0BFQeY0cmp86EDxz8e09BJ5G7ZqCB+i
         FL/cqP46IcAhJfy1vhAaGwCTmxb3AVIwjbZwgYKVgYGyeBjYs5eiuE/GtWYOvdX/ahtX
         MzBy0ubzRQ3bCusVHIcUglKmbhV55PCYrapD9z9npcXcs3fcvwaUzZtzwUbipWFv3ZGd
         7ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528237; x=1723133037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajViM2jGRh1ABanPLV3vCUCQ26Ko5QKn2UQG+HIRUz0=;
        b=YroynCGmjIK/dhP7pbinprSa/kMLYbAm3/klFq/I0F5kaSvgIhYNvimkS4x+3ZJaT8
         1Le3I8nIzz3hQjetJAfx0a5/voG6V9/qLXvuJz3PonPZkI0p9XNmVZp86fakL6vNy5nn
         JK/tpF4CAkIhJWrcoJRhFYkPCO17NaS8Zg2Rp+FXF2TRLCJpawSh3A9yDnS4KL9WBBd8
         pgmVkInWFxT95Lt/0pi+DM2A3htlWIUjELipdELjf5BRXhwWyYkZ1GFr95QsICdiLcRq
         kdFkkDfdZcL3P7BRnt3KZYf106XHGnNiLnCTsZrATNDz/tR7HrpLsEhkXCHUaCclf4t4
         BzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNKQXODBnZGJpguHqnEDfUPr0a/+LCmQVPM6seDrYcX9Fzdjx4T1PZ350O9mrCZcBECenoJ4t9xbb77X7rTikkXCVo9aMu5tIrzMJngQhTB0KEl/ZmaQVjHRxMT4tnnWOdqFJWsihpmA==
X-Gm-Message-State: AOJu0Yz3uJfDswAq7HoWQyPbof2TNDeqZbC5NH5aXW1vMbyqax7O0OdZ
	rnmHqqFYFIkf9P2eX4sFjpyCcqNUBeN630ERCuiaWgbWVvtNIzo+
X-Google-Smtp-Source: AGHT+IFPb9PeJdPoYShorYa0WgTFplfuAl/P62poHQZvyFWCRtV2xKyxZ4mK+zBEpL9ulATY7qrOnA==
X-Received: by 2002:a17:90b:33ca:b0:2c9:61ad:dcd9 with SMTP id 98e67ed59e1d1-2cff952d0e2mr842725a91.27.1722528237119;
        Thu, 01 Aug 2024 09:03:57 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:56 -0700 (PDT)
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
Subject: [PATCH v3 06/11] ARM: dts: aspeed: Harma: remove multi-host property
Date: Fri,  2 Aug 2024 00:01:30 +0800
Message-Id: <20240801160136.1281291-7-peteryin.openbmc@gmail.com>
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


