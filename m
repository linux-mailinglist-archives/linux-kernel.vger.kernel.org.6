Return-Path: <linux-kernel+bounces-332632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58D97BC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BA1C218C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBE17A59B;
	Wed, 18 Sep 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MTdu6soW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E015B987
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662744; cv=none; b=nLJZcj+OpK4lBOe/Lw3JGej00WVWmqq/pZ3CMJVjWRcHqTLRf3vac+JvGtJpk3rjFwGrWQoX4gd4CXzXqQQZUP5DSxWTQLN8IRRrtOik2ROkNw/B57GxtnDZLEkiz+AyZiEM8dZKl1D/0cEvLReKbADIG024G2soexnpEQkj8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662744; c=relaxed/simple;
	bh=0Ewu1Bf1n1ivrLhweUsmqJPyBacpvy03KpcFyiHn5/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HAhuhN6eFxMRLdVnut29fc8nZU0UHlEGAuhzesXa+ceQhCLNib/Zq+SFpSTWmD4U7cHp6UR+GYkTTkHenzUgeXiYwO9FBdwFemoTQD8B9t/wFWSJRa9ekJn9AHAjkKbpI0tnq0BVZ7NMZcnQ0YW3wQdcVUtjNETyvKhtZQbKJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MTdu6soW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d43657255so799482966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726662739; x=1727267539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNv8QLJodZ6BCBr5nGzPSsAYWCO80HdyRqmgwW37LDs=;
        b=MTdu6soWHv3iBfHfw26OVPnqkoIUQkfoGWERYoje4NXDP8qzWec8tOzFp2e+GIIKkd
         znmHyjRzv40//WACPCOlAYLmTXpX0jaRKzHxximpKMtH/LEPBVeEwFb6mCTCJ6/2PdWJ
         nU+rUiGY5bs5mpNkpYOF2orWo2op2QBaJs6cL4Z7RlJKznSIpEFmEUDd+8E6tZ83jlup
         e/xeMGQmstTbVOihQIkDFISz6BYLK8+wOywwFBsrWSgUI/2u+9GsddSAoAZDIXLzyGJR
         oQ1nchIsdisXLicsJWDxHbz4FxsoLUAZvcJM7SJYJ/dd0+9v7xyg8X/Rgxm8+MZ9PYPY
         pLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662739; x=1727267539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNv8QLJodZ6BCBr5nGzPSsAYWCO80HdyRqmgwW37LDs=;
        b=uasmjyOdA11v7sdRtumjaQXZct6TE+A8GbCRzWSkbrzMNHHPRzKOswbdDdOUE3rENM
         8KtvJkg9vdEi2KYzpYe7/T4TCkvkyMZkWnlwIjDFext1aXoKTucUgIS+QL/nxoK4giRv
         cFf5Kvf4EzVP2gnFqVcrg4OthwTLTP6+safFfwgAp1dcAKn7/WHTfC3tcB+u1BNPU3X2
         Wqcg2a1l/9ZwhNXpTzlQFCKScJlx6Cv0LiOsBXCCBUhtAln6d4841grypNWjk8igG3T4
         e0CNWsSeKEFsjmnFwE/qwZpQhnjL2/CZVy0kXifBp2Q56Re55b/w5VdIU3KbMB6iQOjb
         rfhw==
X-Forwarded-Encrypted: i=1; AJvYcCVAkuJZ1iJk3P8kzngqpypTgYCxDDpvopmXlK3h7oHe8TAxClC+9YdqPWuMUhX4mSfuINxf9qT7OE0ULqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevZis1mSTSo+TBhI517Bx6UnPSsCaAKDLgkKXkQTC8ys84CXw
	dALsh9QBnhwcd3aDo+kmvAs+ul9zQ6hZETQ883yabs9+n4BQm1IbUn1vbm82Bd0=
X-Google-Smtp-Source: AGHT+IH1q+42NUpJdG4bTG+GAbbjlQ9prDuIOZUfSCWUinfkTts7ZNz5aSjwnhaCQa8TH4xEO04iYw==
X-Received: by 2002:a17:906:c104:b0:a8d:1545:f48a with SMTP id a640c23a62f3a-a90480d1ad7mr1674789266b.61.1726662739250;
        Wed, 18 Sep 2024 05:32:19 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a2bb:f619:b5e9:672f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3ae2sm579795866b.76.2024.09.18.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:32:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 18 Sep 2024 14:31:48 +0200
Message-ID: <20240918123150.1540161-6-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=0Ewu1Bf1n1ivrLhweUsmqJPyBacpvy03KpcFyiHn5/Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm6sg2aWBQLYs4l+ry7q4e70lWZyofdgv08JB1Q 05qGPfYsTCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZurINgAKCRCPgPtYfRL+ TuqpB/4tFfFZBEhjmMML+MrJFPtMViLsxeGws5xRoIPKZow/utKTWopil0U0daSc3Pxck40whVs IZAGwew4rE9otXEDO6bf0yMHI4QPDR/SY2UwLm7RQScHQtACgABwFIS21z+TyjGSgm7/6Zb9PVe vtxpC08MQgKlffbiGBKpgAUwYzHsBPhTtVh3gkhaYz0F6obyEIZVYFL///184TOG9UTFkZCW5dx NV6oKG197zwUduZyetKLljHJHlNVKOLIoENGAoXeyXbNScha8bW6Lw621BTO/hD9bf4YxmAkBkb LgPfjG7CtrQCEevOMZXfZYIFp0MKiIRDYtdu/rf/05SyK6y3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/extcon/extcon-fsa9480.c | 2 +-
 drivers/extcon/extcon-ptn5150.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
index e458ce0c45ab..b11b43171063 100644
--- a/drivers/extcon/extcon-fsa9480.c
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -350,7 +350,7 @@ static const struct dev_pm_ops fsa9480_pm_ops = {
 };
 
 static const struct i2c_device_id fsa9480_id[] = {
-	{ "fsa9480", 0 },
+	{ "fsa9480" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, fsa9480_id);
diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 4616da7e5430..78ad86c4a3be 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -338,7 +338,7 @@ static const struct of_device_id ptn5150_dt_match[] = {
 MODULE_DEVICE_TABLE(of, ptn5150_dt_match);
 
 static const struct i2c_device_id ptn5150_i2c_id[] = {
-	{ "ptn5150", 0 },
+	{ "ptn5150" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ptn5150_i2c_id);

base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
-- 
2.45.2


