Return-Path: <linux-kernel+bounces-199885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FA8FA73A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68845288B48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7879F9;
	Tue,  4 Jun 2024 00:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n4WtB8Z7"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D56FBF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462481; cv=none; b=WHmvt6ImMlxy5xrvi+8JP3xFxTBECt1zZwV2DSN47HR+y6bFeQLinXnuGeJaXaQz9tuWSn8sNI/h5XVx+/bLN10ceNmd//zW3dk+Wiz30JELBk9zZA8yc24dQWwXCpShxNLx6Rbh+ZdodrxYtutSfy9sEj4pyEzRMg2HZ4fsFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462481; c=relaxed/simple;
	bh=vwe4UNLQlE+V4/kFm4358dnZSLKWNZbkK+8ijy6vxPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtRUUsn7+8qWOSycNP5bAld1zLXlLjqZndLb+SZu8mpezl9BAg2zBvLVMhodP9Fa8jByn7NJF6+0+vWfN6Vu9NZZqROBHWF5I0PphtfDJRUIvWbTqb514JWIsQGobUl5BDvZHFo4zvcJiV5m9sIyPhlzH/MZOIOwRax0QQVY2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n4WtB8Z7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2070e1579so1672957a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 17:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717462478; x=1718067278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6pZSOQaJynPue3j5KZHyGZp5eOmX4YwNkAxybNbnGY=;
        b=n4WtB8Z7S7GC2fOSy7UC4JYX2KEbAmpsglJydMgHUcG3naDZuWa5SYVlnTMxpj/urk
         E3Jh4bRou7S0A9Y6yoWJhQ6FCLwg9lCL3A0jlFnYFf0FHhzs16Kq7TiKi3RA53GFWjyo
         NtOkhHNp3UPBLhKJx0igj1TTdy2IZw7LrbTEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717462478; x=1718067278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6pZSOQaJynPue3j5KZHyGZp5eOmX4YwNkAxybNbnGY=;
        b=by5AXr2fxkPn93ESlcmJ1sL0y1GWbXRVbbg4QsSTO2kkg5kT1bWwTTVyJG1ZNvZKPR
         JsVsXBafX9gWujMmO1z7d73Mv0SDZ8L6fCqLs3Nf0pZg3zy011Uqpf7WHsU8nqQB/udB
         bWcKZ8eVPgtM570gwmNmPAku60Dx3uGIGCAbtylm71iPP/rciNoJzag8DyNcCAFgvtUr
         x+hF+EuHZCz19F7iFHfNX0jIdE30wH/8ehaiFftw8n/h/1Y/jbNjMp2s0bfq13Ur/Z5d
         TrufKHLXzuGefCNDIRDvFWWXWl5x3WNsCDSB0C9CPNvcEwhwbkZIiPbyQsZ1hL/tbi5T
         0/hg==
X-Forwarded-Encrypted: i=1; AJvYcCXVJSpbsee56EjmI7VChxncgsx8YsTxtINDNYc9LgzKez9Ux/9R21VYfSbb4gksFfW2K0Jil2aD1Yjf5soMJUITOlRankL0xvT7wudd
X-Gm-Message-State: AOJu0Yx7/Ce2vkm99wuDUDQLJ8ixubIRIPWLx6kLX7qbVm2C91vIdBvL
	ZGP4ILdweHyIeEjkp6/UlLvX5lAH+JE73u1Mgak9gQOhBq4ZP6UXZ/zR2oLuww==
X-Google-Smtp-Source: AGHT+IHJTl9ktjtYvH+c00K3O1DHZx4eScG7agvwHy0DCMK1K8EDwOPfdaVkTFnP0Gy5RK4I3rTH+w==
X-Received: by 2002:a17:90b:19d2:b0:2c1:948b:6f2e with SMTP id 98e67ed59e1d1-2c1dc5d5698mr8621759a91.44.1717462478455;
        Mon, 03 Jun 2024 17:54:38 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:6203:d1ca:c560:52f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c284250asm7344826a91.50.2024.06.03.17.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:54:38 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
Date: Mon,  3 Jun 2024 17:53:12 -0700
Message-ID: <20240604005354.2294468-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This CL upgrades get_next_event to version 3.

