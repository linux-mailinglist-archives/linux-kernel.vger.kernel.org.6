Return-Path: <linux-kernel+bounces-331305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6D97AB15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9792528C24D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCA16A397;
	Tue, 17 Sep 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="HZXAJBCZ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA615FEED
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551130; cv=none; b=Fh5u6/OaoSCZHqear9XrRYb0bNlB9FghPGcK8xb0VqfMazsj262Xi6eTnPuLT/HL2EsDE8zBjtQ307WfcDNLISaYeAaogCPhCypxsKBeQwnc4TlPULH+UoDTPXtGgPTXZsVYCOYuCB5bHxo0bGruMMN64IdovtgdPRS724KqH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551130; c=relaxed/simple;
	bh=HBBgh4U2TbQiKhQg+3mmt7kSgvNSyjFSCv4hesHPrtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thcx7+4XtRYjnjXJ8sERXiSl/6owXTMlUBVCPnnOZBqsFm7HC+cbc19bXqjETeNA76FVeFA6XMK0snyuWpCtAydmv6dvPCwPrGfO0+v4XpUnlvro3wuppjkVacm+oEmxQYkfPwtQ9Ri7LSX3r1yqZqtIXSnlcWNZcJ1owl1efi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=HZXAJBCZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso54567b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551128; x=1727155928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8Wt1wfr8yB8GpjkRnwYrY5PO/CblyQRQKYIXDYNbio=;
        b=HZXAJBCZ+knaQsb+YcywMTA34sD3ZPcsUkzhhi55RzMzJjD4/lbwKKB03axG2/jcAr
         pgqi+rVDB5zCHqSK4t6SpQEw9kW4rG/mzV+FIJ0+y66Tz4zH1xW0zxs1bCIZLLsYmaWi
         A2859WQ32TAkiXJl9nwm2qpG3A05lMSn1tp7TPhl9R+b4YROcnK8t0xu9yOIPyhWRDqe
         8QRGqxF0EUWvdGt/5ukTvzs1Dq8IhOPhI9ZT+WouR/WFIpQMemAe70Xlr7yo6kKs18MQ
         q2Rvs0w7mkfinVvRd+RNCqAKJCEEtY9oFOCxZaPoSPpNH44dN5X5CcJSUyt0XHQkbO2C
         FV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551128; x=1727155928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8Wt1wfr8yB8GpjkRnwYrY5PO/CblyQRQKYIXDYNbio=;
        b=pcPDL6QhW1PQ36osD5lVkxvKQKxzOumxK4dR1I5sdV3U6QhQ25r6ARaXD0VzkNOUk+
         PCwb4E9h8N/lrrNsrwa5mpMYeuA8XDQQFPGBRhaHg8uQWYfPlIDl48YXwDNSed5zgqN9
         9+1lxK54SkXpaL6E8gsQm2c3/bSKDhPkSoloWJDYPIdYIKFnGBjC16oyeTYmqagLrdQN
         6OiD4bQvumqip9ESu5S2i/FORljGD1CTf7MpgfEUajDjifwNnTam2JcKj3YPKyS0eS+n
         DafwBYg3Yh5/PPrDVngYAGfZ3uutvuGRQx91IJyPNYtJxOBWGk3/1uEfNaIWX1uhUWJ4
         Ar1g==
X-Forwarded-Encrypted: i=1; AJvYcCVAjzvqsf5j+fpu6uA0fyEC/6D/W2HkafDeiposuY8NZ026yTnXj+Amc+XV+18kzDBaBOebc8BmGGUp9IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jCygCHTenJk7qEqKAgFzao9WR+RutOVfpTh5MX8slCLq4kS8
	niCPSTDfwcgHqXMIzHm3m6Kq2gBkngosaadH2PDsc1NuU8g7plU/nn+qlJ8FjJw=
X-Google-Smtp-Source: AGHT+IHrKjf+5zHzcgpeoPHGRycWKpK2MknumxH8Wq7GAa+b9vRHeq3DYP/TCto5oznPhffTAnPGrQ==
X-Received: by 2002:a05:6a00:3e29:b0:719:1df6:c114 with SMTP id d2e1a72fcca58-71926055ce7mr25012931b3a.1.1726551128465;
        Mon, 16 Sep 2024 22:32:08 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:08 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 18/18] Staging: rtl8192e: Rename variable pMCSFilter
Date: Mon, 16 Sep 2024 22:31:52 -0700
Message-Id: <20240917053152.575553-19-tdavies@darkphysics.net>
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

Rename variable pMCSFilter to mcs_filter
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 2eba916d7f50..ee6bc3202727 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -358,21 +358,21 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 }
 
 u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *mcs_rate_set,
-		       u8 *pMCSFilter)
+		       u8 *mcs_filter)
 {
 	u8		i, j;
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
 
-	if (!mcs_rate_set || !pMCSFilter) {
+	if (!mcs_rate_set || !mcs_filter) {
 		netdev_warn(ieee->dev,
-			    "%s(): mcs_rate_set and pMCSFilter are null\n",
+			    "%s(): mcs_rate_set and mcs_filter are null\n",
 			    __func__);
 		return false;
 	}
 	for (i = 0; i < 16; i++)
-		availableMcsRate[i] = mcs_rate_set[i] & pMCSFilter[i];
+		availableMcsRate[i] = mcs_rate_set[i] & mcs_filter[i];
 
 	for (i = 0; i < 16; i++) {
 		if (availableMcsRate[i] != 0)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 074cd837c708..ff616c82b942 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1737,7 +1737,7 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *network);
 u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *mcs_rate_set,
-		       u8 *pMCSFilter);
+		       u8 *mcs_filter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 ht_c_check(struct rtllib_device *ieee, u8 *frame);
-- 
2.30.2


