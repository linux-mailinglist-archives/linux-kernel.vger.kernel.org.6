Return-Path: <linux-kernel+bounces-404908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9449C4A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0428B1F20FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AD1D1E7C;
	Mon, 11 Nov 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MQOeFTKf"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0651CCED1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368951; cv=none; b=Yqhk/WTQVjcJRXF29WSEJZVlPwAtKJ9JOOd8NUxahncyjwO6BOEwm5ZcCgQCf3TE3Rglkqfy2vws2J6UL7hmESuxAb7MBKbawVY0rcHZiiBcemySGZZAhoJTdTYEvlE4SE8IlIekxjngtQ3QZ2q9uKevGGm2Qb4d6KxoiXzC3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368951; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAeaZUWAIJcW7fONIAVTgjN/sV5YVDzRP+jcLeVUH6yOj4Bk3iBh3nZjoBLQUeSPjrjEQnYjP5OQLR/d9Oz+7MuFvNnupRK5VK6o76YSjeyFSVEA3qhoXDo8v5VkA3TMiw8PTcP+7+OVveb8T9RoVM+ftuGJg4/s8Nj357876RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MQOeFTKf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720d5ada03cso5128741b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368950; x=1731973750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=MQOeFTKfgntx/fL0KS1w5ehtnzLw2J47Mgw4aCD7qt3FE0GsZguoRF9UzEZDgQNRgw
         aFV52MGH6xiQKxHGYiA1kQ5dpioB9Eb2OR4Hcr1snqxBl+9BCvPqY53HaGpaY5Dv+Kxt
         5uSsPI702LUrz9n1i44B0UVSu0D/HdbH9sI6vGKOckND5vcI7xCVX4UyWAKHjqOvqbeV
         H6z2/+sDDjg6Ql5St4JCD+3NCRqUcBKc2ATPKwnEKp4Z874xUa6nZGAqIBzYYA1Ms9TM
         2EC1Jigln0/b4vOYbtqVWAsGezZdc3xX9GQP/UGaLCY75z7A1NSNfrTGydecQF7a/u2V
         zVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368950; x=1731973750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=OCq+i1WH1uSJQnx8gyPl/RtxSE5JC7MCNwLjDyEpfJuoNEpHzRNeSwPDBYxc2Nwlnx
         XFRey0uiY2i8rYgFZIyDg81JllUpUHHMimExJAZhMo/IY79tbExiKIDJpbfW7GOCeAvn
         jotKaL6XuSTFEKedqHDllgmfK4hcqAgn+RaHSvOAubpIxSBq0SkwAWevDAB1N/muKDGb
         3ERf3JwRD5uuF9s45cgKTkGhqF0zsxXQ+Q5kJSOlt/0H4SYvJARtywHQu59CRGbP5Wr5
         0p6oCzLb9aSHXGvj0PS3l4UQLyJ5L6NLNopYMzqz/7N04y3qv9VsveTHNeQd3yzxQIew
         o3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQYepGddt4MYuHkMSuN0lGtMyNNaapyhstL0NwOkFdNyM0qElQ56pzMOYS92CPb7vdKpUTv49hOkDmTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAbwyOtdMVvEXDEupuukbtna1idMfQnatuelGsP+bkiQiY//z
	W66YHTMljwJwvNoYBNVuieKjbSUTlR5mowQ7P/aFHwufVbMpbIuMGTM55XeC9ms=
X-Google-Smtp-Source: AGHT+IGxdsMu1dfGOYWXi1R28aWFhjsN5Q3I34Dwpy3CjKRXcDtvBr7LZlUVTVK3RyQbj+sGtC8u7g==
X-Received: by 2002:a05:6a00:3a29:b0:71e:680d:5e94 with SMTP id d2e1a72fcca58-724133510d7mr19932677b3a.19.1731368949731;
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:49:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/16] xfs: punt uncached write completions to the completion wq
Date: Mon, 11 Nov 2024 16:37:41 -0700
Message-ID: <20241111234842.2024180-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They need non-irq context guaranteed, to be able to prune ranges from
the page cache. Treat them like unwritten extents and punt them to the
completion workqueue.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_aops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 559a3a577097..c86fc2b8f344 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -416,9 +416,12 @@ xfs_prepare_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	/* send ioends that might require a transaction to the completion wq */
+	/*
+	 * Send ioends that might require a transaction or need blocking
+	 * context to the completion wq
+	 */
 	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
-	    (ioend->io_flags & IOMAP_F_SHARED))
+	    (ioend->io_flags & (IOMAP_F_SHARED|IOMAP_F_UNCACHED)))
 		ioend->io_bio.bi_end_io = xfs_end_bio;
 	return status;
 }
-- 
2.45.2


