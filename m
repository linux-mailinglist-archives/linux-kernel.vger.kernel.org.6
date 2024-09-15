Return-Path: <linux-kernel+bounces-329704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59D9794CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5972B22809
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A0D13BACB;
	Sun, 15 Sep 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyeqIcMB"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2D7FBD1
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382469; cv=none; b=In+bK4440VxeCEtWREbUD2+VKVisP6DDyu3cjAfk9TvXUHmRJ39lG39ucSyAiLLhgyAQIp+pK1V4onzkpHOUrsNYbAupXwselR0Jhbr8hMXpCB3/uvLPVFsXFOvSc/k3BLFy7dv5uAglaPypKvL8z09VIVffzJBksJ1yVpEZPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382469; c=relaxed/simple;
	bh=h9V7Ghl5P4/1F4b4WHbT0bOdMUDLi3kP3qcWsoffqKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdKUDLMf6mMounFFGsfra63XXmLEmgIHz1i31xXUqPtc2kYssYmCi0a4beBCuJc1BfqsyOmGIlk/37VLbU+39k/C1UV/ZhlfJgBV/ZDeNEMgwIBIiZAVy0BFI8b4RaKem4wqYtAtiEg3X+3cnRju8SAk+9dkM6wTNtODyIgqqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyeqIcMB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so436947966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382465; x=1726987265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trv9Z7LRh7POQ7levyTVtahqiIPQOrS27lYcldQAO3s=;
        b=GyeqIcMBxX0QL8Aj6OUHiIBjsrkn/LexerCWbNiKz2eq3XlzvUrSGjTLBUyWanz2X+
         rnQyL06Sd5pPhXOcEenEc5k093Du1Hq3WU17sg+aTXieMuqH5L7U59SJb16KIUvDOb6q
         +DhiUPtBa+hHm2dORujM83R0XH7VOxESDeAM2q5Tf5t4BkqaNa+Bb+Gd08c7F6IqD3jf
         zIXF3YSKS26REdNdPZa9l+GFm8PtVGFu6MBwNS08dxB2/Xtv9tolqTR3gxYcnC+oJwAS
         TqKW/BEdi3vmXEG/rkxurb4ORGHWJeEbzTnDTPSSFclTZ7B5p3nSrhIUtGWkRGcjUk12
         GLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382465; x=1726987265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trv9Z7LRh7POQ7levyTVtahqiIPQOrS27lYcldQAO3s=;
        b=gd6sYyePu61mUbeWSmtW1Z1H3dFun59ZrD/F3fkmJ3IP8qK24PvBw9CFZLUzFP+Ooo
         atfN8nwG4o1h9Jy6/hxbpJ36N9i8qwbc/P1Aane4ypGZVet5KTPawxjCgEOUKu8XYWcY
         VnP6XVICgm6DTX9jQhOQx3wtBf0HNzYGA0v15JRRvl8NnpmUvJi3UFwrOMmjSGWKGP/q
         S912qxp59q2oP6Ur7d9RQu9DSRTNzW0JBcZysozoTKGRKPYAb9P5RGU9bxBSYslK7Dr9
         GsoteDkAcz6JpjDstEc3APKQbDTn/prHa7YRx4pl16+RfoZ4GkOl4MlOXVRc4zXEwiM7
         wf1w==
X-Forwarded-Encrypted: i=1; AJvYcCUHn8AwIUSJjCtIqtkIWtDP7fVSCaUdIl7X6OqpkSS1u7b0SOJXdfd2auHooYF0uFT2mLzTK4zaQrOWrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9otRtcv42FtXjwYCV+WSi1a/mjJlAvliukFt6SQ0yCGN1yeh
	ZfKPf3ZM1MRSOwtJUCprM5ZdbSX/Zu3nTvK5cIHA/7QC9Oa2ezl6QWtsAA==
X-Google-Smtp-Source: AGHT+IEF/Zm1DMZVZpX+ITdOiper6SsIl0DpHr22GnH7r6/Ax7JA/xHyyO/k5+GCFDEY9PsngeKE7Q==
X-Received: by 2002:a17:907:97ce:b0:a79:82c1:a5b2 with SMTP id a640c23a62f3a-a90293b1881mr1072358666b.9.1726382465378;
        Sat, 14 Sep 2024 23:41:05 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:05 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 13/17] staging: rtl8723bs: Remove unused function rtl8723bs_inirp_init
Date: Sun, 15 Sep 2024 08:38:27 +0200
Message-ID: <617f5fe59abf5f44c70566db60cc624e304c678f.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function rtl8723bs_inirp_init and belonging unused
function pointer in struct hal_ops inirp_init.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ------
 drivers/staging/rtl8723bs/include/hal_intf.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index d3aae413fc0f..93d455aabccf 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -937,11 +937,6 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 	return _SUCCESS;
 }
 
-static u32 rtl8723bs_inirp_init(struct adapter *padapter)
-{
-	return _SUCCESS;
-}
-
 static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
 {
 	return _SUCCESS;
@@ -1272,7 +1267,6 @@ void rtl8723bs_set_hal_ops(struct adapter *padapter)
 	pHalFunc->hal_init = &rtl8723bs_hal_init;
 	pHalFunc->hal_deinit = &rtl8723bs_hal_deinit;
 
-	pHalFunc->inirp_init = &rtl8723bs_inirp_init;
 	pHalFunc->inirp_deinit = &rtl8723bs_inirp_deinit;
 
 	pHalFunc->init_xmit_priv = &rtl8723bs_init_xmit_priv;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 73b6c4d199c3..0fc3622806a0 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -167,7 +167,6 @@ struct hal_ops {
 
 	void (*free_hal_data)(struct adapter *padapter);
 
-	u32 (*inirp_init)(struct adapter *padapter);
 	u32 (*inirp_deinit)(struct adapter *padapter);
 
 	s32	(*init_xmit_priv)(struct adapter *padapter);
-- 
2.43.0


