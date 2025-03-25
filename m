Return-Path: <linux-kernel+bounces-576210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF9A70C68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF9188E2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0E2580E1;
	Tue, 25 Mar 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGQBnbQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F1A8F60
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939571; cv=none; b=S6DqXIQNb2qvlvC7+OAmkdGP0PWfJ2tI5V5xY1qgIzhy+xLoRGm3y+zf2zLXdkJrfawd1wEcNSlUTzWednURDKY7t/FZ7dU2B1mD7FzjAKxD+87Vk+fvq4G6595BpdP7yfAWXgUeqVWt1WWYdWbQyqc0lWaLCBXC2D7DGIE/Ses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939571; c=relaxed/simple;
	bh=NQSHJPRoq6p3/bKW4T6Km0XUljDHOHwYCN2pRjDcGlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk3j+6OpKD6yy0aYfaKF0YhRlL7244WMx17I3255YaMI0Mt3l21UpcyhjrF707ampdyo+vVNWygkR53waBqxqGK+sHppdGrbtVSsGvHL+8xKGlFHvZIVsVSkNw+Ls2xvkXurVuKOL1R/rdib+vFcsBcaysQCnjKSMTLYTJBGbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGQBnbQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9D5C4CEE4;
	Tue, 25 Mar 2025 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939570;
	bh=NQSHJPRoq6p3/bKW4T6Km0XUljDHOHwYCN2pRjDcGlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGQBnbQSTYP/9hpQHiAz7NBkiCrlR5H4XPuM2edWw9A0TZ1/jCUmbHpsTyE7aIAxr
	 k5rP1kJEqT7fpgTrJrTU7y+LAX7RNcH+b8XHgyEImqaUBtDDsshmngR9POvoCCklY4
	 f0GJ12wAlgFxdBljnUbN1nKtbrBV48gIJ26IZ2n8NyPZDWGSTsUW0cu2uR3UN1XmVN
	 0NMD+tWbUvpcKc3mtI7AJvJkX2FNWA9k9c01aCUr4cs6QIvejH/n7gy37bLqcB2iVL
	 CaeW1A8YezkiwPaNEy5A69EkZlUop/9xaN/otPgFJCD2nt0VggHxCtOAt6dMJzuJnY
	 j7OMg/mNUnNLg==
Date: Tue, 25 Mar 2025 14:52:48 -0700
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>, richardycc@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: modernize writeback interface
Message-ID: <Z-MlsM2Gmxdvl_1D@google.com>
References: <20250325034210.3337080-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325034210.3337080-1-senozhatsky@chromium.org>

Ccing richardycc@google.com since he has working on this:

