Return-Path: <linux-kernel+bounces-235054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB4291CEFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE7C1F21B60
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F691420D8;
	Sat, 29 Jun 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKVENcZQ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558113D63B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719691918; cv=none; b=GPJ2D/y/J1Hjfv7k6/zDod9AMNEfCMw4fGvhLaHwz/berwAVXT0ldn4PkPxbBSdRf17HTEKD/ns2uIdXRXf77C019hkJJ6vLYmI1q/F5kdvZbWANSOX+vyk0WYSYzVpFw+8oyGHl7x7zpKyB9sj5hoGZz0RBWWai5xiB99n82S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719691918; c=relaxed/simple;
	bh=ESotLoXsNrZtzGn654TkPeHEvnv5aQNGIkKAJcGVsiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsONKMZe4Rzknsm/XInjwPLqCvkE8eIt3eNFQgmAHNn+Y5d7VjTHMbTP4+UqwOF9DC1THHsYTOIUfPym+u7Vytf+C8dW1oJCuCmYSJE/cB71V9iBeG3WeNQlv7VmWxpHb1VOrD+qHG7MLTnYoYVp4JEB8VaKGk5lM4j74s8CWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kKVENcZQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c7ecfc9e22so1124418a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719691915; x=1720296715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6gXkkvOQsZdR3iCBrXw4yQXuOdkO+dmph8wMsg5U48=;
        b=kKVENcZQ2FHQkUuziuCgIx5lfr1XixYCehjk3CcMbmP59K58TYcEnLmLWe/o2GMHo5
         +yTm13O82d1cKo385f5baS4KQDtDwyFCctpPrQhnk234+fSf4stDMx8RDyWVGeGL3lGZ
         gD99oiIv2hZtOMjbBI6kPbzrKyz4PR7kKcwBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719691915; x=1720296715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6gXkkvOQsZdR3iCBrXw4yQXuOdkO+dmph8wMsg5U48=;
        b=fRXmcrGm28HlsRJNamzT1np7vb/z3cx7ks5fqpbu0C9J2VOpER8hbORDAGuJnBUXhe
         u4n9BvyoIQr8F3EpRqcz4MDMnywRzYBOnKQDGcKkJ+uycdHXmSYMMo2jMJCms2dj5Ljs
         osgJIFYW4zJo+aToKWJQMjHZ2HUVm2VOlQgqW26i6EHedj1sMHKD5OdBwL0AKPBKccI+
         vSMYD0Mdv9xo8eJ96drBQ451N00OAR1XXCfKTRWBhyO3mADuiiEgHnHOOrM91lbjcoNb
         qZbtDzwKuOZvBTFvqIVzvwyqX82p9QK7gKw/WvIztoxrqWFhMttiJzateYDgkIrhvYOP
         c2IA==
X-Forwarded-Encrypted: i=1; AJvYcCVbjcrHvvLYZP4jyM7/5zhTJP0E4WG4koQ6YpdTVUmzqQIQo5dtrPtusFLS9DhltaGBX1yfipzMSUBkHihYIKJPte3W2LuzvPURpZ/6
X-Gm-Message-State: AOJu0YxTUxB7l5JhTobP8Ik2RUS/1JTLaSaH10cF4CYXed7rc1nS98Y6
	8W33YCBrDYoekbtUS2m9Pp+SR7pskg6UGbTesMJijr2jkZBnUTk+08YqZkw6Aw==
X-Google-Smtp-Source: AGHT+IHWQr/7P2OBwhOgpMSPBJwP0koqYdnGoVEyPs2WUFbA2igthn+SEjjqMNEJQUqmLOG4Tc6YFg==
X-Received: by 2002:a17:90b:1245:b0:2bf:7eb7:373b with SMTP id 98e67ed59e1d1-2c93d771ce7mr836216a91.33.1719691915472;
        Sat, 29 Jun 2024 13:11:55 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:db78:5dbf:8bdd:601d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce43460sm3750412a91.20.2024.06.29.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 13:11:55 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Daisuke Nojiri <dnojiri@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v6 1/2] cros_ec_proto: Consolidate ec_response_get_next_event
