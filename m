Return-Path: <linux-kernel+bounces-411575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 795109CFC53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA817B22169
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DC2629D;
	Sat, 16 Nov 2024 02:02:30 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129AA47
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722550; cv=none; b=mBJjbjOHZKklyU1uaF0SwzV2A/3eeicjRysehwpNOTNQFKQsu6zYQgi7Mh4ctTqUltU5wb4mYsHK8rF+7WtB7S8UCgarXGR2EqCc9KUzsi6lze502/pfieRMG48S+xeazc7U1vGyN0+2Uhq4TnBVh5ZoAXoR4astUf8eoqoS+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722550; c=relaxed/simple;
	bh=Aoj4XWnQZqwRP4ovJj/U7XGLClX/8p6u5iKrUUj7UNY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KoAOlh73F5yjHmqDIX23xUPW4jIAcHg66hdyudHJY2DtZJqI5p0Wq2M9j4M32hbxVx1/ZUAuKYDRHwJM05xY7XUOw0+R4psiGeZ83nEoAkZGJCIbXGic3oHxeonUjkYjT+mLzQoTSC+M/obYIKvCwXkJHcqUQWvhndgrKG6+fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XqxtP4mT0z1T594;
	Sat, 16 Nov 2024 10:00:29 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A1CFA140109;
	Sat, 16 Nov 2024 10:02:23 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 16 Nov 2024 10:02:22 +0800
Subject: Re: [PATCH] ubifs: fix uninitialized variable usage
To: Antonio Quartulli <antonio@mandelbit.com>, <linux-mtd@lists.infradead.org>
CC: Richard Weinberger <richard@nod.at>, <linux-kernel@vger.kernel.org>
References: <20241115222634.32259-1-antonio@mandelbit.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e26aea85-988c-17a1-7fff-c14387ca4b57@huawei.com>
Date: Sat, 16 Nov 2024 10:02:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241115222634.32259-1-antonio@mandelbit.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/11/16 6:26, Antonio Quartulli Ð´µÀ:
> In ubifs_jnl_write_inode(), when an inode cannot be deleted
> due to too many xattrs, err is passed to ubifs_ro_mode()
> uninitialized, thus leading to bogus error reporting.
> 
> Fix this case by passing -EPERM, which is the same value that
> ubifs_jnl_write_inode() is going to return to the caller.
> 
> This fixes 1 UNINIT issue reported by Coverity
> Report: CID 1601860: Uninitialized scalar variable (UNINIT)
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>   fs/ubifs/journal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Hi Antonio, thanks for the patch. Nathan has sent a patch to fix it.
https://lore.kernel.org/linux-mtd/b560f413-70f1-8ebb-7403-34591658ca86@huawei.com/T/#t
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 8e98be642371..5eedf511880c 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -983,7 +983,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
>   
>   	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
>   		ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
> -		ubifs_ro_mode(c, err);
> +		ubifs_ro_mode(c, -EPERM);
>   		return -EPERM;
>   	}
>   
> 


