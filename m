Return-Path: <linux-kernel+bounces-267045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08CF940BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6D1F21785
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F22194AF3;
	Tue, 30 Jul 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqLEQJcf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A41922F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328198; cv=none; b=IVJQZZnDcfB2ZasnmamzlDjtLpSXAW52/XoLE8DBovXnAjn769EbfTZmachG7KDjqHgDAaHXi8dCD9PX6gT/Uljky4nTy7Unj1iHg0yOa1Amch0E0PtmjgaIpxmZsWHmL5DsGxuFpwg8+Pdr4AWy1YQg+BMHidqZmw9neq1/HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328198; c=relaxed/simple;
	bh=Al7tsybQ8Ctv+Z5ysbndis3b5/TMJcWb/PrQJk3aAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOMjXRt51886EsNTamTVJ2ECbPrj9T0KMo19piNB9Oe9+yXwJi1E9Zv2CL77d5RKkM06Xtbdr8x4UDKLN0fbKGunpFVNtbYPsq4QQ5W3qk6ndnve7rPVoarZVdV3nf9sZ973Za9Ji+nEfMfCz9iUlmJ9dMMzB/g+gu2r6qNP4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqLEQJcf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so847284766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722328195; x=1722932995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSLp9jYDDTtURILO5YsFnWIzYyPB4gqC+JAko4lkDHw=;
        b=DqLEQJcfR4NBGeZEmMlcmQmkrm5NAJTOecZIlWtUDuTxHLN22iARtu/LqXiSptS3gA
         Dh+uyzNDEvz+OhSkZ9WHtflnAI5fc6tHYbCk5ZivAApmdeMyCzzLau9vmViBkroFSUmX
         eLYclOTrI16GGgM80zu/HUFia3BhvenTNAuqhn7pkm5cR0a+2GttoOvjoNOLb04hWFjt
         olfSDikYbw6K3kFYU1ZEyXzACj7VB3pDNN3a0Gx3QZysu4U9jPe+yVLfx2fQ/iEaZuvO
         WcFXd0vGajp5H8x6iiYkeWp7xtz3su+eCIHqt0De3dr7UyCx1d/q7qyQy6JzOOMXKEAf
         uv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328195; x=1722932995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSLp9jYDDTtURILO5YsFnWIzYyPB4gqC+JAko4lkDHw=;
        b=X120ssVTKNHhwPGE/EY8oPn9xpqZLffYALPtOK8y3CGcCV2/mWZr3KwCgunaojPAcX
         rdq9GBvkZoMWbAqItjCzRibVhm38OxbfJo37teevzuA+yDo2sPlulxWVbnPjTLyw9U9c
         790HGBbIC/NqdgnAJuyaniLpmxJWyOUpnL2NavDdso+ldhFGubN/tWTdGkPEK9YMu3jM
         GtoeUvufevYC9nSiTFksgpMPNnaWjfRB58DHH91n3kdSJ6JGSIDHHBgbkl2Jb/ztKizi
         cWOxBQxsFthF7bYomICGGfxuMIaiPfoJr1Q9veKavAg+6nYsEY1b7Lk7fHO+5JpFgMtX
         8BAw==
X-Forwarded-Encrypted: i=1; AJvYcCXxOXjAjVK+JK6zfVD8gSb5BwhAx8dBYwXEdSNdgO9/IHOzE5CDQ3lqjoE2aD3ceEg5mrGXwAQcA3IAEqaQTg5e20/W1X55/rqGvCcF
X-Gm-Message-State: AOJu0Yzy3mukTPpECBPhfcV3lP4Z92MHHkgNAefjqdypJ0iwUx84e0H2
	zasLyW/CbD7/17Q4StoVWy3hXxy8U37YyYh/6GfB5AF/jP5srOQH
X-Google-Smtp-Source: AGHT+IFYJFEV69ICKm3oEDcJ7wsBCqMqDn9jck+E/Er1ckAxB+rEFJtnkwVItn5U3MoSYij7MOs6Cg==
X-Received: by 2002:a17:907:a809:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7d859eadecmr116807866b.22.1722328194887;
        Tue, 30 Jul 2024 01:29:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba2e.dynamic.kabel-deutschland.de. [95.90.186.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de06sm611231666b.71.2024.07.30.01.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:29:54 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: remove duplicate macros from rtllib.h
Date: Tue, 30 Jul 2024 10:29:28 +0200
Message-ID: <20240730082928.62284-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros just duplicate macros from include/linux/ieee80211.h.
We can safely remove them from rtllib.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
compile-tested only

 drivers/staging/rtl8192e/rtllib.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 022851b7f1a9..e87313a30741 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -414,17 +414,6 @@ enum _REG_PREAMBLE_MODE {
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
 
-/* Authentication algorithms */
-#define WLAN_AUTH_OPEN 0
-#define WLAN_AUTH_SHARED_KEY 1
-#define WLAN_AUTH_LEAP 128
-
-#define WLAN_CAPABILITY_ESS (1<<0)
-#define WLAN_CAPABILITY_IBSS (1<<1)
-#define WLAN_CAPABILITY_PRIVACY (1<<4)
-#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
-#define WLAN_CAPABILITY_SHORT_SLOT_TIME (1<<10)
-
 #define RTLLIB_STATMASK_SIGNAL (1<<0)
 #define RTLLIB_STATMASK_RSSI (1<<1)
 #define RTLLIB_STATMASK_NOISE (1<<2)
-- 
2.45.2


