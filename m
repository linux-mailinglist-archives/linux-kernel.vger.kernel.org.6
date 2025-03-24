Return-Path: <linux-kernel+bounces-573236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26DAA6D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76B1188B532
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8C2505A0;
	Mon, 24 Mar 2025 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWFDVtTu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68861282F0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800183; cv=none; b=KRZxQy88G1APVfj5HvrdcaMEEaawbCVPELjXjX2kAvLu7NHQgmdpymHRZjPx0zFwE6f7O6De+c1XgZ1Dlz5hcMTEXBYHWt7TgEb9FV8tiNba1ccDTTjR1rrgf/EhYO8ceRMrAj5//fHBtny0mJkWZQLQZfAPYSdQEascdBmva4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800183; c=relaxed/simple;
	bh=fkKUf+rmy42MAGfz4Uw430tlPF+nBJ6G5oQfO0NTSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSIhGbMPef+z10dZjRGE5ht8O0nvq404NKs4BMadlOrUVlXM8qGlBJIJWhC2DertfQUseYe5reAyUlxgH5qGKlJp+6E8y10jNhU7f9hUL8kpgxiSKJOAkHBZAZafZmlrWYBvFXcb0dMHR3ZrQyHrQvioSMUD8HK3jcY5k4r1sPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWFDVtTu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso98502355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742800180; x=1743404980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W79sq2DoA2VKaacTSC34apFP8WYj+YQQer7GFXkhKBQ=;
        b=DWFDVtTuR58Sd7GNxgBkEfU20Kdyv2z5Po5dhaqEUntv1u00g0EwJW26XnyXdlPglg
         Qva3TvMRWwYQ3EOacEjXs3ChVdCPJTJ7vuOnZZx6lybccPw/bNBRk1iQrN/dmXYe4K9a
         JWrJhUEbiw1hJ7fWzuQ82TUfZptfEW7dyxRx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800180; x=1743404980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W79sq2DoA2VKaacTSC34apFP8WYj+YQQer7GFXkhKBQ=;
        b=becwJ0Cu7aF8h/VNOmaAWEqTusr+u8z0+yhO/HBDobKgVcp31IzrNlO/S10gsf85zC
         PoQWx2WnzFOV3QcMDFs/FBV+UHup7lt5AqZgyZinhJr75bzw38SPb/n5QlqGS7CSIP9v
         jzQ9OgQS1A6tfymMcOTUpT4sBUbWK65visFH792Nnz+ObOarK1ZnWr2x65YySraLfLLw
         FVIP9xTTyns8pwtnQDbk02e9r655eEuC1jCNgX7/ZvAx1mpBWHtjRk6bQfYqeyRD+NhQ
         J9wimWPQQsLubB7tONcDZIzQs8W3Cl+P0HDtIDBCULhDEkdyl0hA0ORdNcWAeXdHvyx7
         I0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVGpea8GEaDqM6aD5WLs7Sw/kepUd03hsq5CKPu0qkuaMLBm7Fz/aAhaWSRyxHI1V1sEKXbEHU3HNtAvq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZuWivpRd11sz30wONoCfs9g1M/JTN5yOHFhWFHCjJf0hic6E
	VF44FeXRM0MpEmiytiYOXFHm+7Ej3CtElMWPmUFsnU4sdlBbxn3dLR3MMz8EdZQ1k0nz+a3lH41
	LGQ==
X-Gm-Gg: ASbGncuSwdu6r+WZBrx2f0Xl6o21TRWuQ42o8nAgfB3/RCBCSNoIv7p9QZcmucT/8NN
	ZplNCyrwbMHiFmCgajh5/gT5l+nBIRRp6WLjZ+o7evVQDvwA6NtcAmVOUduXEtziC/LqzC230n5
	adSzT41234IdHeiwVa1YX80wesb8wrCzATQ+fX7807x3gcWyFvjIzB9AUnI0WnJwbIABhXxL66l
	ZsjIJuufz6cC+h7+K9XfDO3tjKKWV+lFfynEQ5v5U3ND48Sb+QGFJLLybLaEKNu/pPnKvjcBuhm
	1YmKKqq9HinG2suMYyWTgm8kBQIsBmEWGlWTew4vzBG/rwwfq7t+irYhuoY=
X-Google-Smtp-Source: AGHT+IFT7BS6GiZQhmnZ9D+DMV2M2e4bANx2H9TywbQbwJbXwVC5mo1y1e4AxitzF87kyA5QDP60Qw==
X-Received: by 2002:a05:6a20:2589:b0:1f5:7873:3052 with SMTP id adf61e73a8af0-1fe42f35932mr21301860637.11.1742800180411;
        Mon, 24 Mar 2025 00:09:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f38f:d38c:cfee:a113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739061592b9sm7095170b3a.152.2025.03.24.00.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:09:39 -0700 (PDT)
Date: Mon, 24 Mar 2025 16:09:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] zram: introduce writeback_ext interface
Message-ID: <jg6qgkc2myipf2p6ewqyckhvu4nhwnzyb4ncpj2wggbjm42nkx@kzug7r6dt6mz>
References: <20250324065029.3077450-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324065029.3077450-1-senozhatsky@chromium.org>

