Return-Path: <linux-kernel+bounces-210876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB9E904996
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6489B2482F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892581730;
	Wed, 12 Jun 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mC4JRqdR"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511847D3E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162569; cv=none; b=sDu+izn6J9HO8O3oOLn9fCz4nnhLAZacZH5J3b4VB9WRZOB2zgmD1rV6iwGnce8Zv5R7VyWZdd/4ydeN3DLZF95l6QBqB7yG1Spx+2fZMBsW40imltEQlddNRugdQFYGPbWsKsEIGsx5g3X6VDodBtFqPyb/JbFRCBP75256N6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162569; c=relaxed/simple;
	bh=PMBr1YYNuZJA6HyrdZulTQpmDuqmO4Ov8c7SotPvG2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsvzGbofWHJ4m2b8gWe1Gg0y9my0+eWnj+/118Xny3bjlNoR1Hqsc4AhioQ931TrwEz0R+7MHizeg5pD1/ONI1L1eEqvQw8lCT6XC+S7ydbbGAp4JlMoF2EzEZppufR0QlEtN9mOVQoGIHzvLYSVaKjvrjS21xvtZ6lhFebwHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=mC4JRqdR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4598748a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1718162567; x=1718767367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRT6W8iVB5TH/crkmlwaDlIVBxRo8bFFTV9sN1VFjZc=;
        b=mC4JRqdRIx6S/JYk2QiJTkGurdiyRcxj9+UQfY8K0z5LERcYSMjnjhbJBrnH2vVr4S
         TdtLwkKmKxvK1AjpTcsdadgVfG9AjE343/BwduqBqUNTlTccUvElccRmFl2i1nBzs1co
         v2KNedNwlCcIDeZsBaXMIZiY2PfiWZPpqhVnmQH2/bj5oHfBhWIxIMDIATuG33+EGShJ
         i1oxy5WS2Z0wuh9A3mjJnDOwSFMXH/DfK1Hsh+SitPEhaTlrAdstwj2Cc/08WUnfisUb
         9CgjR2slDXVGqJH9Iids7jVydihagOd+npeF4OdaQHLh48s4Lkk5CCX5vASLA5FhoyqK
         oASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162567; x=1718767367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRT6W8iVB5TH/crkmlwaDlIVBxRo8bFFTV9sN1VFjZc=;
        b=kNVbl9uhpdbu505DWj42bSPVM62rokv7O9lwAzOmhtuQFPCt36SuRXoWp5RcMLaJyl
         80yi4DzKHjpNA1v+nWzSQmq/UZpG+fwzRFwKOkXwCZrVuePJHGHJtBbW0Zc6RsNTuath
         6N076LYjXtO4VOiKPwkg6drfN6ZjqJWmNpgQgCcF/DMVYypdvduuBYumrz25jI+ekusE
         zSuvPMIFuRVZrv0ahkB7vlQCQtkUPdJK0IAB3Kox4+0LOmlJpp9cdVR+C+9IcOfU0FO3
         Lfc86MbnmEfKfiZbOerfsfT1z8pm7cbildFTOvw1QYi2cUiUM4i4HJXe7bifNi/2JmIw
         Ngqg==
X-Forwarded-Encrypted: i=1; AJvYcCWluoUQlPmf0r0PyoomN0TaoLGK8ci/VlkJigrrRvUhD6gfz5dhkycSGQQiPDcZF4weJI1sqSYkRUjlIKx/iEE8HKRrdKnSXJOJWbX8
X-Gm-Message-State: AOJu0Yw9ZcGfcPzFThhNkRJ7mZPe7OlfBMfnfpV91qTpVFuvkayhbVkr
	PcwrV+sN2FIeAPdHfIceALvCiRklrnLQslr9QGCDxJDUVYC7m340ArPtG/LWTEo=
X-Google-Smtp-Source: AGHT+IGZdQyolydFOX1yTIyzNKpwzTfV5AzcpkckaHLJKdXgYjzu4RuXNrxgsTNujadAQhl/3iDzyQ==
X-Received: by 2002:a05:6a20:3d8a:b0:1b4:4568:4c3e with SMTP id adf61e73a8af0-1b8a9b77ac9mr892626637.9.1718162567564;
        Tue, 11 Jun 2024 20:22:47 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8e8a84949sm5635411a12.32.2024.06.11.20.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 20:22:47 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 17/24] Staging: rtl8192e: Rename function rtllib_query_ShortPreambleMode
Date: Tue, 11 Jun 2024 20:22:23 -0700
Message-Id: <20240612032230.9738-18-tdavies@darkphysics.net>
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

Rename function rtllib_query_ShortPreambleMode to
rtllib_query_short_preamble_mode to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Change
 drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 06c3166a5b47..93b9f0609428 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -319,7 +319,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	}
 }
 
-static void rtllib_query_ShortPreambleMode(struct rtllib_device *ieee,
+static void rtllib_query_short_preamble_mode(struct rtllib_device *ieee,
 					   struct cb_desc *tcb_desc)
 {
 	tcb_desc->bUseShortPreamble = false;
@@ -868,7 +868,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->bdhcp = 1;
 			}
 
-			rtllib_query_ShortPreambleMode(ieee, tcb_desc);
+			rtllib_query_short_preamble_mode(ieee, tcb_desc);
 			rtllib_tx_query_agg_cap(ieee, txb->fragments[0],
 						tcb_desc);
 			rtllib_query_HTCapShortGI(ieee, tcb_desc);
-- 
2.30.2


