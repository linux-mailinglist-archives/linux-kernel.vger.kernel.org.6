Return-Path: <linux-kernel+bounces-179407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B28C5FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0731C2204F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8C3BB50;
	Wed, 15 May 2024 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="T6yZWdnS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545A381D4
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748759; cv=none; b=k4LZoFpk3ML3m2bqeeqremHj/RLdB38xXBsCKezcPMSQuvxfNTEfpEofgvLrL4kRmRJaSrvCik1cjmTy7VU/QzFoO1XCRIqIIdLsmAeeXJ5ouiVQeOM0kDPTedVg5S4dD5bBt0WVrvrgEKdztBEYfQyouSvQk1vH/Cd8ANcFH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748759; c=relaxed/simple;
	bh=MaYgk11V9VdrTP8z2Dr0C6mU8sKFgydduukab/SqPpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5ltkhcdp4hoU6Gfisoo5wes8CzUWG3j74U5kU5bhy3+JfvUzxbimStiyFct26p6XVQGMUXbSRWUfqZ8ndsUTkUMnhLWkE3uEZ0llJ+1doJ5zQC5rMxkC3IgHw4+Fgl3ieaQfT045f5bMyfKqF8ftcSGhreMHg0kDeKRhv2HeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=T6yZWdnS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4603237e0so4475873b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748756; x=1716353556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxfiITVjEz5smO5GO/pbEdvc3HEsMTAy+JAImqMp9NE=;
        b=T6yZWdnSehN1aH0EARztxF1iWWfWTlL2Z279Yl7s9l9xRHihLrni3IBbsZXke8RmSz
         grQC5s716pQp4+KuXnsbSNq8Z+sflcPEJt6vc0bwxo2nPTKQOATHu6KBs5QYSZnBuhB8
         t7TRioZEZ68qjG3fN+i7AM8ITDnZhVLNIMFwBwxoYMH3fm836xjHUI1JyE0nEC9attsg
         eicH1tucxOmqQSyhsr8CzkSx8zkBiTQzmHJ9k/w19/M6QX5jHhaLkjn1ZJ16rUuAnUQV
         hTBzTFUG9xfaH5V6G0N9+zPj9TTjd2XOuDcXT7XaYkFGRJxP9ZLmveYIpAIuZzRSt3j1
         pNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748756; x=1716353556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxfiITVjEz5smO5GO/pbEdvc3HEsMTAy+JAImqMp9NE=;
        b=febFGEbeR9TX49xkB6UN1QBto9Lvb5TrjohQbQgn79lFX/e/1mI2SR8m6jowY6sD6N
         oSj8SnwqPxLAOFLby2GlDTHfpB/yHcWixp06pEIHjsiMKP32YK3HlOz3uQyNUQrA7czL
         3kdPHzb+bsJkcRpgVfLVb77qMXh9+6IeOeh/KJKegakppOoz2xuQLRiRewiuF6A7uz28
         7+TJdZFCew/V30Iv3JjuMZm+3EKTgVrLptmysTFm3wPBRPVa9INnZYXig0Nf/huC5ka2
         AkosWnTnwCpDokoKgmmebHS6ooRj3NYTTkxH8u22R58hh0Vumnk8/LpObiXCu+9K8nPc
         OFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbaK/wWJqD9g0ysKpEh1xVV05ES+733HWsrotVnTREgRvcmdNAqNV8ZNNybOFcINjSlawJQ4ZMfwNX2QltkUEPFCYUlTbvKvM94CE5
X-Gm-Message-State: AOJu0Yz6nUT/jRSciczEzU9UfIQuB3Waf9bG3Ce7BcGkC+OThVEP9U9+
	O22e0yJniZHt3khJAj8Y4PqBliyQlnIHbyzD9qFDzuK8mbw8jxmz39BTxYJKfzVgvgHzzAiVgAi
	9
X-Google-Smtp-Source: AGHT+IHHb2FezJuQyY60eDi4sVFJ0+3TzoYSFsoj/FhdPtZ4lKhk+GL3rxC4BlodqXuqsF7xUWbM3w==
X-Received: by 2002:a05:6a00:3d15:b0:6f3:eb71:af90 with SMTP id d2e1a72fcca58-6f4df3ba92amr24104738b3a.4.1715748754987;
        Tue, 14 May 2024 21:52:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:34 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 02/31] Staging: rtl8192e: Rename variable CountryIeBuf
Date: Tue, 14 May 2024 21:51:59 -0700
Message-Id: <20240515045228.35928-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CountryIeBuf to country_ie_buf
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0809af3fd041..8a84d61e6912 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -950,7 +950,7 @@ struct rtllib_network {
 	struct rtllib_wmm_ac_param wmm_param[4];
 	u8 turbo_enable;
 	u16 CountryIeLen;
-	u8 CountryIeBuf[MAX_IE_LEN];
+	u8 country_ie_buf[MAX_IE_LEN];
 	struct bss_ht bssht;
 	bool broadcom_cap_exist;
 	bool realtek_cap_exit;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4a0db2dfd5e9..dc0db6fade0f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2184,7 +2184,7 @@ static inline int rtllib_network_init(
 	network->SignalStrength = stats->SignalStrength;
 	network->RSSI = stats->SignalStrength;
 	network->CountryIeLen = 0;
-	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
+	memset(network->country_ie_buf, 0, MAX_IE_LEN);
 	ht_initialize_bss_desc(&network->bssht);
 	network->flags |= NETWORK_HAS_CCK;
 
@@ -2343,7 +2343,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->turbo_enable = src->turbo_enable;
 
 	dst->CountryIeLen = src->CountryIeLen;
-	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);
+	memcpy(dst->country_ie_buf, src->country_ie_buf, src->CountryIeLen);
 
 	dst->bWithAironetIE = src->bWithAironetIE;
 	dst->ckip_supported = src->ckip_supported;
-- 
2.30.2


