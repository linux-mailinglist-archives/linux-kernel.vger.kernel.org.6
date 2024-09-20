Return-Path: <linux-kernel+bounces-334460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E467B97D789
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B244B224DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4A17C7C6;
	Fri, 20 Sep 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RI3g2QiF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83C17BEBF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846517; cv=none; b=L/YulSf649i/lI+IJ7VI251+IUj1TzycdVCz5I6PlkdT9z+aociKEmWhw0J+lpG2ozTqOSJ07+HI3LaPOliU44lfrjqOAhkS6W88LxZS8jr9f3itbcNjdFvg19qWoRg4qdezPNal1ly2SfkYZSWXwp6mxPH7sb19NmhYByACkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846517; c=relaxed/simple;
	bh=Ff7K6cFONJH358OS+E+terxkifRGKFlrelFWRsEBzH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NjFzQG/oDZ/KagAD0zyCwMnMwEE+v7fuhHvSwjTS5urEGQXQJai64Rw/l3eT0Xf7ZJjHXx5MFsiMlG6egikS5/g9r2qSxE3BSMrbWKln3pgBfByEiUO9u83j3CsiXBi0qtX1AaI7Vgg/p6LxUd7oJLBWGnf9opeCB07t009xO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RI3g2QiF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c180d123so1356410f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726846514; x=1727451314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQKR4iRmb2AaBghMMbFk3Osh28MhFGu0gWv8w6kVGDQ=;
        b=RI3g2QiFkRcibYsZw3ixDqLmpBKsVyX+uT9Dik+tOpAuWWDa/Lihu6wWGgUsGJHYsq
         dsh+kPwjsBHcyuv9EzH49CHKwHaYNNlaylcUYJH7plhS9JBsk+Ou0CphVHOc7lUnf1d8
         XXNT5m55t8XK+xC8qPNQ8w0+3OVPoURBr5F1jS/lJ+OGqVgQE7WTx0Wfql2h8sPjJybV
         ab/Q3xM/bsG0eXeEcL4093t6K7hd1Qdxr4d+HGIh4KgVpnTwyTMie5191QR0om+JBq9B
         Piat/sswvGrHq16qnGdUhExbxnpM/UgkZuPfjFRz4WY5/aoBQ89QsUzIFvJs9146CJV2
         RPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846514; x=1727451314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQKR4iRmb2AaBghMMbFk3Osh28MhFGu0gWv8w6kVGDQ=;
        b=djlTx6U1PAL6i4gCVgFBksAADcwjugQ/LX0zhd4ZLUFxeIlDOirVthPFQ7cKpGXI0o
         Xb29FcqjkrJ0A+eowV4krTu54xCGaWoEvB2gQhx78Hhm+UV5s3AjOoWkAjSRJ8BUn11F
         r59dNpfoHRyvixHeZuK7KEe7BfYG/Q3qqmbBHh97BgkAmFHZ77KLbqZr6KYx/EKlBFgD
         1C7r3Ad2VV5zCQHHDFOt4hJmQawM8cuL0CSw3sADPWdOFedDiNxrUIcvl1M4s3+3s36Q
         fJMwDehGWdZnpfORJ/cn++FQN3iHvYwIYmCbYuCH93qOswwezvWHTIrEm/OczU16TL/H
         T5QQ==
X-Gm-Message-State: AOJu0YzC0ZkaFBXvbe6Kzj+Bqndyy0gmt2biydNYiZl3M8dHeLYzA8NI
	i4djkmcMTrBs47IjcXVCtgzUi6Mp4lGoahpbdEu1/+dN2Vr7KITdZjiYr4evVsc=
X-Google-Smtp-Source: AGHT+IH0vMONnBQRabKJT6a9AQQ+vueeCVBbJ60tmNS6BEyiTM/7pjTlHjSnl2mbonRS9dVXU33V3g==
X-Received: by 2002:a5d:6d0b:0:b0:374:c847:85c with SMTP id ffacd0b85a97d-37a422ac5d2mr2496650f8f.24.1726846514014;
        Fri, 20 Sep 2024 08:35:14 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9cd3sm18176096f8f.62.2024.09.20.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:35:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: isl6271a: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri, 20 Sep 2024 17:34:32 +0200
Message-ID: <20240920153430.503212-14-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Ff7K6cFONJH358OS+E+terxkifRGKFlrelFWRsEBzH0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7ZYRKVN+50dKf2I6p8wRSmUcc80WEOwL+OGNv hAa6YGeC+GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu2WEQAKCRCPgPtYfRL+ TojqB/92lYQjZ2MhwwPvWuOFFEvK2KuSi7PcM38naimTSa7gm5K0WpR1yJV3jGawdMa8AMEdp6Q okIMlzXhaLU418QedG2eAYPfVqLxNpQV6yAwya0DWxqMJ5XLjbndHC/WDeWv6K/hgtlA3VgeylZ zWIjPQX4dfGFt0qhsk+STeSoOmrwi4EX4YAGKOqBCdM/n4NfR44qotx2YZTyyCgid97kEzkM65n wC5uj/SypShzU981pleIzwp9lQPR3p3LwHJyg+SwPFexkWSA7FY+pqsNUuSVtUB00PCW94XLFXv 3lvo9zJlaQJIdiRfgUVZ0blMVxM7F004BhDB9uyi26I5n2Ca
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While touching the initializer, also remove the comma after the sentinel
entry.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/regulator/isl6271a-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index 69b4afe95e66..7883cd160727 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -138,8 +138,8 @@ static int isl6271a_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id isl6271a_id[] = {
-	{.name = "isl6271a", 0 },
-	{ },
+	{ .name = "isl6271a", },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, isl6271a_id);

base-commit: 62f92d634458a1e308bb699986b9147a6d670457
-- 
2.45.2


