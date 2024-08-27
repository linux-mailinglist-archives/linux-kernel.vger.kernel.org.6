Return-Path: <linux-kernel+bounces-303708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2C961410
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3942851E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113191CC8A3;
	Tue, 27 Aug 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft9h65h9"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17070481CD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776157; cv=none; b=SlTknf8fSwjLHGZ7p/rGOSdgqWIaxF7kSehuuuHb4hPuEPfdX/5FsxHDCWJY94U7JqGG72FVzXfa+NAjCZcr9JbiweV3jHNtXpmaeZ7GMyOS2RE8gbw9vD81KdfV69cNu9SQs6WT2CgjXgdVexREXOO2jAsxNv2Aii+2bapjZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776157; c=relaxed/simple;
	bh=6d068J4OaSCdSOeFPpLuLxMTQDuS4GBYgsQPHIGhxO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DHYNkI+twK7wC7yDizPBsGA/nMNgYMKbRpyhVA9RQJ/42zT7LFUlF0UUVyZDiWB9TVr+jjrfQkszbQOKwYVw59oE9bQWYgxaV8dsFhgU9Xm+psDiobhhYUgnnjBnq+zOCyvs8YhtGVyw7LNHflz/STftmucrh9ZokJVijt3GFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft9h65h9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so3603865a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724776155; x=1725380955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LFAKdbhGymRn4n9Kj8H7SNpVd+huYYcGY/vR4eAu2Q=;
        b=ft9h65h9RC5kcAOURKy9qgRPqv/wEXT6AMO71+/2T2THCRu9ij2Ft+eT7vTyubqzZA
         0/CSNljEXshV/L4e8RtcF/HXtYTLEgLfF+rTUZHppT0YXVKy9ZXjBA/oNHapnhLtiXA6
         i79ODeNhrgygJIOrxi2Ao9nykh+tHpcWnjZrYZotVf+mzv/mOc7TJHPfQ3m+sSYYI+rb
         JLZJa0rWIlhDYZJTbMZZTMTY5n6Y9TmyF5yky9DGzPX9dh/W2yXQzgoPZm9adDqGGTJ5
         SDWIfgTWo6yzTPDCBEEB7GdAqs/P4ziNZCzjQtqUU6ViQfyOu3Gkz7cO61T6bnUmEub8
         Oxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724776155; x=1725380955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LFAKdbhGymRn4n9Kj8H7SNpVd+huYYcGY/vR4eAu2Q=;
        b=EH3Z7NRg1B7vlaFdaPM3ojA644U556JHVzVYuCRb1xJEUZRWlKT3SF0frTZJXur1Ev
         OnjjSukGOND9OQdzZZkRvgzZVJXic4A7QTZNtugQcVOlmi9Q42bsO2Qm61F29/5EWAQy
         f4xZOJQD4cHCn+uLtbzdueMbxP6nC0yuJ7mLCp6xhpikkTvuwAwC1CLy4ybO0ISQlznG
         EWV4+6vFGbcScwUsFeSulYoVzbKs/UbjMRzgl7xwCvXI4f6Ovb3zhbH/2h8P8d0ToR9/
         ybO/zlolvhEm4saOSR+fYI+mfFaPlXr4OMDlLvoKNg5q9u2j+yS2aBIkDlpURxYDYLxq
         aDLA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZdoBPMylFX3BizQWeDHeSwp4fmfuYotxSdr0CEoLy6AqVuRUh6ltFLFVQrfWQl5ogjcjOjpi4S4lmM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMB4CwyHHLA0kB6pv58Ynqbai4JSWApe80XOTjs/Ym41KTsD6
	mzzsFXa5EG6WOiw7QOWu31XVHPO87SWpASvUuXNR7rT8fkVCJgpsScMapf4S
X-Google-Smtp-Source: AGHT+IE4k6E1T8Yb1Tym/BNPCZsdNWhG92Mcx/Y1eLA04sVUFeUXaEfXhlebiy0kbLo1JdeN79n6Hg==
X-Received: by 2002:a17:90b:4f83:b0:2c9:80fd:a111 with SMTP id 98e67ed59e1d1-2d646bf2bd3mr13588417a91.18.1724776155246;
        Tue, 27 Aug 2024 09:29:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:16d8:ec10:100:8c4e:d5a2:795b:a46e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d61391a783sm12535548a91.14.2024.08.27.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:29:14 -0700 (PDT)
From: Nilo Alexandre <n1lux.comp@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] staging: rtl8192e: Fix alignment parenthesis
Date: Tue, 27 Aug 2024 13:29:10 -0300
Message-ID: <20240827162910.15459-1-n1lux.comp@gmail.com>
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

---
Changes in v2:
    - Using tabs instead of spaces

Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b767dc00100aa..2d17d8e8898e7 100644
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


