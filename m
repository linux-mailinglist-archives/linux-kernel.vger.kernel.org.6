Return-Path: <linux-kernel+bounces-343223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE22989852
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B01C21035
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01514B970;
	Sun, 29 Sep 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdWjACsk"
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50D33997
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727649503; cv=none; b=PTg9vyLOyjwZtAjhAN1zKmL0e4RmZxNzk+1mBWhEcY2nuXYEdXfU+11Knhu3eQYPwdM/0m1NcSpTgSOFfvz3AjbTOOLcgwG4GkGs54BK5HLN91rTbrnEm1IGh5ji+gvzkswkjDxQtWH0VNttSK3KHhciTgUZE+e/KJGEV6r2SJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727649503; c=relaxed/simple;
	bh=BqgXMcpiBYSz2mv1f9cadM/Pl/lSMCVsOWuqcbjPU6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lo3A3d/YFzKL76KDxmeC0UHCJizC5rUJ+AAn0QIiezeT9jEShJMgyWqQ9cGiAuEAzvt4CLIGSFt4qWy/4aQDTSjc8CUYGsX4amppb9G/Vv0v7edWuiSx49NnopsrFMfN6DJrjCg7cqlJgWpPeWpiDoqEy/yR0BYmD0cb4r3Jw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdWjACsk; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6cb4c013b78so14407166d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727649501; x=1728254301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKOU2k5mBo6Lu/kHXBlc5WVkq1dAquASX5qy359B/hM=;
        b=CdWjACskEtTc6uaW8hoKtaC9dJBGKbVADM7M3P2w7OzwVzrEfunzjEJ5MkWLsFpusb
         zzQ0kxAobqTjpCvybKf+SB/K5Ij2AEy0FcOyUypkK5CvCDMrWz38Bd4ROK6ovbquJoja
         dbcnFlJFFhArXShP07iMVy7ofZnOrlXtuU/PQ/Odt+ocXodPxD6M282KnKKS4VZMxvkA
         deP7TzCTTRhcHRQ4k3HsrSroYPdn3vWr3OQM0qIOcTA7T7dfiVT2J1xkLeH9bAA4jXyC
         1SONKaFgpU2eVMXsDKX2wtAc3zmzHQMIgGd6g6ODbq7U9S9sD08IJZPX2hQRDaHYKzOg
         x/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727649501; x=1728254301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKOU2k5mBo6Lu/kHXBlc5WVkq1dAquASX5qy359B/hM=;
        b=XSrKXtvCaUSvuKKFkUP+dh3/jwAJy0D3EfyYihYgo7UqZNje5scWe1zvub2SuYRum3
         3d9bHtrsakiz/mq6GOK9b3b0Y14a6et1pO8Ikvn/5ig+uFmLgPSXcv8FkY9YznGJmSgI
         gnYD/KwOenP21XSGR9ezny1WvNf4ELrFyrcgCx8q/bFO5M1IIbNloJfRkJS4mAX8uPbg
         loXC9G6L6/onr0Yrt13V1bYaG2M7sQY2xjxhPI8qPwlCRruHLB7187/m1dZp8dLJQ74s
         fTleYeXoq7cqGVj2EXBqHe+SOVq2L+B+OZJ3P5a3bPD1hMAIQkAEydUGuvIZwJ+ZIorm
         sFeQ==
X-Gm-Message-State: AOJu0YzgD7oj4FJwqLxVvplKCGrxPQv7Iq8+kNK9zh8x0krvcOOrhNjw
	XK9KmNtchhdgHl+KqrxZbH1/9OgH9N3Gam7oMezu6WqPbVeC1ISL
X-Google-Smtp-Source: AGHT+IE5e8V+/f+U/bptwvJ0Z+YZ1ZmVGQ2foGt8PRRkTiZ8wCrcZtomhOv2PwXWRH6TM92g/LP7BA==
X-Received: by 2002:a05:6214:43c7:b0:6cb:54ab:a62f with SMTP id 6a1803df08f44-6cb54aba7aamr82602086d6.43.1727649501264;
        Sun, 29 Sep 2024 15:38:21 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68ec2dsm34638776d6.136.2024.09.29.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 15:38:20 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com,
	stanley_chang@realtek.com
Cc: linux-kernel@vger.kernel.org,
	Gax-c <zichenxie0106@gmail.com>,
	Zijie Zhao <zzjas98@gmail.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] Fix possible NULL Pointer Dereference in 'extcon_rtk_type_c_probe'
Date: Sun, 29 Sep 2024 17:38:13 -0500
Message-Id: <20240929223813.21164-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A 'devm_kzalloc' in 'extcon_rtk_type_c_probe' could possibly return null pointer.
Add a null check for the returned pointer.

Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zijie Zhao <zzjas98@gmail.com>
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/extcon/extcon-rtk-type-c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index a592bab77538..9a0824fc7cbe 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -1371,6 +1371,12 @@ static int extcon_rtk_type_c_probe(struct platform_device *pdev)
 
 	type_c->type_c_cfg = devm_kzalloc(dev, sizeof(*type_c_cfg), GFP_KERNEL);
 
+	if (!type_c->type_c_cfg) {
+		dev_err(dev, "Failed to allocate memory for type_c_cfg!\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
 
 	if (setup_type_c_parameter(type_c)) {
-- 
2.25.1


