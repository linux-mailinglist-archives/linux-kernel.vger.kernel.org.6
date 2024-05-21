Return-Path: <linux-kernel+bounces-184448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DCD8CA6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB0E1F2041C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93C77114;
	Tue, 21 May 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jRPp0Ru7"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54076057
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261462; cv=none; b=CeCMOYhnJNgccrZCvBlegragHcdE0P8TxZ7iev0M7j9RNjCdDvTUjfsrkPhjkJ9WQRLGlxYYtX5uNssdq04/7/5OMvBjoTptWKm/RN0+lYrqAMuA6y5J9WAh16jhtsG6xF+nnQi7xYNRqxg7ZpXrgf4RVH2oeZh5CHIWAsaQ8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261462; c=relaxed/simple;
	bh=CuSkbWzRNmgEhaFefmBeplAIbDah/SxhcN3EtVvQ+Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8dfuKpvTYkzUL6m+ceZ5aGrjllrlEtPubCewWdPM2Aco4l//7FC13viAdRZEHTp6oMloRDCXUTZNyt0KtIAVyUzOuCNalQmS7Ex4K/T21mHPC6BK2BFnAyDC5vcn76B9LOdqxz5E6TBPRhtRl3rcGPY2TQ0i09xNBBQwqKFY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jRPp0Ru7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so98963555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261460; x=1716866260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sIarUzF2tCuO5H11FbEf7IvlQmJwJFaix8anRhpZwQ=;
        b=jRPp0Ru7/xGkU5oUwi/UVS3THkqRpkKxVMtQmMDS3D+fgAWr3FZMaUzCOamc65bMLc
         +UH98dyURkPFsh0RvsQKrhV5tNSqN3Rrc+xQNz1mtjFRSajGB2ljcNRpRthuF06PTH5G
         Y08St5Uycg7uPl221yRNtnSogWOOBweQhoAdCAM5DB/HKSHxJxuCP3/AbUIs0NBAdFNR
         GBeuW7LumeplTVVgLfOrEd+fAxDI/gJ3QWGRmdUD1+4GvCXQ8EgDFQjAGHYrKQqWMHcQ
         TuH7p8aJCXjF5/6+g7ZHugEOn8HAoSUW7v2KClbNCPhOs1i0clSZQXoZPK9CMExFUJHc
         y9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261460; x=1716866260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sIarUzF2tCuO5H11FbEf7IvlQmJwJFaix8anRhpZwQ=;
        b=CWaMXnhDdRaYE52jAMSPHAfwgB0Di1NZaxs6UnO2K12somVPb1Lh6awIrXTop5SJYv
         4Yd/uKjJqr394ayuSTpjg2l0s+V4FoNVVeLxasBT74NgGL41iGLkAFemdiLr3CMCH/6/
         sxv+kDzq40Bt1eiNVqbT8mYwUrVliugRu8CDRKdqnnQXUZEB6pE6l5C8pck6lzblTtcO
         6r+ZTtu+KcSwBPpgFFhAOlrHKntHIF5lJiyQQnEI5MTlSyzx8Ts+OB4zmkeunidN9Jmw
         pEeiZmmiNMKg79+mbtdL3uRz0i8UAe8k9HZyHht7yAPzRhn8MuOGNZJpZoicU46ZmVDC
         lH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3jWc60wpX5XJ3eW7BgjvQaiQ9suK/J3ZrNsncJfWoiBhaYsBETV0f2GLTUiqalQgQorxgJhcgUotBoO2MKJthrjy2c8IdBhYd+3G5
X-Gm-Message-State: AOJu0Yw4rKZXMXVoM/ZeS4/PqdnePK4iVH2C5eZYPCdsfmpCBYa6Es9I
	huN9CIW3K7B1vwFJoVH+0kqLd9sWTh3MEwV5tOx1qHRBPRysNi9QZnX4KmzBG4BCEFE53Zg5QTx
	U
X-Google-Smtp-Source: AGHT+IFVS9fZKUBesDxli8IK6MdEI1+1J7dFgtFOdibJVi6iwJ1Q2AG8ffB5ZIrhDQU89OpkPSdFcQ==
X-Received: by 2002:a05:6a21:1518:b0:1b0:9b7:bbe3 with SMTP id adf61e73a8af0-1b009b7c0d3mr22886121637.0.1716261460190;
        Mon, 20 May 2024 20:17:40 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:39 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 24/31] Staging: rtl8192e: Rename variable bMBssidValid
Date: Mon, 20 May 2024 20:17:11 -0700
Message-Id: <20240521031718.17852-25-tdavies@darkphysics.net>
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

Rename variable bMBssidValid to mb_ssid_valid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0914ba37f42f..91164a3b01aa 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -914,7 +914,7 @@ struct rtllib_network {
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
-	bool	bMBssidValid;
+	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 7e41519d997a..480d4bf8df4f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1817,14 +1817,14 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->ccx_rm_enable = false;
 			network->mb_ssid_mask = network->CcxRmState[1] & 0x07;
 			if (network->mb_ssid_mask != 0) {
-				network->bMBssidValid = true;
+				network->mb_ssid_valid = true;
 				network->mb_ssid_mask = 0xff <<
 						      (network->mb_ssid_mask);
 				ether_addr_copy(network->mb_ssid,
 						network->bssid);
 				network->mb_ssid[5] &= network->mb_ssid_mask;
 			} else {
-				network->bMBssidValid = false;
+				network->mb_ssid_valid = false;
 			}
 		} else {
 			network->ccx_rm_enable = false;
@@ -2347,7 +2347,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->mb_ssid_mask = src->mb_ssid_mask;
-	dst->bMBssidValid = src->bMBssidValid;
+	dst->mb_ssid_valid = src->mb_ssid_valid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
-- 
2.30.2


