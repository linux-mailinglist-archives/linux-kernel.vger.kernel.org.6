Return-Path: <linux-kernel+bounces-320605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA36970CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB5D281118
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8AC188006;
	Mon,  9 Sep 2024 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAgyBUgI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B023CB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725855341; cv=none; b=rprlhxbl4lzg4hGIpHSqQcQ8LebL2lasCm8cmWTAhxUHxEpEQ51NkeJWVHfLYdJMiaWpJevx2vmGVZr3UHSCUIVAdMqJxqemiHXvApLfPya4CB5MovwJJ3p6EeZMW2b/+A3fDUj4hpm477+8RqHQwQM6qbdMLvMJWWrUoClVOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725855341; c=relaxed/simple;
	bh=xfFbIdUvQEA+A0pXM0s1InktvjXSjWi99F1gPsoIfj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QGjKYSTH9ETJKyRqox/rPkw82mM2l9jiwaQyPGn3Eyv3v2oM+OxG3ccKuhntve/q4DPUvWGsup6//wq5oytyF6A7YCwnA2GEJ7apWX2vEPVN/Fp3U9+NEH7f2RIMsNouxsAnNyTX56g3qVy3jaK+fJvkwx/baSNC+Xu+QwJ5dG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAgyBUgI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e25d8b67so402842b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725855337; x=1726460137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce7h68vToLcd8NxAA1OJexkTmfKcB9e72XkVNR4Uymk=;
        b=GAgyBUgIBxfJwGqAi1001Zs+kwEcUzMy3kQedKEcAEuMsQR6eK+b4s/zEPpjJcuiB9
         KkbiJFIywt2g6jSMv9lDn/ej77Pb8Fd5hDmnIfc9jpRjqONCDv/RVVW+ldDLVHsCeWcy
         skoZHfAU7Alzo1cY0aEy/9y/QoXUyhFPdxvpFRE0gIVTwLSWFGB0mxZnrz01mJgLyBDn
         4D4d1TKvWFtPH0lH9NDtT35InAhJXxkMmIXqoxYmXLyQ7oTPaUG/wjPHZOvUT48TlFbE
         fUn0GLXg2CUvuMl03dAcK44phuuVwLIFuQwrXR6tvKuv1FoRzbfz6rLHiXWojS1SH5TC
         DN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725855337; x=1726460137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce7h68vToLcd8NxAA1OJexkTmfKcB9e72XkVNR4Uymk=;
        b=I8nVszvXws8utm2qoeu/5KmmmYF5hHnsSZJ17ldB9rlXb8vkdWGt7kTAdpOj+LvczN
         cFAYbvxbuhaaNS3DV52UZG8W/tl/Z4njYLwNWs2XzzP/h4V2KezZOXiH81NEhIoM1dyS
         3SjxmrL62Kb6Y56tN03hdY/mTHupRT1vUrXBKlojCJ38XaXgzzEiZEslOuBYnhHnTI/L
         xJkU1ZQC+TyIuswbfopELOPeCph0Nj0Fh7tOD5hVzn5yKNyhzhBjTf7K9s57qaAoN2rE
         Z9vykBY9lufNr17upzZo0iK82fyEWhlvjNPQEhh50hv5DJ88dInEZZKNJ20qaM0G/ieQ
         BuaA==
X-Forwarded-Encrypted: i=1; AJvYcCWY81oQ4gUIfl1yCTdwCxW8WTESpxqJFAusP9eavLEi/JgdCUJygI5MmQyI+50oUaQzgXUWPIBHO4bbEVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6G802kTxyULoL+ohNWLgkGvKTpV24k3/0Gf6K/fxZ4mHsXLh
	PtrO/lmI77RaxwDfGOIQRYFtO4Q+c58XYWsAgsX1EZ2eTZNHf4m/OtM9Vzd2
X-Google-Smtp-Source: AGHT+IE8NvG2UROO50TdKyrvT/xGy3ZWfk+qOwr4EpD1xc7WZGH+vEoU+rajZoxhBvP1GFsh4TYBBA==
X-Received: by 2002:a17:90b:3889:b0:2d8:d736:c35a with SMTP id 98e67ed59e1d1-2dad510c012mr5055661a91.3.1725855337499;
        Sun, 08 Sep 2024 21:15:37 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988465sm3411971a91.53.2024.09.08.21.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:15:37 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
Date: Mon,  9 Sep 2024 10:00:30 +0545
Message-Id: <20240909041530.2431-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v2: Created patch series as suggested by Phillip
v1: https://lore.kernel.org/all/20240906141134.10118-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index e103c4a15d1a..e665479babc2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -131,7 +131,7 @@ struct mlme_priv {
 	u8 roam_rssi_diff_th; /* rssi difference threshold for active scan candidate selection */
 	u32 roam_scan_int_ms; /* scan interval for active roam */
 	u32 roam_scanr_exp_ms; /* scan result expire time in ms  for roam */
-	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to speicific target without other consideration */
+	u8 roam_tgt_addr[ETH_ALEN]; /* request to roam to specific target without other consideration */
 
 	u8 *nic_hdl;
 
-- 
2.34.1


