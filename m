Return-Path: <linux-kernel+bounces-402128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29939C2444
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD221F271DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232721C188;
	Fri,  8 Nov 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T0foBzDD"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7C219E56
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087921; cv=none; b=bpDjRpeQTrtL2OWYIQ2jFCWcgIGWA+RRF28jURSABxYiFIDUKNbNzTtnq7fBFzNd3EBIcrU9gM6vT/rNmCBo9kVdGHflVbccBkdnoFJ0zDQEFvrMWoXQDvDbI62us/z/ch8N1fUBAryghYOYibrHiI0CtlC1zXwxH7s5slzybRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087921; c=relaxed/simple;
	bh=klEANlDo0QcivFe1NIYDNiOFa1lRCa2wf9JjLv/2My8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ78pwjr/JDEM+sgVtSpojV60ZkS4/lQyVIfhwWcibqqm5X1FsLSdEmvbameaZ8+6ReZJO3pda/EiOKbL4LIHjK7j7/WX6XkxcsL2MMmiYpXHp3FF5mLfozub6g5mDouXfIY3mXp8dmeddfu94FyeNGP8ObKdDFwgtEh03s8NOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T0foBzDD; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5f86e59f1so1484811b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087917; x=1731692717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=T0foBzDD4OiqyTOmDAvUWSlf8ZX65Rcd4TXeNwMBSGFnyZMpDWYR/Na3JXxZUkFG8f
         Qvb2zz0xoaCdxGPhKgIkJPVQgR5A5qPOtvMdw8pybkzAzFgzLOLPCdMI2EgxIhGqdv+y
         PX4s29QLZSFEuWtdYH+BzSPCXf7F2ziNQG9QuCBvEeQ8S3bZWHhQbPZPInu+NeXqC2Ve
         GAIwRTgRZ4K+QVWRjfWisNu3uR/Czq9+kwDbkFg1ZczTwpPX7cwcKdFqegD6LR8ftX47
         CPItpb4+1JW/ZNOarFR/zsiYYACeMFd+oYyCQo7xUDnAekgPtq9cYNm1AjmzhbsopSzp
         Tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087917; x=1731692717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QDQ8u+XOjRX6rdX1KxWEpFxXqQ9HPCp5iTXnKjwIis=;
        b=qcGHfDEsnbyv2oWMgsHg6A1fwpdC+7cemmseETTCbFVmrK2ujShWnRJGJ4YVxrsAFw
         huPcR1wrDHBBt9witDtQUVlxA+SC0ZvQhdeQHr0aBksMdOnfeahfAjT11bLPCgF+QhPS
         00dZMwo2rr43hRUxI2NC17/XVViUEr7s79Vbz/WE7RJTXM31X05iGFLb9roAPwdgsRdB
         1Gy7NOPvalvBfXsUpNQCQT4MHU1X0ot5N9NZW8DhHvAra8CaRrgaHEz2Zb79bBO5g/FP
         ifgBOkymwFg9DXBkqtzhqUuR0tplnFqFU5GG4Q57MWsFMxLjSLh0NtvAFs6VgVr8krpR
         oBQw==
X-Forwarded-Encrypted: i=1; AJvYcCXAlQ/umjkANyrGZE1DbPSEP80hFVLe8V7vRL/hQQHifYVPXUVLXVGhHSIKwolL3eziE+/e+omhYgsgwvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vq7l/YBSqXN/QEfNuuinXJjvo7cOGbFdB5MeHDRvKeBU7Jl2
	R4v8evprPZE1BgReIOPRdQEqCE7WgK1vvl6u2yikdP1Po1d5DrdOBiBcYkHzvog=
X-Google-Smtp-Source: AGHT+IEFLKzY9PDxLtI3q9tzu1PwOWnBFTiZM//bYtu3vxzi/sNq0OsnpZ8TGg2ZJ4XyTsEPnsyfQw==
X-Received: by 2002:a05:6808:1789:b0:3e0:7d53:251 with SMTP id 5614622812f47-3e794675decmr4661644b6e.15.1731087917560;
        Fri, 08 Nov 2024 09:45:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/13] mm: add PG_uncached page flag
Date: Fri,  8 Nov 2024 10:43:26 -0700
Message-ID: <20241108174505.1214230-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a page flag that file IO can use to indicate that the IO being done
is uncached, as in it should not persist in the page cache after the IO
has been completed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cc839e4365c1..3c4003495929 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_uncached,		/* uncached read/write IO */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(uncached, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(uncached, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(uncached, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..b60057284102 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(uncached)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


