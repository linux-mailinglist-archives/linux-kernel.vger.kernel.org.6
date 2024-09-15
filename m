Return-Path: <linux-kernel+bounces-329702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00F9794CD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121BB1F22230
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68077135A53;
	Sun, 15 Sep 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah/ZILws"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E14AEC6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382467; cv=none; b=CUS9iE/yNBt2fU9awN29jXRidhdDDB13wWdybDo5uwyNJ5sAyiez7G0vxPk+NCwcFy0FjF1ANB3fjjI5nRTY9YpfcNibkChBKiASpL/N5hAARk4atDbLCd8yrNKvNcT6vt2glyI+XbLGWqSHSKZWvEmeTA+23GBW/E+9/GcJ8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382467; c=relaxed/simple;
	bh=H/5C/7Pq0/4r9GEExQHKfhf+aom5wH/AOubWvKBdP9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T653RHBHZqlTIwM4zPia+jRg0gFAPqTPqKyupFw9iEhwcjIjzQWlEDJ3/SEksRwycpQbmERjIP+yQiOlme4hQElgzDZ9Qz7alGJFi1y13Dor81rMMygStv1bW6nvf+Npc/7VonuLayMRZ2ULmm3llKdBitTGiQ6EIWEex2uwlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah/ZILws; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso464903666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382464; x=1726987264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDNe2JeoZZgOZzlo+ZuSEo9w+uQCIRKUr+z91NOOW5g=;
        b=ah/ZILwsDsXd5B6pdc1iccrwFebjo/U/l1ozMlmz73wrweU6U+vmqQ7+liy7WhcVhl
         TjtEItQmYdsXnwSMiI43rOMVkEhGXoSJ27GxJdvlxBG4iIKE22hRP29akTy+CnxM4D7I
         tnIwCGrLfG4RDtePIA4E2QO7lASS1sYqcIELh8mT35JzBZ801VblkQOKwOmIwlzEWxfu
         3X6vPtE8YXOlRTMVaGQt/aYbkxtsYRIgkpt0GRD7B30hMfdAS3k+yVMxY5+Y8g7YYBsP
         WAi/oerr0yWhmiF3KDElPbAyy7kgoLvnD7l57i3r1ilf4kDMQVCxHpM86jfbxibAGl8r
         QKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382464; x=1726987264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDNe2JeoZZgOZzlo+ZuSEo9w+uQCIRKUr+z91NOOW5g=;
        b=oLRoZgdkJiGsjRk5TwqdFdzuDWGtQD1UzXxuHfiqYqknKdSvZwinpk/+Q6dvL21D+B
         1l3LiaKemdYkAZu0HwRDVDZXC1rVdAoPFlMbOpl/2PG1kHhttqMvl6g46lw6HbADprv9
         uQVjwUUfDBobn3ZSqnukKOHvpqhoZh5z+b9eLcGSOCfQ2t6CbGWpM1YRJc42kVQkgNND
         qJ+tCy70riT/z4oqfpk9CAVVK3IkZzpPTYVdRSXG5jBNGJqohqFhao5imxaUQ6zBQzOL
         IcDZ2USJ3+HFtl+3aNceUe/w0F95Z/wjZz1wGR8zI21PnzrDLqNsSU/h6c6EzIUi9x78
         Wz9A==
X-Forwarded-Encrypted: i=1; AJvYcCWAgPsfTXBRAU1zgIvX9JFVm+Ej7YuTzbie+waxlWeVbMFsUQgABKFR4XblbRY1dzlXdB+PMdrMmDK1UjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOS5iIjqvHpg5SWDHCU+TSIq8trkdBfRxcYH+8i/lAw+MuJS3J
	IJsLVrG9PSBdNBmClYkIQLMS5zKUIvFn3bBc4skE5SF7imRYIDIW
X-Google-Smtp-Source: AGHT+IE9US5RPXllkXRUFCp55JqjWjrH62fOS+qtz8JPFE/cglfP6G+solJ9l7DIQZ2Aum5hIcsKAw==
X-Received: by 2002:a17:907:f1a2:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a90293c543emr983350166b.6.1726382464054;
        Sat, 14 Sep 2024 23:41:04 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:03 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 11/17] staging: rtl8723bs: Remove unused function rtl8723b_GetHalODMVar
Date: Sun, 15 Sep 2024 08:38:25 +0200
Message-ID: <3837617badf7c81b2914074b56c5064276eb1946.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function rtl8723b_GetHalODMVar and belonging unused
function pointer in struct hal_ops GetHalODMVarHandler.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 11 -----------
 drivers/staging/rtl8723bs/include/hal_intf.h      |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 4c6d9f1fa895..33ae1ae51a30 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1769,16 +1769,6 @@ static void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter)
 	rtw_write8(padapter, bcn_ctrl_reg, val8);
 }
 
-static void rtl8723b_GetHalODMVar(
-	struct adapter *Adapter,
-	enum hal_odm_variable eVariable,
-	void *pValue1,
-	void *pValue2
-)
-{
-	GetHalODMVar(Adapter, eVariable, pValue1, pValue2);
-}
-
 static void rtl8723b_SetHalODMVar(
 	struct adapter *Adapter,
 	enum hal_odm_variable eVariable,
@@ -1876,7 +1866,6 @@ void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_WordEnableDataWrite = &Hal_EfuseWordEnableDataWrite;
 	pHalFunc->Efuse_PgPacketWrite_BT = &Hal_EfusePgPacketWrite_BT;
 
-	pHalFunc->GetHalODMVarHandler = &rtl8723b_GetHalODMVar;
 	pHalFunc->SetHalODMVarHandler = &rtl8723b_SetHalODMVar;
 
 	pHalFunc->xmit_thread_handler = &hal_xmit_handler;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index d41f458d117e..73b6c4d199c3 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -206,7 +206,6 @@ struct hal_ops {
 	u8 (*GetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 	u8 (*SetHalDefVarHandler)(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 
-	void (*GetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, void *pValue2);
 	void (*SetHalODMVarHandler)(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
 
 	void (*UpdateRAMaskHandler)(struct adapter *padapter, u32 mac_id, u8 rssi_level);
-- 
2.43.0


