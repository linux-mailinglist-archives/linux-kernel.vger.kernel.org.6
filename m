Return-Path: <linux-kernel+bounces-429683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2DB9E289C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99454B83123
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964E1F7548;
	Tue,  3 Dec 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="FBw04yPx"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30613B5B6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237143; cv=none; b=brVrBp9zi0onR40J8Uk9AcfY1K/Jvwomesw2tCXwS7TMUH6/bpOTT/rTkB5IVXAt8+cuF54qAox0Sny12rXyvpWRErqabq/k5m3sdG52mY4d/ANOtcG1H0Pu6qyY2Uz2ybARL+UjqVZFX91lNIwTwqpW8USTn8e4cPJoGQccFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237143; c=relaxed/simple;
	bh=8dZAcCybSyyCbITBqYJytc/CotfK54Ox4Lm254vkMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HT2CsQ8pxK6ezJHWOKD60q5bMiUadzqsRkPx5C/+z1lwDIqvF7TwYTvfucK6yOUOUfhaqc5cGFuEMOiaU7qZi5VaMhFi5YJCpp+NWRG9/GEDFvcnGYen1MqRiAmo15+z1Jhnl9KAi5U2d4nLn2FEcpLGfFfkM3VUt1ymz37gsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=FBw04yPx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e06af753so2354844f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1733237138; x=1733841938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYUAWSDIdbphZ5G3pOF/T6c6CGV5MMb69iUkbh1uoXk=;
        b=FBw04yPxapayMEI/Hfp92iF64lphRv30tzwssBm46+MOSJCjFa88BvlfYZ5EW8lGPl
         mBxRvYkDgcqIvYHrUqhnD7fuHKO/pCfkSmmAxz+sgszBH1dF5dlSrVX20rF/daYnPWS2
         LtYuR0drXI7HBXwUntbPCKaKSp5ZZrfLJdcFoTm2Q2QhTS5jtz2uhkD6gY5kJkjz2ek0
         JfQckACfFNMzvtOtY+jwZwPjpXIXvFs3slBWDKZ1mz8Nbc69oD1DZZopOpqaplqkHJT1
         VDMvM3nK9CQG8E6Rdz87QLPIEw+6BIKq40zDLgu5goHOk1Cxt+evVhiMYPQWW3jBlsIJ
         vNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237138; x=1733841938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYUAWSDIdbphZ5G3pOF/T6c6CGV5MMb69iUkbh1uoXk=;
        b=inD7z/IuAyy7REnf5VN0/IayCEGFEdyMbqPKbszj7TOvpxSRoj73fhwXciqUS/2zNd
         X5vAm9BmDKvP+vJABMrABmzALSxlmx+eqCfMc6UbJxTduX9UjWDL3gaRZCjp4iJDZB2V
         js6yOsMeyCSCFzKJ2Qs/7lmtwSEsV8KJuuHNBhLXE/DNmJWteiSxl6BynF4maSaJT4OP
         Oyf6UQeJsq2WObQ7bOkInDRJIL0oTtrvtiHl7ZArFpNsaiHni7NG4ZHBcCc7n7wHmagD
         nlczfnDW+UjnwvSxJL4sJ0IHAwvvu01FKgpngfPb0mbGfyVqJtFydgCE4pb9hHw7xbUJ
         pCKw==
X-Forwarded-Encrypted: i=1; AJvYcCW2HK9vN/oDSj+aRpIg4NWuPY5eUhzKFIKeb/0/Z7JmWoDQyR9XHtHF/2POndPw+Sd8PF3QMXHV/xzEX+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbotFxdfpN92a2JA+m/bVkdkozPcu015+U2jLhlX3i4xjRi4t
	l9DPGKrLI2ZgsiaI17q/3Y+7a1K4lJeXL8MAs8foWqfoZXyu7MJtNp+aurl4tjzwl2ZeRljh39R
	7z9g=
X-Gm-Gg: ASbGncuwNvZhDPNETRokw6uTMPsYQkXjJ4Bp/wdHKvcRcJB55H1Vr6e0S2j9qEFQI0j
	r7SXgnBDUJYbdNHJVt7ARsuIR2lIt7hJJL8K/YXd274y1wv9tvpWKG5llznOZvXpZj95yDTvKcX
	Bi/tyFI4sv9xO5qWx7OwcXpKLRGblJTCd7xbCfTU0Sg8yRzjtOrgVvY2A1roubw33BSW7AXwSFL
	1ZIHG84sqad5M8nZHyEtIH9pWCULgZnJORxxGRe+dASodt0DyYi2/jwpC9QGE03Z547nk3VWnwM
	KPwKhFcbkbVQyg==
