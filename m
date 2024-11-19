Return-Path: <linux-kernel+bounces-413829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181A9D1F46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1E1F228F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B814C5AA;
	Tue, 19 Nov 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geOTHx5V"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFF14884F;
	Tue, 19 Nov 2024 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990897; cv=none; b=lnBbsvK7ERjzGF/VLJKyEKv9hDEs0bHVfdT3FesEjLttWjpOUEqmhAThxGGqmgWbRoeQBT5imUH308+DbcnToLxNFjQ4KvBfDgfT/1IwwT/cq7V7Jas2yU7WVlBKe4jW1SWBlLRDkqWtdrvCJHhRHlpQllKyDFqEzGUfN4lWJD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990897; c=relaxed/simple;
	bh=Ngp1w3QUlS9RiMRnxtGhRctCKsbIXsFJRrpwsCwhnl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TTnLwaZrOtnOdTEUML1IUV33B2BYGFpbhXIJdbX6zFcnKztfu4zawTLvubtS4j2l4MFWA0HMZe0p/BFsy1EO9AGoiLU0bg0clXAjMmZti8w5TWAmB1eSXk2dCJp1pMjLmn+TEowCy6SaOXtsuAMlSiFGCeovleiIk7J+Scr0ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geOTHx5V; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f8095a200eso3514578a12.1;
        Mon, 18 Nov 2024 20:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990895; x=1732595695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4MibD/tDTTi7VO5iTu8AQmQE3saCCZ8yCpb8Ukl5+Y=;
        b=geOTHx5V4r6LwGSoxs4gl0Xat2+GI/36jY4IBPCt/iXHQWGxwhPizReooCKYYeNorL
         WLIjp/8kh2BOUeR48RCRrQbcvd38ulcAX3vO+iMMCIjACl3XAYdhnpfuYGwVNfJcSpel
         TH0HDtaShyb/0V9hqIeHQVgGO8TNiU8IgUs5lumYhP6XDLBaZh1cuhRS4y4nWiTBSp9r
         PERFJDPY2i1YSXwHmYV+1TPE/xCtXoGEL6exsBjKjz3RnmHHFlmcoWvz1UC00YxmiiEr
         0+9ZpzIjpQGGDCbSaJUcalQMspy3fG1FFRdYs/u2OgpCiO2qwG8bFaICnPiCap+35sN2
         F2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990895; x=1732595695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4MibD/tDTTi7VO5iTu8AQmQE3saCCZ8yCpb8Ukl5+Y=;
        b=ZZFV5vOz5uxhh1NfqOZSsglPWe3lX0ihZzF/61cL9FM33C0trmegaD/stCw5lMBgaJ
         isBxh46afcLsob1nGQ+ItNMunLfzSAo4vGR57hwFLQ4peiN+jdKFp+ashmEtqRPpxgt1
         2bvWBd/OLdz4GN1M8RhPsHdW1AVDx0acj7ZoDIenUZIR08FZ28cbzhxvTysFp4eOfIfl
         S17O7CZbUOaT/SnGRKDx6sN0m+nISowwtKPRWmuSKzUFaoyLW5hYxFNGRlqjhR13xoHm
         RS7hoQxz6Lw7SjiCdT3eLKU1dleWSh3YolZvANOQePcIXPVOOrDSmHXP5UJFbxd3XHEx
         catg==
X-Forwarded-Encrypted: i=1; AJvYcCUwFitOQ9nOK1Dy/mCSLl5C6yOMLQdkMGCFYB/sPCv1+5DArn2lgBpG0YXX/nnGE1U+sM54yu6B5sxtIBxgEYP5/vZydw==@vger.kernel.org, AJvYcCVBdq/t6EIABxO6l/9QFifGW1Z1WdEYHtNGOWDZSwtPOS3pK72t0zYIT/Wp5Vx+/FI53jnwxczDh5IbpNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVZoLOZAMTse7Z5b7zLxKRjm54AWM36q7nGHeu0QhlnJeRLU0
	wpqcXpXEoaNPWIi6H9An99P72evcr4ZHaZMseZktpj3zxj3f7DFr
X-Google-Smtp-Source: AGHT+IFNpX3W4HogRyPAEEW6jj1Tptg9P7kFaZa0f4qV+GG4ilWBEW3Bq2kXG+2RNupfB6wT1T0KTg==
X-Received: by 2002:a17:90b:4c41:b0:2ea:a9ac:eeec with SMTP id 98e67ed59e1d1-2eaaa7cf78emr2676256a91.18.1731990894933;
        Mon, 18 Nov 2024 20:34:54 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47135sm65128405ad.193.2024.11.18.20.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:34:54 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 2/5] alienware-wmi: Remove unnecessary check at module exit
Date: Tue, 19 Nov 2024 01:34:46 -0300
Message-ID: <20241119043446.25572-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Module initialization fails if platform device fails to register so it's
always not NULL at exit.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 742fe79f13dc..289b842c07aa 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1252,13 +1252,11 @@ module_init(alienware_wmi_init);
 
 static void __exit alienware_wmi_exit(void)
 {
-	if (platform_device) {
-		alienware_zone_exit(platform_device);
-		remove_hdmi(platform_device);
-		remove_thermal_profile();
-		platform_device_unregister(platform_device);
-		platform_driver_unregister(&platform_driver);
-	}
+	alienware_zone_exit(platform_device);
+	remove_hdmi(platform_device);
+	remove_thermal_profile();
+	platform_device_unregister(platform_device);
+	platform_driver_unregister(&platform_driver);
 }
 
 module_exit(alienware_wmi_exit);
-- 
2.47.0


