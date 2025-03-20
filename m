Return-Path: <linux-kernel+bounces-569816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB7A6A7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD9B984040
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE66224234;
	Thu, 20 Mar 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiTQvwwU"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA522253F6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479260; cv=none; b=frQ13eufH8p7iHb2s4WAHYZ3i2SChTUE9PCR2NQ+vPnkjX0bpV8bBGCJXYfvBKe1qNUB4zfzvcJCXze+0Cf2D4L/31o0ryT6RxW6g80BWx5gjhO9xImUwLL9ai8E+wLxouKq1y/sfTv3FPL0TOu9EBI4FvxKrQZHHDwqsOkwJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479260; c=relaxed/simple;
	bh=5q7KCE9db7ERhm5lr7U4Yg37JmaxdnTD/f+2sXkyzxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZmVfsbfQ0ewgFwEiS2RLwZtcp2VyCnL/foSN81pr6qPqKOCT9zRzBmrwM4byV+wj2sn3YE/vm+2yeA1LIpuhnt4WZ1P5uRIb6m2VgJdDBscO1x0IA6NrVuMtmltWvhPBeWZo5NS9JSSZTXgk8hQB7F5aDzgJWXjaO2poyHGOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiTQvwwU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so976377e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479256; x=1743084056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXE9dlseC0dhD7d4oX2r9ZUURR/ikgG5O0SCUhzKJLQ=;
        b=xiTQvwwUQMwy2rT+pjfqAWF6BwGiO35f3I4+17xJhhQRNv9pdDy/0/tTguJ2Cpd0c8
         CJ+SBoG56JHPylJmxEX6nXspuwd98YAs2wzXaGSVeuJQ5BVSrymVnYYvVJpbPe0D+IKf
         0lWWwnz0i8IlN5C9Z0umiA5mTxsmr8J0DBphm4fMb43o+DIxFlWp8gG5HbC2ulxzlUdq
         wmAjL5V2BWkJ66WfXdc4H2NSxvyVU+mZLYU68j8kREDg+uUKrGCizsy1JUupUnp+IyId
         qUh5OKBXbA/o0t8XoUKyggFwTtDi4sFzoTm7F+6NgQ+3TCy2Yv3gFT7x+X+djZ1JhIKH
         uA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479256; x=1743084056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXE9dlseC0dhD7d4oX2r9ZUURR/ikgG5O0SCUhzKJLQ=;
        b=F4/CBMpO71iX0EisbNMfKxHC6B6eIwk/lMXIiYQwAzNDdTG+4zF+jXKBVYIPkMQQOW
         AY/yTM/q68fXCcxG/dBuuKfh5OphjpCmWoaD11DagWEyGs2FiizkkCInuH395BsHbSM4
         j1JM/K+xp6RrI/SpQBR/M6SVogFMCZ7ggjzvWp9e3v2Ysl1d15tGJO3NMpLPliNjOWTj
         HDaZ/FIUsOmDid4FAocs6PaQCHgeuF1VRHxiKr1M4eEjF45J4D6VHUdPdoWTsWHSgV+D
         WKFK2htY/AydUMCGJqBPX/jRcQenGWp2Q4fbrHlzEDpA2MCFpUG8HyqjiXLLGEGmSXRt
         tcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+AOMh6vyy15u0zfel3GrLcN5HChcyN578IHMi8baWmiXjk6yWHllC0hcoF8Xvd8XlpmgCLmLxF3vvyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygIEwpfkD/HIK94stTGYXcsE6ifk7kbdyNJxENAtF2Bxptuqoq
	zv4E4LqfusDZeDR+J5CZvb+h0/Fl+WHjfRXJtagXlw4mRfO46XVNbgpj9pObXLM=
X-Gm-Gg: ASbGncuUqiHlDUoMRD5Pn0ehb9svBV+sP9r2MWrX1hA8KCTvRxeAVCwVYsGBcCH9LCC
	2WFOgsH7DBgA3lTMkB03PgxOFhIxD41yJlhtUqqyqSZKm8h0xdKyYsRPEeIZP+pJZorkDpaZncT
	CLrmmnOTOWQUdG9LxTb033/fFsi7Zw81sWMtH+hTTT+uFu0ZpR6AeKebfMU7ji7hdot4Qt+Tmo1
	xMR/5Ct/aTSWeUjGxPBQ1tCAYbsveynYNbdtQ+L/TDlyY7JJ+Ej+Q6QcTxQPKNvbLJ00pJEkech
	nywy+JLRe6zU5HvO7mPqju35ueiH/Lk2JmQSgb/c9zIteaQKLjh2u66yP3tazDMwwNrSJpBBNDC
	cQp8TeO+7CWPNTkwXkA1h7lGaXri9uA==
X-Google-Smtp-Source: AGHT+IHyRLgkNoCEkf9M1ICxzrsASm6on3//oo9APTxgLDD9aYJ0CrJh/ehpG879EGIFtCHQch+O4A==
X-Received: by 2002:a05:6512:b99:b0:54a:cc04:ea24 with SMTP id 2adb3069b0e04-54ad068688cmr1116238e87.46.1742479254697;
        Thu, 20 Mar 2025 07:00:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:54 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mmc: core: Add support for graceful host removal for eMMC
Date: Thu, 20 Mar 2025 15:00:35 +0100
Message-ID: <20250320140040.162416-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmc host driver may allow to unbind from its corresponding host device.
If an eMMC card is attached to the host, the mmc core will just try to cut
the power for it, without obeying to the eMMC spec.

Potentially this may damage the card and it may also prevent us from
successfully doing a re-initialization of it, which would typically happen
if/when we try to re-bind the mmc host driver.

To fix these problems, let's implement a graceful power-down of the card at
host removal.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 60af88ac0213..5a62a3d3df32 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -36,6 +36,7 @@
 enum mmc_poweroff_type {
 	MMC_POWEROFF_SUSPEND,
 	MMC_POWEROFF_SHUTDOWN,
+	MMC_POWEROFF_UNBIND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2054,15 +2055,6 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	return err;
 }
 
-/*
- * Host is being removed. Free up the current card.
- */
-static void mmc_remove(struct mmc_host *host)
-{
-	mmc_remove_card(host->card);
-	host->card = NULL;
-}
-
 /*
  * Card detection - card is alive.
  */
@@ -2088,7 +2080,8 @@ static void mmc_detect(struct mmc_host *host)
 	mmc_put_card(host->card, NULL);
 
 	if (err) {
-		mmc_remove(host);
+		mmc_remove_card(host->card);
+		host->card = NULL;
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
@@ -2160,6 +2153,20 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 	return err;
 }
 
+/*
+ * Host is being removed. Free up the current card and do a graceful power-off.
+ */
+static void mmc_remove(struct mmc_host *host)
+{
+	get_device(&host->card->dev);
+	mmc_remove_card(host->card);
+
+	_mmc_suspend(host, MMC_POWEROFF_UNBIND);
+
+	put_device(&host->card->dev);
+	host->card = NULL;
+}
+
 /*
  * Suspend callback
  */
-- 
2.43.0


