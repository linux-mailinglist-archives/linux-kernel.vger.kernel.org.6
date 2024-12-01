Return-Path: <linux-kernel+bounces-426537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249B9DF48A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE202813C3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2023741;
	Sun,  1 Dec 2024 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx3Ey0fy"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A442A9F;
	Sun,  1 Dec 2024 03:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733024899; cv=none; b=KFt1qzCv5aNDyw7rmseJMxl6u9TTOyaP33uXIbGGeWNsgL4QqAI1PbwgVJtLiUu17AMOn/FUyDlBelwP7CyEmyAsIDjuBzKXjcFx2HYIoD/MkuOkGYnZ9xbE68AvWCLUJcZrf6bDROsjiNMou8xnGEuZ+ZTaq1Uft9Rz0pDpXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733024899; c=relaxed/simple;
	bh=bm4g3gW/0JixgF/+bMfyeKUQZTylYWgWoRThFnCITgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldntgodIYqP8kNjVX+ThsOQa+4LPsobGoUWIE51KSgQ3JI0qP/sSxoi3md8wyNMhYe0XgkBrKbNFcWearhnWuhmCoVnWMK791c+dzs+3Q/tWH4d3tkrODUymf6EyqOGfoynspkiWpC6rCZ6QkXAo/dEV1hDCYQJ/8mqo6oqRV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx3Ey0fy; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso2088234a12.1;
        Sat, 30 Nov 2024 19:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733024897; x=1733629697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vknWC1u6q6/j4V2JQKVNzdgspGHJTpTzBoIi7Q9wT9Y=;
        b=kx3Ey0fyXP0+DFRqBkqXLxj3F6O4Pvi+uKhAINidBw3R1E06LIwOP+FXjEIZJFXDh+
         5x8MQA4pHVm1AlN/70y2niM/+xCV+svd3odpvsYbolOxWnCsiDl+YNFql4mOH11Pnol+
         LTTPzV6RIcXVFhnd6GIDmTrIXisHl8tn5TCFc2obaEOtFbQ+LtseKDce2oAh8JJTE1pB
         ExkRfRfww0gv5Tkh9S3BMzP25DMOXHwkFOfhNasWyaSRUMCqAextBoR1g1OnWt1tQrMu
         e4cQHVwHtXKOGpv4aFugRsqnTbfYoHa5nGXSOf3T5BoTordkMTK6kZyUIwasLq5w2EUt
         t+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733024897; x=1733629697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vknWC1u6q6/j4V2JQKVNzdgspGHJTpTzBoIi7Q9wT9Y=;
        b=TN9HNxkATfj4p0dbBN0DRbtoFHcmE29SOLj4SPQOV8oA/f6sTCc7xRPiHq7GVyY1Rf
         8yMDrv9I2wXLM+F+3Tcgs8gTXcBlAkl/h4hmj7nNPI7pOL9ZkJ/6yWgKw+v1uO7c9IAw
         Vfyo2lVY+nq83H2dtdJTjmwUQmUXrQdaZG93foPkOOtHQxyoTyFCz1ZE28385UolA72z
         Tfq3AXelaL+la0J6ahLpro8PmXkR8u2iszQhzDEmXt6zRKMpk6BnuQsqI7jfBNFviFv1
         s7nCXVjDRFxCXWtXuTKo8YvvGyxJO1UHo2uO/hetxQQX5U7zJZsgDn8UmneEUj5kcvOd
         rYcg==
X-Forwarded-Encrypted: i=1; AJvYcCU+h69wYPTjCZ4P2sK1zIIFIO3PcYZypcC69ldVN9V1XWTT7vRpagfKPzl3HEzow+sumnILuVBLLbo=@vger.kernel.org, AJvYcCUhndSqDwt5j39ik5O6H01DFHZNWVtgj7awz8ABejkse8WEbE/0YBy1Fv6mLIcDGdJ+Z+VMfQzkCAaiFmVh@vger.kernel.org, AJvYcCXx2FjhdHFWCArrAEFOCZDSixkjc/caozah7PS/HFJ079yO062tIpLJ5XjafQqG2jdCN/UGw6IwrvxXyCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeReUlyB2oqqh0nDr6K/WUavqhXX9VezHeaDDFHonM4dCHTJu
	4ZLE4G9b8IMvY9nmjBKF7/hIMIx8I9hZj1RAtJx/SEITaKsBwf01
X-Gm-Gg: ASbGnctfYbpqiEdiN+ltdZ+TZAPSpoqwTlEeUan1ISFGSWIJGNVOH5tYZEqZtZiF4X3
	6to1ii5YDrPlEblpzQjzHEIEzQnRqkuP3DXGpEcVyC8sAxW3oK3qz7zZRjsBVakMvQURV6YBdQW
	rX4V9mupxd8jZjVCoAlsiwHxdEi3tCkpH8B6wHmH/7Jd9Lwzx/tacTtqYj241lPlX1JpywPcCY3
	p5citQXRlRYiWtSm4XylyJKkh2m0jOIYD9tT71Ig1OT/byB6pO4xgy+dEK1vL4z
X-Google-Smtp-Source: AGHT+IE0SQPKDoJbTnKcxiB0OMj8dYzlSU9QvWotHLfPodElJGgYskAG4MtsifT6g0vfocsKI4hEqw==
X-Received: by 2002:a05:6a21:328f:b0:1d9:c6a6:61d8 with SMTP id adf61e73a8af0-1e0e0afa68emr26513614637.7.1733024897024;
        Sat, 30 Nov 2024 19:48:17 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c321125sm5442471a12.45.2024.11.30.19.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 19:48:16 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li XingYang <yanhuoguifan@gmail.com>
Subject: [PATCH v3 1/2] hwmon: (asus-ec-sensors) AMD 600 motherboard add support for fan cpu opt
Date: Sun,  1 Dec 2024 11:47:44 +0800
Message-ID: <20241201034803.584482-2-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201034803.584482-1-yanhuoguifan@gmail.com>
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refer to the LibreHardwareMonitor project, LibreHardwareMonitorLib/
Hardware/Motherboard/Lpc/EC/EmbeddedController.cs file,
fan cpu opt is support by amd600 EC.
the registers are described:
BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
{
{ ECSensor.FanCPUOpt,  new EmbeddedControllerSource
("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
}

now add the FanCPUOpt support for amd600

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 9555366aeaf0..381bf117104f 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
 		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
 	[ec_sensor_temp_water_out] =
 		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+	[ec_sensor_fan_cpu_opt] =
+		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
 };
 
 static const struct ec_sensor_info sensors_family_intel_300[] = {
-- 
2.47.1


