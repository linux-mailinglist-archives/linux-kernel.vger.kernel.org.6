Return-Path: <linux-kernel+bounces-546427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B02A4FA97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D543A69C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9301DDA0C;
	Wed,  5 Mar 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uhtYePaH"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159702AF19
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168187; cv=none; b=Skxpb/cisXHwwdVionKmbCNxeaZBQtGxAuxV1tSEHf1h6EEUnOJBLE50Y/Xoio8faXKzhlvcgiL1KnHzGZraNZ0q30HVZfLkrUbAbEQ7EWFo0x3J/D1bQ3JMk5DF3B1CECwp109GGF/QyYg7HA4ulsrJ36OiBrHEtFFupFlsfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168187; c=relaxed/simple;
	bh=E/Pq5yil0cjvU/ukMT3gU7USItiQoOxjeOU2SRQfly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCvep6PuvlMZowXWkB1FBTJEQITr67o1CHwVFlSPmdC9yVJxuqc5HR1VXexP1lnap7AjJ52NaaKhvv6DZg5HQ7VSzO1k/v1O5YwJb9b5vHFsn/d42nlgd1xAZYsSvc/r7MOXSCy+TU5b0ppXOibhBJnW4V217upoBhL76R8wWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uhtYePaH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390eebcc371so2943108f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741168183; x=1741772983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5UjWZ5weILsPr8XknPLuQcsI7+ozARlM9fSmGa2npI=;
        b=uhtYePaHMicj163yVgeoz9HVpObnyQeqY5tDSoBDW4VsjfExxsk6pkjEkFmUjRxhUr
         CFI44y99WkEd+PgxuDLiB3FCoubMwBqRGtJ7X5eXXrvHa5X3eysizExUy4cxLvVuUDKt
         6LMRmEJ9uVzrixup2wlWZdUvhYN35Tfg7cJhUpKhn5M8vhyOFyiqEIyZXY1O2I6SH01L
         8LhiGC4/zSkIAzMZnC9wg3eGd9HP+l3WwDLHuFZyCoI4wI550/NOfthHWrw8gvyKJTHI
         mj9M5ctN3Q/2LtX0qgn8tfDqBzlWFmxmS9dT8+n4OO+Gt3k6PVASTRK24jtv2URZXRbU
         Kocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741168183; x=1741772983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5UjWZ5weILsPr8XknPLuQcsI7+ozARlM9fSmGa2npI=;
        b=lsOASH262ZhhTOEY1PUh7/vhjP4oumdu/17kud7OAX7dEkNNFFLSWwsgh4AXUsw0wT
         rVv3PVhTVPivYwf9lTYt2LI/bsY6vH4ihz1FALW3r1FWMa0KEO9mcSoRIbDwDSu+OscI
         PLB/c5OwbUEzObTU0n9M0gi2wYsXXeZf6JW0utK5zLTStl1k7TjXKKn7JFSH6Fu1lRyW
         iTzNj7xbSda4EnKoiH83Eh72LD4BeLCNkwasWmt8T2J47rmYIKO4f2wEmtdCW269NMB8
         qnRN0EAsQYV6/nWwUiWbcQjR/2t+3PE0La+zjcD/LfEtaoU7Rv4RA2g9k9u6G/QnxGvJ
         jg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZf/nkNg6OapWzz7taL0Ns4XGg85dpRnkwoQvIeBnsJNqlaQU7WVNCc+vbCOYSPBHcSj/SS7zunbgWJNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcEZ4MUb7KpdPirtsoETKmwsehQw/QBZFXbaNibG6SEAHQDqgO
	AlWJXPKn2hsMdpaGVz74x6I0glg3sNZdZbHpdZMxqyoSH+uxnN44LVwF6AW689gWpK3Uz6c2kEt
	V
X-Gm-Gg: ASbGncvVq83QBpIHy4O2/TTin/QYq82xM1DwSCHCsbSCJ2zSz7mvU1EQttDnvRfYRhc
	2Qyu45H8CONB9OefGzAtSDgW+ePjjB/j/CLgl2DSMlJmfBeQXYgZmyb/CxXoNB7cU4ODniHbLTt
	5h3sBHCPUYw4Vu5ej3dHU6WcR3catsleBqGm/jw7r5oetgYdbzucoipqaj+1vjCqaD/5opKElCg
	a3E+FKt78ntsN9y9Oya2mPXDplSOUVEh9u0cRYGt4RdgniHef+4S8LWE1J73f34nVkiPZi7tYpr
	9vECif7k8vwewySFJcMaOrf2twuiHJyo+V2fQ13bW8Ro
X-Google-Smtp-Source: AGHT+IE3ZYndRd3aCGcDy1NsnHk1JcSuobolN1usfY3/rOQ1MO5BYlsEICE8u2lBmL8SzFUnc8hOrg==
X-Received: by 2002:a5d:6da3:0:b0:390:fca6:ceb5 with SMTP id ffacd0b85a97d-3911f757bfcmr2025359f8f.27.1741168183239;
        Wed, 05 Mar 2025 01:49:43 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e514:53b3:5af8:e408])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c60c0sm12272005e9.22.2025.03.05.01.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:49:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] gpiolib: fix kerneldoc
Date: Wed,  5 Mar 2025 10:49:39 +0100
Message-ID: <20250305094939.40011-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add missing '@' to the kernel doc for the new of_node_instance_match
field of struct gpio_chip.

Fixes: bd3ce71078bd ("gpiolib: of: Handle threecell GPIO chips")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250305203929.70283b9b@canb.auug.org.au/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 83e0a7e86962..bbcad928ecce 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -548,7 +548,7 @@ struct gpio_chip {
 	unsigned int of_gpio_n_cells;
 
 	/**
-	 * of_node_instance_match:
+	 * @of_node_instance_match:
 	 *
 	 * Determine if a chip is the right instance. Must be implemented by
 	 * any driver using more than one gpio_chip per device tree node.
-- 
2.45.2


