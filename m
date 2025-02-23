Return-Path: <linux-kernel+bounces-528005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DDA41269
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B3B1894467
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4022D4DE;
	Sun, 23 Feb 2025 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="kFiCdBbx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1271C84C8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740355075; cv=none; b=X1y9+3eXU334f6ylHT4aFhx5cunoZEAeV/5aLM50zR5JexZ3BWt4VcKXA5TXE1D+MhAcbW9YqRULhMYN5l2Hgf6iPWV/a2Y8dNySLxNGFaA41fPyEg1c+EBn0Zxp6KyUvEugQfjnPaV/zS5R5zH8xZ2EkqQCYN5gSQbvjlU5UXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740355075; c=relaxed/simple;
	bh=7nLZmznjt4Y25tiSorvW7p+/KnVD0t69i2xjc2UpgZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqCQO3LHK8FZe1iaCly6+WY7DOePoHSfSMljBmCdOs7alpGf5nDVv57+eee91Yy8gQ1gP9iZ2vJzTvtfwISl62+uc8NBsBToemB2XUfG2bzQfzjtcbOO5/2Fr6cORYU3FKzdfqgRENvZnt40cDZeC5jq8vlmCDZiczc+0z05kN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=kFiCdBbx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21c2f1b610dso109844615ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740355073; x=1740959873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sE2GEpXJe9EB8mr89rPCKxGhWxzC9G93uMNlCaajPCo=;
        b=kFiCdBbxg5jTIKB24iP8bf2B1LHChl/xrzmeuaQK1abm05yKLqrPAZ7d2xerpbXG15
         AfpkFg5QehNlGv4V2Ojn0uFJnKtloIC31Puz730XVj1tdQXdc595mD6ZAVFEcsgiggn4
         DgxfDuXKLIXsWffnGfkxH1iWTcI0ZjUaP8R+nc47PKUcx3/EZ5zaNPnQDDtYgBUm1ehh
         S4qclwl2aUA7ghnyEdyaEuQEiL/RGSdQm/ijDLYIdgUs8RHLKLG4tQDE7ttjBCpJTBdn
         ek4DaoytnEtp1m84pvj+rbkVhNtnD6l49IcdiiMfR2BAeAhhkwVfazTxpXEb9Ei5Q5dV
         lp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740355073; x=1740959873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE2GEpXJe9EB8mr89rPCKxGhWxzC9G93uMNlCaajPCo=;
        b=bymaUuqvOaoY8E4TdsxkxC2JVuWnNytyHIbMGkxMRpFdmciJ/zrMl86jRi2aaisR46
         7wpGNRd4ve9127hmhBKuWSRUSAjvZSn0yxgCnTpLfk8lMqkCSaCQU12oZNvnoedLnYP0
         ZZwu51ywQRhLgIlMjp/7/uv1UaFHmrIRw7cEPZnyMIqmJDg+bIeJm3LoHoNXH6UibeNc
         vLEBqR7d+xjtcCaJfrN72RDPNw9rg0gP4/gnPIPTwfyi6JQNK6QDNlcVF3XUKqw2tCRO
         33+sfzZ4BfDbgIP3owcgpDLiLV7dMmNC0E1KTHkus4vMWAD9qu1VWePm1nLDDrZahkEl
         cdUQ==
X-Gm-Message-State: AOJu0Yyo7sUTK0B6c8It/GEp1iMtQkaP5hsv9jttM0zbk/EE9VeBoeyv
	d9P1p9VRv3Nk7Fm/M2klLZVa1Y47XM7NRYEK2xVpi4hkcx7lC0jKb0NpDzaNU6a4tOhodOkQesJ
	LCNBsFn9Ws+pn4tJBnH0fRWAFdYeceGUeiziECzJHPyUDWIYD54F3R8g0be4wjR3X/gyGVAecNB
	Va5DHJtGaR+ZmGWDaR383SMilbV9mAEFkKt/j60J+oLWwALV5DQ7cgSDK5n+jCcKeref3G699/R
	Pitudr8IgKEt79QT1+dt6jMmrQPdW77jBEcVfPMNVC4v+1Kva6Y8xw0o4ryGLsa2ZDsj0PRNCPN
	uDHxX4y/mNUQC5SnfTdyAGSbx2cRMre862I6tdfVCs/P7FUh28NcfqNVeLA=
