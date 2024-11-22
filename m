Return-Path: <linux-kernel+bounces-418403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B29D6140
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531781F2113C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4413E40F;
	Fri, 22 Nov 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elWkONko"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8922AF04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288597; cv=none; b=o8QZYZeFnyZAsdwZorc48CCZAqXrPp+2Vzrmw8Np2meP1EQRRUvkM9FSDji7dgn5OCXz0Jqk8+zBUaJ7oBJLoLhk2Sdn1K06z4YQqfHLltKQuaW98nAgXFX2xltpHoxe1nlK4jchBO1MxwWX1ThwlYg9/heNKs0nlkoEtTGd1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288597; c=relaxed/simple;
	bh=cun7dEiN7T8oh+0jybyo9s97S4p3yuCQm4IK6MU9B1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6OwZYRvWZTE+/u75Bcr6K7TIXQ3AjzXHzhcN72x0ZZvVOFu3EDZrq9d2mH9kLuKXuvD1y26guTB3xQvxJBK3rNN2Q7pp0Cyou3tmbimBdA1JFOPdcQoMsinsAGKU+SZyMo/AHUqEXYCUzcS9bAM43ro3ncQrFseatxuTO3TDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elWkONko; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso19345095e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288593; x=1732893393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OWA6M/UvS9pJ9TftlYzyLXDp4MXIj0i5mGHyxmzQVU=;
        b=elWkONkoOgK+kN/fZznsLH0krK7MEFgYBFUNUFeHlw1OpPLFNmpojnjwe/hh/t9J2q
         SGjc6pvuIVudn+fCPiSUasG+Suv07zxr6QhQeKrjDRPjZve+ldDkXnhBYysYtLOLpnbM
         LY3nZr6v97/tJBuhhnO5BCMvj1IiVhd+o1LqfeYVwLIRYCXW62Aje4cYLCJ6Fri61NG8
         Rj8qCacsoLtN0Wf+PVCMxuiyD4kBM7aQd8LTLtimmD0t+VqzKBQqmTe/RshqlROriesQ
         yluF6bqnu9w7B98lpMKt6B4vARVIkrjCwOZ8mNdb0YFD14/KeDqqnQsYjI0cW5mGxLI5
         16VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288593; x=1732893393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OWA6M/UvS9pJ9TftlYzyLXDp4MXIj0i5mGHyxmzQVU=;
        b=KqluA2IgE+EmAJMD7vPWV8SmmZJWKSl0kxyfiqV3RfaPrgDuWzLKf8ZZkWmoCknO+v
         jI5jxoFtiASJ9KXXo2DYSWz04m/O9BNoMAWSa19luZTjVIevMBfYfwvN0V3xeixMvvO1
         Vgie3+nHfkJu2xpv9ccGolF0y/5A9bfYjIen5AKFnHSe6NukqY1qH6YzOoCPHo8EF89z
         zb52o5whfHo5CbdtyTeBiwuWu/G3rjzK5+eC3ozkAD43GHIG9qnlm+gIGWywWZC0cptc
         J8i7Q062GJOOFyGrquFB6cZf4i98x/ai91N2gcyssJL+ULqKM4FUHWHPaYNncoQjjG4W
         VGEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAoSs4dDKX4Ml+BItG+4jzdB4thlfqm+L1tJXYljs221gpvUuthCNQNr56wP2+1rZTiGrJDjI18YUEZ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1N1nWHVTOuXaO2BYIt3Ls36VqQBdiRi1wXOaEperLGuISgy5t
	XOW8774XXQh/fz/XuhFUyFn/yx1TFG78mDQ1ObC60e1s5rwfvc0+
X-Gm-Gg: ASbGncs4AjpZSH7z24QHifz/O/+dAQGoM6WSP+YdGclaMfHXuAwlFZXbvziov9w4nQW
	OJWCCQblgbXXGBaek0/4E1cKU1HuZJ0vLXnZPKemz/b9t9IFk/nCVzXR8D1BTOFzIvaoN8AoQGt
	unona1TwYEjj/zmd0F7JAISjWQGPmlVZb7PLaK7ymKYWy1zqypgtkJljJ+UhYOZlLh6Gh+30wJI
	f+ZSTyXeFpmVVdzCXuH6nYvgtyKXMlYMqpeATKTF1431LFACKBAh5CSx6XPV1Gg
X-Google-Smtp-Source: AGHT+IGz+8fAKH5evPU4VZ2LNRvDNnfyX3GYVTyMSb0khsaNbwxKpXeOoyGeXZt3bV4RJPXGmRh8Ng==
X-Received: by 2002:a05:600c:138c:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-433ce490ffbmr24899155e9.26.1732288593332;
        Fri, 22 Nov 2024 07:16:33 -0800 (PST)
Received: from demon-pc.localdomain ([188.27.131.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe901esm2676362f8f.87.2024.11.22.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:32 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH] regmap: detach regmap from dev on regmap_exit
Date: Fri, 22 Nov 2024 17:16:30 +0200
Message-ID: <20241122151631.220609-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
is called, which adds a devres reference to the regmap, to be able to
retrieve a dev's regmap by name using dev_get_regmap().

When calling regmap_exit, the opposite does not happen, and the
reference is kept until the dev is detached.

Add a regmap_detach_dev() function, export it and call it in
regmap_exit(), to make sure that the devres reference is not kept.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/base/regmap/regmap.c | 13 +++++++++++++
 include/linux/regmap.h       |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a6..6205c475ed594 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -598,6 +598,18 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+EXPORT_SYMBOL_GPL(regmap_detach_dev);
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1445,6 +1457,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 
 	regmap_debugfs_exit(map);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index fd41baccbf3eb..2a72111f33c4f 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -771,6 +771,7 @@ struct regmap *__devm_regmap_init_fsi(struct fsi_device *fsi_dev,
 				dev, bus, bus_context, config)
 int regmap_attach_dev(struct device *dev, struct regmap *map,
 		      const struct regmap_config *config);
+int regmap_detach_dev(struct device *dev, struct regmap *map);
 
 /**
  * regmap_init_i2c() - Initialise register map
-- 
2.47.0


