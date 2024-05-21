Return-Path: <linux-kernel+bounces-184427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAA8CA6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB071F2114B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C54AEF0;
	Tue, 21 May 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Ff31qTpG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B542056
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261447; cv=none; b=MTdCUZYwmTuqveLdHIjJO8qwzmSN/FOa6QJ2WhnMajTEvdpaNV3wXsO9G86YrsV8XXB3SjrYnHJpSPX/DVs15R8M5YsnK71RK2+f8zdE7y3IxQlTZRg3BKVdUDgRA+yLjzE4qMiwFuXzCjxiQ2MdHTiBRYU2dQU8q0AAUP8M4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261447; c=relaxed/simple;
	bh=bI19xLqdq+sgsz+YkllY+DoyTJRW1HQq4KyU3VNBrWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYBZK7/xK4YxJRnXbjGrb1cAzmg7oFMOi5t5qTqa9MFAu2kYiIm5Cgyq0PXf9+SlbYr800wl0/3CbD3KzCc8kCGTkzqv17g/gI44Of2SmuQ11S9jSYFZpIAVEPSZpgsMg0NOwU3+smH18Ej3yYN2IBoaFYWQcFW0q27PlnZeCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Ff31qTpG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f2f566a7c7so64562805ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261445; x=1716866245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmiNsN9OzMbofrVzRzK+lEWu2/pKW/vMoZ6Rvo+XamI=;
        b=Ff31qTpGFM3Hl+SuOI4ZX7wmeV0p1kc7ycsAYrthTJCQ8pQgLGTctGZTRk8TvCqmKe
         yPtdWZormQZ4iEPYaURWZCJAm6BRRWNZFc//K3Rk5ZFUfA+lvx/kX+UP4/DEiE5LkFyU
         urDVfCbstF/T2PxmZ/0frH4sMysRvjah/bOVtbatu6VelpsIKq2Jge6JBLGhNMbjf0wZ
         KQtgV8C6aWxD0h180nGrliSbl43K8/eAaO8smO8H7j55oaW5TsWjFBmMZY20uRBxJBEL
         E5tLiAJ0w41oR3HqoitjjHosBYzM/mri3v7T7w/W1wuOG0PT++2Hp/hhVXAUevolKm+I
         SPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261445; x=1716866245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmiNsN9OzMbofrVzRzK+lEWu2/pKW/vMoZ6Rvo+XamI=;
        b=dCW4F+A7MAOMvKrgTFmbqF5DItfgWJrJKanuDTqtjh0vWMeTe6k0c/Yb0dgOiC7vZI
         C9zwfXIdZyXGL5SS6O1NLeWpM3mmAbNZjohCO/zZuKrOLzQd2xuFxC6L3x6G13XnQ9H3
         usHvMkukZDGmVs6DdBjK9iroDy0s4p/jTxDgbNYzj3fq0vVNklxP4EygOE8ujCq9YNhj
         oYoo5GUUoeQYVXTAA1ObNCo6t9Ryj/QmP6/fFG8yH+Br2Aq4L4BjdU43pzRsOkRszE5J
         Cy4mrttSnSKMZm/ijCjVPoaLlC/kxoV4QKYiRxBwAAj4Kn63Rc4vEUvOGKJMQzWfLxdH
         FJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGNIAr/NcBSc1sg59/M2rzHIBhT+WjIOEr7sIcTRJwLPuY0my1RZk86oxjSWm6saz3Sq4Ko+zfhWTeiUMKejS3gIwmEP1aeLU0Vi4t
X-Gm-Message-State: AOJu0YwG9B5FckhqL2EJE0gztbFpdWfYGLK4xYY7rJAN/jtNDiSL97n9
	SLOsm6jp5HTkSugj4JYhqyAbiTOxBJrCBjhquRgK4gyrZ5s3ntZ7HKCMIXakmD0=
X-Google-Smtp-Source: AGHT+IE3jqKrq16VRelIbjkUBnYCDLJ7AALRudo5VhnkqCTTy7hEHxidb8UlPEdHQE1Ym5H06F/23Q==
X-Received: by 2002:a17:903:2986:b0:1f2:f090:b2c1 with SMTP id d9443c01a7336-1f2f090bb1bmr77662935ad.14.1716261444846;
        Mon, 20 May 2024 20:17:24 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:24 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 04/31] Staging: rtl8192e: Rename variable bWithAironetIE
Date: Mon, 20 May 2024 20:16:51 -0700
Message-Id: <20240521031718.17852-5-tdavies@darkphysics.net>
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

Rename variable bWithAironetIE to with_aironet_ie
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cae4df481397..40ec29434d68 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -910,7 +910,7 @@ struct rtllib_network {
 	u8 hidden_ssid_len;
 	struct rtllib_qos_data qos_data;
 
-	bool	bWithAironetIE;
+	bool	with_aironet_ie;
 	bool	ckip_supported;
 	bool	ccx_rm_enable;
 	u8	CcxRmState[2];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 1cae6d6efb96..d4dbf8052c30 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2090,7 +2090,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			netdev_dbg(ieee->dev, "MFIE_TYPE_AIRONET: %d bytes\n",
 				   info_element->len);
 			if (info_element->len > IE_CISCO_FLAG_POSITION) {
-				network->bWithAironetIE = true;
+				network->with_aironet_ie = true;
 
 				if ((info_element->data[IE_CISCO_FLAG_POSITION]
 				     & SUPPORT_CKIP_MIC) ||
@@ -2100,7 +2100,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 				else
 					network->ckip_supported = false;
 			} else {
-				network->bWithAironetIE = false;
+				network->with_aironet_ie = false;
 				network->ckip_supported = false;
 			}
 			break;
@@ -2345,7 +2345,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->country_ie_len = src->country_ie_len;
 	memcpy(dst->country_ie_buf, src->country_ie_buf, src->country_ie_len);
 
-	dst->bWithAironetIE = src->bWithAironetIE;
+	dst->with_aironet_ie = src->with_aironet_ie;
 	dst->ckip_supported = src->ckip_supported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
 	dst->ccx_rm_enable = src->ccx_rm_enable;
-- 
2.30.2


