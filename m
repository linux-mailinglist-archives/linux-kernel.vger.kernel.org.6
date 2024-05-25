Return-Path: <linux-kernel+bounces-189435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609C8CF000
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84697B20FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000685940;
	Sat, 25 May 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDgz2TPD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70B7F7FB
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716652972; cv=none; b=mFsNNgoGLl6iWWyb9UhPY4drHztZoYJxFL8Hy3whE0KFM+PU4DkeC51F2vK9ezj7guoMeJ60WYLqj/J/p5VCyr2AT0FB++rusZZV1DNkJ26+e/pWI0PYzY7xdPLCihzREn7sBiqZZLnM+YTlRSoaeSTZRgvjIypLQ9JjM/dgC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716652972; c=relaxed/simple;
	bh=2PocUIctJT1LGB/9mzIa0giFi5RIO4kYRtnrssDuAGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pL6w/UkJEkyn3iwA457C6X7Ce+cRqFLDbhja1mm48K5d98BkuCs5ipmpQwoVynil57pUX/+cLcn5V1XjF6GzSxSAgcxeUukuXb+YlQPAhqXcJryU8FyKYdcElKP8EL5mBqJqZ/FoONt672cN8LtQJDIXD4twYzjZjgo7QYPrAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDgz2TPD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f47eb21f0aso1119905ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716652969; x=1717257769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AViMprnRZDg8WlLNdCeKLRe1EXgWkFqK17wBJRWM63I=;
        b=GDgz2TPD4ctOZpiEZ1QVAhpKH1NbMQxCqj2Cydk5/GMNCT78N9gyASbVczLW/0cZhM
         cyDKcJlKTEXhsC5PLyp2u33aCaLH844VTU16OzP59rnUIuLNt7VBN4DnGfja4QIpNWLb
         59QxA5r5Xl9qByLPE0BD2e12uIZTtqtdB7hFvkPfEYmz5D3XOLbGxeXq2S0FyVGDBuZf
         zVnIHCCySRamiFv5OIwlC603XlMmSecCCJvlHhDO31XPJVRK9pcyWsgEd55G5EOdE1NB
         F96mc3Hl1ux/ju/Ngz5Y/Osz2c6n7FVBmBbSk+nq73J+Ol3gOPFwxK0xlwmmwO961UdN
         ZDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716652969; x=1717257769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AViMprnRZDg8WlLNdCeKLRe1EXgWkFqK17wBJRWM63I=;
        b=eSJxGDVk59kSnPfqGpENInpBQqlYaKaEJvt4fx1O9toP77l7V84WQeIs0p3TJSkePo
         EuHBq53oh3mSCrvfwEVN1bRKGo2WY1eowqEFsJr/gopsRGxmiJX9G7kJrZb35sPOD109
         XVqC+ZbLYZBzHD/IvdUSzGWMLPL/AqeDtJhjAAQW8UPaZD3ebfIvtBh8zeWo52m9pHbj
         mk9wYvX4CqoIjYBaJ8o8ds+NGTTk8GMkSv5uBdF/0MZmJCk05LHmFnZ7wfmt6yQu1466
         yHOgvKCP6vj6Lyd3ks3Nj5DDbkaXYhGJBvmbzHkyiTweW5r7svG0RGhps04cij+M8GXa
         KYGA==
X-Forwarded-Encrypted: i=1; AJvYcCUQRuckXbqN76zCOhMRXAA283Pi44hx0d4d893LBKPGZ+9IDzEDKefXNgTumR+n6eYjgkM6my+Ws0AAQD02McLvzu6n4eLsLNz3bOep
X-Gm-Message-State: AOJu0YzY7zmIW8tbPbHlarci7EKY+PDitKK0cb+S/RiUDz86TU0+HfyM
	7wr5utaOrEP0vv+DdqzK6ovlNdElQtzMsuI4QlWGXDwbhKtX1iLM
X-Google-Smtp-Source: AGHT+IH8F+iMmwX9YKpALznoihMfYEKPSO49DL5/qynDmNyFDsPcSgr0VzrN329gKNRZCvIhdxRbew==
X-Received: by 2002:a17:902:7808:b0:1f2:f854:f59 with SMTP id d9443c01a7336-1f4486efeeamr39861045ad.15.1716652969053;
        Sat, 25 May 2024 09:02:49 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9b0787sm31668435ad.242.2024.05.25.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 09:02:48 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	ayushtiw0110@gmail.com,
	namcaov@gmail.com,
	dan.carpenter@linaro.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: Fix spelling mistake in rtl871x_io.h
Date: Sat, 25 May 2024 21:47:29 +0545
Message-Id: <20240525160230.66365-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects misspelled word to increase code readability and
searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index c5b12f74ebf8..f09d50a29b82 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -62,7 +62,7 @@
 #define IO_WR_BURST(x)		(IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | \
 				((x) & _IOSZ_MASK_))
 #define IO_RD_BURST(x)		(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
-/*below is for the intf_option bit defition...*/
+/*below is for the intf_option bit definition...*/
 #define _INTF_ASYNC_	BIT(0)	/*support async io*/
 struct intf_priv;
 struct	intf_hdl;
-- 
2.34.1


