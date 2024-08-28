Return-Path: <linux-kernel+bounces-305266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EA962C21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B4D1C235B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD081A2C2D;
	Wed, 28 Aug 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gccSKr4s"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C371A2C2B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858646; cv=none; b=fFrzwuA/5PCP9FQ/3kjBmestBvdhgDAFZWYe25we9fh3Qvstnr4SCoT5LeR05S2suj/wx2iqz0NeFLb7vM0kGo66WbvoDfTTm4MPmJS6WzlgYaF8FqU9VydyaYI9durS6rMOg/nCEiinwX2yZy3Qj14fRtst6cGWd3OKc+ytTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858646; c=relaxed/simple;
	bh=6lTLmMep23Gq5QDy6ixw4lnYp4CtXa4Ieur1dYyWCo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fihika9uGDJ3/2r+JvY5M+eJSeDra0htDVuqM4IKt6OrN5g2QIfusR6mGzRD8gL5oPFvWrRunMCvjOFT8H0mv8yv8e5XkfwkchHdW4Jx0u92x6WjqvMyJ2EtBG2HrgDv3wgnaKGG8aOdwzHAy5KSOHRrUmvLYfdh6niLvfqHgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gccSKr4s; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a2264e907so3072640276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858644; x=1725463444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72MBiybvQQGr50cURl2SciPMebMKvOrZROMVK8UusrA=;
        b=gccSKr4s21mz2NQe+Qdn99WAo3HasqNLC9SPNDguR6GDG+tPDS96WqyKwqsDBnZWfm
         6xcSQ8W6Z/JjEru3IOmB2CUr/VyIJuccopJ9oTNVY6oBaFsCbOzRjkgteN4WhASlx2W0
         hYn2OLbRS/CnNNQdN469FR2NHjWW3wArMuxTSinCpNWci05PbbZ4ryoBJEZiPuc1m3K4
         4jwYV5MqHk8EV9h1xOPkmULR5xVc8un2ENPUb2dnQ+hdx95QeE/ys8+HEUzoq7162GeD
         +vdH5xBIbEJOkVuOq65OgMqrTZzxev/ltENwFe+frU+ieQdbo3eAoIu1BANHNG2SHMDE
         MMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858644; x=1725463444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72MBiybvQQGr50cURl2SciPMebMKvOrZROMVK8UusrA=;
        b=mnBgj78LfuIMNUgtwj8SrFTjZiZ73ilu8L321fTwvVu5YJf6qc74ILBXHjD6ZwhQZ7
         /TMx4LVUo7rSbzRD4WaD4LhyoLt9i623SCnaLvibVKB078v4SxXMSt62jDfUHw70rtzI
         GM6lSKn3rxnYRnA6JVV2sRvgKYu+Lc7dD3bShR9H74EsqrtLI59eVcWOmIu6hkZXhQ3L
         fLS43gZxclhzkI7ZClePiipkEDrcytbHPmYrxd4iRrEYu8R0udGVhraGhEePYGBTArej
         qbM+BjfP49vJ2QuEKno48ruaWumkl4yi9fZUgn1j2kZfB1t4489A4umIio7fdqDXEMSd
         bDLw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbEz3jVQnNI1hv9CUkXxExTSvISXRCDkTNeaKbufvk/99DvE3CEzfWpc/13zeS73iQ99G2JJ5gZqC6CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZZ4DU1Eab+yG/o6YX7+XaCVhsKAIZTxRjcSR20ULPiBKHq5j
	Q3S6Y/RtLTwRde7Fi7h+I+DdOmin8RWoBwzI4Ony/tdonUeNoId4qWtZ3jjWhh019Y+SNkqBf1B
	gLJ+5XtJZ7TQ+u9rPxWAKerW6R3t/Pr2wMnbXtA==
X-Google-Smtp-Source: AGHT+IEw1gwe9loKd33j5BnDay0Z4DWKG87t3uM+kiZ9PMG5kVY3N6xYGb1nm3Gus4eDR9IPgRMJdqjCoZ65T21zh3o=
X-Received: by 2002:a05:6902:1791:b0:e08:7607:bbf3 with SMTP id
 3f1490d57ef6-e17a8b0fccemr17946173276.34.1724858644032; Wed, 28 Aug 2024
 08:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
In-Reply-To: <20240306232052.21317-1-semen.protsenko@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:23:28 +0200
Message-ID: <CAPDyKFrviGd6ECV-8LOENgepUZZ1OV2j+d+H5NPCjnHYfrijWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christoph Hellwig <hch@lst.de>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>, 
	Matt Fleming <matt@console-pimps.org>, Christian Brauner <brauner@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 00:20, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
> revealed the long living issue in dw_mmc.c driver, existing since the
> time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
> Add Synopsys DesignWare mmc host driver."), also making kernel boot
> broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
> with this message in dmesg:
>
>     mmcblk: probe of mmc0:0001 failed with error -22
>
> That's happening because mmc_blk_probe() fails when it calls
> blk_validate_limits() consequently, which returns the error due to
> failed max_segment_size check in this code:
>
>     /*
>      * The maximum segment size has an odd historic 64k default that
>      * drivers probably should override.  Just like the I/O size we
>      * require drivers to at least handle a full page per segment.
>      */
>     ...
>     if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
>         return -EINVAL;
>
> In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> sets .max_seg_size to 4 KiB:
>
>     mmc->max_seg_size = 0x1000;
>
> The comment in the code above explains why it's incorrect. Arnd
> suggested setting .max_seg_size to .max_req_size to fix it, which is
> also what some other drivers are doing:
>
>    $ grep -rl 'max_seg_size.*=.*max_req_size' drivers/mmc/host/ | \
>      wc -l
>    18
>
> This change is not only fixing the boot with 16K/64K pages, but also
> leads to a better MMC performance. The linear write performance was
> tested on E850-96 board (eMMC only), before commit [1] (where it's
> possible to boot with 16K/64K pages without this fix, to be able to do
> a comparison). It was tested with this command:
>
>     # dd if=/dev/zero of=somefile bs=1M count=500 oflag=sync
>
> Test results are as follows:
>
>   - 4K pages,  .max_seg_size = 4 KiB:                   94.2 MB/s
>   - 4K pages,  .max_seg_size = .max_req_size = 512 KiB: 96.9 MB/s
>   - 16K pages, .max_seg_size = 4 KiB:                   126 MB/s
>   - 16K pages, .max_seg_size = .max_req_size = 2 MiB:   128 MB/s
>   - 64K pages, .max_seg_size = 4 KiB:                   138 MB/s
>   - 64K pages, .max_seg_size = .max_req_size = 8 MiB:   138 MB/s
>
> Unfortunately, SD card controller is not enabled in E850-96 yet, so it
> wasn't possible for me to run the test on some cheap SD cards to check
> this patch's impact on those. But it's possible that this change might
> also reduce the writes count, thus improving SD/eMMC longevity.
>
> All credit for the analysis and the suggested solution goes to Arnd.
>
> [1] https://lore.kernel.org/all/20240215070300.2200308-18-hch@lst.de/
>
> Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver.")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com/
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8e2d676b9239..cccd5633ff40 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         if (host->use_dma == TRANS_MODE_IDMAC) {
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
> -               mmc->max_seg_size = 0x1000;
> -               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +               mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> +               mmc->max_seg_size = mmc->max_req_size;
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.39.2
>

