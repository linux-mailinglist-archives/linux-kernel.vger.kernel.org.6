Return-Path: <linux-kernel+bounces-306846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38216964486
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6091C247FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AF198E75;
	Thu, 29 Aug 2024 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwOFGUJb"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEA195FF1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934778; cv=none; b=bbY8j2tG3a7wAmJXhLNr2M7RtjoJiI3lzpFR7d/zVl79fmbbRco3d95eeMxMmkTJaDTmbCekyaanlt8/uAXExySy/3OCk0EwcGWszlLW10Cl+NRhgUh6P4IZfkNjNSudsHY3zqnN8pobpP8wf2aQZxYGdTkundNCfYEs3zoyQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934778; c=relaxed/simple;
	bh=SRTXte8ancTXyFLBRoxU9ak3vwXJ2tIzSD3U9JJSDho=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QcuFhjoF0PCQ8ugZ41rgGf2xYchNtRMzXC6ok9eP78WbFpb7IjteNza33j7M1P7QeKXGoCiVXkGoAk8SXZjMhFgXFVnP4/4iWj/mgfsNvgeJmC0sxhENIHSMaNNTqw3LklrwWb2+KoV8SJcwociHq6kB65LdVK2sKYI7ncPi+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwOFGUJb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so456611a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724934777; x=1725539577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpLhta1Onq53+bLklwgL+euTgLHAYQa9BqkAwN2sT7M=;
        b=PwOFGUJbR5JYNFzA8rwcHZ4xjHjY9qEA6YDRDZmnhLAjpjqvNSUXXqXiMEHCp98KK2
         DFDDg6plOkvIs3InFSQ3r6nBwEkg51bupJVQXglWPczDtOogkcdbnlz9jkjScDcwg4Gw
         Ng8xLhJ62Pmntq7hXva73vLgEij/TD54g2fbWYzziIw5oReBUWsnwwBgyhu1eizwcE1+
         yVjx3IemPq4jlQiACzM9QfJNvaZhVMvAALYzv1dduYu3WnHsZiYNiAkkTur3761ca2rP
         s/PBP60zJq1CuTr6TBFo4hpGt+lUq3GKaTkYqX9jzdn6+bULWZ8xojFUYWkKyVuGud+I
         4JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934777; x=1725539577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpLhta1Onq53+bLklwgL+euTgLHAYQa9BqkAwN2sT7M=;
        b=lqA7krbYH/TXaGRR6kyvz3dOGxvuRfjIbFuxFMw5OwkLWrTZV4diaaXm4lISuMoSVY
         xG3mGc7EK6g+7VPtHU/+mz2Q44KWU+ld7ANGbdGxAxwUu9CQzqN82MAaLYhhN1Mw0I7I
         5vVmMBE3NV1325PVDZENaFrNa7oWc354JPfc3UnfZMbBklhsPbHRMS9L/gLYhPVLfi4C
         xsDL7TJZC/XsfsRkQsonhY/MAkA7m+TdXwoUlV8Vv4iOICv26DxE3roxZHTfqoradfay
         KqPLqzKqAymHgPqFwhiS3YjjuKaAb80SVTykmtCvr4E5+GFcL5ajHYQG2+pCi3tOt0UO
         KZpA==
X-Forwarded-Encrypted: i=1; AJvYcCW79yFZJ0h3h52H7Tg+nVXiXx47NexRYV3KvRawjoK9LCcwes+e+AM5d42WLWiqNoQtipQHzP7eFyhND9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rBrGqw0c3JfHLZSBNGo7xVdPEwy5h4OoUAgVbgyVAhdmx+49
	VXRAHy9scW/nchc/PucBKgLUjgX4sJ3kxdLwu7E1vEuCJf/OaXfSO32GcQ==
X-Google-Smtp-Source: AGHT+IFPdLOOyBet2Jy2mM6kcKOVaAQsrn9R4BWD5QxRsyht+GNlHw3NaHP4yGnS7m9+DDzubndddQ==
X-Received: by 2002:a17:90a:6449:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2d8561d3ae1mr2760812a91.20.1724934776506;
        Thu, 29 Aug 2024 05:32:56 -0700 (PDT)
Received: from BASE-20.technicolor.net ([2804:14d:c098:8bf5:58c0:549d:d99a:c399])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e8010sm3971138a91.14.2024.08.29.05.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:32:55 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] staging: rtl8192e: Fix Assignment operator '=' in rtl_wx.c
Date: Thu, 29 Aug 2024 09:32:51 -0300
Message-Id: <20240829123251.83574-1-alienwesley51@gmail.com>
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

CHECK: Assignment operator '=' should be on the previous line.

Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
---
v2: Line number removed from subject
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 47f1adf30ab4..2d42e7a5bcdb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -677,8 +677,8 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 
 		if ((encoding->flags & IW_ENCODE_DISABLED) ||
 		    ext->alg == IW_ENCODE_ALG_NONE) {
-			ieee->pairwise_key_type = ieee->group_key_type
-						= KEY_TYPE_NA;
+			ieee->pairwise_key_type = KEY_TYPE_NA;
+			ieee->group_key_type = KEY_TYPE_NA;
 			rtl92e_cam_reset(dev);
 			memset(priv->rtllib->swcamtable, 0,
 			       sizeof(struct sw_cam_table) * 32);
-- 
2.34.1


