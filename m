Return-Path: <linux-kernel+bounces-298811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5E95CBC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62786B238E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604D187568;
	Fri, 23 Aug 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dulkqBj7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBC15382E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414107; cv=none; b=Um/WFchR32nQwDWT5nw8TccNgOXy9luYDZ5ahyCVXOCoAL/TRt/2UH6D5Eyt6v3sMRfPYK1/Vc8HGSnTcVswxbD690wP+SCcFgIUA7hSk0HjELQYNh56HcNSABtgGC5VK6rF8y9/a7haQyp7MoKvyUMLv1GbepwZstimoy4b7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414107; c=relaxed/simple;
	bh=mE30tFPerVjz1hMQD19dglrF4v8Mc86tY8LTYlGryUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SACj90W6Ri1/0qHbLKPTINplu8soRA47JrnXHqy9n11I0Q6aScNhl5oEcXQdMQLcEnvZPoBPu2JpVZgPgVt2iVlUz8sjNusrA3Y3S54WLTgIxp3kgNPS0vlbPs/3MEa8d0+8kkzmVa02fG8UkB9yOwcd+/GZcUsF/F849pmTFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dulkqBj7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37196681d3bso1018274f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724414104; x=1725018904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjB6qUCGKHWMxKbWr+1XyaIhur+Dx/TBgKbSsSEgQwo=;
        b=dulkqBj7b54ntJkancNh0uAse5tQaVUnVs/4KEzw11vZjuPulbcX8QQuVhMGadeEv7
         cZRTESBu4R31IYoyMJEJKwcUIEAC/IolejPieW7hwmbgJir8kAkDxhjlF+aVVgut6t7a
         ujtb/cMID4j/PqFENrxiSm4LD8aMqsxhbYj/csMk0yu/ZYIa49mN8t4JEalVrGvrB36h
         M3K3rINju1Y1WwfCPyHzWTSDxxn1spdvfa7WoTu9JttUZaL5XNeW1QqHaJ5eHmj5K7Xo
         VfPG3zrRgj3uZRZRgX/I+l5gkrZ9Ewh/qkD3jbzCY7c5rEfInPfE5koXI2WE3T8g2bwH
         SImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414104; x=1725018904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjB6qUCGKHWMxKbWr+1XyaIhur+Dx/TBgKbSsSEgQwo=;
        b=aRJxnLPgn86bTr1zYLzMJ0mP1xle/f1bZA9xhWMwJGDfJjojszSapAkZGGGJBRWt6a
         NINiTXrN+l1vFM6h1GT69HEC2LV5inByQvoT/itJ857qOHTq5seNgq/2yO8QeEB5UO8U
         6i6qMdtBcFlk4+tEFpXl4GpuCUs9bIkBCXfb5/7cRxIW0q1QbgW2aYsIhaRYy9SOdYie
         StDXXRsjkmyT7COtSpfMZILoObR4TQBfne4eXHU5ieTTZlyQ9ynZQXVIT+qmQY+JA0C/
         kYV3Pn89hZiuR0ihSFSGLLZ5+K42kH6Vps3bHD6i3C/T4Os6uAeWmabadr3zxHWaKS2M
         FRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEfEDsKd7W1mnNN7XDsmDc00nxWkunXAjnlzqV8lV1ILL0JUWCxn1+utv7NZyT5N7YgtF7G2n2/swIocQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ04GooTB2x4OXDUbd2OzjGNsD3zHjSQ0NMgTpf8iWY5P1Y9Pu
	SbFl4THOGfFVuQcYH3iJi7SizNKt4WRxrn93XWpkJpINUjhF+zRH1FdCKwOvQjQ=
X-Google-Smtp-Source: AGHT+IFPtmh/Kb0AOFMbjOIF6PgocrhpRJr53++YPtKB/vcg+SaeiqCVHtwg7xr7/7n7cgCix1DrFA==
X-Received: by 2002:adf:efc7:0:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-373118b9961mr1489598f8f.28.1724414103149;
        Fri, 23 Aug 2024 04:55:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm93423695e9.28.2024.08.23.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:55:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: set the wlan-enable GPIO to output
Date: Fri, 23 Aug 2024 13:55:00 +0200
Message-ID: <20240823115500.37280-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO
as-is") broke WLAN on boards on which the wlan-enable GPIO enabling the
wifi module isn't in output mode by default. We need to set direction to
output while retaining the value that was already set to keep the ath
module on if it's already started.

Fixes: a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO as-is")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d786cbf1b2cd..700879474abf 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -288,6 +288,13 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
 
+	/*
+	 * Set direction to output but keep the current value in order to not
+	 * disable the WLAN module accidentally if it's already powered on.
+	 */
+	gpiod_direction_output(ctx->wlan_gpio,
+			       gpiod_get_value_cansleep(ctx->wlan_gpio));
+
 	ctx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ctx->clk))
 		return dev_err_probe(dev, PTR_ERR(ctx->clk),
-- 
2.43.0


