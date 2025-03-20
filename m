Return-Path: <linux-kernel+bounces-569817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB884A6A7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1176517E73E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BD225798;
	Thu, 20 Mar 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovGwlYVK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE538225405
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479260; cv=none; b=Dk9os9rMQcijITwckXzJ/PqnCPUuqwdfKx8mHqRUSJOscgu2eY5xIuqLM3nBgWUKugz45Vn9Sb/E4bKR6EUF3eCfyz3IdT7R0R9btScfRgHLnFE0xLqM5MKZKDauqo0Y8VPgB5vdE9Xi9s3lkRTcAzWI9FwMTxDOj0XZBlIPweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479260; c=relaxed/simple;
	bh=tJcpx7kVoOVh62Qzq7CsqXZyteSS2xTmfx3MklEEb5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG0HdZaQwUFRpuA1sG5klM8MskeBLhQIOHgefJT80q3ErZC5iXvERD4+g5P82he7nx9OZSaGZvqHWjLkw65wiipUCIRx+xfFljyyi+idgw9T4LrKLgyjap0Q6tJ7hmsxbsClRwC/YHj/kUPXoL3Zpv5AlJuygEl9CVvWIajHVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovGwlYVK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499d2134e8so1120556e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479257; x=1743084057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cpurPguaZZPLjWUcw85lV4P2hxnhe8DmTCMrQ+sP8E=;
        b=ovGwlYVK5p5MCyM7n0n+8jzkYo3MDkQnvXTmQoBhq/Fjh5q1C8rjW8+ORWSc16MwdC
         bfG2H8MJeRj1WXehec8O2cCg/yKJGsAJG6c2aSvvVjDVuAuWKHkNW7bKFLr9cHUW0cXS
         OFIplJZpUJGcrZxpKZNOArUOjXFd8NcXyA4RNcOAfcjx8NcRArND8/CBRZlhB1k95wck
         vEdwWTfLJR+uvJDNLiE6CdoXE4l9g9eBPfyoAzQh3ixQMw+V/7yzpV/DFJYm0fpcpumN
         VvgkXx0rWCMtS6OCHQNWYM/7W048E8KX3lh+NXGxFqOEo6zAlH1+MZ/FuRNcD7rRE4IC
         x7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479257; x=1743084057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cpurPguaZZPLjWUcw85lV4P2hxnhe8DmTCMrQ+sP8E=;
        b=ULPp1DdX4Ax+lQs75R9ZToHk2pNjSFrgt8+n2THamwHnIzIw/C+WkTs6YLoK7CuHsi
         gCOw9P3zscAka3SKoL3xQiVc0RWsQgpDPJ+CtjTimSFLaH5JnugWhsecim/DpRAceCHh
         2rSVovDxaUQCRX6tYmz/RxC2sPLlX0hbNWzFFnPM34tyFaIZn9u9sCmIvsO7CiraAdf1
         qQEsgRWgDMGTXhJYeLW732f1ne7iVeIoS+HJ8DJmcfaLlihEOk6HQlvYf6nMnZTV+evE
         L+ataXGju9i7rDPJjStgqKf5vjCBqJs3VP4WVQtYz/vepMu/+M82ryP142xHVHLnJykU
         7ErA==
X-Forwarded-Encrypted: i=1; AJvYcCXCrcVor1sZMx5zSUg1dHFEmw6lDPs03bG+zYA/a82bYD0zPH0TEg06xRRG1NCPp/4oEDBV4svRKO8B2ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VA+TGSbZujOznt1cW1uessp0bn0lyYjGWe22ETnm0jtuRrvM
	o5fbNOB+5dBQiC2ub/1V7Mx0HQqJXJso9+jTLbkNpeqM86ZQUwNU5Nt6LAzOr78=
X-Gm-Gg: ASbGncvlFAZsaHyN6g72QzAEfnPa8aoI9LC0krqtjvFj3/r+VVO26zl1MgAWXc+luPl
	0tE8rEHVmJf3271oQlgsgcu2MNbqhVIeHD1GkaUfCuPpmvCfQjCt8atqYAZWmL48sMQ3hfRxa7n
	VvmLNP7qbU8DZkoE2ApHUfVnXoA6Dva/T/TkagLZg3r4ZTfY+Mh2nwDynr8lOu4VE7hTXgq9YVm
	xb90u5cVPnRYlTwbIQWAFbuUABlfDhSopKF7xljTqXk1+eze7iWnpaFzMGoYeHg2K0QX/y2ucNq
	hIhCX7TU/zDuK/RpVA6Efhd81EQyAz2ML+zWamsWweYMs0r8wf2FIO1lDtpEx4ZwkCoIvE16ejw
	Z8RZsLePsVap9jT0fyETyQY29y2iFeg==
X-Google-Smtp-Source: AGHT+IFI1fZrjfRWED8P3YwlNenPg/UaJprkHPw65/8Gv1KQD06yFcLy7lNo8+Ww7atrOreTQU9wBQ==
X-Received: by 2002:a05:6512:400c:b0:549:9078:dd46 with SMTP id 2adb3069b0e04-54acb21a517mr2932004e87.43.1742479256977;
        Thu, 20 Mar 2025 07:00:56 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:56 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mmc: core: Add support for graceful host removal for SD
Date: Thu, 20 Mar 2025 15:00:36 +0100
Message-ID: <20250320140040.162416-6-ulf.hansson@linaro.org>
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
If an SD card is attached to the host, the mmc core will just try to cut
the power for it, without obeying to the SD spec that potentially may
damage the card.

Let's fix this problem by implementing a graceful power-down of the card at
host removal.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 8eba697d3d86..cb4254a43f85 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1596,15 +1596,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-/*
- * Host is being removed. Free up the current card.
- */
-static void mmc_sd_remove(struct mmc_host *host)
-{
-	mmc_remove_card(host->card);
-	host->card = NULL;
-}
-
 /*
  * Card detection - card is alive.
  */
@@ -1630,7 +1621,8 @@ static void mmc_sd_detect(struct mmc_host *host)
 	mmc_put_card(host->card, NULL);
 
 	if (err) {
-		mmc_sd_remove(host);
+		mmc_remove_card(host->card);
+		host->card = NULL;
 
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
@@ -1730,6 +1722,19 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 	return err;
 }
 
+/*
+ * Host is being removed. Free up the current card and do a graceful power-off.
+ */
+static void mmc_sd_remove(struct mmc_host *host)
+{
+	get_device(&host->card->dev);
+	mmc_remove_card(host->card);
+
+	_mmc_sd_suspend(host);
+
+	put_device(&host->card->dev);
+	host->card = NULL;
+}
 /*
  * Callback for suspend
  */
-- 
2.43.0


