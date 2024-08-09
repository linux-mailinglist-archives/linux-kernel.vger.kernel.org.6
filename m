Return-Path: <linux-kernel+bounces-281371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFA94D623
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F17B211BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9E1465BA;
	Fri,  9 Aug 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGHJCjOs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E2146590
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227199; cv=none; b=V5B83z+TVi3rQhGxBrt2LRWSbPbSe1CjvDZjg9ztLtq4x6C/639rSN7m3N1/cPOxRRjy4r6Uu0Py2ud1Tz9Ty3W/iVNNgregDFW2Iw9nJqKv93MRt2vtPNX1511TU7p4Z5fRH917ZEhaOXTqDbirUTDInKNkWuxIKfiOHvvDQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227199; c=relaxed/simple;
	bh=JWCgYbzf+h1KKPwP8jzN/aLLpgY4lR1Jk1TknmNYx+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBz5MpfACUhvPNRA90fugrpE6p9PAD4F4IeeieMZmZYzKPc8fLnUeSRxE2Hq4EfiGoutlHbWT/pV3nHVVwuxAgGEFBbJdRqR3yXnaCV0jQBfe1LXinRH7tctVkyYGh9JtaVeZ82sO9AvGTyKibsrabtF+moTLwJA0znVhLBZwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGHJCjOs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so737164e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723227195; x=1723831995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBI9gWTu2lk3Xag4H2X6YcQpeUA1X2ClW7QmG/3ro88=;
        b=fGHJCjOssyemtfnOz0TSAwh6huVqmQzVUqlRJlWSirDNYxpjmdFlCYRO9IYcV42PvH
         HkPNy2VPjZLH5hBIOvSEZGh427oPOLX8LOGDU20PL+SzT7cDj/JDw9KwcWnA3qAm35k8
         AKY0oR0TzL80dumpRd/zVzFnGSWkB0koBssUrcWPH1ge6SrLcjZ5VFbxTgQIXkrxcSiM
         XAla06VmHRTKLEvzZ4Qspx2mkkoGPdu+R8MdwSiR3cDJua+72pCtr52rXvrNWHqXZQ8n
         2Q3Mk4Oy3jMOiM2rJ+0TGpEZoXqTxHrrrTyohTel9n1elo2AlgOibB2fJMVzhfCYkKvo
         W+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227195; x=1723831995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBI9gWTu2lk3Xag4H2X6YcQpeUA1X2ClW7QmG/3ro88=;
        b=AVln5kYpwyw7jWhr8ZktjIx82lzQdaxmjHsdWv11PF+LdG2KnbLqxip4IG5MnoV7qn
         Ov3OC1GRVdG4PItf0+rDDUAEdqntJu5mrDdSxM/AM3G83p54jC9DQen+zCZQLzNhTlXl
         GfbPOS/2WCkLW0bqkslAAdVG7pCOHkaFksai4lLv+6fwIOamM8x5SgQfBZcmMCVAYKey
         OZ7IzV+gc7Wo5svJeJrx90hHOaL0JcIWph611HKM81pxD7hjgGZZKVX8PTGRqLQE6zFw
         E/dwQrjOzYTYG7VMZQqZ+9T7xsr5B2/EvILVzHFfsDmpz8Aybl7TDo3t29uvT7jzvA1G
         YTaQ==
X-Gm-Message-State: AOJu0Yyc6FbKkYHFH9FS3Lms7JXhrmScsJIzdoFEOnvpa2wj8vaBJa5o
	g3fANF+4reX2u3NAqY7BWHhTGWyltLc3reP9BQGPTqaVQTznj7sfcmywV1wYW53OQQ==
X-Google-Smtp-Source: AGHT+IFwfco+ndQ4TrtTIKC97NW2y3O3JAiq66SMoIyaUm805y2VhjFFyG9d+GmAUaJn6D0f4YKjgA==
X-Received: by 2002:a05:6512:3b95:b0:52c:d6a1:5734 with SMTP id 2adb3069b0e04-530ee979bd8mr1522945e87.14.1723227194933;
        Fri, 09 Aug 2024 11:13:14 -0700 (PDT)
Received: from localhost.localdomain ([5.211.194.141])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-530de465362sm1063840e87.182.2024.08.09.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:13:14 -0700 (PDT)
From: Parsa Poorshikhian <parsa.poorsh@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Parsa Poorshikhian <parsa.poorsh@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7
Date: Fri,  9 Aug 2024 21:42:57 +0330
Message-ID: <20240809181303.9882-1-parsa.poorsh@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 70794b9563fe ("ALSA: hda/realtek: Add more codec ID to no shutup pins list")
Fix noise from speakers connected to AUX port when no sound is playing.
The problem occurs because the `alc_shutup_pins` function includes
a 0x10ec0257 vendor ID, which causes noise on Lenovo IdeaPad 3 15IAU7 with
Realtek ALC257 codec when no sound is playing.
Removing this vendor ID from the function fixes the bug.

Signed-off-by: Parsa Poorshikhian <parsa.poorsh@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2dbcf8f5bcf..7b593642da99 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,7 +583,6 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
-	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
-- 
2.45.2


