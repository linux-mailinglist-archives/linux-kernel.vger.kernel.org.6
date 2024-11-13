Return-Path: <linux-kernel+bounces-407218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640009C6A55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29567282F29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402F189F2F;
	Wed, 13 Nov 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0SXWCnh"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED3189BA9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485369; cv=none; b=IuUvQtcCA0d3WcKh6gRSy+jmMgePo6mOMg5M3Xa17deX7LGoOB7jAvMTErQIKV51iOnmVIswW4QtNARsg2nqJpguhqfTIC9eYB1Oh3dCeZEuBpQ/qC/M/14VBF8VOk/Q5MXdcJNX8bowypxm4Y88pZoiCQvVx563f9uUa7eMdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485369; c=relaxed/simple;
	bh=7WpWtv2jS3x3gXkO8R5xyAkvr3fN5myR6YUfGDPxZWg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jDWnsxBV4lp6L139biY+bCqVuTW2ldfQhOnXqGqjqIblCWiXAx9/A6DMtluDimRh8MDlfGQISN10YKciwpmvWHOxtnW6sSdtvIp3pO4EEANmHrEqEUovvEAL2EIJFpYCrtuB6ncVbH0ArsIlzyq4TZc7Mk/wFp62DDc9KGSIWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0SXWCnh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso64506345ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731485367; x=1732090167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIsnWe13ChOHunrq+aFxgomX4EggmYavswon98hsNh0=;
        b=D0SXWCnh544uo0QFy4RNcJ2pzlLJanQLRqE/D/VKSOSUYubKqs9Ho3+Xf+e29J7dvG
         hRbRX1Q6ynenzgav3c+Dj0bFjuVzqySEfahs4HZ2nmwnDpQngpcjHMkQm2nzfromH/X/
         6EiZ1b0u6QxuDN1/ZNSgTjjWWi0AebuvX0C4V1A6lesSKtmuhWFZwntk7amo0KQdMYUv
         /LtN6ZCzsaMCX6ozhoFBsK30sGLRVV5RH8/fwWr87eKMDhEueJiIB4OuP5fwLNMbdcFC
         Rf6fs1qA2OoZqJkKDaMqqOVubU5WUaQfrFAFLP4u/FdsDPBWrCo8xgHKVGZDA6Ru2bsl
         pr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485367; x=1732090167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIsnWe13ChOHunrq+aFxgomX4EggmYavswon98hsNh0=;
        b=HIp+i0VvAt1QrKfHiQ83dyr8a0GgBzl1Oc4cZ6vA6gvaIXxD2BQ/t+pCusecUSXARD
         ejwxbbWWMNNu/VCAIhvFNqZRiJr/RkzmIaiLPINsaPIHNt/kovJXo7JJTQuPpcsrsEFO
         y2scmOaR5HCzOVI+3JIty15EYec2TiBr0j4/YtVFAMIwOo41a9ZSU3nLPV065Nqmh3Im
         mHVffyiOQTs39Jqjo6c+sy5nDlsAYYfFFTdTRz8vhEvnXet6DQzJ0lv9aKVWzt0FstyU
         vPLhX9XqP8Es9pKfnoO/YSSoEhWIspOhUSRFvPwhTKdqqTsQOxEdkhv/Iki2vctiuobg
         BtEw==
X-Forwarded-Encrypted: i=1; AJvYcCV0k/qTTkCUO1HXYgCceEQM4bOa9kEtBY9RYsoU9jnt0ScyArbGS1wDAzPNnRp6q8MGhLqIZ9q83Iz3fPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzz+yEJzxlwReBGP0CefLa2kNzJZpc/ggt6q99MeSQsTmhgxkT
	gFL3p8ro5talxKPmka63xNWyanGL97KjbstMYRbmYIcUndxt749M
X-Google-Smtp-Source: AGHT+IH/hCD8QpNb1D96+qOwTRIPNXkvBqvqnmyXSFc7Q3LYNiYEnQsdpsPS6vUxcfQzJgpRf7YMHQ==
X-Received: by 2002:a17:902:d4d1:b0:20c:6bff:fcc2 with SMTP id d9443c01a7336-21183e6e414mr232444315ad.56.1731485367391;
        Wed, 13 Nov 2024 00:09:27 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e58e4fsm103225255ad.203.2024.11.13.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:09:26 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ocfs2: replace deprecated simple_strtol with kstrtol
Date: Wed, 13 Nov 2024 00:09:12 -0800
Message-Id: <20241113080913.182499-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function simple_strtol ignores overflows and has an awkward
interface for error checking. Replace with the recommended kstrtol
function leads to clearer error checking and safer conversions.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 fs/ocfs2/cluster/heartbeat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4b9f45d70..dff18efbc 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  */
 
+#include "linux/kstrtox.h"
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/jiffies.h>
@@ -1777,8 +1778,9 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (o2nm_this_node() == O2NM_MAX_NODES)
 		goto out;
 
-	fd = simple_strtol(p, &p, 0);
-	if (!p || (*p && (*p != '\n')))
+	int p_to_long_ret = kstrtol(p, 0, &fd);
+
+	if (p_to_long_ret < 0)
 		goto out;
 
 	if (fd < 0 || fd >= INT_MAX)
-- 
2.39.5


