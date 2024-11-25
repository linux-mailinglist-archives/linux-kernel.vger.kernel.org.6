Return-Path: <linux-kernel+bounces-421707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EA9D8EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D0DB2AE66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C81BE854;
	Mon, 25 Nov 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBGlj8S9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802D1B78F3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732575216; cv=none; b=oH1ndY1l907Ronal+22QRpltH+/PLuIbw31TV0qs6lPPUUNylbiqoKLiOXNy4IGfrrIdbfjDKjJN3Ynrcy7kvicpnCjIMYyjAYDc3TL1RmumYDeDIAgeA0wizFQGppKWO+NMeVW4xqE14n6qb34tHypOgzA9wMDya5QP+wihBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732575216; c=relaxed/simple;
	bh=z8d6Z5DoxDAN9pjge71M9GbAXIHRYZWcfYoQdcMTatw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFh2ct9f5wOrG4VR9qw6XbaqdAhXtzH3NB9NWUdkQv+WPm3jWJdfDYjpinJIYrEK7T91vL9r4/kBqvYU/Y+Vfy46SKyn+WxXAr+xO/aH9bJAXJk7dol8YDZBheChUyNAqCv7E+eNkgiZNmZ8nSWS13ECEVSYIZnOMJuONkOO5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBGlj8S9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so328712b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732575214; x=1733180014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sf0UnYlMfG0Zaof4x8glKBufQrY/Z6YuQPrhM1VLm6E=;
        b=GBGlj8S9Rn+gMNOfC2ZfCsVtnajoxK9s0NWZ0wkbcEvuwJQMZiaE6GU3Hov5P/uYpb
         W1BZUWC8p24XEt07gzCK52LdtC8//yFF9+XqoQEXYocG5PcqokDs6ws8xoVqSHxRGwZe
         dh+AgjMqVHCCQyeQ7SmIQnrvEiEA0JHsoWIsE7hit0qeOfRWtzCFOuoMDrSVwgeJ6bjd
         wZsl/XAzoAEvrJ4b9/jj8QRt5DRFvskumuhguSpSY7wuB5H+ytKfLX/4vG0qhsd3VFef
         9I0Uh6DnAXP9vPYAAUFsz5IUW4hNg1FBgeHSOBOmKuJCvdTLQsFnwDfBEtus7Npn8oar
         J0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732575214; x=1733180014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sf0UnYlMfG0Zaof4x8glKBufQrY/Z6YuQPrhM1VLm6E=;
        b=ocIJs+n5yj/G7fkky/Usjsur+auzwp7mWtSp+ex1gWrnaarq80UZ+EmQ2WOyPoG1F3
         xR7TrHrdGXif8XDgnOntnTijJR0TjpJiFOg5mvqiBc3h2/CynnR8d4PZwH3/7OEEY46L
         8aABiXicHn3xNDSm/H9Ju05Us2FlLsh2WOQlg2pp+1tZcl8OrG1V5hKNM5zzMVN1Bxkr
         wm3n3PHJhfFSgoO8oC0raTKrg8WU6bS/l2Mo0EQccvloXwsqyjEvKMaq741RWOVRoYXz
         rM7EAarnaCHdZWvSYNT0l+gmAx30cwbNhVYT8yIqsHxS6zxAPxoKnD5cz86zdsc08gRi
         +/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXBXRnivPUm6tpxczTXKMTwSFXaCdfYWGs//tDkNvnU+x4zvXYQY7a9yVOobpemXTZenNKa1iLj5Yr6d7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1H9+bNcLFFSZ4VnWqgqR9/ppaJibVjUaWc/7lljefnjarEttl
	YR/tMWRHLk8U9wI6MAoksRGQsjU8rO6ZioCVKi78TqyZSblv4bSP
X-Gm-Gg: ASbGncsXIUBOoicQwV/FXmKsQ+rpVE0e4alhmY80DlKLvjk8nZAD9W5pMCB5MVztNLJ
	gWD1H4rU2v6nki6x4XPZmbf8wae+OxwLsu/rFP/IFmji5A/GR4OewXWXd/Lo6WWjqJSiaLOIYp8
	NXAp6NqozW8NMjOqScAvvxUqtDlHiHKap7girjdE60ZgnRi7XlD1f9iyhNRtatMLVAhz2W/xcCX
	LuQCn/Vuhcxr7NOFvehl/QPwJhWLDiImPvYgd1NbgVri0Lxzv+Aj0j9WLrGcqnyF+vEVgIhZA==
X-Google-Smtp-Source: AGHT+IHPTH0aVJf2SFTOfQ/+2jgplaOyqlz3jX+/P6YUgcDzTZb1h4bhyPQfRMIO4wKu5X84qgqA/w==
X-Received: by 2002:a05:6a00:2d10:b0:71e:2a0:b0d0 with SMTP id d2e1a72fcca58-724df645b70mr18260344b3a.13.1732575214183;
        Mon, 25 Nov 2024 14:53:34 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724dea69e96sm6977544b3a.73.2024.11.25.14.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:53:33 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix broken code when cflag is used
Date: Mon, 25 Nov 2024 19:45:04 -0300
Message-ID: <20241125225308.8702-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using an extra cflag, DBG_RX_SIGNAL_DISPLAY_RAW_DATA,
hal_com.c file doesn't compile.

Fixes: ec57f8641fbc ("staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.")
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
As noticed at [1], hal_com.c is not compiling with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA due
the changes at [2] (a few statements were not replaced with the new struct).
A little discussion was made at [1] too about how useful this cflag was or if
the code under the cflag should be deleted. I think there is no harm to keep those things 
as is since we can easily fix the error and someone might be interested in using that
to further debug the driver.
Tks and regards.

[1] https://lore.kernel.org/linux-staging/f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain/T/#mffa281a89e67c609db9b125878d5b8d090776812
[2] "staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.", commit ec57f8641fbca07bbb61a75bd4760fd7aef86860
---
Changelog
v2: add missing commit msg and fixes tag;
v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 95fb38283c58..63bf6f034f61 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -906,7 +906,7 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
 	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
 
-	struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
+	struct odm_phy_info *pPhyInfo  = (struct odm_phy_info *)(&pattrib->phy_info);
 	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
 
 	psample_pkt_rssi->data_rate = pattrib->data_rate;
@@ -919,8 +919,8 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
 		psample_pkt_rssi->mimo_signal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
 		psample_pkt_rssi->mimo_signal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
 		if (!isCCKrate) {
-			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
-			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
+			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->rx_pwr[rf_path];
+			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->rx_snr[rf_path];
 		}
 	}
 }
-- 
2.47.0


