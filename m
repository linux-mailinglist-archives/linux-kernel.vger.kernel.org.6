Return-Path: <linux-kernel+bounces-330207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCC4979AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68367283AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD723B796;
	Mon, 16 Sep 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="WT2X9Rce"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE67381B1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467005; cv=none; b=U8hulfJYgqM0ClEGYuul788x/remc4QvcDJRkCtXJUHNUObssTeDsNiSXz+8pp3qY+A+5OdiDRWoaEjCQ09aNCn2xTn/uk6Z4mG8oaIMz5NzM7xuhSWfo1P5scNVgoVPQm9213jCwuc6RqQQcagc+4a9JtNdqauPjYcCSfqMiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467005; c=relaxed/simple;
	bh=mCDMZtNJOo6xRBtcL3MU946yWGoACKA6TxVv86RGU0Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PHfTvG9RDEFm7LBc9IRx0aL9QIY3B12WaP3RiygH10yB0W6XbYiWFtufPkeXqy7rBLH7bWLZdO4NiMzWYkHooNiWA5duz4DZy+e8QI8J8R3bScYllkuX9M1fu+l1xL/kBoFwIEEZIet0ZkHXaakzy99RGf/84H9iD79Xog9+1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=WT2X9Rce; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id pmz8s7RaviA19q4vwsqf0a; Mon, 16 Sep 2024 06:10:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id q4vvsCN8byhfgq4vvs3uAJ; Mon, 16 Sep 2024 06:09:59 +0000
X-Authority-Analysis: v=2.4 cv=U+WUD/ru c=1 sm=1 tr=0 ts=66e7cbb7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=4wIeQxAJSnUt7UKOCtYA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BPRUcNg/CdKy6c0htTAEtda7PXWeXWX6j6CF6eawafs=; b=WT2X9RceGB/cwaf13LEn73C4U2
	25h/x2UxLN1KrfCM7/MHBszvw2RB8Z7qVg+3269ywDfZM8Dhe12CmDF54wMfprHKCeqjXHCSb/fgo
	n83XVjuVsGbrgqC/KzL7ePU9S4T2/950efZqKkxSz+hvs4LK+Uto9jcfQ0J2eFUjyjpA7LCWXH52K
	9M1KngqRu1KvWz3E3oEBO3sm5MFXpXxyrBrnVxMo3RUufswLNgk58SCje8LIlCyNpj+ODKX5N/HCy
	yS78ztQHiSiy+azp8BUWGCUnwdWP76AX0/P2+oSUPOX2cwlPJH+w51Sxk9FyZV9w8wlrV2kprFPQG
	IF0cresA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40654 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sq4vu-004CJQ-0m;
	Mon, 16 Sep 2024 00:09:58 -0600
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than
 4K
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@gmail.com>,
 Matt Fleming <matt@console-pimps.org>, Christian Brauner
 <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, linux-mmc@vger.kernel.org,
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <614692b4-1dbe-31b8-a34d-cb6db1909bb7@w6rz.net>
Date: Sun, 15 Sep 2024 23:09:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240306232052.21317-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sq4vu-004CJQ-0m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:40654
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKqG9BFmlumGo4OF0bNq7RP51tcYhKbHT7MKQerq4V/8Sj68YfAosajBbfyR/TyPmWLQR84bmJyx2ygd1TOiHnUPLIc5SNSUlPDZHmP4uJvFhN6D80OY
 hnP6yIg+D0tZxluJ8Z+OELpPUBUfGXdd60gxaY4o9P/pe1fBLFQYos2hqhMOQWrB05TyRMce4Dq3lIw6WhaELwTyWPRYfUs8QA4=

On 3/6/24 3:20 PM, Sam Protsenko wrote:
> Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
> revealed the long living issue in dw_mmc.c driver, existing since the
> time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
> Add Synopsys DesignWare mmc host driver."), also making kernel boot
> broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
> with this message in dmesg:
>
>      mmcblk: probe of mmc0:0001 failed with error -22
>
> That's happening because mmc_blk_probe() fails when it calls
> blk_validate_limits() consequently, which returns the error due to
> failed max_segment_size check in this code:
>
>      /*
>       * The maximum segment size has an odd historic 64k default that
>       * drivers probably should override.  Just like the I/O size we
>       * require drivers to at least handle a full page per segment.
>       */
>      ...
>      if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
>          return -EINVAL;
>
> In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> sets .max_seg_size to 4 KiB:
>
>      mmc->max_seg_size = 0x1000;
>
> The comment in the code above explains why it's incorrect. Arnd
> suggested setting .max_seg_size to .max_req_size to fix it, which is
> also what some other drivers are doing:
>
>     $ grep -rl 'max_seg_size.*=.*max_req_size' drivers/mmc/host/ | \
>       wc -l
>     18
>
> This change is not only fixing the boot with 16K/64K pages, but also
> leads to a better MMC performance. The linear write performance was
> tested on E850-96 board (eMMC only), before commit [1] (where it's
> possible to boot with 16K/64K pages without this fix, to be able to do
> a comparison). It was tested with this command:
>
>      # dd if=/dev/zero of=somefile bs=1M count=500 oflag=sync
>
> Test results are as follows:
>
>    - 4K pages,  .max_seg_size = 4 KiB:                   94.2 MB/s
>    - 4K pages,  .max_seg_size = .max_req_size = 512 KiB: 96.9 MB/s
>    - 16K pages, .max_seg_size = 4 KiB:                   126 MB/s
>    - 16K pages, .max_seg_size = .max_req_size = 2 MiB:   128 MB/s
>    - 64K pages, .max_seg_size = 4 KiB:                   138 MB/s
>    - 64K pages, .max_seg_size = .max_req_size = 8 MiB:   138 MB/s
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
> ---
>   drivers/mmc/host/dw_mmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8e2d676b9239..cccd5633ff40 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>   	if (host->use_dma == TRANS_MODE_IDMAC) {
>   		mmc->max_segs = host->ring_size;
>   		mmc->max_blk_size = 65535;
> -		mmc->max_seg_size = 0x1000;
> -		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> +		mmc->max_seg_size = mmc->max_req_size;
>   		mmc->max_blk_count = mmc->max_req_size / 512;
>   	} else if (host->use_dma == TRANS_MODE_EDMAC) {
>   		mmc->max_segs = 64;

Unfortunately, this patch creates side effects for the RISC-V StarFive 
VisionFive2 board (which uses the DesignWare controller). The following 
swiotlb buffer warnings are produced at boot:

2024-09-15T17:54:27.194101-07:00 visionfive kernel: dwmmc_starfive 
16020000.mmc: swiotlb buffer is full (sz: 352256 bytes), total 32768 
(slots), used 222 (slots)
2024-09-15T17:54:27.194107-07:00 visionfive kernel: dwmmc_starfive 
16020000.mmc: swiotlb buffer is full (sz: 352256 bytes), total 32768 
(slots), used 222 (slots)
2024-09-15T17:54:27.194123-07:00 visionfive kernel: dwmmc_starfive 
16020000.mmc: swiotlb buffer is full (sz: 524288 bytes), total 32768 
(slots), used 110 (slots)
2024-09-15T17:54:27.194129-07:00 visionfive kernel: dwmmc_starfive 
16020000.mmc: swiotlb buffer is full (sz: 524288 bytes), total 32768 
(slots), used 110 (slots)


