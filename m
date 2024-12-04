Return-Path: <linux-kernel+bounces-430382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256BB9E303B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC645B27229
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53433D1;
	Wed,  4 Dec 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PS6589Ef"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F253234
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270660; cv=none; b=jpgPhnZVl/Hki47cGxWrrfJ7XJrQ7MjUrRGLW//OWD3f9IyjuXUesiQhnvwAn61zz90IKxv4O3qCNahLRJx+8Nm69PW0RBUCtBDhDyYI0+AvqvU3NzLAHQZhkF24yt8zDXoi/ZiMSwnyXycRDaBwMKK+y0hPhNRUyvdMWkjIRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270660; c=relaxed/simple;
	bh=+ipD/Vuf+WHiBO3am03cEGfuJhA/9jJW/6w7HvVxhiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biXeHJpZQl+ZQ760YsK3hMU7lctRj1gJJQcXPzVJbWgU+eFC6HnVtBYdoL2GIsLngTejZYxvk60M3YQffmloA6iHd906rdiAFDH5C1/AIb8SsRvnUOsJUoTp2r4b0k2hPhYYY51E48nm/udWWXwvtk7BGU2jdUj+mDELdMEb6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PS6589Ef; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fcdb53cca6so1842548a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733270658; x=1733875458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4m7pNMsdgNYxzBIEAAkmRSEO/6g/enlI6isMmxPuL6o=;
        b=PS6589EfNPLkMBJE7QPiT5HZe5+kRBMX8llZn0HLTVb15lpo4ztq+DNGb4AGKFOWL5
         LFxilEAob59DyafywN30LwTSuwi4tcv37qd2sZLFO5wDQSCzON5ntYUyw6difkD8bCUA
         xOpaGdfxOm3nTzyfIuik9iaeeB7wYvy6FDkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270658; x=1733875458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4m7pNMsdgNYxzBIEAAkmRSEO/6g/enlI6isMmxPuL6o=;
        b=BX+GzcRvgZGxh4eAywcDWbPjyuZPO/LJYRaUbtmtYBbCuRoK9vpx6Ha1R2Hh3XIxpt
         beA4iRRcJCZaymThW3441NJjTfX4IzJy6cOT4BrJcX4govU7bWYqUXodRXHAZFi5XisO
         crUDrz75YFQnFGwRQ8bnCf35ruwBgtqb1CAD8wUmljqxqMGXs2kF5lWMK1/DQE5RHpqy
         P974Jyp4Lp3kxiyD/YmKK1OWyEwI8JuANQICrCY7Clsr0OH2H6kYCM3nc0DqsHdWEkOF
         hRzBEDUhcIm723qvR81DBZH2Z7S13RM35WZ73lpKiNC1uDiG8as32nyE3jLIPo8wCBAa
         yliQ==
X-Gm-Message-State: AOJu0YyZHJjDo5dhffAoOHGqnQOZZbxKn0QT3X3oKLVg++ZGUkBROQWl
	16AVtNN0vmVCEnzaUo8tsjhPwcVNfPyabTyW0dg1X8ysePhvDJHY8/h0zp/gV/EZTk1h+8frXkY
	=
X-Gm-Gg: ASbGnctKX53KN5YdzIQ9SYrE0EwPMf0X+S4ITgk/zotu33T5d+dP3LGSzJxUlurrh50
	FOlgYMq1IG3C8KP0cs6/c0vamPKqmnOA2ClyH2LkFj2K+yOOgMHWS24mhrwwAt10nJfWH6tKYAS
	dFpaTAWdOoqyca5ljyYfeAfthWhxifln+nFMXvzmTreNJa0rVCvf6rLczpNjSBQBK305OJy71uW
	8SNzEhZRLAPC6DV1duXbYp3quLPHhwjI1WCZrrK+ERBY83IeFcCLUJat564UcaDjreFS9ecaMPt
	dIgbJOz7TZhFCA==
X-Google-Smtp-Source: AGHT+IHYAWFOhMRMmsJogPCN+keqI5onO24l06foMGQMmqGxtDSAhpXuUqKm8NyRO5YVeG1E5lAVvQ==
X-Received: by 2002:a05:6a20:430d:b0:1db:ebf4:2cb8 with SMTP id adf61e73a8af0-1e1654132b6mr7413981637.38.1733270657782;
        Tue, 03 Dec 2024 16:04:17 -0800 (PST)
Received: from localhost (188.139.125.34.bc.googleusercontent.com. [34.125.139.188])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7254176f3ccsm11049434b3a.56.2024.12.03.16.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:04:17 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH] of: Hide of_default_bus_match_table[]
Date: Tue,  3 Dec 2024 16:04:12 -0800
Message-ID: <20241204000415.2404264-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This isn't used outside this file. Hide the array in the C file.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/of/platform.c       | 2 +-
 include/linux/of_platform.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9bafcff3e628..f09dc183975b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -24,7 +24,7 @@
 
 #include "of_private.h"
 
-const struct of_device_id of_default_bus_match_table[] = {
+static const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "simple-mfd", },
 	{ .compatible = "isa", },
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index a2ff1ad48f7f..17471ef8e092 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -47,8 +47,6 @@ struct of_dev_auxdata {
 	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
 	  .platform_data = _pdata }
 
-extern const struct of_device_id of_default_bus_match_table[];
-
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
https://chromeos.dev


