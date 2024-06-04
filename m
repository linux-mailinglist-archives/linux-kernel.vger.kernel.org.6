Return-Path: <linux-kernel+bounces-201133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C238FB9F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373BA1C2515C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D31149DE3;
	Tue,  4 Jun 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U9BXMl/c"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D61448ED
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520887; cv=none; b=Ku8fMi8DNj7BckzSQMiR9UyFx2p0KvwKsg7OGId+6G2U1FXlSHdgZo5ILUm0nOjVMKHSllUghG6VDgAWX7D3mNpEjLQZ32t124wSJH7cBnK7oHx9FzyvPSIE5Dqq/0qqEQdHSlZwIFQ5Zl55KxDhgO9+6kVZ+uPQPy7/FQSqNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520887; c=relaxed/simple;
	bh=4XSej0FLCZ/AI/Z4e/U9mxn1uwf56jUeeM6toqEinfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEdegvvef4IN6rK+TzU7qwg0Ft/jrCTjGQ7cDW0p/JlaGVmo2bmqBTDqzWrZsyDaLLwu1YWvnA088hk0wtZDf44VafD190R+uE7YCCy1SXvMwbweEA/DcvsKoPLLzzVOY/aDG598SiZc+IOccqfbfgj/7X9Aa5AZafaAPlU8Shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U9BXMl/c; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ea7bcc72caso245739039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717520885; x=1718125685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKD8Y0etVVlMmtHijWaqp2Q9vJ/jXpdL2qQDhE5pUXs=;
        b=U9BXMl/c1NawKA/ATwvfY/PnYKNBELIIweBPGHGBL90jRRk3JdD1bKOc7NFSbUxMW2
         0++BlqE/RxYqs03ztc6gtfeSfaEKGJMnN4OC9w16lXSaJY1pQMl7RYinuIzYlua20/2x
         7spfLsE3m1jVgQJ7tD/f4uEFwwFMWwNhg6CXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520885; x=1718125685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKD8Y0etVVlMmtHijWaqp2Q9vJ/jXpdL2qQDhE5pUXs=;
        b=HOsEFGCMjolz3X7pzl7PnKQMrCDd83yVxXkKnyusVmcUtDgUIxzjSvjT0ujky3/iNp
         hVeZlqFXgkRmG064q5UenAu1ZnkcULLkdQToVc9rIbYyBbJfsxUVZFYZRnvzmUEG+24g
         rTh9EIel4KxZvsy3rvVlQZSNtxz5i01abrvWg5R78apbK00czK5UvFEIkBZkPWUzqhQB
         pG48mgFr35b0AbHUXEXNEJ34/mRtLeCiCZjRvlu5h0zBM1Czohm2xJ6RxX/Q8FUOfBP6
         hMg3T/A9P+w1EmHNg56Zzl0Hbp4eOxRMl3WJ1aEFPM+RNH/bz5vGFQoZGBZ1j7RqhI5H
         7gVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSiLmp4iA4iTIm1022eHLDOlwnCGVkYPmsoXpoBtn8XtXaZUlK+FQhGwIHoI+EtM5/OqgdSiifs4KYv2jV5ItTISYErOGvExVDAiiy
X-Gm-Message-State: AOJu0Yy3lclDjboj7LYGYLmWbssidnzuunjPMvaLW1vJHJNvvWdnHmUg
	tHuSyMm5YMjQhFSXLqzIBC/lAcLw18aGAU2LvcOEUjJSeAIwY+fVXvjTnZLDQg==
X-Google-Smtp-Source: AGHT+IG6rzIdxtJQDyaOwSq3bWNdynASkOlJ8wpgF6gPDBALMjBITmL8HhIinzycWfSdb78mGae2CQ==
X-Received: by 2002:a05:6602:6d16:b0:7ea:fd77:c28e with SMTP id ca18e2360f4ac-7eafff2b92amr1828956039f.17.1717520885067;
        Tue, 04 Jun 2024 10:08:05 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:6203:d1ca:c560:52f1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c354e744a0sm7257125a12.30.2024.06.04.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 10:08:04 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
Date: Tue,  4 Jun 2024 10:07:43 -0700
Message-ID: <20240604170756.2518459-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604005354.2294468-1-dnojiri@chromium.org>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upgrade EC_CMD_GET_NEXT_EVENT to version 3.

The max supported version will be v3. So, we speak v3 even if the EC
says it supports v4+.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 27 ++++++++++++++-------
 include/linux/platform_data/cros_ec_proto.h |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

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


