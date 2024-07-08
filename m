Return-Path: <linux-kernel+bounces-243997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83677929DBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F491C21D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431AC48CCC;
	Mon,  8 Jul 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EYDe4A6l"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0E38FB0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425035; cv=none; b=W6xtg3YpxzeJ2Vog1rbzvnHVkhUZqzwu113S4zf9rnyaC6OPiyY+EtSuyirQJZAu62aEcJ5gS407V/OPsJksUk30YhkzXMJEBpeYCemWEDqk2B0oEE4gp1wrEaFbcWv+nG6UMUMfKuxqmufUhH0Ug+kimG6/hxPAsC+zrDQiiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425035; c=relaxed/simple;
	bh=qT/I0vbZRGDpE8yP1ELoiUDNULDJ0duW33V+A0EfTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7BqOg0SFPC1TxfnlIjGcV4mPR+qNJVvMYabXp6xrh3wDvIToY4OQ6jR2v5HCsJXfM62FOyWt0+eu+fJLrWkoZhSTuFL9L3xYiP9V4ydf1tfeQvMZEyNZlzViHM4I/VxCZGw2wlizgdCPknrfRucCLqADGb97V/50DYT6kDt+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EYDe4A6l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36786081ac8so2223668f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425031; x=1721029831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=EYDe4A6ljADu4uYo/+yKHjVNlJvACxZlSWBOvUy9AFzEaoIbWw8rxjdcodDmYPByO7
         Y70F5jkWV145zREBHbMGdBohy7VoKW9o+Hh2m0VZUktQ+mlKwdHW637wJW5JL3pSlye5
         m+o+obqdTKGGCspqf1WNoOUEmMZfCxXQcAQgTL/Cki+UfQ3D0t2w1WeoqM/WLiugX86h
         8pcZ99IFp/ViGgKLfph0A+mJxOg2jne95BgXB8ZJo8+UzTJRmpGtx3zwprRcGN5gY2zQ
         w8s7Me+filDnw17jy3mUQuxNDVDgnSnJ4LWSPXa3infDj0XV+c3+gS7DzqZwb4ax8WBQ
         S5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425031; x=1721029831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=box35J9rCXAeOGizw3L38wg+IxdjoZYq1cvcjgQCKh5/hB3DRlSpCur8Sdwl7ROIG5
         T0QW+QRdHa6YYkWQIItt0qUivL8tXFSjtPth/5jAYsWM2omRPhJ1oguwY3lbg7hYVJB1
         v82pxJMQCcjI2mlzYZqkfO6Eyf5LzrCcDH3oHqP3nEG9L0o8pdJ2t3QrxbP+0U0+kNtx
         jKCRv5/hn8B37OymFHpWyuZmI5Qu1kDY4iUhWiXrGDuoXRgHW9kE5r1V2D9vtIxPU+q1
         ZLZpeUOl6gjdAbZYDO1Fl6CL0qBroEt/CGO1J6wP4WT+pI0baIQg0b1YxTfRjQwiCrq9
         Y1lA==
X-Forwarded-Encrypted: i=1; AJvYcCVJNlBKmmCjO1BlBMGw6OyebHLTcUf9g3kGHsCTBUVu06/u61iWSdpdvUQGuVs2qAen0G8oDpF+TtHq4PHYc9fWKlC2SNT+FkcfNo3e
X-Gm-Message-State: AOJu0YyS8vfl9n6gjC6XPVt90D6lKCQ+tB5GKv30wC0/cD8CmaGi86O3
	YRwuVGyUeTbLz+UdYh1N7AVjDEazFsGCektVsz/y83v25nGbiwghpZkz8lEmXio=
X-Google-Smtp-Source: AGHT+IHVB2YXB4XGZU9hQow7TYKrFDF5hlVBHYX1Zn7NqJFValokpAL01XU7F8dmUnLHKfJPoXRn5A==
X-Received: by 2002:a05:6000:d04:b0:367:9107:9e11 with SMTP id ffacd0b85a97d-3679dd73c6fmr9802180f8f.62.1720425031243;
        Mon, 08 Jul 2024 00:50:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Mon,  8 Jul 2024 09:50:21 +0200
Message-ID: <20240708075023.14893-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
References: <20240708075023.14893-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Checking the firmware register before it complete the boot process makes
no sense, it will report 0 even if FW is available from internal memory.
Always wait for FW to boot before continuing or we'll unnecessarily try
to load it from nvmem/filesystem and fail.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 0c9640ef153b..524627a36c6f 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = aqr_wait_reset_complete(phydev);
+	if (ret)
+		return ret;
+
 	/* Check if the firmware is not already loaded by pooling
 	 * the current version returned by the PHY. If 0 is returned,
 	 * no firmware is loaded.
-- 
2.43.0


