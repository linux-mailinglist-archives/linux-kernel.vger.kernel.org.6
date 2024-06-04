Return-Path: <linux-kernel+bounces-200922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA75B8FB693
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E0F1F2162C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD7143C47;
	Tue,  4 Jun 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLZzefoO"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B013D635
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513609; cv=none; b=lahOiaKtrKbIIj1FRQ9dwQqC3IJ4OwCPcr6D+IYkyFhJ/AU58pvuI8jfvONmkw0G2CjVkY7K5h56VCn/Am30mQOXNG/uitF1x0YfhYihuma5dzrvR8BT/wTtoUBLFINU8TSppGsO0wDPYMeEKwHXpLRD9yIC7m9j9s9KOaSFSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513609; c=relaxed/simple;
	bh=2+qXDfAbhYUn/QH8iwQCLN4+AhhRWmxUefIYty9tvjQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rRPEEwJ1hcU8OVKHDm7pWiIXXRf1LZFMyDkumX4gfizAiLm2DFQocLykXiYT1kXSWkhzpXugcO1jr2njxVz5e36e325z69AH4jNDDtlAe0G4mKDBYJPk/ei9CpGM+XUVTzgHxsBSC72eD7kXy0UnYWM6ZCDIbBdP0fLo/n2sdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLZzefoO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70255d5ddb8so2318507b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717513607; x=1718118407; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJhh363fbWRlNJvkWAmkbwBisq5XC+2LXzyAvBxQ2pk=;
        b=dLZzefoOWsblE1dZrr9sh1dAQI6+mjS0Y50tONrTK3i4T54vpOavmZFM0iiUOxKPge
         4H/xhBPqpPe9+jFg1f6+RXJVvgN/oLMOtwryvlaJlTSuOIFmH+twmcqrzsoBlCinoEg1
         a0LWyGsyZX6ACisTWcnoWMSixIJlpD2rP7vVxhGmHuNssLheP0KbsuFCT8kQFBE7tx+2
         BZaGCONdwgZcYnr3JO8rVTvfcD88an9hip6XIW+rgGVsDvpdMqh79+IwU7Y+8lG+gQ6p
         PRhSEqwFNHjli/XbAIFS0JFMa8leim7ueVezR78/SmtRh+3Y9ibkq44DbKP4KGIph0dz
         mUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513607; x=1718118407;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJhh363fbWRlNJvkWAmkbwBisq5XC+2LXzyAvBxQ2pk=;
        b=cxIrxukAfVKcikevc9bzwzL5xDzR6MZo/KTXSyxO+5xNJ9sYb0grc2zQVZak8QyHeF
         ZWnPVtvSwzvtpVhd4zLogalOySdaAQnpxu32jZwX6AlmAnkBSuQJKN4OBe+vyqciAPGr
         LOPGe6YIIOq9cbYufBQBC5GxHVFnQKl3DTDcc6zfJp42GcHyHsjTIzjMw/tjZHvpzw39
         nkYLFVWQt0nui0xgG58FVmKE190ClHV7wwpkjbCDdk4Yi5WYdkicIpwf5y+XPMpEFVwx
         srG5g1U/YfzFoilI1IjJqHLcxNAUpROqWdedTurSdu7gRFQshbkzdzpImnX12fYf9ojV
         k/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzHo+JkLkn39/PrLZWE3NMyFmfMiBBXSnAmU/WD4iL7Y3nG50dLohIB18N9g8JJEWswk205NBeR2bfGSe62VH3ap0mgEsW6PIS2RdK
X-Gm-Message-State: AOJu0YyEPhNB3USaQvI8H3ztHOWm24FUyQJudHOpnizHVe03TnexxYsc
	ZRNd4eMw5/Wim9VGbRQDGZIlysMeEIKbM1SCsqpub3Umtl9zKCjS+5Qz/fe1
X-Google-Smtp-Source: AGHT+IH010tpZVdxgd9Yw449UqLipwVxZfsbDuz06jA5aRVTAA4YUmp64TMXqKVnkaKczlNteTqLig==
X-Received: by 2002:a05:6a00:23d2:b0:702:36a0:a28d with SMTP id d2e1a72fcca58-702477bc037mr12205994b3a.7.1717513607178;
        Tue, 04 Jun 2024 08:06:47 -0700 (PDT)
Received: from localhost.localdomain ([180.69.210.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70248dc56d8sm6740666b3a.80.2024.06.04.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:06:46 -0700 (PDT)
From: Jung-JaeJoon <rgbi3307@gmail.com>
X-Google-Original-From: Jung-JaeJoon <rgbi3307@naver.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Jung-JaeJoon <rgbi3307@gmail.com>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] maple_tree: modified return type of mas_wr_store_entry()
Date: Wed,  5 Jun 2024 00:06:29 +0900
Message-Id: <20240604150629.30536-1-rgbi3307@naver.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jung-JaeJoon <rgbi3307@gmail.com>

Since the return value of mas_wr_store_entry() is not used,
the return type can be changed to void

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 lib/maple_tree.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2d7d27e6ae3c..da30977aab0f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4203,31 +4203,28 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  *
  * Return: The contents that was stored at the index.
  */
-static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
+static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 
 	wr_mas->content = mas_start(mas);
 	if (mas_is_none(mas) || mas_is_ptr(mas)) {
 		mas_store_root(mas, wr_mas->entry);
-		return wr_mas->content;
+		return;
 	}
 
 	if (unlikely(!mas_wr_walk(wr_mas))) {
 		mas_wr_spanning_store(wr_mas);
-		return wr_mas->content;
+		return;
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
 	mas_wr_end_piv(wr_mas);
 	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
+	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		mas_new_root(mas, wr_mas->entry);
-		return wr_mas->content;
-	}
-
-	mas_wr_modify(wr_mas);
-	return wr_mas->content;
+        else
+	        mas_wr_modify(wr_mas);
 }
 
 /**
-- 
2.17.1


