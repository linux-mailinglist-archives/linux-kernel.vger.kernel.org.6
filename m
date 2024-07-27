Return-Path: <linux-kernel+bounces-264215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9293E044
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DE3B212F4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2480183098;
	Sat, 27 Jul 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxp/tXkN"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C940858;
	Sat, 27 Jul 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099827; cv=none; b=s9N5e33BH0NsRql8s5CW8hLkyiXwgE9az+WbgD4lSKKIu3qRwjQDbAjWKrwnLnoSb51dLRSpe4Xk2V9FpY5qWegUiOadxfWp3L12EQ+o/gtSpRoYTKkb5zlrN0OM97lUrDqHHn9ORt/STo9YGwOhC+xjVQgKRDEQSxbW7xIqnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099827; c=relaxed/simple;
	bh=ix5YfW0J+1zfDtJJlppE0RDbfCy4n0jR3dlnSlonNow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eee36O1tQxdI+zBagvGVwZkO78/08TG2tJo4N44xE90B6F+oyqS+jRt/HDLgFVz7lcPF/q59e3Tmm4uiUgOUQkpqz2xaZvUt3PmWLURENzLp2HstC9irZRcZxGwghHXlP6bCdLq5iQRdvgBwAiyNUpE80kQc+rlrK4xfLmbd6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxp/tXkN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f024f468bso3217780e87.1;
        Sat, 27 Jul 2024 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722099824; x=1722704624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NqwdKTkCuZxDOFpBUq2Hdbu50nRquMbPSbwlFBDKps=;
        b=Qxp/tXkN36k3JbxJE+CIm6Pay3FlOozXN7TJE2yrAy/GFyK+wwpjw0Lcl9GyTZvw52
         DO4cDVdihqFVeo5cREXMUOSZheYk5BXWYDvBhvdBDNUJLYLTepHJu134N1SBe6btKm6w
         h3OOueyLCR+RCrjTgNbZw93giwegXWfAFh8Fkpmw3gWhAz6VmETNFl5db1+RFf3yv6mM
         bYzbnqq5fzk4mGAGub17X29AZVHiLap6DocHusamdgbRrdPZhvelIabbgw7u7trVoyuf
         QZYsNkFxwsrgt2m11SeIoF28CghkCvfnXppJvbLJ7NfmV1GCOw2hFOQ+B25wL5y5Ku9K
         2IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722099824; x=1722704624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NqwdKTkCuZxDOFpBUq2Hdbu50nRquMbPSbwlFBDKps=;
        b=wcsExwtWfPfct3PotMdW0xqfBmrk3XwBTB+k2Gt7p2J9u91Csw6QH+6W82+FE9MFgR
         e/zLT8DDAz4I76bzgb4T/ibNmwritBMYqRugeEHKyO/ErN2uTW1g0yCDiYF3fc8WcLE3
         PQt4oM/hpax9sYKDHX6f3bnWuxYd6AMTx/iFyxCsNUK3cA7IzjIkUfSPOLyMfc1ziyew
         0F9CwHvyVscPRqMweR+QbxD8g2omkYD4PhzSVDKxzYk4UUDLcrjNp9eK5XJ4JfXzAQJv
         EEhjQoxb23wIdGTzGgT1j6zObol4AKdyDM0pSA2oaHWQGgVnF5VjgGBgHp5ccjxr5ecc
         NZNg==
X-Forwarded-Encrypted: i=1; AJvYcCVGU3jt3rS3L7lXP4jlaeRiO5i6hnGmU1kPJq8bcjZTv7HBk0n9IpLFLybh2nShY9bOoz1pPcwzsreqAYObEiDBVRqByQTWPq2scOQnKRCnWkXoV1YbVSODKpZ/wOTf8a5X6dL69TlEvaQ=
X-Gm-Message-State: AOJu0Yy+LYVbr0OHDOsO6CLFZfmtMysvB19QkJnSOtsrf4FU+r86A2Je
	dJQx6fgyle8SLP/IEkdPg71zz2AIOeWdFucXfxFtE6ZQp2o5OWxE
X-Google-Smtp-Source: AGHT+IHLov2eQvOhj55Q+Kf3aB03SYmK+0gl3CyJtcL3RRYrfwSsHUQyG6tb1tRYgXTMAL5pzk2kcg==
X-Received: by 2002:ac2:5968:0:b0:52e:9dee:a6f5 with SMTP id 2adb3069b0e04-5309b2c39dbmr1879799e87.46.1722099823207;
        Sat, 27 Jul 2024 10:03:43 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1ec5003008007610402bf2.dip0.t-ipconnect.de. [2003:cf:9f1e:c500:3008:76:1040:2bf2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acadb82e7sm296666066b.208.2024.07.27.10.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 10:03:42 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: RobotRoss <true.robot.ross@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
Date: Sat, 27 Jul 2024 19:00:35 +0200
Message-ID: <20240727170324.8867-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727170324.8867-1-eugene.shalygin@gmail.com>
References: <20240727170324.8867-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: RobotRoss <true.robot.ross@gmail.com>

There is hardware support, it seems the sensor was added by mistake [1].

[1] https://github.com/zeule/asus-ec-sensors/pull/58

Signed-off-by: RobotRoss <true.robot.ross@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 6bb8d7b1d219..ee396f21fac5 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -420,7 +420,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-- 
2.45.2


