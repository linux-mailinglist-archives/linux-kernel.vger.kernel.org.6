Return-Path: <linux-kernel+bounces-213522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E2907667
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C72840AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C90149E1E;
	Thu, 13 Jun 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOC9wJYT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF99149C62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291865; cv=none; b=kbuyH485GBQ2ZILTtZ/CZ+7/DAyp8gGnI0dTy0+HVDCHygaX2jJ0VtKW7a8+Y9NcqeihBFaMWCjkvMcnagUwvvFj/hhiiNqcSMiGJgJG/OOZeB415i234cBCoTFNwFDlcyAsg8lRHDxK+wXjWR0ba/ukzODQxkOfkff+9jN+Wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291865; c=relaxed/simple;
	bh=jdW7r0DvMXZ+6bD8HOFgHdxMq3SFo3mD1pj8POZ4qAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxewb+4rh14zISJ1dX/1wEiCTiLOObn1B614ml8gEkp5KB7yCDuzZK42YSVK0zAr1LJrYvYC+2/PiK/GXCdKXrIe47hT2OcUu5niA0JfW3uiuMDiZ3JIDv1DHnInRybehk2eIflyd8padAO5hYjDg6JjNiikjXuJUigUcRfC1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOC9wJYT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so1352987a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291862; x=1718896662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u+4y22eKBX5WD/mmlsZLnRYhcILJ7Rc9DRw3I8loPM=;
        b=HOC9wJYTbKQO9zZs2ZPoLzZREizGpXbZwq3mjf0ZuXkH6q0EtttPubQOpnc9j0Pfpi
         MjKAhjn3pBb3j1WrnloBrgfknM2y1g+xAKku7m2GFTqH/hfunpKA+ijmOsIJSPAk5sif
         A+Fg/JTFPx/XiZSJ/u3mxrITNF8N9XEXd4/uPOQJealTkzXfoNgKdaYodI15XmuQ/xnt
         2pFZnLmazhYxCttOoiPOIAFplgTJ65AxmI7aoqfDCuEHFkF9/ej6bXWpbPrXm7YuoLEU
         1ZJTEARFSTYFiIBr4g0n5r1nkRx6xTC4y0bLLWmXjUlViWkfSss/k0GIIQl4lvY5E7Wp
         U5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291862; x=1718896662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u+4y22eKBX5WD/mmlsZLnRYhcILJ7Rc9DRw3I8loPM=;
        b=vGG3QCcMyvA4Ybdn+DwMm+HOUEZToEja4RqzkxLN6Fu5H80to9aeiczs34vU+E1saH
         3ss2Ts48LZ/TXExi0kiDhIA/D1vxbpbs6cqRfhAvfCYi8UcGxLP0i63Zw/rH+EntYVE5
         4TMkU79fOjCbyQiArWILV4M6W0tWHMdRo9oyI1bAHxPoxyLisbf73RhNa3tGumBr6X/L
         SJQIYy0xhCCfdtB0cFtv+jwGThMW6tRaAGlC2Jf39RN8OP8l+opoXE7d1loWmuQYMiHu
         M8JFPgACuBAVt5ji8jDn2TG16B5tybEj5/BKiB4y/JwcD5ZSHxyrkzvLshZwdJFc9KP1
         dkbA==
X-Forwarded-Encrypted: i=1; AJvYcCVJUuyPmpHWpFVcEaWpUacSr/cBfS6zXn65MAEFvOGT5MFwJHnXMzLJNKQxn5o8IjXsWsf6ovb0ecnU3qbkkwwZ2kB9leUlnQniE13G
X-Gm-Message-State: AOJu0Yxf0Nm8rk8AT4H33xRBMWdulFwjyF7uC5WWg1V4u1a2e4H4P7X7
	ZuzfS90OhSuHoj0RcSUVClNOYgarfxzsCNPGGV6YLdlq4aMaj/6u
X-Google-Smtp-Source: AGHT+IEepVCor/QDkO/5TMDgOqVVUt7KvHUZp/gpcRZ5qehhECfUzrLx8B92fl9Owj0ID6fAZFsSnQ==
X-Received: by 2002:a17:906:605:b0:a6e:fe30:5c78 with SMTP id a640c23a62f3a-a6f60d1e040mr5811466b.19.1718291862052;
        Thu, 13 Jun 2024 08:17:42 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:41 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 3/6] staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
Date: Thu, 13 Jun 2024 16:16:34 +0100
Message-Id: <435144fee61f0432af269e3cf386d984a2f218c4.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
References: <cover.1718291024.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused constant.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 84e673452be4..863af8ef9f94 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -33,8 +33,6 @@
 #define		RATE_ADAPTIVE_TH_LOW_40M		10
 #define		VERY_LOW_RSSI				15
 
-#define		WA_IOT_TH_VAL				25
-
 #define		E_FOR_TX_POWER_TRACK	       300
 #define		TX_POWER_NEAR_FIELD_THRESH_HIGH		68
 #define		TX_POWER_NEAR_FIELD_THRESH_LOW		62
-- 
2.39.2