Date: Sat, 29 Jun 2024 13:11:30 -0700
Message-ID: <2b1d7ea765747f570d80ae0a37feb77cb4f1b140.1719691604.git.dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <cover.1719691604.git.dnojiri@chromium.org>
References: <cover.1719691604.git.dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate struct ec_response_get_next_event_v*.

Let X->Y indicate kernel X sending EC_CMD_GET_NEXT_EVENT to FW Y.

Old->New:
   Existing kernels send a smaller container (e.g.
   ec_response_get_next_data) which may or may not fit the last few
   bytes. The FW copies as many bytes as possible to the container. The
   kernel processes as many leading bytes as it can understand.

New->Old:
   New kernels send a bigger container. Existing FW copies as many bytes
   as it wants, leaving the last few bytes empty. The kernel knows it
   didn't receive full size data from the returned data length.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c       | 16 ++++-----
 drivers/platform/chrome/cros_ec_proto_test.c  | 28 +++++++--------
 .../linux/platform_data/cros_ec_commands.h    | 34 +------------------
 include/linux/platform_data/cros_ec_proto.h   |  2 +-
 4 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 945b1b15a04c..a849c29f125b 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -686,7 +686,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
-			       struct ec_response_get_next_event_v1 *event,
+			       struct ec_response_get_next_event *event,
 			       int version, uint32_t size)
 {
 	int ret;
@@ -709,11 +709,11 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 {
 	struct {
 		struct cros_ec_command msg;
-		struct ec_response_get_next_event_v1 event;
+		struct ec_response_get_next_event event;
 	} __packed buf;
 	struct cros_ec_command *msg = &buf.msg;
-	struct ec_response_get_next_event_v1 *event = &buf.event;
-	const int cmd_version = ec_dev->mkbp_event_supported - 1;
+	struct ec_response_get_next_event *event = &buf.event;
+	int cmd_version = ec_dev->mkbp_event_supported - 1;
 
 	memset(msg, 0, sizeof(*msg));
 	if (ec_dev->suspended) {
@@ -721,12 +721,12 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 		return -EHOSTDOWN;
 	}
 
-	if (cmd_version == 0)
-		return get_next_event_xfer(ec_dev, msg, event, 0,
-				  sizeof(struct ec_response_get_next_event));
+	/* The max version we support is v3 */
+	if (cmd_version > 3)
+		cmd_version = 3;
 
 	return get_next_event_xfer(ec_dev, msg, event, cmd_version,
-				sizeof(struct ec_response_get_next_event_v1));
+				   sizeof(*event));
 }
 
 static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index b6169d6f2467..4d5306ea27e4 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2072,17 +2072,17 @@ static void cros_ec_proto_test_get_next_event_no_mkbp_event(struct kunit *test)
 
 	/* For get_keyboard_state_event(). */
 	{
-		union ec_response_get_next_data_v1 *data;
+		union ec_response_get_next_data *data;
 
 		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 
-		data = (union ec_response_get_next_data_v1 *)mock->o_data;
+		data = (union ec_response_get_next_data *)mock->o_data;
 		data->host_event = 0xbeef;
 	}
 
 	ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
-	KUNIT_EXPECT_EQ(test, ret, sizeof(union ec_response_get_next_data_v1));
+	KUNIT_EXPECT_EQ(test, ret, sizeof(union ec_response_get_next_data));
 
 	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_KEY_MATRIX);
 	KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.host_event, 0xbeef);
@@ -2097,7 +2097,7 @@ static void cros_ec_proto_test_get_next_event_no_mkbp_event(struct kunit *test)
 
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
 		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MKBP_STATE);
-		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(union ec_response_get_next_data_v1));
+		KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(union ec_response_get_next_data));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 }
@@ -2182,18 +2182,18 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_version2(struct kunit *
 
 	/* For get_next_event_xfer(). */
 	{
-		struct ec_response_get_next_event_v1 *data;
+		struct ec_response_get_next_event *data;
 
 		mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 
-		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data = (struct ec_response_get_next_event *)mock->o_data;
 		data->event_type = EC_MKBP_EVENT_FINGERPRINT;
 		data->data.sysrq = 0xbeef;
 	}
 
 	ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
-	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event_v1));
+	KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event));
 
 	KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_FINGERPRINT);
 	KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.sysrq, 0xbeef);
