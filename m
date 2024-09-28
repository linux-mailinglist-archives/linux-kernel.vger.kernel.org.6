Return-Path: <linux-kernel+bounces-342330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D3988DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239AF1C217ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31882199957;
	Sat, 28 Sep 2024 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4ToqtEh"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC61EB25
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727492024; cv=none; b=Itw8PVw/h1m7sKKKaIrZUrdg+DiWup2EN6GQwFUQSMhHcMCzML7zEiUDm13aDMAP9D6hASJpXukhsUWKNwZGBCZVpeen7gu/60PyCkV+v23CGmmSB6upYKKZ4jaicbIKKoj6tqHLy5QzpJA9QzkCuBqNDfQ/BPg9rAf0s7Bsn6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727492024; c=relaxed/simple;
	bh=1P5VSdEr6UYzDIu6A2snwQSfVUvFw0ftgr0LKwbktp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ledil/p8tk0XZBU8zKxmj8sVFfRQ+PYY7rQ6rfqhh4Rc2r0sPwY7oKEDJu1K3i8+h93Zf0yqlhbonID7wOZE0IvECCfRx9ysaNJvVvSvISQehXe3HIbdwZVTPG/gyWjD/AFauJWaN26K8hP7flNAyyayHm7nvTPvCJhgiWjDSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4ToqtEh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d704704aso2331459b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727492022; x=1728096822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqbEnkFqMvfFF/pkDHaeuRRro8Yo1fTtXIG0am66j4A=;
        b=B4ToqtEhAG2PUOpbM8/0X+bjn7Yxx1zsCs7ZQCUirLy/v9Gv25PyAfcX3FtGZEADNw
         SEGO0vEqBI5K/KOMDa65Puy1R9wlBowZCLvXd6JBMVnUvhVpTeIgtf1O+0ZkAVamQCpx
         4iCw/1PJBOE+Q5HbtqDXyeJ4s5hpE5V5QCYvDOBQ6n/C6ZKhemFzcGItSjcDpsWr86Ff
         MlA/tB4R0D2jBZrU/7p91t7okEUhXdr3H0KuWOX3IekVukTcDkiSzY+sYakHQazKwguq
         AC+hmE+hVhMI9uxlApHtzSluBsmD1LC3cM6q6EqYI2dAPTyhs/VyGqCg/SIfqsOtsmTA
         VvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727492022; x=1728096822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqbEnkFqMvfFF/pkDHaeuRRro8Yo1fTtXIG0am66j4A=;
        b=iqjddlAq4wcSL13yZqoHjsOMNCVwEw6EZORkzxI24MbgFJIyfuXBAlwnMGEN0UvyJb
         9b6ATINwzBsUz1mUwhzwzGIsJzbKYnC/3RGeCSMakiW+UDJF6Yvc1HFOyt6kV3/yQ8Le
         qHhxG1vDN0yiW6hCDCvw8S5CWtrVMRHrvepXahmScp+U8AhAxEzM7fEORjEHWXIgBySm
         UzL8/YYaq0mUrE9NeeXsYJjcJzr+ntHDNe61EYd+fCVQaB5ymNQOPepRMTtoe1HmMNLz
         jKtFPjTpkRR8u1XPBdMh0/s9XDiZxY6jeykaOfRDNmLynVvTm23utvK+XexHqK9YyKI9
         VnQA==
X-Forwarded-Encrypted: i=1; AJvYcCURr32RP+kF5xk1f7GChBF5tl8+hXDQMQvXvCkrLcACFOfSYV8FDwdvaEeQJ75bTlWxtT/SK/EOydCsAks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVYhaokXYcSc8FS1xtIaDMMjitwJK3VTD8R1KDrs6mWx4bngU
	DtsgUwSd+6DkXxYPDLka1KOeKvmetIzcYfwFyZZsP/2hNRs5VerrRzlNnA==
X-Google-Smtp-Source: AGHT+IFDeXgCaD43BECwV8fDnjNu8ghhynmrO7e/H7s02hjuOyPlDmejr9Cx/OCKiMqZDsE4ncd/0w==
X-Received: by 2002:a05:6a00:98c:b0:717:9191:8bfb with SMTP id d2e1a72fcca58-71b2604c2abmr7743159b3a.17.1727492021835;
        Fri, 27 Sep 2024 19:53:41 -0700 (PDT)
Received: from gyrocopter.. ([2603:8001:e00:4cd4:9999:1075:5963:7350])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652589dsm2277388b3a.155.2024.09.27.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 19:53:41 -0700 (PDT)
From: Michael Harris <michaelharriscode@gmail.com>
To: gregkh@linuxfoundation.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8723bs: hal: odm: removed unnecessary braces
Date: Fri, 27 Sep 2024 19:53:36 -0700
Message-ID: <20240928025336.55940-1-michaelharriscode@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed unnecessary braces.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index ea3b4cd32360..5b5a2efbe5a3 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -417,13 +417,11 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 	u8 i;
 	struct adapter *padapter =  pDM_Odm->Adapter;
 
-	if (padapter->bDriverStopped) {
+	if (padapter->bDriverStopped)
 		return;
-	}
 
-	if (!pDM_Odm->bUseRAMask) {
+	if (!pDM_Odm->bUseRAMask)
 		return;
-	}
 
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		PSTA_INFO_T pstat = pDM_Odm->pODM_StaInfo[i];
@@ -461,9 +459,9 @@ static void odm_RefreshRateAdaptiveMaskCE(struct dm_odm_t *pDM_Odm)
 static void odm_RefreshRateAdaptiveMask(struct dm_odm_t *pDM_Odm)
 {
 
-	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK)) {
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
 		return;
-	}
+
 	odm_RefreshRateAdaptiveMaskCE(pDM_Odm);
 }
 
-- 
2.46.1


