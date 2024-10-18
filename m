Return-Path: <linux-kernel+bounces-371668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194179A3E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE169285638
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F341DB352;
	Fri, 18 Oct 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nIdlTye+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE42AD1C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254283; cv=none; b=NXQkiitPE95jFN4pnZ5kpNqCJUhG7031d92K85pLOW9U2QKM92JyJtx4LTAUou7TFtjbME88LM60pMJKqg7Q7CjK7evSBq620Icb/ldsXYXicvrxGs07P5+KLrskDnZp0gSBx5MTcrfhEjaR9Se29CaCgb2yXBOCIx0V8EHFFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254283; c=relaxed/simple;
	bh=VHw/GBoW8BYLfS7z5ET9McRCyi78Nnx41JGN6LhxslM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYl4RHZL+DXRx/6/NSlJ/334f+P+U/1v176yD61TrbSH2hT4QphqN60gyRTCcI/6ei7TS0P3D5yXPkAhxBEZi29jcdZcpv3SQ1pzXN5BEnrWfVoytjcx/PlJbT5ZD2yDWB7peXu7MPxYTghxJNLf021r5J05mOqS3GSOzUKpVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nIdlTye+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d5689eea8so1483845f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729254280; x=1729859080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5yAXKgkvRlmM7Q3Q1r6EA4WE06NJ9JBCqdIMCdrQfc=;
        b=nIdlTye+wmKEaDtKSbUHJ90FX4PsC0svsQb0LCAdciJTc+ALmyx9fFSEsti1buisY6
         l4PakiXEF1kWWjz2NxJUIefVXWj76sbajUcDA/Lio1i8Un3I3txvSd2NuadSpjvJSVPn
         Mza8WTw4Jvobjuz2+M+gV3UEv2/ByhgWFbb2ycu4j2KahEMxHJPP+oBUFBbl0CQZcRuF
         e8fulZiiOaFfia7VLXZsuvw1/sFkefQpVjIb/c2U53WidRZdJryGzV2Z1vFQxE2Bq4cl
         Q0JaZmyA84MORS9wp8Xmfil37CMwK3AczIt+z7I7CQyKEDzaA3XwWNEbaD+Yv9ajKTSC
         jd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729254280; x=1729859080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5yAXKgkvRlmM7Q3Q1r6EA4WE06NJ9JBCqdIMCdrQfc=;
        b=uZM4CInrE06NBWyRF2ypVuJjEWFWSGXSz83dNuc8VxSkkGbxXSTJ6RNItHrs4c2EhB
         YoS0QQdza02OOPmxMJuObsgUfUZ0GqO2itxecdyOaxSP7eRIZGbb8QhFqEJPnyq9rrLv
         D6F5Q0QmY22MxTVC7rQD3J8TwcZzWHB4O+pMUksB0VT5uNiT10jvgK2ixKkAw6OLK927
         GxXJkJnfwe87EKcmB01TyGfH3eUQQDQfvicAnv3MHL4jXDyEX+6gi05fUwsVj+sEPDGQ
         xmCQnktz91dZJN9x/KN6UXmAjorlJrx6htf7bOPO0jHQVeKtgUyGWP5wm+OemaHR/kHg
         sWxg==
X-Forwarded-Encrypted: i=1; AJvYcCVULeFLmQf1xYNBePiiFM+R71txosuZky1NmvUpilJnWI6AKG1HKe2RU/PDzkUNlSNUMnDENWeuXmm/APk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEmJN6C03nBZEmtQvs1f7S33W/jL7MZ6IU+Rrkru8B7dvWtfW
	BaOG0KrCmIeLrm/dBVWJvGdq8sNq0T9jTlB5UhdzJtm3FnUur3py6if4eKuhM1E=
X-Google-Smtp-Source: AGHT+IG2ngeX0J6avQw7IRzxx332+oMunIxQk+ee9sLmJVKDrk/IfXceSnQQ4Nx6MNAMfwxAOrNzWA==
X-Received: by 2002:a5d:67cd:0:b0:37d:5301:6edb with SMTP id ffacd0b85a97d-37eb48a778amr1382595f8f.57.1729254279803;
        Fri, 18 Oct 2024 05:24:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf08a236sm1823351f8f.62.2024.10.18.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:24:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] spi: make class structs const
Date: Fri, 18 Oct 2024 14:24:37 +0200
Message-ID: <20241018122437.64275-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The two instances of struct class are only used here in functions that
take const pointers and so can too be made constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7c5e76b15421..5528c46edd0e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2926,7 +2926,7 @@ static void spi_controller_release(struct device *dev)
 	kfree(ctlr);
 }
 
-static struct class spi_master_class = {
+static const struct class spi_master_class = {
 	.name		= "spi_master",
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_master_groups,
@@ -3016,7 +3016,7 @@ static const struct attribute_group *spi_slave_groups[] = {
 	NULL,
 };
 
-static struct class spi_slave_class = {
+static const struct class spi_slave_class = {
 	.name		= "spi_slave",
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_slave_groups,
-- 
2.43.0


