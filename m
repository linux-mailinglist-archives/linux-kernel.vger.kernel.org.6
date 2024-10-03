Return-Path: <linux-kernel+bounces-349718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E498FA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C1F1C2127E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B391CF5DC;
	Thu,  3 Oct 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSlK9Lqc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56014F124;
	Thu,  3 Oct 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998118; cv=none; b=UmIBe2tLDF/LR76UF4BGoxCNtXoYuOF73G+fkMAQEMf04lUAhtRWVAe9Ec/snhjiC1R0GTQ1NtK4hueFAl4FuTc/apHJUhhQlbPIqSw9a+FlRuQmZAZEH6f+E34QFxYJrX1rVxbt/UzQRuUp/mDB8gsjiKMRkyoFv0F46nP79Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998118; c=relaxed/simple;
	bh=4fPZFq9GucltM9qF4rscl7ftDfoWZ+wWMtPS0pSK47E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVQSVWO6FJSI7IoH4hndF6c4RmmswXVVAZgNF8rwolVwEmfSSN39SwzxnDm9JNJ+sUZa20VZ3BGX9vCaNlpTVzjiBIuzH3iZIuI+7JQ35R23tlxFi40veFKNLIsato+nb4fPiznGuEqXBN72pl5Yl7d7NOl0JZ0iHVxWfJARTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uc.cl; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSlK9Lqc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uc.cl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20bc2970df5so11704735ad.3;
        Thu, 03 Oct 2024 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727998115; x=1728602915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EYpCc4I8glQ7ck+nhqJAvbOoAL+loG6airV9nPgLSA0=;
        b=XSlK9LqcDnx5MbCEbNFZKzgtyZcdQafrdJnEfqVhCq1Moxh2NfGUD0Mn6nVHCBkwOo
         Q6pl5LrJpz9hOHsQEXG4VIdVnQDEl+m+TrPDf2g2tcI4WX42cpIqQmpDqwun0sfPT83V
         ZaEOZd9PznIBApD/J8S8UCoStx45hxRBwgFK+OpH9n1XlOnw7TYdv/eNITySX/+T6kS3
         5XSVuHrZmnnM/jUpxofe3YLqub8mRmH50tCsGtn8v6j94Jtnopq4fAW7W4ay/XuL1B0a
         e6jKIOSJmv/BTJxGNA0NbhrcQTrio3Bp1fQCVtKGAwaKtk+qyzi6RA28idgiNIp7MzaG
         mEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998115; x=1728602915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYpCc4I8glQ7ck+nhqJAvbOoAL+loG6airV9nPgLSA0=;
        b=KaFnrMoXrKKxbBnipvr6NFSMw4JqaEWh3tyV05cHnYzWYCg3wRN0M+xxhSK8H87Hw7
         x00109RZlwDyK2LJ/JqbVijpEVPgRqUawICjMJLZFbO1vN3vXIN/K/tMMVEV70pvmeWw
         ncb+6WD9z43eyEGu1HFrpyguwmgokvAKQOxuz/vQy2Y936puBG+x1sTt6yf7+SlpkTVt
         SKU/6RRIUYPYpQU22Liut/44p4HQwAAiVnalQawvd+JQYgLuynJW+kCmwTqkAlJCgLaj
         Db8h1lNhwj51vA046dzCj7d4RXHqk///b8Si6bmSZ7udhy0pgt+g7AwvZOihc1gf0opx
         vZqg==
X-Forwarded-Encrypted: i=1; AJvYcCU1gRX09QVsQtwdgpUYk5Ul9HV39mdV4xmiuUtipGS5FujM3PV71IMXY1IZpdfznubpowb5YZoth7gNGko=@vger.kernel.org, AJvYcCUEtGqHwdnGxtjSjV0jeVaPhYjk+NBZusyeTKF4z2S5IHNnyCyfWomrhpgVounFKcskJsvkkv+vbodEYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FS9dkr7b1MlZc4sDwc0Fvg0P7tS6dYjVWJtGGhUf23V2DDbz
	Q5PMSFoiiz0OktOtqyuituLftu+8R3kDtJ5LTKcXqPu1Z4R2App/WKoGvw==
X-Google-Smtp-Source: AGHT+IEjarl3ZFpoUlFYkZdMg7n2IxlJk17wP6TTR8dFnbsiCBWhX7f7OnO+tIVjnbgIBL/v/zloBA==
X-Received: by 2002:a17:903:32d2:b0:206:a79c:ba37 with SMTP id d9443c01a7336-20bfdfb05e7mr9329415ad.19.1727998115304;
        Thu, 03 Oct 2024 16:28:35 -0700 (PDT)
Received: from lenovoKubuntu.. ([2800:150:11c:d43:5c59:fa0e:7df0:84f5])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20beead24e7sm14118155ad.10.2024.10.03.16.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:28:34 -0700 (PDT)
Sender: =?UTF-8?Q?Hans_Peter_M=C3=B6ller?= <hmoller@gmail.com>
From: Hans P Moller <hmoller@uc.cl>
To: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans P Moller <hmoller@uc.cl>
Subject: [PATCH] ALSA: line6: add hw monitor volume control to POD HD500X
Date: Thu,  3 Oct 2024 20:28:28 -0300
Message-ID: <20241003232828.5819-1-hmoller@uc.cl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hw monitor volume control for POD HD500X. This is done adding
LINE6_CAP_HWMON_CTL to the capabilities

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
---
 sound/usb/line6/podhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index ffd8c157a281..70de08635f54 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -507,7 +507,7 @@ static const struct line6_properties podhd_properties_table[] = {
 	[LINE6_PODHD500X] = {
 		.id = "PODHD500X",
 		.name = "POD HD500X",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_HWMON_CTL
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
-- 
2.43.0


