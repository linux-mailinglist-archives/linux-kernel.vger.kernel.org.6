Return-Path: <linux-kernel+bounces-329703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8219794CE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04701C20BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E313AA38;
	Sun, 15 Sep 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlThFiGf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50469D2B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382468; cv=none; b=dZDOP+C15gZ6U4GzV/3V9Nu/jwSA2sDEanQg0ADSAoZ7yZXoKVZ340oiDaXwzAy93vVqyn4KPCF3wpvFEt3rIUXf3mOV9gWCf12OA+B5A/cCR4a1KsKTwxtTiaj1bCCZGZxwQnqIhs0W+GIv9CU7GAq11gMjuJMejRy1KZTkiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382468; c=relaxed/simple;
	bh=Vy4Z7ogZT6V1enSiVeEgUoSoj9IL1IcG0eoH+OHj+Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7Rx+Qcgm7pmDprD0GgmKUHJ04GyzB3Zyrq3Z+3CBtRsdC/9M0K92yYL3YiUj7XFpWTA+mjymTTWxcidmrk5G4QtGRBJfMrucKHxLwq5wM/Uolk9gc9/TXsdVXF0f2PWh6EaGQ91ISNhf6Ui7f5jZDEglGsdYCYq6zrkPeVAke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlThFiGf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d60e23b33so437837966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382465; x=1726987265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRQIYYPh7+sB41jLCAlLwMG5cR5oSUg70pK1/hkRhBQ=;
        b=OlThFiGf9cdUrCQsV9jq7I9dzT5YtS2p/jKFXxxfEodik1MhPWCAijCJINYoYRhiQD
         6y/knQQE7W8KXqEBryYFKMtcSPQvuO4j/38KK45z3KcP0HAQdDf6E+h8HI1bytBbTSYX
         wioCSapxcpPc5npMUiafNE/lSZUSUyVAenu1BOtfZhujV5VGB+X3QznHJ/9ZwrIZmY8D
         TNv7lOaYcmI6yTep4Syvdp7SG9SiZC7OPkifDv+n28m/Bn93t6gsFt8lMX5jjlEu6KYM
         CuY4l4eEhPnTdj/Os4LnvtVQPDe1aIrglNFJ8ZxiNoTZJqahLRlxq979ajjT06y29agQ
         0ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382465; x=1726987265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRQIYYPh7+sB41jLCAlLwMG5cR5oSUg70pK1/hkRhBQ=;
        b=hyFKikiKFrayE/6vaNJP2aLWLorYuHtUn9SGICSTqVTCuiNxBwABIzIsv9XepJYfM8
         KYnlGVOOzLp+4JMHOkkLwqmHzh4I51nsmRYvLwACChWnaqvSySr5fazCMBhII6LC2AxN
         5qeYssLPF4pXQCQ/BTC7tSEVjRIdswP6sjS2p3KiS/6+b67AK5eNsMFCCiQ4bNOSJvD9
         J0BgD3tP/Dp8pF3NCD9nn8Qn/W5O3RTBj/obVn4km0/fEyob0o6gQ0GVxLnJ8HxYhEVi
         241a6lsaoFo5htL+EzbcVBbCYHHtMg9yp8nyo94rHEU+iRWL/tpJcUYUdpaydNnRUvqO
         mYjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxFsis1fM143sL1scFD2JYFsCsQgRocRYtEllu9mGLnNAI3BqEPuASymKRekN/4bX2bepMyikIbIPNXHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuueU93HGPdZhVDAjnghavAP64/iny4gV4hp0xXNcJm5AtMaf
	o8VNN7bzFxqVQ+NPhsx21ldiPCkMWF31VXiI3tgDNDSMUfMaARba
X-Google-Smtp-Source: AGHT+IHP6XQs1lHVokE4Zc1X7LdOcT6wFW2nV7n9gM1PvFIrsqe/YisTi4556BKADZNBHqsNr6q7Xw==
X-Received: by 2002:a17:907:f1e5:b0:a8c:78a5:8fc4 with SMTP id a640c23a62f3a-a902947d512mr1057428366b.19.1726382464789;
        Sat, 14 Sep 2024 23:41:04 -0700 (PDT)
Received: from kernel-710.speedport.ip (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967bbsm160201066b.8.2024.09.14.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:41:04 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 12/17] staging: rtl8723bs: Remove unused function GetHalODMVar
Date: Sun, 15 Sep 2024 08:38:26 +0200
Message-ID: <f6f589189a72a55d3a57bd37299929c307f31b4f.1726339782.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
References: <cover.1726339782.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function GetHalODMVar.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 13 -------------
 drivers/staging/rtl8723bs/include/hal_com.h |  4 ----
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 719dd116d807..492889c837d9 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -796,19 +796,6 @@ u8 GetHalDefVar(
 	return bResult;
 }
 
-void GetHalODMVar(
-	struct adapter *Adapter,
-	enum hal_odm_variable eVariable,
-	void *pValue1,
-	void *pValue2
-)
-{
-	switch (eVariable) {
-	default:
-		break;
-	}
-}
-
 void SetHalODMVar(
 	struct adapter *Adapter,
 	enum hal_odm_variable eVariable,
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 17d5cfb66a36..4db93484725f 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -158,10 +158,6 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter);
 
 void rtw_bb_rf_gain_offset(struct adapter *padapter);
 
-void GetHalODMVar(struct adapter *Adapter,
-	enum hal_odm_variable		eVariable,
-	void *pValue1,
-	void *pValue2);
 void SetHalODMVar(
 	struct adapter *Adapter,
 	enum hal_odm_variable		eVariable,
-- 
2.43.0