The max supported version will be v3. So, we speak v3 even if the EC
says it supports v4+.

BUG=b:331761304
TEST=Type keys on Kyogre.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c       | 27 ++++++++++-----
 .../linux/platform_data/cros_ec_commands.h    | 34 +++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h   |  2 +-
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 945b1b15a04c..df257ab12968 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -686,7 +686,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
-			       struct ec_response_get_next_event_v1 *event,
+			       struct ec_response_get_next_event_v3 *event,
 			       int version, uint32_t size)
 {
 	int ret;
@@ -709,11 +709,12 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 {
 	struct {
 		struct cros_ec_command msg;
-		struct ec_response_get_next_event_v1 event;
+		struct ec_response_get_next_event_v3 event;
 	} __packed buf;
 	struct cros_ec_command *msg = &buf.msg;
-	struct ec_response_get_next_event_v1 *event = &buf.event;
-	const int cmd_version = ec_dev->mkbp_event_supported - 1;
+	struct ec_response_get_next_event_v3 *event = &buf.event;
+	int cmd_version = ec_dev->mkbp_event_supported - 1;
+	uint32_t size;
 
 	memset(msg, 0, sizeof(*msg));
 	if (ec_dev->suspended) {
@@ -721,12 +722,20 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 		return -EHOSTDOWN;
 	}
 
-	if (cmd_version == 0)
-		return get_next_event_xfer(ec_dev, msg, event, 0,
-				  sizeof(struct ec_response_get_next_event));
+	if (cmd_version == 0) {
+		size = sizeof(struct ec_response_get_next_event);
+	} else if (cmd_version < 3) {
+		size = sizeof(struct ec_response_get_next_event_v1);
+	} else {
+		/*
+		 * The max version we support is v3. So, we speak v3 even if the
+		 * EC says it supports v4+.
+		 */
+		cmd_version = 3;
+		size = sizeof(struct ec_response_get_next_event_v3);
+	}
 
-	return get_next_event_xfer(ec_dev, msg, event, cmd_version,
-				sizeof(struct ec_response_get_next_event_v1));
+	return get_next_event_xfer(ec_dev, msg, event, cmd_version, size);
 }
 
 static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 070e49c5381e..fff191a8d413 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3527,6 +3527,34 @@ union __ec_align_offset1 ec_response_get_next_data_v1 {
 };
 BUILD_ASSERT(sizeof(union ec_response_get_next_data_v1) == 16);
 
+union __ec_align_offset1 ec_response_get_next_data_v3 {
+	uint8_t key_matrix[18];
+
+	/* Unaligned */
+	uint32_t host_event;
+	uint64_t host_event64;
+
+	struct __ec_todo_unpacked {
+		/* For aligning the fifo_info */
+		uint8_t reserved[3];
+		struct ec_response_motion_sense_fifo_info info;
+	} sensor_fifo;
+
+	uint32_t buttons;
+
+	uint32_t switches;
+
+	uint32_t fp_events;
+
+	uint32_t sysrq;
+
+	/* CEC events from enum mkbp_cec_event */
+	uint32_t cec_events;
+
+	uint8_t cec_message[16];
+};
+BUILD_ASSERT(sizeof(union ec_response_get_next_data_v3) == 18);
+
 struct ec_response_get_next_event {
 	uint8_t event_type;
 	/* Followed by event data if any */
@@ -3539,6 +3567,12 @@ struct ec_response_get_next_event_v1 {
 	union ec_response_get_next_data_v1 data;
 } __ec_align1;
 
+struct ec_response_get_next_event_v3 {
+	uint8_t event_type;
+	/* Followed by event data if any */
+	union ec_response_get_next_data_v3 data;
+} __ec_align1;
+
 /* Bit indices for buttons and switches.*/
 /* Buttons */
 #define EC_MKBP_POWER_BUTTON	0
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8865e350c12a..dbfd38b3becd 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -185,7 +185,7 @@ struct cros_ec_device {
 	bool host_sleep_v1;
 	struct blocking_notifier_head event_notifier;
 
-	struct ec_response_get_next_event_v1 event_data;
+	struct ec_response_get_next_event_v3 event_data;
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
-- 
2.45.1.288.g0e0cd299f1-goog


