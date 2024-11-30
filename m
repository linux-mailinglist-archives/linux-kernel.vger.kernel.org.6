Return-Path: <linux-kernel+bounces-426287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E09DF142
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC00B20F65
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EED619D884;
	Sat, 30 Nov 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyhrpELa"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AF15C15A;
	Sat, 30 Nov 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978071; cv=none; b=gzgJE3xLYbAP18FvSmZ+EX3OpsDtacKQIHKUOeK3T+eXkMIw8cRB5Mc5GE1CBCs5m9NoJLC7rQNIHKmo3yp/ZxADi+wdOC7oAeses/J0dUTm7FvnVC84PD96/GZ3wbob8s8GAwwRTupFTCO1wyWbn94t/yEODSYF4Sw21ifALY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978071; c=relaxed/simple;
	bh=8wWHBESBFqgL7aeMi2O7TQQl1TNrgvI2Og5dA6WzVPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuSvKoV9SlS3pQZL40+apIWf90dGnqUb3aOWqaTqlfcK+5e+KbXjzBcXRrg/l6u4wd43kT+YhdEUVxMv23435MhNR0fqOSDo1wY2fpKppL3dObn7NH6miX96qbBBV78M1DYDZ5QsvBgyF7peOAivG/euHu/GS20l+tZYKlrNwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyhrpELa; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso2397659b3a.3;
        Sat, 30 Nov 2024 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732978068; x=1733582868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUUlbhnCf8ybyia2/JvGG/usRMYcU4kbBUPhFCuCz1c=;
        b=jyhrpELalw0ej931XT/Jplgd8j80iLnm1oxDlwxfWUVpEW1ARXKhxjXKigRMG38A6R
         o0TVjNGcpuBT4F11n3lkV3AA3Qn06ffjgospNQWiC6EILckZy4Km5ygW1zAMG2VijtO+
         QInrpyR2XPdeYF5fLFGJcr36AHWv5xJkXiTZBsV8cshG2ZGhdUqi7F9nfuMfQmVDjAd3
         CbKIOJeZoeWCziEMCCVo0ZDQ/nFij+bXbDbEbXmQvQyr9UmGeZ56AYEoTImkncy/MZ25
         8bjTKAwV24gs/gFWOCKddkBS1IE5ldlPsMYk3wvwB67kKUqjdBIbJSCAviWir7Kjmu2b
         0f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978068; x=1733582868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUUlbhnCf8ybyia2/JvGG/usRMYcU4kbBUPhFCuCz1c=;
        b=RhpuAj2AdwZ6HRLDzKXkNmDgvvIzL/rHNWZVM/44db+juwdUOBiq9xLeRTqRLfuVJp
         oZPxbXgExmB/1NodfwZxDaCVzyCryQrqHpQOaJzRr//TcGGKTOBPKbMy1xvx1UqHb8AZ
         0a0s7wwixDsV7+gjqoXKechyEYmladGAP526bolJBf3rSwbgcexVi6xG9rPp+JRyYihr
         NgdOH8cnea8wuO9XLTCI26+Q2Ky9oFYmpDKQyQEZqme4fLEIyXfCBtbaku3M42m+3TG1
         RYQb3Hamb0ATg7R3qURZSgswMm9x9CHTx78b0nFhZ1ohxjsJVyNCj8Nq/qqIw0rqJUSK
         Jw/g==
X-Forwarded-Encrypted: i=1; AJvYcCU+ttBjLbkrMyYxC+XNxCJT3gV4+oeXZ2VD100ePJwA7BZmmKPrP5jilLfUxPF2ftGc6t1GgYtkTirA9B8=@vger.kernel.org, AJvYcCV3S/mJD4mTj3cwLd5unhaWkkwbqEtpSfCna/T0W+wJXxSA958B4TSlFYF6Q46Kn3fhEEv3LA7CpnQ=@vger.kernel.org, AJvYcCXjr5PZFC1jAJNbs4wzcmVOCnWB97djyQWgjpXnuV0h/Io32ej0i/qXpYy7U6xA94hTukRfPlQSyAXEFn2h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+NQZ/8CFdV+ALuhiICioSwtzv2r4XTRomhjwHKbe8iOanA3a
	3mCjSnZXc37WWjbTcNmRDwPNS9t1xrB5ZWyEkIYH+6zUisdY7p2l
X-Gm-Gg: ASbGncsZ5Nj/LaouNlKZjtYygzytiQ5KMuqZVVDUI+8h0kYeKCUlYYh3yd3vid8sXCl
	hZNDrfdihadk7wuH6YKhAtYGpcfbmGTjVTk+neYKuqZhC+NCfMEBMdDJ7u4oVGLoIiSHZ3Gt7v0
	40y+X1aLMoL0G6y/qZu15n+xnDPAFQ2HbB7rXFMk+LbmMUYecK/J6g8BEf9HWfsd/CRIS8tND9f
	kln6Nq5Hg6rQpwnB3RbmoJEiJbKXZ6n3EPk/AUPqrD412CMWIcjcQh8bBvl0TEk
X-Google-Smtp-Source: AGHT+IGyrT9kNwT4PBG5swi87ra/15jFPz5GyssTBisIUGiVmeFP5dKRASZ+p4OpD0bWAw4p1dWuZA==
X-Received: by 2002:a17:902:f70d:b0:215:44fe:163e with SMTP id d9443c01a7336-21544fe1949mr102915995ad.1.1732978067788;
        Sat, 30 Nov 2024 06:47:47 -0800 (PST)
Received: from localhost.localdomain ([38.47.127.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156e0bf55csm4789305ad.5.2024.11.30.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 06:47:47 -0800 (PST)
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: corbet@lwn.net,
	jdelvare@suse.com,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	yanhuoguifan@gmail.com
Subject: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Date: Sat, 30 Nov 2024 22:47:33 +0800
Message-ID: <20241130144733.51627-1-yanhuoguifan@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add asus-ec-sensors on the mainboard TUF GAMING X670E PLUS
support these sensors:
SENSOR_TEMP_CPU, SENSOR_TEMP_CPU_PACKAGE, SENSOR_TEMP_MB
SENSOR_TEMP_VRM, SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT
and SENSOR_FAN_CPU_OPT

Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index ca38922f4ec5..d049a62719b0 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -17,6 +17,7 @@ Supported boards:
  * ROG CROSSHAIR VIII IMPACT
  * ROG CROSSHAIR X670E HERO
  * ROG CROSSHAIR X670E GENE
+ * TUF GAMING X670E PLUS
  * ROG MAXIMUS XI HERO
  * ROG MAXIMUS XI HERO (WI-FI)
  * ROG STRIX B550-E GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 9555366aeaf0..f02e4f5cc6db 100644
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
@@ -362,6 +364,15 @@ static const struct ec_board_info board_info_crosshair_x670e_gene = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -512,6 +523,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_crosshair_x670e_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
 					&board_info_crosshair_x670e_gene),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
+					&board_info_tuf_gaming_x670e_plus),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
-- 
2.47.1


