Return-Path: <linux-kernel+bounces-284959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE4950755
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22DF1C22A69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6289E19EEC7;
	Tue, 13 Aug 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azkwPqRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991F19EEB6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558440; cv=none; b=iP4Pzy3FQGRLdhIKbSesI60UQXh1eOACPWEorZSsp1LPEQsRvcQjpKA7yBm2gyf9wzkzvOrokgRO4fgaWI8UQA0QU3+5lygEZDWzhLvngL91OTVS6dJdDu7JLy9G3waJulLYxNuKgnofeyCY4pYVmLdtoDCysl+LuXawcPMHQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558440; c=relaxed/simple;
	bh=+Rahtg2CIbqQVDwx0J+IxStkz1u33ze7GCP87Z5bhDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCxPFAeka/emssZspP3R0/mQvQ99OZOS4xCFCmn8a6jKBJ/VtiQKsUW6KkkEhWAHqp1h2rt9uiT+w1My8M5AqLZyvDQTjh6QjJWDYwYAt/IemTU1p1N8OlCioIsNuqqF1TWnRg4nvo9tU5V7q22zpOnB+H5PYLxTpWMlYR8t76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azkwPqRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF9DC4AF11;
	Tue, 13 Aug 2024 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723558440;
	bh=+Rahtg2CIbqQVDwx0J+IxStkz1u33ze7GCP87Z5bhDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azkwPqRfL6kB75jA+pqe+ygYJJV/FrIXp79ryh2MjDe6l9aF+7/8bbWxzpTHMQFm2
	 7RFyhMAzw2BHCVZNj78tyeVGZzzP5CGKx+QXsLuZAsOOPOcJQgomYIqhqkxHa3zFKo
	 w2me4nsj27Tbom/J9J16Tom96uQagm2Avj1KsxT9wuHZWSwemdPkgZ59l+KbGcS8JW
	 SqYW/r+LmwSIDyj5a77se9l2UghPwZcqqOI45l6HXB1JR+rL1l/LXSaImKvPFX0FfE
	 5dEDxiTJOI8g2hJYucr/KDKj4P1lMR1p3U8wAQrshzW4t259xs4wkVxyk5xEIXLO1P
	 ZRuY/bcCD+bjQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 9/9] f2fs: convert f2fs_handle_page_eio() to use folio
Date: Tue, 13 Aug 2024 22:13:31 +0800
Message-Id: <20240813141331.417067-9-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
References: <20240813141331.417067-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 fs/f2fs/f2fs.h       | 6 ++++--
 fs/f2fs/node.c       | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ffaf295a198a..7f76460b721f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -99,7 +99,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	}
 
 	if (unlikely(!PageUptodate(page))) {
-		f2fs_handle_page_eio(sbi, page->index, META);
+		f2fs_handle_page_eio(sbi, page_folio(page), META);
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c29ed8b6eea6..28b6246e07f9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4666,9 +4666,11 @@ static inline void f2fs_io_schedule_timeout(long timeout)
 	io_schedule_timeout(timeout);
 }
 
-static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
-					enum page_type type)
+static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi,
+				struct folio *folio, enum page_type type)
 {
+	pgoff_t ofs = folio->index;
+
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2b764c86aacc..7beaa3690e03 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1492,7 +1492,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 out_put_err:
 	/* ENOENT comes from read_node_page which is not an error. */
 	if (err != -ENOENT)
-		f2fs_handle_page_eio(sbi, page->index, NODE);
+		f2fs_handle_page_eio(sbi, page_folio(page), NODE);
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
-- 
2.40.1


