Return-Path: <linux-kernel+bounces-412822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401E9D0F83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF521F22439
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489341991DD;
	Mon, 18 Nov 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aOveGGGv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491A196C6C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928814; cv=none; b=jtnULkITPn+zoUg5qseE+E6Yjpe2/+s9zmFfkYX1BzDf8KCllyy6P71vRjZCTMewuLvsWTSO24Okb5siLqZPgE4mGTlNw2rEAs7Oro9mWPgQgqu/0DYY5edeNIAQQ/tnIABwt+9cKwk8T29i0OWIY9YYRDYoKCgcujVHoc3e3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928814; c=relaxed/simple;
	bh=gkebMvifaHHqYyg3wApsDhnNPWqEu8s40kTTe7mYLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAJt4flP9S3XlU/LzkdIINHHsExnR7PCjqhXbmjINB+PycWCXRmfxISn0xxYwis+i+oW2whcLaPO9skB8586X9KSDybejWwU7tUmeTahcvuXLE70c5bZoKQ+/XseeGXDWqgyTmwKvaLALRjeVYhhZs8n+fUA7BTyVQFOjh85+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aOveGGGv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so37242595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731928811; x=1732533611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asv+1zcPSdtmvj/jsSINOJXF2sibgY7PXKflhCuFup4=;
        b=aOveGGGvoNZ0O1eTy9ZV8x1nd207pxAH+TQTN6Zr7InPAIMK5jFI4ZOPj9Oq6VxefQ
         3ZXXz+MKbFbdEHSXyIDW56SfYa/yl4SDfca+i33F0jwmTX77XAihv+jJAOvsLNKP0XSR
         Y4NKk2KnavF0JeO2b8q69UmOY8ITyzTUGSQA1SjVWhSc3eWC9hQUP1u5ANXMPgzI4lDM
         99hgdWeejbOD6oPxKMXk0EL5EL7O4LeCiIA1LKkUO84Yw3sI4Bv/O1aEg9Gx8uPpaXTC
         /LdjOy6/OnKO0Kq2+FaDhSTvnXd1/klOg26wAeh++dkpOplJ7PNsmzHB9VS+puucCxsR
         ON0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928811; x=1732533611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asv+1zcPSdtmvj/jsSINOJXF2sibgY7PXKflhCuFup4=;
        b=lFid7vH06VasdvCxtqMXbcGY6Ne2JOOeG4M0GVsGvw6eQ2bEU5uzaDEt4DszAvjT2q
         sryEgPEGoHPjamBK57zQewpnKI03YISL74NNC1wOMwuKUUVQxAZX3ON7yLPszdn5469j
         LGw+6UZSGjrcdtGYxJVUpPpEyixQ/rk1LfpBD6WCQtopHb+TxusEAKUi2KHpE1Wj+hkY
         fwbR5ZY2dAIsi9vABfTsNWLJkwI+kepm/zVpeprOux8ixNQNBtB16WwkDhtqVJtXyBJF
         m9opKyTwxuGnw4i+sRR0CeGZr07kTlvV0z3CTSmg+yaNxAhH5kUqEV+sipxQtopUBkSX
         IooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEojEmuIdVQ7r2jAsZZh4upb9nj+BRqTADiYcXv9CbGyi8oqWv4159YjPnStt1HAofFDoKXpIrf/KYQkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucwDjCX9y/EQvt0gc1EOrPQsMu29uZiTA91ttFc8squJgvw/i
	Q7ME9TkgV/z/vMZQiFNrcfsFHpBGOYLb02AHwLo559mHF1BYrW7gzNZlPywzg58=
X-Google-Smtp-Source: AGHT+IG8WB54uuUl8Kw673I1UaAQsV/m9AUVgJQSJZ7e5WATQjmgWaIOnj9DxIM7Tr7wJGPWfVKJVg==
X-Received: by 2002:a05:6000:1544:b0:37d:393a:97c5 with SMTP id ffacd0b85a97d-38225a059a1mr9276421f8f.28.1731928811238;
        Mon, 18 Nov 2024 03:20:11 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824af06e02sm517377f8f.32.2024.11.18.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:20:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ad7124: Refuse invalid input specifiers
Date: Mon, 18 Nov 2024 12:19:56 +0100
Message-ID:  <b083836da51827154a0a215d6e9910da71eb1aab.1731404695.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1731404695.git.u.kleine-koenig@baylibre.com>
References: <cover.1731404695.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gkebMvifaHHqYyg3wApsDhnNPWqEu8s40kTTe7mYLOw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnOyLfGsCIByaVZGarVHFl3mkS+B0/j1LFfwxB1 8fYuZZ1IT+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzsi3wAKCRCPgPtYfRL+ Ts+bCACIz+mk+hqNkhtGHLZ6hP8yd0qzFgyJFsUKKkzO536lI8s6cM4YJbIpKlRBwMrlDULO0Nk W6FItS/1LvFpl35M6Ea3q8CiZhf4W7CRKrQqxGzpGYis/jBD79JQXQAIUm5211E7yRJz1adqSwA +sKLNn1aZKg0uCJmQY25DtAnXcm1L8oVeXxLYp/cYHJ7bec5ea8Kn/2aL8RhTyccE7K07BF+x2k Tw2lXhP0I7yR12eLck5B7bCtA+aOjzkGhQ4Z/3vejJNjkOyq9NM9+tgTMzEnU7yq5DRCgN8g7Hm wL9JCgOcR39Zp5/qVMyWBn7ODUZyjNXbpS7LEuo1p/VOZ2+B
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 has 8 analog inputs; the input select values 8 to 15 are
reserved and not to be used. These are fine for ad7124-8. For both
ad7124-4 and ad7124-8 values bigger than 15 are internal channels that
might appear as inputs in the channels specified in the device
description according to the description of commit f1794fd7bdf7 ("iio:
adc: ad7124: Remove input number limitation"), values bigger than 31
don't fit into the respective register bit field and the driver masked
them to smaller values.

Check for these invalid input specifiers and fail to probe if one is
found.

Fixes: f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4de69bb8653a..bfeec59e33ba 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -807,6 +807,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+/*
+ * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
+ * while they are fine for ad7124-8. Values above 31 don't fit
+ * into the register field and so are invalid for sure.
+ */
+static bool ad7124_valid_input_select(unsigned int ain, const struct ad7124_chip_info *info)
+{
+	if (ain >= info->num_inputs && ain < 16)
+		return false;
+
+	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM_MSK);
+}
+
 static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
@@ -859,6 +872,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
+		    !ad7124_valid_input_select(ain[1], st->chip_info))
+			return dev_err_probe(dev, -EINVAL,
+					     "diff-channels property of %pfwP contains invalid data\n", child);
+
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
-- 
2.45.2


