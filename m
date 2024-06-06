Return-Path: <linux-kernel+bounces-204329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8A8FE74C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234AE1C24D25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C52195FCB;
	Thu,  6 Jun 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgWk78SX"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F22195FC1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679539; cv=none; b=W1oo8JdllFnYj7RUX0vwIs1qvJUPFdIyLO7LE4rkZ3PeSdRXVkUfynAFqb3EqB3n6K+fnjZ8fTAlQna7pLseR1d6l8WSjTgWY9BBPJKCMBGCjt/xaHuzwOrQTeXX7m7NFCEOLrNgJx+Qif1t3fcUhlk3pLOjXBfC+80Ed9a2994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679539; c=relaxed/simple;
	bh=me6Ty41cRCSnMOmdHM0XNnCYCzQRzAGcL0KUR6aAOg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mNTOXHtq6bIg/1/Dd/8kMLzHpNTfRe+l+WECbfElPvwn+LluRmDfnODRbhO282rg2zai+z8cT+JYfYau8EYiU8E1UaiWoG42G6sumlrJJuBo1TBAWxnuIB4UfLaPIR4o7iUIjfSSfQ+HpKT4d7tDlKbw7dSKvSlIfUCDFP2YuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgWk78SX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so116996766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679536; x=1718284336; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxE7l690bffTKUzQL4YoKYab1ziPbqqN+8E58otRGxA=;
        b=fgWk78SX8ddpC3EEREr42d64HI1y7nQ22Omr+c54YWBSAgm1ki4ftHxPuX/dFbrmax
         Vydb4RhUhLaI/5Qo1SU3NBCD40CpR2mab47hE4T6g/HAkZrTdg4pH5TO+SXWJygrmtGE
         1RTev4hbteS8gej3t/w6KljVdQRL/mslxzIGxYYdu9Zl3NKjlXPA7CZfrpDp7zse0pJp
         U2iuwZ7DG/+/aDsgKANoRzmVD0ds0xAXjqJFTrBcN1Hv6LaWP5kzlVLDsTMlawHrZtL1
         pn7LHVIjUj5gXUJN0mKs2A7hjbd/UnuUobLRcscDga1WQoJIrYYu/sOPCoh/vR9qJYuc
         zICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679536; x=1718284336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxE7l690bffTKUzQL4YoKYab1ziPbqqN+8E58otRGxA=;
        b=AXtduM41ZOrTJoCNWGiYmA7DrFomsg/kR93BBK7QM7ujO+HICdlmaeOBUowBSPKUjJ
         VOJoP7AJMI48wYFFOYJmSlDzacoIX7sFb0gMqSsOHTWBXT/rmFSRoINRUN8o554BpRnp
         uP39btM+gBHmVU0ogLmlJtM30U8765lXIHjU5eGREnq6xfFPdwYbL6gknSRxqCNk4/G0
         jjpfvUwYX8JDP9EFd0JIFqALPMtc20TWrahOz3FxECMar5QOgNjQL0HbQdeEEPna5Z5s
         HLV4lW8bAYz+Vj7hiUOhPUGiHy9UOf65X7zXGy7qlzLSFdrCJiRUMvv8zmBHmdZxd+Fb
         q90Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB8SYhWRFw0+7TEmNXUD8aVOz1FxgwWcdjXlQEiuOS21QgjcpxG06q0QadjiopkHqxiIbOu+GSS6CJjvjlqinTmZSqGcSlMwG5b8V3
X-Gm-Message-State: AOJu0YziGzsNyDfftyRMrRlk0nUkPitx0k1pWPQ8A6FdNmji4xEBVsfK
	wK/AHH+TGj1bXNaLHkF7GdgwQm+TRmm/VINj77muw+VuHpYhi7+V/mrKTuipAgk=
X-Google-Smtp-Source: AGHT+IEz8YfL+SCPuHJF+3F2Q+2LZ4go3JrKNs5304zCp0iKQZ2Bs1sP4ET868nj7mSwau9p+NP6xg==
X-Received: by 2002:a17:906:390f:b0:a62:5ff6:c728 with SMTP id a640c23a62f3a-a69a025318amr374676066b.76.1717679535821;
        Thu, 06 Jun 2024 06:12:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ccb1csm96890166b.80.2024.06.06.06.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:12:15 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:12:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] hwmon: (cros_ec) Prevent read overflow in probe()
Message-ID: <42331b70-bd3c-496c-8c79-3ec4faad40b8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "resp.sensor_name" comes from cros_ec_cmd() and it hasn't necessarily
been NUL terminated.  We had not intended to read past "sensor_name_size"
bytes, however, there is a width vs precision bug in the format string.
The format needs to be precision '%.*s' instead of width '%*s'.
Precision prevents an out of bounds read, but width is a no-op.

Fixes: bc3e45258096 ("hwmon: add ChromeOS EC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hwmon/cros_ec_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 41f268fa8260..b3ba7247e06b 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -212,7 +212,7 @@ static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_
 			continue;
 
 		sensor_name_size = strnlen(resp.sensor_name, sizeof(resp.sensor_name));
-		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
+		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%.*s",
 							    (int)sensor_name_size,
 							    resp.sensor_name);
 	}
-- 
2.43.0


