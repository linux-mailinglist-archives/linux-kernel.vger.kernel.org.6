Return-Path: <linux-kernel+bounces-559048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA66A5EECC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234653AA4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461CE26560D;
	Thu, 13 Mar 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="FdBxu3P+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4048264A81
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856491; cv=none; b=Wmk7CDM/oemzz2L+ZdG+qlARkQLn6HCnnoJlMJmV1wDUlbsX6iqwCjkTVLZSZ7mXpz00h9ti/kasM/vJ8W0PuRj4iRvsUTv0Z7jIJXHjPgwp7L9RZPZDEa7FpckRXcgD9IEsgcFim1hBGzMqgS7MdVfYfNJ/hg7tEoDznvXxomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856491; c=relaxed/simple;
	bh=oLhlWw1tOovRHEGC4gsbi6BHKYXLNDYOrtVP3tTS5nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=baAfN8drFOEwQR9LVuWoVsd3jkMbQECK7Zuc68EzbbJwM4Zb0tbziTk1vvqED+f9JPOMbjRyjvV1hvy3svqZr7OuTZJdSM41D+DsbHvw0jEhaRlKwzpLWuOn9lu56ahcAsvx4A4JRawEK90smoYpejhxkdlSrxqRBh1ey3RwmQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=FdBxu3P+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so2084981fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1741856487; x=1742461287; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uj7GGUjO2Cb2hoHrzMda/fIIQwFl12ddzGuw5jrHW8M=;
        b=FdBxu3P+gf3qNd4jxSOCYUJ1meLFYAm0ou6lnEyomeeXDBFwITM6FM0cgBdXgmkLWZ
         ZKowNImwE9FKqNGxpg2tZ4obR9aM7HzzkxV3TE+1aIiocbr/5xyXQU+/AUvaM3vui/8d
         SFiwhX9FwFKdrYi1Og4XFD2aBhA5Fzp0U27grJYGTLchEfkr9Om43y3vZ7w2ENEBU0SO
         7NFmSwx7BmflIybP2sGCUzjacGQzzec0zz256EY7GpZH9r19jgWiCe1YGWdlxDaRhWze
         xV4okbZKydpYlUU/qGsgn23cRQuFCvMobvfkmTwsGYwlN4bAzq/cHw83YEFrUzYOngZK
         z7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856487; x=1742461287;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj7GGUjO2Cb2hoHrzMda/fIIQwFl12ddzGuw5jrHW8M=;
        b=rPjgN7dhr715MwolZSNMNO7G8WVh7vF2nbGC1qPxTb19GZWYvqI+xcyTxawfqrOm3q
         N7G3E/BIPJABjTBGH2MULoHTCjPINbMKJdWqWQe8p7EfaCcDbIZigvDdpZIbZ61tU+oE
         MFS9yZBfD6lADLuaObECVX1C7zd+2zYOdUEq55PsH4pJW23UtUn/bubqmmeTlTR7GPWu
         3rzMjJinh8lD5ljM1VkCC0yvPh7C7tslSld1doY2eeTzIglmQLA9Kz/aQobFvyj50WMP
         AnTa80Q9ZQFKoRifusEMzcmE0mYGhoo0JQQ7VkUwaEhf8fAMK0SQeCxTjp4ltKphsqgq
         H2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcrOQJ8ZnUcgskcjyEMB9tyc34AriIw8rTf21hoCNiEh/iYcMK0C9qiTSHhkTmO0JGuoBL3AFH6h2FpFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++h25ZAOyR9iPDed19/sg4YFrvkMbzEVgX/+lJeTMxdRZR4ad
	i5ZVV0kgJIP2fXqZg6u1BX+jB5xjNW9iNZDFV2Qs6ezpbMjQ0xeKCsxqBIvg3+4=
X-Gm-Gg: ASbGncs7BxXrVLNi5l2CgeQHJ1NXdD6lyrAa5SQDEOkit+XVvl8j+b1aumGM2rYlRw4
	06whwSDOToHQgFH/X/BMxamiYP7pMv0Gl2BwCXmidjMA1x6w2L559B80Q/Vpr18TMN5QbfT5i4o
	o+fvomkwkDsqvz3mJpbqCPIPi+oUzH3pqPm7JiwQta2iVBNiYO70scUWGJH8i6exjoqGul4M0Xk
	gLj8DLFLsT24/Ig/b5dz9Cw/ae1OQUjyihjEaEEIREMKFHhH19cLYxsJmUZrjTTgZ3ggIQCkmtL
	JMShcmDI0tYzNZb8vnMTRkeXfUGl7E7hDhz7iH8V5hJWuEPhAv5BmIFu9KvSVhaW
X-Google-Smtp-Source: AGHT+IE2NulrNIo+M5vahinpDWyI9BdSgzdREdo+l0AN7HhcxOd01ZBOpT3HYFht1EVpKj5T7Edrrw==
X-Received: by 2002:a05:6512:ba6:b0:549:8f21:bc0e with SMTP id 2adb3069b0e04-54990eb1987mr9398593e87.32.1741856486697;
        Thu, 13 Mar 2025 02:01:26 -0700 (PDT)
Received: from [127.0.1.1] ([78.62.132.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88591csm142134e87.187.2025.03.13.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:01:25 -0700 (PDT)
From: Mantas Pucka <mantas@8devices.com>
Date: Thu, 13 Mar 2025 11:00:56 +0200
Subject: [PATCH] wifi: ath12k: fix 5GHz operation on wideband QCN9274
 radios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-ath12-wideband-caps-v1-1-23ac4247cd8a@8devices.com>
X-B4-Tracking: v=1; b=H4sIAMee0mcC/x3MQQqAIBBA0avErBvIsUi6SrSwHGs2FhoVhHdPW
 r7F/y8kjsIJhuqFyJck2UOBqitYNhtWRnHFQA11jVYa7bkpwlsczzY4XOyRkNqZjOqNcZ6hlEd
 kL89/HaecP+zWjGtlAAAA
X-Change-ID: 20250313-ath12-wideband-caps-24b281788dfe
To: ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
X-Mailer: b4 0.14.2

Currently ath12k_mac_setup_ht_vht_cap() incorrectly assumes that QCN9274
radios with 6GHz band can't support 5GHz as well. This prevents the
addition of HT and VHT capabilities for the 5GHz band. Since QCN9274 is
capable of operating in multiple bands, remove the 6GHz support check and
exception for single_pdev_only (i.e. WCN7850).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dfa05f0ee6c9f7356634ab55a6d9c0b4064645a9..aea3ad01b0671fd236ee70864aee4c1e65f564db 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6484,9 +6484,7 @@ static void ath12k_mac_setup_ht_vht_cap(struct ath12k *ar,
 						    rate_cap_rx_chainmask);
 	}
 
-	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
-	    (ar->ab->hw_params->single_pdev_only ||
-	     !ar->supports_6ghz)) {
+	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
 		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
 		ht_cap = cap->band[NL80211_BAND_5GHZ].ht_cap_info;
 		if (ht_cap_info)

---
base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
change-id: 20250313-ath12-wideband-caps-24b281788dfe

Best regards,
-- 
Mantas Pucka <mantas@8devices.com>


