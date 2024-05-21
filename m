Return-Path: <linux-kernel+bounces-184429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41F8CA6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBD3281FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDA50269;
	Tue, 21 May 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="V1j4nVX4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAF45BE4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261448; cv=none; b=CVOSGJPpbEDDAcftOBIJLSid5XULI2Mk/GsuTO5f3SchkNwgswsA/J5bvU7yulyEwpxYI06QHRPUR0DK7QTstBwa0sJKVNebBVvk/LXXqJ2/t8BAv80iU5Bz4GcEUafb43mXZkw3AonP94lVp4bo3xSiKkoumM2uZuuLcV5jLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261448; c=relaxed/simple;
	bh=HAcGEyiHKCIG8JO/8aUs7l9AldiL5WVCu/Fjjtl3Q6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZrL4T4ZqKQBEjKwMlq2ctJtSKeX/B+fhRv5llbRsPNWaYI3cHYQUP/z6VSxelL/B5ggFZO9aNrePS/9yp+ReczpkzaddeBBOqyA96bnRpih9Q2xY3PBZ8ekJrQxGJtootkLMuTsBfe0L70x7ZtX2PI0rxez5IZ40YGKKMnSk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=V1j4nVX4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec92e355bfso107910495ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261446; x=1716866246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd9btt6pVE9LpJ5n8h41Qkxs4h4F6F4P2g3ly8ex9yE=;
        b=V1j4nVX448vZ5vloK1UUIenjuEIZhLQdlvOYmu+Ah5KHe1QVNL5E52kTSteJlM3VEH
         0VOR0/qbkwwG88RpUY2nfcXszr+x1pCohdsKpZFI3YWGjTOcPQ8KCgRPceuCexQgPLQH
         LFXNX67XDT8dsVpYm094eiCMilCBSWwd04NuZf3mwzs7k+5tfiluW8pOqMhukPwR3YJB
         uQmzbDFZ7yflVBN4bIXrSPzcTV89kFFMWILX0gTvmHIn1gYfmEpGO6zFw2TMhCkEWvSd
         0B0lnx6aeXr0kasdDD7ZjZi8gp5Rh999zXFT/GwOR3zELtL29+hl23kEgmARjgfwLh++
         2/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261446; x=1716866246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd9btt6pVE9LpJ5n8h41Qkxs4h4F6F4P2g3ly8ex9yE=;
        b=wViz5CCcko2JGtqYimBeRJi9kB21W68Djl43mF2zPrv3j8fAQ63Dv8NhloyrXtPpr3
         7b5pwt3UoOI8xthQyq4pQqxOZKNFjMOcfhBxXwHAnNedNFPHQENEkRCJyWxn1AA4ZM58
         nWfEq8lRTekuRGVk5fXWbTDCU1lvT5IYUFML/ZdLL5vmIEC3GrKt0PRzEL/yTh4zxElg
         GsxX1bAIPR94K3EahwivTzotFE4GVOYrWdo3AVKk/7w7eYUkeW3hRtjaS0q9CFKrbVhv
         i9NidlptVDaHRwIy3Sr4/s09IPVfOBzTcN4YFuBQ688nSFz51aocCU8aNVN64bGaguGI
         fa1g==
X-Forwarded-Encrypted: i=1; AJvYcCVOSWRJn1Ud7yOm6ktlQOZbkgCAcueUadi6XJp3HukL4/z025+Vs0O1nYb2yj5EHFEzYYMg61nAVvBwQS9Upvi3+YD/4Xuhjoci189T
X-Gm-Message-State: AOJu0YzvJyNC1NCwkgoAtGsANelc+8B9VAJ4fUHJhIO4XWc6sQVShJIY
	IY5YAn+usBnxM21ePM1fGz2DDspMcmwEF97U6MK3lnQFSOE3xHrsqlKq6xNoDZY=
X-Google-Smtp-Source: AGHT+IHeKS24eWCSBCMhzaXtqlNvcFXLY1ze4ihnnHNRG1rQx5z2MKpVvn9kkaMUz9VJXr/TqxzhJw==
X-Received: by 2002:a17:902:e809:b0:1f3:695:eeda with SMTP id d9443c01a7336-1f30695f16bmr35379215ad.61.1716261446316;
        Mon, 20 May 2024 20:17:26 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:25 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 06/31] Staging: rtl8192e: Rename variable MBssid
Date: Mon, 20 May 2024 20:16:53 -0700
Message-Id: <20240521031718.17852-7-tdavies@darkphysics.net>
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

Rename variable MBssid to mb_ssid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ce0cd1f557c3..7f1c2f49227e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -916,7 +916,7 @@ struct rtllib_network {
 	u8	CcxRmState[2];
 	bool	bMBssidValid;
 	u8	MBssidMask;
-	u8	MBssid[ETH_ALEN];
+	u8	mb_ssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
 	u8	bss_ccx_ver_number;
 	/* These are network statistics */
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4e7c491c0aaf..c29efa3eef6f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1823,9 +1823,9 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 				network->bMBssidValid = true;
 				network->MBssidMask = 0xff <<
 						      (network->MBssidMask);
-				ether_addr_copy(network->MBssid,
+				ether_addr_copy(network->mb_ssid,
 						network->bssid);
-				network->MBssid[5] &= network->MBssidMask;
+				network->mb_ssid[5] &= network->MBssidMask;
 			} else {
 				network->bMBssidValid = false;
 			}
@@ -2351,7 +2351,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->ccx_rm_enable = src->ccx_rm_enable;
 	dst->MBssidMask = src->MBssidMask;
 	dst->bMBssidValid = src->bMBssidValid;
-	memcpy(dst->MBssid, src->MBssid, 6);
+	memcpy(dst->mb_ssid, src->mb_ssid, 6);
 	dst->bWithCcxVerNum = src->bWithCcxVerNum;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
-- 
2.30.2


