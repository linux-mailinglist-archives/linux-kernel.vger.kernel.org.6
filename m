Return-Path: <linux-kernel+bounces-429859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B89E2AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D9B810FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267B1F9F5C;
	Tue,  3 Dec 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dG8ZLu4m"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1961F8ADB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244113; cv=none; b=D3Ri2eJzhEF6O1Be7jeUfhYPRd8QE/1jdtZBm/n3wxQ6ZqTadj27FsNpeSB2EVkydsCFkUwONLCYIcAep9M6kIytDOO9DEIWuOtCxxqRcd+KiOzVOtwLOe2CSCbKlF46kxKdFkMXPXdA1HK+Xmc5DR5ght4S4KfR5uq5OEvhNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244113; c=relaxed/simple;
	bh=79lvtbvvn5WeBGU2jOePEenHhsByMveWov7DNrhlJkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqY+qGKeHf7aCBGiUY8Qd3w30djTNHeOeRPCARjgXTxQVuNKIikcn8ebGsm1PwKoEgtGxEHpQ48yJsTm5L+IDuBI6giETqf+DXPALYVr40AbvPlYpRvbdGRlz+B3g+UAuuVa+f5+pbN/D3kNt6JWSn+QJJqOXCoD7U0oO915dRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dG8ZLu4m; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc016f301so62793061fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733244109; x=1733848909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E78siUumg37DyNEcnTfFgRjM1O430FWuRK5MEMvIBtg=;
        b=dG8ZLu4mlAbl7q7lRFVpfPhuaUNxxUL6RZmeXxS36WjwAQkU0T2S8C5rxQX8uuV3eU
         U4IlCSIVtrSZkmK+eurG1t7Yfmt0AqQGfgOQIygNpfgue0K9LUkVWEbNHSrmgaHMdEpi
         6TXT9KZqhTJpeW9OIxRI28Bu1uFMkpG+3c+Y8QWVioIDmnYryMqFiuAbBHdzu8eJOG5E
         Pq3GueN/iS0GC5slvsgxlHJI+Pzz2Qgkl0vkCHZMPZa76PbjBrNoRxkaf+zm62I81izO
         mrJ1dsBk69P7wQitQyuJ/A/iuX62oP6nSS3nBKGqbtABMaFBXtHsc08HXF6D+L3I9swu
         zSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244109; x=1733848909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E78siUumg37DyNEcnTfFgRjM1O430FWuRK5MEMvIBtg=;
        b=RHHFb4Xhm1HbHRJ2mrHzqsjhnzCZQAwsFg9u4KeuC/PeRf0P4tgjzTm6WTzEM0USXH
         lu8Ugm67oTxvn1X1DDetaSuQDFCgrx2bjDggsLAZ4XN9nQLBwIHh7O1dVjWkzOyhvo/I
         DCasHN4VlUYShZfOx9gKgNyDIMKdunYp4stMav7pNKymCcB1IuS1fGK0v7fywjKIafIZ
         1YrumaHL1VLy/Uk5XqiEuPkpAc2Q3v/jkklhJv1n/u1XTpGicyGITaCcsyUOHIDcjo9o
         VmfL2WywNiZ4q8thTfSEypOu2VA2ZYpJOIeAz1nGwTg37uZzmVkoblrwH1V66B8vf4JA
         zDcg==
X-Forwarded-Encrypted: i=1; AJvYcCUJmQbgvBfZsh+zmHVUkXnfTU2OXYTio/Nrfy5aevysGAgAgGAmbSNcx1WedcUxy4fCBpuOj/3jWE/9Fq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzirVGVZSJWQhMvBZZWhARWgWw+Q26nt0b/5SXXLo9hkwU4frmg
	WjXoADSp2IuxicQ4l8FgO93okMUA/4EbXag1ltQvCHlTr0qqKPx2DA7XgZKmTu0=
X-Gm-Gg: ASbGncv3HSKnD+oUWOicKhjbKYFGUd9oKhcBi1ii5AyB7DDL62qYk4VZoYmo/Fku5eW
	WVRnPWB/g3nThX/abGHoDI4qj2qd1P2yXdjHdrg2B031RmF6ScYLPqSJJKQ3Qd9GV8EiNS4NBkT
	+ANao/gXlFtFNEi0IRMoUyekXfbI1cNc2CgNtUOr5t6/QdXmYCWHAeV8kqn5kVfDj936++k8A7D
	MrVvQsWqSqVRiOm7m8QeyHvf7q3OL3vcgoy3PKWwtq8KB8QzkBynlyenMUJYqkJBViFPns/XB9U
	mGUb96qG8FaNyw==
X-Google-Smtp-Source: AGHT+IFx8bRQqNDnslqD1KoTl7xzEuIl2AL3peCZQQRxuOaindczpYRpHJlgrK/K9HMSqBDkd6UiiQ==
X-Received: by 2002:a2e:8e95:0:b0:300:1558:7db5 with SMTP id 38308e7fff4ca-30015587ffemr4110501fa.27.1733244109275;
        Tue, 03 Dec 2024 08:41:49 -0800 (PST)
Received: from brgl-uxlite.home (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3000b262f32sm2482161fa.4.2024.12.03.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:41:48 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: omap: save two lines by using devm_clk_get_prepared()
Date: Tue,  3 Dec 2024 17:41:43 +0100
Message-ID: <20241203164143.29852-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203164143.29852-1-brgl@bgdev.pl>
References: <20241203164143.29852-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We can drop the else branch if we get the clock already prepared using
the relevant helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 54c4bfdccf568..57d299d5d0b16 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1449,13 +1449,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (bank->dbck_flag) {
-		bank->dbck = devm_clk_get(dev, "dbclk");
+		bank->dbck = devm_clk_get_prepared(dev, "dbclk");
 		if (IS_ERR(bank->dbck)) {
 			dev_err(dev,
 				"Could not get gpio dbck. Disable debounce\n");
 			bank->dbck_flag = false;
-		} else {
-			clk_prepare(bank->dbck);
 		}
 	}
 
-- 
2.45.2


