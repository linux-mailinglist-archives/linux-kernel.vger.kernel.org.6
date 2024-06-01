Return-Path: <linux-kernel+bounces-197770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090748D6EE4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B953028523E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2C1CF8D;
	Sat,  1 Jun 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO5myp0A"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71F3D69
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230724; cv=none; b=Ep9qivM5c1XzmVB3wHcjZZh876bG6YZYDqXpJxDXc4TANTz778GdnvCfXs7sFc52iD3ciiGMttVoHoxTlOLKyORx0m3gmU4Vk+f8ADwevmTTF3ZX1M/wIfMkPenhweKT0MrJRkUYD2pZi3N0QetqJf8Qm6rPIrM+kq4IItnkMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230724; c=relaxed/simple;
	bh=FKb4cyZxX+aHBqlharm4di4pT4yRKJBQrV6+RAj1SmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpKeaWhO4+OoH9Y1iCeWgS6peHMYCYK/SrU/TlSfy+Ch4m0sF77zZv7Uj+0NIsCUjVpA/mx9i8CDLhiH1268gpm6kHa2lWJLpEXTIYJM1wP1TTEPznvaegH6xIUlxFHdKLslL9m4Lnh+Ph7JvcMxtnvMuVN+aAn1duFbP7Z6hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO5myp0A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c19bba897bso2163067a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717230723; x=1717835523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3hjzwanBytkl4obEE6D67qP07qRMuRdAI0wYEzYvMc=;
        b=KO5myp0AVxfKt1s5399lEOOMM244lD/dR8tUYiMrRhFjMDhqltCiFUNr1dSN/jJKHA
         ax5feJXJYaR+H77KswJPOY968fpseItaPUpxprVDXZxI53cFk1MKaQN1gj0ieEUXLj0L
         r43DmAZwmFHYbrRKwupU9MW/QTNiBa1bg2Oq/2Upu2kMoP9NUI+rjO1I9YslJbwmc9ol
         8LdOU23xX0AABfn4ZhCNoyIo4RaMIhwhyLcKVzENjJJhuy0n5RU5CXTX+vzKinyPPOeI
         hiqOngDdxZZZYa3e4Hlmt55s0iTBGEyDFJPQiMd1lScj329iBZngl9ZLr/pg1RKv6zaZ
         KjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717230723; x=1717835523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3hjzwanBytkl4obEE6D67qP07qRMuRdAI0wYEzYvMc=;
        b=TCp1FmvEhkdFbsWO3zPymi+omlIhblsTbuktTnxH9gSY4DWrMJqgp2T5ncqcJuSid5
         gFIY8ePqTyESntFiBiZDl5guqefF4zLByXXLqObboMCeWtRc9nVyatFf6PzwxyDG78LT
         ySM+w0tvRXJ7eAbN/P4897fcymP6dvB44F8EUu1hjUzB5pz4IuyadhdcjiWtKl45GNPq
         vF7GUGMpm8qRTsxVRkopy50t1cQD8c2OY8o1f4n2Qbb0+ZSfRcFmqEkpTMve2fuAs6s6
         aCGtUqL3lHGyE7iGFmOvfjhWItVIXw4Z+Fz96kkvFLNEHTyJ5qrbThjtBupm7IIg03Zr
         bOTw==
X-Forwarded-Encrypted: i=1; AJvYcCVLDTeObFYAZliZhPmPg57MT7aiSb6ouELmlsFXoAasqcewhDAZ1UNTSmXqsYtO0IT2w0+MaINlCh6dLWIK7XoklhOv7FXVyGAFW3wE
X-Gm-Message-State: AOJu0YxaD/XDfYWkTwy2n3/OxZk40DvIJEsx8UE8LoDc6xjCd4EIyhVz
	Y/ae7ybhr0PNCiCks7RqAJpYe6UBXKcygKOk8BMX7F/1qrGwjuhJjhP9jFZq
X-Google-Smtp-Source: AGHT+IEn0wjLCo6Y1AE4Mp4UbxabwPlAjXIHUBxQsF3C/qD+vV4XI4Luyq32+AdsW0zeHI1BnStLHg==
X-Received: by 2002:a17:90b:2282:b0:2bd:fa57:b361 with SMTP id 98e67ed59e1d1-2c1dc56fce1mr3603808a91.11.1717230722679;
        Sat, 01 Jun 2024 01:32:02 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bb65bsm4384000a91.56.2024.06.01.01.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:32:02 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	ruanjinjie@huawei.com,
	bragathemanick0908@gmail.com,
	colin.i.king@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in odm.h
Date: Sat,  1 Jun 2024 14:16:53 +0545
Message-Id: <20240601083153.96242-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes misspelled words to increase code readability and
searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index f5c804a1b9d5..010274ba8079 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -76,7 +76,7 @@
 
 /* Remove DIG by Yuchen */
 
-/* Remoce BB power saving by Yuchn */
+/* Remove BB power saving by Yuchn */
 
 /* Remove DIG by yuchen */
 
@@ -878,7 +878,7 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	struct odm_mac_status_info *pMacInfo;
 	/* MAC_INFO_88E		MacInfo; */
 
-	/*  Different Team independt structure?? */
+	/*  Different Team independent structure?? */
 
 	/*  */
 	/* TX_RTP_CMN		TX_retrpo; */
-- 
2.34.1


