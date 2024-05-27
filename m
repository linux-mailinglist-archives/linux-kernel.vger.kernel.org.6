Return-Path: <linux-kernel+bounces-190184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A472F8CFAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6024F281C96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23183A8D0;
	Mon, 27 May 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="glRPCfaZ"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2594594D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796907; cv=none; b=Do2mtFBgeUYL7i58Etpqbck6Axl3r/pEEi50MIEJvWiepf0PNWJklLoYo+8yysx+gYHX52i8od9tZlMhvBJwQfQsDxoUldd+cSzXyWfO8ACe3r4aqWoUX8I+yaWXGuDOVne9VUCyWAQu2JlGPtk/upbWd6gy7FwkuFKThmqRTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796907; c=relaxed/simple;
	bh=Jkpr43X/qDFxJGmKqmQgShXrBkBVcEw/3bJPwmjpF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1yTW8888gSMM8ZKlMOaZTDsDPv8DpZU/AiKUZe4IePuUlGFAuygsZbYF1nk2e/JGWotkJ5rwY7T2t2RBpOGa/zxLYBxLWWuvE7E7QWcMQJSe+SC/eK0M+OnoJoZLoYLTvNs6gePq/zuQC7CPzKiDgjdeGCnjZKQH1m3lm7aumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=glRPCfaZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716796901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eMc9oQ4YVYpAx8gh5q0mqb2/rcNUyELqBXOxKDT4IhA=;
	b=glRPCfaZfsOQk2KMlum9Ys/c4ChI8IwVLsJNQknIDDSL9PnDCpjjeDtaJddOebaIYhpOYa
	oup6lF4RomW3VH/pX8fFHODKQHMEASOv9awbgimT88yAndaMKXLoaXIuTps3iO0RoogLqU
	ENBT8geFuYNp8PtI2qDeMDraUTHUSTJviDv6+bKfV9pXAIR8x5ey54+4eQsbz3YFHhWyw4
	NoZKFTS8Z1DqbLGUqlKiNdYF3KrFDteqlBVu+Fayj08F2VwEgIqDDyn+U2aNPCW1BXD1Mj
	myVpATMESHA+nXhQjYzCb/65azOOXRpzyr2MCASdj0pyRi5A7tQCK1lm2n0L9g==
X-Envelope-To: jic23@kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma7660: add mount-matrix support
Date: Mon, 27 May 2024 05:00:18 -0300
Message-ID: <20240527080043.2709-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow using the mount-matrix device tree property to align the
accelerometer relative to the whole device.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/iio/accel/mma7660.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 260cbceaa..9d23f28d5 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -38,21 +38,6 @@
 
 static const int mma7660_nscale = 467142857;
 
-#define MMA7660_CHANNEL(reg, axis) {	\
-	.type = IIO_ACCEL,	\
-	.address = reg,	\
-	.modified = 1,	\
-	.channel2 = IIO_MOD_##axis,	\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-}
-
-static const struct iio_chan_spec mma7660_channels[] = {
-	MMA7660_CHANNEL(MMA7660_REG_XOUT, X),
-	MMA7660_CHANNEL(MMA7660_REG_YOUT, Y),
-	MMA7660_CHANNEL(MMA7660_REG_ZOUT, Z),
-};
-
 enum mma7660_mode {
 	MMA7660_MODE_STANDBY,
 	MMA7660_MODE_ACTIVE
@@ -62,6 +47,21 @@ struct mma7660_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	enum mma7660_mode mode;
+	struct iio_mount_matrix orientation;
+};
+
+static const struct iio_mount_matrix *
+mma7660_get_mount_matrix(const struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	struct mma7660_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mma7660_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mma7660_get_mount_matrix),
+	{ }
 };
 
 static IIO_CONST_ATTR(in_accel_scale_available, MMA7660_SCALE_AVAIL);
@@ -75,6 +75,22 @@ static const struct attribute_group mma7660_attribute_group = {
 	.attrs = mma7660_attributes
 };
 
+#define MMA7660_CHANNEL(reg, axis) {	\
+	.type = IIO_ACCEL,	\
+	.address = reg,	\
+	.modified = 1,	\
+	.channel2 = IIO_MOD_##axis,	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = mma7660_ext_info,				\
+}
+
+static const struct iio_chan_spec mma7660_channels[] = {
+	MMA7660_CHANNEL(MMA7660_REG_XOUT, X),
+	MMA7660_CHANNEL(MMA7660_REG_YOUT, Y),
+	MMA7660_CHANNEL(MMA7660_REG_ZOUT, Z),
+};
+
 static int mma7660_set_mode(struct mma7660_data *data,
 				enum mma7660_mode mode)
 {
@@ -187,6 +203,10 @@ static int mma7660_probe(struct i2c_client *client)
 	mutex_init(&data->lock);
 	data->mode = MMA7660_MODE_STANDBY;
 
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
+
 	indio_dev->info = &mma7660_info;
 	indio_dev->name = MMA7660_DRIVER_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.45.1


