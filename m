Return-Path: <linux-kernel+bounces-555361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D4A5B662
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10560169354
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E51E32A3;
	Tue, 11 Mar 2025 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l30i7Blt"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3141DE2DF;
	Tue, 11 Mar 2025 01:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658251; cv=none; b=ZKBERJ70WnTh73oFS/7Sau14IlBKKLfPZLnq84YhbwAHlOpxO4AI9+5idQSdt0wSRoiBsRM0ZR+D5t6SJtxCHGv6CTxR6qW0zmcO3R/2s5dheKsF8nY/a8jlNAkpjXOBmdUDG8Ffs4Xi5JUNgd+vZjGKA6tPkrV2ckrCm6bZ7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658251; c=relaxed/simple;
	bh=LhI04fpHljjvVrHkByXaegpBqu8dEZSJzh7TmUwOtGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NOMmqiqVFsT/Vo6V/yryPRwMaBdJj55gQEthWAa3Om7hFXitJFGb5ayHjgVBwg92bSMj8M9cNV6tvZj16KMhKYc1C8ux7q/CO7w6ooUkEFD52mKaaDtwM8M8MuF6OjhcIHR1WCZG7lMhFrCcH7N6sQM9MLM5006Tt7Jyhew2iDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l30i7Blt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0ca5e6d45so61413185a.3;
        Mon, 10 Mar 2025 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741658249; x=1742263049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTbA3z1waEv3baccpL2pucmVyLthoa4/pOBPjlQqSNs=;
        b=l30i7BltCwzdY8mjrni15CPWT+2zNkcTvhz85ZFGXhmIKNpenc/8zbqrlKRtLC8XIP
         UzOUIxxCBhckTc4gppoKALG9NlDT71tAcO/GD9qtpQ9XX+bQS1Phlt5062qfBTUjmCJL
         0M0Jh9CtQOc+UvJn56CVJM32X9Wg4j6Espw9V2XiUs+G76xVQIFDqi/xGx8ZhG6neCpE
         SfW1JADPLPtOgMGlbWCjpGSJ1e173pCRTpNF67BBTmSQJ7QNR4jhI3eBR1j0aeoPzSRU
         jS3VXsvRIYjDBZhI8O6xVwSfukJnYzCkLILdbgFLjBWM/GXcOfLUFuTntZ4UXKyJA98n
         Yvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741658249; x=1742263049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTbA3z1waEv3baccpL2pucmVyLthoa4/pOBPjlQqSNs=;
        b=eE7SiMfM1P7rh0Yw7rkt/QGzZgbeiWM2QYmhYRs0auRtirmn8+PgPkvY8eTGZ897JD
         Ej6fHsBC7H00SGxtDKvzOxfhr9D3G9LutkkdNDK+axu4Bn5DurYbrp393Vo2KiX0tlI8
         tM82A8AHv7ivZJSDelN0BeWgj754nPLZvygoANfrgGmuPtXVS14leHvaHGUnPgL5OTs+
         wfrzXaZlUYtXQcV6C4mBCbQwo5TKNts6tQzup8Xykk+NCaBcBZdyZQTu2Nuw+7siz+d8
         gkrHo5OaRWnjnaeNNEG7yASRi1DBI81d9gpie/ONZqCCfjx5nQxDvaxYqZrUT9417H6D
         cpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfcy9mZH3WlKbKlxCxhsFu+mOd/02d+VMyRtMd0ILpEqy9orifxdpIL2rmyg/53MrZp2iv9oKNDb6R7Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3sbYlmOkOfsj5pXNuwXxrJCvc8mCcVykxCsOiKbyU5EkwMO/
	ChZhEkzmUxQTKfDmIDsRTH4DX4GC2FxEBe7yNT1m7Fqhoixh3q4=
X-Gm-Gg: ASbGnctmYPOL25b2v8cRa6l7N6yZs0ZV9Fmx5rPoSiW61p118m2fHQFACQETwpTv9EV
	ZDyXeeEQU0JxuIYnMWtlgml9Y+7cMYGJI667sEeU1GovZg+gEjpohzg01RwL2GW4oA5cRGzzds6
	zX56hOhGG9/SITwSNLqFtzjKx86NAuE2jHjrSd4T3J2VjpUlMGEeOduklGWTh2kXO4KBSr3H0r8
	KnWaX6iGqqK9bjgeIlBroC53gzbBLuNBlMmcRjv0wINnLT7VUNWLw5gWo83WdKB5VqdJsQ6m4gC
	yQWgw1GqVDr4Xhttv8CxeqsWNliwYcbaH4mjQOBaPw==
X-Google-Smtp-Source: AGHT+IEH2yG3+uT9AKJtKzCvKDd+IFYDwbaaQYjMIVYkhz9uuPvtonSYiFVSxKy3hH/up0CxQg7u4A==
X-Received: by 2002:a05:620a:17a6:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c55e93de37mr123349485a.14.1741658248936;
        Mon, 10 Mar 2025 18:57:28 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5479ff0d3sm399256185a.29.2025.03.10.18.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 18:57:27 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: kiseok.jo@irondevice.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] ASoC: sma1307: Add NULL check in sma1307_setting_loaded()
Date: Mon, 10 Mar 2025 20:57:14 -0500
Message-Id: <20250311015714.1333857-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All varibale allocated by kzalloc and devm_kzalloc could be NULL.
Multiple pointer checks and their cleanup are added.

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 sound/soc/codecs/sma1307.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 480bcea48541..b9d8136fe3dc 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1728,6 +1728,11 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	}
 
 	data = kzalloc(fw->size, GFP_KERNEL);
+	if (!data) {
+		release_firmware(fw);
+		sma1307->set.status = false;
+		return;
+	}
 	size = fw->size >> 2;
 	memcpy(data, fw->data, fw->size);
 
@@ -1741,6 +1746,12 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	sma1307->set.header = devm_kzalloc(sma1307->dev,
 					   sma1307->set.header_size,
 					   GFP_KERNEL);
+	if (!sma1307->set.header) {
+		kfree(data);
+		sma1307->set.status = false;
+		return;
+	}
+
 	memcpy(sma1307->set.header, data,
 	       sma1307->set.header_size * sizeof(int));
 
@@ -1756,6 +1767,13 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	sma1307->set.def
 	    = devm_kzalloc(sma1307->dev,
 			   sma1307->set.def_size * sizeof(int), GFP_KERNEL);
+	if (!sma1307->set.def) {
+		kfree(data);
+		kfree(sma1307->set.header);
+		sma1307->set.status = false;
+		return;
+	}
+
 	memcpy(sma1307->set.def,
 	       &data[sma1307->set.header_size],
 	       sma1307->set.def_size * sizeof(int));
@@ -1768,6 +1786,16 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		    = devm_kzalloc(sma1307->dev,
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
+		if (!sma1307->set.mode_set[i]) {
+			kfree(data);
+			kfree(sma1307->set.header);
+			kfree(sma1307->set.def);
+			for (int j = 0; j < i; j++)
+				kfree(sma1307->set.mode_set[j]);
+			sma1307->set.status = false;
+			return;
+		}
+
 		for (int j = 0; j < sma1307->set.mode_size; j++) {
 			sma1307->set.mode_set[i][2 * j]
 			    = data[offset + ((num_mode + 1) * j)];
-- 
2.34.1


