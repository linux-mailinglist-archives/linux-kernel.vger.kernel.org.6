Return-Path: <linux-kernel+bounces-355552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B239953F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A528433F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB361DF241;
	Tue,  8 Oct 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dXeDqQxn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD0224F0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403308; cv=none; b=bIprHeVUCbcpmvBEBxuUL3PS6HXu07lnipe3auvXfqJ665nbROesDSxRen1dVPIR2XqdsrfbmI2hSRVbR8fiyqkbVBZ+iGTeWOLZKCs2bF7wGZfnA51X/FebeM3qgKBxMPZlkPA0s9pHcaNc6oOBTjIqfvnS/OZ5/c4NDfFVwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403308; c=relaxed/simple;
	bh=6pU47CiYN3EVOmy5b96h41Z0vXSiMpnhxRrzNk/tQ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyHMXmbl/kp3muNMJmPJrYgYfhGWN+nCYRzO2cGsa54+5aGSCfqfhuAjv3kcdNGcEIwbgdzyrhprRHHpNnzIKpb8jvnRiyW6ZDd2fGu+4/QPF9YGaSZ32EQnDV/Lnp2tSQkX8msJlF8um80hLiq8F/3esepkTiNb8EorMgYi1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dXeDqQxn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso59935665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728403304; x=1729008104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3s9oSg9hyHcMfQiy/pbWage+koXe/JdbFI9wGPznvgw=;
        b=dXeDqQxn2QebsC6wTlQuw3xOGIkGn23CwlrnRGA6puAk7ZUPbzHRZSIYQ/OlFFsvw5
         9Eoi2W01jmRGYd/pYygUaX7JlhfIPv8RYADYGw4SZt8FiOEMICzwJpOhyd5nrn0yJaTo
         5mP0suw2lvpY1ASCKFfi/nPHQZiL0bT1nmfo4ksQtazGJZ/05r+SAM+kspWgmt/+4ENX
         8GQoHIzzwbcrW0J1AKEhAWw4LlHNqNDn3zSaniAJNfBXjve7ZZax/+VySqZl1GF3ABN1
         +0b5iiQk+A0KfqOrJMj4JHwplrWdwr4UyJ2U/scNPOPR2pJDYRT9LdC3vmoYLvWiOVhi
         /BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403304; x=1729008104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s9oSg9hyHcMfQiy/pbWage+koXe/JdbFI9wGPznvgw=;
        b=neyU19LYAB/Jx6z5WpQV8v7VzQofZ7me6hcb4s5AX/RMdSSverEESRo/fMpNLO5tPO
         UgpCc/RLpCWqEBxrCQAIVda46IejtXOh12VZaNwXMgZhX/jE2wYKzLmQ/x4/mmuWegxa
         ox+8T1VQ2Uk/4PJ8KpEXaOWHALe71CH/UShRJ3lKf+aL9JU2V4A/G8UePzwe+hKS4qCG
         d151RSlYWG8YDc8xLUYwA+jAxnkgUElaDWnZsvnc8OMItVuug8zuX3z+89lwPLOp9nMy
         g5d6PyNloe1KnHrklNB5q7IhtAlylbOF8m1oAf+X389JruTmxW9x3AHYnClw22RypA+8
         q+ig==
X-Forwarded-Encrypted: i=1; AJvYcCWh+wLGHStVxhGgygralD5i44lGk7WLRmehr+gUu7UGKY6kpWc4cSm2twSrmizh1X66xc2h8c3c95O9f4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4Zc6d0nfXDIX6ZcFQL8N6KpBSA7UhapsDDNlfK4iK2Z6ElGx
	u8syHqybymWRBgWMFRO1RaAOROhoRjQpZl8bQzu47Beet3KMon472pskyG3L9/o=
X-Google-Smtp-Source: AGHT+IG6aCaOYevj0NkS1PQr8iOt3XMxnjEGZOxnPI+9ILlWXqvGiIUJFoA2Fzjb647XEx/VNkPmEQ==
X-Received: by 2002:a5d:6b91:0:b0:378:a935:482 with SMTP id ffacd0b85a97d-37d0eaf7adbmr9041255f8f.58.1728403303931;
        Tue, 08 Oct 2024 09:01:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4d8sm8389125f8f.36.2024.10.08.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:01:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] mmc: mmc_spi: drop buggy snprintf()
Date: Tue,  8 Oct 2024 18:01:34 +0200
Message-ID: <20241008160134.69934-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GCC 13 complains about the truncated output of snprintf():

drivers/mmc/host/mmc_spi.c: In function ‘mmc_spi_response_get’:
drivers/mmc/host/mmc_spi.c:227:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
      |                                                                ^
drivers/mmc/host/mmc_spi.c:227:9: note: ‘snprintf’ output between 26 and 43 bytes into a destination of size 32
  227 |         snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  228 |                 cmd->opcode, maptype(cmd));

Drop it and fold the string it generates into the only place where it's
emitted - the dev_dbg() call at the end of the function.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
- instead of fixing the buffer size, just drop the snprintf() call
  altogether

 drivers/mmc/host/mmc_spi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 8fee7052f2ef..47443fb5eb33 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -222,10 +222,6 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	u8 	leftover = 0;
 	unsigned short rotator;
 	int 	i;
-	char	tag[32];
-
-	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
-		cmd->opcode, maptype(cmd));
 
 	/* Except for data block reads, the whole response will already
 	 * be stored in the scratch buffer.  It's somewhere after the
@@ -378,8 +374,9 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	}
 
 	if (value < 0)
-		dev_dbg(&host->spi->dev, "%s: resp %04x %08x\n",
-			tag, cmd->resp[0], cmd->resp[1]);
+		dev_dbg(&host->spi->dev,
+			"  ... CMD%d response SPI_%s: resp %04x %08x\n",
+			cmd->opcode, maptype(cmd), cmd->resp[0], cmd->resp[1]);
 
 	/* disable chipselect on errors and some success cases */
 	if (value >= 0 && cs_on)
-- 
2.43.0


