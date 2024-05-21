Return-Path: <linux-kernel+bounces-184426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D68CA6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941AB1C20C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4A4597A;
	Tue, 21 May 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bX9WWI2r"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7461D52B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261446; cv=none; b=bq9iIcexdR/DDXsKyPeJKA8/Qpq/GCIVBfLWzUE0VRqDNuM3lzteNS3UdP7gCwXL2oBlngPCTGqB3lTrK513YOiO0H1yDI4p+KQlzjDVlY16Dn/tb0fttqSE5EndXhvT8itJaA3sv4++YDGT05jN55jVKMoqhZ6y9pu4VqVJmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261446; c=relaxed/simple;
	bh=ebhL7OWyfs31SLaHB1cYxnl7cOPvEZeqPuUHXc5pcNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtMRn38R9FEN6StSHJDe3/UlbQO1YsI3QF92xb02wW7QjvCQNJoTlpz1wC9NxoHe08NMmGXv2zaTkLGbnqweHSvl3Bb2DpzBj8m4tPjNplJHua/iKcKLE4Icsz8B7jL1EhtCWklXivEZWhysEVXQdZrpN6mQMtmsLO7OYyWXd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bX9WWI2r; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec92e355bfso107909875ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261444; x=1716866244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P37hzP+paRdjgXjGabfu2gjX5afmH1EUMnSM6TIDMs=;
        b=bX9WWI2rp9QnuAH9Fz1ayfczIw07fmSrPHU2aw4NTqqGQT3LBUzl3gsY73zsRBf1YZ
         Ch9hyY5xDrjQokRcbbW+T6CTOt0ZyfVtwyb0EvrQj5vE4Gkgkd37w81+XRECsMUlibpk
         +m11KUn8Q2Lc9Y0+fmx2ysIyUrB4HVAVyinF/PaFOk+DMUpUB2Wrwj0+mRdJmyKB3T8p
         jGRO5zR04zx9oFLcxifZ+8ppBPXEsNmy26p8v0lalQBMCE9EvOdVYbti30gkmgvxTFl0
         MKuonsiKF95wFyfnwp2aP4KU3qEE4qSUt1Cffzr/nbOQbxSGMQa6orZ4bzfELVEBDize
         1hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261444; x=1716866244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P37hzP+paRdjgXjGabfu2gjX5afmH1EUMnSM6TIDMs=;
        b=EvFZnpwhywUhSljbAlBGtBU6R4RSufqslW5oIpd2nq0cyHuIrE16u7q0MEppiL1CsH
         ZG56hrgt1J987dNp/1i2PXu5cpYdPJdVG3o5ISzXRbjodsq/UotlWRB1nEI7R1fxWSat
         I6GXWe5/xfJ1uhWdy2DPBKvrM8c8OecNAJIMSfATxKHSNp0dIHPF9vOzTQAjBTTI49XE
         w1gQQOnMolKkkQsXBg4x3jjbXD4Cq+WB8vkRj8mPP568iCtYvplHacesfzkwMupdXNoQ
         PXhrquRpoPiUdwhRFhDvQvTzEmDWa2V+m5dfvmVZybYT/MdOT9vuSMhR+wWN2QtSZnNf
         YbEw==
X-Forwarded-Encrypted: i=1; AJvYcCVKL2NklkloudJN9O55Z9whSKSTZqDtgEXR7QLV9ocD5OWKXujlhQxPCNs1tCuHtKnCLbEuEjeZz9CcJvRqWPv4w0J+ZRRyk3zkxxJS
X-Gm-Message-State: AOJu0Yz2lR6Odynru0qYWn/VSH9V6rdFk2l2EG36ubE3xioB+lQE4eS9
	8wAuimALAsmsQH80U7kejyDBlBTF+aY0DMmPqhfItnQ84wbtDIFTtqcb+2WTWSA=
X-Google-Smtp-Source: AGHT+IEguD0lIgnB383cVpP59a3+EhvaL8r/2t38JuAG5vekRSV96M1f9rt5EICHCrC7qXiplCmvTw==
X-Received: by 2002:a05:6a21:8cc9:b0:1b1:d31d:c0c8 with SMTP id adf61e73a8af0-1b1d31dc132mr8718679637.32.1716261444057;
        Mon, 20 May 2024 20:17:24 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:23 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 03/31] Staging: rtl8192e: Rename variable CountryIeLen
Date: Mon, 20 May 2024 20:16:50 -0700
Message-Id: <20240521031718.17852-4-tdavies@darkphysics.net>
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

Rename variable CountryIeLen to country_ie_len
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8a84d61e6912..cae4df481397 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -949,7 +949,7 @@ struct rtllib_network {
 	u8 wmm_info;
 	struct rtllib_wmm_ac_param wmm_param[4];
 	u8 turbo_enable;
-	u16 CountryIeLen;
+	u16 country_ie_len;
 	u8 country_ie_buf[MAX_IE_LEN];
 	struct bss_ht bssht;
 	bool broadcom_cap_exist;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index dc0db6fade0f..1cae6d6efb96 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2183,7 +2183,7 @@ static inline int rtllib_network_init(
 	network->turbo_enable = 0;
 	network->SignalStrength = stats->SignalStrength;
 	network->RSSI = stats->SignalStrength;
-	network->CountryIeLen = 0;
+	network->country_ie_len = 0;
 	memset(network->country_ie_buf, 0, MAX_IE_LEN);
 	ht_initialize_bss_desc(&network->bssht);
 	network->flags |= NETWORK_HAS_CCK;
@@ -2342,8 +2342,8 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->RSSI = src->RSSI;
 	dst->turbo_enable = src->turbo_enable;
 
-	dst->CountryIeLen = src->CountryIeLen;
-	memcpy(dst->country_ie_buf, src->country_ie_buf, src->CountryIeLen);
+	dst->country_ie_len = src->country_ie_len;
+	memcpy(dst->country_ie_buf, src->country_ie_buf, src->country_ie_len);
 
 	dst->bWithAironetIE = src->bWithAironetIE;
 	dst->ckip_supported = src->ckip_supported;
-- 
2.30.2


