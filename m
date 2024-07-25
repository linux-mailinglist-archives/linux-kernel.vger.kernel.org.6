Return-Path: <linux-kernel+bounces-262427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83B93C6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50D52823E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D519D886;
	Thu, 25 Jul 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e+yRimPg"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C012B7F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923768; cv=none; b=KXQ/W9zrvRrZHTsIikpAgP7c9tbYZw+pQ3IYfOwNX2pkRweZ4WJeFEt7HvevX7q2DjEMlFWGfEEK8WvaTAYh8mzYBpOSnbADjQ3ECQaqcShIsCeGrfcc23nuSSkavgDc8qHpmINsfCQpJ7gjvzYq3jSxcmeD5qbCunKzSRkNdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923768; c=relaxed/simple;
	bh=0YzGF4GyMfessr4lVFgodpAqPfVxp9uoOTqyuI3AkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOV5Nok1sA7iGb0ETqMZFXut0Il2U3pApIaIFIGMxdn6WVmSaSl1B1O61yAIK5akYjblaQbxZGEafMTY1DhXxHrBKkCxIqO2D78skSq7hDEsx9nepepos7KaN71wdmLG/QH5fu9hueEvib8rz4PescMKQ46Wt0txsN+1zjBgh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e+yRimPg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso1528195a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721923764; x=1722528564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDSAAF/a4fOXqpuc6GQj2oOWv1xbuPBJffj+bgzyw1Q=;
        b=e+yRimPgV6ouHATokOPR5TOHh8HpbjvShzHuvuXCsDTxvd4XeBweRlnUqsUvvo+OSm
         yOq7vWZ8qiwNw7YGpd5AeWJ9hIfoZDCQ+qziLsgPDEiJcW3fCGN/jf2CYxSGVsBfFNLH
         zDp3QSU0wBBIb0GUImkLPfYd4vV0ev3rzXQLqXprr+AoP+5PDO7zEh1mwnotdeXf+hvB
         dkyG5imD74nXBw2nsoR3kDtBMnghTmdqrmqpAibha2uRmB0GPnv1l3EvDdxs8fbJGUvJ
         MrS2XX8tITIqojWSChSb4ytDXDNya5y0tYVBxSgHJhGM1Ea7UD7TR3Z43VldOL81e7LX
         n2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721923764; x=1722528564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDSAAF/a4fOXqpuc6GQj2oOWv1xbuPBJffj+bgzyw1Q=;
        b=h88jqT+7CVApbsVP08jWlfO0ssEL2QjY1x8gqNJIN54msq4hOY9Z3r545vBFheOMou
         TcDcBQ2uyy+nGd4rehYq/TSbEos861MwH+2y+SBHxa2Y4xQ5t2jXesRkcCDO9GXzjJ3E
         4OEQRmPeGzq20N6kBl/nxjtN23Qvj2sL7+YMk0yB8I9GrPykxrM3s4TvPziEvouRniFg
         pDkvnoiTWhzPVCliBgFCa/ni7tdS6tk9qLTh6QSJLeXLFQlbqA2/EzgQXbrX4IXWEMyt
         7pnOyUqtLlqQmy7cVdbgedxqzGrVOs01TaAyqf/Y9sWU3Crr2IoSAE8vz9iXCYy8WNeA
         GUfw==
X-Forwarded-Encrypted: i=1; AJvYcCX15Rvuj4UyGUYiYl0SZ/G9rXRLc5miHIw85PEkMMShnTGIWttfepgimxEYHPPygnrn8JSIBY19U1+vXEcZe2ZhFN8sJu4j51IAGLx4
X-Gm-Message-State: AOJu0Yx6qMSEwSAGiuACp3IogMyiuyXb653Q4qq3apzqOw3FZq2ZvoJ4
	hk4JPi7AXpyHG6A90IIS6ytixNjDgzpuP3KWoJNnuVRcnOfXIxTRfLO8R1ZuGLs=
X-Google-Smtp-Source: AGHT+IE5La1o0XCvTQgCQWa05NHCUTcScEIklvAMbmlU3QDFkplfIZqQmbfXWAHoKjPAnNeZz+3COg==
X-Received: by 2002:a05:6402:26c1:b0:59e:686b:1874 with SMTP id 4fb4d7f45d1cf-5ac2a1e428emr2379536a12.6.1721923763492;
        Thu, 25 Jul 2024 09:09:23 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:fa3f:b4a1:f7b0:d4b0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac657835e4sm937733a12.93.2024.07.25.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:09:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds2482: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Thu, 25 Jul 2024 18:09:07 +0200
Message-ID: <20240725160909.326143-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=0YzGF4GyMfessr4lVFgodpAqPfVxp9uoOTqyuI3AkRc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmonilDa4Bk5I2p8sRQ5FetI7P8X9um8cGz+5fu /HXU8kvMl2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqJ4pQAKCRCPgPtYfRL+ Tp+AB/wM0VR6LTw5J8IUnFLWaHQZ2+bQfJ7+wl3gGKK0vbgLQJ+HOvAQFlqsCd19xiqanohIn/P ZhkGFX4zdv5RH1vwNWDURnlmfO57tkHbSWolSZN7CL2RAkVh4vl5x1Uomda1YVLf7Yd3r9yU33R J6NHxTwN5kEJ2tykPSIS/RMl2j8MRNQOQuKSwUU4JjMBtcpsfCaTuA7JZu16vYYKauglmC0Vbve wV8kO58CUPnMobEyi63UwtqQTomkFtFZI2P1rx6fGYYFrV5XWyVLjkK3vgHcu9zsUjjYeMu/6yR 8R7HW6q2cKAFVcg85XAfvKW9gyp8RXSqZcWGrQlBOvIcu0Ef
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This driver doesn't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/w1/masters/ds2482.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index b2d76c1784bd..a2ecbb863c57 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -541,8 +541,8 @@ static void ds2482_remove(struct i2c_client *client)
  * Driver data (common to all clients)
  */
 static const struct i2c_device_id ds2482_id[] = {
-	{ "ds2482", 0 },
-	{ "ds2484", 0 },
+	{ "ds2482" },
+	{ "ds2484" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds2482_id);

base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
-- 
2.43.0


