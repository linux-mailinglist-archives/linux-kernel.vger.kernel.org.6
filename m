Return-Path: <linux-kernel+bounces-304643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9096231D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1454F1F229D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D9165F0F;
	Wed, 28 Aug 2024 09:11:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9928165EE7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836318; cv=none; b=CUj2NlTLMYM3eN430wWfiV2ED3CX8qISVHCZfXfMxU9uer5jDs487CJvP2w9mxLw+zhfJwRYZIsQM/gTv2Dy4WX7gvlkTclAaNngwQ4FPj+dxPVdvTi9MNhAgFH+t5aEyB03oK1URSrUjMRiASTqQlJB7OPOTKYGJfVyKM437+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836318; c=relaxed/simple;
	bh=e0DaCUldFhWGSajdSY5/6o7zlcQyXSv9jhaiXI6cWzU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HlIRy2sqRagMF5DX2q9TVeXmPD93TCiuHgxC/JwTuaOWNk+57jNTyttFQJw3B+34xpP2+glpO58rxo/VrG5YKxLseMNVGTRhsspUbNw9rFF5xBoGXsZ4uyGvcFz8koyu1citXdusL6vpHCebNg8PRe3ptzbk6tuXbmGALGFelqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtzC41hcTzpTvH;
	Wed, 28 Aug 2024 17:10:08 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 25E08180106;
	Wed, 28 Aug 2024 17:11:50 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:11:49 +0800
Subject: Re: [PATCH v1] ubifs: Convert to use ERR_CAST()
To: Shen Lichuan <shenlichuan@vivo.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>
References: <20240828085908.35695-1-shenlichuan@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <30abe7aa-ce3a-782b-b4d4-b2177040ed6b@huawei.com>
Date: Wed, 28 Aug 2024 17:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240828085908.35695-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/28 16:59, Shen Lichuan Ð´µÀ:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>   fs/ubifs/lpt_commit.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
> index 07351fdce722..aa8837e6247c 100644
> --- a/fs/ubifs/lpt_commit.c
> +++ b/fs/ubifs/lpt_commit.c
> @@ -577,7 +577,7 @@ static struct ubifs_pnode *next_pnode_to_dirty(struct ubifs_info *c,
>   	/* Go right */
>   	nnode = ubifs_get_nnode(c, nnode, iip);
>   	if (IS_ERR(nnode))
> -		return (void *)nnode;
> +		return ERR_CAST(nnode);
>   
>   	/* Go down to level 1 */
>   	while (nnode->level > 1) {
> @@ -594,7 +594,7 @@ static struct ubifs_pnode *next_pnode_to_dirty(struct ubifs_info *c,
>   		}
>   		nnode = ubifs_get_nnode(c, nnode, iip);
>   		if (IS_ERR(nnode))
> -			return (void *)nnode;
> +			return ERR_CAST(nnode);
>   	}
>   
>   	for (iip = 0; iip < UBIFS_LPT_FANOUT; iip++)
> 


