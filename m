Return-Path: <linux-kernel+bounces-296300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD695A8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03405B22076
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD11B641;
	Thu, 22 Aug 2024 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrzB9YT9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C338BF3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286429; cv=none; b=qBPylKjaB2ElDMckgyPAzxTson/jC1qeQjmpoh6ehy0eY+fmgGJwZhTBz//Jb9RgC9lS1Yt+t0NdT591BuhXwJwRxTstIalRZdWLN15IBvTXigKSbzMVtQSfUffr37TCbJB8DFqJ5m5GaaJVjk45ZrQZZV5ot4JKunIBKUlyWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286429; c=relaxed/simple;
	bh=3pp6gpSU7hKvKNGBkaWHTyCgUV02DJGsTirelpariC0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OukKfO8NpPZFq1rHm8RSInWGIbK6dgEnN5Zn9NmmZymL03hmgBZKWKvWRP0vPOLL5Oy5QK58fG1RT7vF9unKND2EAGhrVzXSl8S/14G3qj4u4GCqT6W9n6jJqYATB9p9H82ITb71Z78f8uXU+3d7b9k8I6HiQno4oehiNdy6Olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrzB9YT9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-202146e93f6so2316145ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286427; x=1724891227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RvlAQhh2Iu5hUoNlMc40btF8Kdl4Oqh4oQPMDczCT44=;
        b=SrzB9YT9ppOsbkjhQZ6OFXE1vx8R+0TOY4yq0HFoZEVfgLtT/FpcvYeL1DlfeGC5X6
         25iJpUagom0TIWLdcJQQkrdcCIRlwh6ddbBKxcvf85mVJw9rf+4ujXtrBNvQ46qljmpi
         pxMT7AaGOY/WfXRvzxdabrJ2LMx6SNFOOLibh2Jbdqc8iDrKcJgxf0cNMhKTF0xhdC33
         6ibLHYg1OmNhFRdWTgGXnCWCR07V9cNddnUb6V7V3S2aoW+vNEqHUKbxvNlXWkm0s6ps
         OysXZSq7ZrliLITDs1Fartmvzd8Ig81TibcqonFpWPaq5ufp0YSslV/6ojS5EBF6p40N
         vFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286427; x=1724891227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvlAQhh2Iu5hUoNlMc40btF8Kdl4Oqh4oQPMDczCT44=;
        b=PflhaIml0Sh1VDpKTDgr0jNXtxHQmb6HSCGH3wc508nSWsTfEewizIHQqXkpwqEy9K
         lhLF6+SOV/YJs4rcYX92tYYBPOogtEH1dk28RhYs1/QpL5Jw92lRN0gxJmeOfF43iYCS
         S84LX6LBzg9FqA15MEOC5zMkOqcinPvaYR4QTyySe+U2X0/PD2ivNFDFtdpEmK7RoJVo
         mBK5wWnBG0urOY2vuWA8w9Ii/mm4cBORCFL7eaNf4ZRAqtC27xVcfj7PjjhIbrMxDxuC
         hAtuxmDgzKVdy7nysVb8fyY3ItRkO/lq6OnGwP01G7feWbbxqyk1sQxaGJfj7m2NB4UI
         k6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWP8QDz/eT4q5fMMdPOGv54QPLuJkCfMF+vRxvcFnD/JHlAYNg9O6gbtgRF3Xg3/jbNHzJcuzAs6QDOU1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlNSYHvMlHLkZUJ0a3ZXv2sgUJIKNZaNTR0WWUGaozmri/Fd7
	GvGdaF32inXXhTkjsPItxP9kPISWC5WYHIGvwu5rn/N+7WqY3o1G
X-Google-Smtp-Source: AGHT+IEkozD7C27Noa+fI0EwtD/V4c/ip/cpFJi+eeSAwVrGS8pBO7celhVousV0wLHSKTfa2nZqdA==
X-Received: by 2002:a17:902:cecb:b0:200:aa78:cfc7 with SMTP id d9443c01a7336-20367d32badmr47069205ad.2.1724286427390;
        Wed, 21 Aug 2024 17:27:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:16d8:ec10:100:8c4e:d5a2:795b:a46e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f081sm1725635ad.94.2024.08.21.17.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:27:07 -0700 (PDT)
From: Nilo Alexandre <n1lux.comp@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: Fix alignment parenthesis
Date: Wed, 21 Aug 2024 21:27:00 -0300
Message-ID: <20240822002703.4183848-1-n1lux.comp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix alignment parenthesis in _rtl92e_read_eeprom_info

CHECK: Alignment should match open parenthesis

Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index d95807ceed7a6..caaa79935d7da 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -322,7 +322,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->autoload_fail_flag) {
 				usValue = rtl92e_eeprom_read(dev,
-					                     EEPROM_TxPwDiff_CrystalCap >> 1);
+								EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
 				priv->eeprom_crystal_cap = (usValue & 0xf000)
 							 >> 12;
-- 
2.46.0


