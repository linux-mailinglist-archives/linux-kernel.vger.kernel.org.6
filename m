Return-Path: <linux-kernel+bounces-436457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FC9E8616
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FC018854FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD741175D47;
	Sun,  8 Dec 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="x0Wk2VkA"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93D16DEBB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673173; cv=none; b=uhdfR/i9MK/sdsX6yMZyEA+ZMDY3z9FFrN1jmlWgs6YagKhcJEOnbgZRjIJHFWlRcyfdjLi/sUp3OicjE0dumsL2O/sbctu+JV3Yo9aHslOYVSX35i9BK+b2UfX1o2yK49j3kONQ4PMmnBfIXYtEc3wY+L07PqYxTrLARul7bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673173; c=relaxed/simple;
	bh=HyyWUkVImKTbnfUbDT8H94jFhoM3eDYkpcrXi4gTshE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5FqyDjrcFYTC1D1pVC07scsGvlz45JkRdLLrdhYFWPqxV2o/4siJoZCR5dE6h5SXvfpBnY1ShIbfaxG1H4d8KxYTYQ3f2K/xy1pFUbfGakEqHH3FshE4LR6wKZsa8z+v3aERHakZYD45Q9NDwvopZBzZPIijstCK4xxRirybKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=x0Wk2VkA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so78324e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673169; x=1734277969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJl98tLA1KqA94ObFzxMBXTp9IXq9js5q87hBKbnvrg=;
        b=x0Wk2VkAF0goOOK9oA5ZQyOFU7541kKbRDUhCxBiBiP13EQpMeUSKSrSqThZcm7wFG
         BWCNbrThqdrJDPbgzoBc9XjN9x7/eh2pNT/HErJPJNx6yoLK5EnADw/7DozfAyWyNPvE
         h8/3n5yfZ2TYGY2rVOnVDzttFCE8SYVwib1Kirq+v2558bEIRb0SEc43PKJNSjvLi8AJ
         tG8SCmRhCdSw0YgX9/0wII4vH9fCU6CAoHNQo3qvAby1iZiV+RMvFbhdq8FPnNicYaDw
         DsGrcwjOxml7PyNKBnJlLCxLf2FbuttzNP+gEB5Ix2zZUGdwaJeOwDHzDBss6BwuUDHT
         i7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673169; x=1734277969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJl98tLA1KqA94ObFzxMBXTp9IXq9js5q87hBKbnvrg=;
        b=YSW+h/TSI9nlgQt1MHB6R8zTK7YuyQYXjbqm6Cdg7PFfWSzgIpZv7KJK7yZNnx1yHq
         Tbil3cr/lmN1YrxS/jAHE4SoM4OFVmZSRI3qzg3RNKAwGAeuE61pTDitw+jrgdUEJeYY
         niLKez7dh/lgz7oxRYepnN+c4+8bODpAEskIXu+/jPC/h0o+qeFAC4Ll65olGiOtHxjL
         K56ky2oo1hC9xvh8sJiUZFf2HzyWwwWy5bEPsUCUWf/c8rkL3j0kF8q+gFM5d7iddQmh
         wfztLO7j0f/6koLyH7w/NeFMBQFKTsO+3PotYfYWHrpH4q+n8iBu2jRwFZcWeYSd+7ed
         8lqg==
X-Forwarded-Encrypted: i=1; AJvYcCX13DA8Tg5ogfiP/wSLRFKFtU97Tfri/7ZNCmrQzo6wbhJjA5Z9eZQNdce+buUD76I37lPk3xfaSEhZJYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eI7WTepYtNhsJ3vuHdJIEoMeHm5K62GewZ9abV6zd1QxiUAW
	tOOjU/z8QXQv7Mf60oZaxpcZCkxZDc+7aC+aH511Wrlop3xn4jUEGLg3y4uWovU=
X-Gm-Gg: ASbGncvIOKH0jCw2JyLHMt3HMmoJaBwt6wcy1h+G+krlrQwjg27Hg0iJvp6kBCUuKge
	722lKNFYzD4+YQU+39Vpwak3QJO0ORpI/HAOv3yzYkMpZnIVLaYLCF4ElPicEvM38nWJeQ9Y7Us
	0cHaTR1oqIuB2BBZQ2+fr3gzzv0YieKgl1bkX0gAkc/87UmUMWs9QdS5jHa/og3neiz7bdTTCYC
	hWy+tRuyDMfEE2fzU8HR23zwXIoz9ftDcXog2UCytbkF7V284EroLKyFW61vpxd
X-Google-Smtp-Source: AGHT+IH3PSTZTHavCvoa1I3kEsvmuL+iD0caZGd6QozHV+KkfcwNGoYPhdqy84lNEnLmvIZv5Ekjcg==
X-Received: by 2002:a05:6512:6d2:b0:53e:16eb:d845 with SMTP id 2adb3069b0e04-53e2b7328d9mr3358489e87.18.1733673169476;
        Sun, 08 Dec 2024 07:52:49 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:49 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 4/4] net: renesas: rswitch: add mdio C22 support
Date: Sun,  8 Dec 2024 20:52:36 +0500
Message-Id: <20241208155236.108582-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic MPSM operation added by the previous patch can be used both
for C45 and C22.

Add handlers for C22 operations.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 8dc5ddfee01d..444e7576b31c 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1225,6 +1225,23 @@ static int rswitch_etha_mii_write_c45(struct mii_bus *bus, int addr, int devad,
 				    MPSM_POP_WRITE, val);
 }
 
+static int rswitch_etha_mii_read_c22(struct mii_bus *bus, int phyad, int regad)
+{
+	struct rswitch_etha *etha = bus->priv;
+
+	return rswitch_etha_mpsm_op(etha, true, MPSM_MMF_C22, phyad, regad,
+				    MPSM_POP_READ_C22, 0);
+}
+
+static int rswitch_etha_mii_write_c22(struct mii_bus *bus, int phyad,
+				      int regad, u16 val)
+{
+	struct rswitch_etha *etha = bus->priv;
+
+	return rswitch_etha_mpsm_op(etha, false, MPSM_MMF_C22, phyad, regad,
+				    MPSM_POP_WRITE, val);
+}
+
 /* Call of_node_put(port) after done */
 static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 {
@@ -1307,6 +1324,8 @@ static int rswitch_mii_register(struct rswitch_device *rdev)
 	mii_bus->priv = rdev->etha;
 	mii_bus->read_c45 = rswitch_etha_mii_read_c45;
 	mii_bus->write_c45 = rswitch_etha_mii_write_c45;
+	mii_bus->read = rswitch_etha_mii_read_c22;
+	mii_bus->write = rswitch_etha_mii_write_c22;
 	mii_bus->parent = &rdev->priv->pdev->dev;
 
 	mdio_np = of_get_child_by_name(rdev->np_port, "mdio");
-- 
2.39.5


