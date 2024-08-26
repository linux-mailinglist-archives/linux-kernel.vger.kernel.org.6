Return-Path: <linux-kernel+bounces-301858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6D495F687
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A41F25DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70877194ACF;
	Mon, 26 Aug 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNnzsPQo"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF877E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689690; cv=none; b=QZH5wZ4usnetWQX3R0eXYsfnqoudiIJo0yupg1KDeL4xlIVOlmtkcEl7nUriIqbcUEkhjssadM0H5Myj3dvLl+zzXTPCVsdHQSyYL7bDqY5IkQJdIAOIgLqnYuAZ73gcs0hWFgOSI93y9bMvnPYfSh3L5kgYlYuf7y5hmvTwtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689690; c=relaxed/simple;
	bh=a61nPFMBkE/nB5lWlRHE+zZhBHDWfKez6McDO2i56M0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=VrKaQR0WZVfmjDVInFZbvEM8rt9hgFPq3ERLqNVIyPAqWcEnMlkZJvRcY2Uu3HJlTXUIPAHPOw+bj+VZKZ1qzFc6Ns5j+FGhOujYorifEKJYn+qwxuqpPKdO/pPwc0v6c5lvH5iYABKrz+su2Q1ZfxWNcBRrJIhQ4cZfHxYXIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNnzsPQo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso4092068b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689689; x=1725294489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0/RKmYvm4ebcP81vpv3lvWNYuRii1WWVcVVAKbqmqs=;
        b=cNnzsPQoGbHeHNflfLy/MwUJlNd1GKlePu5gGS9D4lObZEenNwS/mZKfNpjFPL26cg
         GokjydgNHss+B/RX4S14KhgYvb/An1wxkKWh+GGrAVtNk1vWqWoD040Ull7DIwqCsLlz
         7uUrV83411mrtoJhoje6ZTLn82H4lDq0Q+xtOLslTiE4cTlHL7BZPKtTo06FksffbhXg
         rSM1KSxircrsYvfobUvsxWLMV42vKwvrFwyWkPrn4PqhTN9rYydsHv833suF2idzM7hr
         yGyYYk+nVB8z69ufzo8nFuYLj8xMDdGxRVgUMI1tQymRHJZ43eH6eaRwsGcvJ+UU3GSp
         uQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689689; x=1725294489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0/RKmYvm4ebcP81vpv3lvWNYuRii1WWVcVVAKbqmqs=;
        b=HxmWBGT3h2DKPieWZWbSbY/QDu0Qq2fdDTZ0yxCTEXZuL0Uauy7JwRfcLxb41Xx4xx
         c03hEpNU+kEb6vVVz9KoIPGHCl5qFJa+g0tKdSbBK1+uStg4ZtPOMn+cmA1DnTBqNoLw
         m6ZxFOKDSUlyRw2bVOWQzYEYKx15Cb3l8KviawyCGG8+W+dKcOwoZN+ZiPJMwf1vsvnv
         aI8lcGEULJhJev63SWkx9qUPIqdwg5O48lQ7n/JGbFjIUimslBJFDQgSwrT0YAI/+EhF
         yCQmNNijmhl2COPWKLvSpuv5Lczz5sGW+QT7xdB6Xu0+UWuCNlWx8nbfI3yxNqiFvA44
         ZDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnpZIshZ2M3UrNCfZnkr/iCvd9GIrvqUkFEwdwmQju8IZIMCZ3zKP+uedRmj/9qijOxi2mLFhVgaJOVRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXwfkRnFdlZqivfbPfS+/KdWQQDNf6WaQ2qIn7Az6ouRGxp+2
	W+Js8rYPqvEXfd0zOAHUlbATW7pNrSc8D/jFc6WbQkmrC7E3d3gL
X-Google-Smtp-Source: AGHT+IGkjP7r59x/lWcFgHfpLdjKi4fyY5EfpWD/UlvX3nYemTr+wBvOIJQMX0LhX9/n5bai5T85vQ==
X-Received: by 2002:a05:6a20:7b21:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1ccc02716bemr244396637.17.1724689688313;
        Mon, 26 Aug 2024 09:28:08 -0700 (PDT)
Received: from BASE-20.technicolor.net ([2804:14d:c098:8bf5:5293:dfcf:1562:f16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7145a3d32b0sm3644850b3a.23.2024.08.26.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:28:07 -0700 (PDT)
From: Alien Wesley <alienwesley51@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v3] staging: rtl8192e: Fix multiple assignments in rtl_wx.c:529
Date: Mon, 26 Aug 2024 13:28:04 -0300
Message-Id: <20240826162804.18996-1-alienwesley51@gmail.com>
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
v3: Fix typo in commit message.
v2: Removed two spaces in front of "=".
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


