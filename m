Return-Path: <linux-kernel+bounces-302741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE65C9602BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795841F23225
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64C1537A8;
	Tue, 27 Aug 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lh1bhsP9"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00C13774A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742878; cv=none; b=KRB4VsbJGpDUiBMTJcPRJbjQdQo1ML6XyABwhITCn0DKp8lv71MlBYfjjC+DYWosoFfIueEivV+znFNe5Wr+quMMVKnnkqlhVS1qpH3Ediyv6BWlKtK8U3i5kIfJdrdF7NAZNK9dFwzl/3zpGnEoxMWM+j7su0S0psPjUb6XtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742878; c=relaxed/simple;
	bh=z0SSp782dvjxQaYaAapI7BR3oOPD+StxZHaAK5/WZvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbYOvSqycrHRO8lkp++tdLA46K6VEqyDQAH9s+t+gxu2zcH/8y70fBBgMJ3BrzH+PWFeW6rZoJzRg/llLvV7p2SDgAXJH2dmm6GVT4feQOXFxgad2RdskTibDA82juLuTKssamXKwyPG0TxJGdD2G9C8boQz0+WG7gu+rPGNwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lh1bhsP9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724742867; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ysTiOl8kT8smCXWHLoQmCWKN4XNF1Y38+Fr5TDTXrpM=;
	b=lh1bhsP9KLnmGLUby+a4xmibOcmn7clKBAhawIKENntHEaLZv0Opv+jzTsp8iTDPgELpeMdf63X+DCuQ9UHEMAMntPE3dFz5UEjbU1lNCIJN+CL+AEXk/sJQLQDOfmXm39HTkNl5KrbVepxq4q5KZTPud+OtfBvMsoek4ZLM4ug=
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDlZBDM_1724742866)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 15:14:26 +0800
Message-ID: <34694c88-13c5-41d8-8a3a-437b6f4fdcd9@linux.alibaba.com>
Date: Tue, 27 Aug 2024 15:14:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix minor off-by-one in shrinkable calculation
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <d8e75079-af2d-8519-56df-6be1dccc247a@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d8e75079-af2d-8519-56df-6be1dccc247a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/26 06:42, Hugh Dickins wrote:
> There has been a long-standing and very minor off-by-one, where
> shmem_get_folio_gfp() decides if a large folio extends beyond i_size
> far enough to leave a page or more for freeing later under pressure.
> 
> This is not something needed for stable: but it will be proportionately
> more significant as support for smaller large folios is added, and is
> best fixed before duplicating the check in other places.
> 
> Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
> Signed-off-by: Hugh Dickins <hughd@google.com>

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 85e3bd3e709e..37c300f69baf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2326,7 +2326,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   	alloced = true;
>   	if (folio_test_large(folio) &&
>   	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
> -					folio_next_index(folio) - 1) {
> +					folio_next_index(folio)) {
>   		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>   		struct shmem_inode_info *info = SHMEM_I(inode);
>   		/*

