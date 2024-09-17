Return-Path: <linux-kernel+bounces-331299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBD497AB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E455F28C196
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1E15C127;
	Tue, 17 Sep 2024 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="RbIDJdIR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E7157E82
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551126; cv=none; b=hEbC5QghFfTUd2jEwg5VzETIRTHzrUQBTtO1TtUoNFGVseRpfS7PInSUr5LT8Mk6z+5H9bOIgaY2EuoUOZr8YByOI0v3V2hU87CW8MFjUHFJDsTn0Sp01V8W/6kRjC42o/4a3+O0jNfVnvdCe2ATYtcRhpMhFspPkJUQHTYPutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551126; c=relaxed/simple;
	bh=Eu62Vsbi3EyTNBZNJGu7Sa5YurqV3OpEufb9wqPQ/cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8e7mty0s9WgJMTtauPlyp1cwTyOWOgQj8Wx8idXB0EUGVqX742MBPkUUEJFSDJI+6UZKzHIJ6l0i6I/KoQwL+aLj0Latu2cuWon8Vr4yI6sIg1uXQ5FKnY+OD3RuqL3el9aO7UIIwe1jidpBbNAqV+TVkX0DVIgI0Sow2Files=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=RbIDJdIR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71798661a52so3925619b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1726551124; x=1727155924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml5litkFUrleubbrzCJcFBZD2B+ZFOCAuPzHnKwaYVs=;
        b=RbIDJdIRAcUlTYYkeXPiGV7r5L6hOHNRS2h/6j5S9/8DQf/6Wf50/Gv58FWqjDTS+M
         YsfThmYtmn0fqotZCaDgS39OBGut7A00SPMibj4+JGHE3+SpKJ6ieWXdq+DBTiw58pmX
         Xr2nQzgBiJwIE3HTYVbsOOxv0c5JRXaJmQ87v1qzUeYPvyp6NnrXUuOsePM0gKh/m76/
         XLH+4lC1HCPDWkM31bRx/UddE8aP1BdXjweo3a7gBElvYfy2N2gUMzw1COd8Wz/wGLl1
         qLssyVIZmfI8zKjt1d0d4zjUPEmH4NudStskhxyZzA+k2OhRB6ZHs+U20fqEh+H315DH
         Oovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551124; x=1727155924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml5litkFUrleubbrzCJcFBZD2B+ZFOCAuPzHnKwaYVs=;
        b=aso4ItlMjmgD01R/l89q4zIQ0PLbw9ZUncD99rJ6HlUjzG5VITkk2JiDrKn+AyeTrU
         FCGsInZ1/BdiXqQU28mCDYs3HOwQkU+DM9tnXXomE1ctuFu0rWoUsRFxy8SiCzczpVPZ
         hoIx1jNK8X96LiQhoYXF7Kl9JsE5mTHc85iK26cf10oRHqnIELVduocRGjxR9AlxeJ5Q
         ZQ7WVYm2ys6iClyf5cd6obdv3vSH+7ekRdZvlvXgiyktp1ffWSlNY0jpSn4lHhbjqLPC
         sx6i2h4z1GQs+t4tkn2yRELt4jdA3qrmKxWkkRep/L5EPPjsL1aTQudu9rCN/rR0WojE
         bBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy5wptILK2nKkiy+1GSbvOBvLG3FiBcP+Q9+PyRhCXCJ3jtCE+xt+LcixMiGQvn+D3BcQsfxDATveT+og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvdev46T85vsQKCspLyZo6otIel6uLCSj0kdZHFcH3hNpjfIFd
	jVoOgVYOeJo7XJlZkFH9lc8feIR/6wn1KT8TYPYRsctD8D7Rt2g6+Wz+nB3rOSX3dIijIvFHeci
	+
X-Google-Smtp-Source: AGHT+IHLEyfhXWwIc3+AFaoigbKTGpCRVE9V+G7IG8vYEbYVxhLEAl6UAOPCNkVqC5jBl+0tX/1opw==
X-Received: by 2002:a05:6a00:2f9b:b0:718:d4e4:a10a with SMTP id d2e1a72fcca58-71907ea941emr35291301b3a.4.1726551124333;
        Mon, 16 Sep 2024 22:32:04 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e0607sm4392328a12.8.2024.09.16.22.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 22:32:03 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 12/18] Staging: rtl8192e: Rename variable bPacketMatchBSSID
Date: Mon, 16 Sep 2024 22:31:46 -0700
Message-Id: <20240917053152.575553-13-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917053152.575553-1-tdavies@darkphysics.net>
References: <20240917053152.575553-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bPacketMatchBSSID to packet_match_bssid
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 75ca921c8aff..873c749250ae 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1170,7 +1170,7 @@ static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
 
 	is_cck_rate = rx_hal_is_cck_rate(pdrvinfo);
 	memset(precord_stats, 0, sizeof(struct rtllib_rx_stats));
-	pstats->bPacketMatchBSSID = precord_stats->bPacketMatchBSSID =
+	pstats->packet_match_bssid = precord_stats->packet_match_bssid =
 				    bpacket_match_bssid;
 	pstats->packet_to_self = precord_stats->packet_to_self = bpacket_toself;
 	pstats->is_cck = precord_stats->is_cck = is_cck_rate;
@@ -1362,7 +1362,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	tmp_val = priv->stats.slide_rssi_total / slide_rssi_statistics;
 	priv->stats.signal_strength = rtl92e_translate_to_dbm(priv, tmp_val);
 	curr_st->rssi = priv->stats.signal_strength;
-	if (!prev_st->bPacketMatchBSSID) {
+	if (!prev_st->packet_match_bssid) {
 		if (!prev_st->bToSelfBA)
 			return;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c43d5b8298f1..4055c3044fe9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -482,7 +482,7 @@ struct rtllib_rx_stats {
 	u32   RxPWDBAll;
 	u8    RxMIMOSignalStrength[2];
 	s8    RxMIMOSignalQuality[2];
-	bool  bPacketMatchBSSID;
+	bool  packet_match_bssid;
 	bool  is_cck;
 	bool  packet_to_self;
 	bool   packet_beacon;
-- 
2.30.2


