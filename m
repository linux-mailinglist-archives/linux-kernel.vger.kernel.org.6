Return-Path: <linux-kernel+bounces-207665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 213DE901A60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB761F21A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB4D18059;
	Mon, 10 Jun 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="k73shDVA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE410A22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998541; cv=none; b=MHBl2mb9oo3QwigH4AtskTwELfSVun0Q8tjtPSLzO1/HaXdHTGR2SXCSuzrYf+oZ7OoT7EX/cbhFNBcxcKDDNT0XZpGfQAgpXTWMcrs1EQN7PCpceg2iMX8P3ycVg73PtIbK4xXVyQf71/e7cjbw73n8r80uPvx1OQSNd0xisEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998541; c=relaxed/simple;
	bh=qYhOWTTUKof2c4QgKWFM13jGlMxV2R9Pkak3B0MAmE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kz3Hpg+xZvYTRaIRB6DWVBFW+YCgsrxHQhjubYgXHVKLnEv8ETVoaUXWGVCsDcx7CMl7xzh4ALtPwN6l/U5inSKvttyr2h41n4sYMfCIM2VtWnJXUZ/ExncuSdFT+JqHB6oIl8C/YYhJ58ZwQksD53G+Hatc96NFG+roFWWYz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=k73shDVA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f4c7b022f8so37086995ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1717998540; x=1718603340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRXRGFVuPvTPmvLX2a/6A6CGCqB7aDpnf5P75tUEXgY=;
        b=k73shDVAldRFKOAx1Rk1PI3yA2pZ8XQr6dQQsDJYHoiD1KURLNVXbkJ0xtfQ+s3LAq
         D0K4pWZ5eV2Ojh21XbZnCHyr6hT869aycX01VY5GaiETRYO844ACyBjETJSuaLLQOhXx
         /uV7a5RoCFZzk6yoMUS9DWgsDBYGqB2honY/I8ofBF9SzSlweuJuQ3T8LbEDCMSlqwMc
         i4XQmQkKPv8Pi69nwHsE9gM06qn9ydNd8W9CMkhOpCGJPH9Jj1fm8wBn39s0N7bqXQL5
         2bfx4onbpTHxq8nFYoqkIKIQoi+4b+8yKmq88b8zEgudJekPkR8mmCp0FefeIfSvN6I3
         5/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998540; x=1718603340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRXRGFVuPvTPmvLX2a/6A6CGCqB7aDpnf5P75tUEXgY=;
        b=QLVznE+irXl1of/rqhNQQBRSPuh1YD5CdZkQw1TK8Wo3gBsd++xKeo6gRDcE84tYtn
         qmU+ATUlmNImeM+ZUohqPtjevNrWzs/J99hniXA8HMDQ2gzwoj+vptBZdFUSN3IsOZ96
         Sexh5sfTIyap4rEMJ03a6zK3S8452gtEY2Jl5rrFxPCtvQvdAA2MNnxBqav3NBbCzbpv
         EBawingWYDztiH8Ld2bmjpW4ybqpMtd2OMdLY7j5f9jYNHHsd/qA36j2NO3RPppazhVn
         f4Gh7/WwOdePDh+1T92rVMHBx4BxNdhgKSmO+S9IJ91aXa9NQ1MkwGm1uGdmEH5Ju5p3
         LqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAnFqXbuNNX2OwbG6N7H1u2RsVr2KndU76IgRRPBsVIHatd6AcoZtvL/NwzLuyIcUSNBB8iD09mB9kDa8huLISq64kRGuURtSvnKNn
X-Gm-Message-State: AOJu0YxfD1QpqIEpa5u0LccFfOJq3TuZexKXSOxdYu/6TkOZhAeg60Om
	bBb0/bkeI7YqVdVbPUMzNj69mMSaLyXSefALL/rxEpyiPnvWZizVesKPIm/r76M=
X-Google-Smtp-Source: AGHT+IGEuNTi3Jp96CjNxqopxOinooozrwQO8gHbqgUCgcm4hReSHbBK2fpFZHd1rpF2jZcIIXgRrw==
X-Received: by 2002:a17:902:e749:b0:1f6:f3cb:13e5 with SMTP id d9443c01a7336-1f6f3cb313fmr60008235ad.61.1717998539690;
        Sun, 09 Jun 2024 22:48:59 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f1aced64sm35653725ad.9.2024.06.09.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:48:59 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/24] Staging: rtl8192e: Rename variable HTCurrentOperaRate
Date: Sun,  9 Jun 2024 22:44:28 -0700
Message-Id: <20240610054449.71316-4-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610054449.71316-1-tdavies@darkphysics.net>
References: <20240610054449.71316-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable HTCurrentOperaRate to ht_curr_op_rate
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_tx.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 36a734ded7dc..e38cd0c9c013 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -496,7 +496,7 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
-	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
+	ieee->ht_curr_op_rate = ieee->HTHighestOperaRate;
 
 	ht_info->current_op_mode = pPeerHTInfo->opt_mode;
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 46bc3561f56f..6dc641f78202 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1198,7 +1198,7 @@ struct rtllib_device {
 	u8	reg_dot11tx_ht_oper_rate_set[16];
 	u8	dot11ht_oper_rate_set[16];
 	u8	reg_ht_supp_rate_set[16];
-	u8	HTCurrentOperaRate;
+	u8	ht_curr_op_rate;
 	u8	HTHighestOperaRate;
 	u8	tx_dis_rate_fallback;
 	u8	tx_use_drv_assinged_rate;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8856191a1228..360d1cc446d0 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -510,8 +510,8 @@ static u8 rtllib_current_rate(struct rtllib_device *ieee)
 	if (ieee->mode & IEEE_MODE_MASK)
 		return ieee->rate;
 
-	if (ieee->HTCurrentOperaRate)
-		return ieee->HTCurrentOperaRate;
+	if (ieee->ht_curr_op_rate)
+		return ieee->ht_curr_op_rate;
 	else
 		return ieee->rate & 0x7F;
 }
-- 
2.30.2


