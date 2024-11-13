Return-Path: <linux-kernel+bounces-407259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AD9C6B00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB17B24B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2F18C009;
	Wed, 13 Nov 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="EP4Ur6gJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFD185936
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488071; cv=none; b=tB/CRghjNkJMTO0ICiVK8XIn1/pF26sx+8nASHY7qx6Z2EnpPaqRo9rKpGUlgyJVJW6YZ5OqEHYUt9Inz4sH+RGs2enhjEs4GJSl+b6YqIdnUNOd+8EuwBthRUtNw11KlxRhSqajcRRZSCOX0K7fAcyrNxjWY3fAiMkXaK1+ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488071; c=relaxed/simple;
	bh=sC0rGWKRhlBzr+1LQVi/VMn0X6bCdk54lshxZlGnk6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV7Vv38hO/VLVa3sw1cl4+RKIrtxpaN4BzrJxk3MwlMTY/IBdb43eD8yTLZXo+QHXVdUAEg+thBPV/jV6I9QLU/+fSy9/oismuiA4eRAyIB+N5K750hyn+0oG+YVVEmlJNLz8E08d8bEtnrMxkct+2LKwOSBzQkOV+DBmx/15cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=EP4Ur6gJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf3e36a76so68683455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731488069; x=1732092869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNsK27Fa1Ex5W0VeJ3TA3Gtj8S2K08nVqm3agCQiDts=;
        b=EP4Ur6gJjbHhFlWJeJAaLg8LSmk3UbmOD7tGTnXxyI87OJJADADLhvPufmlX1LpuEq
         dapCcZqRLhl8UyH/1ZgwINxda4zWQZUCI8S2tq0jGr/bMKXA24IQVlGX+x9yFXgaCWxp
         GVadN09GdCkKBH5fOYhu9tH51Bo/EBKUEJri9BQDl4GxjetkaaBPtC6Kg7zsCyrXLQ+v
         LX0Zvb6Q/3UKroTOg7O/oPE88yttNUZCRTVpVJHHIU/xoRSfDrSdgpqLhf32mDO69y9s
         FZgK4qxW3kG7ie1ULGHglYovgnnAJ5aBzVyUPFz5oS2YgRhENyR1SUbowJsCZ+8EcB2d
         2NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488069; x=1732092869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNsK27Fa1Ex5W0VeJ3TA3Gtj8S2K08nVqm3agCQiDts=;
        b=fCKTLC6/TcIZBcu4MbQFDKtSLx2Uclm22x3pIZ9gNrK/ogM1TbmxjZQnpGDdkST86t
         0/oYcT5X5Oe7rycxFS/XW859gfCuk1OUkHXleTJCB8S2fa0HRcoqDxIEngspopZx0Bqk
         2K7ollcKmlzRnKl8s1dJwIatFCugsFPNGSJH2ZO3Mb+nMIasYJylgcQR+l2Z0+ar6a5w
         q16NW8HjvTnRrJJf0NtcaTezLIoc2ZBAQlpb3rt7Na/XggbSOJWaCQw+pLPlcOX+uPTc
         CKAKWtJipLjQnrucvDNfVb660LXvDahFZ/3uCTn028T+NQHVByQ5XwU3kbreNM+kBxam
         /7JA==
X-Forwarded-Encrypted: i=1; AJvYcCVi5JeTbuj7kbM7NSiNLPTNQzNH/u86tWLwSyeY4lSePcDe3ZLUAr0jjggRu6YXh4q1Txjsyu2iz9IWKt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02gUm0HeFujZYPT74JXLeB8Mg2gJQDEue25Ss+I8u8L9Ok36O
	Xn9IQUWLzfENFKxg266VbS442msYd/qyWe+1z+D7WOOS4dkuaiOWS/xPCjAa
X-Google-Smtp-Source: AGHT+IGvQQOK2pmty0Ab0hdZeyxnxRqA5cqd4YJeTPkl4mPTvKSC4kOdrnW1nTpFjXXf6p4vsYJGyQ==
X-Received: by 2002:a17:902:ccc9:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-211b5ccdc57mr31401705ad.32.1731488069238;
        Wed, 13 Nov 2024 00:54:29 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:a83:68dd:5f1c:4ed9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm106095085ad.11.2024.11.13.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:54:28 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: linux-amlogic@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 2/5] rtc: pcf8563: Add support Haoyu HYM8563
Date: Wed, 13 Nov 2024 17:53:52 +0900
Message-ID: <20241113085355.1972607-3-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113085355.1972607-1-iwamatsu@nigauri.org>
References: <20241113085355.1972607-1-iwamatsu@nigauri.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Haoyu HYM8563 has the same hardware structure as PCF8563, and operates
with the same device driver.
This adds Haoyu HYM8563 information to the device driver and document
to support it.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/rtc/rtc-pcf8563.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 5a084d426e58d0..42382c8709b7af 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -555,6 +555,7 @@ static const struct i2c_device_id pcf8563_id[] = {
 	{ "pcf8563" },
 	{ "rtc8564" },
 	{ "pca8565" },
+	{ "hym8563" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf8563_id);
@@ -565,6 +566,7 @@ static const struct of_device_id pcf8563_of_match[] = {
 	{ .compatible = "epson,rtc8564" },
 	{ .compatible = "microcrystal,rv8564" },
 	{ .compatible = "nxp,pca8565" },
+	{ .compatible = "haoyu,hym8563" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf8563_of_match);
-- 
2.45.2


