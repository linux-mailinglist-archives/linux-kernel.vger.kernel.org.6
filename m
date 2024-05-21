Return-Path: <linux-kernel+bounces-184430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307CC8CA6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622761C2039A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66E250A65;
	Tue, 21 May 2024 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="FUGwlpUN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDE4654E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261449; cv=none; b=lYffksm7rChKrovvKRPYdkCjtDC9FMh9K5JLSQecglGtI8W3fODlZpCGpXEJvqsJQwQPXGKOniu8zGTDUO8IKxOR7+f1Hy/IMXXQcJ2hPr0OOpRL+/QZyf6aW6IrYErQrRaOF10H9WPviq6E5e6B65N9CA2uvPlqRGBoQTVJNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261449; c=relaxed/simple;
	bh=yjnVfiPa/m1e7bMoAHPK8wG9ELF9HjLigJk4WoCJGCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foPSGN6pv6irGRb/O4VtH/AfDomkO1S3c2y/Mn2yVlvqCzztoE9s2i8HfdxSD1RFx9ppW9WMs7z6X6rYpnrWLhlYlFRmJUr8uqZBsAqEkCo9vxjGgpKWAiItajrF/+c2FLAERNW3QiSm8CJeo4l2TpZLksaOZ8BLasTqJZXwpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=FUGwlpUN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed96772f92so92953195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261446; x=1716866246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKQNuljJrQrm0mrk57cCGFb1Ap+racxF02oGqH9QatU=;
        b=FUGwlpUNleAcVSd/0DKGY5DthU1+WHhGXgsfqSZMSVPNW4mseLI/shtstsjgPayWdp
         Gjkdofuxa2o8nClBbmGDfyIWAV+1oBljo753SahogTighXp0DYOFZ8SfSIYSYeBW3iv6
         C3dipajyzsKpzpa6u4dc4CulHcJj3sFOl+jRymtH/vCsSl7nepsWY3Tr1k2kzg7TqunK
         f5voxazmxI+HOKbSajbgDSs68Vq9L6FkZ2OopcIaKJsTzqnUL8zxM07uq5ZliVh++H9W
         XInabWuynv0yNAfojqg2zMEDi5CqAW43SuTuBhYbXZnVUf7KSPuHXi8P1nlGwPubApVW
         mG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261446; x=1716866246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKQNuljJrQrm0mrk57cCGFb1Ap+racxF02oGqH9QatU=;
        b=vovwO0xlXtxdln3eyTosG5YXpUTzYVc3Hel9niSCpWQyuaI5UCKd4u+kbzvltYk4GK
         QqipMccXFqjy8/gL6w2E6k2vAHygC4STbETUHAFjO4OesdbuZUKj5Pzo8oYjm5N9bsq1
         iwtttVRM9rG78lBdpwBwAM3W/lAAZoklm8Imvv3BkwYZG7JyKU/SpqHv2dvGsyuc4YyC
         17z4FEQfNdDYvpRLgLcx6zFNTs8r0XyPySyLve4iMPxZ38YGXfOQElbwYjOkIk3aTU6G
         I2Ss+yEVfY82oS5tfH05KYZ2jHCtgkZw8nKX0LCJiF9qmtou0Nxn4loHW7ghdCCDCjQR
         g77w==
X-Forwarded-Encrypted: i=1; AJvYcCXavGQ1RW1ykJF6zIK52EQhM7YUVWZwqz9gzB1dKU+oY6yQCsG4nh6/EMXUYdvn4p/TMgY5TO0U2ePO8cb6bbElAXSWVGwU0y+vP+6N
X-Gm-Message-State: AOJu0YzesRm9sgzHfgvXds4H5faLxx3JuT2N8xbQEDk+lw8ZpXawH+ra
	E/Ukx+PGigmRxJXpbUJuFz1bZQKlQdndHDrV+2p8G5CaF7x4+UTs2xIDmSQjGWM=
X-Google-Smtp-Source: AGHT+IFw96ldbcgB3oflpWfTd8TOYioaKqrI7h7QhyBMYAnNYP6nXm5YDsaO4zlFVR8FeN+BqXFiSw==
X-Received: by 2002:a17:902:eccb:b0:1f2:ffca:879e with SMTP id d9443c01a7336-1f2ffca8d6fmr51273685ad.11.1716261445574;
        Mon, 20 May 2024 20:17:25 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:25 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 05/31] Staging: rtl8192e: Rename variable bContainHTC
Date: Mon, 20 May 2024 20:16:52 -0700
Message-Id: <20240521031718.17852-6-tdavies@darkphysics.net>
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

Rename variable bContainHTC to contain_htc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 40ec29434d68..ce0cd1f557c3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -489,7 +489,7 @@ struct rtllib_rx_stats {
 	u8    RxBufShift;
 	bool  bIsAMPDU;
 	bool  bFirstMPDU;
-	bool  bContainHTC;
+	bool  contain_htc;
 	u32   RxPWDBAll;
 	u8    RxMIMOSignalStrength[4];
 	s8    RxMIMOSignalQuality[2];
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d4dbf8052c30..4e7c491c0aaf 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -743,7 +743,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	if (RTLLIB_QOS_HAS_SEQ(fc))
 		LLCOffset += 2;
-	if (rx_stats->bContainHTC)
+	if (rx_stats->contain_htc)
 		LLCOffset += sHTCLng;
 
 	ChkLength = LLCOffset;
@@ -862,7 +862,7 @@ static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 			netdev_info(ieee->dev, "%s: find HTCControl!\n",
 				    __func__);
 		hdrlen += 4;
-		rx_stats->bContainHTC = true;
+		rx_stats->contain_htc = true;
 	}
 
 	return hdrlen;
-- 
2.30.2


