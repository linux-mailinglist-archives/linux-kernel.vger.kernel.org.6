Return-Path: <linux-kernel+bounces-256240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BDE934B55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BA7B235E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD512D75A;
	Thu, 18 Jul 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ro39/axO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083D12C46D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296689; cv=none; b=LdefleNTfLxRMYIiGxCT4ymbmkapr6vVlzS1X/kWLd06q81EUIrKDkXYJQcOMzM1ZTzsNFiF+g8FuHljFiRNCX3Ozr/uWK058lA9CEbhX7Swso/f43KsmZ+S5eOkZR9c3M/ajoB5bz13YuHigVaCFO6rhv2Vkwo8GPLvEUQEKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296689; c=relaxed/simple;
	bh=vUvLQh/jO3ceweKyo5MuuklomweI2Q56BLv7uiWnR0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+7m/ejTADLh/wLzr8WoJKk6QIHmYprKXC21Q5JvkWhmIW3MY8kDNPEujn2bBwRWYkF3E6Hf2FJsx99th5bknHsXSzlKUjfdevOmamSR3Yzii8IJS67QuQBLwCwmpHeBWJkr0Lb1ZGUCWcY44Z2ZlcoIzAQwSm+LGIQmpSJlBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ro39/axO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3683178b226so342396f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296686; x=1721901486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOgT9D/DodptCqE2kKdT3PPWDoUGy8iZZzt0/7nqeFs=;
        b=Ro39/axODBz57J8mWllB92iCBbdH9EhNVDO6J1ycG4k0RgCPSN1NOKyhXxhKaQUii5
         YwcSc02Yw7STxE+M5IZ66rI2RgHcKF0p7+/BjLvjpah+60e9ykBsJzIHlpRAqaTih7a+
         7ypc8txKViv52i3tI8hTE/kTT9UHsDRMaeuUq5VeiAUVRhRXc7MtKnCD2ZptVrc1titt
         Mmlc0Rw6ttRJnSySXtp6ZCMGxcNCYXFH0d8TRbA6bjhUSc46FkArOwGLeu44GLziRauw
         AyVZkbSZP+ZmPtGHwjFdRK4yzmU1FZGDgdRZtPqHZ5FreolfQrEiG9piliPdm42bHC97
         s08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296686; x=1721901486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOgT9D/DodptCqE2kKdT3PPWDoUGy8iZZzt0/7nqeFs=;
        b=W/KleF5bd565VmcXilNA0DOnq+UcMEqfxq6WH9T3ODLeTqS4+7UtndFqPxz63ZJJnu
         Ja5PophH3AJlJkTFZ5nfoDqtMO0Eywojx3e+p1JQ8YoC5YfOZo6d3NXCrI3/1CQPPlAM
         yqboy9ZoOZ4Jq8Oy3W3SirjsQPm+93FVFZNfGpzyVypwyGMfU0CQCoSjtncK1HnKU6qe
         9mlKdJiesz2fznq7/LbwFaPpvlFMT5h4YRqMnManMQjCoG7y9xePZxpIfhmvvkAfD6B4
         iol+WCvGQKBA7+MJBf1Y5BrdsnYk4GqNVjwTElz7kexxnc6g4bnu1Sf7qC5vpEQipkpC
         KHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnUv5eb+r4b+cpfO+2oXTO0YQhjH1VyHQS03KeG9NfCze86EHVB4DIJJ1WAkoDF0DI7f8YOgPYN257zqIo/4+p1JTO9Fy/FHOCDby1
X-Gm-Message-State: AOJu0Yy57x0Y7PWam8Zkb3JTskMP9OcpNmoOxMrp+9Nn1+1nLw0lyJ2X
	Rhj3EmhHzDOb6xJSDqHxDprNgL3KQKiTnLIPBIbKujcUVVFJfuPuy4Ng66GnOo0=
X-Google-Smtp-Source: AGHT+IGDhk3n3fMrhl+KxiP4qxoRTY3Xql+du2qHjuCX3AxvdTe+ANakilfvecMzJUQGpqBPrQYCqA==
X-Received: by 2002:a5d:4576:0:b0:368:657a:6347 with SMTP id ffacd0b85a97d-368657a647bmr411614f8f.34.1721296685836;
        Thu, 18 Jul 2024 02:58:05 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 3/9] reset: amlogic: make parameters unsigned
Date: Thu, 18 Jul 2024 11:57:47 +0200
Message-ID: <20240718095755.3511992-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

register count and offset cannot be negative. Use unsigned integer
for this.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index cd7dff5bff61..a4705021b8f2 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,8 +17,8 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	int reg_count;
-	int level_offset;
+	unsigned int reg_count;
+	unsigned int level_offset;
 };
 
 struct meson_reset {
-- 
2.43.0


