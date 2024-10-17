Return-Path: <linux-kernel+bounces-369355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424729A1C35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9636B23A66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770D1D2200;
	Thu, 17 Oct 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EMUcgJL8"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A41D26EE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151893; cv=none; b=l0SBCtvNlxr5hyGxUiJGTpAQhd1Y3U7s9fcqlFFp63G/ZW0vgvjopO8OMu3dgCB6BxSme+L30kgn+8xM2imkQavx7Lznd8FipQemgBiB/aEXKSHUcuejQP++D9MbKkirrSRxvPQ8BN758ornB+vkGaHGtE8cDEX0oh6FUYNnwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151893; c=relaxed/simple;
	bh=MUTytqvzjqbGT9xPhox/JiZD48aDvCLrbzhOjtOq7n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=br4dBqC0zheF6jDF8pnr4swIsBcqa+9mRA5FQfVrqYvwNc5znlyZelCoaE/yz9Ojbo6R4OK3hiD82dgZEugjLwR8k5NxIHYPWbPPA/5xQA4QMhox4AUDnDkfCCiFOGUNeLMwrLAnsorA6G4E2XWofJFXXx6KXJOyRhlViKvtD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EMUcgJL8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729151887; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xSQuZ3RrlX5HhMVvn9kUolFt+7zp3/8AJ7mdOCoylNA=;
	b=EMUcgJL8T/giBumteAiLNPThU2eSWd0et4cGYbA5p1tU/JGKNZEShHQpx8Knxj7TUI3G1+a+Snq9A4FgTkTqtUbwtpBnW8rjzvRmXQS8e5uWjpUI56UYX0YqaILH96Ugol9PAA5+KgytQyg8/KdpjxaVbzPX1UTmtMtC04cWGaQ=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHK.xZK_1729151886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 15:58:06 +0800
Message-ID: <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
Date: Thu, 17 Oct 2024 15:58:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Barry Song <21cnbao@gmail.com>, xiang@kernel.org, chao@kernel.org,
 linux-erofs@lists.ozlabs.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20241017074346.35284-1-21cnbao@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241017074346.35284-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Barry,

On 2024/10/17 15:43, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When a folio has never been zero-filled, mark it as mappedtodisk
> to allow other software components to recognize and utilize the
> flag.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Thanks for this!

It looks good to me as an improvement as long as PG_mappedtodisk
is long-term lived and useful to users.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/fileio.c | 2 ++
>   fs/erofs/zdata.c  | 6 +++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 3af96b1e2c2a..aa4cb438ea95 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -88,6 +88,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   	struct erofs_map_blocks *map = &io->map;
>   	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
>   	loff_t pos = folio_pos(folio), ofs;
> +	bool fully_mapped = true;
>   	struct iov_iter iter;
>   	struct bio_vec bv;
>   	int err = 0;
> @@ -124,6 +125,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   			erofs_put_metabuf(&buf);
>   		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>   			folio_zero_segment(folio, cur, cur + len);
> +			fully_mapped = false;
>   			attached = 0;
>   		} else {
>   			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8936790618c6..0158de4f3d95 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -926,7 +926,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   	const loff_t offset = folio_pos(folio);
>   	const unsigned int bs = i_blocksize(inode);
>   	unsigned int end = folio_size(folio), split = 0, cur, pgs;
> -	bool tight, excl;
> +	bool tight, excl, fully_mapped = true;
>   	int err = 0;
>   
>   	tight = (bs == PAGE_SIZE);
> @@ -949,6 +949,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   
>   		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>   			folio_zero_segment(folio, cur, end);
> +			fully_mapped = false;
>   			tight = false;
>   		} else if (map->m_flags & EROFS_MAP_FRAGMENT) {
>   			erofs_off_t fpos = offset + cur - map->m_la;
> @@ -1009,6 +1010,9 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
>   			tight = (bs == PAGE_SIZE);
>   		}
>   	} while ((end = cur) > 0);
> +
> +	if (fully_mapped)
> +		folio_set_mappedtodisk(folio);
>   	erofs_onlinefolio_end(folio, err);
>   	return err;
>   }


