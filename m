Return-Path: <linux-kernel+bounces-322364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C129727CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61EB285AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1D15C156;
	Tue, 10 Sep 2024 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxm11Dx6"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D714037D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941136; cv=none; b=cLI/0QRvVrKYRHDcqmVCOsUEQ67vtjlftwIquTcjf97QI2m8b/KRUuT69EgYFS7M9dGTaWr/86OJDXo2KmkJ/A2E1PXbtedbOj7MBdV0h+3py/Z3UM/zTvVTjHQhMGXhF+sjVCNgseekxCoJK8IM+ZHwpiwYDRjAlnYwZQMFUB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941136; c=relaxed/simple;
	bh=1ziOisrsaKx9mcLmEMAB+eShXK3KN3vwItbdAjnlqNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=levP0VkQVFR8Q46HfOVsPX0ityo+Mf/ntNvsKdX9edH/xYmmzN4b4jFjiOEWEemftCqBAquOczcBfPM3O5o6XuGXONgdgKy1b738uHLhWbf+kBg3TJ/hLTv0UvhT7sCiTPQoPSEIjfuzjdj52KJ3bWiTjH4J7FoR3g2E5fPV+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxm11Dx6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e25d8b67so640742b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725941134; x=1726545934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57j6dC4h677FMz51Re5oWsR6lG/2ScumpzqstrCEmAI=;
        b=Zxm11Dx6P/1YHiLYpsCgw6Z1qFZQ2uGsYpEO95rDUPuy+F3Qnhtk8Ki8OvaAlGfDj2
         /d7UsHk1kPkqzbTcwSSwFZ/S1C2mK3e9Wr0YrS952kT+H+mPq5henVOsjs3xddZrpuWd
         pNaE0F7alKFnbapFN92l8vgkQlNpbVPZtdfthEJ+A6dpg65dWqEQU1fhGq4C5RWaHszu
         gKg6ajSECOAlYvHfpDFJNoewEWUV1AIXi+RUDdnKG1WK11UFp/Ltn1tJL0nNUfCcr1zO
         Sw8D3KatWNY2g0KVrtp1SZr3xPpbCkyL6ZhO2B5g27WAg79SvUWeEpahiqVmhvFCq5q5
         Js7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725941134; x=1726545934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57j6dC4h677FMz51Re5oWsR6lG/2ScumpzqstrCEmAI=;
        b=GEWWzuJBhAzH2dEzl4Aj4S+EBVfwJM/XOl4pkJ4rPIgt1QtJea7UtLTrcybj4dVUOc
         l9gzxgLsTTcZ3ff1WJJeXIZ7aqE3hAl4aBnbrtfPF6A9V5iKPLsQ4lbSTXZY1YXtPxzV
         O0LSd30FbN46usIB1YyE54OSMLhUKcC4BTK8bWZBh1KhVTyI0es8nye3qGo4DlIBGb0U
         viFMhCvFE3MfqtEi6v4bvaqaBWFPVoJ41iVT8vGEAHlv/Ju4WhMCir8inDEMOOgbKVDR
         az5zeudeHVn/HKIs4LPzOmDeo2Y83pu36oRqs3Fc2OznDk+Qod/og/tQBM9l865+fCcx
         e/tg==
X-Forwarded-Encrypted: i=1; AJvYcCWvy7obbKSNNoSky/lKVStjyfAPhFFnXTFu9OPLCd1kIjSz0eFF4LypVKSktMj23GjfxcLAJ5WwfhjxdYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpybgKa+2r9LGDcfUvDNvsmNBtqULkudWYOoxmlaHGk49+81F0
	8CaLQHLANaLx2s2fP4uMmqvo3RbVr6my+vsfWUFWMaws5g25Hcqa
X-Google-Smtp-Source: AGHT+IFuCKt+97i4M+2mrhF3+ODNKOXG9EUEen87AEDnk1K9pGTHYhWqhp++DOhd92pCS/rNrpFuew==
X-Received: by 2002:a17:903:1d1:b0:202:2af7:b50b with SMTP id d9443c01a7336-206f054055cmr69842275ad.5.1725941134116;
        Mon, 09 Sep 2024 21:05:34 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f5245bsm40610785ad.303.2024.09.09.21.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:05:33 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c
Date: Tue, 10 Sep 2024 09:50:24 +0545
Message-Id: <90f26f7bce03d80848e3c0fc166c5ab584b83446.1725933169.git.topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725933169.git.topofeverest8848@gmail.com>
References: <cover.1725933169.git.topofeverest8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3: Created patch series with cover letter as suggested in the feeback
v2:
 - Created patch series as suggested in the feedback
 - https://lore.kernel.org/all/20240909041549.2449-1-topofeverest8848@gmail.com/
v1: https://lore.kernel.org/all/20240906141157.10167-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b1965ec0181f..755c1bc86a74 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -45,7 +45,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	init_completion(&pxmitpriv->terminate_xmitthread_comp);
 
 	/*
-	 * Please insert all the queue initializaiton using _rtw_init_queue below
+	 * Please insert all the queue initialization using _rtw_init_queue below
 	 */
 
 	pxmitpriv->adapter = padapter;
-- 
2.34.1


