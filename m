Return-Path: <linux-kernel+bounces-428041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39D9E095D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA18D1625EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661781DA62E;
	Mon,  2 Dec 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MhZ/Ckf3"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2D13C8E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158651; cv=none; b=ItDfa/Mre7842fkQYntKZabLctDrWTAgdnT7IYnKUU81aXHwL0FZ8h0rJ1ZUDOkGh5JM+qIijsg3IZkYmy7NC92WLPqMXZ9kiWhxSdbnAINcmq7LhUzOcbQrxiAMnu3zhMXTNr5OV/RetaIY9I8SWfOJFq8A7phsi2f60Pm2Lj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158651; c=relaxed/simple;
	bh=hZmHmXhaPxYapkmazSBTQYJSOtR6grcSKudIxSa5uys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTVwqv7draskgdHTHfnbZCwbjkDbvoQANghYSaHeUq0QJmUicE2tl1xBA0Pon7ObL/qyRfDR6S2iCB2LGxx43Khf0D0VmOq10c/0PMVbtGTV0vmGs97T7Eh7R8oPuzQZlj7nWLkmVl36UvnJ9rmgenTIezmgbPn6SaAI9Le1l0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MhZ/Ckf3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e06af753so1723956f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733158647; x=1733763447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItGaUx4mMjWP305q8FK6zTYZIbWY/yA/nNMSXXpCvDA=;
        b=MhZ/Ckf3wygfCFAb2aIoeL0RQQpcfH78/4o7b9xf7DEpAxOj0k9p58m7boAPz7lWcL
         QsnIsSwHqEeQgmrTm/3uxDGf7A7RF+dq7/kuS0ieHqnOMRizTVZV62QCf38BXTNm+LoP
         V3lmDO2oSkIhlQZlI4t+zHDY+62kj8KtUvI9p2ko4z8r2PVSt70PLcgPIKZhYQc9Dfww
         X0LJKkDn0LlV9Uusb4QrSEvy4pcq7L7gm/pZalGn3LsLJhmevFVq5/hEZhffBGNxRHG4
         Xets/dKUjNnqivUYxYbc7Ra5zUcjEl66KQZ/DJ0wta1lhSvZQUqkdXnXhlmmUhcl5NI6
         tdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158647; x=1733763447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItGaUx4mMjWP305q8FK6zTYZIbWY/yA/nNMSXXpCvDA=;
        b=LbZ6bvdVRTtR+wOaq+3P1OnS5Ywo3g5RSo07y+9P43jR99SeGi1f5h8Jx1mTqMoy5U
         wSdc3xK3DWNh3YJowR57CutL1aUZ942AN/Io9gCDcwbZCc9zzVmhuEmS7F0TU4ZAgqR6
         9G9s7r9qndws6/BGLzejTT0VzgwDOIuzLhTbkLle3YixuYLUDd6ZL8Yofj8S1FasfX0p
         zNpCKtC5uS29rR0daK8HqMUhx/xmii/qb0ckiXlbbVup8vIGFQ19S2QTSpYv9L1sRAQt
         3nXvzfc61ialjfofnVZCdqIO9Dn5JIEdhNcuJB0KqzdRMKf/HP8GTJGvJ+NFuC5Ejz5x
         5s2w==
X-Forwarded-Encrypted: i=1; AJvYcCUhfasQnJX33E6+6xJlK6p8+uH4FQzHMY/T2ig/qRT5RaWfg2BovJdFWjPJdUzJyfsxy/XSpEtLxgGGWTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL8nldD1kaS4vXKP96L56NTOnqhsbVzbsdh+PmnjYwtQRQvGg
	95Wc+gZi6+g+aBRUHjep8Oeh8MgM9Gxxigl6EWcOWq3DUGjNilXlSKyQIarsJmMbvdgJ/5VZ4/M
	x
X-Gm-Gg: ASbGncuGd1wMxjDnqFbpdYOBRoQvHja4CdE9dP9maRTU4dsUY+r4vXLTuUlZEV8eHI0
	JeWXy2CT2BINgxhtLU4L0YuR4R1jS3nPisY/Y472O4LehWWuGGH5gSHsepsxhn0ZBeQIuTzeFFp
	iCQw2N4UGc1aRiCygAjDMa/CyrWCvWgdb9ugXmWFFtv5QEdKEazp+YZewjZoQCGS4KtW2iKh/Ne
	N2F3/ovmkRCdZW15cxHmsG0py9mnUj8Fh0hu5sTvCfXYLezMV+w8xiOC5Qki+2vdmJS
X-Google-Smtp-Source: AGHT+IFkc0FoA8n/kEZkWOw5oBoZq+a4ojllKECjH/Lm6zucKJGPEHanSq+59uPtKp/9i2UQfGBW4w==
X-Received: by 2002:a05:6000:2d12:b0:385:e013:b852 with SMTP id ffacd0b85a97d-385e013b918mr9226081f8f.35.1733158647431;
        Mon, 02 Dec 2024 08:57:27 -0800 (PST)
Received: from brgl-uxlite.. (150.46.205.77.rev.sfr.net. [77.205.46.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df69feaasm10111106f8f.5.2024.12.02.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:57:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] interconnect: icc-clk: check return values of devm_kasprintf()
Date: Mon,  2 Dec 2024 17:57:23 +0100
Message-ID: <20241202165723.17292-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

devm_kasprintf() can fail and return NULL, add missing return value
checks.

Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/interconnect/icc-clk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index b956e4050f381..88f311c110207 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -116,6 +116,11 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
+		if (!node->name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		node->data = &qp->clocks[i];
 		icc_node_add(node, provider);
 		/* link to the next node, slave */
@@ -129,6 +134,11 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
+		if (!node->name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		/* no data for slave node */
 		icc_node_add(node, provider);
 		onecell->nodes[j++] = node;
-- 
2.45.2


