Return-Path: <linux-kernel+bounces-184436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B758CA6E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C4FB224C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94196A8AD;
	Tue, 21 May 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="BnY0/bGq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AD5674E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261454; cv=none; b=sgr+Id5pFR2l+itZglLhNvhxhlxi8B65vkW2Ign9qN41VQYt3e9FvPjtj41htitqxwktIvNgtCDUJjKOG+8oadcIuLbKu6Mjx2m0d4/6t//+DHi99kMl8bwTDsneyVVfGwijfatyNaXR/GuKdAhMKM7yRPh78oSTKHdm5HpnlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261454; c=relaxed/simple;
	bh=4zQZ/o4OTAP1Q63eyDdLz+A695cMhyvRSK0keQfQf1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9hLY3DXASqj5OGoS64EAqxoycysBgrjT0piQP34/0wotsYYeBW8PAaiS85FDrIo1IqctMlnwk541Seww5JPkFiyHVxosP4xTDWg2LinuJgFA3/YJiRHturYc8OML49qFIGS5hyb8taophwG/V6EcbOV1eY/SWjbzXQ+We+HXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=BnY0/bGq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edfc57ac0cso96079365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261452; x=1716866252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NY82JNhe1Lcp3d6UGeyI0G7Bbb4dBlKnBMAKZ+t4Vw=;
        b=BnY0/bGqtrkci0HseOWontANHEq9XcJKJRfsGl7MGQIziyaFl8dnT2VDVyCvGKY9zl
         J3GW2QZ3QNzoY9hWag6itrvk2sM8vN0j8xRVxepWVZQrqerUiZNKQsLVeg8V4RvFZPS5
         j9ZWVzKuf7nk5tV2jnqOQ4ggBzwR9yiXLka8xKnaXFVVHZZww/v1tK8JCZTvJl7yqzcq
         dCc5jtAu+BI9B5WxsyrxyFI6pApzFfsN9zLdDlw6V6Qx06vEx9qn8jW63m3Wr4neNndj
         3R4NwwlFPan519vBqxdLaHm4Y0dirg5KeIr31MNYJinwdthbxmzzShSzss3JsCHeXNk9
         XuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261452; x=1716866252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NY82JNhe1Lcp3d6UGeyI0G7Bbb4dBlKnBMAKZ+t4Vw=;
        b=dkDgqu4OuiaWVGkZBzEpx4a47653M+AIB/d9wNx/Ue9UKFWWKN4WvUofPSgzBZwz1e
         i3i6XmiIdxI/92rQ1Tn5xvab6yJcj1cKU5JuOx8FA5YWUkNqHmeqWLEvwNXvGLi09Js4
         wkSUUqCiMCiTl6jA40B1qF8TGqbOnXaEDFgdNyP81tSJu6PVpAbW+Gym9xbqCUv+IdnE
         4/Ww8YqFM8LPrtWzzo6/0rLvxZ5KfUpHkY9wXg0NHPjgB6bSdJTV/jw9Mkv9AGS5I0ol
         6wGXlx8AzEg+DzzLEW9aY+RePbWK+lAHelRUHgi+TDy99h5rQxsLspsq9N94t454OSIc
         i1sg==
X-Forwarded-Encrypted: i=1; AJvYcCWStqxQP1/+jA2tC6PIBAuxMbVgk3oKqmCWdUyUdvtyyktUC14zyA4I8WSodZabv4GUEne3UED4rDi9qAY6DwE5AV7w6+OvojazNWM2
X-Gm-Message-State: AOJu0YxRtj8PBoMLGwt89hM0hWqUTlmdILeveAp+7miWaOYLI05Plc1j
	EWFO6RUG5t+1Zb1jk7q+3EIQyf7q+C2maPRfjPdNQj9K6GEElgcdgwsGKNs+k7U=
X-Google-Smtp-Source: AGHT+IF/KndwB5JM/Mysm9NlKwnpEQ4rYTS2YQtb2qNKae5M3qcQWbQEJeZj5ZqRLsVnNipPseSjzA==
X-Received: by 2002:a17:902:e891:b0:1f2:fc8b:ebfe with SMTP id d9443c01a7336-1f2fc8bf12cmr60440765ad.48.1716261451785;
        Mon, 20 May 2024 20:17:31 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:31 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 13/31] Staging: rtl8192e: Rename variable RfdArray
Date: Mon, 20 May 2024 20:17:00 -0700
Message-Id: <20240521031718.17852-14-tdavies@darkphysics.net>
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

Rename variable RfdArray to rfd_array
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cdb3ebc77a53..996662a06e3f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1407,7 +1407,7 @@ struct rtllib_device {
 	struct work_struct wx_sync_scan_wq;
 
 	union {
-		struct rtllib_rxb *RfdArray[REORDER_WIN_SIZE];
+		struct rtllib_rxb *rfd_array[REORDER_WIN_SIZE];
 		struct rtllib_rxb *stats_IndicateArray[REORDER_WIN_SIZE];
 		struct rtllib_rxb *prxbIndicateArray[REORDER_WIN_SIZE];
 		struct {
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index a30945f30e14..4c8cfa40927c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -509,13 +509,13 @@ void rtllib_flush_rx_ts_pending_pkts(struct rtllib_device *ieee,
 			   pRxReorderEntry->SeqNum);
 		list_del_init(&pRxReorderEntry->list);
 
-		ieee->RfdArray[RfdCnt] = pRxReorderEntry->prxb;
+		ieee->rfd_array[RfdCnt] = pRxReorderEntry->prxb;
 
 		RfdCnt = RfdCnt + 1;
 		list_add_tail(&pRxReorderEntry->list,
 			      &ieee->RxReorder_Unused_List);
 	}
-	rtllib_indicate_packets(ieee, ieee->RfdArray, RfdCnt);
+	rtllib_indicate_packets(ieee, ieee->rfd_array, RfdCnt);
 
 	ts->rx_indicate_seq = 0xffff;
 }
-- 
2.30.2


