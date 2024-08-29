Return-Path: <linux-kernel+bounces-306760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20196432D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB13283ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3B191F90;
	Thu, 29 Aug 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN0Wap4e"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB431190663
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931373; cv=none; b=RmZinjA8g3N+bW+BvfMs0DM6Qfbcr2byP19T9xJvYN70Umhl3aqQZr5/x3dv5I8NvStkAEIt1rQQq1xwWSlqeZ2LKS4NI9Am4Eszj+Y/uTjpG4BuhGRBGiYiUkTKYd7SQJYSexHkfhddyVyhqzIYTwoe1VBJYOBUrKXBBj8uEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931373; c=relaxed/simple;
	bh=xjlUdWHuXe9kVpBV5SFh+YipUMtfQLnvnhnIdhIMRWM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sh6WxJKL9zhvwnu9/N+LojTVlu3iSzjpWGaoFG4ONRUNi7aKb6UdhJ9XoQAl/iV4Nq1Q8bFoAWhV3bDoe98PdvfPK5HEHoKcU4wnCMJZK0aZsmEV0/w9PUSpB0W+eAAvvP69T7tR40r44NUQQzK7SEzv9r+x8/vUfu+4Z6XDfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN0Wap4e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so416252a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931371; x=1725536171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvk8Z4I/ZWd1pT8hER0HXmY6x7UiyZ6oh440YU2oX9k=;
        b=eN0Wap4eA3wwSpUjX43wHe893CyCKDXLO4jgM22oxAbaCjcD2PUfjXiAq9HV0Jeaqa
         /GP/+qbAXbsvP+pkKbyUeC2R7AWIPx1sbryf7qA9S7tO1ayUQxJsxapzZBeEd2gHlSlR
         yJKfipjI9+gqR4ABzF2p7NNp18k23LQyfmmsxOQNwOJgk3+IE6waOaE3UPYT4PlQFzvw
         Od/II8RY2rHObHVfVh4SENMwXPTi7x2+d6wNzg3v37vOe8HUvcafc+T6ucZ5jak4smv6
         Q/RilFazdojIlWZ6R4r2fDKe5nE5M3oARaxtArq2T64664+J9B88ExaYpvDZFDAlYjpH
         Diug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931371; x=1725536171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvk8Z4I/ZWd1pT8hER0HXmY6x7UiyZ6oh440YU2oX9k=;
        b=O6HR1t5supu7AndLtsLJZa989Rt9AclcG4SO/MOflDzKCcuceCSTXhf6Nw+6tTGBkH
         l/qCOmPsWYh1Hu/r5l0w21wUiX5+ncuZt9Y+vGTQ0SzlIVWUWu058j+MaK47t2Ad61/C
         vSscp4882YvlpQTm5/v8KbYW7WytYOR4shZaJaGGo6HLqNT3QhGWs0CRfrwEje5g1hZ9
         9qkHy2n2sl/IXzleTJZJiV9BwYVlTqwUmV+qhqC/j4V58Eprk8yLiCSXXBvCIWjxmwX4
         +9xnAyb6YG91qY+jEAtePwPmC03BTPrIOk6gOL0mj3AJ+l5eRiEoSmbsDp6JHPoP3pvx
         wSmA==
X-Forwarded-Encrypted: i=1; AJvYcCX/2xoSOVtmYkeUXJ4ZJWh6w3sb3ognxCQjUr00DaAzCyC/y0tOaeH+SgjLpsVvI9nNGNqRVho1srnGWeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfdNEloQCVloOScYoGYiG5zUuUKGd/4Gd5/VjuYWSGUGml072
	jDsIP7Yiv3l5IBC+JX52vz0CrU8w9ZzckYi5OyiFdsD8Dd9tv8y7
X-Google-Smtp-Source: AGHT+IEkZF47UaIKPM2D4LC2LJ2ypEMjLFClj2jLf+cLSfwzEsvqy/rT6wVXFf4Q+BVYFwtdjzjMwQ==
X-Received: by 2002:a17:90b:1c85:b0:2cd:40ef:4763 with SMTP id 98e67ed59e1d1-2d8561a7ce9mr2608353a91.15.1724931370576;
        Thu, 29 Aug 2024 04:36:10 -0700 (PDT)
Received: from BASE-20.technicolor.net ([2804:14d:c098:8bf5:58c0:549d:d99a:c399])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5b56sm951788b3a.57.2024.08.29.04.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:36:10 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v5] staging: rtl8192e: Fix multiple assignments in rtl_wx.c
Date: Thu, 29 Aug 2024 08:36:06 -0300
Message-Id: <20240829113606.76645-1-alienwesley51@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separated assignments for pairwise_key_type and group_key_type
in order to silence the following checkpatch warning.

CHECK: multiple assignments should be avoided.

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
V5: Line number removed from subject
v4: Squash v1 and v3
v3: Fix typo in commit message.
v2: Removed two spaces in front of "=".
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index fc8e7f73b2a4..67c4793e0fc1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	mutex_unlock(&priv->wx_mutex);
 
 	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
-		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
+		ieee->pairwise_key_type = KEY_TYPE_NA;
+		ieee->group_key_type = KEY_TYPE_NA;
 		rtl92e_cam_reset(dev);
 		memset(priv->rtllib->swcamtable, 0,
 		       sizeof(struct sw_cam_table) * 32);
-- 
2.34.1


