Return-Path: <linux-kernel+bounces-432792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20439E5065
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C28286F25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724A21D5AAE;
	Thu,  5 Dec 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wByYVFdL"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AFC1CF7AF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388971; cv=none; b=erDcxxjirulRm4cDXmQzw26T2Lq5Y2Gg3HE76XlZ/qiLFHxkXRKGGuHFs/ezzaeIV/sgIljNh2lTRU/tMbFXz09nWhWOEcrhc/tQp5/msE6DSZp8g0E/UOgPfwpyjfKl6Xi38vq5eyzaNOs8tOWMpNaBKZTwOHfXhHGTEn1t5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388971; c=relaxed/simple;
	bh=MkKR7zoHkAA/29Xi9mWZG6juAEiowiopYAOTbHhhwzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izeSn5fbBTAbQjC6pPBSoIWuBpBj7VCndmDK86cjgBcAdYfFjk85wkgpkhlJRz0v+TQ2hw5wI2zke4Swz/XYmgDx//5X7mie2jJ/ymTI8bAtMGukLctYP3QbIAmkROgROFNrxCqfjdTeqMjKPe+kMvkCJSdYYMeszULE63cyo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wByYVFdL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a95095efso10609975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733388968; x=1733993768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTOc+0E4muFvnsRfZNGhHy3YqolkkyzLqORS9CmOfwY=;
        b=wByYVFdLiQtBlq53dMbII93zOhEE0E0ylB0w5Pt7PeZvCXoUarfPhbhTGEYC2d8kBf
         nDMmSiLwVVUIMo1EICxoO3yhlBjicZA+u5TvQt+xHWVdiFaoH4P0VNLyjlcJARSjM3Qh
         kFHo4uSK+cZNgdcyI98S7r3bzVmgyl0cwTgkkyP6WEGoPicqZu2hP4WICpR6cRhatYUr
         R5kGS8Bye8aHm6mFJyUzqAwlDY7cBKAddAclu3U0sDYhFg8jbpmFJrLPeOhEP77vEREH
         1B76Di0oN8bhGPgGVbYZb97B/lPmu9KxLcTy+4swUlQ4CxE6KlFBOvAi/xSFijMVYpp5
         JE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388968; x=1733993768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTOc+0E4muFvnsRfZNGhHy3YqolkkyzLqORS9CmOfwY=;
        b=LAN05Ku0xkND2PCzZUGZ9jzm1tCUnp30onzYZW60U1ok/GX7EMkxBy+VSl3/rHFg4n
         UCObul9d0/7eaVPqJkcebjF9yNEI8HzAHugUaud358TUSShlYzCyrTDnGJ7D8DxAv/LI
         Oe9RXbOz/qBGaT+MEkPdAH1eP3vQPwEwtheVrxAI559MnL22ILTg8c3jEB3zKL2TMmlX
         e9CJJwNnhcDyUqE0fc3NTzmm7mbpdIpDkRWE6P+LoxZ7WxF+Gbpcr/EJgu5cbyHLpJC3
         JKbWnTT5/wu8VppTmMQLVtnDCd9OtkeuAMo2ngPnHemppNDpQ8r56vN7a5KXR8wuw8N/
         4yQg==
X-Forwarded-Encrypted: i=1; AJvYcCV7dFkwqVeuwTzeAsugvy0K/+hofgNo4crYpnGyQcQEu8uBK+yuVOh7U93jonAgRxoIoMKSvp9wq6dFZLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45hbY+tUinO9C+0e3zUcdNPPjQe7vMOPLaWUOCqFQl+KRSeNE
	kshIk+k24muwjka9/l+rQPpZUUSeHhl4iRv5hR66ORDk7MoV4wddxLnNyOGuSnc=
X-Gm-Gg: ASbGnctLlXcruOQ9R+oxZIZ1wEcHphg3pkMHYeQR6pn3bgJRhYI7A87p0KsKUch2epQ
	OCp0niR+tAAiPzc9qRklWHTz2D/FdWoxoASsRAtQM4tY2CsBy9pmT6xLxcxJ+92K8IS6CH1AXe5
	nMtjCxM+K8qT8h+UdsjJqIBhxXw/LrNHFqMN6nJ7O3rMffKbrxC0FwqWUc0tw3HDK/kjTeNnQ/l
	QWi8YkxzGqKqG73JGgh84h+6awIM55/YwGgsAwnEAMUQNir
X-Google-Smtp-Source: AGHT+IHSZEQehupXgx1feFpP/8tl8ohgJEZ4bOfvfFksNWbmV+hAgwiqsJYFqb/viTeJ6c2p3Gr5ZQ==
X-Received: by 2002:a05:6000:2cc:b0:385:e4a6:5ae1 with SMTP id ffacd0b85a97d-3861bb5c182mr1845397f8f.8.1733388967909;
        Thu, 05 Dec 2024 00:56:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf446esm1345500f8f.20.2024.12.05.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:56:07 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH] mux: constify mux class
Date: Thu,  5 Dec 2024 09:56:05 +0100
Message-ID: <20241205085605.9501-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

All class functions used here take a const pointer to the class
structure so we can make the struct itself constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Greg: Peter picked this up into his branch long before the v6.13 merge
window, then never sent it upstream. Could you pick this up this time
into your tree?

 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 78c0022697ec7..02be4ba372571 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -42,7 +42,7 @@ struct mux_state {
 	unsigned int state;
 };
 
-static struct class mux_class = {
+static const struct class mux_class = {
 	.name = "mux",
 };
 
-- 
2.45.2


