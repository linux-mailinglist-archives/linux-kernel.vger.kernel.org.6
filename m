Return-Path: <linux-kernel+bounces-365273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80F99DFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773341F239DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6DB1A76D0;
	Tue, 15 Oct 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tCgDcmSK"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356518A6D9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978777; cv=none; b=AV2mBdrL3qt4/4opzTV2eA35afFtDSHqqOG6UELzhU/IhXB6WRACZ7jiP8ZZQ5uwHlUEFHIz7RJyqJ+bH3/RA54nnP92YAWQNZmPRy0jvRkv7ZjpzXrCbvIOzE6juZFxUtdmEe54PX2sg1lAUeLP/m8QzA5cyCdHNfZGZXcTPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978777; c=relaxed/simple;
	bh=yKy4gKAOegZZMQfE4qbX5aO6EBlZq7VAN/0/6IdaTwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQHA5Yu9kwzr9TlRxoHB7UGStPvIWLNHn0q7BvhzcDVm+hDFfiy/eTnNtUEEvZwMB8hKYrD5NLKCYk4wiyzcovOcTY5osIwLcvfzCp9hbXKyxR0JRGV90qdetgqRejIDDnM+OfwC84qcapWQmq2LbhI+k6tbypb/tZHw5QlYPQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tCgDcmSK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728978766; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XmrO3mGDMdEdy6F/vjqBqNRpe+B/XqnieplA2yVTEyY=;
	b=tCgDcmSKP3xypRqxOP8JMSQXVQwbDggKAdFNEQS6XhTpby9AgNIvhUAb7PVhWiD+zq7o4HuI5kFbyFqjVJDaw/IeKjJd9GnUD7KAPkq1Si8p1PnY93ruj3c9k9ipQ3DIeUDJAQRokxWXlH4I+vBGt16VenV51D0SN6uwLvujAM4=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHCxYGt_1728978765 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 15:52:46 +0800
Message-ID: <b0c38bac-a682-45ae-8991-b73991ae6ddb@linux.alibaba.com>
Date: Tue, 15 Oct 2024 15:52:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix blksize < PAGE_SIZE for file-backed mounts
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241015070750.3489603-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/15 15:07, Hongzhen Luo wrote:
> Adjust sb->s_blocksize{,_bits} directly for file-backed
> mounts when the fs block size is smaller than PAGE_SIZE.
> 
> Previously, EROFS used sb_set_blocksize(), which caused
> a panic if bdev-backed mounts is not used.
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v3: Fix trivial typos.
> v2: https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/super.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..ca45dfb17d7c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   			errorfc(fc, "unsupported blksize for fscache mode");
>   			return -EINVAL;
>   		}
> -		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
> +
> +		if (erofs_is_fileio_mode(sbi)) {
> +			sb->s_blocksize = (1 << sbi->blkszbits);

Why needing parentheses here?

Thanks,
Gao Xiang

> +			sb->s_blocksize_bits = sbi->blkszbits;
> +		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
>   			errorfc(fc, "failed to set erofs blksize");
>   			return -EINVAL;
>   		}


