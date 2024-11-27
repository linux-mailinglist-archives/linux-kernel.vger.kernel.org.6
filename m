Return-Path: <linux-kernel+bounces-423971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF859DAEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F9EB2239E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2D2036E5;
	Wed, 27 Nov 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GABKFJ5b"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD0201260
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742557; cv=none; b=ETnCoxvyVbHuFI+Dr4WdnzHya+SjnY4RIl4MxY6ea7HD8T6m6kZs4/W/uC1cEyk0VamC64e7EYp+X8T2ESYZwJa8JgXEz5KTijfrisotdqrx0UIswFX+uOJ82qGVgNjyQruINWzhcyBDqBWHCcSsfO81yVc1q1JTUBR3gk0CTfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742557; c=relaxed/simple;
	bh=Agnjbz587P4oSCogC5lLzBSRTTaiXdovVtgVuafHtks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoptgAFcM28fkLorLeID6DneLXAcbzN1wRZzO/U34bZZlBwm1mSZj1U+rO9aug7B+Pt7QnS6MGlZPzxpXuDvL212DTa+S73ioojyDEOOzg30/LGSDn+jKHtDY4/bvtUOWTgcJSlOVE7MJdBgHW9ZO7mL2JcGg49AJhWxrfh2m/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GABKFJ5b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so871215e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742554; x=1733347354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOKP8M1nDZ9OKJh1q0CWeqQ/iPZ7vzW6ilNHfYhI9VI=;
        b=GABKFJ5bLgGAJncH9pCR/ki39tRwlD+Djr5Q0do1kpnuIkLwMQBA2eMPcH+yUEM444
         zidnk0DxL4EkWMmoySgKa/y13FgllJzI+WwOXy9hnXJOVS0Gsd750RIfirQ6T6QRlfTv
         c+MEdvmAfIspZNoBSUb2cCYgYRdwR+WPqtC7t33RwPHHsJX77sH996h20DmVCBvky6E5
         R+DRBdMlNVcVELZrw8pDfHbj7WTsT9nw0OvMvyL9KcWjNQ/Zl14+GEc5VE2eOCZ3Q7VT
         3CXI00W5XQVjZE8wQgluZDs0Zp2mJOmbLbV086Ra59wms0963UvXYY781dfVPi+eAbkL
         aLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742554; x=1733347354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOKP8M1nDZ9OKJh1q0CWeqQ/iPZ7vzW6ilNHfYhI9VI=;
        b=JkdlOAcEyE/CTGqx5b4iaXjwCejWVPbXZgECJcAou6nncIY5uemwrtfTJUkENAdh08
         ZXtL5fUqHbC9hxpWm7nm/qhjnEiR+9TrxN/WV5qQkUdzMCy15krKoGWk5Apz8qIjm/uV
         V+j157TKlmmlD5tTak7HTBImJL6CzQYYItnF5V1z24tQTk4ljIzBWQmtVz8DR0Eqrkdj
         AvFhfJVKqpHjRJ+ELdDNRUX+TI9XqAqGDtX5sk1IcArcceDBoYlUlkm4lOFVgSyIKRc9
         EmlNtizgJ3LTWIYAQg9q+Q93JtC9iOJ07yKUroBMD6/UjUsb0rNyFTzMY67GlqM51PnW
         a8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVd1piW8SXznwo4to4vVP4ECMrglbtEOs2BKFV8RvoVFtWiTsNnfEnTWEQsSVJmJVEkjI1zWtx5IbMSq7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdlEO7WrdNL0wcahdO1cgGnFhNIw0Xb3oMwP1Qnm5qR/Ytvsc
	0qbP6h8YZwEQgxsy2njca/drNixNIC76RBdwRGPGnfdwvo9UxbVe
X-Gm-Gg: ASbGncs60x3jIBX+sBu2F8mReCYHue591RKf4JBOt+23S9Kov2eTKaOIY1MstuqG+/f
	hEbj+5OdYd9FkBkwcC0FbQSNKZijgfR9n4MPsNlqpUMqmc5vKzEu7gT6VkrE6biQnTW9FZb2c37
	9TDEv93vrx4SuL4wUeh/nTY5bkxJCOtDXM/AyMpL5LEgk2IQNFYgR+sMTTWAJ+Y5RsJ8eWpbagI
	5oRIMquURJVzR7p46HjN3O4dLm0yYoOtOyjykoulanyJzD7Zrf7f0xk4/wdK4g=
X-Google-Smtp-Source: AGHT+IFyOC85pA7G5rfMZI+Xvk/NzuEGMS/EOrXcNhS6i4CT1eXBjcLFu/uRA8eXycyLNh+xOE9yWw==
X-Received: by 2002:a05:600c:4f0e:b0:434:9cf0:d23d with SMTP id 5b1f17b1804b1-434a9deca10mr37347595e9.25.1732742554027;
        Wed, 27 Nov 2024 13:22:34 -0800 (PST)
Received: from demon-pc.localdomain ([188.27.128.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76b52bsm32148505e9.18.2024.11.27.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:22:33 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v2] regmap: detach regmap from dev on regmap_exit
Date: Wed, 27 Nov 2024 23:22:31 +0200
Message-ID: <20241127212233.330983-1-demonsingur@gmail.com>
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

V2:
 * switch to static function

Fixes: 72b39f6f2b5a ("regmap: Implement dev_get_regmap()")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/base/regmap/regmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 53131a7ede0a6..e3e2afc2c83c6 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -598,6 +598,17 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 }
 EXPORT_SYMBOL_GPL(regmap_attach_dev);
 
+static int dev_get_regmap_match(struct device *dev, void *res, void *data);
+
+static int regmap_detach_dev(struct device *dev, struct regmap *map)
+{
+	if (!dev)
+		return 0;
+
+	return devres_release(dev, dev_get_regmap_release,
+			      dev_get_regmap_match, (void *)map->name);
+}
+
 static enum regmap_endian regmap_get_reg_endian(const struct regmap_bus *bus,
 					const struct regmap_config *config)
 {
@@ -1445,6 +1456,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 
 	regmap_debugfs_exit(map);
-- 
2.47.0