@@ -2209,7 +2209,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_version2(struct kunit *
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
 		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
-				sizeof(struct ec_response_get_next_event_v1));
+				sizeof(struct ec_response_get_next_event));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 }
@@ -2221,7 +2221,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc(struct k
 	struct ec_xfer_mock *mock;
 	int ret;
 	bool wake_event;
-	struct ec_response_get_next_event_v1 *data;
+	struct ec_response_get_next_event *data;
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
@@ -2238,7 +2238,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc(struct k
 						   sizeof(data->data.host_event));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 
-		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data = (struct ec_response_get_next_event *)mock->o_data;
 		data->event_type = EC_MKBP_EVENT_HOST_EVENT;
 		put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC), &data->data.host_event);
 	}
@@ -2258,7 +2258,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc(struct k
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
 		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
-				sizeof(struct ec_response_get_next_event_v1));
+				sizeof(struct ec_response_get_next_event));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 }
@@ -2270,7 +2270,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struc
 	struct ec_xfer_mock *mock;
 	int ret;
 	bool wake_event;
-	struct ec_response_get_next_event_v1 *data;
+	struct ec_response_get_next_event *data;
 
 	ec_dev->max_request = 0xff;
 	ec_dev->max_response = 0xee;
@@ -2287,7 +2287,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struc
 						   sizeof(data->data.host_event));
 		KUNIT_ASSERT_PTR_NE(test, mock, NULL);
 
-		data = (struct ec_response_get_next_event_v1 *)mock->o_data;
+		data = (struct ec_response_get_next_event *)mock->o_data;
 		data->event_type = EC_MKBP_EVENT_HOST_EVENT;
 		put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED),
 				   &data->data.host_event);
@@ -2308,7 +2308,7 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struc
 		KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
 		KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
 		KUNIT_EXPECT_EQ(test, mock->msg.insize,
-				sizeof(struct ec_response_get_next_event_v1));
+				sizeof(struct ec_response_get_next_event));
 		KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
 	}
 }
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 070e49c5381e..00c06c130dd5 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3475,32 +3475,7 @@ enum ec_mkbp_event {
 BUILD_ASSERT(EC_MKBP_EVENT_COUNT <= EC_MKBP_EVENT_TYPE_MASK);
 
 union __ec_align_offset1 ec_response_get_next_data {
-	uint8_t key_matrix[13];
-
-	/* Unaligned */
-	uint32_t host_event;
-	uint64_t host_event64;
-
-	struct __ec_todo_unpacked {
-		/* For aligning the fifo_info */
-		uint8_t reserved[3];
-		struct ec_response_motion_sense_fifo_info info;
-	} sensor_fifo;
-
-	uint32_t buttons;
-
-	uint32_t switches;
-
-	uint32_t fp_events;
-
-	uint32_t sysrq;
-
-	/* CEC events from enum mkbp_cec_event */
-	uint32_t cec_events;
-};
-
-union __ec_align_offset1 ec_response_get_next_data_v1 {
-	uint8_t key_matrix[16];
+	uint8_t key_matrix[18];
 
 	/* Unaligned */
 	uint32_t host_event;
@@ -3525,7 +3500,6 @@ union __ec_align_offset1 ec_response_get_next_data_v1 {
 
 	uint8_t cec_message[16];
 };
-BUILD_ASSERT(sizeof(union ec_response_get_next_data_v1) == 16);
 
 struct ec_response_get_next_event {
 	uint8_t event_type;
@@ -3533,12 +3507,6 @@ struct ec_response_get_next_event {
 	union ec_response_get_next_data data;
 } __ec_align1;
 
-struct ec_response_get_next_event_v1 {
-	uint8_t event_type;
-	/* Followed by event data if any */
-	union ec_response_get_next_data_v1 data;
-} __ec_align1;
-
 /* Bit indices for buttons and switches.*/
 /* Buttons */
 #define EC_MKBP_POWER_BUTTON	0
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8865e350c12a..a795fe260a38 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -185,7 +185,7 @@ struct cros_ec_device {
 	bool host_sleep_v1;
 	struct blocking_notifier_head event_notifier;
 
-	struct ec_response_get_next_event_v1 event_data;
+	struct ec_response_get_next_event event_data;
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
-- 
2.45.2.803.g4e1b14247a-goog


