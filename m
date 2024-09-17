Return-Path: <linux-kernel+bounces-331291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C772097AB05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717C51F28A59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53196142E77;
	Tue, 17 Sep 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="kdaioYFG"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A4535D8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551120; cv=none; b=eHM8pCRxp/gzmfvp01u6DfqeZlMwQ8OiFXCmUuWTUAmgXmvYFMvY7ir5WUY2QzlJDijT33GOXILxC9/CbJtDkrPlK8EdwyUrhd4RRcH1q9i8TKhlSyWczTB2Q2D91rOb2WPqF7eh2kT+EIOh/TaFGbM4Nii+enc1veyBstNmgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551120; c=relaxed/simple;
	bh=lExOrX63qroyhjaHURfuxChMnHToTXmcCJ+pARDpjqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZ5JmYCQPPzE5swguqskA7h58RWzlCRe69qW6CP4BM/kj0B02ZfxO+fwU3lMKeXmymfkFtKe8XKLdbBwLymL6bwaoqosW0RNfxVnnHSUgjhXsYt4OFxSSJ/yNKvncbtXHVEBu6l2KJ+CIQyyzHafb10WbLqF7xc8b6MeaQ0hWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=kdaioYFG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7178df70f28so3951538b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551118; x=1727155918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BbJQpuuZ7BYT4gs2DMNofQ/MuRf6Eta7FLnNUeSPu8=;
        b=kdaioYFG3Ig9mRFg0jKfqsNXWiayB5YlbODbsPIEuJy1FYdL311kQgSBQpZvLPiUAb
         obRCc4moLJv83PbE7MeIGiVqhAkqTA+OWNXFVQF3UHTiVdBI7A0BKBTZEOw2OFZwaT79
         WmZTyoFbB/w4wSCQp2bb6ahmUaucFPQ8u9X8jR4a93ZhUUjQNhwg9vR5Rjb4nQyFYZkp
         jSxOUbGNZuwUBYA8p2GO7K+7swkfAxJ1KQ+ue/uZ0rJePSybF9AWzxKUudd2TDM7uWnn
         Rz/NoGwGDDxrnhkTSknyuEX3IiG7gc9jhm8pRsx2IeLPn9xK08CO0pnPvK+z8G1OQagQ
         Bnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551118; x=1727155918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BbJQpuuZ7BYT4gs2DMNofQ/MuRf6Eta7FLnNUeSPu8=;
        b=Vuzmn7vaYUr6tFVRvJARpNIX5+sMwSvxbladam/PmSdpyYeCVy6i/6zYSGrEpS3kXD
         p67U5t9yvGT80L8EYMcVtMPrDVLkXb/3rITBtonbLqZ/vByFKUShNL8XbntW9JfPRfnc
         o+mRnq+z5AGrrejfg6BQWctCGJ7nBx4vJ1/8Cm9xEGDXBb+6EvKxzGvtaQQ0j5jYf2Fi
         4SiF2TUdU0oRKYizzwrIMUhUVk4P+IC53RNIXK5hnpxj6Y+nLzB9JVYbRjEt2Z+42fWM
         BlER4ZW3KkxAeRRzsfLh60KfS7bTVM0aar4GmKGsiwunr4XFsynNJkAYmOpfT4uFx9iL
         j6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWSx4iThDGp4kNf7K3cqfNoXnyV49lVbFSMcvludepN4B7G4VdtqwJOOa/whL7mPatARnyxyEqQWpKdSAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtobq3BXyBblZGVwhnVoWx79q/LrPnAG4lApu4z7gSxj1KIWZ
	BfqSNteWFJNHAJNV5D+217qorMUVfpHWbdUihjjHZV1IAGA5Ngc9yeji8PKwXFI=
X-Google-Smtp-Source: AGHT+IG1F1zV+SY7EGa8BLbwQvUbeHXnPVZ/26DGEmwxdgWhBdSAfyeX81JQOkF916zV5fj3rvEpng==
X-Received: by 2002:a05:6a20:ac43:b0:1cf:36f2:21e9 with SMTP id adf61e73a8af0-1cf76358fdfmr24098507637.32.1726551118499;
        Mon, 16 Sep 2024 22:31:58 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:31:58 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 04/18] Staging: rtl8192e: Rename variable pMCSRateSet
Date: Mon, 16 Sep 2024 22:31:38 -0700
Message-Id: <20240917053152.575553-5-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pMCSRateSet to mcs_rate_set
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 9c9c0bc0cfde..2eba916d7f50 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -357,7 +357,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 	return true;
 }
 
-u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *mcs_rate_set,
 		       u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -365,14 +365,14 @@ u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
 
-	if (!pMCSRateSet || !pMCSFilter) {
+	if (!mcs_rate_set || !pMCSFilter) {
 		netdev_warn(ieee->dev,
-			    "%s(): pMCSRateSet and pMCSFilter are null\n",
+			    "%s(): mcs_rate_set and pMCSFilter are null\n",
 			    __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
-		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
+		availableMcsRate[i] = mcs_rate_set[i] & pMCSFilter[i];
 
 	for (i = 0; i < 16; i++) {
 		if (availableMcsRate[i] != 0)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5bb928d9cd12..7c575535d074 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1736,7 +1736,7 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *network);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *network);
-u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *mcs_rate_set,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
-- 
2.30.2


