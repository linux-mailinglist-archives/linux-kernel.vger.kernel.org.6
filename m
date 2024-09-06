Return-Path: <linux-kernel+bounces-318998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9B96F658
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861E21C21DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338B1D0143;
	Fri,  6 Sep 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0j7yjgh"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306551CF7C6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631840; cv=none; b=hRpew7gMLYf+IIm6s3fiyyGysB4/Nn7JXWu0ARrgn9Uo3IuTcEErJ8O11SqVOUb2vu3EtFyYCaGy+vAPk8Bx5kop5O3bwHxCGplMffG7UlZVL5kmGGg3Hhe9tlmgk0SaPIMSXiuvDKDLwDqQGAjZ8Qb5Gbm0KbQED0RjGgiTSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631840; c=relaxed/simple;
	bh=Jkg3+i0mTY4FdI4toZ9e/r/mwam+fDR7fNlJ60pKIDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1T5V57ieyFcG5UAWiSQ1l7d/7YgYJ3ghB1OvwFAVDRj/dW2j0PgNOSgDCUfZSoQxcDv1d6HdUJKdIdsuXNZ8iT2a5ZWkpkQ46OVVWQ/LjwkoyYUXzH9mqCIwIBVptTaDKshusGkzgK0OuPKcEGcOJrlCkFPmr9EQwHw8GaRDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0j7yjgh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717931bdb24so141865b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725631838; x=1726236638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpwGePaDBp0uVaEd/rbAQsUfTJ3bw9Qu1GLMpYo60uQ=;
        b=B0j7yjghh0g00opqL23GVrMkzfdJ32m22Q5oOzzO+Mlv7/pIPUT5n5iqNaJxY4pTTA
         o85Jf6AU8eOiYqbwEvco+ngDPtoOqlZCKei5Gpyat4a0fGW7yweRNo3AGiwobsJnSbKo
         DAwBQOIIq56YwCE7va+VOlZkhq3ZAFSbLEfbifeXqq0vUHz9KCGMyJF1OASz7Y5iU8dN
         hORL75Gi9ImYSrTCUQght+1fZu7Vrbyw3t5ZTcd8WDMtkKHPu+YNSR21DOeKYPn3VxEb
         tDachd0eElbbM3a4i3TD0YwBkdJaxBvA/K9Tkarcnbc7BbYaT6F0bhRGPAQXFpbB/ldc
         Uc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631838; x=1726236638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpwGePaDBp0uVaEd/rbAQsUfTJ3bw9Qu1GLMpYo60uQ=;
        b=jydyCdZbacAxD+ka3MF2oYIQmPui+lAi0ie0FnRj5sXcpt8zzfkhIAJsSZneUudcV+
         y3zxKidT7X31RL5m1dfSmJtVM/bfFF7xrk5F25mslCHPHnV7wguYI29mujVXv/T27L7n
         zgcAVBDr/dlz07z9UWP/H4t43HstF5AbstfL7X7ew7NZLbXeDycIT2C9PZQkHVo6Mqzg
         ZpGFTnsn3j9J50/YCho91ED3tfepFSkrbhG271USl0oA4NS7nHeNxoTRm0FNjJeBbera
         ZXKqRSLfQ9MBAl+CDuA0do5KvSwSaM747mB9RIAbmYypojTihf5HkR91cHPbx8Cu4y17
         u27g==
X-Forwarded-Encrypted: i=1; AJvYcCV/laZB0QMHQrKKUMYDMJ91sylEHawRwXnt34EinVWiPA03wx1ddamnuiIirGsH0SXA7fIDuR4A03/qOeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyhBMXR67hutTKhy41Z+VPeIN+PemnU2VOVWe/UHqlZtf0nNm
	nlOKIgWLgEZdYZQxaVNCqNv6oO5POpmq8ldP1x8Em9/ZMhJcBKh6
X-Google-Smtp-Source: AGHT+IHJQZY0Niird7SJgtEDlzL9MuvLmJBzy22Ncjys8umvt8oEcLcJzQ7d9ALDctEaLcf4kz+xmw==
X-Received: by 2002:a05:6a20:158b:b0:1c4:bb9f:c564 with SMTP id adf61e73a8af0-1cf1ceefa59mr1490912637.0.1725631838339;
        Fri, 06 Sep 2024 07:10:38 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718d6e78801sm1289976b3a.133.2024.09.06.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:10:38 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
Date: Fri,  6 Sep 2024 19:55:24 +0545
Message-Id: <20240906141024.10021-1-topofeverest8848@gmail.com>
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
 drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index a3b4310caddf..544468f57692 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -15,7 +15,7 @@
 
 #define XMITBUF_ALIGN_SZ 512
 
-/*  xmit extension buff defination */
+/*  xmit extension buff definition */
 #define MAX_XMIT_EXTBUF_SZ	(1536)
 #define NR_XMIT_EXTBUFF	(32)
 
-- 
2.34.1


