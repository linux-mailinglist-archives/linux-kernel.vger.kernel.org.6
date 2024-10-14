Return-Path: <linux-kernel+bounces-363434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADDD99C262
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9F51C26ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D015667B;
	Mon, 14 Oct 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMYEW7DU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25786155A4E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892764; cv=none; b=i1qwZeKC4xeOe8jr0avL04YKkuVzf9UaSEvUdEqbVkrwRUMb9mQMWjf7yEiLBTCwRpBOgoIYKOIqPx2v+VTA5bokSHZJZU1PIo5xKZYYtnmicl+9G5Oa7UKJjB5yg+b1HcEB2I6c0FoeHZ1xKTzL55B4PQfYR7pjTUer9xc2p7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892764; c=relaxed/simple;
	bh=upgrwTvo7xO8WX12+oZnlIX+0zS10YgOPfhzCNsxdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv8YFFTSASEeOgFHtqdsFAeYoS+6Khjz627l8rE4xZS9AVLC0Jk0zPlK6tqj7dz21KK10v7e1J+BIj7OTCD6V7ZTA+4Hc09JLLiIEOZNJDNACKkrhr+sEs6rWgjSosUp0Clm6sGWBeWgBaIgwY2iWA8nZelase4AVUNuL5HuTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMYEW7DU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ce5e3b116so5114945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892760; x=1729497560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rITiXOpgMIOgb0l4pa06zrGp6TC0ZBdEjqCWpggTjmc=;
        b=EMYEW7DUMaWY4tKOVpbFCu+0Drrkyg9HRAdwhclhvOkK278TunkzwvLGdEKS0jxmq+
         tYDGyCzpPryaCXSTME2AKjPQJ70zY+2Ry19LjKmG+mgwV25ZrkuSpDHr14WGoC8Hm1Yr
         CoXC/1mfKIdLlDkxsYmpnQASHa0Or2NYKkhRLHAZIiPQCikTTuR9S6/hN44grbOgOdy5
         Z2S+3626hT0y/mV46JS+OTFyuxQfhBt/QCtDWmTKQgjzjThfiP5Y/DDcnMm0WOUBs2tr
         RCPLLor3Ie8TYNsIxfjm0axqpvSlP0+9TJ8WmxdHWQJN6hM9+0wfkGQDX4w7t9YIXyOl
         gIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892760; x=1729497560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rITiXOpgMIOgb0l4pa06zrGp6TC0ZBdEjqCWpggTjmc=;
        b=kCUCtHtIlf8yLHYnEWJFV+slYd00oYhpY1dTcaXWy0157HjK8clfRSI5uq3gpY9oOv
         OyY3ViFB1vH8bgKVnJUwUk3ckcKOEIeushO7DErh6VVqhXuE3hkuqGZEUlL4ov2BMPgJ
         8wgJCcu/kwAIF+bk8SRe7Ui+ecNBqjqgV1IxToCBBfzqGxMDNZvEyIC17gjYBlAF1knf
         8riTmO7dbEDme9v+alu8nU1jfFVmsDOirU2zvL1KTQUUpTBTJzuI8cVf19XPW0gLPOyW
         vul6FeNIdN5JHAFqrPp7YrI9uSkC8bfoh1srHS5PSzax7QBx2pXWWAn5+4LzSyYriVc7
         pACw==
X-Forwarded-Encrypted: i=1; AJvYcCWCWd3sN57qOxLLrbcUhZNjUZMQ/oasXeGZ6RxaiV0TiOOjN7OvlDs2Y0sFmAwPJi3EkDRNhJ5UH93c9gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzliDZhG0lSdf85zV9k7B+MMNzrQjIi1xJlX+9I+n06+w12Tqmb
	FqhFHS11usQyU+I1LJijXIBf4nLbwXCICF2Q18M9t1cquJGox6YZecuRYluS
X-Google-Smtp-Source: AGHT+IEqRspu7jOjsn6zm0jDrQMHpP/fh42hMbjigYXyF2deDDOlnLbWLfey54h1ShErqj1Bp8UU8g==
X-Received: by 2002:a17:902:ccca:b0:20c:5c13:732e with SMTP id d9443c01a7336-20cbb22ee88mr134925725ad.38.1728892760196;
        Mon, 14 Oct 2024 00:59:20 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c31c3acsm60738035ad.236.2024.10.14.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:59:19 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: gpib: Replace kmalloc/memset with kzalloc for zero initialization.
Date: Mon, 14 Oct 2024 13:29:07 +0530
Message-Id: <20241014075907.1571439-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the GPIB driver code by replacing the use of kmalloc
followed by memset with kzalloc. This change simplifies the memory
allocation process by ensuring that the allocated memory is zero-initialized
in a single call, improving code readability and reducing the potential for
errors related to uninitialized memory.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
 drivers/staging/gpib/cb7210/cb7210.c                 | 3 +--
 drivers/staging/gpib/gpio/gpib_bitbang.c             | 3 +--
 drivers/staging/gpib/hp_82335/hp82335.c              | 3 +--
 drivers/staging/gpib/hp_82341/hp_82341.c             | 3 +--
 drivers/staging/gpib/ines/ines_gpib.c                | 3 +--
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 3 +--
 7 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 1296db4d47c6..cff555447ee9 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -518,10 +518,9 @@ void agilent_82350b_return_to_local(gpib_board_t *board)
 int agilent_82350b_allocate_private(gpib_board_t *board)
 
 {
-	board->private_data = kmalloc(sizeof(struct agilent_82350b_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct agilent_82350b_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -ENOMEM;
-	memset(board->private_data, 0, sizeof(struct agilent_82350b_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 59f6dde3d966..d32576c21988 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -1199,10 +1199,9 @@ static int cb_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 81a952beee0d..847e4bea2cb1 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1105,10 +1105,9 @@ static int bb_line_status(const gpib_board_t *board)
 
 static int allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct bb_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct bb_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -1;
-	memset(board->private_data, 0, sizeof(struct bb_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 4e277997684b..cf92fc0b3337 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -201,10 +201,9 @@ return_to_local : hp82335_return_to_local,
 
 int hp82335_allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -1;
-	memset(board->private_data, 0, sizeof(struct hp82335_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index d37dd8335523..8ad1c885a9fb 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -459,10 +459,9 @@ return_to_local : hp_82341_return_to_local,
 
 int hp_82341_allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct hp_82341_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct hp_82341_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -ENOMEM;
-	memset(board->private_data, 0, sizeof(struct hp_82341_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 9dbbdb048b9f..87f9d3789c5f 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -1063,10 +1063,9 @@ static int ines_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__ link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index ef4b9ce36741..0a850926c118 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1644,10 +1644,9 @@ static int ni_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
-- 
2.34.1


