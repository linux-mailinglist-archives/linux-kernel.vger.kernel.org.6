Return-Path: <linux-kernel+bounces-170115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE7D8BD203
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27826285CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AF156227;
	Mon,  6 May 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tW6Un03S"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B18155A27
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011191; cv=none; b=hkSbqrn9HdaRfR63h63G/YhXTtMl13EldygAo5zOvEoDIH4uh1Ami3Q2Li0CajdD22VZkZFFjNEIjZzGKaYZaNozV0k63iVVdyFmMkobLbY1KC75kZsTHbW/oOn8gAxgpbfHo/AIkbd5H95S0o/HqIqvTJRiQlFt3erVF/o8zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011191; c=relaxed/simple;
	bh=YMGGVsUIjQf2VgBWC3RcoqXjDkrx5e5yS87wvjb9cGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coK9c02zRhWk2D2No+5EZTU810DJAZUCC/XNZeyNxaF5BMpZv78qPc9ETIor//tsuqm8ptZO5BZ7fTuUtgF7OxcqQ6D4IkS2wvJveHdnVT3cJxCttY2fxu+z1BiOopC2w1XmT9KdrLrdhuMFYMfx4d8xe520LsTGDfeSCV9VBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tW6Un03S; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0442816e7so801907a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715011186; x=1715615986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAGwrecvGXteCvVGgA1e1GYVTjqsSEm5aVyfdJzjWYU=;
        b=tW6Un03S5yPzK5bOr32OeYKYXFzw2CXlk45RC0ra5TsXkKs7c5pcHt1LNvqCVTrq6S
         qDSZKoS94JRkOrKN31d86+e7ruHxWiR3DafyaDFonn4EYZKZMHNy/JK8/vqJgmtTbl3D
         ZlS+FQZgvtpbDUIPgIIc2vMfHWgGQ9Ok9LsjlEwRjTHS+XAay90cRl0n8JbRHLimRV2Y
         DRWWMyaeI5wOcElV0Pvs10E547Qj8duYCgHT6ZaUSTCGDmk7cLrnKYwO3YwLXwgUD9Nd
         iCSqKe7ZJRwJWjfu46o61S8rcOGjCvAREyvuKchjcv8p9drS3SnbJfG/O2hcxtxw25FY
         Y1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011186; x=1715615986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAGwrecvGXteCvVGgA1e1GYVTjqsSEm5aVyfdJzjWYU=;
        b=oqXTXg0Lz3yB7REw/fuIFe42zyCpwwwT/cgqR+f+zelHPDJDgMshD+kgHVZt1WexH3
         Ljyhp28hhspRJN2Oj8c5N6XvjRNCnJ7669nkOUwOOsefzNGrgeWJ84E0/6Pk/8jQ2/XP
         2rG+x7xuZY6T98tRrgRmY+T0uTRybDeTg+xoIk4R7SKFsuHGsjo8SaXsmdEj+9xHO5ov
         0A2raB5Dg/b2qUfUaBsR6CcYcMNVt0Rz3RU4GKBbdjQkDOmJnm+vNXf+rupzTuu1Fsog
         8u2W84L3Q5q3E3gwOPoR+izvriCN4oZ2z4Av7/7Ym5w4BGUFTRWkzGxE1vKHFm5ler47
         WuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnOqqZqHR08PsCMi/ViQ+rmnNcEuYHBmZdqNE4utQv6eoyoHoUXFaQaGjw/8dVsRuLtS5TPiJfdiW7FILvs7yf8e0kiakU0BRlv+A
X-Gm-Message-State: AOJu0Ywalc/o/wgaLac1ThLN3ubzhBeH6CNxbnhTooRcr6Zx6CIUCo/f
	qqJiLowrlikm31bBZ2+L5zpqDykzNFhvJV1Q836doO6XYGnmoSpfDXurEkg0QnA=
X-Google-Smtp-Source: AGHT+IGrx6LK+UeWJ0SHFwCJ9zDahTjHANduPD+Q8IbM8JODW2Y00gTfXonztlGCeDkcRCJG5sgsNw==
X-Received: by 2002:a05:6870:f688:b0:22e:98df:9a2 with SMTP id el8-20020a056870f68800b0022e98df09a2mr12386001oab.8.1715011186287;
        Mon, 06 May 2024 08:59:46 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id e17-20020a056870451100b0023c82e5be0fsm1955226oao.7.2024.05.06.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:59:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 1/2] regulator: devres: fix devm_regulator_get_enable_read_voltage() return
Date: Mon,  6 May 2024 10:59:15 -0500
Message-ID: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-1-356cdd152067@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
References: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The devm_regulator_get_enable_read_voltage() function is supposed to
return the voltage that the regulator is currently set to. However, it
currently returns 0.

Fixes: b250c20b6429 ("regulator: devres: add API for reference voltage supplies")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/regulator/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 4f290b9b559b..7111c46e9de1 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -193,7 +193,7 @@ int devm_regulator_get_enable_read_voltage(struct device *dev, const char *id)
 	if (ret < 0)
 		goto err_release_action;
 
-	return 0;
+	return ret;
 
 err_release_action:
 	devm_release_action(dev, regulator_action_disable, r);

-- 
2.43.2


