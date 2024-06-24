Return-Path: <linux-kernel+bounces-227704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909119155B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A1D1F2457D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4E19E83E;
	Mon, 24 Jun 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXfKQ5gY"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3519F47C;
	Mon, 24 Jun 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251191; cv=none; b=EpPwXUQzCbROArYttXMedrEi21Td8I9d5EzBq9nCMLD4qljVm5LYYyiTd/zn8K+/JkCJMS/+YeveULrfgKP+aHGAeOdlmb+gD2bYaXDEtN8BhEZi1DaJZD6CCcvvNVXHY0HOV/RII06FubkrWB7WLyGJm2bmctEEgJmwJ+HnbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251191; c=relaxed/simple;
	bh=p9OSa2J+J61U4skMpTA3cbTTUVpHDeNkIwWDyqHX8mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dv76SURzThESE5dzb+zPfwj3LCALKR9KIX04SqTArSeqP3PHYt4A2NGPkdHQi1DYm60YrWbPJNDWIwMW7h8vGGdUSEmCTEaVx4F11FrMcKSUS1IeE7EQSTcABJJcyynsTvypg2ASy84fcJ98ETX7ukwOO98NXbXedJ3JfbRl0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hXfKQ5gY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jic23@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719251187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqOkN6IUDIXk9Ibe53TqX76Qt4EwVJgv68G4Bznvn6Q=;
	b=hXfKQ5gYYKr+KlXMgt1ZUXk7HwgZDDl/ULzron+ysYdbVrF2c8epe+auqRfapYCOs1QZ0h
	Lq1rXbK2NQHFeRoTPed5q3zKjYulOzrl3i4ubgW/QRxkMfrcKC7jREvBW+JtRRmgn8Gr3U
	C04dhHl074Fy9hJKIYsoF9vRmN6pinc=
X-Envelope-To: jdelvare@suse.com
X-Envelope-To: linux@roeck-us.net
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-hwmon@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
Date: Mon, 24 Jun 2024 13:46:01 -0400
Message-Id: <20240624174601.1527244-3-sean.anderson@linux.dev>
In-Reply-To: <20240624174601.1527244-1-sean.anderson@linux.dev>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add labels from IIO channels to our channels. This allows userspace to
display more meaningful names instead of "in0" or "temp5".

Although lm-sensors gracefully handles errors when reading channel
labels, the ABI says the label attribute

> Should only be created if the driver has hints about what this voltage
> channel is being used for, and user-space doesn't.

Therefore, we test to see if the channel has a label before
creating the attribute.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Check if the label exists before creating the attribute

 drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 4c8a80847891..5722cb9d81f9 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -33,6 +33,17 @@ struct iio_hwmon_state {
 	struct attribute **attrs;
 };
 
+static ssize_t iio_hwmon_read_label(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
+	struct iio_hwmon_state *state = dev_get_drvdata(dev);
+	struct iio_channel *chan = &state->channels[sattr->index];
+
+	return iio_read_channel_label(chan, buf);
+}
+
 /*
  * Assumes that IIO and hwmon operate in the same base units.
  * This is supposed to be true, but needs verification for
@@ -68,12 +79,13 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct iio_hwmon_state *st;
 	struct sensor_device_attribute *a;
-	int ret, i;
+	int ret, i, attr = 0;
 	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
 	struct device *hwmon_dev;
 	char *sname;
+	void *buf;
 
 	channels = devm_iio_channel_get_all(dev);
 	if (IS_ERR(channels)) {
@@ -85,17 +97,18 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	}
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-	if (st == NULL)
+	buf = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!st || !buf)
 		return -ENOMEM;
 
 	st->channels = channels;
 
-	/* count how many attributes we have */
+	/* count how many channels we have */
 	while (st->channels[st->num_channels].indio_dev)
 		st->num_channels++;
 
 	st->attrs = devm_kcalloc(dev,
-				 st->num_channels + 1, sizeof(*st->attrs),
+				 2 * st->num_channels + 1, sizeof(*st->attrs),
 				 GFP_KERNEL);
 	if (st->attrs == NULL)
 		return -ENOMEM;
@@ -147,9 +160,31 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		a->dev_attr.show = iio_hwmon_read_val;
 		a->dev_attr.attr.mode = 0444;
 		a->index = i;
-		st->attrs[i] = &a->dev_attr.attr;
+		st->attrs[attr++] = &a->dev_attr.attr;
+
+		/* Let's see if we have a label... */
+		if (iio_read_channel_label(&st->channels[i], buf) < 0)
+			continue;
+
+		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
+		if (a == NULL)
+			return -ENOMEM;
+
+		sysfs_attr_init(&a->dev_attr.attr);
+		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+						       "%s%d_label",
+						       prefix, n);
+		if (!a->dev_attr.attr.name)
+			return -ENOMEM;
+
+		a->dev_attr.show = iio_hwmon_read_label;
+		a->dev_attr.attr.mode = 0444;
+		a->index = i;
+		st->attrs[attr++] = &a->dev_attr.attr;
 	}
 
+	devm_free_pages(dev, (unsigned long)buf);
+
 	st->attr_group.attrs = st->attrs;
 	st->groups[0] = &st->attr_group;
 
-- 
2.35.1.1320.gc452695387.dirty


