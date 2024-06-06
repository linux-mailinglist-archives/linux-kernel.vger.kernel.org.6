Return-Path: <linux-kernel+bounces-203489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47248FDC05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CEC1C22F51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE9F4EB;
	Thu,  6 Jun 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzBzgKfD"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB57749A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636044; cv=none; b=e3+0irXbysnJ/ezDbBB4ftlLT+c4HK4XJL+ypBH8s/NRKdvJOj5G53h4vMDugwX9EYRtxkvRHvjk9YZFWgWzqDCLsZvcyUtNezs9fLdHzX2KyECLh0+8yG1Dy/1+mwcJkpK50EK3dNCOZqKGkC8tbaX3wjQ84iZq4AJ1d5NuSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636044; c=relaxed/simple;
	bh=gFn5wwu4bMNpLGJMXipsrkFzI3buH1deDAdkAU5DByc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dS4dxQDM8WtQCZRVj4MQvbrWe/DOsFXMbtlqHDFfHkOEtZq2rEOcYaeXa8cUmYPfNCTxXxdmz5WOgnrf/HOEMB1bTBT7fnPnALb5ZWv2oFX7CUuRgwVA0V1PgWJxynmvnD0DkvVGNbHshWGdfl7c7QTd10TNTgJRz0IKCf3qFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IzBzgKfD; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24cbb884377so241811fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717636040; x=1718240840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHJWUhGCM31EHb8N/3uQR4RdhPKST7fahqcoh/PkOfA=;
        b=IzBzgKfDKm6FAH2AqhnzfYy2Ketqj1nR91A98kdZIeXqm/2IZoADcyBbhSNf/P25Ff
         BfLDEJO894o3ZUvaE/RZk8WOcH1hAwCJHS4+9lBxFD2G75KHa/Zpa17U1E9hCg2Jvl/v
         IIKqK+ihEjBY32xN1MlzMRrk0HO91BXMNgUdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717636040; x=1718240840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHJWUhGCM31EHb8N/3uQR4RdhPKST7fahqcoh/PkOfA=;
        b=TdYXop83n0t9odmkI27huEuHhY6PRbgwaEkXjLuTPl7dSbDQHg3KWQr/dMP9E9p4Oa
         xlc4IdNYLBwSFbPsqAj4HRKdTYM38MjRNH+gRMEONHhngqcrvq0w+x4hIqKfH0VkBeoK
         Vxd8wi3SnIQxiPqoaPPvCxqjDidLvdZGaLzIWpwyRdM/f81wr8nhkOkUeZq6Qu4z4B+v
         NaM9sREf+etSyX8kt6r91CGcHkTTembi7QksovGSicfQlnTOFIgiZzYEoiRBH/LqijG5
         lixFpD9Jt19IqiSrPEApdPMWAul5e/df2Dw5u1J+dTuHXl7FAZE9QP65Xoj6LxxFL5VB
         THSw==
X-Forwarded-Encrypted: i=1; AJvYcCV46+bFGi8P1gYdP3uZM8eMDnQvYTryPWvaUu/Gv5lgSYf5LQU9DdCtIoJd0oMLOTPUpWVWT5yfuT3vhklhSDWZMn+wEgGX9dmfu/n8
X-Gm-Message-State: AOJu0YxBz0anqR2CtTFP4ZKJiTnymzo9i2MX+3WucI/lYxV+wGsJI7rP
	XZ7rYPj3d5ke9UkVAFYnpf+OtB5ke5HEs9+1SNTNCAEy4ZaDWsTNyN6zwdI9zg==
X-Google-Smtp-Source: AGHT+IHmH0jI7w3IKJ+BmIm+75hSNR0Qkc6y3LcT1Z1xvmyEHLSV/NA5M/qYahJWCyXzuwoUttfvMw==
X-Received: by 2002:a05:6870:d890:b0:24f:cabc:4f6b with SMTP id 586e51a60fabf-25121c94350mr4957202fac.8.1717636039994;
        Wed, 05 Jun 2024 18:07:19 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:3fe9:f321:712c:442f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4950dfsm114252b3a.133.2024.06.05.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 18:07:19 -0700 (PDT)
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
Date: Wed,  5 Jun 2024 18:07:00 -0700
Message-ID: <20240606010713.25275-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
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
2.45.1.467.gbab1589fc0-goog