X-Gm-Gg: ASbGncsy0wE5eA/5BcYIQoJq/+Gi9W/fhAnpYUljNNr9/nlBChdDfHSgCtqPUbc5zNT
	zYuEAQpziKDyBe9Up0b6+IuHMRNorxOLn7O2LIlW1jzMSK4EkPqlLa/emIIXNRibWVQCnV+mEUd
	jfA0Q87TcIBkaSbr5Vx+RQxK3mp3IA4JiKhTFEuqBN2a0+eXfvPrb1Isr4dazLYK/aVvp/EaKrG
	ROGIADThiuGEa/LuD9RCmnECk7sh7+NoLbHCIGqPEcTgVeblHX3PNqzAXG7/q5lN3F5zYhMNi73
	tQ0EH00dDbzPQNRWjbbi/K+WUQ6wow==
X-Google-Smtp-Source: AGHT+IHw7//riiQsuVb5lGlLqWGLYjjfKu88D1cSIxhylJZNIWrjx2825KOCcROlA96N4e6VRrJx6A==
X-Received: by 2002:a05:6a21:6004:b0:1ee:c6bf:7c59 with SMTP id adf61e73a8af0-1eef3cdcb24mr19667494637.23.1740355072878;
        Sun, 23 Feb 2025 15:57:52 -0800 (PST)
Received: from localhost.localdomain ([2a09:bac5:7a2:24be::3a9:14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae0950ecb95sm9641091a12.41.2025.02.23.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 15:57:52 -0800 (PST)
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
Subject: [PATCH] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
Date: Sun, 23 Feb 2025 20:57:19 -0300
Message-ID: <20250223235719.66576-1-raphaelsc@scylladb.com>
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
returned ENOMEM despite there was plenty of available memory. The user space
used io_uring interface, which in turn submits I/O with FGP_NOWAIT (the fast
path).

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
from __filemap_get_folio"), which performed the following changes:
    --- a/fs/iomap/buffered-io.c
    +++ b/fs/iomap/buffered-io.c
    @@ -468,19 +468,12 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
    struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
    {
            unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
    -       struct folio *folio;

            if (iter->flags & IOMAP_NOWAIT)
                    fgp |= FGP_NOWAIT;

    -       folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
    +       return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
                            fgp, mapping_gfp_mask(iter->inode->i_mapping));
    -       if (folio)
    -               return folio;
    -
    -       if (iter->flags & IOMAP_NOWAIT)
    -               return ERR_PTR(-EAGAIN);
    -       return ERR_PTR(-ENOMEM);
    }

Essentially, that patch is moving error picking decision to
__filemap_get_folio, but it missed proper FGP_NOWAIT handling, so ENOMEM
is being escaped to user space. Had it correctly returned -EAGAIN with NOWAIT,
either io_uring or user space itself would be able to retry the request.
It's not enough to patch io_uring since the iomap interface is the one
responsible for it, and pwritev2(RWF_NOWAIT) and AIO interfaces must return
the proper error too.

The patch was tested with scylladb test suite (its original reproducer), and
the tests all pass now when memory is pressured.

Signed-off-by: Raphael S. Carvalho <raphaelsc@scylladb.com>
---
 mm/filemap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..b06bd6eedaf7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1986,8 +1986,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/*
+			 * Presumably ENOMEM, either from when allocating or
+			 * adding folio (this one for xarray node)
+			 */
+			if (fgp_flags & FGP_NOWAIT)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
-- 
2.48.1


