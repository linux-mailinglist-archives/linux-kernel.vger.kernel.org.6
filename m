Return-Path: <linux-kernel+bounces-353219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C8992A92
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E3EB21111
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E46D1C9B77;
	Mon,  7 Oct 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3HRROZGG"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD818A6AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301560; cv=none; b=U859MksSZIlHhuixvfkRr0OP+8i7Ki0tkaGdgVKnBjWB3E2B7NN0cFF/V3QDD/gtmuXidszsjpH5IRIrc5xJ4e2utcMFyh3neN1UaDCd63c8DCUJ2Qb0yszyeXEjWTo1GdGzZggo7Qkusi22kLqzvejCYYqWNET59qIcIZHfqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301560; c=relaxed/simple;
	bh=jESfmue0np+sznfxFUnf226R9lUQNlDJcp5q8IXgN54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPm6cYstzoDMMy9WCsHke6X2H85HgqotUZ8RzhadCr3UXxeE44p+NVvv75EaHV4BUJdjnN1/PxI740jb6q0+/iwG3RNoWiGhpvqmOdqAsHr13N8gSCRAtZgyBPgNF1Kl1O2r+bwQYj1u5kM2KlGLhT98ejVPiAbckogE06oVva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3HRROZGG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cc60c9838so2416749f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728301555; x=1728906355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnfRZrs5rd9jTocE6z1mGyd4iAKiwxMzAQadUPnEw/M=;
        b=3HRROZGGyl9oqHtYebGZ1OK7hDlsCYz+YCJWiMD3KAoxaBFdRpA4IxCvnCJmxIjPwN
         UGWXtufAHVj4u6hGSlN4agpgX2QC1SfXN1B0gR3b6Z6Cj6RMUr2Hbe8mVEZM10A5DMZX
         7JOqQG2NPaRRFpFHX0Xnqs2H0FS2QwDE2OV2PpEBD1vJOG3OacEXZ+cKP8QaDZs3okvm
         y1aouZqH42EDdBzstF4aPIKeKQqxHnKbjpufJfVPK1z6JAZjkrG+RIhgaWvPGBFHKY61
         8dj/tyR+baalJ60XwjyyoCsFT9f9OKlHGuQcdlbrXLZWpSZ71KDcVkHsfrnH0I8mRxaP
         GLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301555; x=1728906355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnfRZrs5rd9jTocE6z1mGyd4iAKiwxMzAQadUPnEw/M=;
        b=psHM+vmaMxfY2wKG/lWrl13DOVbTAl1ALJQh9oRwwqisnjhaqrtC0rQurq1zabr/mq
         I7ZZm2rX8TovjufBJubA7sv6xPqZLBjOLDXiIroer29dwp2GhcQlPpeUJARExlevbwTD
         uPJ+k8shZmbNmC8xQ9Fr0pnIf1ng70ZPgGTIU9z247rdycFFb67PY6KoxBFSzViiM7ZG
         O+CfGRvtyMiIl7fynhCRi4IaC5N8RdZayTHUrpeUdwNj1DmsJ8AKhScvf4oUP7nqx+gN
         x7ssjiDoJgE++o47h/X4uFB7N/FZW7jkYfG3OmZV2h6y9XXLHTmuR6coO21me6L98z2Y
         TVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH8GPKu6UyPWYXDyBLCP/ukG09Tn5D3jRfdG0CiJgvJYPVBMQaGWcaKoRdII5PX1QswbS3FvwnS5esdNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1myjNvg9VeDufz2hHdNrYhB11GPqUVmt6Mc/B94E9kFLBIaH
	4J42WtM3tQPIBamdQTQyvycoH4p8Or/VywHq7HrcjB7Yi96EC83BQPUmA+GdkdI=
X-Google-Smtp-Source: AGHT+IHv2HDJzBlWcJX+EM1VUKdDajOjn74SvjnVr6X2+w9ayFZJ8r4VM0n4+22m48JJDuduijUscg==
X-Received: by 2002:adf:ce05:0:b0:374:c1d7:4ef9 with SMTP id ffacd0b85a97d-37d0f70c86cmr5784457f8f.26.1728301555040;
        Mon, 07 Oct 2024 04:45:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d169734a8sm5562454f8f.101.2024.10.07.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:45:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] mmc: mmc_spi: fix snprintf() output buffer size
Date: Mon,  7 Oct 2024 13:45:49 +0200
Message-ID: <20241007114549.51213-1-brgl@bgdev.pl>
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

Increase the size of the target buffer.

Fixes: 15a0580ced08 ("mmc_spi host driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 8fee7052f2ef..fa1d1a1b3142 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -222,7 +222,7 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	u8 	leftover = 0;
 	unsigned short rotator;
 	int 	i;
-	char	tag[32];
+	char	tag[43];
 
 	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
 		cmd->opcode, maptype(cmd));
-- 
2.43.0


