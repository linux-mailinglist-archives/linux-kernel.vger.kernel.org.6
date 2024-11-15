Return-Path: <linux-kernel+bounces-410334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221D89CDA11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB153281DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C341DFFD;
	Fri, 15 Nov 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHCAqvZw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A741188724
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657111; cv=none; b=sHFpn6pbn1x0ilDI64yAj2dUXnAkluLH1FT1FndDAT197ligPkzDFcyTIf7YqZB2/mxou+AThNDnY/oeVwqWvrL7zEzCImLw9F96aQDkTsw8PLZtMtYa2pNnxsad5O8an1QL7yU3obwOKXMzW5VtuhXKuhfvpv81bWxeqB0GZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657111; c=relaxed/simple;
	bh=qqENQbAaKXZZva5Avw5Y8LEF9gtDGy8zzcMAUd41gSk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=I2ihhJP/MWkX3VOzLlOK17o1jKet0oY/HJ3rA5rN7xLFVkH7julof2P493xZkgCjq4SxposGvRkN45eR2RBPa/dXsfAcJj49uHUYUPC3GLEcBG09Uw5zF9u6zJ5M02lzqx4tnhXHjkGj7ZVqpupakfqJs2x+ZgZFXRBzlQPUjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHCAqvZw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8b557f91so15714175ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657110; x=1732261910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsAouvdVMNUqn4IU4fD/T6fDVN+WMWnKWEIbCDTa3i0=;
        b=gHCAqvZw38YnDGSkGOpdnT75s6AAa0RJorobS737SLate7zJRUYjOLAGHPF1BDZKaT
         rUw7rN5hBSdTSHOJv1ASLssC02xx1jFyEdyANsD93MkjkNt1DSrREURTc4XKnnzS7dxQ
         6MCAMRbdjzXTIyWhpUwP4lBispiUjvcBO93dZFyXce916jjcatYshsId3IAmfRvdqcfG
         FBQ1VtA0kZ0vQC7RSVOIpbc8krPA66FM51SKSKTLPVmVSMZa9XtpEp8Ertmkfd3qdBZT
         mUhaA5Bjc8hK9Vw6gHeexz6yAIhO18+SALru5jz8u3W7lUIu8ncJ1p8Unw7P6zgRdvfA
         a7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657110; x=1732261910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsAouvdVMNUqn4IU4fD/T6fDVN+WMWnKWEIbCDTa3i0=;
        b=g8q88nw0oez49TksTa8QZTdf6CRvbp1+g5oAMKUU08jtEyYJmjKI2ASG+DP3xBDqTL
         LJEjvC+jdR02FFg8SqVdZTXcaezvJsFA/gIwL1CVMeiSRWVpt83h/TWA2w1+A9OTzE64
         UeltZGiykEmexnfdwFRZ2bc/vQk5TuiYKEvi0yDxSDHbLceMzJA19ibENmPeJy3nCIAl
         vYWhmfU3lcpPaTq79Eq2YqAGUxI4vaoEVApV8AC7Tm63YMiGoG1cRTYxf9CTcaLYZp7q
         jK4MuRwRGCv09dxvN8bGTCxjf7Wcq6nZEGbZoPuvpMh0A0f0jZetkBBm2/oHGv5f7BTf
         8Dfw==
X-Forwarded-Encrypted: i=1; AJvYcCVW7WcQKyEVs7jzl9ogMcXbuNZ/jSof9d6FopSFCv3tj7pUekqRsSZM/lrtE1ePsuf0weGa8okVzi3G950=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY2aKL5Ue99U52jVnXklxmAj8G6rhIPOdB72jI0tyvtKVu4/p
	PiHGkkiXeicUIut7jL1D7wsrfjvMl5hcMI2heZch/yzL+lXqRVGYfWDp+seI
X-Google-Smtp-Source: AGHT+IFzkzeyJcCFRb5Z3zNnEDk6v8V4BkBj6xtGAUVR35xl08Ysxdp+lgXyAzGw0rXAZUxj1QsD3Q==
X-Received: by 2002:a17:903:1d0:b0:20e:5792:32ed with SMTP id d9443c01a7336-211d0ebc0c5mr21895735ad.41.1731657109792;
        Thu, 14 Nov 2024 23:51:49 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0dc3114sm7191875ad.15.2024.11.14.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:51:49 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
Date: Thu, 14 Nov 2024 23:51:30 -0800
Message-Id: <20241115075131.4457-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function simple_strtoul is deprecated due to ignoring overflows and
also requires clunkier error checking. Replacing with kstrtoul() leads
to safer code and cleaner error checking.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
v1->v2: moved ret definition and removed blank lines

 fs/ocfs2/cluster/heartbeat.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index dff18efbc..84ee5e340 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1536,9 +1536,8 @@ static int o2hb_read_block_input(struct o2hb_region *reg,
 {
 	unsigned long bytes;
 	char *p = (char *)page;
-
-	bytes = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	int ret = kstrtoul(p, 0, &bytes);
+	if (ret)
 		return -EINVAL;
 
 	/* Heartbeat and fs min / max block sizes are the same. */
@@ -1623,12 +1622,13 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	struct o2hb_region *reg = to_o2hb_region(item);
 	unsigned long tmp;
 	char *p = (char *)page;
+	int ret;
 
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
-	tmp = simple_strtoul(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	ret = kstrtoul(p, 0, &tmp);
+	if (ret)
 		return -EINVAL;
 
 	if (tmp > O2NM_MAX_NODES || tmp == 0)
@@ -2141,9 +2141,8 @@ static ssize_t o2hb_heartbeat_group_dead_threshold_store(struct config_item *ite
 {
 	unsigned long tmp;
 	char *p = (char *)page;
-
-	tmp = simple_strtoul(p, &p, 10);
-	if (!p || (*p && (*p != '\n')))
+	int ret = kstrtoul(p, 10, &tmp);
+	if (ret)
                 return -EINVAL;
 
 	/* this will validate ranges for us. */
-- 
2.39.5


