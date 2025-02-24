Return-Path: <linux-kernel+bounces-529366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554CA4237A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77D8188F32F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E0254854;
	Mon, 24 Feb 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="P6VAJO94"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3824213B298
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407859; cv=none; b=Bn1iAHSr7dSbgaVnKYMFGOtobPsI0qd7VwjAFVRfrFu1bRoHiH21dtby9IicsS+ngpr8YAR6TvDZjXwhJGyoV0YkYARGD9JODlIgTB7FtRyKejMWLEo6yObUgQZBgBgTscGBc8LinySlW3n4R5fCqRmJPaU6exkAsdR8Q5H3FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407859; c=relaxed/simple;
	bh=Gc23huDW2EMDvsPrII/FfATOT3S+8qNoqO/SY9zSRVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7LtTSxOiDPOsA8ww751wI1T9P2wuvJXRCGnfN/HBMRi6LUeh1Wf2JZKkQfkYt0KaFlHvz8MH2xOIgqf28BAMoegVpi8H+T5iFbWNp2ovd2zyj8sPIJFkgQ29S2lStzjrdvagC59H2SEkX4HjJQPT/jTrKIJYI2kk7nmDd6WaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=P6VAJO94; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21c2f1b610dso130931565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740407857; x=1741012657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tr5NrMy0t1nSuRnqeN8ZOfvTg64bXP6rdk8GuFGDbik=;
        b=P6VAJO94A2JQVD2Oq1AQuldioP9LkI+3vTV5g6M3wCI+tf4sUMMSaugybK08sjwR4n
         swe9XSLhJrfikIo6L6PZLo7SI9homo7vKtxCoGsNWnIoPa4YpJGyFDssJ8hbNXVVRJqh
         UHibyBTQsfFusU/D393hjXxsYylqqh71tdWThqQLB6FWC0Rxr+lPKIf01HSkdrJR1fUl
         nQXgs1rlcltDfN6UQ4Zkr7Gnfj6QLRZI6RY+KE+hgtCVsWfGRCgS7TdN6MxliC1LLe8Z
         PEjvcENQMrftBXYY/Zfu6NdgY9luF65xoJRCyTLbrz4sKakm03k6vIPbfXhRMoD2JXgR
         HxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407857; x=1741012657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr5NrMy0t1nSuRnqeN8ZOfvTg64bXP6rdk8GuFGDbik=;
        b=sBprUj14CHRG+PRDLNXweRSp1IdLXcRGJ9etaD8b59GRDB8cgyzJC1kKN6LgG4uj37
         rafrrBVc176Mx4p8X7OViF/W01TR4+GtodtPiEthAjrU7mpQona1yuYVcEACIWfQSinM
         nOypjYoIWbXXX1CUhXtcftCeO1hC31yFdtuxIw32u3zsuo11vcUyvtUmg98CZkor/uvp
         RMKwV4Oa6tANH2zx3uQcaz2+NFpIcxfJjBJmghimUZVneT36BTrcWHa2gPc1S5uIdJcv
         6WUnSHs17ZNu0fCstU5haZ3ZmXpFKDUVTVzqMaDoJ3HZPpx/Zu50yHyAqcTTGQQXqZLO
         9/cA==
X-Gm-Message-State: AOJu0YzuBL69dSEecL2HDEpf2ODTfsJEyBDql+DSLyf93uINVnFVN1vf
	KPZYVIEc9uosUXyZOyabL3zORfH2V+IEgIN5yCo8o6BMWHXkrsk/hO0BUEN7o8GHTUe8XtndThk
	ygg9vq2QU6HK0CKC9FofyD5pjggGO3GtPUtE0cyYqr3dckYLOQRCg/kA8lV3RleiWzc/jvH18dy
	GqREHAmiKDsPiplBFdeiUjLUMmR1ybq2DABm7ty7NMigKN9QYaiOWDclv0MvW/rheXz95xp6RC2
	g3n7NMyvHLpSIm0MeZP1bI2r53rPUDPbEHGXP2v9MTO7bnIIvODOU1Ql7tU92cj/xza6kzeYEB9
	FWljdvGbH9kw/oE1u6r44TUBBBsA/Taj0nxhziPDyABKoo5pVXf+y9om3sw=
