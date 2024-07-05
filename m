Return-Path: <linux-kernel+bounces-242917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE56928ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F265E1F222C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B916DC04;
	Fri,  5 Jul 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lACSADsK"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E153145B3B;
	Fri,  5 Jul 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215357; cv=none; b=iQeC3fPnmAedcwi+W5xRRCb7BD6kdJ0INVpEAIViFqEd9/vI8S9b+8g56akx+doLk7ww86zy+rQYNtMqA7fCZ2UNJiNIyF+W3OlCjUphKU7BNCCIwMiU2fykbLn2SiaJHivaCR55oZBFOnYfGo9+ddTlnU0VaT9U5vO6ojTp/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215357; c=relaxed/simple;
	bh=t32ubQd4OEBe7g6pwt9rfdIRcJfqxzvrKZI1tmn7TjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tknDZlg1hIvCO7mIvfxVve8xKQNNAOLW/bUAbV0C0ETDg8cYkzdUqEt/Zx2+L7Z/RoRExScWqpl2jQermESctP04yIEkQQ0kjZ8kxh6dNayGkQKbX1LfJK9GaH+kgokdYZBjLCpF3p8iOEHy+1zT8ZnkX9q6kiZSpPAaL4e4aDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lACSADsK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-700cc388839so1371722a34.0;
        Fri, 05 Jul 2024 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215355; x=1720820155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx6XwWAqVCmr7zhKaI4PNYIx6ePypUUY6x6wa+exXio=;
        b=lACSADsK2Vv5BxnZJGtde1w3Du9ToJEc+VStyXTANNKZv9uwHCMg4wmFsv6zXGjcYY
         sw+4H91ZzlxNf9MB/gKEHvP7WTj9AJ/qISevHrVP76MEd40tiOzeND68hxeQUKYQ8ipI
         krCDYdfjOiXbg+RGz16XXJRfm7ic4mSZFfZP0E8YtQE3cFaLNJqMvam1kF+u3ULb9IpU
         CaMKWNju4rT68QllYkNqy++f6NvHIvyL/DI48n5hvA9FomxeZyfOwRhVQoIDa30EBO0B
         hJE1vovN6tw8hIAfjwl9ypM9YnpjlJSnoG/xhSUse/V7ihr8H6POq+QOWpxALX25X9mx
         6qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215355; x=1720820155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zx6XwWAqVCmr7zhKaI4PNYIx6ePypUUY6x6wa+exXio=;
        b=kecv0yKrZ8CfkWZOkmEsNsyaDkqrtC75pc/qvy2DaGc7bTPa0jwNf7sPRiqu7+Xchu
         73EVgU01Dxrpc9Ny4geXmGuP2Kt4R6P2XDQIor0kZRW3qHEr25lvm6aAIX7K+oGMLnrS
         wDBQ1l78CKgIAkeVnxSVSGXHxqLyDZXRUD9OvNwQGExcZ55dDT9rYDg7SC5gbXpa/get
         p3sTSKBJBaZflQi3lsTyn+Dpk5JAJYK0fUCH5g0qSejR9MdXy4Bnc4lx1GRj33sGyNrK
         Zc5aEuGmwvAaHN1mLt2qLu1MGm3VnVcB1bKsWQs3gR4iKarItVBxa7AkPgQUWFb6MZ32
         Q2zw==
X-Gm-Message-State: AOJu0YwF82F9JvuqYnhPbXnKlkrDmwtqW8bLBzqhD6nWNaSICG7FTUu5
	gD/gTV++udwg2kqaBpVm2UtlKFg0UEY4SWpwfF95gI88p0w0AGYCvKAjXQ==
X-Google-Smtp-Source: AGHT+IEB6A+D2U1IwB0rRKY3xnOZwbgB/e4q5i7Vz/2Wtr/aqak9nXJs0oLrDdcb03mW9S26MHa3Yg==
X-Received: by 2002:a05:6358:441d:b0:1a2:4601:9197 with SMTP id e5c5f4694b2df-1aa98c76322mr490962955d.24.1720215354806;
        Fri, 05 Jul 2024 14:35:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm14960436b3a.91.2024.07.05.14.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 02/11] hwmon: (amc6821) Make reading and writing fan speed limits consistent
Date: Fri,  5 Jul 2024 14:35:38 -0700
Message-Id: <20240705213547.1155690-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
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
v4: No change

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


