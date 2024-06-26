Return-Path: <linux-kernel+bounces-230771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205C9181BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E05281A31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3218629C;
	Wed, 26 Jun 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE+pGWX+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1354186285;
	Wed, 26 Jun 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407145; cv=none; b=ZnW2y8r0lxqXsAJroRV2eMGvXIxcFyqTBJH0TOSPXnJ7pWTQ6adUfraHcSNVTj2belzcQk4qtSFwBZTFrh9glhcBRq5SwqLmfiGDSgirmM/c4kmmrth2pV7I6behwlR22G6TXF6zIVT0uQQ5iEIy4b8ZawdWneGoVPqmsvUj2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407145; c=relaxed/simple;
	bh=lc9kSa2hxTis3PR369JkJvJViMceQy/8ylVOSj1YHhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQAPN8bN3TM3hTLGmPoYL6gaUbcwlRDrYLNJfNopjk887uLcI8IfSOejbYvuJRFlEPLLZMF4ZzcViYvl8diKm2IqcgksHE8KmVJUQ55mUuFZ+Cywpi7sOQjTINmReacQcZ8LMVfsr4ZiHKsOFlIp1MmV3MrynhS2KvL4Ww3GMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE+pGWX+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so26499725ad.2;
        Wed, 26 Jun 2024 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407143; x=1720011943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwLRvqkTKJTXMBBbAKtuEYSjWz9CZpPrtmi6SvMMZc0=;
        b=EE+pGWX+8xGcMpdTtgIT+2rr+vaiRAqjXz+xzrFOGKg0Zk1nKMrtxx5M/vsDxiLASI
         n6+sg/U17JdBbqxf379QZk7GzpCG6a4IEHo0eiDzebavgukYwzjJK1Gg8UoU1PibAywA
         fMhejNXmZpz4ZV1jHiGfcTfac6XW5h9Nqi9fJ85b/YXCkNbzT5Xcs/hWf96LDJeBx2WM
         XcaEPqP2MT6nV0VIFVnLfotawOdkDfv9VJBL/JmWoAxqxCtTepm+jMMkKHR+WiX/woNQ
         gpKTMOQiLlxQxvN2sLO3fkVG0TYpeF7oeZGfXaRlXsMUdRk+5SooytbOyFp9+miVUnS/
         uImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407143; x=1720011943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwLRvqkTKJTXMBBbAKtuEYSjWz9CZpPrtmi6SvMMZc0=;
        b=Y9U1FxRsciaLnTusPJbyCzrBo+Rhdt67dgWGCjANbUiMINZPgInOdOF5vuzil9Jp2y
         59w/0WT+NsXttVL2f/2te24CUo6oeN1mJ/HStZg6asFPLES4yg+tLYZe7mfmrw9DvdVN
         Z3WEt70+FUOykdUOTL6v58ou4tIN8+Ln15SopycoNRqEjnbXzvYNxgVgVVU2K+iWVEZ5
         qr8D8Qv4KqwkcylrD96dXL2M7PdOxBfRI78fd0QwlZR/wQUpb7ROfNn4ffkRqX4GNly8
         /AnEWswdAbnsCVZOVFk2CITXHHFfs7wXX7TjcXhN6RRhHNn4Fpi+FB9BnaNNWS/09uBV
         OiOA==
X-Forwarded-Encrypted: i=1; AJvYcCUODrzT2eVhtVHwjYkZpoNUq1/CydLTgNmU5PBaETxVazbJZj5lpE2Sv3a/Y+ieXto6AzTzoZzNB03rVMUNaW1jO0hKovWpy8dmjL6Pl89DU+kjM4T/b9mjYx6/hkH6nbMzaMUXbLzMSQ==
X-Gm-Message-State: AOJu0YzmlluM6L9u5ORZCLN2Mb3tfyN36dk+6dxeOKZRpbeJf2YpYJ7G
	kemAAmo4h+LGq9J3mDOleKxboyne/8NQcD+zj+4YpBUaVBHVpCjR
X-Google-Smtp-Source: AGHT+IEMJa7XMcgEXmYjitMuEjQPUMYdDdat7TumJMvXRj8VCcU3DEP7Jd1tgcM0j09sXKozb0rYRg==
X-Received: by 2002:a17:902:d2cc:b0:1f8:64e2:73e4 with SMTP id d9443c01a7336-1fa23ecacd5mr149796295ad.21.1719407142076;
        Wed, 26 Jun 2024 06:05:42 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:41 -0700 (PDT)
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
Subject: [PATCH v1 02/17] ARM: dts: aspeed: minerva: change aliases for uart
Date: Wed, 26 Jun 2024 21:03:17 +0800
Message-Id: <20240626130332.929534-3-yangchen.openbmc@gmail.com>
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

Change and add aliases name for uart interface.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index e20e31917d6c..ca3e417d2c7e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -11,7 +11,8 @@ / {
 	compatible = "facebook,minerva-cmc", "aspeed,ast2600";
 
 	aliases {
-		serial5 = &uart5;
+		serial4 = &uart5;
+		serial5 = &uart6;
 		/*
 		 * PCA9548 (2-0077) provides 8 channels connecting to
 		 * 6 pcs of FCB (Fan Controller Board).
-- 
2.34.1


