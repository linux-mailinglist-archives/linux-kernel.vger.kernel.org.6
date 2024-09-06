Return-Path: <linux-kernel+bounces-319004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C596F662
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBBFB25293
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245D1D12E5;
	Fri,  6 Sep 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2094qd3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2E1D0496
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631926; cv=none; b=jvw3KR2OGTOH1Vf6oXlrl7L444LstAAz12bz4UAwsVQw92krTjezP7WXQiUnDUbRSFcYwSFUZqkJ6pvSC7VHsqefzUKxJdL79MFRxhNWbmYrX+oG1FmQ52yaN2Eb01VtQv8OIRg4Ye8fWi9o/DmnZpudkSrfoNbYvjojwdV9Yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631926; c=relaxed/simple;
	bh=tr0k3udyYHTsb6noIMnXKzGBGum8kb+Pq7RA90sKRMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fp0wfAXJTSVpaOhApZwsXiKkql3SnzT9aqNltxClCvLBBInKeSeLTBDHUhN9U589FblFPotyegGM4jxpyJOGsvquKxm6Y1oCECczepvf8HWYkjRFhml2w+nciWLfaww5SogRRMEIILw664LypLb0JTnk1FoVO7WT39ZKfqWxVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2094qd3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc47aef524so1887265ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725631924; x=1726236724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cB0+7HUocPV6rVpUr8k3hJ2pVw2G7BEadEUj4KIQ8CA=;
        b=g2094qd3aBoIbZXZkR6/w0S8KuOABvHne1N6Ezy/R2WrCOu0o4sklK8SqGO3HrVZTy
         nyluMZSI3LtUGQ+5SFZoDsBDyXBsXu4Z9LRwXJbmGSuhkAAi6fQmJXdfazHlNitK1J2b
         wyX6Kfgzwv6DvM4B1LmLOH9RCpmkAs+fY3Vdc1x3CGBSjJzHn1sJYcEzE8l40um/EI1y
         I1KszMYGNY/Bh8UTQ8iZTgMIfPz7aeMh0rq1rFOX3RQF23LihQXY46prt5TaCpd5NKG8
         jv41R/NL1qPfhFP+GXsz24FSOrne7j2jEMAeW/f6pWuDofFoWp/ABroZKDUu+cr1heJE
         zBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631924; x=1726236724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB0+7HUocPV6rVpUr8k3hJ2pVw2G7BEadEUj4KIQ8CA=;
        b=IaoiEySqNQoG7I3Ff45e9Ukjc2gvBVYWDNZwJBMhYGx+h7C3Lpg/rzLfhCUQfMGcK/
         +fI99nUbOhCG2QPnqizz43DlkzEoUNP+ty0lr9GSRC4YMVyjystadsj0IM6jfJgCMuhA
         ZLzRBP/3OSSBbRbbVH6fCgeuwc12kzWeEFGjszoZhdZflLBoaX+NsExR4M88VLmxM6PC
         hxOdPkxdPsjxKIn1sBl1Sy428yKLo6YsZUA3f4IcqDcDjOd/o5hu1wrZRdVKEYOHc0XS
         UgOw6MY+hPdOlpzNjx9Mm47SF7ectjKVTPU7cYF2jvgKT4IsOk8x6bofjJjv2I7uuBox
         0vmw==
X-Forwarded-Encrypted: i=1; AJvYcCWCDhDP8Wk9SN46IHxGgwU/kdajmE9DJBz9Z5KsMUsUbTp1LmBUNCoL/darRLhixFOtay/u4FaXwyI+kvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEB3cxTox0bbEgq6afptjk4AnAw5epOTyZO/EOEmEbPSm83uz
	jZhzpmp6ol56+io37sxKFxb3XKGtJ6Mudeaj43yHKZe9FZkafWzW
X-Google-Smtp-Source: AGHT+IE3LHZzIOKXhe+IEWE83z84niJa0kAefJucb9M9xlSY0zVtDuSMLl8ZMO/10JXAKJkERlz4Pg==
X-Received: by 2002:a17:902:e550:b0:205:40f5:d1a with SMTP id d9443c01a7336-206f060b887mr14174945ad.6.1725631923989;
        Fri, 06 Sep 2024 07:12:03 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5554dsm43493095ad.235.2024.09.06.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:12:03 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c
Date: Fri,  6 Sep 2024 19:56:57 +0545
Message-Id: <20240906141157.10167-1-topofeverest8848@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b1965ec0181f..755c1bc86a74 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -45,7 +45,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	init_completion(&pxmitpriv->terminate_xmitthread_comp);
 
 	/*
-	 * Please insert all the queue initializaiton using _rtw_init_queue below
+	 * Please insert all the queue initialization using _rtw_init_queue below
 	 */
 
 	pxmitpriv->adapter = padapter;
-- 
2.34.1


