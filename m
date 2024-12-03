Return-Path: <linux-kernel+bounces-429762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884189E27B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895A3BC33B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02F201006;
	Tue,  3 Dec 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RuMwze1b"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41AF1F76DE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239975; cv=none; b=quLIXFpZYgy0Wyme+/c2iwoaXvtSRMCFnI1cqTPR44rYMY10XIiu1XKdRYCBt9sErz1ICLlAhuhO8sP2Nj8R7W2ydrux+Jy/OyMS4QE8kpOlp5l/DStCYHv+FB8+chr2vtqhz5uUegzPMhPfwS7Ic+pjH0RT2Q7/N67WQ2DWxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239975; c=relaxed/simple;
	bh=SQI+ulnw+CRtDMqT4Q5a3RM/yVgI6AvOV11bMjB5isk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU48wsTepPVK00X+mFMTjARA33zBy6LsruyjEV7tBsYfLK3wlE7eCiWiR5plTx/gnpyuk4ur7y8z/1Lj8Z7DgR0oNlikkftFPO5sdS5Dk6WOC0OJQJr4Jw4XKzxxxTcPZOyFy7dE+IwMM0vipjoqMDEc5gSMnSbMaq8ZOIX3LU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RuMwze1b; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ea55a2a38bso3014443b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239973; x=1733844773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elv86DXnTmRzX7BzNNN54cJv91/ZhMhRandVuyh+78M=;
        b=RuMwze1bubbkloeBcqqhIIKdhgXrelfY/tzbUVkN72jNmqL1Pu1EcLkjbX/221s3Ec
         gC2rfqKx9VyjuhWcbokwU5l6TMtPQ7D1KDHv31FBP0RgjchCEVvWU4qS9CUYNHcaScAm
         iAl6bJwhqxTCuPouyfBG9Yw44cwPJhpJjgEZ282vfGnD2YOlL83R1ZlgCiU2f+AhwtcY
         ViAk7w1NRl8Q+6m/mMvDaeDm5OGC8TyhI78JxVnjwC/4fwBcfY/FJNdBKtQONWx5YzTb
         t6mS9rkO5MPiEZghVzftLG2OUnEoZ78TmE80CO/jUbE8N/RArWNWGqmfE85hBajtwZjY
         W0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239973; x=1733844773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elv86DXnTmRzX7BzNNN54cJv91/ZhMhRandVuyh+78M=;
        b=uNYVfi7LvSyVlDgT1ynUYLt85IIlPA5SFk7HpMZBnvM1ufU+UJxws5jmJngohGTRK+
         +xGZZFX0xGXlE8q1slQ/zO1Vrxyn2vKpyvo7eqHMJ78kwyfPqNAUuWUdNQBEQdTn3x/L
         YNEFb3+4EDXLpfTnm15agJ1mKbflB4WlgaXnhmVkCz8kdSGtp9dubYtPpowoXkzA3lgH
         nIEKyfFBf6KrbzPrVExOWj8lnL/vquzJbNHkLiP6clVTnCT+LjZ0VLgQQwrp/6BCsO7l
         DrltlPjfN1z6XdVMVWMu5SwU9n7c/FEi3uNFZjvpnQapmPxFkMVUagWCWcjfwNuPWjEN
         e11Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgnTn+CTsFBsyobiJ8oXXp/xGwUL3Qf6JIcr5V0/INM8Vo+jphWxBcbpEjlP67yaQO4Zzy+Bpwlzm+9GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/D5DzUpZMK9kzlXcPrr5uldyktDIc5q9V4t87pBwz4q4FTG+
	xg+fVpurTO80T00StVeydyKeHKDofqaaSluNzGnthDdXkyrCMuDkk6M+64uk+Zs=
X-Gm-Gg: ASbGncvdCMlbsLi5uvwVOXJrhtQCabfTMV5mB1DBsT+QoRGd2vq8DuDUbeuJg6tEtTh
	tC7p0qO00rUa98MfXRXKLQSoAWvFfwZAhoINRo4kGtuK5IC41vHeUPgaQKe8W0QsY0v2JOgu65B
	BmAC2EG1q6yaW3dtb1nCyk7/dENm/Ahpv4N/8J78WF0YCOMbi3NEbPfAPUdZPAcSyJ9zdjfyT9D
	3km7SMOMeLSj5ZS8JhpFLHTRjDqAwqpLLClA+vvrnOhAZt51dO9cZAJ2bE=
X-Google-Smtp-Source: AGHT+IGEqY5mPPeclzVfJP1sqwpK2NEo6ZfmI2zg3SEWdjZlSMpJ+brY6rhQdeJiLlo5jFiEsUF9Rw==
X-Received: by 2002:a05:6808:1795:b0:3ea:4c23:daf5 with SMTP id 5614622812f47-3eae4ecb2camr3172373b6e.8.1733239972824;
        Tue, 03 Dec 2024 07:32:52 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/12] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Tue,  3 Dec 2024 08:31:41 -0700
Message-ID: <20241203153232.92224-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 898e992039e8..dd3042de8038 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2527,7 +2527,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2542,12 +2541,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