X-Gm-Gg: ASbGncskn9gNpwpwqCb/eTexe7nIpEYRhS3455Dps0dNBv5dTDYAjZH6PfbetT2EgO/
	GhiICX6viuZz+VjyHv2modeka7bJcpypCNDDZZtZXAuRcShImvsn53Bp5fdPHRreJJBiBBCoELY
	boseMoD1MK5HdLCiSjQXxHrxb8vwLd3hYzgB84ecUUhTHKmvlxiuW1x3oDbCVQ6LjGLYmtRfnBc
	xknPaunhUqW9mEq4AAeBpGlFwaVaDgcWD7QyizhAFs4lhvS4rPmLLVaU6ZL/nA+XBgDAMbUK2zC
	2Sc1kLnd7QScXpAkIxsmmssqXG0=
X-Google-Smtp-Source: AGHT+IFpy3+E5cMzJqqit+IUZQ9CCf4tM5IGjll5j8aYvpZK6kzjNSVYR9yVXPP52A1Zj8pouSbmXQ==
X-Received: by 2002:a05:6a00:4b4f:b0:732:622f:ec39 with SMTP id d2e1a72fcca58-73426c7c77cmr19802356b3a.1.1740407856561;
        Mon, 24 Feb 2025 06:37:36 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:7a2:878::d8:ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732575e055dsm19294949b3a.68.2025.02.24.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:37:36 -0800 (PST)
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
To: linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org,
	Dave Chinner <david@fromorbit.com>,
	hch@lst.de,
	willy@infradead.org,
	"Raphael S. Carvalho" <raphaelsc@scylladb.com>
Subject: [PATCH v3] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
Date: Mon, 24 Feb 2025 11:37:00 -0300
Message-ID: <20250224143700.23035-1-raphaelsc@scylladb.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

original report:
https://lore.kernel.org/all/CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com/T/

When doing buffered writes with FGP_NOWAIT, under memory pressure, the system
returned ENOMEM despite there being plenty of available memory, to be reclaimed
from page cache. The user space used io_uring interface, which in turn submits
I/O with FGP_NOWAIT (the fast path).

retsnoop pointed to iomap_get_folio:

00:34:16.180612 -> 00:34:16.180651 TID/PID 253786/253721
(reactor-1/combined_tests):

                    entry_SYSCALL_64_after_hwframe+0x76
                    do_syscall_64+0x82
                    __do_sys_io_uring_enter+0x265
                    io_submit_sqes+0x209
                    io_issue_sqe+0x5b
                    io_write+0xdd
                    xfs_file_buffered_write+0x84
                    iomap_file_buffered_write+0x1a6
    32us [-ENOMEM]  iomap_write_begin+0x408
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096 foliop=0xffffb32c296b7b80
!    4us [-ENOMEM]  iomap_get_folio
iter=&{.inode=0xffff8c67aa031138,.len=4096,.flags=33,.iomap={.addr=0xffffffffffffffff,.length=4096,.type=1,.flags=3,.bdev=0x…
pos=0 len=4096

This is likely a regression caused by 66dabbb65d67 ("mm: return an ERR_PTR
from __filemap_get_folio"), which moved error handling from
io_map_get_folio() to __filemap_get_folio(), but broke FGP_NOWAIT handling, so
ENOMEM is being escaped to user space. Had it correctly returned -EAGAIN with
NOWAIT, either io_uring or user space itself would be able to retry the
request.
It's not enough to patch io_uring since the iomap interface is the one
responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
the proper error too.

The patch was tested with scylladb test suite (its original reproducer), and
the tests all pass now when memory is pressured.

Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
---
v3: make comment more descriptive as per hch's suggestion.
---
 mm/filemap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..3e75dced0fd9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1986,8 +1986,19 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/*
+			 * When NOWAIT I/O fails to allocate folios this could
+			 * be due to a nonblocking memory allocation and not
+			 * because the system actually is out of memory.
+			 * Return -EAGAIN so that there caller retries in a
+			 * blocking fashion instead of propagating -ENOMEM
+			 * to the application.
+			 */
+			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
-- 
2.48.1


