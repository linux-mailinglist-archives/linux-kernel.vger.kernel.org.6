Return-Path: <linux-kernel+bounces-296240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22095A80C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420311C21115
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033A717CA19;
	Wed, 21 Aug 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMNAq1Kz"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4317C7C7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281587; cv=none; b=Ek99iXQPvtxxBGCRSCGA+7OPFHBkzkFYNERBj1YPF7eIXKNjkcqO5V14XgOWBScRcSmchFvHAALhAG4u8YSNoPER17/900MB7nWwUBrrXOWtGiskbn5wH5m6cYcPNoT1h6ciTpFujdiI1x2fLkY8s4rGOFMyI0gIJGiMwlO8Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281587; c=relaxed/simple;
	bh=+2a3e6fzU6g1LxfJMSDIChbvuKERgiPIByYdrnn6FHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UezEZzrxDskic0Ln9AuMPBickYKg371jQwub1UDJ34RbP2J1wy62sutAn/9yTWLoE2HGDDkA2bmjk4CGXAXJYiymN5eiygse7FWDOzBQTE9Se5FCZu5MSBvR9s3nuvfDPGBwx3yVBOzW+HbZSjPHPW0R8gJL9aHrLa/StZc6jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMNAq1Kz; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so176443b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281585; x=1724886385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j8AVcy3nA+u6dMBdfV0u6O2tPyGN+umcRjrnsJwbL8=;
        b=CMNAq1Kza+otw96LXm97pwhLUG5GWtBfuIGqlDAdIgRBy5OcTOHzeDAFQ1+9Krgt5n
         o31c7ZiPqIoFAWcn0xHK9pqczHDIMLsIx9w+1aHpA+WSQiTnf9QvUvC1ECmA5/1jQP1T
         JhtDiNbtaUTUGd6tF69tkfWvmgXh4sU04yB0cCV6suGMok2ySMlDucsrkoHsEcnMUIkr
         5XcjC46cLKvvjpLxGPkK+VyDNNWEkRMVDpcuTwefUP99ek9cSg4CzV/hapmykrRmEt2O
         hhb96jeWikNBr1sdcQQI1p3gUGaOKeccyfjYBQCWGaum/LU1apLn4VT7Bv39vsdfQigJ
         Wq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281585; x=1724886385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j8AVcy3nA+u6dMBdfV0u6O2tPyGN+umcRjrnsJwbL8=;
        b=SUQ5eyNvu7mPjdyROFCwzoNTzpQ3Jhjd5alkg8H1bQTMEJP4dc9xx1zteAzFeeWG1h
         yurTRLp8ra0uCbNt8b55pK/CPUJMn2unu6UtPic2EFRIX70rheUa7RYXOTgm3bC4a0XS
         SgGoRIGQIVzoK6Xp+MNb7GX15OdcpspF7IonBkj4rqdMple2GxWpGBk6K4pQ8qluoFm9
         IKm3TbEO7MpqfQ8feCc40RjU9LyGBBNsKLWLFV0bgcYKUoNIiqCCeWLsLfDVx4NwL3o8
         6tJXIpSeGcxEtbbOkBRFzz+OMJBZdSmZ+kKCuj9ENIpMo3GX4gpHYVTb6cAa+S9BSNNM
         FOdA==
X-Gm-Message-State: AOJu0YxmG+PwHoSX6x6luVgKu3gbMMAgSJ2BSl0PnBSeyfV/LCzNTk9n
	BJiVS5hxQPlc018CWSvEanJj7NsRGYuhe1286AaYYxBK/Y4/GUsG
X-Google-Smtp-Source: AGHT+IFfBczXZo+UWU5F8+qqVF5zKafTj4LZ8XIO00fuY/ucWwm22VoBvTClV6atKCO0mLVyIR6r/Q==
X-Received: by 2002:a05:6a00:10c4:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-71423448b4dmr4619860b3a.6.1724281585084;
        Wed, 21 Aug 2024 16:06:25 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad7db5fsm111843a12.92.2024.08.21.16.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:06:24 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 3/5] list_bl: remove lock check in hlist_bl_set_first
Date: Thu, 22 Aug 2024 07:05:37 +0800
Message-ID: <20240821230539.168107-4-woodyzhang666@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821230539.168107-1-woodyzhang666@gmail.com>
References: <20240821230539.168107-1-woodyzhang666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows it to be used in situations when locking is not required,
e.g. in early initialization phase.

Signed-off-by: Woody Zhang <woodyzhang666@gmail.com>
---
 include/linux/list_bl.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 7ce411567fe5..d25c659f6635 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -63,10 +63,9 @@ static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
 static inline void hlist_bl_set_first(struct hlist_bl_head *h,
 					struct hlist_bl_node *n)
 {
-	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
-	LIST_BL_BUG_ON(((unsigned long)h->first & LIST_BL_LOCKMASK) !=
-							LIST_BL_LOCKMASK);
-	h->first = (struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK);
+	LIST_BL_BUG_ON((uintptr_t)n & LIST_BL_LOCKMASK);
+	h->first = (struct hlist_bl_node *)
+		((uintptr_t)n | ((uintptr_t)h->first & LIST_BL_LOCKMASK));
 }
 
 static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
-- 
2.45.2


