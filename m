Return-Path: <linux-kernel+bounces-241561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03327927C90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8406D1F239AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0313A243;
	Thu,  4 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBq/AUcT"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6674131E2D;
	Thu,  4 Jul 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115538; cv=none; b=Sy7I7zZu+JGl40pbNRMqsTSm7SIakJKK8lZ38jM6TTNw3YfCyMcYCMo2fdm8GJimDUmr02H+QvJmvLNKUbV4VFQFksB/7uoNsVlRphEtUNxR1qY7fZXm9GE1qdAEfa7TjklwTrCOtGAbBULZdgN39N8ZAILkq+n2dRUjbvfHPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115538; c=relaxed/simple;
	bh=60iankztuhOOmeqBfTIDrJziE4CQ9ArHrygJcSndlpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ptx7/YFLWLR/DHt91NvyUWacWpK66QoGWgqflkgJZJx8ewuII3n7eu2QA2H+zlPE+cUYdi3xFclCSuEL2YJEVJHaZRzJ2qBHshJHiGpJOwOO/Ra5AuSxzKEUzdjRMM8fUg2yZWwsNqYTcNQvPBXJePoqXAAt7NGpcnpV7Z7jYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBq/AUcT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e076f79d5so421988fac.2;
        Thu, 04 Jul 2024 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115535; x=1720720335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciD3sPrk0ucgsuuto0hZVqTq2o3pfwV/M9pGgg9n9/A=;
        b=EBq/AUcTnFt052ay5IuLtZoTbCpQl7b6Sh6JIAnYq123u3QjOVGCX2+71ix/PWeD1A
         s8smgVinJhAcf3wE/dsl5xC9dpVNwN1j0bGS1ZlgFSwWyWGGQE51ZspV9Lor5YJtJbqR
         CNI5/VlUE5qCnR8DOQnxbUKlg844c7yEsSACtpDqKeoTJgKK65eU1kHOqb9rCr19p6v9
         EoTL5eiBNv7JYZlD6woKxdOmZh+8u0R4f3i1NJVYz07e/LMT/EnkixU8vzCQhJmg/NU8
         0ZwHXwkG+VRA/yQmmbFfmzxJ2VmXaGtp+THyAbYunnJEIf9Vu9oq/vi1mNSUPSPOWSQn
         C3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115535; x=1720720335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciD3sPrk0ucgsuuto0hZVqTq2o3pfwV/M9pGgg9n9/A=;
        b=kAZ36ZBc0pO+Vm9Zb9xhHNlUkSQPAZAMUIhgKGJd/vPvMzTrkxMsZJRhVQbofvUJ+y
         SdOpIcCbTnyelhGHd9FaS3CtVPu/wLa1YAx+u9zA1P0ft9gNloVyrx1pBpN1IkwcHbwF
         Tvf4I0IxN9S/+O4KtkSa1ZWmr5/8L1+EHqG8zdonJLRW8BbEJ8BObvWKchwE+AMNh1BY
         reWxQRMgqpuxgd4lEW2/xe5L8Clz0GdDNCorov3x5HBF6MbfWEX8al+sP1XTpdSSeHXp
         RCATYGtS58Dt15RZwIDtcfjG/lT/e8D43ey1PlZN+Pi761ccVY+lkhuOVzI8J4a5/ras
         m2Yg==
X-Gm-Message-State: AOJu0Yz0pgaY8R3u2FXfppzzl3pEYf38l9tZdMMovpiIEmpLAMKme6yI
	pZFwJycVeQ6MT5HaPwSWciOOcZRRin37Pg5yoedM26Fd0YobKf04FHc6kw==
X-Google-Smtp-Source: AGHT+IFyoRtfVe1lgCsStUROzBO/0xk+LbeOGQ391jK9JJEL649dYYrfNX361+n2SfgPX58mrpn9Cw==
X-Received: by 2002:a05:6870:63a4:b0:254:997e:ea4d with SMTP id 586e51a60fabf-25e2b8d5be0mr1997092fac.10.1720115535089;
        Thu, 04 Jul 2024 10:52:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246c8edsm12492447b3a.58.2024.07.04.10.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 02/11] hwmon: (amc6821) Make reading and writing fan speed limits consistent
Date: Thu,  4 Jul 2024 10:51:58 -0700
Message-Id: <20240704175207.2684012-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default value of the maximum fan speed limit register is 0,
essentially translating to an unlimited fan speed. When reading
the limit, a value of 0 is reported in this case. However, writing
a value of 0 results in writing a value of 0xffff into the register,
which is inconsistent.

To solve the problem, permit writing a limit of 0 for the maximim fan
speed, effectively translating to "no limit". Write 0 into the register
if a limit value of 0 is written. Otherwise limit the range to
<1..6000000> and write 1..0xffff into the register. This ensures that
reading and writing from and to a limit register return the same value
while at the same time not changing reported values when reading the
speed or limits.

While at it, restrict fan limit writes to non-negative numbers; writing
a negative limit does not make sense and should be reported instead of
being corrected.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Add Quentin's Reviewed-by: tag

v2: Do not accept negative fan speed values
    Display fan speed and speed limit as 0 if register value is 0
    (instead of 6000000), as in original code.
    Only permit writing 0 (unlimited) for the maximum fan speed.

 drivers/hwmon/amc6821.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index dc35e9b21f91..8e3cc33d8073 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -616,15 +616,20 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	long val;
+	unsigned long val;
 	int ix = to_sensor_dev_attr(attr)->index;
-	int ret = kstrtol(buf, 10, &val);
+	int ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
-	val = 1 > val ? 0xFFFF : 6000000/val;
+
+	/* The minimum fan speed must not be unlimited (0) */
+	if (ix == IDX_FAN1_MIN && !val)
+		return -EINVAL;
+
+	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
 
 	mutex_lock(&data->update_lock);
-	data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
+	data->fan[ix] = clamp_val(val, 0, 0xFFFF);
 	if (i2c_smbus_write_byte_data(client, fan_reg_low[ix],
 			data->fan[ix] & 0xFF)) {
 		dev_err(&client->dev, "Register write error, aborting.\n");
-- 
2.39.2


