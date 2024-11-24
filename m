Return-Path: <linux-kernel+bounces-420273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3989D780A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 21:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A71CB21C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4114B06C;
	Sun, 24 Nov 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUCfXwG8"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B59291E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478996; cv=none; b=rBiubXAPKjX8X5n3xbyYlMERjb/9MIuFrm8+QcAkQKOH7v+GFGHAfKj+tGJnF+lCv+I7H+sRzCYrGwhlvRyrIGHUfWGJdmHgRXDo/MmY41BY1EgXffUjS+i4cckxVDA9mrv6tgCn/MNSQGqE+Bmv6gJjvE/sMivzyy4NS3UU6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478996; c=relaxed/simple;
	bh=hlqPQuS8ofAYpPfraJUnreUPZH3D1P/2FWLM9df7BTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewlLzUsmx9yRiV1syulH92wAKvl6u3++GBLyovCW6jhDLhhYogK54EppqQaKMZKsaCgWIEqnXaQvVoLIY5Dcbfq2bDsv4kahCHwUpG57fjsYYWRqbSmKLABmY38zIpvtNgkkEaClz4yFRFR6W5Lr0foNvObWzw5xqvdSWahxVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUCfXwG8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc340eb006so94222a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 12:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732478995; x=1733083795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Garqcydm6d6hOSEnkqfwcQpL+EyitpGGI+ocpotqa4c=;
        b=hUCfXwG8Y3DE7j5IVpc52p7C/9T2+BPiVPnFBb1ITQUjssi7wTRmDBORfH66hfFS30
         OwX+EiIbPoYe0N36pTKaJtsgSXa1O7XzRVrN4lgIrQei9cCVbXY7hXoahLaJOe2mcQYe
         VMiLkX+17LXHlPlut42bwFDFsYpU6CdYRuTVgeATmU0kaAuFeEuE/P7TLPmC4nRO5Yda
         x22cvle9r7hS3zxAU/BUQJDivQeaOKQg8AnEnB9B9Ra50kk6pAtxdvkOvhsoCHm8lqRp
         VeBlp8GneMlNTISyMZM69GbZ5vTWknPmXEfluH02zR/UlB4PEuuu1AzOIda4XwpcTyyH
         9qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732478995; x=1733083795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Garqcydm6d6hOSEnkqfwcQpL+EyitpGGI+ocpotqa4c=;
        b=TXklE/50FIEpJP9WwL7JviTgcFzDd3XP/Tq9VSEYnqhygxpBmx9znACZe+A5XpqUwT
         AoUJAORAkkcL6ZpG/vfiyrWqiDY6fUd+gnv3ayvNwLmX4TrIQENakV6jfxp4OC5U/Ukq
         P2BtsbcOISGrrkNE3R+kWiCwP2atOHKT5rAyAlh8WS52kO2dQ78fCN54XOxl5t8mFqWv
         IcZsnt1ZUfFyjRtoV0jyKRw8a2u89RM7tVsoUjvPGdv3dKeaMqACSGCZdyObqlMiP2gA
         Xs89vkj82cIoBQgrNwbWI7wrThrzNjUY8zI089ctWYBva9T32l57Tx/pEiWBxqDUX5p9
         4/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWAKSUm+96C85oMVm1KNHDLZta3DzwfXdnSD0NiW3QZe0b3iO100D8yeAl0QDbGbdZHStKee1rehB9xeg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PyoFxZfQ3LP2eyrsbV0vo2ywICKIvzC/iTt5TNrxR1IWzzye
	S8N4/qZzWbnj/IpKVbqGtuYaKU3R5Pd5LZ6R7xUKzsPcWnpO8Wpy
X-Gm-Gg: ASbGncsXIEY8pas8TslLCL3k6TScm3HiF7vrPHUTAa31a023A0d26yDG3hnSBppGWS1
	1CwKRmJ1YqyB4QS3OioKanR7b2fGUqEqop0xPTmv1JSWb2cEIf574Tqk6aWOYcbkMcoOW5Xj7z7
	FtLItjYXxAA0DqBoapIDPkD6M6HLJocoSbl9Us1DCbbybB6ITloYPQ2MzX6n24kz6eCYn+lIysw
	5mZUJ3BfwWro/844s3324abBfYHDUUuPhVCvLjR3yCHfworSw3wWDOm9gESke0XmJgTPW1FiA==
X-Google-Smtp-Source: AGHT+IESq8ReY8EvXIJVDV9iY0yFrIx8i65dKaW8cXabuqo6IeLRwhk4vuvzztkiAP89nQfKLe74FQ==
X-Received: by 2002:a17:902:d4c4:b0:212:f64:8d9f with SMTP id d9443c01a7336-2129f7c1228mr157928095ad.32.1732478994603;
        Sun, 24 Nov 2024 12:09:54 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba22afsm50280195ad.73.2024.11.24.12.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 12:09:53 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix broken code when cflag is used
Date: Sun, 24 Nov 2024 17:08:22 -0300
Message-ID: <20241124200934.156252-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
As noticed at [1], hal_com.c is not compiling with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA due
the changes at [2] (a few statements were not replaced with the new struct).
A little discussion was made at [1] too about how useful this cflag was or if the
code under the cflag should be deleted. I think there is no harm to keep those things
as is since we can easily fix the error.
Tks and regards.

[1] https://lore.kernel.org/linux-staging/f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain/T/#mffa281a89e67c609db9b125878d5b8d090776812
[2] "staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.", commit ec57f8641fbca07bbb61a75bd4760fd7aef86860
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


