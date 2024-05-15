Return-Path: <linux-kernel+bounces-179408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C38C5FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D141F21E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A53BBC0;
	Wed, 15 May 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lQbtU6ib"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CA2744C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748759; cv=none; b=MeuEV1pc/KEvqaT2IHyvEDdG8xpN3U/345E0xxADsY9YUAEwRUOUXhjh36ln3C7iftj0sKUkVkujwnMc3/LVLgSETaw0xeDl0V1q+ngCtXYalPbAkL+94oAaxjKhvkcBiaewK3zsnOW73hfE75SMMVhB/JXQ+fZAddKaqC4o79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748759; c=relaxed/simple;
	bh=bMj1LTysdPDWnmSnuPdPl6x6oclWypZmQaNvIISuQVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQN8vel0owzbdpTNIKh8o1kIJ2CqEKN5759XcEFmKaZ9JtLnX7hlbyBCKlo/8H/8Xs+84puIMmt32P5z1RrprsWpRnNVPadiAJ2Bh/9EWxQNuOofFIkTrYlcm8td1M1GnchemQplJx1qj7LEVgj3eYI82deH2VYp7kTzA7Bx/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lQbtU6ib; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso6321482b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748756; x=1716353556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bA+4MlFti+w7GYvI8La/yKfya2pdjLh+dw43i0/xQU=;
        b=lQbtU6ibkO//bUhI+pnUdDjARxXA5opLy1Gy++FBrhpXrtGedu9EH+p9juWc6ufy56
         xN+rLPA3mUm4UcfihPQ60IYD12N8fRmJ9grEqQkarr9ZqGsCf2t+x81uBHYjUHNOWlG+
         n+X5GO1mm0snOeME8/HMNp8M3ssXnFXImEM9ghhBX9qx5dLstcFBAtVDBxRQjqWTMA13
         DRpXZS5FWHoYJcZSfB8+VeW+rf8V21yMxkzkUeMv29bSm5/Mm8+EgxBIFfLTprgl6GtA
         7ATcA65b2Y8pSd+BCQ+zWljUPLmkLeyyUnv2EyGBjNl7H7DxIDXi9Lgg/jDOb8GCrW90
         vXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748756; x=1716353556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bA+4MlFti+w7GYvI8La/yKfya2pdjLh+dw43i0/xQU=;
        b=BDzktdu/LMeWCU4lORyGmUkInabPU2SEUpMPbhbReZauXYj34a5khkIGd+kg55ob7G
         U+dAw50tWFnusro52NS1lWr7Mzj/mj1el1Uq+0z0Yeh++dIQx418HdSDSJ8itVZYWkgw
         145Ef34CDga/d5PMw6abKAGf2rNknip1FrDohfb6Vmzx5XdpNpmicS6qYeZhQSskiFM4
         w85KPX8OKqjAkuRdqiGlQcaYVlZcmfucoLoVR3pW8GUkqfdmDhO1jQlI2bZQw0EmnLmt
         7b9z80sNYUJcsad7/uJViv0ldU9umKGse7RmjaQpq16ogIkZFRzpFaIe86+MaoxflcVp
         sTcg==
X-Forwarded-Encrypted: i=1; AJvYcCUstX0yAchkZ54YAG/bIALGK0HUnB7wGvw+IffbYysZQOuptRBRaULS/Z6bFyEM4wFowOpJ0/9ga6wKxiFVUZI5alNhiZX1vp0Ho6l7
X-Gm-Message-State: AOJu0YzjCRfL8+Z7mUJ+mfhX9L81IO2BtsieIvPjcA2/6oU3rFBerN9N
	VNUncbOH9+iQIyhNumjS+ZCD8Z8YvTo8xlonEXBvsYgc7yr1xNoceXc6NyLR5hU=
X-Google-Smtp-Source: AGHT+IH+7IPgOluoAi3IpL4zc0TWJUrUEQhz7bufL00+sd65WAAqzL9nuA6x83MXq7Z+UVGa6pgcOg==
X-Received: by 2002:a05:6a00:1807:b0:6e8:f66f:6b33 with SMTP id d2e1a72fcca58-6f4e029fc8emr19237540b3a.4.1715748756357;
        Tue, 14 May 2024 21:52:36 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:35 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/31] Staging: rtl8192e: Rename variable CountryIeLen
Date: Tue, 14 May 2024 21:52:00 -0700
Message-Id: <20240515045228.35928-4-tdavies@darkphysics.net>
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

Rename variable CountryIeLen to country_ie_len
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
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


