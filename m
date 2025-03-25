Return-Path: <linux-kernel+bounces-575230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC50A6F6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD4116C088
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41E1DF72C;
	Tue, 25 Mar 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZuvQZo0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2E433A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903169; cv=none; b=AR5Wl7rR8mtw9Vm74HTArI7w4I4X4RNN0V7OkFMLDxelWE3fKOhU7R6ZymIKZQp5j6BtRkBgqevjEs2bu4ui/N8KD1N4nUe7os8DDsQ5pj0T1oSEVwqrHQx7ujA1om0mMSlS2L9GD3RhAVEe1e6Tn9+06sIdgEvRliMrrsMOwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903169; c=relaxed/simple;
	bh=3I6YOEEevm7Iddu9Wu3uhmlaf4D1s7KW/SvZf1lAK98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc1ndHhH0zkloCl83r2piWt9Gh9THz5NTSxUt48LnNIB3seSPMsYClVHdrYfWsfqbvp+vr9U0Akufqgn7YQRnff17+IWIvHk6KNvlzy6fnjHgw4rbZVTeQEr1M1pNE+6hJKdwq1x7FjhsHCGfYd74zayVkve6KO+xs6pmPuVdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZuvQZo0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso58912835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742903165; x=1743507965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QM6yckbMzLuQtYcD19Hf+kaqNYJs8oHRxuA6VUZJjFY=;
        b=VZuvQZo0regIewOmEmcqDhJ8v807sBkxtWTAZ/VPK3VBGnZSQBPLi5HbJY5cf0ragZ
         9DTdLaUFqCiYKLyzV9+8Elzb8LnUIaHSg4nTCla/szo1PNRkE7IO2QMIx0/QhYcPwMSZ
         xLPlu8HI+Ob337ZlDZ6ce7S1nYisWQZYROpIoAb3dnBrhF57LvOIOAS/4GiGM3iU/Kcq
         vYpuYG0iDcrOq/FpagazYq9046bpZ0IgCGP4O+hsBQaeQpP5JFmjImoJxGeKoJkpP3aQ
         C7qXxvhu0zcGi/LMiDSQGMi9+W4WfVlkSsmE1rOFZKafwRPChp4/Iuqjd7vrW5Ip+jeA
         kUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903165; x=1743507965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM6yckbMzLuQtYcD19Hf+kaqNYJs8oHRxuA6VUZJjFY=;
        b=jFNu1JYa/bEQQIsZa2YkSaORLbpbH/J7xxhXXzxOSPc7jVxFpuS9QDOLV+Or8wFd4m
         oS8PzLJ7IJNwixOzZZAvOATBxn49LQ+tbPA/jM7PZ96Te1p7+vxDnlf1PZh1RP9JZ5Zx
         Gxm0E8z0p3iWru+1HkgClLO2FYCM0N6F0ibquNfF/ekml0n6X6pxVdGbHlnIM5Nm5yxG
         L1YYgFqr67PzC0bRvGCEmUiKARhHGyMRZhHUZBqZqTYScOCscaxltgzwIQ4A7l10VQds
         tRhbKP92l0vjcsWoYijbNGlzexA9KqiDVhgsIXSFl7EfahSrOpHJ4NHsdM6y6KmLXNw8
         TmIA==
X-Forwarded-Encrypted: i=1; AJvYcCUibnkqEqWHqDqgWmnZwoi7SM/hJ4oLl0AYl0/kyb/+aOw+U8Fit9q6SfBP3Xfj08w++uKrMTWZKkj00wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZJOhQCEXj3ca3oIUIWssfgs+RjRzNyKQgqqiymlip/WKpZAT
	YR+LcgSWOEx6R2cPrxPKHrfAd1NCR5mEVZ91tHOyW8AARtCl9CUx
