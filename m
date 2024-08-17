Return-Path: <linux-kernel+bounces-290770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B501955863
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8F728188C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B3BA33;
	Sat, 17 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bUaz2I/8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7955256
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723905421; cv=none; b=DAGevupPU5yR1ijcYkX+pVDhZg8qyQyqIARY0ZMC97Wfh6ZU+TcOi56nbNC6tWRqdZ9JT/V0ir+17y5MMUBggUaqwa3+fOMZyJpz+H3mjNY00iUMSNI3WqxQEVgo/uEK6U+QTRzMiABnbG2vQoSWeBfVI7pab94GwYFhr1TNxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723905421; c=relaxed/simple;
	bh=AgZkjTczEFd62yuqkbBbC5Z2vbFEzvDMtqf4z8mAx6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he6rYKyJoaQe4XQYoD0Aq7d+OE7zijGTRkDuTqNpoCoiKO+sspIkpuif7OyI5kelJwQgz4SDEwOB0khnIwznDBdsy6+80UVKEmUvZ1FD31XD2IMdtEZlzbgeGtko5pVWvW/m7L9Tegt2uVsaDurcUQQ1RTQrkyS8gvQjeMoNnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bUaz2I/8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bec4c3ace4so389784a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723905418; x=1724510218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al+SmtU+sIIwFr4jQDcTO2Drgn6PFlBI5eq4W/6i2T0=;
        b=bUaz2I/8xBodmvNFF7Oaq2cJguW9BV1kc9oJYvhEZRXDwct7Xdp1VPXndnOIWoY4lf
         B7Z3W43nU+ApR31cI3MpgAwOQ2tw6+wJPSbc2Gr8MnJVT6WLpmPWnByaTdyjMsNvRJ6x
         s6QXz+mBkRW2xhqXoS/3EAYW0VmGQEA5+o9mx6o1JoqmzE0lrjXV6V9CA0PE3oeQkWuB
         hwN/nA5xh+2AwSsc3g6mLhk/wRYqlayPi8LTZDhlTCfz1wYUn7gdf5hqtmv29JgXG/an
         vsV5WN5fHWIf4b9ZHA6OHig7IwDjDh8igYzLcR9ETbeLGhUX2/9YZvHJnM00NbJI0oBK
         JUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723905418; x=1724510218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al+SmtU+sIIwFr4jQDcTO2Drgn6PFlBI5eq4W/6i2T0=;
        b=AnPnAplknrx6kRv0whw+vA1qyO94wwXqr0SrNbDiQqde+XUiXkLQ5CJ+AadVBZ5cE2
         geD7F6UBbpkdpMaKWJcVTQ0qBrCm3CQnKjVt7EfmHf2mrWvi4f/+ECeeE1dlmuJoS+WZ
         850U1hJDdDh36lDN40PeY7aGhO/B9EJSPb2lfj8f006piglt6GoMMP2bnXQyLWb0kqQU
         Vd2aWZ9QA4ECEUKo3Ub3DmrCNFdqdTK3YSsccprw8HRlKnzIdQMYf/MHFDzudjF49WAC
         9hoM5n60e1q4ws5LKu5fsiaSDkUhGtHA5RjxAtNiCgN3YJIEc1Gou1ZILKkXAMPqB7SM
         AmSg==
X-Forwarded-Encrypted: i=1; AJvYcCUqcKSDoYOEXOl4qxHOgrIbw8NgfTF7OSpy2Pn3K2kFuyLZjfOGH14g63qeRrVr/BCANABkfU58/qrUYkyoOP4NMqTvRrG7Mtq7o/o1
X-Gm-Message-State: AOJu0YyzrVAY6w86HUJ2ks1oCob+2rXpInl8CXu/xnzmexq8nhcaCLdY
	t37dijRpUVosIXFsS3OcFDUcQp5pCYpk/tbkC733ihsnI7NrY8m+N2xMUiq9srM=
X-Google-Smtp-Source: AGHT+IGXfJ5EzbcdgJZ4wHtZcC561IG3+5+VwIwevWbFKrMqVIbwwgqjQ8Fig1iwUAxR5oDeuAxQrg==
X-Received: by 2002:a17:907:9709:b0:a80:ed79:a0d9 with SMTP id a640c23a62f3a-a839254db5fmr211834866b.0.1723905417295;
        Sat, 17 Aug 2024 07:36:57 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946898sm410376866b.174.2024.08.17.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:36:56 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	Michael.Hennerich@analog.com,
	lars@metafoo.de,
	gstols@baylibre.com,
	nuno.sa@analog.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2] iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
Date: Sat, 17 Aug 2024 17:36:47 +0300
Message-ID: <20240817143647.15998-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240817142257.14470-1-aardelean@baylibre.com>
References: <20240817142257.14470-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
samples.
But when going to 18-bit samples, these need to be implemented as 32-bit
(or int) type.

In that case when getting samples (which can be negative), we'd get random
error codes.
So, the easiest thing is to just move the 'val' pointer to
'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
preparation for 18-bit ADCs (of the AD7606 family).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dba1f28782e4..68481e97e50a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
+			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
@@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
-		ret = st->data[ch];
+		*val = (short)st->data[ch];
 
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
@@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ad7606_scan_direct(indio_dev, chan->address);
+			ret = ad7606_scan_direct(indio_dev, chan->address, val);
 			if (ret < 0)
 				return ret;
-			*val = (short) ret;
 			return IIO_VAL_INT;
 		}
 		unreachable();
-- 
2.46.0


