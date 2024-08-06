Return-Path: <linux-kernel+bounces-276397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F00949310
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0421F2549F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C41BB68F;
	Tue,  6 Aug 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiZSssAN"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B418D658;
	Tue,  6 Aug 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954548; cv=none; b=ZIr0jGoikFbeMtyKkpUzlCTaXETZarOkMT/xcNKG/Dy79gj92ADQO3DYBegrTn9IjhYnhyWepEhhQBsFUfny8qADBhGprR6yyqu1TNRM57VMMxfqsZG54vx4Mzi+RZ9wYJIwtpzK2c54Wk+B2xgpICq+sDHJ9S6G7fCkrGBXkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954548; c=relaxed/simple;
	bh=+Hia14jXePbx+EZ0PdeS3yPRkGoG79HqfWL28ZGjSZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gS0qkSCzWAnSearT9hxcypx1qAtoVACuYMiybsSs0MorBwaDvAKHamI87MURq0KdIjP61r5ZUwT/WVvSblrgAJo7IITK28H3MInDvCAB/DjKs6Ue7PAettBN8Xe/29C9L1UbKRO6miYCqHN320lQGraGoNeuOC9E9rlxfWBytgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiZSssAN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368526b1333so4059254f8f.1;
        Tue, 06 Aug 2024 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954545; x=1723559345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llNvaKfNW8kRYvcLVyz6JzJVLP63vxvP6L9kO0DUS6k=;
        b=jiZSssANubddrwD+fnHOTk4a6XELimWyHSqEjjA/eOBm/F6yiF5sq9GJSaCFtNvgdm
         tYdni4/lx93eBdZqDKoJW4Hs9Ul37baZjPNLv3nekcNoR/6qMGfab5O+sln0lLU3QMDO
         7THv+fQ4Czr9QMPxOGD9BNRiVpTBm8/07PqyNvEyePr6BqboSiCfNyODv8UHMS5azyeY
         ngZ7mMhN4R6hsB25dDK+1rcLJ3kfDta2Gek5Z7pDbRFH1T0aV/sDt/8L7LQcVeBkq/YQ
         jtdMTuWtPGXPfZNEI/nPZmSAwguxkckZz/TF7dl/lHklj43ZomlhP1NWXphCdV1gTNH8
         UYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954545; x=1723559345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llNvaKfNW8kRYvcLVyz6JzJVLP63vxvP6L9kO0DUS6k=;
        b=SwJFBWjJ8oSGS9zDhVTBm5+Rycnxe/4l66DRw/Vi6VbHV6PWjjuhgWu9uK+My9K3Zr
         I8pvso9gqBRM75v62PUvlkOUJtLZBFXf6mQ0v7EbsXxZj8+681jrLtKWQs9iie17PsoO
         SpbzDPWECqWmlzzzPWHs8WAcRlN3+9VtvKG4ti+3cMwYiZUeeWeOPlJsB32n69ucSIuu
         mQGzOCw3oYOzCCiO5wyhnJ5/+9jTaRMVSlHIyfyUA9QvBJYJMPYRiDxETDxR9ZXRUTnn
         rxnmOEgbtNA7LODX/rPQnlLWHbvccBA1EKwYo9cUCdabE/YObCl98F4SnaQ/Z37/Kf/+
         mGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrBGE4F5ALMjz+5b8LdhoYzK3NCu8POmvQRta9zZ+rTViro1iIyYhbvXrenHQfzpwxSX2t72zqK281LwPSaqJ+9+wATU19pn6tqm7Z
X-Gm-Message-State: AOJu0Yz/H1UIEO88GGTuCZs/hG0r+D0/0Ths53sRsoL1+HceEw73lXym
	9VvGpKZljxkwqnoC4Q7RigR7e0ThkdKVmXiNf4tECMHuiqqjbTCNKKG4Zg==
X-Google-Smtp-Source: AGHT+IH0y55ybyEW17euw2OmuZdVdziMjdxhMUolvzWG4oQEqSk93Gz3zBq2u4FRz8277LqDaEucCA==
X-Received: by 2002:a5d:674e:0:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-36bbbf138a2mr8235025f8f.35.1722954544637;
        Tue, 06 Aug 2024 07:29:04 -0700 (PDT)
Received: from localhost.localdomain (201.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc8esm13072531f8f.19.2024.08.06.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:29:03 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-clk@vger.kernel.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	tsbogend@alpha.franken.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
Date: Tue,  6 Aug 2024 16:29:02 +0200
Message-Id: <20240806142902.224164-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clock plan for Ralink SoC RT3883 needs an extra 'periph' clock to properly
set some peripherals that has this clock as their parent. When this driver
was mainlined we could not find any active users of this SoC so we cannot
perform any real tests for it. Now, one user of a Belkin f9k1109 version 1
device which uses this SoC appear and reported some issues in openWRT:
- https://github.com/openwrt/openwrt/issues/16054
The peripherals that are wrong are 'uart', 'i2c', 'i2s' and 'uartlite' which
has a not defined 'periph' clock as parent. Hence, introduce it to have a
properly working clock plan for this SoC.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mtmips.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 50a443bf79ec..787ff3e66b34 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
 	CLK_FIXED("xtal", NULL, 40000000)
 };
 
+static struct mtmips_clk_fixed rt3383_fixed_clocks[] = {
+	CLK_FIXED("xtal", NULL, 40000000),
+	CLK_FIXED("periph", "xtal", 40000000)
+};
+
 static struct mtmips_clk_fixed rt3352_fixed_clocks[] = {
 	CLK_FIXED("periph", "xtal", 40000000)
 };
@@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data = {
 static const struct mtmips_clk_data rt3883_clk_data = {
 	.clk_base = rt3883_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt3883_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = rt3383_fixed_clocks,
+	.num_clk_fixed = ARRAY_SIZE(rt3383_fixed_clocks),
 	.clk_factor = NULL,
 	.num_clk_factor = 0,
 	.clk_periph = rt5350_pherip_clks,
-- 
2.25.1


