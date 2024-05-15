Return-Path: <linux-kernel+bounces-179425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B048C5FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A9E284AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880D60882;
	Wed, 15 May 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="jcV8D25I"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CB5A4E9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748770; cv=none; b=eXMC6FIF6ZKLJNyKGnkcpqug9peeCtMJR31stf6KsaKXmZkJYtXKhwF/qlZHXdw/ESQz1+RciycJ1VBWIrm6Pc4wJs9slnql9baiv3Z5krDvJ11C01y5jEQCm1xtymHqerV68JJhQxPMYNtUaUrjzzCzu5riYyJ5PUNvZB4RdYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748770; c=relaxed/simple;
	bh=aEaBp/mQ0gwcVexIJ7BuhP3t1ukG82pKvrXnoWrveIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEpUQrYH3cTmkTQsnI9F+om/DmCE/kayLsWb7DNfhC1IJXO3KYkw4Qhtu0YTCdyDpVJcEHBLIHIYVIeIId5BsLPr/idQajNSv12T3pR1xKFJGbhzz4/kwPhUjAVwayt5pfdcKEgCZPKQP7yZKdb9pyTfosSuuwysgtCPAD3xgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=jcV8D25I; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44390e328so5870729b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748768; x=1716353568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvfIK48YP43wqCqKvrzT+mX/UTiFLxkkrmO0jBglQA8=;
        b=jcV8D25I4p3aDpHLIABUpec1k9vK3Q5yx0JJRnu7sn3YPKeRAeHcwzWWeNgUSUw2oq
         EVy+8bsXPf5LnsHuHtxocjuG1it6E6Do7t2oK2PCpWRF5sHLH4hMdKn4A1HtrTmrFtPZ
         lKjaVg04wFZ8TRB3xNHxtobhKK4Tq+a0y/M5bAUBp55Z6/lUQCmFPy7I+N5+glEERssC
         MFOiC5aM0V0hCARZbu1z4Pl6y9FcX+JAXX7WLUE1PJyBWOJnz+pSceMa/MJZpx+t/EHm
         ms08+ieGvwS2sb7iL/aiZa4ylFstr8BqCR8jm4coI0vhFZ0iVa6N8xm7GgUvSEVOEeOu
         QwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748768; x=1716353568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvfIK48YP43wqCqKvrzT+mX/UTiFLxkkrmO0jBglQA8=;
        b=PMMPgjgOLNYwvXLB+djw/+Mm/6cT14/GnWNWXoXr+sVKHZ1qBEOunc8MuIIn4mFs8L
         n752sf3c1A9g/NvUIdNTZ2rLAAik+xLwAaT1brMqREUsqJfAV0JW0gF1pQ8I28+IBWre
         BrZaWEOHiaCSjsgATzNjU2kMp4KjgGskhrEeyXacfIKQ40B0AbTd09QRKL/iMf+1DdbJ
         VEp9yNeh+ZrN7fz1MiU5TdYpgFtJRAs6bw5R0ZT2NPaD6LzYSWfQ+2n+76KoMz97Sev4
         cHOFbUn69SMLCHcAmDd7QFDO/LoqPwLil1RtWfs1pbj+2U2otKCwBpbRhRljolAiU4g0
         9dtg==
X-Forwarded-Encrypted: i=1; AJvYcCUjXafwGQ+LdshLJGM31igX1oLVc0r4/m/ogyi9KHOBdahH4rgmhzyy1dF2VA0XL5pXvce52m5b/eceQ3PodPR+ibsYfkq4WwzkCKbD
X-Gm-Message-State: AOJu0YwAN28Ys8S+eB6bliSQxLjZfPREQUf7VnYNGVs7MZYavECvIYy4
	m4hHm8IOB0jaEqK3CA75RnGzwlE8HXFBXgoO3wV+8UeEums8UJeYG2q71JTEPk3bTXFhsXcnWoI
	Q
X-Google-Smtp-Source: AGHT+IEV19/6hamLklDvRLWJF3yvGui5BeA+UH1BOMX/YAfh8NQPDTuI4iYqOmWyfb9UOWuI3DDXMQ==
X-Received: by 2002:a05:6a00:1916:b0:6ea:9252:435 with SMTP id d2e1a72fcca58-6f4e038539cmr23344033b3a.30.1715748768489;
        Tue, 14 May 2024 21:52:48 -0700 (PDT)
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
Subject: [PATCH 20/31] Staging: rtl8192e: Rename variable WinEnd
Date: Tue, 14 May 2024 21:52:17 -0700
Message-Id: <20240515045228.35928-21-tdavies@darkphysics.net>
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

Rename variable WinEnd to win_end
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ca1c748ac40c..72e4af81b1de 100644
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


