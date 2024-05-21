Return-Path: <linux-kernel+bounces-184451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAC8CA6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5771F21941
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A479945;
	Tue, 21 May 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="DY8pY/zv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F077110
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261464; cv=none; b=n94mhe5mSH6izmim7b/eZrwfXN29lP47o+QeaSc6T1aU61rE6om5DLyBKr0zt/z4CRC0Cz3JSQ4IdDMIjyjOmzdfIarvk3f26vCHwS1PSC3VnQ3T3iwW7wnhexZQkglUYTXfFLMbr6dQyCvV8XQnLufdrgu0c0AaQ0lLDc1IMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261464; c=relaxed/simple;
	bh=sskCsC9Vm7UrLbQDRtkQoQ+iOreZFfaBms8WkVFgyLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OG9IXmoO+hoxQ5F10wCuit/nRFrOoi2IGnFA5ZdGZn8YOnb4uohy33E4CerM/SyCQetYvrqdTKaoP/8LUuvnjOC2zrZRlvatzqIenA6Mk1BBDtPu6YWhz/Mhvec9Es3fhaAj3XCSm7cnofgyqR+1j/kV9/KzhNVKuCWms1BRMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=DY8pY/zv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f3105f3597so1967555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261462; x=1716866262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEDkjeMT5xd5TiSydSW03WzTRxILrRiRjBw53kiJS/I=;
        b=DY8pY/zvGjKhc7Yb6kr3AgER/9UjtWO5QsTzUei4jGiwhRdb1aSLMf1lhQWlsat0f/
         ygsDm6Gb9HHZafzz2CSTpA/ii1Sc5+0dlmP2XkgBFgbkBQReugnunxlVtcV0zaI6CoF2
         6nUpudjYEAt7FPrNycji96ST8r4fKEqAMn4ZVvC9+jblJA9HNyyYyUXSmrqkqTpsHjIL
         gx9fKTh2c05rPdkC4xbeRi6zAe2gyBSQqS+6Xh0b5smyJqquPdQj7QIt5zp3wFQ47XaX
         4UQWO6rXQh09E3AcHd2zxqjYL97dfmX7GSVEygHYCFPtOxraLLA9yIgnRyDAKEFYbgWd
         TmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261462; x=1716866262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEDkjeMT5xd5TiSydSW03WzTRxILrRiRjBw53kiJS/I=;
        b=sP+vDkSMAIj3dGO5My4JOyCu3IvmLinEBIrjTO4m4gsm5BbW5ZYQ8t1eZDhYei8Wqs
         FSnKOnvn32+Gw6NZ0alwCPDhIkMPGKznTQHyYYxxcegq3W8Cp66dcLslDziSjcKcpiEA
         n4OdR05H0522eLRzI+J8tHnL7jKLLf/Oz+W/XV4DU+zZ4SdrHlMalS30g2+H2UL+DCB1
         gGMfwwSdwbM87bNkV6DgQFzNdIU35kiymBbD93L1O+SHHj0Cz8pCg18zKxzHMm0PL+vx
         /BB8rE/NEYhIPCStvUwOVHgPkSI/9H790ReInKzJ2EOkZQjKGzr7y0rLiU7lSq8yGCIy
         xliw==
X-Forwarded-Encrypted: i=1; AJvYcCXNkRieuyi5vXM2ixKykUPtt5opQjoi+JH1lxowvy3/UWilkVzOjVDLn/uB9LukMDPC29eetG33aqv6CXyjnqpWyBIDFWInL29tr45Z
X-Gm-Message-State: AOJu0YxGf5pvnF4N66MxI+wzGXa9uYLu5rVC3JdtHi4iPWh0EeJl6r91
	OC+cjsbqA+1ddtmt6rBYROhoJhPVJ+MOxq+KK6x6p06MNcFQNIIYngv37O28BJ9Q2qONxcQ5ETr
	V
X-Google-Smtp-Source: AGHT+IG79QyCRtGTpo6DaeE6OC79fud+iH4BsmkxBCnehK+xNrUjxZW1M3SLBKnYMz10OsNWBQUJ+w==
X-Received: by 2002:a17:902:6ac5:b0:1e8:2c8d:b749 with SMTP id d9443c01a7336-1ef43e25e67mr297822655ad.30.1716261462384;
        Mon, 20 May 2024 20:17:42 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:41 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 27/31] Staging: rtl8192e: Rename variable CcxRmState
Date: Mon, 20 May 2024 20:17:14 -0700
Message-Id: <20240521031718.17852-28-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxRmState to ccx_rm_state
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b88c7cd399fb..ca69bb0965ba 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -913,7 +913,7 @@ struct rtllib_network {
 	bool	with_aironet_ie;
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
-	u8	CcxRmState[2];
+	u8	ccx_rm_state[2];
 	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 22c04f37bb40..3e8ee1335c24 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1810,12 +1810,12 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96 &&
 	    info_element->data[3] == 0x01) {
 		if (info_element->len == 6) {
-			memcpy(network->CcxRmState, &info_element->data[4], 2);
-			if (network->CcxRmState[0] != 0)
+			memcpy(network->ccx_rm_state, &info_element->data[4], 2);
+			if (network->ccx_rm_state[0] != 0)
 				network->ccx_rm_enable = true;
 			else
 				network->ccx_rm_enable = false;
-			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
+			network->mb_ssid_mask = network->ccx_rm_state[1] & 0x07;
 			if (network->mb_ssid_mask != 0) {
 				network->mb_ssid_valid = true;
 				network->mb_ssid_mask = 0xff <<
@@ -2344,7 +2344,7 @@ static inline void update_network(struct rtllib_device *ieee,
 
 	dst->with_aironet_ie = src->with_aironet_ie;
 	dst->ckip_supported = src->ckip_supported;
-	memcpy(dst->CcxRmState, src->CcxRmState, 2);
+	memcpy(dst->ccx_rm_state, src->ccx_rm_state, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->mb_ssid_valid = src->mb_ssid_valid;
-- 
2.30.2


