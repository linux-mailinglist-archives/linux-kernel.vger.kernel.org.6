Return-Path: <linux-kernel+bounces-201532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F368FBF9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1654C1C22132
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EF14D43A;
	Tue,  4 Jun 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eubPSMKi"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909814D2BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542541; cv=none; b=Jhiv7kscVIWC3lKvCE5i/GKyjIfYEjdXLlEb5ixO46Tvsl2DbUH2bbCQHhxbxVkFl5TU2V/VGVrl1Q7Vq2Vh0S0O/r5H5v7jH4C9K1BO9j2HtLLkZUJdKvZyi4hRpK2HNRpUd55ZpRBfMZGZzVC1ojhLYHjtgSsRsksCVOgtpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542541; c=relaxed/simple;
	bh=jItJlnuHB35DpaKJ0dIjWrJnF2d/a8eObJOjomO7Ihs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItMRronml6t8iSDV0ng9WLeJOCMHFNgNEx5teghEo+xh0BA93hPibyFw7Cs41pjfNnKOLEC+iS1A4KfLNHianyAgti1fNH4i0h+NgMP6eMLmusbjoXAdc0NqE/YD9/0wEgTrSBAfhpkcFWcV22I5g0nkZlJwWmpZS9lhVsTRKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eubPSMKi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6342c5fa8so36601985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717542539; x=1718147339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRNOn6MGKklcZNQlL7ZC6Enr9RIVqAlFFrQl6ERFrf0=;
        b=eubPSMKi6/hBlwXxMUZtq0ob+JQxjTUHzwoCyO6ozstQM/EY1Dg66HYt+l0Sdlw3C7
         +nWdHMVkUn80vWsItZYeVr6FGJWVShuqvAv4iD4vKSKE4U1iXj+9KNHzJIxh0NoSM8UO
         u6bn3zie/8usprYn/SlKgD2reJ+YiUdqR3tJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542539; x=1718147339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRNOn6MGKklcZNQlL7ZC6Enr9RIVqAlFFrQl6ERFrf0=;
        b=Zz24N/jBj4F7VuW7F3VHbeW2hlLAJ7+dLLB9QUVlt/4KSzP3eDt8AlzNaQ3mkSNcq9
         C5b6a2k5hCV4T2r4wGNQ9euK+/s3x4zuRJ6qTMHheAhtgg8Eu8fkxWvbZMBACrfYHehD
         gRMLGES+fPRrn5WGtSiGjrIAiRIvHO1+916XptaWNeCGz9xK939zkm3LB2COqB7F/AvV
         fAOl/G788nDh61FvfWULuHVKyXYEYmLwLpgbawByuh7P6cJTgf4Oj7R+5FhjuUmoo6s+
         RSsp40K3myO9pqTC2k0sDMVzQN7gA50GwiEkGs0im2WC7vP21lsc3KXlp2t9kStQnFze
         //pw==
X-Forwarded-Encrypted: i=1; AJvYcCWm8ltCsCcS1aSuHObyaRyvZdkokYF1iindAvLVatzMhTXXhDWA+/NBCFVXHuEM9EFAKpt1oyUyqWgbUWTYwIhH4gSDNg6y4kd7gnCU
X-Gm-Message-State: AOJu0YyUAx/2GNyqRa4sQWSMWqzn6rUjpGePl8HkQRLp1lI3/6dXS22D
	v2B9gWKFiophgUIxONx9WPwHuD2x4hDD04h6csDbkec+9S/O+1coIo5vsz/wsg==
X-Google-Smtp-Source: AGHT+IHd9kPwzkTcMHbBZ3TM0b2pWCt7CfkhLEnlAVIFo84Z+1RxCEljWuBq/pMKidPurCPWslr2FA==
X-Received: by 2002:a17:902:edd7:b0:1f6:9010:1cb8 with SMTP id d9443c01a7336-1f6a5a849cbmr8629555ad.65.1717542538979;
        Tue, 04 Jun 2024 16:08:58 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:c108:1a83:e639:e62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232e0ddsm88931015ad.51.2024.06.04.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:08:58 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
Date: Tue,  4 Jun 2024 16:08:25 -0700
Message-ID: <20240604230837.2878737-1-dnojiri@chromium.org>
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
Change-Id: I3af4912c4f7bfdb24445dbbff5f1c6b7a4453de4
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


