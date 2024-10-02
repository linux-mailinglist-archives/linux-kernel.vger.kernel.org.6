Return-Path: <linux-kernel+bounces-347582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E94B98D5FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881001C2228B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA071D0480;
	Wed,  2 Oct 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi7uZn8K"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1F376
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876119; cv=none; b=MYErDSh+Egtib/dWadq9yz9pj1JuslgddDhWgNV5zyUYwicY9YPNrOReFuMcHuq1wEPTcEOyX/snThxki+MShngSEvDJ9ek6+q0Z9nwEzlWyrjFtzh7qgVUB15i1vkl2Yf7oE/kI3VPCum+XcZ6/mzWvc9EAjzFj/WX5SITyTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876119; c=relaxed/simple;
	bh=qRwlxlFAtaAJ74vl3Z0QjZYZyaUCpEOgDJUxtQKtx/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9Nm0sKHw1FYhp991u4zcmAxRjxJ0Y4/+/8cBLo57/U0cDnNyxph8gBrHVzwC3xgZgSHEvOmgyaUWTwBIK+88qwLHBnsGAgfEVcheBJWRPFKDu5vF8FEvsw4n4MKTqPhhojA7sNuYI4fhPphaW5Dgz8kRpTk5MhAc3JexmaIlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi7uZn8K; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso61776885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876116; x=1728480916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl8qdL9Esuv1xaPNJPqak6gWKhyL0JBXKUYSyQnPmDA=;
        b=Vi7uZn8K14AdL36mlkcvIq13HtN3CYeOI2GgOz31dHaTN++afib58D2El18fsUnhc5
         MDbv7O5qvkCUklbb1JNs+dO72QfPzz0ofcWhWG+aBd+6ikf63Cr0NHUPgu+hLsQcUq6/
         SALUu4szqpURwHZvT39qiLX3sjLAxAfTJED5K8Z+myJpksEuM2kUrlO/fSdk+rByFioI
         l+nALrSbU2vmFaBNzhUMS1tTfXYiNNpeXmNTuMoL/nxgOJ1rrozu2JVX6QX5/ZM8mPL/
         7pOPjopSAdY+Pj1Oh4KlhRIxG9UorEfd9RIwf+A0S3UNYRa3TLc/yeCyeD1U2ZIEKcHu
         hbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876116; x=1728480916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl8qdL9Esuv1xaPNJPqak6gWKhyL0JBXKUYSyQnPmDA=;
        b=iqExkv7OXQGC6yiUajNWxULXqVwBA+dZgyi9nCUgg1a+9sCov8A6SUqLfgfyaU5+PL
         x6lTSeFEhdlH00YddB8e/XpKZ05zQNMWIJ3uhjfhd4o5N9eNA0wWcKLCo658fc75dPhd
         XtSaEXNmMufh+U5CjTvbnP0PIcF/I58NxRrFRdVXQAVoMv0x5As2nzmVuei02FpF8r3q
         RNqFhbK2a7lJwiOPF3xbv3ciU9frPDmmZq+h0JRQcayVuk5DBLv7y1SFFGD0C8avADQ5
         L1G2XO+DNduYf5+9xr2Wb2SDGaalpNfFnTqOTDuMMhQWxgoqbC4e7f25Q7+4goynq5V8
         srCA==
X-Gm-Message-State: AOJu0Yy0o+WZowhc37c1Ke+Rgpyfrq3TMebeEx7d6JyK/Z9RCpd6DGOX
	Go+/dFhTWKNLlcjWabsLKVyS5RR9Ys2j9oGrJ+fd3l3GCR2PR0SUJ8JFalbPC0M=
X-Google-Smtp-Source: AGHT+IGtjD7lriJd0/yQxR3an54eIw7mxpO43Zclz1QzQH0dVES9xwOfzVr8zyx1ejoFOFFHtqx8LA==
X-Received: by 2002:a05:600c:3514:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-42f777ba627mr24380985e9.12.1727876115634;
        Wed, 02 Oct 2024 06:35:15 -0700 (PDT)
Received: from localhost.localdomain ([146.70.124.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f771c208bsm21052235e9.0.2024.10.02.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:35:15 -0700 (PDT)
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>,
	Tudor Gheorghiu <tudor.reda@gmail.com>
Subject: [PATCH] checkpatch: fix IIO_DEV_ATTR false positives
Date: Wed,  2 Oct 2024 16:34:19 +0300
Message-ID: <20241002133418.7924-2-tudor.reda@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NON_OCTAL_PERMISSIONS checkpatch error can trigger false positives
when searching for the "IIO_DEV_ATTR_[A-Z_]+" pattern. The script checks
for any matching macros and reports an error if the first argument is a
literal and is not in octal notation.

There are a few other macros that match this pattern, in which the first
argument is not a file permission, therefore they don't necessarily need
to be matched by this condition.

The macros are all defined in include/linux/iio/sysfs.h:

> #define IIO_DEV_ATTR_SAMP_FREQ(_mode, _show, _store)
> #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)
> #define IIO_DEV_ATTR_INT_TIME_AVAIL(_show)
> #define IIO_DEV_ATTR_TEMP_RAW(_show)

The script is fixed by matching IIO_DEV_ATTR_SAMP_FREQ exclusively.

Discovered by running checkpatch on some staging iio drivers:
https://lore.kernel.org/linux-iio/20241001202430.15874-2-tudor.reda@gmail.com/

Potential checkpatch issue identified and patch suggested:
https://lore.kernel.org/linux-iio/20241001225426.wUBOFdMi@linutronix.de/

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
Suggested-by: Nam Cao <namcao@linutronix.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..2fb4549fede2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -817,7 +817,7 @@ our @mode_permission_funcs = (
 	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
 	["proc_create(?:_data|)", 2],
 	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
-	["IIO_DEV_ATTR_[A-Z_]+", 1],
+	["IIO_DEV_ATTR_SAMP_FREQ", 1],
 	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
 	["SENSOR_TEMPLATE(?:_2|)", 3],
 	["__ATTR", 2],
-- 
2.43.0


