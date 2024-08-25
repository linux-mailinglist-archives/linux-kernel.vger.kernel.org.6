Return-Path: <linux-kernel+bounces-300583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9DD95E56E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3D61C20C64
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E92757F8;
	Sun, 25 Aug 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSmm4EsA"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEB45003
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724622380; cv=none; b=R1s80VnN4p07s9f0wH5WCzGv+pVk8wfyBtFkgDDVS32/ztDYB05fTFNKLyXxUywZj+Nq/okPb5KE04JL8FfIg9GfdELP5XbM3+mk5+/b/lBIXwgbM3lzYgjME4WFJAPme4+zIRHqjcA7LZZzU7KFoxl//S+wDP6mcO4C1HAWDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724622380; c=relaxed/simple;
	bh=tRqA3pZO4ChqklOPMPNPOfJsYDua8CM0p+lMxxbt3Nw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QQ9Gb4qQNOnzUMRNlwfUQBWxglu0oIoM818wIXzk5s5oRocTCgNWULd4GbwbG41siqmi2Hm6NDbMisgLIdNwR4b0MN4OJknk7xt0qcU0sGyJRVq+h0fsQQWZUFdVChbIBoJBhB2pqzeEe6ZyejtJS6dz7Pr5/Q9odleyT3jXvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSmm4EsA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so2168518b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724622378; x=1725227178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7m76LHgbUmejyxProia0AVM2QTv2kcsI9DgRl8hHA8=;
        b=dSmm4EsAEdIlNO4t41ljQwaNvXoVrDB2j4jWR9pdxYCUOIDxQWbtOzSWIFqMPht0BX
         PJUFvG8vI48yg9RiBq57I9MEbpO9Qwds+oDuH8fdLi0V2uskg5h8rCLdylQROKITzkOw
         ZjQJPhkMSfdhxenyjeuXKnEKVMKge4j/PMn/xTHsdIpmy187+hgVINVawbiEqADi5PCd
         KrcKwf7EWZomFIVCmt9a9nN05NKzyYGz4tVBl498W1DyApvC//W9oAxJF1ucGqm6eszr
         RAuB/yRClhcxeKQNBew5h/Q7YgL7om9cLmJCydtP7yA4OhrXX5AnGtks4t/WMaNvvQ5P
         Ueyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724622378; x=1725227178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7m76LHgbUmejyxProia0AVM2QTv2kcsI9DgRl8hHA8=;
        b=gM6B164JZwBx6k3lSxTBm1sSeAxGzmvzSXuSH+MQV/xlKejhhsBEEd3uhPvEVHLk6A
         cDgfILGqwyF3SxGFTuud8zZjhD/KTOBNfdM2qPqupcBt4isEEnup/YDneCD0H/ZstoGd
         i3+0Eb2Cio+QuIDq2DQO9jmF0J2aeSD3msKZSsqWUk325c+J8xyliXARj2EEqtK5q9om
         ryLiX8N55+MJTonrVhupeGZROo7p742yER9sHrCvn7/0MgHaFuc02t+VKA6jYK1pM9A+
         y2bV6d0cBa2YsCTs3lNpQc4WfAk5Ym7nI4AIDxuSOdCWpMb0YU4FN2bNvkkn7dcVxsnR
         LpPw==
X-Forwarded-Encrypted: i=1; AJvYcCUrrTLECgc6UBW+9mRWPmVfAkF4ZRga5fj8OOKsNRNPP51awAf7OajA6753mHH+ZOpqNYr9w+RiZ2C9ReE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9wahfiCw/31adbJNv1LO1x5i1PxZR38D+nnUk3wJe+1RsMqR
	wW8a35OTdQOj247lcL8zBN7V+MkFT3wmKenPHeshN/ayWYcFngfq
X-Google-Smtp-Source: AGHT+IG0vxhout6cqPChAOh6vpjgZACAApP1gSMoZ/6MPROdMrPfys3a41KGYvyDKQ9wQOGMeOlbMw==
X-Received: by 2002:a05:6a20:c909:b0:1c6:ae03:670b with SMTP id adf61e73a8af0-1cc89d29dadmr10719629637.9.1724622377863;
        Sun, 25 Aug 2024 14:46:17 -0700 (PDT)
Received: from BASE-20.home ([2804:868:d047:ced3:41fa:c7cf:e733:9f1d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430cc60sm6014817b3a.154.2024.08.25.14.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 14:46:17 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
Date: Sun, 25 Aug 2024 18:46:12 -0300
Message-Id: <20240825214612.49254-1-alienwesley51@gmail.com>
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

---
Changes in v2:
    - Removed two spaces in front of "=".

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 47f1adf30ab4..67c4793e0fc1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -526,7 +526,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
 	mutex_unlock(&priv->wx_mutex);
 
 	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
-		ieee->pairwise_key_type  = KEY_TYPE_NA;
+		ieee->pairwise_key_type = KEY_TYPE_NA;
 		ieee->group_key_type = KEY_TYPE_NA;
 		rtl92e_cam_reset(dev);
 		memset(priv->rtllib->swcamtable, 0,
-- 
2.34.1


