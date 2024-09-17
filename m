Return-Path: <linux-kernel+bounces-331304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FC97AB13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CE21F213AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE8166F2E;
	Tue, 17 Sep 2024 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iAjbsf2a"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C81607A4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551130; cv=none; b=cbqttOGIQyqkmXrcVPihEubLKTAWqfTc42WYVjQL2/Qv5xSmxCUnLDOrNthHLXAJ+1ShoM0cnIhYGgCYK4AGJ5iplsGzi9CIPZji83a351Yma96viATc4dLHn81604yX7zWrcII2reTUeJWb0vKqrvWEeQv+dNJrluZiKH13KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551130; c=relaxed/simple;
	bh=6yEMFfoSwpjfCXOzC67az4SEYPpIZWGHydG6G11AuDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/qYtzkqn/P41Zhn1VDBiEj1rBSQ4YRFityirRJcDDQcdRJ/epAnI2SYJ8ZueO1l9noWKj94e8qD9QyR7h+c1DHg/SoGCly15cWGJq5DxSPRXnrr0DY7c6c+R1UQ4KjWDIG0C3dlBcg7ZWnfIb02Q0hoAgmA9f2xRSRdluQZADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iAjbsf2a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71781f42f75so4521905b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551128; x=1727155928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt17mD/dE//1Ybyc4L7AOySBbggFjSxKjKPkk3oTidQ=;
        b=iAjbsf2aYlLekUngv20yV28kp/W/ce9Iny95VRXd2Km73ffbxHPpPWfzACoGx4Hxzo
         CDF7VuD31mYhgOoXsgB9hdWay1TevZ0JmSS0gBykv6PC2P/gaxT/v6j1f7U3fhYSmP00
         IsfYbdK9XAqAkt8Ch1gH3QreYWUyD99Kq21l1SoXOO7NUaWIxX+MCZI6CxuMzXsRljEQ
         YAH/PklgU4UZrYebj4o0ts7ubypny5a4vbFLMwCOjkUlam99GM9iyfivujadJOB2Os73
         XnKKjbtT2Uww5qyDETOqCXgHnDtVybKsloZZ0qYQmR9QQfRoM99mhOh/RN5Rn8kmw8qE
         fJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551128; x=1727155928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt17mD/dE//1Ybyc4L7AOySBbggFjSxKjKPkk3oTidQ=;
        b=oQ3GoGyCbZh4LWrkAPfyjAdG/4uYm7vdMYFWrTjtFXdzcQ2KIVtSGNUMXK5bFEZBCk
         fOwqXW0teSzfIHw4PyAAznnlxno9Xaf+w+kY7fRJOw1HF96KiTfYC0aUWF/d2CCWCfVc
         obLSr2j0jqtcKuQ/hgWFoHq6MYGfLa3DfB/xPP/TCK1ujNC1k3tSq60/s+Ow++mi44bU
         0bs8H4J6ecKlmMQFlpoQoop15DrHThSsvhPVks2csP3jElJavboOz7P/f9pq7mp1x8dM
         m5Pf/YImxi62dwCjywnTaBcYgHlZalzWX/n3cb1I//oHPL3052mtG3Aew8RAQ25GjZL/
         Y28A==
X-Forwarded-Encrypted: i=1; AJvYcCULOlrZ0l5o+OACmtOxkjNkqmTOPfZxenVmdAHQHP/5tTERM6lrwkLwRa6WLT5lV38PNISro0JdYeAQnbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUZqBmYTHmPSDC5NSncamiLc5w21/RHqJ5T/GjPWPK0Dzf+CW
	WaPQOYgbhOKgRueLV29i5L8F7tZglXgs/3NJS0uIYoQyCgm0lYlMUrW+gxnvm2Y=
X-Google-Smtp-Source: AGHT+IHH7RLFZsPJYTmnjGh6vw5+VSIHlR9cQa8vhyBFrLJI1jwlzdgnVqAuQQqrwNXSJFPRICHYuQ==
X-Received: by 2002:a05:6a20:cd0e:b0:1cf:337e:9920 with SMTP id adf61e73a8af0-1cf764a7aa9mr29036901637.47.1726551127826;
        Mon, 16 Sep 2024 22:32:07 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:07 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 17/18] Staging: rtl8192e: Rename variable Sbox
Date: Mon, 16 Sep 2024 22:31:51 -0700
Message-Id: <20240917053152.575553-18-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable Sbox to box
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index fb80ae6c3f2f..2b9e882d0bef 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -137,7 +137,7 @@ static inline u16 Mk16_le(u16 *v)
 	return *v;
 }
 
-static const u16 Sbox[256] = {
+static const u16 box[256] = {
 	0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD, 0xDEB1, 0x9154,
 	0x6050, 0x0203, 0xCEA9, 0x567D, 0xE719, 0xB562, 0x4DE6, 0xEC9A,
 	0x8F45, 0x1F9D, 0x8940, 0xFA87, 0xEF15, 0xB2EB, 0x8EC9, 0xFB0B,
@@ -174,8 +174,8 @@ static const u16 Sbox[256] = {
 
 static inline u16 _S_(u16 v)
 {
-	u16 t = Sbox[Hi8(v)];
-	return Sbox[Lo8(v)] ^ ((t << 8) | (t >> 8));
+	u16 t = box[Hi8(v)];
+	return box[Lo8(v)] ^ ((t << 8) | (t >> 8));
 }
 
 #define PHASE1_LOOP_COUNT 8
-- 
2.30.2


