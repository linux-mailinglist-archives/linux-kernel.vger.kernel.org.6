Return-Path: <linux-kernel+bounces-445122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B69F119B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC005281E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC441F03DA;
	Fri, 13 Dec 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xBsqQG4W"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0371EF088
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105379; cv=none; b=Oming3qvMgxel8pbe1UQ7eeiqtKPJ/NyKxujXJhmd/vi1hHmiBRPzSdWgMYzZChHWkuCiFhtFMEwgitRfunOuCFDBgawxmcJQY2usvHeRFuyOqqbDwU10zgEmKrSsmk3J8aaI9snTR/xnjooLfmzqjFXycNp5ZPihVM5V8aVVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105379; c=relaxed/simple;
	bh=5nnCX/ugaux253bLZRpzYYnFsErlHtBtfq4h5ryDOj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0hp9ak9WnBlWM5O/JSmem7UvXw43xEiKeS4+xeaycXckjVwGb5DIAmd7B9cvIbrGQKlowxAO40ROMFT6pKiT61EUdVLBuQft5HKAOn4wPIJdj3pYXpOXA61Xxgr7+3ObAHuWor12HJAS5w38YP0dXV/oMvQr6k0UZJ3DiX5UpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xBsqQG4W; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8160382d4so6011025ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105377; x=1734710177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJvpEUV5aCutO0n1vzbjd3IdvpDLlQuRWwd0hw2DTJ8=;
        b=xBsqQG4WWzJ40QYjSZYrM1RDXg+bzMi0GiUO4zqLy4cZRfW+o08/20ZGDrQY2xx9tf
         2fAeWjLv/apNFx53ZsgOSVYfiGEZLt5NFsXDnQVtMBkp7FdI15rVO/VBgloMjPVb9Y8e
         F9aulmRj6oBbflzIRYO0Xo+jwlNYxQx0IoMqkyCRXZs+d7g4EkS7Ag/x7ZCSHTSHp6aL
         qHHHHQgJX0+3U21vc7pIVSiochjtnyM4woNvbvqAQasC52GPpCW4bPnXN9/GiwULZNpJ
         p7uaYm3Is+Kx952PvSZDTwAHZR/+q9OASOfMBkVMItN4iJJBOkhYumDdsl+m72lJ0XDD
         Rakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105377; x=1734710177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJvpEUV5aCutO0n1vzbjd3IdvpDLlQuRWwd0hw2DTJ8=;
        b=IH/cDNFIrBYuEUg+DMDn6x49OXHN77rTyO0IALD50T/H5wAvA4XRHDqzvaGugNsx4W
         H2VS9udd0DcnGAnOu3Zc3aFqifz2VoFY6+UJGErWzbpbX3FSvV9vMYIgnq33N5/zUdE2
         1c+s9KL3W5/cAkTMfUMn6VEsDMzzK/U74rlIgsWC81jaWk9MShpy37YRhAx3iBknbS71
         rbDE9H2glezdy15u06VHx98PC6cv1y7WLfoTfTgt4DpvdvY9MTL4qM83cyhgFmKzigeU
         LaeFuueDfDstOHx1r/2SDAxNKDIWzIJ1FV8rQUkQHNIa5IrHUxl1mTUAnN0AHhsDNAgv
         xEyg==
X-Forwarded-Encrypted: i=1; AJvYcCUtc8ni4Myzyjrk8yHuw/BBQwfe9Rv0ItnYscn8pj9XNH+m3g8l7vdRdw/Gp4sVccuo1/Q3KS8mVHlAyL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2HItANUuDxK3YkYVDeds9+8Pq1mq4Hl1UqzqYndX4GxlGkMD
	S3D8Rhlj5VflsNHBVhkxfK2TARQGTYy8tL9MqSxSaCPAC/y2cHcbs9zKdTExYtU=
X-Gm-Gg: ASbGncsyUGHh5LUMOYa+b+LWBLNbg3exxpvFpst/qhgpdMuwSL9gZFf2hFC+lrCmXMa
	FkdyNXq5IY8uRS8/HeUbpIXkVQHUxjnrzK+1oKfHLpPCtD36buDmRgYpJVeDRUFMJvtLq2Wd3kK
	gQsWPMQ7AiqNHaa/EdK0J8T4ce7xJ1Js2QIhXxiRE/kaJpy5WaOaKrpMGmbf1TFXZPDOOAmPpmr
	E5gbHcIV0WFdMs5tOYvoo3W+EtYq3WAOBP/YXr5sHwHKG0Do4eRxkZCaEL9
X-Google-Smtp-Source: AGHT+IGauJ9uKAF5WxLAKMTF0QyH5oGnff/+E24GczIOzswP0NPnXSGxgq/rQ7IZv36KxS5lv0tqHw==
X-Received: by 2002:a05:6e02:1564:b0:3a2:6cd7:3250 with SMTP id e9e14a558f8ab-3aff50b64c1mr29557815ab.10.1734105377176;
        Fri, 13 Dec 2024 07:56:17 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:16 -0800 (PST)
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
Subject: [PATCH 10/11] mm/filemap: add filemap_fdatawrite_range_kick() helper
Date: Fri, 13 Dec 2024 08:55:24 -0700
Message-ID: <20241213155557.105419-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Works like filemap_fdatawrite_range(), except it's a non-integrity data
writeback and hence only starts writeback on the specified range. Will
help facilitate generically starting uncached writeback from
generic_write_sync(), as header dependencies preclude doing this inline
from fs.h.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a838b5479a6..653b5efa3d3f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2878,6 +2878,8 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
 extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+		loff_t end);
 
 static inline int file_write_and_wait(struct file *file)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index ec087bab1c97..7db995cb5179 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -449,6 +449,24 @@ int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
 
+/**
+ * filemap_fdatawrite_range_kick - start writeback on a range
+ * @mapping:	target address_space
+ * @start:	index to start writeback on
+ * @end:	last (non-inclusive) index for writeback
+ *
+ * This is a non-integrity writeback helper, to start writing back folios
+ * for the indicated range.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+				  loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+}
+EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space
-- 
2.45.2


