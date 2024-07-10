Return-Path: <linux-kernel+bounces-248130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D727E92D8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9234A2834DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66DD197A65;
	Wed, 10 Jul 2024 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Cw2QNhKs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E8195FE6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638088; cv=none; b=cgKUJmtkNNUca4l77DhyOw5EqOW4kmXGmwM/ScaaPGFmqPdfdRZl2vwJKuearrfHTrANyzmQXg3nhSWsKZsmD/iTT99uNxIPowBMxlY/VIqykl+9y8jktexFWzes4lOE4pFmWTghEdJ4HS0mCjIpfMmP5FScKMv/4kB2hxZCR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638088; c=relaxed/simple;
	bh=cxsYq/naaH5Uont4n4ooMO30CRSHMlCtlh3VbMmYBXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5pRbL0eY6/H1X45ipozXb4//CtE2AsItAAFsdKoZoHg2pr/tI/tM+2JSwyuLguuOGWJWsgh7wrbKdjRY/OzFXXvaAPl5LW73Z4zpwnxz3DeelDyYB1mIlLo8dcOKKIa+Vv3+xGpNnDtZXdX15uFudfnYagSmXWM6riTWVIuZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Cw2QNhKs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367b0cc6c65so1907f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720638084; x=1721242884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=COX3XkGudVuZTn/eMUc5+kdCw7hyca+yvKvwyEtbd4A=;
        b=Cw2QNhKs1IHFq6wbRKcCIONkViCvs0skYp2MTULMxB/Ok3pgFiu9vTKF8VvxhetmjP
         Fy06cjAfPG6gm3lfH5PljQE1PMzckt+uJrnTW+qJ90WjWt+A2MnljG+5slvFRGxSjdh0
         QGirAvx6RbZuXUTBVyA00tPAPM6naJxjgmPxR7pYXLCjeYLvCsT1IoxOGNP0Hz37Ce83
         pypSZ7qGtP/rG80zaFqrRd3PTyfz5enIAWza89Yh4rMNNHIWtH3/49NOZyJKgesgIGa8
         MsYKAi2cmJ1wDtg7feZtc8MZV51sKokKkf+2wg/s0ij8Ti65NgJrkB/WLohQ29ue38Bw
         L98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638084; x=1721242884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COX3XkGudVuZTn/eMUc5+kdCw7hyca+yvKvwyEtbd4A=;
        b=DE0sUwMIn4ZE6i+wYp4zxDYqDbelXaJap5g2gm+n/cnjNFGpSnMqu6UvYvOD/UQJtf
         flo86geURRX8/5l++CCgKIqOBENVSmKyI1ZuUkJEaILCHGZnIsE3gQTxNC3N0wdUJ9Me
         p6vjL3gK2AdJrzRKEJ7Hf+IbZoaNVp1EFX1sV+aXObCX0vkcMwERmor2SowbluaSe7LG
         wNL2IPLTiUEw8NwnTWCuN3LrB5e92wdghICw0HWACl3STQ8IX82dvjrkuOnMJbrabo6a
         INpiiwgi/hShMsm1eU6YN6cLwq9sN1ky6VmhXgZRyzBYxdQccDBG4vX5TWknorophCAM
         L8+g==
X-Forwarded-Encrypted: i=1; AJvYcCW+xkPKYWkbI3NZYAC4WfJcAIoRbea4lV8GFVkR2eyyOpD6u4ZRZN0fM587wJDifbxsDgzIYukwJsRkrchl0gWtUrvtr+zncuHCtcmr
X-Gm-Message-State: AOJu0Yx0hRGoqkN98oWWShtdkqhiLzQDBWVuzEzL+YYqjd8CtOqkrXMP
	fJ+EdA37Q2kiZIoJ69f82CUiHRsjFzGbTCNqVcDAlWUd5MJPgi9rMdTYYT1C0Ws=
X-Google-Smtp-Source: AGHT+IHinMImnGMgYVPwjbcMEexhVVdiGpPM1w0iQzMat4MsloCwZfdxt46dPYoseAM1KbR9jAHOog==
X-Received: by 2002:a5d:4947:0:b0:362:2111:4816 with SMTP id ffacd0b85a97d-367ceacaa13mr4166962f8f.55.1720638083863;
        Wed, 10 Jul 2024 12:01:23 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm6006328f8f.21.2024.07.10.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:01:23 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jes.Sorensen@gmail.com,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] wifi: rtl8xxxu: Use swap() to improve rtl8xxxu_switch_ports()
Date: Wed, 10 Jul 2024 21:00:48 +0200
Message-ID: <20240710190047.709843-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the rtl8xxxu_switch_ports() function
and improve its readability. Remove the local variable vif.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 89a841b4e8d5..489574668772 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -6679,7 +6679,6 @@ static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
 	u8 macid[ETH_ALEN], bssid[ETH_ALEN], macid_1[ETH_ALEN], bssid_1[ETH_ALEN];
 	u8 msr, bcn_ctrl, bcn_ctrl_1, atimwnd[2], atimwnd_1[2];
 	struct rtl8xxxu_vif *rtlvif;
-	struct ieee80211_vif *vif;
 	u8 tsftr[8], tsftr_1[8];
 	int i;
 
@@ -6745,9 +6744,7 @@ static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_BEACON_CTRL, bcn_ctrl_1);
 	rtl8xxxu_write8(priv, REG_BEACON_CTRL_1, bcn_ctrl);
 
-	vif = priv->vifs[0];
-	priv->vifs[0] = priv->vifs[1];
-	priv->vifs[1] = vif;
+	swap(priv->vifs[0], priv->vifs[1]);
 
 	/* priv->vifs[0] is NULL here, based on how this function is currently
 	 * called from rtl8xxxu_add_interface().
-- 
2.45.2


