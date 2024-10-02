Return-Path: <linux-kernel+bounces-346888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE6198CA4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408251C21DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006A748F;
	Wed,  2 Oct 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eETPGOSn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336423C9;
	Wed,  2 Oct 2024 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831298; cv=none; b=bIdpo74GR8t2AL1JiTYGqjMTqGNA0OQXQC8F4ojwERpGL8PcyQWhfNkcCGqQP/+hkxhCAWswqeYqb2hivBshxIvwW2JYrfr2i2CGWY1kzA63FQxRL4fpexAmz8CddY1oR8SWyjowaoKqGDPu/IjZgI8yvoQ8H5msYXUGFWUzU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831298; c=relaxed/simple;
	bh=jVbi3t8lZurLqhrQK/NOyeimKl6Es+3F/vDh1DUyOmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vyd3PjsVVCUWH9ZQsG4lShfsCs8KpwWvQ4eSpYfe1dUY25ZTsgSgwl2Nq/G1oqTVda9Cty/VDlxp/kVwsvqcGwOryknOsrZwT3P6oJn5/D8RrORrXxFtIlRbF1xFGB0pam4k0duAE7po9C/BfhhptOBd3zMp+VvP1k7anLeMPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eETPGOSn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb2191107so50440755e9.1;
        Tue, 01 Oct 2024 18:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727831295; x=1728436095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx+Kxej7yBgCfadZZmLk2XJn+XQWGOOPIR8YNo97uLE=;
        b=eETPGOSnhSTL0eB/iLj6oXwTIGWLRfoZxKUAfzNXz0swi/BWcP/AUG8TNiyPuZChaD
         +UFA0GRIQb/H0egUKoh11YDOhfNEKo6HWS2QrHgQ0J8Xst1TS99MRTZpqa4RYDM8GLyp
         Ce0BquG4ICUrcfqpXLab8aEgn6GqxK61I/90VPvlDM0ytwNGHtgKckhJhNoYEUlK9qSw
         G2Y1uGE9W6ribOCG+zDFXLkoNJSY/aAT5oPSwnEsFaIkJ7+VQdWfugADN1+wE+0VLj57
         QLejQ6YxlSsEqqMc/OxvLBpmeGReCb07e8DwbNIBhDkHmwAGL5yMfMKKIc4S8yyWP9ZT
         fJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727831295; x=1728436095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx+Kxej7yBgCfadZZmLk2XJn+XQWGOOPIR8YNo97uLE=;
        b=S+w+fh5FD7RI9G3t6tfxT+qy0Mh0dGlo9Xr5MVE0zJURVR51TkvtOiY9xVPkJch5Gg
         MHxkkhGUgl0KCNPmW6e9mcNpgUEU1oKFC6OOKKnwO0fZPecX7eoX+92uDWmAJ2Kww+no
         LQYAx802ZfKLcOXfdo/lLf8UVpm6KBbXLAncyM0oIAg8rEkEkxp7HoeD3dkH5KKE+HWC
         5OVL6JBPBfAIu9ngdu0t1zUMR/a1dicvKD7Vd2kQwkLjXA6dCmUuvaaipegrWP2At1sB
         PASZG7cYTmM4jHD2WFCX3ekPnBdRhAl/Kw5+nnZF+2OcGCTdUY+KAfE5XTH1xFXUaut3
         nRIg==
X-Forwarded-Encrypted: i=1; AJvYcCX7DBQ5itgdfiSEqYqxcJVKWxQum37lQD2AVPOcSTjqSxgpBKqF2h9+7hF3Fl4nCSfLhOrSIf24cFiGwNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVHJWPlwJwHo16MTbGROxV30+kl25iMjBsa5R+41J2yMOZBpr
	JtFV+1CT8i3OBGJRs8tgeCpN4kifHwtLJlVkFg4/XmhHgkQHySyxJ9rMFZ6x
X-Google-Smtp-Source: AGHT+IGDS0NPRQJKzhmVcMW728j9I+0JkafhR4lrNX7GcxZQTGs/UHtf6bHIHWkcP6d84k3xvHmCDQ==
X-Received: by 2002:a5d:63c9:0:b0:37c:c4d3:b9c6 with SMTP id ffacd0b85a97d-37cfb8c8537mr729518f8f.25.1727831294938;
        Tue, 01 Oct 2024 18:08:14 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e89b4sm12881345f8f.53.2024.10.01.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:08:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 03:08:08 +0200
Subject: [PATCH 1/4] hwmon: (adm9240) Add missing dependency on REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-hwmon-select-regmap-v1-1-548d03268934@gmail.com>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
In-Reply-To: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727831289; l=809;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=jVbi3t8lZurLqhrQK/NOyeimKl6Es+3F/vDh1DUyOmg=;
 b=DKDdtqqU9ePm5J6pbG59XRPsmBL2b3zR0PciFwjvUr1HfrngbDvn10XFU9qgAXOkoin1IoStT
 bdsR5gDjTRPCO0pkHY6XZR6sYbIQW8b4pHYQlBiVlqZftnMTMY0dcYm
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config and devm_regmap_init_i2c. Add the missing dependency.

Fixes: df885d912f67 ("hwmon: (adm9240) Convert to regmap")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ecf09cd2510c..f47f6a28d1c7 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -162,6 +162,7 @@ config SENSORS_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on I2C
 	select HWMON_VID
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Analog Devices ADM9240,
 	  Dallas DS1780, National Semiconductor LM81 sensor chips.

-- 
2.43.0


