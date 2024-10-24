Return-Path: <linux-kernel+bounces-380089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC39AE8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5781C221EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5A1EBA13;
	Thu, 24 Oct 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i16RMAjw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CF1E1311
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780006; cv=none; b=FChsjqKiCKfridYwxkcV9SMh9HyvJI7mytwQ/GpzXUDArjC5sqHXt9xXOSQtBebDH4G8O7CRt1WBneylTXYe9rKydIyUcVKaDNHTI72o8Yvw4D1qQ9WnaZPdkk9XrMZz+qNReEcprVcmMqZ7df9HZJ5vRRviYHnCgBURNx9elig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780006; c=relaxed/simple;
	bh=C+p1aDyB7VkC61Hc3/SxtK+1NINzVdF1y4LaKhjxQK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/S5KwJNuzjcLqmfnbRqIOr79SuMhtsb/138a5dzgDVXDPsLdrQZb9PwN2EbAC9rR4n80erQwDHKP5ygDCVO0bHqanmzYeQFuvNccUGbwDJf2qpkpSdLGaEoOxzBetaMk5RW7bN+QV6BkgHxfisHR+5GX21WU8wld5n2D8+9KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i16RMAjw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d447de11dso733453f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729780003; x=1730384803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oga2UVsia+XB/fVly3dFhZNF3ggE1IEb6E9XDUwGIzI=;
        b=i16RMAjwWVzkE8xMHDq80vKFz1CSoiibyMQo24CI5I1oHgJBQlzbbvQ5ZUlTOcs/jM
         IwlNfO2sX26W4XIN4VNNo0tHOd3vCLvA+E3RMmrSeTdNUE3hX3H6zDE8OXBQLjKHnoJz
         bYUMgunC++kd1jgtjJW/Ep0iipq/+FN4vSx4oo3IDY5X0TAaszrXodNep9dmpBZ5MplZ
         GvLNhrqbXhDHtfLX7bvN24M4llb5BLqzkCKwh32abOi08GpuD287ClNIEkTZJoUwCIUC
         F+Qih9QLCVAFMNDFHXjb/sGTUh/e+KGSsBoL3y5i882zvSnUToBH56d6khApLQaMZRQQ
         zNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780003; x=1730384803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oga2UVsia+XB/fVly3dFhZNF3ggE1IEb6E9XDUwGIzI=;
        b=w57452+VRqhPbM0SpotFQGvwZDvI4O66MmO2dg3FBAyOil6W+LiFFptgxeZE6x0HqN
         elNSVYEh1xwD4lmjdlCaL7/AQoTz6dpzpdira4wLEb9OjP4Aki3D7I81IiPhtiPbZluN
         oZpwR5RAKoV6kclS4QXDtIFVbJsQ3GZwCucI0Z+10X50Exp9IQ/p3JO7erjvEaTyzulE
         4dmFVDbD5EaSl8EBsrYFmOO/yt1nW/zOFjXCnFhK0op2BneeW0LNSt9k0//xtf99oylH
         8yCg9F9UvmsXl032MyhMPEYOVAIss1+NQYKoS4zhPMGX+IDBbK9OsP+TdcpiT9MWUJeU
         o0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXaLORdm+7z9HmWvmrB8h0hnB3IDYjuIlDg/SogxxnZAOTuqh81gnmAzQHs5+MUTynCGJ6P/9EZmNjROiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8PygsWzwwtd0gKw1d5WVXVMzbTj3eoHmP48W60IXneSFsdo6
	N7WURRCw/6ey1HPP2fGRTBVZN8QsRYSNYJ8ViobQ9j7EafEOC0mfXQcLIKrQ1Ao=
X-Google-Smtp-Source: AGHT+IG9tGpJm9iadws5hKUkxtEkvcfk3rNV99P+H5KkUqUwBXXfEplDy+UCDrL5u2QxNmRMuvH26g==
X-Received: by 2002:a05:6000:546:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-37efcf79d9emr4163170f8f.41.1729780002651;
        Thu, 24 Oct 2024 07:26:42 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430absm19940975e9.6.2024.10.24.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:26:42 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] thermal/lib: Fix memory leak on error in thermal_genl_auto()
Date: Thu, 24 Oct 2024 16:26:29 +0200
Message-ID: <20241024142629.1146298-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function thermal_genl_auto() does not free the allocated message
in the error path. Fix that by putting a out label and jump to it
which will free the message instead of directly returning an error.

Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  Changelog:
    - V2:
      - Return when the allocation fails instead of going to the out
        label resulting in a NULL pointer passed to nlmsg_free()
---
 tools/lib/thermal/commands.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index bcf0f14d035a..4998cec793ed 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -375,6 +375,7 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
 					 struct cmd_param *param,
 					 int cmd, int flags, void *arg)
 {
+	thermal_error_t ret = THERMAL_ERROR;
 	struct nl_msg *msg;
 	void *hdr;
 
@@ -385,17 +386,19 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
 	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
 			  0, flags, cmd, THERMAL_GENL_VERSION);
 	if (!hdr)
-		return THERMAL_ERROR;
+		goto out;
 
 	if (cmd_cb && cmd_cb(msg, param))
-		return THERMAL_ERROR;
+		goto out;
 
 	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
-		return THERMAL_ERROR;
+		goto out;
 
+	ret = THERMAL_SUCCESS;
+out:
 	nlmsg_free(msg);
 
-	return THERMAL_SUCCESS;
+	return ret;
 }
 
 thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)
-- 
2.43.0


