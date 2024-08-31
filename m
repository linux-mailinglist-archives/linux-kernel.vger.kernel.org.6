Return-Path: <linux-kernel+bounces-309814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB769670AF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DF2283517
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1C17C225;
	Sat, 31 Aug 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRs1pe24"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12016F8E5
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098924; cv=none; b=WFY5BqzOh1f62hBQVQW1gWeWGp1MQNHLr5mk5sIZdMp8iDtAA41Mf/gwGJrYRkqvnq9R6v/5lZA7mv9mFksVPoOgDv1vexYXo6Y2Fil2mOViFyyWJIvtmh32il9L7CK5qraCELpDggF3djthb8KTfJ1WgQNmDWxznEyqmY3FctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098924; c=relaxed/simple;
	bh=Rr1J/pn1Hf8bKQKYa0+8wlzWON+yhy52CoDcyw3J4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIOaEjdGsJ0c3lK13GmIrT8RY9zlQ4NCxADr77hLI6DYAumZYfgR3gq3S7L+dI49x+IGXlz7AeXSU7ChAIkevyW58bnQOOwCAASvmXyOG4YD7eZnrHI+QfqxMRFQ8S7Dm9888tR2mqfd6BacfUWbsoWJOiCMDIS/ohLpmwK928Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRs1pe24; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso31518001fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098921; x=1725703721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faEhqntifmkFgb+Deyix1zyRhrqBZG7g3qlwMKhNF/4=;
        b=hRs1pe24Dn/Q1g/ImragMe5Cfw0KQkd53Qt+f8tXTFaGTnYmy1oG6Mph7cYgWd0F71
         PEZhYjEy+GaJNp62ZFQWDBlNmpGSyRagGwszAiTh/qLGL1+bNg+UEVVSfTaR7q1ZSY3k
         09nREGXp60fV39NQde1tCxCKnL/cxqDGe4LIHzBfLm7VUTwrpUccu1vjmlyArJ+vluqY
         qssU46+Bzga4BGxYB8HwgBdhN5C4gVteih/TvLOhdKYi5I0WSxfbrxa+XO0Zx8vR4uFw
         sDKv34KC7+TjkQ2z+Sa4mhmt6jj3so3bgI83EBiVMCNcaNGrCPsChAxYnYXEoNJSTHL+
         9/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098921; x=1725703721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faEhqntifmkFgb+Deyix1zyRhrqBZG7g3qlwMKhNF/4=;
        b=Rfw+Ca2M5ymQEICDBHZzanCv8eR1/TVLlnfcJ5up5pb8hG+bFr2fpS1UKQ49FoDQys
         ieFdlOTT2M/BiSyJjYoFmAyOPvt7Uhff3Cfhl9/O/0XYJ78E+ZSTSRfeqbpROYwWKnM9
         r2rx0cVyQwjcTsMr3ILKDdv77dC6sBS2rhaG1CVhX+AyP2HIJAQs3MWK6nsNu29JtMoL
         pHCqcFdOeH2UX6pIb4VO6MwepjIeRRDQbvunFKFqrpci/9mOYLsPBrjeMyEEY7v036AI
         TY5/dsffXro4SSN0E5vryfaI0XBZDrmELCTM1dMy88yJ/0ZXN5F7xfzAaoYrIeSmZskj
         cI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVnaJ34gH2sQ5qWSj7k6OPK3X+AEd/uTeX3g71y21ySgjMT9ZgSJsxkDfw9EtU6yEqg9KBvlebe7cVKgXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVNcHKFKKT2k92390dp05hHs5G/HMTSHJGjOOep7pRtPMwjnO
	UWemEQz8Bkog0t0vfBq2rE3sSnYTeKFSSbz/v9LOeOF2sDlcHkbM
X-Google-Smtp-Source: AGHT+IE8e9rNBsAUXRHl6M2ebOrMtLp87eBh45Xf+H+oxYJ9nbGcVyKBCxXSDJ7466hpbgp8LkRuUg==
X-Received: by 2002:a05:651c:551:b0:2f0:27da:6864 with SMTP id 38308e7fff4ca-2f6105d7954mr81215511fa.17.1725098920668;
        Sat, 31 Aug 2024 03:08:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba11.dynamic.kabel-deutschland.de. [95.90.186.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm307444966b.82.2024.08.31.03.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:08:40 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8192e: remove RF90_PATH_{C,D} from enum rf90_radio_path
Date: Sat, 31 Aug 2024 12:08:05 +0200
Message-ID: <20240831100809.29173-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831100809.29173-1-straube.linux@gmail.com>
References: <20240831100809.29173-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RF90_PATH_C and RF90_PATH_D are unused in this driver. Remove them
from enum rf90_radio_path.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index ff4b4004b0d0..c928bc2b218b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -20,8 +20,6 @@ enum hw90_block {
 enum rf90_radio_path {
 	RF90_PATH_A = 0,
 	RF90_PATH_B = 1,
-	RF90_PATH_C = 2,
-	RF90_PATH_D = 3,
 	RF90_PATH_MAX
 };
 
-- 
2.46.0


