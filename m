Return-Path: <linux-kernel+bounces-332634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380797BC43
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C94E1F23543
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E518952A;
	Wed, 18 Sep 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t8hMDXNh"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F43176FA7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662758; cv=none; b=HEK4KWiPlr2pXHwmKONmhIcAeEWxIHzHMQzzJdUjmJ1ivRvN7UXwwJb4LWOArdh73Uy4Hm5oftAe6PLoVP4l5cYsRFY4rNxIbeJldL7jFk48jQn4zIyOtKKkeEZtpL2mtd3OEvDfFLpsFam97n0U2VbqtgB+asHoUWk3pQDQOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662758; c=relaxed/simple;
	bh=e94bHoBBlK+w4WW/sjko5SwjqRhAXR8YYex6MlFdW7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u8axJTsniQKktRWF+CqDaucYa7kT9waNuPh7tP5KcnXzlac7O5UFgrxtn3S9zYEna6qAPmA5lp6l+DWedx0S49u3iGPJDfQfMPhdd++yKwmzuE5YJSg/GJUxK/Ckn40KpOEPKj0fUsE09ps2Kt58JimlpwHFe8rH2bC2d4JK6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t8hMDXNh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a706236bfso372560466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726662754; x=1727267554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSSzj65Hf9thKNMl5L7Gjj9JEwg5bb/8x6Gry8i6/i4=;
        b=t8hMDXNhzmDRn1/jWqKLJzrzoKa7XsS8g97VB11e4Qs+DEj0YwQlDZoUkp2KoM9Ggb
         yeITwtcgfe3oFa0BpRmYO6+V1QVjsZcWlEHjVMEfAlEDAQruQOB7iP3KPatee4cIMKlJ
         aAiRMfJOFqNmnhfbYotv7ZNaxDJtjCV8GcexkmcHeM3vCHKlAzsOQsmrOlqjA7vhuVEw
         WPtqP45qZjZm26AuB7yViAexIDLiHZ7CU+eVN5mdp60wGHbAHIgWxqttIxF39FJBTxdH
         14CtNmMqE9EmSVCYamQ8VC72aKqMoNklcOX9DxyDcK2GApxPSXutRuh5Elme6SzJfIte
         VeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662754; x=1727267554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSSzj65Hf9thKNMl5L7Gjj9JEwg5bb/8x6Gry8i6/i4=;
        b=fzl6AnoLiQn2rMlyZxpdhqtxISlxXNJUpU44XA/20am7vgLPaP3EgrtQD+wH9NVUNM
         P83tZcvr39mZczsVv+CQYVnHV4UQ4llnEFqi+EiqcY+YcpQBneJNaY7TdoZPhGVml/Dv
         RX5eG9ILHkfs/rK53O0bws5bmFHtMInvBfZgf36rAT3uv1XWFjwwmQMhcNYbPnadjT/x
         AQvvYf4LKw8gALOeR9GgDJS2/M1TfL9wXkWatUUc6MmSnBNcodEO6vHy+Fvba7tsb7Wj
         BoS2/thHKr68oTIehDx8h8BRHGcIM638EbunXykEkqzU3SGkrE6tjv9z5VAWsVxkVqUL
         Ff2w==
X-Forwarded-Encrypted: i=1; AJvYcCXwt7swDDLjWOsd/aoIITnNKWLYD6GNFvgx1cukRwArsw03dYj86p2vNPr+WRDe4wVq9RZy8M260FwDYjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKNnksgEPEDm2kAiM/Ge/4DegO6Ub3n4xoCdZPKItoHwRoFhi
	YRJf95O8OPG1ScKBY95hvGnUK93Qnq7sSbNLm+l7fN7KtTmPD6Zcy9BpESAL4PY=
X-Google-Smtp-Source: AGHT+IFOHTmh6WjjAvSlJ9jw6vJffg4qiekAqePVNu6gcJ74rOBBCjuXur6YnYguCAzYeq9aKwm08g==
X-Received: by 2002:a05:6402:278e:b0:5c3:d0f5:86f3 with SMTP id 4fb4d7f45d1cf-5c41dea6befmr29262377a12.3.1726662753839;
        Wed, 18 Sep 2024 05:32:33 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a2bb:f619:b5e9:672f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89dfcsm4768842a12.69.2024.09.18.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:32:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 18 Sep 2024 14:31:50 +0200
Message-ID: <20240918123150.1540161-8-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=e94bHoBBlK+w4WW/sjko5SwjqRhAXR8YYex6MlFdW7s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm6sg9L7fhT/JAyFhiG43/3gKjKI4XN/W/VYX3S pnKYkwp4+GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZurIPQAKCRCPgPtYfRL+ TvthB/9NbXdID/Bv6t9LBmImz/0Bre/1MCIcMHXNSglt1QBRH2pj6/oqhnYE3pl6r0Ipw+PuarE aS+kRYAMlMt6Ex1QUaXyT3/9WV4U5ZJka8NZuwhdP6u+oFV9bsn+dbpJ1S6H3OtKwt502BsWZ5i P/SwJHGwDhmtrKn62kcczFWhoxWJrWNXIL6jykjNm0nqZjJ4cBVTocJMEoFe8cCO1CZRX7X0ZCu 1EOPVb2mXDHkFiuU7cJI9abzWYZL62TXJLH0n67Y782fxma+5s7A/SFoJFilZAVJRjXohMDKoFL SRl9XXEiO/txZMwqM9VuZQK6ENbuf++zZmtr2VZkv5VOqu2q
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/auxdisplay/ht16k33.c | 2 +-
 drivers/auxdisplay/lcd2s.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 8a7034b41d50..b00012a556fb 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -747,7 +747,7 @@ static void ht16k33_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ht16k33_i2c_match[] = {
-	{ "ht16k33", 0 },
+	{ "ht16k33" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ht16k33_i2c_match);
diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 6422be0dfe20..a28daa4ffbf7 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -349,7 +349,7 @@ static void lcd2s_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id lcd2s_i2c_id[] = {
-	{ "lcd2s", 0 },
+	{ "lcd2s" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lcd2s_i2c_id);

base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
-- 
2.45.2


