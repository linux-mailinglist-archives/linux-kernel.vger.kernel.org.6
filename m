Return-Path: <linux-kernel+bounces-307928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC4965511
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CD1C22C19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628D149C42;
	Fri, 30 Aug 2024 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="aO0L920z"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982891D131D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983514; cv=none; b=dhyaJ0qDHgXWW8R4T9bCqHrCwwDk4CRaeEb4P92PqmylUR8OcpBesj1c0z0gQmmkoMX68TGFzlIkeEac9Xt0Mwcsd1jdEyBbXB7OIM1zJwUtjcT5i1EKhAH+k596kwepPTNfiAZwpxuICCdfe+zFiLawfV3WTXRZTYfJ/fFrMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983514; c=relaxed/simple;
	bh=ZUXGDOlBivq3kr6fSii92TWirdbh/R4VvVK3g47pxoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szv6A34t+LzK2hQH/PODDHL8zUVkL704L3noh3pK73m1Q1fWdq+hBPcGuqiNoR748e+uzjouI32n9YPedC+pxNcXBKfM2iQs9YVFZEKN9SG7Xci7Br6jx7sRzxsIJ3r46wXBfdidlwvoO9vI/8VfFN0uIg9GV4t3BWmEd1V+qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=aO0L920z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201fbd0d7c2so12420025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724983512; x=1725588312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2lpwl3ZNj47V0UXpn+t6V2z5Nus9ARRgUC1djMYwNo=;
        b=aO0L920zKUjkiaQWHf3L9QfS5IG2jfkl5ZqPtEbgpRT1nVFxuoEjp45NTNSF39SixP
         iVGpxICMLG+eZyQP54f7wmziGGDmvo4ZLaY/ceJFJ6BoFX+UBOoCKPw9Wi6o0NcPpuIK
         oS9Qq0klKedrcm7+9txeJP2jZE4f4AVng4NsMRGzmAFZI9vE1yqIwRohZGjK91FMPZ1Z
         5i4tiOW8OuTcQ/kHUmCQ1CrrSBQLcYvDLDXMCxTdIF4vR5QbiAhV+gdNRL551jMMkxoh
         +/mXthN8jQlAAFED8VfuXGG6yRHyEYvpanI6mx8GoQ+9BTBlqfoWSSKjZKSM4UzzJNsT
         rewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983512; x=1725588312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2lpwl3ZNj47V0UXpn+t6V2z5Nus9ARRgUC1djMYwNo=;
        b=pBMxp8nU8GXLXiitODMGxgo6JrdaJvgzRHSdeamtW3C6eHnQsWQ/7hzJuw1m/OurOC
         04M0XZWJkJWFLpM7e8XDDVoD1Uv4G1jC2fD4hnXeXXRFK3eFd1bwaqst37mKLom0JCf6
         9TpAsglm1SaDW0pLUBEE5Z1hWRevovd8ey9LlrNzN4urI6pKAJCZAdnbs7kdGuPU4Nrt
         F++jWmhly0R6Co4WNaereho4fim9OOvXKLpaZcIsAYIAjyKXXwI6sMVMXW/UDPMo6Mkq
         RMS1JkCRl8j66vGSJ5NjcHK38W341CG4wHI3BixGHj6tSg4/khHK91YzC9oX5R5Ru7pB
         Fx2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+jRIfTxIpOa8mP04C3TZ/TTW6RT7Z9BGkgZlMaXoKM6SLIKX8Y53ivRbYcYc1roG/6022wHrso1z81W0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27QbGS0WiDrWmbytu5g50S3n40JZtlxHFA0p4f65nkS1Rua0S
	mA9/QO+bvKseP+K/DMUbxrWch/obxlYl/3YQWGOPHWNbRsloUEgUo3epcg7EdHA=
X-Google-Smtp-Source: AGHT+IFp1Vi6Uq9t/fcNbmQr9FbIidmfkI5sBkeZbt6Zmh6j1BZi1m9p88eY0YGFcWu47gbLCpjJEw==
X-Received: by 2002:a17:902:7612:b0:202:51ca:9831 with SMTP id d9443c01a7336-2050c42efecmr44551025ad.49.1724983511776;
        Thu, 29 Aug 2024 19:05:11 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534444sm17643255ad.147.2024.08.29.19.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:05:11 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/3] Staging: rtl8192e: Rename variable pNetwork
