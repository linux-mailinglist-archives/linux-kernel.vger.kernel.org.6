Return-Path: <linux-kernel+bounces-203019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577A28FD515
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CBB28804F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC214D2BB;
	Wed,  5 Jun 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2X6l/Cn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378B149C63
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610571; cv=none; b=S18uwpW4JnorA2FpMdp/MVVKmiraCYIxUaYAKnqyQFypCLJD0RAqlB6V3Qp8NRZ9Xcxuz8U9vocG5Hf5o5Qn2G63PXdNSaLmbSZMi+8FIv7r3htJEOcMq4nj/Ad+MzjuHVboN5Uym0T1mmzFzJTW7e7YCyOBZUu3X9N9+YeLaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610571; c=relaxed/simple;
	bh=L6k+G2m+3j3md7/zl4VB2q4oF1PIwiQxOqm6LYJmtKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gerZw+tV+pyDVUhP8FnahWSkndWs7h2ZL97XMSCoYTJ7w99MZ6ZPJXZRGneec6DsCSMchkJoDoy7mEGJMTx0sFnfsSqGusuBcWcoyjUzR3Fa3T9KmZbpOphKRhzHfC3S6cDPlE28lEGsfmt7WoM+7V8Gj1M6ShKjwcvokRp9OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2X6l/Cn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a0841402aso266267b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717610569; x=1718215369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUTCTG4PiwJpsjy0QKETkEiNDEwH04EYXsIQhajeZMg=;
        b=u2X6l/CnJHRqsHZ+uqWAuBZR2EDxEE7VQOHBGEJWO82zvjwXqD7qJxXBn9P3wlYn/S
         P4vKe/yG01XKq16yIxYARa/A+s6Mv7WqHlVYjACiA/gDL9Faq/QdOyj9IOzHvlkSJJ+o
         503leGdALXnNTEdpjvOLYNt/GC44iG3fAc0ebZGxR12mgtPkH0ZXYmeFilrL6GAE64+0
         8KFTsXahDn8y7qdHAv9bIAnBQMMV288ZcMOQh+ZTq5vbDThXjxT0KVce2mqe2CIc/nK4
         BIUj+z4Ox71qKxUxvQTViK8c80aQX7iytCFYkqYku39TU847AsFpxldfDH73MxlqBpSi
         gEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610569; x=1718215369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUTCTG4PiwJpsjy0QKETkEiNDEwH04EYXsIQhajeZMg=;
        b=jFljwgAktXKfQw+fIpQWkhGuurKPH0dZLgsSsRG7rf1hYYTKDiUkZBjmbh71vL7yfa
         kg6a7RHz1FafjnP9r+5CIovYcr4XihGkJrZ0F647YUyIU4Zxzu4VKXrPYOi9r2uUy8+b
         dUzdrq5q6aT+oyYujtdHSMJZXJ50h8y9WWquDKiO2XAXdC3Vm8oS7t+4Jx7NpbecoEwO
         D2Aiypx29cqMrga4M5pU17QJfc1idh8+UUdsmIuzVkjZblcKZmT1a2cORxOZMuRX+DQp
         XqpkLMEt4x7GclSVmZ64wYUhwLaK6SWVo8ExX+StGiKeDgo3S0I7kHUGRxuJE/xnmHox
         iY2w==
X-Forwarded-Encrypted: i=1; AJvYcCWzTR0cOJrXDHU0daqlNM2UJRh3IBBFOwMUvhbyqzkVPd3T/G7XfoyrNibbYnvGYsKodDLWkTwnaHGSTV0GLk1BjOg7nRYdOTP2/VH1
X-Gm-Message-State: AOJu0Yw9+qa4F7uqnH3iEOhT2Y5H7J2Aa1vD7M9rsf7T7Q7K7QrN53xZ
	X5/a2oqyOMBmYedaalF5/1QWjNnw3uZo0NU0El/Z6Zsunkpay2UMYdu0xnSJXO1fIfTVuAB5KDM
	2U+ckP6HXAQ==
X-Google-Smtp-Source: AGHT+IGRE1l9odt4GG6RaI8M/uHdLkQEjh5Taz0VKgQ269YOTeE9TiCNJPVhuqv1Ry405YEIQ6hIdx0yWPVe/Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:4c07:0:b0:62a:415b:a137 with SMTP id
 00721157ae682-62cbb4a2295mr5047937b3.1.1717610568813; Wed, 05 Jun 2024
 11:02:48 -0700 (PDT)
Date: Wed,  5 Jun 2024 18:02:32 +0000
In-Reply-To: <20240605180238.2617808-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605180238.2617808-1-joychakr@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605180238.2617808-2-joychakr@google.com>
Subject: [PATCH v1 11/17] mtd: ubi: nvmem: Change nvmem reg_read/write return type
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change nvmem read/write function definition return type to ssize_t.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/mtd/ubi/nvmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
index 8aeb9c428e51..eab14821343d 100644
--- a/drivers/mtd/ubi/nvmem.c
+++ b/drivers/mtd/ubi/nvmem.c
@@ -20,8 +20,8 @@ struct ubi_nvmem {
 	struct list_head list;
 };
 
-static int ubi_nvmem_reg_read(void *priv, unsigned int from,
-			      void *val, size_t bytes)
+static ssize_t ubi_nvmem_reg_read(void *priv, unsigned int from,
+				  void *val, size_t bytes)
 {
 	size_t to_read, bytes_left = bytes;
 	struct ubi_nvmem *unv = priv;
@@ -55,7 +55,7 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
 	if (err)
 		return err;
 
-	return bytes_left == 0 ? 0 : -EIO;
+	return bytes - bytes_left;
 }
 
 static int ubi_nvmem_add(struct ubi_volume_info *vi)
-- 
2.45.1.467.gbab1589fc0-goog


