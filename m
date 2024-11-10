Return-Path: <linux-kernel+bounces-403264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042AB9C333C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8ED1F213CE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735718594A;
	Sun, 10 Nov 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u8x6MYx/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6216F0D0
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252576; cv=none; b=tYE5HkLrScqPn5S7G96gpkkPHRYGptK6yDc1Jj5njZpIBzH3MbbnxBjYVcmeThh3CBk7VWk4MYbxIax4TM12wjTbLRYUOGEJJovbjgBfcrQHAIWfLuNMXWakaTvYCZr6m0bdh+xd0nO4MSmaZbsFRUvacya6ODXG6O+i23v7QQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252576; c=relaxed/simple;
	bh=JN6ziuaz3h3w93syhui0sSuROUWYBUO3x3xlg3f4CsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxVuwtKOAXvIKPgc06hrmAEDXSmVAyAaz7t5IB4p1XlBDCXye3iZ85+17t3Dt/4sjHb1utiTRHk6EVeiHmhmXv8dH16XoTs8d2ogwVB3G3WWHeuYzbm1DOkinPA716+acpyLmYeMNyJbm0KWgODH6oisQVKrNMxqC7w+TgUKbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u8x6MYx/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-723f37dd76cso3790018b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252574; x=1731857374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=u8x6MYx/UtKOMks7NJ+TLYm6DBTL4EOTB7sb6PmubdEYVNejDlMm2Eq76FR3nXWymp
         r3zVlFa6uMYain7P9bUHme/pWSDRtjdvIRZ5SMtKrWvTifsLiEgWVOJ9FOTpnL2CiGRy
         7+j71tC8+NhT3Mx1+LDHq1Eh0iNEvGcTkJ1Kw1FQCPWqDGZhpknvWngSsX3eu91RDTeJ
         Ssh4TMi06dZ4R0X0frUPK79mIeN1IbzJElZIyguXJHhFqDbPyARWZ4mjBWIDG7/s6Tig
         aLBvrPBXUgKqT3se0RKHpC/2YT+XO9kdLOabVfuirvLl8LLFRMAAY5gqNp/VvQn7xS3o
         Gzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252574; x=1731857374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL88Qd2tMlsmBvcuEyGfQPoq7EBSjG4mmD1oB3CTmL4=;
        b=JBbGxfNG0xoWdAo0Y4KBi/gj7Qr6T1o9otkkRdZmotIlm/omZ+tO6Pt1L9CHFiH5ez
         osipcylnHVHwkoWwl1I/zY3nBb3d40y2BujZg8bn0mpqZU2B4Bjj90FnWhL5uX8swACt
         cEUKuYUFnNoDk7NsIriu6SHFPC2+0wqI5HFpiqLhd/V55Vm2RWuVyYdWaAWVndLeF3Dr
         Hp7EBA4QNe1uAEFeFgSO9LUzccWg4FxuCCZ1Nwc43QitOhEuNEgeGFfOBc5wkFMvj5Hy
         J70jXtO23Uh5iT2O3fLLZ+xfr9sZnqRtOhKRoC7NqowzyqUY3/xZT7HELHHTBPB376sv
         R8mw==
X-Forwarded-Encrypted: i=1; AJvYcCXFv4aDFzFGE84/9BKMCYsGEFkmumVgYCAASkEvGmf2VmsrZiG/S2PiqXXGKc+LNIRWG+gCOkrwM7j3VLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaUR0ucD1AZl4G4yXEhv54gkRUQdTcfHkILs88sRjiGy+cDY7
	OHEfMVVjwXfC3aMELHky/K5cNgApUUfkqqO1/uhs7d+o3oBikIz24xy335tMdOg=
X-Google-Smtp-Source: AGHT+IGDHhrWZvwz3+S2z66PgLKGWEEUzZeIBjMPJzYATyn0eBE8Y9PpfOEANie1fvuwvTvVxNqbng==
X-Received: by 2002:a17:90b:38ce:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e9b174113cmr12568464a91.23.1731252574323;
        Sun, 10 Nov 2024 07:29:34 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/15] xfs: punt uncached write completions to the completion wq
Date: Sun, 10 Nov 2024 08:28:06 -0700
Message-ID: <20241110152906.1747545-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
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


