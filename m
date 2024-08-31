Return-Path: <linux-kernel+bounces-309815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4C9670B0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583EA2842BF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89C176AD0;
	Sat, 31 Aug 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSW1X5LT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F317ADF1
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098925; cv=none; b=l+ziSpp6PpHaLK3fPflUR0/J3j02rLTF5uu007IlHqsoGjM/aLNzB96GD4KcR2NFFwTnm2zYUjDqdO98HqBBK27HOPIs7McdrCS9IB5yr5/OrIbcre6zMIJvjpCiSQ270KzT/6n5X0ziNUcpzSU2CAH82Mhq1eugxdGW7CXRB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098925; c=relaxed/simple;
	bh=cY2o0UYjDgyCICYRXstYHRj5B2Xr5OU1iSqLAKb1/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwyccqkhLTeJzGMNxoVK65WPX6IADiw8pNZbLkEPxL0gMrHINXsfuO1sM1zuEIabygMznYnAiHa0tVtKSkN85FuIhkhnlRWD06P/jRWx9A0Kd4/fd0RKL9azJTNJY/Ox/nIpoGWKbdiNIQHjPLSs/MmsZ0CV0hJJfu8HRG8PFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSW1X5LT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso2713627a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098921; x=1725703721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7H9JeKDAqJKz9ZBN3dXy+SuB9Qo0RI3iNgQzrTm7+U=;
        b=NSW1X5LTyIIHZejhaGgQbM9Ca681bbHcgfvDwnrtXbtzjNa9UxUQE6du2Dbb9Orp6a
         teOMwJysdB0VwtL9jaoeh63ON5LMMGcTAIEImgHko430UKAYbTSPzglWa6NL/Sb5Dayw
         Gogq1EJ6BlLB1+ohxaVAxIdISLtXxPM13I30L3DEevG2WrUpfXRHcToNFcForTpY/tDt
         0T69xpgRQjSPD1L+bAhsGEElpeuBJBvxAc38gIdwwGP2iR4hxOelqzznFCIwa9lw5NU/
         hE+h1/7mVDzzW4UE9ODKbPuMg99t6YRNUKndzvOuwAeGzBxt/7YCMdqc0zMbgaYeUMfP
         tdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098921; x=1725703721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7H9JeKDAqJKz9ZBN3dXy+SuB9Qo0RI3iNgQzrTm7+U=;
        b=TJ6IHpkWxF4NWxL17KsoJRo4JdiADvfG/hWXdVBMU16ouZkWEahG63eqH6R0SqsNR2
         W5DlxXonDaUkiQ2lMXF4YfM9V8TI8AWzx3Z8o9mS9g5XRy04j1UPZW2Uw8A83qtxkTKo
         qMT4OKnJKJnqFYC6akUPJR9sgl3NTOaZoJ7tJA75krJZ6em1Z8wa5lBa9aXF/u6ILmBD
         9tRQ66vilzD8hATdwp6GXKRahSBnIhZBq0pshQinrE9io95NqOTGo6gsbLlhX+dgR1Vn
         ecJUV3e2QDKOWrezC703iGOIo3ukzMb3/AiGJKrmwLWlflR95Fs//VB646Sm+C9CUrug
         kF6w==
X-Forwarded-Encrypted: i=1; AJvYcCUXxXKu8wWmTH/N0eA6LwZn3JVAFvRxYERLiSlrFlhk4BAl77rJR7rfnVfnBDMXRaMjunHbaarx3EsbXtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfvQ5liVN89/NuxMPJIDEhx3KK7c0fKbSwUyIZClaN6nl8kLx
	/aHHYwRlhVoYujbrStoIfQ35wEb/C2XFMvLZhSt38MM73Lp4xIID
X-Google-Smtp-Source: AGHT+IHOrDxSup4u50Bd3VqTXPrAvwMsYNR71+rzdrczOx4Xxg0gfqvvk2UHVu3qu/A3M2ISF+d4jg==
X-Received: by 2002:a17:907:94d1:b0:a7a:b561:3575 with SMTP id a640c23a62f3a-a897fab7ddfmr639638066b.56.1725098921158;
        Sat, 31 Aug 2024 03:08:41 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba11.dynamic.kabel-deutschland.de. [95.90.186.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm307444966b.82.2024.08.31.03.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:08:40 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: rtl8192e: adjust size of rx_pwr for new RF90_PATH_MAX
Date: Sat, 31 Aug 2024 12:08:06 +0200
Message-ID: <20240831100809.29173-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831100809.29173-1-straube.linux@gmail.com>
References: <20240831100809.29173-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local array rx_pwr in the function _rtl92e_query_rxphystatus() is
always accessed by indices in the range i = 0; i < RF90_PATH_MAX.
A previous patch changed the value of RF90_PATH_MAX from 4 to 2, so we can
reduce the size of rx_pwr to 2. Use RF90_PATH_MAX instead of a hard-coded
size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 519cad9e1106..5646bd498871 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1159,7 +1159,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 	struct phy_sts_cck_819xpci *pcck_buf;
 	u8 *prxpkt;
 	u8 i, max_spatial_stream, tmp_rxevm;
-	s8 rx_pwr[4], rx_pwr_all = 0;
+	s8 rx_pwr[RF90_PATH_MAX], rx_pwr_all = 0;
 	s8 rx_evmX;
 	u8 evm, pwdb_all;
 	u32 RSSI, total_rssi = 0;
-- 
2.46.0


