Return-Path: <linux-kernel+bounces-395461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C19BBE2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5681C2178A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F8A1CC893;
	Mon,  4 Nov 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IfPmC57k"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC1192D7D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749342; cv=none; b=gorZbjKL71yT6kcut20fOXNXwzYfw7h14y3CqH3SDJ6lrAEylhxiVlm66qaAkWiijX/eQlAGur/XUNF0pB1ymg7/ttHOZ9MW4CPZlBrbIJHF7q2rmu2aLgAhLe/lDB9IUjsFD0Q5UJyfpvD7ZfwJrt1pvc4MO0Vxs60/hiYMq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749342; c=relaxed/simple;
	bh=ghH8SUs2xIYHxh69jB1Dbm04YaSfIMCLl+COIL0Gpz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mnPLd37yVRrDcBH91lG8rFK6TUsDp8G7aIRG0GvEG2099JXOfxjbadsIZX+072rP0/O+uSdWMuRpNeSa3vJxikX3BzwQe2FB4E/0bENQuZ6AAMSma7P46zoHzSZmiTnttSW6xmfRFrbjZYFgkeDtNJ+GOgI5Ck0O0c5sx2jUAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IfPmC57k; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e60f6ea262so2211866b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730749338; x=1731354138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u8WCOGgtLJgQ6p3jneGTxF+0Vn8IZil9sPC9bWx/hUU=;
        b=IfPmC57k/jUxC+ewUMzsF+Eopq//a+52aHfH0r1LYFiYHl/SgFoi4N7YuDt2QblFq7
         d9Fus5Mc8NQ5vVqCaNIL8cqgOlXQHBRmLhSXXqUaTEoqfw9Q+Ii5KzlHn1FaJNrmmbhO
         56P5xG0TG8ob1/fvBXuVCimbtZBPUWP8O4HG6JKMdI1zGYmwqkiWY86ENgkCK1yE+I4o
         kW+8CPR5+10ODQfOY9uiiJDBUXO3EcSPPZFs5LicdtXpUVFkPUQsBa42nl45NpzpDxSu
         03V8wHv5W31HrXoDqmYK7oYEeg8oQm60inPvrmp4P8NoG/mX7rBjTtcBB5at+kH99veY
         iqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749338; x=1731354138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8WCOGgtLJgQ6p3jneGTxF+0Vn8IZil9sPC9bWx/hUU=;
        b=nadUldM1lJ+UU3lI3a6yg9CBvNewDAEZC/zJmX96WCfSIY45jRdUkTopqWKVUsuFFR
         b0Ry5B3AJYVjAYInOxWgHETZErbbFMRcCLi/5Lop8F3xn4vS1P9MCo01tyZ3YbVUSE3G
         7Hldo2L6X0W//YJTpB12mEwm1eATjJGdoSl5Oh/6m9Dx3P5jhLy+pnjVwodZ4w208wpV
         NhHPcNizaPOYm0VWf7mCCLAiwPItstF4TYyuqJDBf5ZVh+6HZkfFtQJfnAHuTxfkjUvI
         uqGRiIegSOzpwLv/p8rGNy5cx2jTV6B0jp4Hk/OAt9zFHo7Lnc7fAd2TZJXJvqggpb76
         rgHg==
X-Forwarded-Encrypted: i=1; AJvYcCUwnK5cw2AekWZDfTxbsJZpz18aiqBcUDuOInaGgYit/d4YRUmt+2leab6wYBKLYL/bk+PGOyo1PDVL38k=@vger.kernel.org
X-Gm-Message-State: AOJu0YylvmBR3VzUZWCf0+g1SOiPhdc0w2SoktubafoS9Y3om8wlk0lz
	WExNQgt1o/7uuZ/wSWFuGwujapl6BVreg5lvp/lxiuWVEUp6J4Tc115KgELEHgU=
X-Google-Smtp-Source: AGHT+IGIsdqYoxeyYsizgOlVt6WZLmDTguEjzLAF/X2UOgae7OqFd8cG+ju1lnB0BdAK2oO3SpDDEg==
X-Received: by 2002:a05:6808:38ca:b0:3e6:5816:543b with SMTP id 5614622812f47-3e658165986mr19052983b6e.7.1730749338265;
        Mon, 04 Nov 2024 11:42:18 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6614673cbsm2169502b6e.10.2024.11.04.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:42:16 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 04 Nov 2024 13:42:14 -0600
Subject: [PATCH] iio: adc: ad7173: remove unused field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-iio-adc-ad7173-remove-unused-field-v1-1-da9500a48750@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJUjKWcC/x2NwQrCMBAFf6Xs2YVs0lrwV8RDyL7aBU0koUUo/
 XeDhznMZeaghmpodBsOqtitWcld5DJQWmN+gk27k3d+FHEjmxWOmjqzzIEr3mUHb3lrUF4ML2U
 E9SmGq5+cUA99Khb7/if3x3n+ALiTNkZ0AAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove the unused chan_reg field from struct ad7173_channel. This was
set but never read.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Noticed this while looking over the code.
---
 drivers/iio/adc/ad7173.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a0fca16c3be0..29ff9c7036c0 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -193,7 +193,6 @@ struct ad7173_channel_config {
 };
 
 struct ad7173_channel {
-	unsigned int chan_reg;
 	unsigned int ain;
 	struct ad7173_channel_config cfg;
 };
@@ -1316,7 +1315,6 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->address = chan_index;
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
-		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
 

---
base-commit: 56686ac80b859c2049cc372f7837470aa71c98cf
change-id: 20241104-iio-adc-ad7173-remove-unused-field-e3d2ca362501

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


