Return-Path: <linux-kernel+bounces-213981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB1907D48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E9EB24B59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17A13A86D;
	Thu, 13 Jun 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcCJ1/TC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37845139584
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309787; cv=none; b=b3pQ7RHnWhOopETQMoePybNpRvQRObGaXWkCdh7GnsaQHSPsh5AH03ejABXESvxnbIVtK53YeH+ascw8Dm3t1By7Pslppo4EmKc4InVWH5TqF+po2RMbKWG7Io0PPpIjLjsFfk8eR2CslJzdfjU1bx2cEPXvfxK4MoQXDDk4rg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309787; c=relaxed/simple;
	bh=gvuzmi1k/XSHJhqfXtsgoGFtVRXKq1oA2+kiC54G6do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAJ5FzTSjnJ9yNyZly+L1OTacnSg5EVIJaLmCyLynKBye6ckYLGRk5trgocH6PJlCSlIvFtcMFoAyb8Ya/wveZ3oGDoAM8XnTmIHqETTZQor/pSPRGry8DM6R0IJiLZf79AfMTELs5TrXzdEF113Kut2Zoo3xwmYa8l0HhqfVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcCJ1/TC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso12494405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309784; x=1718914584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UINjgp/D2gC+Ch7EiW9poorIgokpZPzbo7zad3HlYkA=;
        b=YcCJ1/TC5nlNRXTjr+r9nEdJt8hnXw10+pmdMj5cvnR7RaKhRNjHtgTfy2yFXn2zeT
         K9If8d+Z8+wSwKcP6SCvla+L4WefBMIOfsZc2AtLqyZTnBbY6OGehW4poNW6NT+sbQC8
         VxTmMHwcamyMz5kRfzBC0MYLC8MZxcV8eDvDdCVqEqWEz6jDFyJK/i9oZCzF3b4OXjpx
         5s1m9VJVBcFBn6V3NebBYGRkPs3+5sWh+HziSRXNr+2mXta5bPMxe9rXlFXKUVKFibgy
         gQtTatZ5kGGGhuEsp/UaSMjdxGRiJVwQX8QG3bqB5IS9xSSnFX+UaNf8U4rVuFsuMiKw
         HHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309784; x=1718914584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UINjgp/D2gC+Ch7EiW9poorIgokpZPzbo7zad3HlYkA=;
        b=JR2SRdFKwlPgt2yfnR+sLvfdc3W+LPNAMGshzEacrGj1JKQxIzc8wPxhutSCyUeNOb
         vXqICicd6XzpAuKOA84gp3BVteV1lkiQBZsvGR4VdFnRCxlKgxSLNP17tQMK3sYgY+5V
         lq2SecFRBiJZ6TmGyBolaor7CEVdcv8q9MHJvCX9jgfNQyizBXAgHjExKaLuMGfoU7Bz
         9URfnt6t/RLPrgfhKHFOoGmnADBOuHe5l1/PTCJfkli2oWxZdx/PxEQ8WIL3/MeK5w5b
         eSPC9BXhR59EMKKtdG+gjf5nExGL/ZFiFpnXYG/axLqbzcK6vPetNYTUuLteq64GNxG2
         V78w==
X-Forwarded-Encrypted: i=1; AJvYcCUBcYdWzOWA66rBwJp2njfffn6OpWINjlFoYbhEtiSoqmjWoCivFVOx3sKJN4XlmzpBgcbvrtclV8v1nykbDwrfKkR9T3X8iVPVhb+k
X-Gm-Message-State: AOJu0YwF8/qHprydiynEn7MemT85B5Ys4pKhXQhl792fJWZOj8nxFe+0
	mmamIHjGBhyuDFSzkisCbLH6dKfmfLnQdFb/rlGYskz7f3NL4VTH4RIyi3UIvGA=
X-Google-Smtp-Source: AGHT+IHtqZdNg7gArhrDE/I0mRMBS89kqy0mJs/WggrkUzfiolcB0zaG/GcvLiy3wAJTKMbZFow4dw==
X-Received: by 2002:a05:600c:1d29:b0:421:79dc:56e4 with SMTP id 5b1f17b1804b1-42304862690mr6394605e9.41.1718309784509;
        Thu, 13 Jun 2024 13:16:24 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de618sm73817195e9.37.2024.06.13.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:16:23 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v2 1/5] staging: rtl8192e: Remove unused constants
Date: Thu, 13 Jun 2024 21:15:07 +0100
Message-Id: <0ff436b8aa199829728ee11d0ed302e3fa6fd2ac.1718309120.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718309120.git.engel.teddy@gmail.com>
References: <cover.1718309120.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused constants: IC_VersionCut_C, IC_VersionCut_E, WA_IOT_TH_VAL

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>

---
v2: Combine unused constants patches
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 8c85f1c866d3..486397d7db84 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -88,9 +88,7 @@ enum version_8190_loopback {
 	VERSION_8190_BE
 };
 
-#define IC_VersionCut_C	0x2
 #define IC_VersionCut_D	0x3
-#define IC_VersionCut_E	0x4
 
 enum rf_optype {
 	RF_OP_By_SW_3wire = 0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 84e673452be4..863af8ef9f94 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -33,8 +33,6 @@
 #define		RATE_ADAPTIVE_TH_LOW_40M		10
 #define		VERY_LOW_RSSI				15
 
-#define		WA_IOT_TH_VAL				25
-
 #define		E_FOR_TX_POWER_TRACK	       300
 #define		TX_POWER_NEAR_FIELD_THRESH_HIGH		68
 #define		TX_POWER_NEAR_FIELD_THRESH_LOW		62
-- 
2.39.2


