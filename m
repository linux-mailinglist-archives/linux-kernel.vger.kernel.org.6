Return-Path: <linux-kernel+bounces-184636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2118CA9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346CD2817DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23E54762;
	Tue, 21 May 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Mb/QJk"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE14F897
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279922; cv=none; b=KkywNIdDrf/7s5K5zucwSaJaXvASJEb2gF0T7FRzzQGIRm2wCjdaH86/7RPw66xhys/Mrrnl7YBdkpKipE/yHDJy8HcXwVbha7wI9pFEADZJGZP2gdlfE8ZtOCv+UnI1bnVLMume62g5gshTGv7MC0tnxhTVLAhZ0Cfyuw6iDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279922; c=relaxed/simple;
	bh=UMphL9CtM2ScYjcGliWymvECddVRUmfMh7T/9EmF5WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q2cAuoXx2q2pwyTuhGgopaAsvsjXm08nEM+adtDR1MJJFEK9S5WYgJTL9m6+Qpvc4j8fz+T1bKbh7IgtDKIry8NhAS13PQ7XkhazZIx1hdsgkI1fmdEUQnz//3x6GBMlkyK4McUOwl9V4ZuUYrsAFlC9jKCy2gE2bqjiD0Z6HWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Mb/QJk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f0e3667564so2198529a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716279920; x=1716884720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQJiOpbiO4NHr/WijrCrZ5Mc4ZByvlfcBypTMOSJ1Zw=;
        b=I2Mb/QJkTfXDa/pZDAf5s5k9pp0+kzlTNp1YJcpYyVaWnSWf5SAwDuZblTJBnk90pI
         n8RK5yetKwPNI3G2MXR08n6POquibihfhiPfk34O66SsvL+acepOU1A54UHsu2YB/tZ0
         37QWxcPaUPtJSzy/6W0DFzKCfP3hyA1931Lgt5mNKNVm1JKuuwWURkYvVR7f2Uu6X0QY
         tjpXHbgYDq/mr6WVEAomqKPdC5F+snannLeTiM1/lhQoP1Lau25ZYehAPdyoJIjgS71r
         15VVY1uqTHTsnC0bpUMZan4onS5FII7OwWqbkMnR+jQ56IR/6R/6s83HC8ieeGxz5MqX
         jqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279920; x=1716884720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQJiOpbiO4NHr/WijrCrZ5Mc4ZByvlfcBypTMOSJ1Zw=;
        b=FaifJ57mm20r1BYpDj7xTBJEv5H/ZlFDtxZU2Jbo9dn2HGrtiIyOKzvEnTkMHF/xBy
         hqTU2smIysZ39JyQ9sdFUOCCEG9Z9w0I/MACuuJpXqOxMkc4M88rYZHFFBaMEaXLz08W
         RRJryg5Y8AGo4jjaVSIkeCFXkg2rM6Bqdg6ORAvs0+OKTFziEtp2R3qe2+m/pIYdA8zB
         O2E3xNzoUxGDiGD80u3JQwcqgaNTJGj73JCQfGo6zsqx3dgID92jk6mrUUfzeYdPCn61
         +GmJW936355zXyuQ1URodgbFrigcB/IXHVeukmX2OgbN78UH2Pxs2mWjzAM65Lk2os7U
         QVAg==
X-Forwarded-Encrypted: i=1; AJvYcCUj9bp4fMAOdOQraVxBcAk5hOyyBnH/r/+tL5rZvRFul+K//pU4MA0OPjClm8V47xbNQ9jH21epjACe60AxjuiYkkJ44GiAPa5ZPcWS
X-Gm-Message-State: AOJu0YwnWAFxVbT7lxWHVrzu65pcbvW/SIvScj42z9twkbv/mop1IoFo
	rX6WwNKku3bdS10GfJc/BqDo2nK53FoFuWlAYcMCqh3aNuOzqN2c
X-Google-Smtp-Source: AGHT+IHVYDNs7w2Yoqut/Sm43G2/GzmjV5kGt8Ep7yyMndZQaKQsuYD45AcJ624BV58bp7l0bahQ7w==
X-Received: by 2002:a9d:7991:0:b0:6ee:21cc:ac91 with SMTP id 46e09a7af769-6f0e92b7f10mr33915071a34.32.1716279919779;
        Tue, 21 May 2024 01:25:19 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae2fcasm20265503b3a.123.2024.05.21.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:25:19 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	ayushtiw0110@gmail.com,
	dan.carpenter@linaro.org,
	namcaov@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: rtl8712: Fix spelling mistake in rtl871x_event.h
Date: Tue, 21 May 2024 14:10:10 +0545
Message-Id: <20240521082510.50422-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled joining in rtl871x_event.h. Correcting the
misspelled word improves readbility and helps in searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v2:
 - Changed "mistakes" to "mistake" in the patch title as suggested by Philipp
 - Updated the patch description to reflect why this change is important
   as suggested by Philipp
v1: https://lore.kernel.org/all/20240520064750.48912-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8712/rtl871x_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 759a2d27d8f2..0cc780cf4341 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -37,7 +37,7 @@ struct surveydone_event {
 };
 
 /*
- * Used to report the link result of joinning the given bss
+ * Used to report the link result of joining the given bss
  * join_res:
  *  -1: authentication fail
  *  -2: association fail
-- 
2.34.1