On (25/03/24 15:45), Sergey Senozhatsky wrote:
> 
> Alternatively I can just extend writeback and say something like
> "starting from 6.16 it also accepts indices ranges" in zram's
> documentation.

See below.

Maybe this is actually fine and we don't need a new sysfs file.



Subject: [RFC PATCH] zram: modernize writeback interface

Extend page writeback with page indices ranges.  The previous interface
could write only one page at a time:

    echo page_index=100 > zram0/writeback
    ...
    echo page_index=200 > zram0/writeback
    echo page_index=500 > zram0/writeback
    ...
    echo page_index=700 > zram0/writeback

One obvious downside is that it increases the number of syscalls.
Less obvious but significantly more important downside is that when
given only one page to post-process zram cannot perform an optimal
target selection.  This becomes critical when writeback_limit is
enabled, because under writeback_limit we want to guarantee the
highest memory savings.  The new interface supports multiple page
indices ranges in a single call:

    echo page_index_range=100-200 \
 	 page_index_range=500-700 > zram0/writeback

This gives zram a chance to apply an optimal target selection
strategy on each iteration of the writeback loop.

Apart from that the new interface unifies parameters passing and
resembles other "modern" zram device attributes (e.g. recompression),
while the old interface used a mixed scheme: values-less parameters
for mode and a key=value format for page_index.  We still support
the "old" value-less format for compatibility reasons.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |   8 +
 drivers/block/zram/zram_drv.c               | 321 +++++++++++++-------
 2 files changed, 224 insertions(+), 105 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 9bdb30901a93..753543751c28 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -369,6 +369,14 @@ they could write a page index into the interface::
 
 	echo "page_index=1251" > /sys/block/zramX/writeback
 
+Starting from 6.16, this interface supports `page_index_range` parameters
+(multiple ranges can be provided at once), which specify `LOW-HIGH` ranges
+of pages to be written-back.  This reduces the number of syscalls, but more
+importantly this enables optimal post-processing target selection strategy.
+Usage example::
+
+	echo "page_index_range=1-100" > /sys/block/zramX/writeback
+
 If there are lots of write IO with flash device, potentially, it has
 flash wearout problem so that admin needs to design write limitation
 to guarantee storage health for entire product life.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fda7d8624889..f267d562518c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,114 +734,19 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-#define PAGE_WB_SIG "page_index="
-
-#define PAGE_WRITEBACK			0
-#define HUGE_WRITEBACK			(1<<0)
-#define IDLE_WRITEBACK			(1<<1)
-#define INCOMPRESSIBLE_WRITEBACK	(1<<2)
-
-static int scan_slots_for_writeback(struct zram *zram, u32 mode,
-				    unsigned long nr_pages,
-				    unsigned long index,
-				    struct zram_pp_ctl *ctl)
+static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 {
-	for (; nr_pages != 0; index++, nr_pages--) {
-		bool ok = true;
-
-		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
-			goto next;
-
-		if (zram_test_flag(zram, index, ZRAM_WB) ||
-		    zram_test_flag(zram, index, ZRAM_SAME))
-			goto next;
-
-		if (mode & IDLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_IDLE))
-			goto next;
-		if (mode & HUGE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_HUGE))
-			goto next;
-		if (mode & INCOMPRESSIBLE_WRITEBACK &&
-		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
-			goto next;
-
-		ok = place_pp_slot(zram, ctl, index);
-next:
-		zram_slot_unlock(zram, index);
-		if (!ok)
-			break;
-	}
-
-	return 0;
-}
-
-static ssize_t writeback_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct zram *zram = dev_to_zram(dev);
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct zram_pp_ctl *ctl = NULL;
+	unsigned long blk_idx = 0;
+	struct page *page = NULL;
 	struct zram_pp_slot *pps;
-	unsigned long index = 0;
-	struct bio bio;
 	struct bio_vec bio_vec;
-	struct page *page = NULL;
-	ssize_t ret = len;
-	int mode, err;
-	unsigned long blk_idx = 0;
-
-	if (sysfs_streq(buf, "idle"))
-		mode = IDLE_WRITEBACK;
-	else if (sysfs_streq(buf, "huge"))
-		mode = HUGE_WRITEBACK;
-	else if (sysfs_streq(buf, "huge_idle"))
-		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
-	else if (sysfs_streq(buf, "incompressible"))
-		mode = INCOMPRESSIBLE_WRITEBACK;
-	else {
-		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
-			return -EINVAL;
-
-		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
-				index >= nr_pages)
-			return -EINVAL;
-
-		nr_pages = 1;
-		mode = PAGE_WRITEBACK;
-	}
-
-	down_read(&zram->init_lock);
-	if (!init_done(zram)) {
-		ret = -EINVAL;
-		goto release_init_lock;
-	}
-
-	/* Do not permit concurrent post-processing actions. */
-	if (atomic_xchg(&zram->pp_in_progress, 1)) {
-		up_read(&zram->init_lock);
-		return -EAGAIN;
-	}
-
-	if (!zram->backing_dev) {
-		ret = -ENODEV;
-		goto release_init_lock;
-	}
+	struct bio bio;
+	int ret, err;
+	u32 index;
 
 	page = alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
