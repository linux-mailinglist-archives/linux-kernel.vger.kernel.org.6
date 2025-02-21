Return-Path: <linux-kernel+bounces-525596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9A7A3F1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD8A1890995
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEF9204F96;
	Fri, 21 Feb 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="T+pOjcbK"
Received: from mail8.out.flockmail.com (mail8.out.flockmail.com [18.213.226.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EB2046B0;
	Fri, 21 Feb 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.213.226.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133348; cv=none; b=Nw9V9pOal0re7UxjxFigqkp6nfN2DE2GfkDMPxtkQs1Q87EJNu3nlGQcQxNIFjz0BDGL4pMfJpxOExBCeOdefrMY7v50o8TFQdK/2xWmNdnqgPjwxSYV+YKCbMAa1/8cJ5c0JhUMmxSz2WiMvTwjwSxrvEklzqB3AJ5JRZgUWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133348; c=relaxed/simple;
	bh=ttghBKtfmBaf6W/eC6gBjd1xmqSctrMbOIo9Izajkz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKM4Eghk2kaMPWLPWW+fvptU3/9am9sEmroYh8Frepg/FtuneIwYHGLeUxA+K7WWqjMx7MpxEs8ZhkuL2r+KzylTZPUH8ktHoMxdPVDUrItMfAGbZRvrg33htxbD0kqHMAUh336cnOH8sBS9XVzNaarizv/aOUEMwWUeuXvSbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=T+pOjcbK; arc=none smtp.client-ip=18.213.226.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
DKIM-Signature: a=rsa-sha256; bh=wANmo5Vtnc/jU4ejAERcYTCS0of3r3IMDpNVJqe6D8w=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:date:from:cc:message-id:references:to:subject:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1740133345; v=1;
	b=T+pOjcbKVifJTuhaF8ueGstAl/qLiBu9Y+6DBYPMa+wr7KUK3M4N7BZmatBz3NL7m9dU6cAS
	pAk3V4mnZxqx3TfwlwI0k2mZdyV/ZmrTrP2GYNMouiiNz49R/ktsbgnR4HJNIJl9X6IJMWtcjmY
	TAKRUyzXrQuNxsqB+ffyXq0E=
Received: from studio.local (tk2-248-33924.vs.sakura.ne.jp [160.16.213.178])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 2B4C5100253;
	Fri, 21 Feb 2025 10:22:18 +0000 (UTC)
Date: Fri, 21 Feb 2025 18:22:01 +0800
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, song@kernel.org, colyli@kernel.org, 
	yukuai3@huawei.com, dan.j.williams@intel.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, ira.weiny@intel.com, dlemoal@kernel.org, yanjun.zhu@linux.dev, 
	kch@nvidia.com, hare@suse.de, zhengqixing@huawei.com, john.g.garry@oracle.com, 
	geliang@kernel.org, xni@redhat.com, colyli@suse.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 06/12] badblocks: fix the using of MAX_BADBLOCKS
Message-ID: <ehghja4fxqxvc2s7popqz363bitvxvbu6sdtovetfvx6neiate@5qe4ivr7zyzs>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-7-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221081109.734170-7-zhengqixing@huaweicloud.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1740133345741267071.29396.2836886487781970934@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=bq22BFai c=1 sm=1 tr=0 ts=67b853e1
	a=0OgjFgg9iTm4RD4XR/h7Lw==:117 a=0OgjFgg9iTm4RD4XR/h7Lw==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
	a=ZuRJGKQMYiGAcWkIlfYA:9 a=QEXdDO2ut3YA:10

On Fri, Feb 21, 2025 at 04:11:03PM +0800, Zheng Qixing wrote:
> From: Li Nan <linan122@huawei.com>
> 
> The number of badblocks cannot exceed MAX_BADBLOCKS, but it should be
> allowed to equal MAX_BADBLOCKS.
> 
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>

Looks good to me.

Acked-by: Coly Li <colyli@kernel.org>

Thanks.

> ---
>  block/badblocks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index a953d2e9417f..87267bae6836 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -700,7 +700,7 @@ static bool can_front_overwrite(struct badblocks *bb, int prev,
>  			*extra = 2;
>  	}
>  
> -	if ((bb->count + (*extra)) >= MAX_BADBLOCKS)
> +	if ((bb->count + (*extra)) > MAX_BADBLOCKS)
>  		return false;
>  
>  	return true;
> @@ -1135,7 +1135,7 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>  		if ((BB_OFFSET(p[prev]) < bad.start) &&
>  		    (BB_END(p[prev]) > (bad.start + bad.len))) {
>  			/* Splitting */
> -			if ((bb->count + 1) < MAX_BADBLOCKS) {
> +			if ((bb->count + 1) <= MAX_BADBLOCKS) {
>  				len = front_splitting_clear(bb, prev, &bad);
>  				bb->count += 1;
>  				cleared++;
> -- 
> 2.39.2
> 

-- 
Coly Li

