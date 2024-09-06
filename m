Return-Path: <linux-kernel+bounces-319002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29496F660
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB829B250D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968A1D014A;
	Fri,  6 Sep 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYy9qmJe"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5871A270
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631905; cv=none; b=j9JCnzRNAX6kUinqlSO6YIXzJG951nsNPY+Bnax1c9iBekbLYPgEKq+EUBy5UpJM5JiLdpwAxbEPIAzzmxuUccq3QnWpm9eWG/Xp4ZemKjAKH/Dclcs3gTn9VleQu+RdWkT1UMWkxFXyjC6FaFgqoo+zYlms+1I/SWu8Nv3u3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631905; c=relaxed/simple;
	bh=n8WQglKXOWQ5TRI+1rAwPrg2+szf7yQwZbqLLzSWIo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHNGpLMujSQZokAz6fk/g9oXnHQb3eU7SNNzbBg4xROk1p9pu+sAhSvVs82o7iOJ0ifvMeB/ShsG71AhPt3YEKYVW1/W1vcPaLYhUZrKIQY7LGrh9UiFOdptQgYwR27Z5MyYe+1LE0Xk4TRYV0BgPrNUAhZMXperfCi0QX7z0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYy9qmJe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e70fb6dfso144558a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725631902; x=1726236702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5vSWCkgvvHrA0ZM+4e5EthGrwYNA4O6y9CajVrLEgU=;
        b=LYy9qmJe+09Ti6BKMU8X/aerr/6Dlhe602vNAZPc4d1UCJbK3gkv8YSIcJdA2cqvqB
         CNYnqPe0Fvsz9N+IevgvVUZBi/61glwvnD4v2tkpQ0YgEfmGPgXRRy9gtX/BboY94afo
         YmIoO5ftcDO53YFtQwA2TWwi3cNcNq2h+s2lYLB4N7FvX32EiSlGoTjD4Z4OtOJR1uqo
         O7cz3G8oJGgvGzPEAOP0hM2hK1D8KzYaVO1My8et6Jsoyj9ourQaPCvTSQkjuStA4s8m
         o0jbN4AIRkNbqQpeBvZBPT9+VTcdPpqcZVPpZxSjKvdoLoDJlaERPWnRdqazp3ZhqsVO
         ZPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631902; x=1726236702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5vSWCkgvvHrA0ZM+4e5EthGrwYNA4O6y9CajVrLEgU=;
        b=kJ/zyjBfVhALgPVRuD/5j0u+rADBxVLEHLvKBeRgi3RonNfCJltHC3prCC8HUzLRb8
         zRXEncKMXu0MFqL/g9lUaBVgptJbj5lRgWaw4uICckOF91tfsB/ZtEUDcLpcy/SBM4a2
         O+fel0c58neuvJpdGV6vTCQZ2XXWaQfBocVpsLRAUBUHUofyoJvycXKOrpxA6yictujE
         8aFVnH02YJwezqcYCdnP1nakz57i0tTDDyRSSijysGLQNw0+EDAHg+7twXmYRg9yBt/t
         6F0mRLxUXCRAacuNajDqBbMmTFQodCAh00JfA/eFsCzThnfZiBrD4hVpXlkpfvx67Xe6
         vZow==
X-Forwarded-Encrypted: i=1; AJvYcCXOUZbrmGe3PiXrgOudzbhTB8xs/WZ8zLMj4EblzPgwLC9mdIzZfu7DTZIuAWnddfYCy1AiqRnLYGVwGWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHiD2o4jo6yDuwJo4A1I8JStOgikmO6o5v59jzLKCNQ/hXCvhe
	EWzjBm4dmcBxU0QL5FBe/+5XTsooU4cdLUfEM5r6WXiBr289ZGQO
X-Google-Smtp-Source: AGHT+IGnttK575gxEnOIsRfoaeIrU1TuS3xGG5WzKJfzYm0vLyg1t0QUlE6wi7rzXqhJhSNjp3BRmw==
X-Received: by 2002:a17:902:e5c6:b0:206:b8b7:883 with SMTP id d9443c01a7336-206f04b2ef9mr15362495ad.1.1725631901741;
        Fri, 06 Sep 2024 07:11:41 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea351basm43481015ad.129.2024.09.06.07.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:11:41 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
Date: Fri,  6 Sep 2024 19:56:34 +0545
Message-Id: <20240906141134.10118-1-topofeverest8848@gmail.com>
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


