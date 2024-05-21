Return-Path: <linux-kernel+bounces-184435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5B8CA6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF9B22BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153457881;
	Tue, 21 May 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gyDI/vb6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1B53390
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261452; cv=none; b=MG6gjJ5dNNGoe/BgE58igEoI7SPnj0PUy3iBHYZeKfdRAkm0vNej+NKu7gatnP517hPno41/79REFdWf/p6XO0B8cdzU41+RG3zCFZt+ajw05FZ2ITjnW3IZtEPOzlOPkyTRY0aJaicai1zYdhEvRhRzLgclKty8zThpLl4FusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261452; c=relaxed/simple;
	bh=gVS9SiiP3Jqr/gOO8soEZkMdLYajewLyAHFLwln8wjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+ZGK2KJVXRKVZa9Cjrx6iOOBF4JGhXgF46wZOrNQhaP21EbMwHvfh0jo2iL3MNsGcwX92hUstXIIu2oN0ShXf6SfU8o4ZkPfGujvJT4OuhxhzgxD00d827mfmxarK6jid59l4kDFpK05QqPNxsKSDziolaCl1+pvM/BJFuNjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gyDI/vb6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee38966529so24148945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261450; x=1716866250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9y3vOCZ0Z5C3M5gLdN2/bw89sLnlW10XMSKoOopYVI=;
        b=gyDI/vb63CC3nKQQkdioDSfBLne5eZ0YBqlCS6bJudywnkH6w8tf1qFK2MRs/foUH3
         o01/P+2nntC9SCzMNlQqSS+PkGlzhrDfYnMoFmNUZX33tiNGrkyYsCr1FCEHuv7Qp9rs
         Italx9SmkQq3GP5U0GF10kdez+S7LWcdnVqF2flyGCUuZNSi0/iB7GqTo3S0QbEQXA+X
         br6Okh96L/gjaR8WpgsVn2QhbV8XZYBtOT8Cvb0QDQyCztuDJ0/cb0hKrjF6IxC9BDPL
         QsJXSg3ZbMnA1sytHcB/Vlw2EtY6EPKOGEJjcm8gEdtGYhzoopSspBZvnZgEYC0SUsfX
         TOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261450; x=1716866250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9y3vOCZ0Z5C3M5gLdN2/bw89sLnlW10XMSKoOopYVI=;
        b=Wjk8Ky7PWJk5RYzL/gb61Pj2NAzsFm9FlIbULVLXZg7P49jpR+miXW5IwjM5SG9TzW
         ZstNsy3H7wNdOVqJNjXWJiXCoySqJ7J4K7/N1X4FB13nJ8d/G5PbN9C7GLTkD3s9ZOgK
         KorZHlA3VP98AleeO2C/txxIiA+w++xfMiEqB5dk+AkAf31BcRs4c30ne+F2Xr2uHB5/
         5RRuR9oJRiUOdhP87pJ/xHREBrrz/ry/pbpFGWU+ioj3DFrWFXVPxPIhpI2FSb8CMt6i
         EN2U8cIPqY5QodyuMPZoa3Eyj+QXKIntpJ8u+fCu5ngZNMI7hNjfssY/cMub5CU0Xjeb
         KW7g==
X-Forwarded-Encrypted: i=1; AJvYcCWIcMXSAbcl2xilo3vo1gdpSkbW6grU95dCMUCJVVLckrNI3Lz1qJuFzr4TdE4/9ia5AsDWEFLO2nnMmAxBMGFoEXJRgD37xNKQZDfF
X-Gm-Message-State: AOJu0YzCx16M7HqUIIJlLIAdQTOifH+C9KS4O6Rslf/53XoZFhPjr4fY
	x/5xLgZ7qEMRGjY4OcVCO2fqm77MLsz9RToZn729vWSroXAFQCMLCd10tLdyQyc=
X-Google-Smtp-Source: AGHT+IFjkVC8ANjXpaRvethnrKCdkYfNqHmoD7I5z11eexJoDDsjhzYeSydmfkHG3t7A7bSzHN/OiQ==
X-Received: by 2002:a17:902:a50f:b0:1f3:b38:aaee with SMTP id d9443c01a7336-1f30b38ac34mr18877605ad.24.1716261450105;
        Mon, 20 May 2024 20:17:30 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:29 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 11/31] Staging: rtl8192e: Rename variable IsLegacyDataFrame
Date: Mon, 20 May 2024 20:16:58 -0700
Message-Id: <20240521031718.17852-12-tdavies@darkphysics.net>
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

Rename variable IsLegacyDataFrame to is_legacy_data_frame
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4645fe803a15..cdb3ebc77a53 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -339,7 +339,7 @@ enum rt_op_mode {
 
 #define	FC_QOS_BIT					BIT(7)
 #define IsDataFrame(pdu)	(((pdu[0] & 0x0C) == 0x08) ? true : false)
-#define	IsLegacyDataFrame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
+#define	is_legacy_data_frame(pdu)	(IsDataFrame(pdu) && (!(pdu[0]&FC_QOS_BIT)))
 #define IsQoSDataFrame(pframe)			\
 	((*(u16 *)pframe&(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA)) ==	\
 	(IEEE80211_STYPE_QOS_DATA|RTLLIB_FTYPE_DATA))
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ea8cab9707bc..24136bba64b6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -882,7 +882,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
-		IsLegacyDataFrame(skb->data)) {
+		is_legacy_data_frame(skb->data)) {
 		if (!ieee80211_is_beacon(hdr->frame_control)) {
 			if (is_duplicate_packet(ieee, hdr))
 				return -1;
-- 
2.30.2


