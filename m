Return-Path: <linux-kernel+bounces-184445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33598CA6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E8B22CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F72763FD;
	Tue, 21 May 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="mGjjDAX2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F273171
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261460; cv=none; b=Qt1zAtPNcfXvebdw35ig+x9JRI8RVzRiTKGX41ogJKzZm52F0NDDzze8kOSbLHhnfhCUUFhuJAzH6WM2jw8bFVs9XqJXlZf2YiaK/FEcUWtfxu3Mam4SY77g6fEozWld1oIzCcc0Q/MGg1r4UAIwC9F/YJQz+z0ttqr5a2aO5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261460; c=relaxed/simple;
	bh=hPJRM/f0cWl7W+m4SCd0UK0MHAt/7KX6y+yPnva3ddY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiG+P9RlZM0V8zr0ZXwcXjEFeFcYfc6pt8qtdvykTjMv7tDhlQd3P/zeWSxAUYvTI4I/YqVlZMvtmAKkhdJWNQGctGdU9AqUN6AG9ezEilntGN0HWbswEBZ1gpSnJhUMKeUEAcb6vr59G7wjWnVCUpsxKPgNiziDsXqztnKZm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=mGjjDAX2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecddf96313so81731035ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261457; x=1716866257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzmRGVhra0vqV7ClBDZ8LpQ88upOg0kiLsBQjRBVvpA=;
        b=mGjjDAX2i8YCuT2+fbLDgOFjO2hMKh/5ocvjmHCvweRusZ/qmDUIw5wGByYY5AJzNv
         HWBy50GtWVj4JuUskB3vVfFEx/nAHQBbhn8TThIvuyEpjjwaF/Mlq6+NFpiqF7fqJivT
         Zv2GrthjZzWc/jrs3RtfapuY3X8auKHbkexiINbQ2SGa7yGZosKSsuuyAvaz0ekyUDlt
         6u70CaohVk87W/LoGMQwK78UKi2sO26cm6EDhGA0rej767ufo/cS1qKWSDAlALIo42S3
         rzdV/LjjpffFe5HpSagsPoLUfy8aZtEmCKNoQ58Z7OI6g/bK07qg76rcPw3SZ9EIiWKu
         SWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261457; x=1716866257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzmRGVhra0vqV7ClBDZ8LpQ88upOg0kiLsBQjRBVvpA=;
        b=PaXyBxqYQGC1vXVAvIuMkE9btWgrJuRoYf2qupM4BHmoqneilriuU1LyDWZUii/URo
         CWk+bLiM3A9FPw03C76zMc7i1wjk2mejx89oowoBUmTmb9730YN/qzy1PojtYC1G9xg+
         6+fbopZPXWl9Jf8+GfnITyKoSVDQLvIJi/ru/9LlDO0w6ouZZAroSEweeUhSj5j/WynK
         HES1vksHj9Nadssbe+whlF+vWINR1RyheONIVi6K3wWKFscfbGB64Oz0yzATGrtucAd0
         epvFV9sq3OeNv44u7XD0NcXJEK/0DBZ4EpttOg317fTCl2bWe70eL7Ea8ETq+jWFplUr
         ZkKw==
X-Forwarded-Encrypted: i=1; AJvYcCXUvnoNHlq9o3YQKBZqGoa4dVuiP61QFy668dXKUTkZVQyrufHlbynB1pQOaUgdkMDGsy6u1D3lz+VQLV1zt5qL5rJ+nFJZUQtEFg5r
X-Gm-Message-State: AOJu0Yxg3oXyUgflKxT6dpRu6Da0mK0aJ3UbG9loenySCk0JnYdf+z77
	RB78uDJau4/IcajK1yfYmH+dD2GCXggNOXNA26LIl3lMnf29ul/TuD24+ceWWAo=
X-Google-Smtp-Source: AGHT+IG3xZPcwhNaTmcektbIQRrzEBZS1fMMUdZ5TEtlnDulIxt5qmDUML9L7SII1MpSR5noRKJh/Q==
X-Received: by 2002:a17:902:6b44:b0:1e2:81c1:b35e with SMTP id d9443c01a7336-1ef43f4e417mr364559355ad.54.1716261456986;
        Mon, 20 May 2024 20:17:36 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:36 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 20/31] Staging: rtl8192e: Rename variable WinEnd
Date: Mon, 20 May 2024 20:17:07 -0700
Message-Id: <20240521031718.17852-21-tdavies@darkphysics.net>
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

Rename variable WinEnd to win_end
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3a637731506c..ab2aa1a86c51 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -527,7 +527,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
 	u8 WinSize = ht_info->rx_reorder_win_size;
-	u16 WinEnd = 0;
+	u16 win_end = 0;
 	u8 index = 0;
 	bool bMatchWinStart = false, bPktInBuf = false;
 	unsigned long flags;
@@ -538,7 +538,7 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 
-	WinEnd = (ts->rx_indicate_seq + WinSize - 1) % 4096;
+	win_end = (ts->rx_indicate_seq + WinSize - 1) % 4096;
 	/* Rx Reorder initialize condition.*/
 	if (ts->rx_indicate_seq == 0xffff)
 		ts->rx_indicate_seq = SeqNum;
@@ -563,12 +563,12 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 
 	/* Sliding window manipulation. Conditions includes:
 	 * 1. Incoming SeqNum is equal to WinStart =>Window shift 1
-	 * 2. Incoming SeqNum is larger than the WinEnd => Window shift N
+	 * 2. Incoming SeqNum is larger than the win_end => Window shift N
 	 */
 	if (SN_EQUAL(SeqNum, ts->rx_indicate_seq)) {
 		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart = true;
-	} else if (SN_LESS(WinEnd, SeqNum)) {
+	} else if (SN_LESS(win_end, SeqNum)) {
 		if (SeqNum >= (WinSize - 1))
 			ts->rx_indicate_seq = SeqNum + 1 - WinSize;
 		else
-- 
2.30.2


