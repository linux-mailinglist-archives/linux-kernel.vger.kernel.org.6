Return-Path: <linux-kernel+bounces-184438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BEC8CA6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63222B21E46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34906BFAB;
	Tue, 21 May 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MkcUX30b"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1145822A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261454; cv=none; b=q3svhbwko8917jFBd483bivJTBQMMOvmyr2ovEO3EhMNGcpA3ae9sYuhXUvOL+2h6zBfMnEggbmbvgGOBYcZzCNAfWLpke57NW9+kTRPVIoCu/Xf0c8Ti5imcyR2RbhBlb0U8U4ToPftDPuwcf8dCrNppp9cdm3IXUv5JKXergg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261454; c=relaxed/simple;
	bh=0KJ6/0UmzK8lxJK25BNUy5fsFD+en8FEeDG8l85Cv5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBR2UBP6F6lMAiWmL8aFpzl48grJKz/0F2ga8PNvc7GxRNA8wvg5T1OFRXFjwxOib7NmuyvhanVF9pPQbxY3xJY0kaSiIdLt31Sk3QjHbTKuVB9ZAjQkHVMqcW+ziRH1MDchJP4sZgvCWI0gkSxcqTDBKXfKUeXwhqGnPgKFOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MkcUX30b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f304533064so9681735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261452; x=1716866252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPE9OC+GQk0I6LRtpC2oK8ZC/gu1AchzTamw8jiTg6I=;
        b=MkcUX30bVP+aPyxhzPJbsoJ2EHmPCbt39ihHP2puoLWRS5NqCijHtyFCJc3KQslwVv
         p+a+RVlP/5G6zZQc3qQ8YX7O/vUyJFrv2FReax3UeBkKEPLQ5e00uiPueeDyLIHaZsb/
         wJklQp+Ec5c6YbIRfa09/NWwC4LHyZpw6vItlJ6p2hia1WIaefFqW+rqKWnd44A+2duW
         39tILb4eqnO32+GdXz/4LtnZuTsMbCO9/OkXHsw0RIImuPiERo7s5MU/9Z20/ePyQyi1
         Dxp7UWLjWZmEloYxppsl9h0CI2QpzelkZW704GA9sKCt/m/0BoqeD1uqEz3HDKw4+yZM
         AUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261452; x=1716866252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPE9OC+GQk0I6LRtpC2oK8ZC/gu1AchzTamw8jiTg6I=;
        b=c5FsqqtCjsJ/pHUNQF9gLnlGjWbRG8N1I0BNZcPMkWKY1KhoYGs/ZE+GJ8fFltAWoF
         vjnkHLwnQnGY3/zFOjJo8fPAhooqm1Ad8Nk/Y6jbZAJUb9fJmSugeoEfVGcHWgmMDI52
         igGD13a80tRy8rlbvlDlUy3YzN2R3UVUsap62i3J+n4M80VRBYCYociG0ToQ2CUk9jae
         4aRbw8RfwPQtQm3JViigk6jaz2mwyGsOgIrHO+oTEpTJDftkGZFAkYLIKbu8tOfAUJWQ
         h6eanmWVDsrHyx0N326+tPo+FzEgewGOIpdCAUHDJx2vK+zsB6h+XWMdLkwTSbKg3YYY
         oErg==
X-Forwarded-Encrypted: i=1; AJvYcCXiOgGYFRBbc5NiqlGxlrQSv7A1j7cT0jV4SaZ2HHyvbje1x6ZeMCEVsz8hhYvKuO4BO8KNGX4F/IWkLNHynah8ZEOP4pL2VU0fvBtN
X-Gm-Message-State: AOJu0Yy1cYe9kdMh9N6RPIkFMxwBBwXwtTQGNpVCZLhbY7PR8dNW7gA5
	8PyqE6XRyZRpi+gptDPLO4zdfVFcy1xhXfwOZYveNbeegNZSfhYBp6l2TaaECwJ5eG9+2wnudW8
	D
X-Google-Smtp-Source: AGHT+IGhvkZi6H3ProckbnUiRXtNCDkSP46gIyKASbmiGcRGeltnEGsRQDKagpTmcKzBrSYzXsvV6w==
X-Received: by 2002:a17:902:e741:b0:1f2:f954:d69f with SMTP id d9443c01a7336-1f2f954db9amr76401125ad.18.1716261452501;
        Mon, 20 May 2024 20:17:32 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:32 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 14/31] Staging: rtl8192e: Rename variable Decrypted
Date: Mon, 20 May 2024 20:17:01 -0700
Message-Id: <20240521031718.17852-15-tdavies@darkphysics.net>
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

Rename variable Decrypted to decrypted
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index fdf8fc66939d..1901a319316b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1646,7 +1646,7 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
 	stats->RxBufShift = (pdesc->Shift) & 0x03;
-	stats->Decrypted = !pdesc->SWDec;
+	stats->decrypted = !pdesc->SWDec;
 
 	pDrvInfo = (struct rx_fwinfo *)(skb->data + stats->RxBufShift);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 996662a06e3f..f69f4ca39fd5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -481,7 +481,7 @@ struct rtllib_rx_stats {
 	u16 bHwError:1;
 	u16 bCRC:1;
 	u16 bICV:1;
-	u16 Decrypted:1;
+	u16 decrypted:1;
 	u32 time_stamp_low;
 	u32 time_stamp_high;
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4c8cfa40927c..3afce436a5d8 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1025,7 +1025,7 @@ static int rtllib_rx_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	sc = le16_to_cpu(hdr->seq_ctrl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
-	if ((!rx_stats->Decrypted))
+	if ((!rx_stats->decrypted))
 		ieee->need_sw_enc = 1;
 	else
 		ieee->need_sw_enc = 0;
-- 
2.30.2