-	ctl = init_pp_ctl();
-	if (!ctl) {
-		ret = -ENOMEM;
-		goto release_init_lock;
-	}
-
-	scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
+	if (!page)
+		return -ENOMEM;
 
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
@@ -929,10 +834,216 @@ static ssize_t writeback_store(struct device *dev,
 
 	if (blk_idx)
 		free_block_bdev(zram, blk_idx);
-
-release_init_lock:
 	if (page)
 		__free_page(page);
+
+	return ret;
+}
+
+#define PAGE_WRITEBACK			0
+#define HUGE_WRITEBACK			(1 << 0)
+#define IDLE_WRITEBACK			(1 << 1)
+#define INCOMPRESSIBLE_WRITEBACK	(1 << 2)
+
+static int parse_page_index(char *val, unsigned long nr_pages,
+			    unsigned long *lo, unsigned long *hi)
+{
+	int ret;
+
+	ret = kstrtoul(val, 10, lo);
+	if (ret)
+		return ret;
+	*hi = *lo + 1;
+	if (*lo >= nr_pages || *hi > nr_pages)
+		return -ERANGE;
+	return 0;
+}
+
+static int parse_page_index_range(char *val, unsigned long nr_pages,
+				  unsigned long *lo, unsigned long *hi)
+{
+	char *delim;
+	int ret;
+
+	delim = strchr(val, '-');
+	if (!delim)
+		return -EINVAL;
+
+	*delim = 0x00;
+	ret = kstrtoul(val, 10, lo);
+	if (ret)
+		return ret;
+	if (*lo >= nr_pages)
+		return -ERANGE;
+
+	ret = kstrtoul(delim + 1, 10, hi);
+	if (ret)
+		return ret;
+	if (*hi >= nr_pages || *lo > *hi)
+		return -ERANGE;
+	*hi += 1;
+	return 0;
+}
+
+static int parse_mode(char *val, u32 *mode)
+{
+	*mode = 0;
+
+	if (!strcmp(val, "idle"))
+		*mode = IDLE_WRITEBACK;
+	if (!strcmp(val, "huge"))
+		*mode = HUGE_WRITEBACK;
+	if (!strcmp(val, "huge_idle"))
+		*mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
+	if (!strcmp(val, "incompressible"))
+		*mode = INCOMPRESSIBLE_WRITEBACK;
+
+	if (*mode == 0)
+		return -EINVAL;
+	return 0;
+}
+
+static int scan_slots_for_writeback(struct zram *zram, u32 mode,
+				    unsigned long lo, unsigned long hi,
+				    struct zram_pp_ctl *ctl)
+{
+	u32 index = lo;
+
+	while (index < hi) {
+		bool ok = true;
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+		    zram_test_flag(zram, index, ZRAM_SAME))
+			goto next;
+
+		if (mode & IDLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
+			goto next;
+		if (mode & HUGE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
+			goto next;
+		if (mode & INCOMPRESSIBLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+			goto next;
+
+		ok = place_pp_slot(zram, ctl, index);
+next:
+		zram_slot_unlock(zram, index);
+		if (!ok)
+			break;
+		index++;
+	}
+
+	return 0;
+}
+
+static ssize_t writeback_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long lo = 0, hi = nr_pages;
+	struct zram_pp_ctl *ctl = NULL;
+	char *args, *param, *val;
+	ssize_t ret = len;
+	int err, mode = 0;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	/* Do not permit concurrent post-processing actions. */
+	if (atomic_xchg(&zram->pp_in_progress, 1)) {
+		up_read(&zram->init_lock);
+		return -EAGAIN;
+	}
+
+	if (!zram->backing_dev) {
+		ret = -ENODEV;
+		goto release_init_lock;
+	}
+
+	ctl = init_pp_ctl();
+	if (!ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * Workaround to support the old writeback interface.
+		 *
+		 * The old writeback interface has a minor inconsistency and
+		 * requires key=value only for page_index parameter, while
+		 * writeback mode is a valueless parameter.
+		 *
+		 * This is not the case anymore and now all parameters are
+		 * required to have values, however, we need to support the
+		 * legacy writeback interface that's why we check if we can
+		 * recognize a valueless parameter as a (legacy) writeback
+		 * mode.
+		 */
+		if (!val || !*val) {
+			err = parse_mode(param, &mode);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		if (!strcmp(param, "type")) {
+			err = parse_mode(val, &mode);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		if (!strcmp(param, "page_index")) {
+			err = parse_page_index(val, nr_pages, &lo, &hi);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			break;
+		}
+
+		/* There can be several page index ranges */
+		if (!strcmp(param, "page_index_range")) {
+			err = parse_page_index_range(val, nr_pages, &lo, &hi);
+			if (err) {
+				ret = err;
+				goto release_init_lock;
+			}
+
+			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			continue;
+		}
+	}
+
+	err = zram_writeback_slots(zram, ctl);
+	if (err)
+		ret = err;
+
+release_init_lock:
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.49.0.395.g12beb8f557-goog


