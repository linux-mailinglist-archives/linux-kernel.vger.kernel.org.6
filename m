Return-Path: <linux-kernel+bounces-331294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929197AB08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6021C27524
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4A1547FD;
	Tue, 17 Sep 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Xe4LBvje"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E01494AD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551123; cv=none; b=V2wGFlIYfHvRvit0cdaEWolIWRf8wc+fmhrzlbFXrUX5MNET7VdolF/fNzoyqIZnV80joWLx2Rxm/WfWYUdEfm+fhaCv2La1BZDWkDMcdBwdIC7NTA7RV945tBfbxeRIJ/3MN7AF7LfhbHXDz+LZ3EEPC21h2tHhIxloAzruFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551123; c=relaxed/simple;
	bh=8zSIpfttX95m36PD/Re1w3MokteJ8O4kuDOGNKsYBfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8MXuJU7Y5t5JCD/eggvXLbLIJf0v/++f6/G/esXr42ML5oen3YmmkHx7crQ7ZmoAfHBwJZ8UjFPAXAInxtYTl5n7Zy3rq2ZajTlX0ITLAt4bVnsC6hVE7snrTCs8PjxnEP76iTiXvdcETEExFHQl1pRyfaozmezfq55r94kFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Xe4LBvje; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e03e9d1f8dso2739879b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551120; x=1727155920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5mbYRsj6Nd3jVYuccTxUGwM6zWHiTfD3OTp16s/FMQ=;
        b=Xe4LBvjeou73XwGRqirHJfatuoqjEPjqQt1xJxGyHNEnW60fzAr9/jvPd83kwCFFtR
         xT0TF6aBaODH2VkrxDNzT5yrA8Jtqbpurl1GlT4CnoDjDs33y0g2InVMOMf9zhq5rSMh
         pbISo6+EFeKHePEaHj3+z29g9WIoltFcArNmMxxFyLIXo+2fxatnyjN0kHOczbXC+2fp
         rjfvGv9K9fniyTPrl4NJskRWN4YR9Il1KHhxrw8dTzr6QasDa4pNImmbr0ej+MREXvuH
         KK/CbbT8lbIhJYgMK/81W6s792Z/ahX3ehXImTBV5iP4WHbzoG9cipPi57wGiJEfKQOj
         +irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551120; x=1727155920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5mbYRsj6Nd3jVYuccTxUGwM6zWHiTfD3OTp16s/FMQ=;
        b=TXStojZnIHEHugfgSHHPM2j9by8l1yzC4r0/TbUenLd239h9HkCbDV4qRKp2Nvm0W8
         OR4OVgq1Y1Dhvb+DNHmWTCQH0Pv8Z6wWWOeSJ5j7le6R1sM1yO89gnrDrMP5bIeDw2Cc
         tT56M10xlQp8ncVf6vorgJUS8zSAcWd7+4nwnkrQcH5mD1pjJEnYsshe7HS9mCVCPtbK
         bBVfTDxxsF/HYzvi+zT3FyLyQMhM8ubP8PyZmmOrCy4fz+IEnZMZjX7J46QKkbp//N5h
         xRFb+zG6+95X0waZBvoyahAcPG3l/VyRNf6PQM8ByDm1nlj5ZJy4imSwSPQK1+ra9XmF
         Eg9A==
X-Forwarded-Encrypted: i=1; AJvYcCVjVapa21coTFGy4R6biZLRkBgO6jG7UKvHv1G1kHBXiV8o3f44z6LOZKajhD+vqXD7Ij20mGblh7qnZ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkH7Y8QgXiMZ4TxMbzaDBJ61WzkzRSk4B3jQArLFe0a60virvN
	yeAguMRgBifLIEj5Q9C1W+iS8jIhLAwyo6/0NqvSy51bcE4p21+CsIkGKDQ0K/E=
X-Google-Smtp-Source: AGHT+IEC7s/Y/5FSwSUzOovr9eWhzwY10d17OVlYZL9RTTdrUwi+pPOqtRNWeCrMtal6UICa6sCjYA==
X-Received: by 2002:a05:6808:138c:b0:3e0:3d83:49c9 with SMTP id 5614622812f47-3e071a85532mr15225206b6e.7.1726551120573;
        Mon, 16 Sep 2024 22:32:00 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:00 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 07/18] Staging: rtl8192e: Rename variable RxDataNum
Date: Mon, 16 Sep 2024 22:31:41 -0700
Message-Id: <20240917053152.575553-8-tdavies@darkphysics.net>
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

Rename variable RxDataNum to rx_data_num
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index dc1301f1a0c1..32dcccd58b9a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -924,11 +924,11 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 			(priv->rtllib->link_detect_info.slot_num);
 	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
 			priv->rtllib->link_detect_info.num_recv_bcn_in_period;
-	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
+	priv->rtllib->link_detect_info.rx_data_num[slot_index] =
 			priv->rtllib->link_detect_info.num_recv_data_in_period;
 	for (i = 0; i < priv->rtllib->link_detect_info.slot_num; i++) {
 		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
-		*TotalRxDataNum += priv->rtllib->link_detect_info.RxDataNum[i];
+		*TotalRxDataNum += priv->rtllib->link_detect_info.rx_data_num[i];
 	}
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 352b79c2df2f..c6a9cc0b2760 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1086,7 +1086,7 @@ struct rt_link_detect {
 	u32				num_recv_data_in_period;
 
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
-	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];
+	u32				rx_data_num[RT_MAX_LD_SLOT_NUM];
 	u16				slot_num;
 	u16				slot_index;
 
-- 
2.30.2


