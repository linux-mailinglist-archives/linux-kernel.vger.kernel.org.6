Return-Path: <linux-kernel+bounces-184449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76428CA6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323F0B233CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEA78B4E;
	Tue, 21 May 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="HjsGsX6y"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF1768E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261462; cv=none; b=elpfP4DAursmFCQzzY/KIODy8BQWKTh89ykmHtTgYmiLzkgZNZqIzKT9tl/r6Mka6fqKNyWLZpemt/BJ6Wspx1HfmhEGQ6Eae5fg/Yui7EU1M4zVSM47AyBoUWUIQQ5A5pB3soaMESWb4tCPrj2afnf+oLSLGt8mQzWfvg8KZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261462; c=relaxed/simple;
	bh=zCqvorSBaGZIzif+lPh4oaRT8OhvldrR3odkMX5XB38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JawyCDiqosH/2Jp5dUmfhYS2+FON2hRIEwed6u9Hnlu6A3ks6FIrhkB8tPIduyszwoTn9WR9YYloAnVIpEjOIAgtm1WkS8CYlEzO3i0/53QU8QVJGW3K8YlHbUwiWfDhfd94NjAgn0PmRxcirM3iYlAxYO5bfE4f49G65vtNHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=HjsGsX6y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ecddf96313so81732275ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261461; x=1716866261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi0tzsNlePC+MRPb33kI/mSFw1w7V1fTyHb4oJsIRQ4=;
        b=HjsGsX6yi4WBnGkUDph7QHA35WfHK11zuQruBxqRlQnfGquovkWm0/bsiUdH6cKvdN
         P2zmfpdWgXUzlyGaH8xNFzumEtx/gJkP+NWa0SO5K0y3kOqKK0/Ihm+9VmRsUJD8Y+1V
         tBX8NDbZ2zN0yjyQtPxY50+jIhxET7Hmb5kKEplvKISwZGG5HobC9Z6br7wpFrtC4QdJ
         0jp0iYI6qnG/VkOOnPW6FUgafooy9YZFj2k8njt+j7Ir5lnHIUKsTrsKNwiolVyfiFJY
         8BkWnp7vNryktJQsrLveQwf9L4rv9Eh0kDnHkPxp5Z/G7GrjbqItMspfyN0+Aiup18gj
         qQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261461; x=1716866261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi0tzsNlePC+MRPb33kI/mSFw1w7V1fTyHb4oJsIRQ4=;
        b=cTXK/EezFIUVzzOGJO81Fx/rFOmmsk1hTMhkSjCRaTLORslqqGc4NZxwp8aj4qjJhE
         0YXDHSwk0N4oYclwuhjuNyo2BK/uHyvmvKsaQp1YfpE1ROsSrjqxLnbyV4nlPFUI7mOb
         MwKFiafy6WNMIOKsvOTbPoBwacgiCbbE2QTk3Y1lgrZd3QGbrVGdED2BvD4NVa6pF5lp
         i+dvrkdcznPj7XQK9vZpmWDIdy3DaDrbF0Ty1QyzpTdiaN1vJdfETShQiYzmP97NdY8L
         koSE3jRnOM5fatihFCOUSr1bYHL6/hGSixL7SxZAmOl33BIaF22h6WEpMvYyYnWn116t
         088Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBxN+dI3OTsLg/k4jVw0d+grw49MFs81LShcCqHx5fxgMIbcnWjXkjdsoS5RNN4XVNbY12dSA3vQ2iXWnp8812pKNnczL1gu+1cLRb
X-Gm-Message-State: AOJu0Yz43sp1EnC7j3dDJseiY1GZzWpYlQDwFnyvdCfNKwHqdvkvD/7X
	bbtLt2SZpmdeMHh+RkUut/tv0x2TOTwLBSiJ/+EkBq6RJg029SxR2NpKH3IaP5M=
X-Google-Smtp-Source: AGHT+IE1lUAWf9zcNS4+KWUmFaa+Gmi+y1btT54d3CnG4I5elxQClQvx7GoFbtofB9i0QLiAf/kcfQ==
X-Received: by 2002:a17:902:b70a:b0:1e2:8841:8d67 with SMTP id d9443c01a7336-1ef43d2da8cmr343378175ad.32.1716261460995;
        Mon, 20 May 2024 20:17:40 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:40 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 25/31] Staging: rtl8192e: Rename variable bWithCcxVerNum
Date: Mon, 20 May 2024 20:17:12 -0700
Message-Id: <20240521031718.17852-26-tdavies@darkphysics.net>
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

Rename variable bWithCcxVerNum to with_ccx_ver_num
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 91164a3b01aa..4fec36cfa2fc 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -917,7 +917,7 @@ struct rtllib_network {
 	bool	mb_ssid_valid;
 	u8	mb_ssid_mask;
 	u8	mb_ssid[ETH_ALEN];
-	bool	bWithCcxVerNum;
+	bool	with_ccx_ver_num;
 	u8	bss_ccx_ver_number;
 	/* These are network statistics */
 	struct rtllib_rx_stats stats;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 480d4bf8df4f..2d0a0efedc97 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1836,10 +1836,10 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96 &&
 	    info_element->data[3] == 0x03) {
 		if (info_element->len == 5) {
-			network->bWithCcxVerNum = true;
+			network->with_ccx_ver_num = true;
 			network->bss_ccx_ver_number = info_element->data[4];
 		} else {
-			network->bWithCcxVerNum = false;
+			network->with_ccx_ver_num = false;
 			network->bss_ccx_ver_number = 0;
 		}
 	}
@@ -2349,7 +2349,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->mb_ssid_mask = src->mb_ssid_mask;
 	dst->mb_ssid_valid = src->mb_ssid_valid;
 	memcpy(dst->mb_ssid, src->mb_ssid, 6);
-	dst->bWithCcxVerNum = src->bWithCcxVerNum;
+	dst->with_ccx_ver_num = src->with_ccx_ver_num;
 	dst->bss_ccx_ver_number = src->bss_ccx_ver_number;
 }
 
-- 
2.30.2