X-Gm-Gg: ASbGncvkmUrtXQ1TO+JlatAMMs9SQMlJ85JxdUegMcYghRURHYB0IRw2B0Z9viXSg2S
	WR/ozi7BvhtcP+QFOHJFX98QALKi4hEkZOkFra+g5BQBVr+9/5SGo8TwWNh7sB4n9SZkLQuwKB+
	8gCBoiOKR5sNWoWOnhLqn8aqjsizJE3sZKl7ZDNvrjIwfTy+VFgYwHFK/oKqrP76R1Z9xxcpnfQ
	lTJrojOQ/LvTkxOFqyXzXTXwZJC8UgpJwCAvdBs7G55DfKQLzhkYPS/byke3uZfIv+rWFY99mZE
	qqdinMy+lrBMaz9lTwFRyh4UMDpDo2IjpjIyyLng+w==
X-Google-Smtp-Source: AGHT+IG1gg+2VMW6S40TL5SGmizmMHwcdq3j/bUWa544XwDYu50O4TXneCJnlGDTs3FUGeIlvjDRfQ==
X-Received: by 2002:a05:600c:4e41:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-43d50a3632emr167118635e9.29.1742903164542;
        Tue, 25 Mar 2025 04:46:04 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d6ddf2974sm12782885e9.0.2025.03.25.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:46:04 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: gregkh@linuxfoundation.org,
	outreachy@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	davidzalman.101@gmail.com,
	vivek6429.ts@gmail.com,
	viro@zeniv.linux.org.uk,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: Rename variables v2
Date: Tue, 25 Mar 2025 14:45:52 +0300
Message-ID: <20250325114552.45393-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable `supportRateNum` to `support_rate_num` and variable
`supportRate` to `support_rate` to adhere to Linux kernel coding
standards by using snake_case instead of CamelCase.

Fixes checkpatch.pl warning:
    CHECK: Avoid CamelCase: <supportRateNum>

v2:
Fixes checkpatch.pl warning:
    CHECK: Avoid CamelCase: <supportRate>

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 50022bb5911e..d46a04b9a05e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -370,7 +370,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 void update_bmc_sta(struct adapter *padapter)
 {
 	unsigned char network_type;
-	int supportRateNum = 0;
+	int support_rate_num = 0;
 	unsigned int tx_ra_bitmap = 0;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -396,9 +396,9 @@ void update_bmc_sta(struct adapter *padapter)
 		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
 
 		/* prepare for add_RATid */
-		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
+		support_rate_num = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
 		network_type = rtw_check_network_type((u8 *)&pcur_network->supported_rates,
-						      supportRateNum,
+						      support_rate_num,
 						      pcur_network->configuration.ds_config
 		);
 		if (is_supported_tx_cck(network_type)) {
@@ -817,8 +817,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	u16 cap, ht_cap = false;
 	uint ie_len = 0;
 	int group_cipher, pairwise_cipher;
-	u8 channel, network_type, supportRate[NDIS_802_11_LENGTH_RATES_EX];
-	int supportRateNum = 0;
+	u8 channel, network_type, support_rate[NDIS_802_11_LENGTH_RATES_EX];
+	int support_rate_num = 0;
 	u8 OUI1[] = {0x00, 0x50, 0xf2, 0x01};
 	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
@@ -883,7 +883,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	pbss_network->configuration.ds_config = channel;
 
-	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
+	memset(support_rate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
 	p = rtw_get_ie(
 		ie + _BEACON_IE_OFFSET_,
@@ -892,8 +892,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		(pbss_network->ie_length - _BEACON_IE_OFFSET_)
 	);
 	if (p) {
-		memcpy(supportRate, p + 2, ie_len);
-		supportRateNum = ie_len;
+		memcpy(support_rate, p + 2, ie_len);
+		support_rate_num = ie_len;
 	}
 
 	/* get ext_supported rates */
@@ -904,11 +904,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p) {
-		memcpy(supportRate + supportRateNum, p + 2, ie_len);
-		supportRateNum += ie_len;
+		memcpy(support_rate + support_rate_num, p + 2, ie_len);
+		support_rate_num += ie_len;
 	}
 
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
+	network_type = rtw_check_network_type(support_rate, support_rate_num,
+					      channel);
 
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
-- 
2.43.0