Date: Thu, 29 Aug 2024 19:05:06 -0700
Message-Id: <20240830020508.532945-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240830020508.532945-1-tdavies@darkphysics.net>
References: <20240830020508.532945-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable pNetwork to network
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 34 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  4 +--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index dfdb7a7dc14f..188e1fd9554d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -559,7 +559,7 @@ void ht_initialize_bss_desc(struct bss_ht *bss_ht)
 }
 
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
-				   struct rtllib_network *pNetwork)
+				   struct rtllib_network *network)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8	bIOTAction = 0;
@@ -567,32 +567,32 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 	/* unmark enable_ht flag here is the same reason why unmarked in
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
-	if (pNetwork->bssht.bd_support_ht) {
+	if (network->bssht.bd_support_ht) {
 		ht_info->current_ht_support = true;
-		ht_info->peer_ht_spec_ver = pNetwork->bssht.bd_ht_spec_ver;
+		ht_info->peer_ht_spec_ver = network->bssht.bd_ht_spec_ver;
 
-		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
-		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->peer_ht_cap_buf))
+		if (network->bssht.bd_ht_cap_len > 0 &&
+		    network->bssht.bd_ht_cap_len <= sizeof(ht_info->peer_ht_cap_buf))
 			memcpy(ht_info->peer_ht_cap_buf,
-			       pNetwork->bssht.bd_ht_cap_buf,
-			       pNetwork->bssht.bd_ht_cap_len);
+			       network->bssht.bd_ht_cap_buf,
+			       network->bssht.bd_ht_cap_len);
 
-		if (pNetwork->bssht.bd_ht_info_len > 0 &&
-		    pNetwork->bssht.bd_ht_info_len <=
+		if (network->bssht.bd_ht_info_len > 0 &&
+		    network->bssht.bd_ht_info_len <=
 		    sizeof(ht_info->peer_ht_info_buf))
 			memcpy(ht_info->peer_ht_info_buf,
-			       pNetwork->bssht.bd_ht_info_buf,
-			       pNetwork->bssht.bd_ht_info_len);
+			       network->bssht.bd_ht_info_buf,
+			       network->bssht.bd_ht_info_len);
 
 		ht_info->current_rt2rt_aggregation =
-			 pNetwork->bssht.bd_rt2rt_aggregation;
+			 network->bssht.bd_rt2rt_aggregation;
 		ht_info->current_rt2rt_long_slot_time =
-			 pNetwork->bssht.bd_rt2rt_long_slot_time;
+			 network->bssht.bd_rt2rt_long_slot_time;
 
 		ht_iot_peer_determine(ieee);
 
 		ht_info->iot_action = 0;
-		bIOTAction = ht_iot_act_is_mgnt_use_cck_6m(ieee, pNetwork);
+		bIOTAction = ht_iot_act_is_mgnt_use_cck_6m(ieee, network);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
 		bIOTAction = ht_iot_act_is_ccd_fsync(ieee);
@@ -609,14 +609,14 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 }
 
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
-				     struct rtllib_network *pNetwork)
+				     struct rtllib_network *network)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct ht_info_ele *pPeerHTInfo =
-		 (struct ht_info_ele *)pNetwork->bssht.bd_ht_info_buf;
+		 (struct ht_info_ele *)network->bssht.bd_ht_info_buf;
 
 	if (ht_info->current_ht_support) {
-		if (pNetwork->bssht.bd_ht_info_len != 0)
+		if (network->bssht.bd_ht_info_len != 0)
 			ht_info->current_op_mode = pPeerHTInfo->opt_mode;
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7a1a68317a49..82fef04e5784 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1733,9 +1733,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
 void ht_initialize_bss_desc(struct bss_ht *bss_ht);
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
-				   struct rtllib_network *pNetwork);
+				   struct rtllib_network *network);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
-				     struct rtllib_network *pNetwork);
+				     struct rtllib_network *network);
 u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
-- 
2.30.2


