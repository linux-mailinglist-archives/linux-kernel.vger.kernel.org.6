Return-Path: <linux-kernel+bounces-523360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D367A3D5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DFC7A68EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA71F03DE;
	Thu, 20 Feb 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mNqV0fLu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E71F03DA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045440; cv=none; b=jG2apY7xHOSfJD4CxTUDLErR2ty54VFfg/h41MYAAuHWFzFOpALcQSq1Jd4UG5EZ7ttRgAIM5ezB8eGlpu9sqVfsMatUysiEMM4JAg+WCto5ViblCcpRehPQwioJ8Efbn7+Q1N24sQIYCv+QDVQLIuo41Y+WyV3kPuXmsYMsYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045440; c=relaxed/simple;
	bh=/gqeqRwMs8CevwwaRvu7rMfOHz8FGAeaeJay3AIimak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Neu3do+9ZaYt2VSv/WtnjV3Cp3uQ+6kL25jFmbg2Hv4g5hFEiGLTIrktiHpogC7iCSjjMQrMb0GdpiWTG9lRcby42PnkbwEKLs3uESb7J5+nvUZTeXVixqXqeCv1nF/MnBzxR+DsXBSeBdPaL57Z9nLQWCN42G+ExeW/+PbqEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mNqV0fLu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so4406425e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045436; x=1740650236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePE6aVSyq82nNiteS0eDm4Murw6GeKSP9YRuA1+AOq4=;
        b=mNqV0fLuVu2L5+QXJoh2GuOOj6dnK1k0W/KI80AeBRCN7EfV/v29KcZzC7aS3NGi5g
         02GsEZLzfR1cDUH7vFqFyDIl/8o49E928FwZVOorLuc8KVVfJDifD9UFqQigN60P4hDZ
         J12zXzOhcUhKAUoaqbiWO9amXXxMy+uRJe7IpIhmt/Vg66yKdYlpYUiwWgFqJZi6LxJA
         oWyis+a8oqroRe7E0VaP1JCvnyRINAHmGHrAbgty0Cm3pMYIvsfZI5cds3k+bb6M6loQ
         nrH0mhrweh1v+z7SlIyc7HukEx2rLnNYpo0e3iTGSc18jZP2CkouI3qZ0EszG7JgQcYs
         LNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045436; x=1740650236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePE6aVSyq82nNiteS0eDm4Murw6GeKSP9YRuA1+AOq4=;
        b=t+oZYs3NEbHl0zyLrpQ9FR6nREMJxlHNL+VKwX8ruaBe2qPFLBp8D+IcHKxbTKKLKC
         VmTPzHaUVEa/VV0+YS4d9OE6gH92RkTT+pC1CsiKvMIQzScfDGvwjE+CVgbJLdw1WlgF
         BkL9uNRYzfMDpjdbUbQndAXFg4gabkax6CYR7t1kHX279J/AIdOd3j3LbEWc6MUDAMby
         TvYavqG6DAzBMl6eKloitCoqDQXre7Ye41fCjHRBV3M/YWMrAhZbDDGHvUTHYz7fTPTU
         +yeyFfuEVJpeOH8fCcl2I1/FhtdDYi5v6KWLRK1CVf1ujbeN3EAwWDwAQRNKUJ8yCwhc
         zwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx/2iWne3nUVY+rXJ9VaiqCfRjlM8jXl0FhBZMc7gHCGTnV0fzOVkH1I0ukNHX3CSaGg5sz9yLH2Z3i7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nLc9Qqw20aXoCaPdbqYY6pq+CaTE0cJCkuO1KyI0p9Ehknjs
	iju9IzoMxiuR4QMFcZ/N8EzzcmAtHrtTPBZRcO2e3NBe3/STEDgDEmaZStcliVA=
X-Gm-Gg: ASbGnctFHzGFaOTUlRKCIvnfCoIX1ZBCgtSy72544de88NrgJXzeiRHvN9YXScs7pr8
	ovDAWulz+loKbou+8me6wtdSn2jNKzwjkte3kgV8XoemlEM4PlXH2XMXbHV0ryv+IETOAzOCuGy
	Lo9mMFTxGPOQ9av4ew1yBIj0k3V3M8yox/BpRXuWUYy8Po2nQ2Q5pjyaY+carS7Yn3tZgUEPD1F
	EykcfVbYzBmwLLeae+xxMzcQad9TXVMMy/I5tSl6ZAjkmpS38O1cZ/Jg5SvB7VONzTFdkfj7B7c
	kbM8WtI=
X-Google-Smtp-Source: AGHT+IEJ18E0znCg/W6pI6SBZ6POwzntvKs5Wddj1jzrAx7EMhapZSXX+0+m/ezVaZFBdWbuk2I/Mg==
X-Received: by 2002:a05:6000:b07:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f651405d3mr1047722f8f.37.1740045436112;
        Thu, 20 Feb 2025 01:57:16 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:56:58 +0100
Subject: [PATCH v2 01/15] leds: aw200xx: don't use return with
 gpiod_set_value() variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=PIuGkhnXNIukoW+JQ2UdGjN/QTq1yPTYeOxQX3xtWd8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx2ZKtP4FP+4pU3UV9J1oA5xxYaJP4wFaj6s
 eKwF6do6XaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dgAKCRARpy6gFHHX
 ctGWEADaiKjypEdiDNeOeEm1nP8JwKq7Occ+KYMcJrlW2mkA6sC+tG3lFxgXKdHHkra8cMdvmeE
 yKalq+0h/rNSkpMUJhlg1TMVaFucMWJSqvZca28OccapHZu24j3I4l/+A9kapSZvlk8n9/kC6o8
 N5AfP+VRR3Q+Zj4V5sq0NYLAuRHwQOx/oESmv8OFHwI5ihgB4rGXQh5Qhwp2JjitTiZDy8QAS6m
 frYj/XuUZXMo1yCr/uCgSgEyDvWe3vhZkRj48p+eivBPeibHsRXJaa9fTzutNFfdIfCna8TIZXJ
 g95pL2mCdWhrGWwIuj6jccIUSyV+twxjrXorYhRB4ZaDREF/hu1MD8mFRIp8PUxCk1T3Shhsdwj
 3IEcpvxalJHy8mckvNeOpQGqoL6bphxTTQbz0hKJfelAdbdNkph5Yvy93r08vg+YM9AxGJqlqQM
 TYOcyugVDZUc92iHjac5lV/rz5h2LjhYhDrCJ1ZE5rse9uhAoLfMpfWHLiIohS1N43NM5xr+atb
 ILkzVHghd/xo6/q40EF4GOhyVmDR2Xvenw+T4rH4zad2I3KlyVEbuNxwKFIc9kkTIEEySJVXARm
 DmO75+rvkfLQb5t648rPOARandd31y2oTkZE3B6z+Mi3r2sR2TPuLVSwoMaxf5LMTvA2ds/UyhC
 HngwkMA5k2QKIBw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

While gpiod_set_value() currently returns void, it will soon be converted
to return an integer instead. Don't do `return gpiod_set...`.

Cc: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.CmoMg9Q7-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 08cca128458c..fe223d363a5d 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -379,7 +379,7 @@ static void aw200xx_enable(const struct aw200xx *const chip)
 
 static void aw200xx_disable(const struct aw200xx *const chip)
 {
-	return gpiod_set_value_cansleep(chip->hwen, 0);
+	gpiod_set_value_cansleep(chip->hwen, 0);
 }
 
 static int aw200xx_probe_get_display_rows(struct device *dev,

-- 
2.45.2


