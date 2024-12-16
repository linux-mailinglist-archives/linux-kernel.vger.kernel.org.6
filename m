Return-Path: <linux-kernel+bounces-446912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE19F2ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A731889601
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D181D5AD3;
	Mon, 16 Dec 2024 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="lp2QMC9C"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A11D54E2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333622; cv=none; b=c/GpoXpxF1pokGc43hEMx65EdRcbn4ZbrgQMJ8o8fq0e4tuQxVreDvHEWebafRjFRVBwNY8oCHvzmHJH9ict7znr2JbsfVUp8IOGrJjJOF6S49RfJc/B5dPyBprCLB30Qm8GXO+djAzOCDvU/u0iExJ4sVnE0weNQcGdhXejcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333622; c=relaxed/simple;
	bh=PPu77jqSXBAgupPgYnoSOAHUAmL6TvEmfGQvFsLGMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzG4JafMBHl1B6IHQIpyBvPqGdkZsiDrWD10ckK87g9XepAs8qtjAMlDDguPTC0gpR8xcRJqsZQlQooNDDOzSYhVDBAdM+Uw4W6r3zm2oJ6nDDxecVbGOLkvNWkciYJIcarthpL8qZT+U8rgWBI7ZQkTYPvfZHumCqAI3Q/lCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=lp2QMC9C; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df80eeeedso3773925e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333619; x=1734938419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bRm8i06V7UAQJx4SsgcbkPUCzwQb13lEnvW91v/XN8=;
        b=lp2QMC9CI3ikyuAy2Tt9MtnsgHTh/Weq/TNHrCzoGhFjpSqj4i8hVoFa/H4ntMR3zd
         AG/vIuyn2m4gJyTClbQnI480tmeJt4eOsthR0NBvtXbBYSALivYD/k3wk1iH28mRcmv1
         58AZAMhi1F1qBENhYGKpkveJZYs/1KOwDyCAp1CuTff/TH/+Jt3HY4nCYJcebVH2V4AK
         99anuJvKzysRb7SK6WXSxlIaGRfnH2fl85X1lFdSi/M+MzMoqovJmfSWhaeBlStPuXMj
         V+JUzYSqRbwbHLMe65qZb4zYO9vpvynX7r3AYZKm0mNNr/vh7A7nxMcC0mM36mh4BKav
         DpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333619; x=1734938419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bRm8i06V7UAQJx4SsgcbkPUCzwQb13lEnvW91v/XN8=;
        b=cMXixF3z2svWkiWADH0cQdUrdmXGlPGF5TPD5Pxk5ZeIEB4ChWnWqIr2qhu6Mtwshh
         QzK4oKy0ntx1Li3ONP/cwReyrdscCsQcX0uVclvEbTgc7CUr0NXMQhGclbOnk+ZFpBpy
         aXP6I/f/sEgwXWDm7qEIy9DL4d1a7ICjIXq0ymnvvj/gUAz+r7dXVGUmNm3BVNblRRi/
         yxLcOfYcYpL8MfYTq2rVE3n/os3lv1JVI1rEWs4M6FhR/NNvjHY/FRnND5kY/yfxN42P
         FW5hptAnvNZ4o3A4fVV/TuD4yLVYPreONUa8NJY6t3po9emTdLHKt4L3j3xwGQTITXCc
         8Ugg==
X-Forwarded-Encrypted: i=1; AJvYcCWxtFrjs58uHLnEFhzDrlyKAZfQuc1N3+MFj1MV82SKRLENT7fFmOTNVFwXLxYVZm2lE6gi+evgz0O1sy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtcWtSA/ay4NnCy85sK0gT6vI3hbLkOLLVqJwraR6UG8l6pw6
	u5zzqQLQltiWCafLgBRY3mdseJ2iRT/bE/tp9fYw1StSdnf0O97Zl8XxT07rwmA=
X-Gm-Gg: ASbGncvki2CyBrfAb3a7BR2loQkDq4EzHmXZ+h3EMPX5pHwo1BqsWPmKAPkrsnKDhDu
	HOsLUcz/Iks8JRvAuw9DslSl6PUdGKIuSd3CIyUzGoq9bhj74JFQ7Hwm58SoVomnSRpIQxstSS1
	QaUUBG+Dx4PBaakl2y1fpgs7VghG2JtRPCPTWufDCYq44GssXKm3qAxhkVKfRocGSkzZjvRQGFq
	tzeKfYQionU9i3er1aAfNnMTcvnoxEpn7hvspKkIDCHYpPX6w+ugPKAUdn1reVmdipCNKY=
X-Google-Smtp-Source: AGHT+IFowAXgGjOedfuT8nJJtjG23yp3KyVX22HWiWvy1vf9kaEvbhBVhV1xHsfmSOlU8xeDwiDt1Q==
X-Received: by 2002:a05:6512:401b:b0:540:c349:a81b with SMTP id 2adb3069b0e04-540c349a962mr3449085e87.48.1734333619267;
        Sun, 15 Dec 2024 23:20:19 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:19 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 5/5] net: renesas: rswitch: add mdio C22 support
Date: Mon, 16 Dec 2024 12:19:57 +0500
Message-Id: <20241216071957.2587354-6-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
References: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
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
index a3ba2a91c0ab..aae26098bc0c 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1253,6 +1253,23 @@ static int rswitch_etha_mii_write_c45(struct mii_bus *bus, int addr, int devad,
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
@@ -1335,6 +1352,8 @@ static int rswitch_mii_register(struct rswitch_device *rdev)
 	mii_bus->priv = rdev->etha;
 	mii_bus->read_c45 = rswitch_etha_mii_read_c45;
 	mii_bus->write_c45 = rswitch_etha_mii_write_c45;
+	mii_bus->read = rswitch_etha_mii_read_c22;
+	mii_bus->write = rswitch_etha_mii_write_c22;
 	mii_bus->parent = &rdev->priv->pdev->dev;
 
 	mdio_np = of_get_child_by_name(rdev->np_port, "mdio");
-- 
2.39.5