On Tue, Mar 25, 2025 at 12:42:04PM +0900, Sergey Senozhatsky wrote:
> The writeback interface supports a page_index=N parameter which
> performs writeback of the given page.  Since we rarely need to
> writeback just one single page, the typical use case involves
> a number of writeback calls, each performing writeback of one
> page:
> 
>     echo page_index=100 > zram0/writeback
>     ...
>     echo page_index=200 > zram0/writeback
>     echo page_index=500 > zram0/writeback
>     ...
>     echo page_index=700 > zram0/writeback
> 
> One obvious downside of this is that it increases the number of
> syscalls.  Less obvious, but a significantly more important downside,
> is that when given only one page to post-process zram cannot perform
> an optimal target selection.  This becomes a critical limitation
> when writeback_limit is enabled, because under writeback_limit we
> want to guarantee the highest memory savings hence we first need
> to writeback pages that release the highest amount of zsmalloc pool
> memory.
> 
> This patch adds page_index_range=LOW-HIGH parameter to the writeback
> interface:
> 
>     echo page_index_range=100-200 \
>  	 page_index_range=500-700 > zram0/writeback
> 
> This gives zram a chance to apply an optimal target selection
> strategy on each iteration of the writeback loop.
> 
> Apart from that the patch also unifies parameters passing and resembles
> other "modern" zram device attributes (e.g. recompression), while the
> old interface used a mixed scheme: values-less parameters for mode and
> a key=value format for page_index.  We still support the "old" value-less
> format for compatibility reasons.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/admin-guide/blockdev/zram.rst |  11 +
>  drivers/block/zram/zram_drv.c               | 321 +++++++++++++-------
>  2 files changed, 227 insertions(+), 105 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 9bdb30901a93..9dca86365a4d 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -369,6 +369,17 @@ they could write a page index into the interface::
>  
>  	echo "page_index=1251" > /sys/block/zramX/writeback
>  
> +In Linux 6.16 this interface underwent some rework.  First, the interface
> +now supports `key=value` format for all of its parameters (`type=huge_idle`,
> +etc.)  Second, the support for `page_index_range` was introduced, which
> +specify `LOW-HIGH` range (or ranges) of pages to be written-back.  This
> +reduces the number of syscalls, but more importantly this enables optimal
> +post-processing target selection strategy. Usage example::
> +
> +	echo "type=idle" > /sys/block/zramX/writeback
> +	echo "page_index_range=1-100 page_index_range=200-300" > \
> +		/sys/block/zramX/writeback
> +
>  If there are lots of write IO with flash device, potentially, it has
>  flash wearout problem so that admin needs to design write limitation
>  to guarantee storage health for entire product life.
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fda7d8624889..2c39d12bd2d4 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -734,114 +734,19 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
>  	submit_bio(bio);
>  }
>  
> -#define PAGE_WB_SIG "page_index="
> -
> -#define PAGE_WRITEBACK			0
> -#define HUGE_WRITEBACK			(1<<0)
> -#define IDLE_WRITEBACK			(1<<1)
> -#define INCOMPRESSIBLE_WRITEBACK	(1<<2)
> -
> -static int scan_slots_for_writeback(struct zram *zram, u32 mode,
> -				    unsigned long nr_pages,
> -				    unsigned long index,
> -				    struct zram_pp_ctl *ctl)
> +static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  {
> -	for (; nr_pages != 0; index++, nr_pages--) {
> -		bool ok = true;
> -
> -		zram_slot_lock(zram, index);
> -		if (!zram_allocated(zram, index))
> -			goto next;
> -
> -		if (zram_test_flag(zram, index, ZRAM_WB) ||
> -		    zram_test_flag(zram, index, ZRAM_SAME))
> -			goto next;
> -
> -		if (mode & IDLE_WRITEBACK &&
> -		    !zram_test_flag(zram, index, ZRAM_IDLE))
> -			goto next;
> -		if (mode & HUGE_WRITEBACK &&
> -		    !zram_test_flag(zram, index, ZRAM_HUGE))
> -			goto next;
> -		if (mode & INCOMPRESSIBLE_WRITEBACK &&
> -		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
> -			goto next;
> -
> -		ok = place_pp_slot(zram, ctl, index);
> -next:
> -		zram_slot_unlock(zram, index);
> -		if (!ok)
> -			break;
> -	}
> -
> -	return 0;
> -}
> -
> -static ssize_t writeback_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t len)
> -{
> -	struct zram *zram = dev_to_zram(dev);
> -	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> -	struct zram_pp_ctl *ctl = NULL;
> +	unsigned long blk_idx = 0;
> +	struct page *page = NULL;
>  	struct zram_pp_slot *pps;
> -	unsigned long index = 0;
> -	struct bio bio;
>  	struct bio_vec bio_vec;
> -	struct page *page = NULL;
> -	ssize_t ret = len;
> -	int mode, err;
> -	unsigned long blk_idx = 0;
> -
> -	if (sysfs_streq(buf, "idle"))
> -		mode = IDLE_WRITEBACK;
> -	else if (sysfs_streq(buf, "huge"))
> -		mode = HUGE_WRITEBACK;
> -	else if (sysfs_streq(buf, "huge_idle"))
> -		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
> -	else if (sysfs_streq(buf, "incompressible"))
> -		mode = INCOMPRESSIBLE_WRITEBACK;
> -	else {
> -		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
> -			return -EINVAL;
> -
> -		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
> -				index >= nr_pages)
> -			return -EINVAL;
> -
> -		nr_pages = 1;
> -		mode = PAGE_WRITEBACK;
> -	}
> -
> -	down_read(&zram->init_lock);
> -	if (!init_done(zram)) {
> -		ret = -EINVAL;
> -		goto release_init_lock;
> -	}
> -
> -	/* Do not permit concurrent post-processing actions. */
> -	if (atomic_xchg(&zram->pp_in_progress, 1)) {
> -		up_read(&zram->init_lock);
> -		return -EAGAIN;
> -	}
> -
> -	if (!zram->backing_dev) {
> -		ret = -ENODEV;
> -		goto release_init_lock;
> -	}
> +	struct bio bio;
> +	int ret, err;
> +	u32 index;
>  
>  	page = alloc_page(GFP_KERNEL);
> -	if (!page) {
> -		ret = -ENOMEM;
> -		goto release_init_lock;
> -	}
> -
> -	ctl = init_pp_ctl();
> -	if (!ctl) {
> -		ret = -ENOMEM;
> -		goto release_init_lock;
> -	}
> -
> -	scan_slots_for_writeback(zram, mode, nr_pages, index, ctl);
> +	if (!page)
> +		return -ENOMEM;
>  
>  	while ((pps = select_pp_slot(ctl))) {
>  		spin_lock(&zram->wb_limit_lock);
> @@ -929,10 +834,216 @@ static ssize_t writeback_store(struct device *dev,
>  
>  	if (blk_idx)
>  		free_block_bdev(zram, blk_idx);
> -
> -release_init_lock:
>  	if (page)
>  		__free_page(page);
> +
> +	return ret;
> +}
> +
> +#define PAGE_WRITEBACK			0
> +#define HUGE_WRITEBACK			(1 << 0)
> +#define IDLE_WRITEBACK			(1 << 1)
> +#define INCOMPRESSIBLE_WRITEBACK	(1 << 2)
> +
> +static int parse_page_index(char *val, unsigned long nr_pages,
> +			    unsigned long *lo, unsigned long *hi)
> +{
> +	int ret;
> +
> +	ret = kstrtoul(val, 10, lo);
> +	if (ret)
> +		return ret;
> +	*hi = *lo + 1;
> +	if (*lo >= nr_pages || *hi > nr_pages)
> +		return -ERANGE;
> +	return 0;
> +}
> +
> +static int parse_page_index_range(char *val, unsigned long nr_pages,
> +				  unsigned long *lo, unsigned long *hi)
> +{
> +	char *delim;
> +	int ret;
> +
> +	delim = strchr(val, '-');
> +	if (!delim)
> +		return -EINVAL;
> +
> +	*delim = 0x00;
> +	ret = kstrtoul(val, 10, lo);
> +	if (ret)
> +		return ret;
> +	if (*lo >= nr_pages)
> +		return -ERANGE;
> +
> +	ret = kstrtoul(delim + 1, 10, hi);
> +	if (ret)
> +		return ret;
> +	if (*hi >= nr_pages || *lo > *hi)
> +		return -ERANGE;
> +	*hi += 1;
> +	return 0;
> +}
> +
> +static int parse_mode(char *val, u32 *mode)
> +{
> +	*mode = 0;
> +
> +	if (!strcmp(val, "idle"))
> +		*mode = IDLE_WRITEBACK;
> +	if (!strcmp(val, "huge"))
> +		*mode = HUGE_WRITEBACK;
> +	if (!strcmp(val, "huge_idle"))
> +		*mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
> +	if (!strcmp(val, "incompressible"))
> +		*mode = INCOMPRESSIBLE_WRITEBACK;
> +
> +	if (*mode == 0)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int scan_slots_for_writeback(struct zram *zram, u32 mode,
> +				    unsigned long lo, unsigned long hi,
> +				    struct zram_pp_ctl *ctl)
> +{
> +	u32 index = lo;
> +
> +	while (index < hi) {
> +		bool ok = true;
> +
> +		zram_slot_lock(zram, index);
> +		if (!zram_allocated(zram, index))
> +			goto next;
> +
> +		if (zram_test_flag(zram, index, ZRAM_WB) ||
> +		    zram_test_flag(zram, index, ZRAM_SAME))
> +			goto next;
> +
> +		if (mode & IDLE_WRITEBACK &&
> +		    !zram_test_flag(zram, index, ZRAM_IDLE))
> +			goto next;
> +		if (mode & HUGE_WRITEBACK &&
> +		    !zram_test_flag(zram, index, ZRAM_HUGE))
> +			goto next;
> +		if (mode & INCOMPRESSIBLE_WRITEBACK &&
> +		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
> +			goto next;
> +
> +		ok = place_pp_slot(zram, ctl, index);
> +next:
> +		zram_slot_unlock(zram, index);
> +		if (!ok)
> +			break;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t writeback_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
> +	unsigned long lo = 0, hi = nr_pages;
> +	struct zram_pp_ctl *ctl = NULL;
> +	char *args, *param, *val;
> +	ssize_t ret = len;
> +	int err, mode = 0;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram)) {
> +		up_read(&zram->init_lock);
> +		return -EINVAL;
> +	}
> +
> +	/* Do not permit concurrent post-processing actions. */
> +	if (atomic_xchg(&zram->pp_in_progress, 1)) {
> +		up_read(&zram->init_lock);
> +		return -EAGAIN;
> +	}
> +
> +	if (!zram->backing_dev) {
> +		ret = -ENODEV;
> +		goto release_init_lock;
> +	}
> +
> +	ctl = init_pp_ctl();
> +	if (!ctl) {
> +		ret = -ENOMEM;
> +		goto release_init_lock;
> +	}
> +
> +	args = skip_spaces(buf);
> +	while (*args) {
> +		args = next_arg(args, &param, &val);
> +
> +		/*
> +		 * Workaround to support the old writeback interface.
> +		 *
> +		 * The old writeback interface has a minor inconsistency and
> +		 * requires key=value only for page_index parameter, while the
> +		 * writeback mode is a valueless parameter.
> +		 *
> +		 * This is not the case anymore and now all parameters are
> +		 * required to have values, however, we need to support the
> +		 * legacy writeback interface format so we check if we can
> +		 * recognize a valueless parameter as the (legacy) writeback
> +		 * mode.
> +		 */
> +		if (!val || !*val) {
> +			err = parse_mode(param, &mode);
> +			if (err) {
> +				ret = err;
> +				goto release_init_lock;
> +			}
> +
> +			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
> +			break;
> +		}
> +
> +		if (!strcmp(param, "type")) {
> +			err = parse_mode(val, &mode);
> +			if (err) {
> +				ret = err;
> +				goto release_init_lock;
> +			}
> +
> +			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
> +			break;
> +		}
> +
> +		if (!strcmp(param, "page_index")) {
> +			err = parse_page_index(val, nr_pages, &lo, &hi);
> +			if (err) {
> +				ret = err;
> +				goto release_init_lock;
> +			}
> +
> +			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
> +			break;
> +		}
> +
> +		/* There can be several page index ranges */
> +		if (!strcmp(param, "page_index_range")) {
> +			err = parse_page_index_range(val, nr_pages, &lo, &hi);
> +			if (err) {
> +				ret = err;
> +				goto release_init_lock;
> +			}
> +
> +			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
> +			continue;
> +		}
> +	}
> +
> +	err = zram_writeback_slots(zram, ctl);
> +	if (err)
> +		ret = err;
> +
> +release_init_lock:
>  	release_pp_ctl(zram, ctl);
>  	atomic_set(&zram->pp_in_progress, 0);
>  	up_read(&zram->init_lock);
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

