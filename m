Return-Path: <linux-kernel+bounces-180552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5658C7014
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D47D1F2221D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059591854;
	Thu, 16 May 2024 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A/uOHvn2"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9010F1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823726; cv=none; b=qp+Ew5oethijfMElMCgnb720Cu8jxDbnzEADIBDCy4RhSM0Etb+47hmgbIsLsCxt5R0zLC5MT9QmKg15gGQes5B7Y8nhaiLO/cWQ83vClS3afFUiRyQmIbM/0xAcPBiObVhku3u+v2aEOwHTKR2cZ39V2SbyqlDoOF4eyHiNN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823726; c=relaxed/simple;
	bh=sphSLpGX7TeKcLF0fd/4ZGq0GRD9kGI/Sv5KgFRyTKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHPcQmD2efTl3JjQMFjT7+x/w0mkOUKGcGvNuKYfLG6qlmlUufIgb1j9sDSFuIMSXHihO445BwanSGq63FVkBDu6XhQ/SMda6+Mj2kQPvBg3kAV506ykWOG46n+yt5R25rQA914lDID4jfQ13S5ri4kKsclSOUlEysTSo59qN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A/uOHvn2; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715823720; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6l2j1hfJLj/NOswmfviaKoySFrdt0h7TrfH/eLX7gz8=;
	b=A/uOHvn2dexNJX04dZ+KHLaxirLwb/7Si+3TrR1fwnWQfM/OCuBkb8Iyjm6OezPcMBsZKno0ylaDf3/OSBILyasGCskVvLDmT1zMKphU4WY//B/M17cPQB8bQMnR6EYN7B95heRML1x74IbgLxRN+nOuyAJMD1wT+m//3pDkENA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W6ZPauu_1715823718;
Received: from 30.221.128.154(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0W6ZPauu_1715823718)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 09:41:59 +0800
Message-ID: <03f031e5-ed9c-4794-8f08-8a4007c1d704@linux.alibaba.com>
Date: Thu, 16 May 2024 09:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ocfs2: strict bound check before memcmp in
 ocfs2_xattr_find_entry()
To: Ferry Meng <mengferry@linux.alibaba.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <20240515132934.69511-1-mengferry@linux.alibaba.com>
 <20240515132934.69511-3-mengferry@linux.alibaba.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240515132934.69511-3-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 9:29 PM, Ferry Meng wrote:
> xattr in ocfs2 maybe not INLINE, but saved with additional space
> requested. It's better to check if the memory is out of bound before
> memcmp, although this possibility mainly comes from custom poisonous
> images.

Specifically, this only addresses the case non-indexed xattr. 

> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
> ---
>  fs/ocfs2/xattr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 37be4a286faf..4ceb0cb4cb71 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -1083,10 +1083,15 @@ static int ocfs2_xattr_find_entry(struct inode *inode, void *end,
>  		cmp = name_index - ocfs2_xattr_get_type(entry);

Or define a local variable 'offset' for le16_to_cpu(entry->xe_name_offset).

Thanks,
Joseph

>  		if (!cmp)
>  			cmp = name_len - entry->xe_name_len;
> -		if (!cmp)
> +		if (!cmp) {
> +			if ((xs->base + le16_to_cpu(entry->xe_name_offset) + name_len) > end) {
> +				ocfs2_error(inode->i_sb, "corrupted xattr entries");
> +				return -EFSCORRUPTED;
> +			}
>  			cmp = memcmp(name, (xs->base +
>  				     le16_to_cpu(entry->xe_name_offset)),
>  				     name_len);
> +		}
>  		if (cmp == 0)
>  			break;
>  		entry += 1;

