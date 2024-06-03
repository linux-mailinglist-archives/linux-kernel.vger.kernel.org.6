Return-Path: <linux-kernel+bounces-198528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E838D79C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D591F21855
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38F2F3B;
	Mon,  3 Jun 2024 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhTsLqFg"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B91C14
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378227; cv=none; b=sBuMyAwDTQrP2c3gLfCPDoQ8qkPdyLWPkliM9kRIUhM2OS1TgGFGgoHrGCukBQDZqjWb62M54bth/5IpGYdEHVrOxNr5VdTxJb+bAip3tNjzdGl8vWjHJVdGCyE+Dh/jjkZYTRTJIVSi0iozxHfKAVFkhR+RQ9WU7Tih1xip7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378227; c=relaxed/simple;
	bh=hQRSuF4fcKuvZy+7FPG3ztWNu6T8tJFxZYTu///cOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSD5VEuupWIWQZzcNCmkSfAEl65RMlenidE0rsw1BGhGt5y6A1B2H9XNGoB/cDlC4MIHLnYoEcQjCqjKDnbYHNkS/R/N/BcfFXZLPG+/9ys9uUAbjJHPWDRxjT44GrmwHhGnlVf5fkPZgJd7fuetZJYT5J+T1geVjhSyJiMY6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhTsLqFg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7023b6d810bso2621873b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717378226; x=1717983026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS15qjGSe6PTQR2eoAM4lHF1ea4VHbs/P9F17xo4vAA=;
        b=mhTsLqFgJo37dMveSyKP7bmr7pTeNpRmkBrqdSOcYfqcBfJA94XbLiTDFFd1C6dUfE
         FSmr9iyYlbEgk3Y+4Hqbtqn4jz8Q21Z4ALMSQRvjNeBjrBAutY5kP7mW80XSIRQxB/KK
         0EuvHiET+1Dzd4o8NTJjWgTUsDuEjKc/0xfFE2D3klUzioK6PESbMQ7L4qkYQmeQIB/v
         whhx35Qr7kiOfa8EBf7Eu0fmSBe/I1pBRSZRNok7t/vKy7ZAQBlZmOtel/i1riEZNMWo
         FWLGgCgKKrHPNRtvHBLscjTV9VvUxXtSjTCfjQiSSLzWHpReBuSdIDqdqSvPzFi5tnBe
         8uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717378226; x=1717983026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS15qjGSe6PTQR2eoAM4lHF1ea4VHbs/P9F17xo4vAA=;
        b=wIyStGEV4lhk4rEDfTpuboLyd5EH3v2KxpSjB7ODauj3W0JIO92AEkvToCytxgy0aa
         43LaVvYUpMWrdC4aATzzLEHbst/eYDLdX8w0nOItOJ9JXrz+4cx06g8aIAPGv/01EiX8
         AP5GPLZ6VXpx+G+HRwyQQEZ2b18n3zCOFKBXGXmDNjfotciW4QOmAS3IN8jZoB2QXo62
         9rmW4nT6uWJlAUDNh4roLJqROZQMsgPb6pBST8zKurQ/EuDHp19Atb24/3TtuRFO5F5R
         EKa2xR7vf2tB9m7zBsEc2txZdziOFHuHq0PwqW1FqVrxY66K4yMZHWwMwXUCFAEetxK0
         TrBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/h+ztl2/NLtF9IQh03zITI+lYXW3lwOwy3yw4rAcUX3MyF5I4/eZoh+49iV/vRu1D8GmMwuUuoHHndChHyxrzmvG40GSM7QXKRFv7
X-Gm-Message-State: AOJu0YyNj0Db1JCtdmt475juBM3yQIGyGFzpJUlid93Lpy/e9KRq9pWW
	xxngLEKLsL1vOOffroUYcCviD3W6zrvdbRFkKY03FHlcX/fhD9kn7HAHjFXEZXw=
X-Google-Smtp-Source: AGHT+IGs6z5mL3xKxFCycDd8imzkJHgzRpAuMo2Ismpb0CjdgJJhTx/OJJoCTMkj5x+ASeYZaFLesg==
X-Received: by 2002:a05:6a21:788a:b0:1af:d1f3:2cb5 with SMTP id adf61e73a8af0-1b26f0e64a4mr9621243637.8.1717378225636;
        Sun, 02 Jun 2024 18:30:25 -0700 (PDT)
Received: from desky.home.arpa ([2605:59c8:790:a500:5d50:7307:99f3:76c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a77bb855sm6725047a91.52.2024.06.02.18.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 18:30:25 -0700 (PDT)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Benjamin Schneider <ben@bens.haus>
Subject: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Date: Sun,  2 Jun 2024 18:26:38 -0700
Message-ID: <20240603012804.122215-2-ben@bens.haus>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603012804.122215-1-ben@bens.haus>
References: <20240603012804.122215-1-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This frequency was disabled because of unresolved stability problems.
However, based on several months of testing, the source of the
stability problems seems to be the bootloader, not the kernel.
Marvell has recently merged changes to their bootloader source that
addresses the stability issues when frequency scaling is enabled at
all frequencies including 1.2Ghz.

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index bea41ccab..f28a4435f 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
 };
 
 static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
-	/*
-	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
-	 * unstable because we do not know how to configure it properly.
-	 */
-	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
+	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
 	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
 	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
 	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
-- 
2.45.1


