Return-Path: <linux-kernel+bounces-235663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0C91D81C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ED81C21FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C5383AB;
	Mon,  1 Jul 2024 06:34:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AE7E110
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719815643; cv=none; b=dzTlkUEaDsvVFQyvg8nRyNa813Ymx8LazWmK0SO9Q4mycuvw5gyZnktreFHaqGWn45UKIVn6L21dkLiln846S6d3PbLvlYAsCkxvoKS5E/95O/qCgWVovrthXW8ClkO+0LKeuCxufl+OQXPsQSEbUQQBA537eFwRQon57De4l+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719815643; c=relaxed/simple;
	bh=fr7dDh0TQOZX/GkqtI9pkHRW0/gN/p2TecKcxJHipP8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iNzojiB8fHBzD9d5EQYTNMMVq83lOIqmP1bKUqcfeVRKBc2XZClPn1/cnjQ5LBE/pT98v6Qf+qIDEq6bwZ/pCI2nOcNrhuuYwE8MFk3/EsfuLkmZvV3mCb1YQQMUoIX9zdt93jZkbB9/bby3AmX9+NTyPCT1IseENfy36bywzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WCGNY0m6NzxTsB;
	Mon,  1 Jul 2024 14:29:33 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 3469218007C;
	Mon,  1 Jul 2024 14:33:58 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 14:33:57 +0800
Subject: Re: [PATCH] jffs2: fix use of uninitialized variable
To: Qingfang Deng <dqfext@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, Qingfang Deng
	<qingfang.deng@siflower.com.cn>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240701045206.162103-1-dqfext@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <587f2211-8667-ff30-db5b-8b6e3f61a15d@huawei.com>
Date: Mon, 1 Jul 2024 14:33:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240701045206.162103-1-dqfext@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/7/1 12:52, Qingfang Deng Ð´µÀ:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> When building the kernel with -Wmaybe-uninitialized, the compiler
> reports this warning:
> 
> In function 'jffs2_mark_erased_block',
>      inlined from 'jffs2_erase_pending_blocks' at fs/jffs2/erase.c:116:4:
> fs/jffs2/erase.c:474:9: warning: 'bad_offset' may be used uninitialized [-Wmaybe-uninitialized]
>    474 |         jffs2_erase_failed(c, jeb, bad_offset);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/jffs2/erase.c: In function 'jffs2_erase_pending_blocks':
> fs/jffs2/erase.c:402:18: note: 'bad_offset' was declared here
>    402 |         uint32_t bad_offset;
>        |                  ^~~~~~~~~~
> 
> When mtd->point() is used, jffs2_erase_pending_blocks can return -EIO
> without initializing bad_offset, which is later used at the filebad
> label in jffs2_mark_erased_block.
> Fix it by initializing this variable.
> 
> Fixes: 8a0f572397ca ("[JFFS2] Return values of jffs2_block_check_erase error paths")
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>   fs/jffs2/erase.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
> index acd32f05b519..ef3a1e1b6cb0 100644
> --- a/fs/jffs2/erase.c
> +++ b/fs/jffs2/erase.c
> @@ -338,10 +338,9 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
>   		} while(--retlen);
>   		mtd_unpoint(c->mtd, jeb->offset, c->sector_size);
>   		if (retlen) {
> -			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08tx\n",
> -				*wordebuf,
> -				jeb->offset +
> -				c->sector_size-retlen * sizeof(*wordebuf));
> +			*bad_offset = jeb->offset + c->sector_size - retlen * sizeof(*wordebuf);
> +			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08x\n",
> +				*wordebuf, *bad_offset);
>   			return -EIO;
>   		}
>   		return 0;
> 


