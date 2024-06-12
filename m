Return-Path: <linux-kernel+bounces-210878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9597904998
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959831F2485A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17982C67;
	Wed, 12 Jun 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="H9GGNvhR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475780C14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162571; cv=none; b=oaKTsBLaUTNt0WEjdyZZyb5moBXogrpYwvjCubT8ePbxtRlCyCjT9+jQoBSigtJyGj6/mdQwuIFUWRMMgs5qltF+ubiOmZJft/ZAbZMsQe/Ui0AQHI88or47XWRYsRisso0dX5+wDCKC6QY1m0GGKCBgOi9ezW62BCHFND6cmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162571; c=relaxed/simple;
	bh=1HQdO3CVCBt1jv7/Hcgi7TyzvW2t1arGQSRLfS88Mxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hprgkc5yrIJCmW69udXxNYjmX7SMIbuSNRwNCAdeToJ3BSVFY99ATDd6ImLeHWDAJKD7sAlk4wpe8CiaiNJycCg/+CdNh6hXBA50ldvLH6y+aG6xGtPLF9wq161bdK1izCwGiuTs3vcTmwZyHXZfBT/TLD2UZG4Itb2vB9m6BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=H9GGNvhR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70599522368so1512486b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162569; x=1718767369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNlXJ31YIbCQqnMFI7ayEiu4pLngypLxNb6gVxuSZNE=;
        b=H9GGNvhRHTsgXzJxRLFl06Rp7Bf1i6J2CVUQ4b5yjxDMihNzHDWkUA492uQemncgx8
         FiA/TSeboHhH/6ATPOqGGj3AiFGEXcaHKzHNyF+Ode2Vc8DnFTkBuR2Wlj38bXua+JJU
         mSyqgy1UmFXR6kKhhk6isfohHldrgLKvDcCSJetPFc9AUXepm7zeIwED/SHghce9/FP7
         3NaDd0IeR3lRGfBSqd5YNDzmqhDcHUIFr9pgLCLZi1mxPTpLFnypXU4XMmDZVgfPx6Jg
         keCQutEO/sS5JKCbjAgvZ8+ClhjYPfzm4M29LhkMX8NiYOIs7ZK+TDDz4Law6eOSmA6s
         UZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162569; x=1718767369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNlXJ31YIbCQqnMFI7ayEiu4pLngypLxNb6gVxuSZNE=;
        b=mHiuqkN6yv/VaKUIuedTO0xcKUbtgKUbGdEeg0emUifZOzrL1YGBf5himgGlJiWvwp
         fsAEK3ozRKtsU0klNlw9ur2wkJ0Vy68y0FEY8wiXEoOU34+1AmLGBogPvWSY9WGPpqUF
         YrwvJn03RHErp1/QDMV9KgkcAtT0hAwuWrLtN3aSVqwOt6eVdTONZSPJzSh8UcVVZoEx
         2W4ezqmhzGfdr4CRLaExpB9+03gV1/q4t8FCoeimGVzBe26ahSSm5OLeT+zphbxJyzf4
         FIStlJ8DHPEinxUrBPPkMPYp0unxTAA2mPdF5+MdhViuhRGE3qsN3FxcxkKyGiVGvqBz
         NKwA==
X-Forwarded-Encrypted: i=1; AJvYcCX/mChBBWzm3JI0zmvXKIoPNnJ/2Ww7sx8UShqJgEC/mlE6YPcsxMoFS3WwHUFHJyDdu5nb/jF8VQzK5RvZGEl8QYI1lRs74HGOdzLM
X-Gm-Message-State: AOJu0YxiXj8tF7stfQsNxogfTOb23HITmqJ6rBoqnZ+ebO8+LBkayIfq
	mAy448QB+OuD7PxwTESrAgsh+9LqVb0XBBHeyw6qDZeI5i3wNYqrNUn2oNADRQ4=
X-Google-Smtp-Source: AGHT+IG3eAhcKdCbyYwlrRUkf+6AyYpjJl/kQQ5xhFG3MVQzE6WHkQiC47DK1qgkL8VZmL8TcTQ1+w==
X-Received: by 2002:a05:6a00:60c9:b0:705:c029:c998 with SMTP id d2e1a72fcca58-705c029d008mr96466b3a.3.1718162569523;
        Tue, 11 Jun 2024 20:22:49 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:49 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 19/24] Staging: rtl8192e: Rename variable bUseShortPreamble
Date: Tue, 11 Jun 2024 20:22:25 -0700
Message-Id: <20240612032230.9738-20-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240612032230.9738-1-tdavies@darkphysics.net>
References: <20240612032230.9738-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bUseShortPreamble to use_short_preamble
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c           | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f38d172ddb4b..46e42fad5834 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -860,7 +860,7 @@ static u8 _rtl92e_query_is_short(u8 TxHT, u8 TxRate, struct cb_desc *tcb_desc)
 	u8   tmp_Short;
 
 	tmp_Short = (TxHT == 1) ? ((tcb_desc->use_short_gi) ? 1 : 0) :
-			((tcb_desc->bUseShortPreamble) ? 1 : 0);
+			((tcb_desc->use_short_preamble) ? 1 : 0);
 	if (TxHT == 1 && TxRate != DESC90_RATEMCS15)
 		tmp_Short = 0;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a35079f6dc65..61d383a560f6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -113,7 +113,7 @@ struct cb_desc {
 	u8 cts_enable:1;
 	u8 rts_enable:1;
 	u8 use_short_gi:1;
-	u8 bUseShortPreamble:1;
+	u8 use_short_preamble:1;
 	u8 tx_enable_fw_calc_dur:1;
 	u8 ampdu_enable:1;
 	u8 bRTSSTBC:1;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 6a979151d1d0..1aad5253ae4e 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -322,12 +322,12 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 					   struct cb_desc *tcb_desc)
 {
-	tcb_desc->bUseShortPreamble = false;
+	tcb_desc->use_short_preamble = false;
 	if (tcb_desc->data_rate == 2)
 		return;
 	else if (ieee->current_network.capability &
 		 WLAN_CAPABILITY_SHORT_PREAMBLE)
-		tcb_desc->bUseShortPreamble = true;
+		tcb_desc->use_short_preamble = true;
 }
 
 static void rtllib_query_ht_cap_short_gi(struct rtllib_device *ieee,
@@ -440,7 +440,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		goto NO_PROTECTION;
 	}
 	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		tcb_desc->bUseShortPreamble = true;
+		tcb_desc->use_short_preamble = true;
 	return;
 NO_PROTECTION:
 	tcb_desc->rts_enable	= false;
-- 
2.30.2


