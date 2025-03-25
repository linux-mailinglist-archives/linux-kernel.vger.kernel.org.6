Return-Path: <linux-kernel+bounces-574994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12BA6EC54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB98716904B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BD254845;
	Tue, 25 Mar 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biiqntds"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585B2F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893954; cv=none; b=mMYyaMAgSaGz8Bx1USaqazGmNaLexVt6873qY8X0FhA5tJD1+04vX8wGSOmwMXRIJL7fJb+nE2V85z4CW1J29jLgdM8HM/K4GehgJcpw4Pzpn3kgEAUVYTZHaLltJ2YeqJ3tFhUj3gnLx/WsqyeK+Pi6YUqPzhZeDdaSpCNEfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893954; c=relaxed/simple;
	bh=Y+R2XUXKPUXHCHG5wKcBEc2R6T2CDrGeZxqUGTT8EXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVIMRXltEA5pg6ab34qF2P2XWwVXBkazryt3Ci+o4ZTH8YdRe2B4vnGxO8foewoWcadheGmnU3gVzFDaVSEVMVtC6Aj1Mhk8MDbQZq753mw7xvcRuIyb2c/7C3NLQf3vXJMGIAxLGTyiQ3jiB7H+aT2/xjVBWNElVx+QIXHdsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biiqntds; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso48462795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742893951; x=1743498751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igKVCuJLDlRqPK4T2ULZyQbzlrghPqNKipcFpBAoGp4=;
        b=biiqntdsmd1p3e+weVnUbr6gD5SZ5Q+PGSQNe7NC9Ov2fOT8E5AUPznRHr8BcN6Y3U
         Ya+lztaaeZKmAr2V7ZGcCqJlLTlrnvtY1K0f4rlFCJjVT3QQJNIAV4M8PfJTYpplqbLN
         vGlMObzJbBMbXp0+Hhyi5MzUY8d5V0Cx+R/Mncjv92dLXigicuwEeNGh8TBUv+QCoasa
         FT5xBWwC8m36RWKRk8fdQfszFzItS0QgMZ5ZZTLumTMtGT9NjFj3hHzjR/HIN01nDttg
         aP5gbAPp5p24/IYOrrZHeomD/xHUFx1+4rE/3If13bz314FRuFTWfv7YURun6a5p29A6
         8EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893951; x=1743498751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igKVCuJLDlRqPK4T2ULZyQbzlrghPqNKipcFpBAoGp4=;
        b=wxvnxKbCeyRz+H2mqyRNeWcVYbPaJgfVMTZoi6g6/cb8pkVcSr6pmMiEUlu59S3woS
         zMkYfHh054YTlxc3KnH3ZhoUp3bPYUhCICxU9tVx4zI65GYHUVVQuZubKo/l+JP9V7O+
         sZ3IvUqsH3Rl/hkZAQctGX+pnwpYdNGTeg2h+F4o3YlfXu0rs8+663ligxnUQd6PuUvg
         kw8shFUKRoFhAnHC7oXW2MEAuzpu7TVbyhogYxxzviN/g3gX0+lSYAfPHVfiQZ1Pp/WX
         jk4P8x/w7VBpvwP5Cct/hYDJw+8kV6EooatYUK96LASXNw67LxMDJdkaj9CDSni9SzLM
         GU5A==
X-Forwarded-Encrypted: i=1; AJvYcCUeHCizjx/sx0QPqmwDubHvCH+HQB7KkJCZcoyxXeSaNeYIFWaXp/6dBOGjrrLlCADCDQPFTkF3yUc7q6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAg5CGOZHLDLC76fs7Or3jRCaOoS14mhu+6h9nFfzEDieqfD3
	dShZiq5Llyr2CRJO+vyU3+/tnaHUNbQ0DQ6npK6bO9b9BRvXcz7g
X-Gm-Gg: ASbGncsxv95v6T2EuY2gYGGiAdHakbs3YBht0If/ZONBL9AnTNI7ncb54FXx2yFdbyG
	b09+OhecuRxKrESDra/j6QIAW+ayRL1Zm2j3iuwZbn8CTt7PhtC7M46Fs+GuSHS1b75p+7YBn+5
	J68/Xuhy6Ige5VajKW3JXiCk4LzdAme6+pg3o3htDDWN2ldBjvV7JbLPEHqLK1r9ba4wNMomS9D
	HF2TMbiQiycpvj0jZ1PGHTtpGsUV5RxSuaE9W2z+eUPVXYTH+sdPKUPTHpSiuPrwGol44w4VNxj
	znO4o7Ij1q56Ck5tXg6UkNOex6BbYewCqZxcVwZVQgRb500zKOuL
X-Google-Smtp-Source: AGHT+IGleKR5b6dcwSh19AN+MK7Lis1Bbe772oF9njIxdXkUMy0EbYz85aMlNWr739QKERhf8IKk9Q==
X-Received: by 2002:a05:600c:1ca0:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-43d58c9a7b1mr120065965e9.11.1742893950565;
        Tue, 25 Mar 2025 02:12:30 -0700 (PDT)
Received: from pc.. ([197.155.71.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9decbsm144187305e9.27.2025.03.25.02.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:12:29 -0700 (PDT)
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
Subject: [PATCH] staging: rtl8723bs: Rename variable supportRateNum
Date: Tue, 25 Mar 2025 12:12:20 +0300
Message-ID: <20250325091220.38601-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable `supportRateNum` to `support_rate_num` to adhere to
Linux kernel coding standards by using snake_case instead of CamelCase.

Fixes checkpatch.pl warning:
    CHECK: Avoid CamelCase: <supportRateNum>

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 50022bb5911e..5124260602c8 100644
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
@@ -893,7 +893,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	);
 	if (p) {
 		memcpy(supportRate, p + 2, ie_len);
-		supportRateNum = ie_len;
+		support_rate_num = ie_len;
 	}
 
 	/* get ext_supported rates */
@@ -904,11 +904,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		pbss_network->ie_length - _BEACON_IE_OFFSET_
 	);
 	if (p) {
-		memcpy(supportRate + supportRateNum, p + 2, ie_len);
-		supportRateNum += ie_len;
+		memcpy(supportRate + support_rate_num, p + 2, ie_len);
+		support_rate_num += ie_len;
 	}
 
-	network_type = rtw_check_network_type(supportRate, supportRateNum, channel);
+	network_type = rtw_check_network_type(supportRate, support_rate_num,
+					      channel);
 
 	rtw_set_supported_rate(pbss_network->supported_rates, network_type);
 
-- 
2.43.0


