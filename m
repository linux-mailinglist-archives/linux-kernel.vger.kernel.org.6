Return-Path: <linux-kernel+bounces-429767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DE9E2365
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D42866F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E8209673;
	Tue,  3 Dec 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zawtuFyk"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB56207A04
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239982; cv=none; b=sY396jZp45Ioiv00ryIxUeuurgo1SqBk4oWwj8AHt32rJ1X5DWHEz2Evs/CzKzyhdLPXvDnYLL6p8mhE3nd3zETVtnfnGUX+UZTrUi/P+Q5M9IMyqqNJMyghYnUzKdz4/wj7I31ttT458yOIQ7ZJcc/KAwhaBW3qOSLU9+R+I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239982; c=relaxed/simple;
	bh=+Kcl03qnXK2xysxVuDL9GwHkxgxUkvV623M1SHc2Ce8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHQ29sIP+IzpbNjvDcPpjg7LW584XvZKOwvIlXBk/VN8LqusZ40Vu0YO+fYwbYHkRItbrkhVbY3qg3geb/ERgb1faoky+OMXop8tSrmPBaPAASRRGFEmiKfT4hWynHx2WZVT2cOg03PclzYH4X60EHsZRNrWRjG8zGqxBWmewKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zawtuFyk; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ea411ef5a9so2747596b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239980; x=1733844780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckrp5/MogNB2HvhzJuNOPyu1ag5BruWn5XeKlERZse0=;
        b=zawtuFyksJZVwTNlOSWuLl0I7/NrJnGwM6osw35w7RF+X4LrOQBsIpdgqB21N2DG/L
         hs2QdLfiE//80U5o1IqKVnvGP/5rJciwzgJESHGtoiAGmd2A8D07PvYIoD/qq09Z7Hqd
         XvzlipIh94GKK1kJnwgRE3/19xA5Q9ihvdRUc1Slmyqe7J5l9co69/51Jva6CzI66LUW
         9bMDGOXzlwMfzaK28tdx1giFwMEZS3GcXInjHWOOzqqbNyxG/kcGgC+tl1F3JdjMIycd
         kJ6BWTh3DFaDiIFxiFYz+iLsRlVvoYLhAzfZBlP49LBl3KnRdlxMazAvHXaCyDlSJdFv
         fJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239980; x=1733844780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckrp5/MogNB2HvhzJuNOPyu1ag5BruWn5XeKlERZse0=;
        b=qf72R8pQ5iaZLCsC6w73FHYLT71sgdlJZnn43m70LwW+AtmLrkPxIBIofUbtwr36Th
         wjSN0MlzUS2xSBOiYMiQZgdtVRetgGWs4M4ESCUm7lAxsQpEoKj08gGusKsDvklEAnS/
         u3XBOi0+vaHNoNEg1jX1oGr88+X0dvj6yLmGhwkzJFUqbY5qkvcd9q7zgwM/BHpHdHm1
         qY2SkhLmvTHf4uZx3Y8OHnbx6p4WnTaPYB6UduNK+qQorXf38rt1sthmjS7M6qBNPffg
         Xgb46r1LZ8EwUAbby5lfb8LkzMxnaEfpK5b9vcOn25m0mVhsMJqiEfI5IbfVUI/+GW6R
         Mufw==
X-Forwarded-Encrypted: i=1; AJvYcCUgXUYFIUAlpIwE6HhS/swM+j3yF4sVs5QEy6qDvEkASh68FgfXL6JkXaBLx3IWvWnIdv/6+IDurGGrTjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3KTaL88sWOwAPKRQJcxQsHZ9SH3AGIHcpnOZul5TFyZUn4a0
	NCNtJE97mJ7NSdB5AVaIlzaqkM9B43Hc4hu/Y1bSQTb9qeshEejLMkYoBZSSkx4=
X-Gm-Gg: ASbGncvIZUl0quSK27PW872eblCp+bOk8wtKrtWc3vOya4RPQhGcVFOyyma7Eal/mJT
	PFbHszwnRt+McFVIpIKNTYRH/PA66iVVeEYzMIyE8dryMqb0ymQc8/ha6A5FE+Nzel3iXIDxL9v
	BDK62m/POB4Jjsdd66E/2b9wLWWIHwnDisciMlcHbGCbJNorsjtz5YzfOS8SbBzvwjP9fgHdOGL
	ILRqjmWm8nbNGxo9g5Q2sczSdVAfp8L0GP2zCZes6ZyIH1A9KQ9aFuip9c=
X-Google-Smtp-Source: AGHT+IG43FQHTFqL4PqM6F3qojzARV1JxsiCZ9D3Zgsdfa2TEHjYK26CmkPy2H7KTh+zkEYZWpQaaw==
X-Received: by 2002:a05:6808:3085:b0:3ea:52b7:ebdd with SMTP id 5614622812f47-3eae50c51b8mr2904392b6e.42.1733239980115;
        Tue, 03 Dec 2024 07:33:00 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:59 -0800 (PST)
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
Subject: [PATCH 10/12] mm/filemap: add filemap_fdatawrite_range_kick() helper
Date: Tue,  3 Dec 2024 08:31:46 -0700
Message-ID: <20241203153232.92224-12-axboe@kernel.dk>
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
index b64a78582f06..40383f5cc6a2 100644
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
index eb6a8d39f9d0..826df99e294f 100644
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