X-Google-Smtp-Source: AGHT+IExdHHjexiWRYW0A3yzO/aU99shhOBSmwRHUoZR7Gb39P6gg6MqzgLWtBfZZGTqXTUyZjZmMg==
X-Received: by 2002:a05:6000:4802:b0:385:e961:6589 with SMTP id ffacd0b85a97d-385fd3cd5f2mr2621165f8f.20.1733237138384;
        Tue, 03 Dec 2024 06:45:38 -0800 (PST)
Received: from localtoast.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm3180818f8f.20.2024.12.03.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:45:38 -0800 (PST)
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: Julian.FRIEDRICH@frequentis.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	upstream+netdev@sigma-star.at,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy
Date: Tue,  3 Dec 2024 15:43:40 +0100
Message-ID: <20241203144448.30880-1-david.oberhollenzer@sigma-star.at>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mv88e6xxx has an internal PPU that polls PHY state. If we want to
access the internal PHYs, we need to disable it. Because enable/disable
of the PPU is a slow operation, a 10ms timer is used to re-enable it,
canceled with every access, so bulk operations effectively only disable
it once and re-enable it some 10ms after the last access.

If a PHY is accessed and then the mv88e6xxx module is removed before
the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.

This especially affects probing during bootup. The MDIO bus and PHY
registration may succeed, but registration with the DSA framework
may fail later on (e.g. because the CPU port depends on another,
very slow device that isn't done probing yet, returning -EPROBE_DEFER).
In this case, probe() fails, but the MDIO subsystem may already have
accessed the MIDO bus or PHYs, arming timer.

This is fixed as follows:
 - If probe fails after mv88e6xxx_phy_init(), make sure we also call
   mv88e6xxx_phy_destroy() before returning
 - In mv88e6xxx_phy_destroy(), grab the ppu_mutex to make sure the work
   function either has already exited, or (should it run) cannot do
   anything, fails to grab the mutex and returns.
 - In addition to destroying the timer, also destroy the work item, in
   case the timer has already fired.
 - Do all of this synchronously, to make sure timer & work item are
   destroyed and none of the callbacks are running.

Fixes: 2e5f032095ff ("dsa: add support for the Marvell 88E6131 switch chip")
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
FWIW, this is a forward port of a patch I'm using on v6.6.

Thanks,

David
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 +++++---
 drivers/net/dsa/mv88e6xxx/phy.c  | 3 +++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 284270a4ade1..c2af69bed660 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7264,13 +7264,13 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	err = mv88e6xxx_switch_reset(chip);
 	mv88e6xxx_reg_unlock(chip);
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (np) {
 		chip->irq = of_irq_get(np, 0);
 		if (chip->irq == -EPROBE_DEFER) {
 			err = chip->irq;
-			goto out;
+			goto out_phy;
 		}
 	}
 
@@ -7289,7 +7289,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err)
-		goto out;
+		goto out_phy;
 
 	if (chip->info->g2_irqs > 0) {
 		err = mv88e6xxx_g2_irq_setup(chip);
@@ -7323,6 +7323,8 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		mv88e6xxx_g1_irq_free(chip);
 	else
 		mv88e6xxx_irq_poll_free(chip);
+out_phy:
+	mv88e6xxx_phy_destroy(chip);
 out:
 	if (pdata)
 		dev_put(pdata->netdev);
diff --git a/drivers/net/dsa/mv88e6xxx/phy.c b/drivers/net/dsa/mv88e6xxx/phy.c
index 8bb88b3d900d..ee9e5d7e5277 100644
--- a/drivers/net/dsa/mv88e6xxx/phy.c
+++ b/drivers/net/dsa/mv88e6xxx/phy.c
@@ -229,7 +229,10 @@ static void mv88e6xxx_phy_ppu_state_init(struct mv88e6xxx_chip *chip)
 
 static void mv88e6xxx_phy_ppu_state_destroy(struct mv88e6xxx_chip *chip)
 {
+	mutex_lock(&chip->ppu_mutex);
 	del_timer_sync(&chip->ppu_timer);
+	cancel_work_sync(&chip->ppu_work);
+	mutex_unlock(&chip->ppu_mutex);
 }
 
 int mv88e6185_phy_ppu_read(struct mv88e6xxx_chip *chip, struct mii_bus *bus,
-- 
2.47.0


