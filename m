Return-Path: <linux-kernel+bounces-179426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B2B8C5FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4ABA28522A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4365191;
	Wed, 15 May 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="OLJPCkia"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EA5D8EE
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748771; cv=none; b=JS9BdA1BOLnueAydZPlCQQ/3y/37Z6SJAZjrKtfC82xusa40tO8PYTlxVaxcknZIzCx3JcdokKfWQ7BVQk2ZIhRcjwrYs3r6TFCoVmmf166EHBm0kgGf+sfeG3gvWHPeDhJpK2qYGsv6KXzQ8Le/k4JXfFn6rxrqYrzdNJ2G6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748771; c=relaxed/simple;
	bh=4XTLJvgMh1WinVEq0Id8ZcIV9UdiDPoQ+WA50lQ7L1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdURFXrjRq4NDB8QXwKfoDPGrjCPTJDYzA2+grNprsi2021GS6qXbz6aNn2XFuO/bpkn7itNJB5ociLz/LNYHBPWtforYMEU/qExXUvH+3TksC6HKwAuZ988X3dEbf0zFg4ulSmVt8sMEL5LXVQzbm+ohxnpx/0jYLcjmQeMmrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=OLJPCkia; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0277767fbso2881412a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748769; x=1716353569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrMvq8qC3hHMkYwnyvuzzsX4WuQrrRB+cSvIUWL+7wU=;
        b=OLJPCkia3ZWoBX2IeHVaRsimd+iWm//7oUoRJp8k8YVVSkn/Sr+bNCePzOiUsmzzqw
         gS7cuh9waryM/lnYw5mjhgbOWz1XPR/86vv6cqb4wR0OGP+TgjZGHhtDtEzWe87xoTUS
         KirWo81GVJNCnpTPDyR3dzf9UqwS90cLOC3avxw7PceLzy1+9nAi9GFbWF5s5CjDGzHw
         uTg63ZcsxF4mLQcFvC6pn8Q7Q0WlRsqJ+W4dGx+/8gBYa7KiPzqUPNK5AW31q/FQ0D+S
         8L07c67uoJpdd57C8py7IJS6OSESTCGC/aSMf4RwuPo++T/VMFRshCI+Q1muaxWpCTwW
         Z1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748769; x=1716353569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrMvq8qC3hHMkYwnyvuzzsX4WuQrrRB+cSvIUWL+7wU=;
        b=lrqvV/eTlL8gX4wV1ueg4XT2QVEa+NcpJKEdS1RgQ5ehcFYDuePxsSF+xMCYconCj4
         Rg9EevlTWhMmcfBFzph30LRf9CEtuoVwY+iX1YwoJhNIaiBNDT/9Na4GU7F+Xeft3QmJ
         LE7c8N7+VmjQfdHt+Ndg1R1neL3Q7XiJ+RP0PpBfgmgo7+Ro4tSWWcqoOlOxF6fI60TZ
         DjKa7GQnST6uoU01qi5Y45CeCl4dbY0jxSHA1bL3LnsqLQefWhTLoOI3g5Dy7HhEY3o4
         /LT4HcPRFT1ww0Z5ssZH1jLU3VgHtEnuHy7WPsA/XPsZdN7o2niZDAY0zsCV9W16vMSb
         ym4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTsi/9dtNLbgipEOgixTp0NcdQUhkCjaIECMdRaG8ldVnKb/e57Hzx6RofvQLqGL7H9hKs4Jtu/pFaOi1pyKwfoBQwQ/IgK8FE8lbt
X-Gm-Message-State: AOJu0Yw/j+2V2xB8TWVygQYy4AJl0QuK/ju6znNfVDvvEXiYpdb64mVU
	jmuvB5QuOf6gIhJS0lGidw+Iro1nmPJZgtxZ8svBcPhh9GrlbkMZiAp46yA1I0I=
X-Google-Smtp-Source: AGHT+IFmmz7iQdKFayBIXMY4XXVZ6NE4nA/h8O/y0t9uVFWS3hw0S6ov8zh6piTpQxthknH1VPxpAQ==
X-Received: by 2002:a05:6871:1c1:b0:23c:f645:944f with SMTP id 586e51a60fabf-24172a420c5mr15089318fac.11.1715748769146;
        Tue, 14 May 2024 21:52:49 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:48 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 21/31] Staging: rtl8192e: Rename variable WinSize
Date: Tue, 14 May 2024 21:52:18 -0700
Message-Id: <20240515045228.35928-22-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable WinSize to win_size
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 72e4af81b1de..f276e52aab08 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -526,19 +526,19 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
-	u8 WinSize = ht_info->rx_reorder_win_size;
+	u8 win_size = ht_info->rx_reorder_win_size;
 	u16 win_end = 0;
 	u8 index = 0;
 	bool bMatchWinStart = false, bPktInBuf = false;
 	unsigned long flags;
 
 	netdev_dbg(ieee->dev,
-		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, WinSize is %d\n",
-		   __func__, SeqNum, ts->rx_indicate_seq, WinSize);
+		   "%s(): Seq is %d, ts->rx_indicate_seq is %d, win_size is %d\n",
+		   __func__, SeqNum, ts->rx_indicate_seq, win_size);
 
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 
-	win_end = (ts->rx_indicate_seq + WinSize - 1) % 4096;
+	win_end = (ts->rx_indicate_seq + win_size - 1) % 4096;
 	/* Rx Reorder initialize condition.*/
 	if (ts->rx_indicate_seq == 0xffff)
 		ts->rx_indicate_seq = SeqNum;
@@ -569,11 +569,11 @@ static void rx_reorder_indicate_packet(struct rtllib_device *ieee,
 		ts->rx_indicate_seq = (ts->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart = true;
 	} else if (SN_LESS(win_end, SeqNum)) {
-		if (SeqNum >= (WinSize - 1))
-			ts->rx_indicate_seq = SeqNum + 1 - WinSize;
+		if (SeqNum >= (win_size - 1))
+			ts->rx_indicate_seq = SeqNum + 1 - win_size;
 		else
 			ts->rx_indicate_seq = 4095 -
-					     (WinSize - (SeqNum + 1)) + 1;
+					     (win_size - (SeqNum + 1)) + 1;
 		netdev_dbg(ieee->dev,
 			   "Window Shift! IndicateSeq: %d, NewSeq: %d\n",
 			   ts->rx_indicate_seq, SeqNum);
-- 
2.30.2


