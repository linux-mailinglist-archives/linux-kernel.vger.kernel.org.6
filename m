Return-Path: <linux-kernel+bounces-340383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C5987286
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83732280A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C71AE870;
	Thu, 26 Sep 2024 11:12:59 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED31AD9C9;
	Thu, 26 Sep 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349179; cv=none; b=RLsrL6BtdmLzjDD0BxDuFe+D6GokcQdIt1Elaa3HMoWdLZ727t6fiZawsGB5jk/5E4+MO93ZD6Ho3MrdP/pmPcKC8/fQx2liXU0VtDxNFYaEde4QaXBRL5JsxkhLQqzANJS+RxbhY8rXS6XrdfSUusyhITUNZxHG/sLFBDAZrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349179; c=relaxed/simple;
	bh=XCCV+Z7wS/FC9ZI+K6FEnyXKjh6uP/xvF1F2qfbjYdU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eaehHkJXo16yKZ6oHigpf1zAkNwCKCJ8Fc3QVKiZYC1YqpP4zjTAC7P1n6Sb8OrlmqL799S00QNy8STk/x7xvUYOisWY6r5GDjkRaUFx3LiJbYW/Kz1WrN9GItkqv7vaCwIctSkcY+Hw5s+UuExVJ7YO7gTAd4KaNA7mK/ZSaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDrXM5htwz1SBnY;
	Thu, 26 Sep 2024 19:12:03 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BD191402CD;
	Thu, 26 Sep 2024 19:12:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 19:12:52 +0800
Subject: Re: [PATCH 1/2] ubifs: Call iput(xino) only once in
 ubifs_purge_xattrs()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-mtd@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
 <c5bd9bb7-2636-4c48-9623-4c93ded3469c@web.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <002d1dee-0e34-279d-c2e6-3d0fdfa385af@huawei.com>
Date: Thu, 26 Sep 2024 19:12:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c5bd9bb7-2636-4c48-9623-4c93ded3469c@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/9/26 17:49, Markus Elfring 写道:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 11:05:29 +0200
> 
> An iput(xino) call was immediately used after a return value check
> for a remove_xattr() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   fs/ubifs/xattr.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index f734588b224a..7757959e9f09 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -541,16 +541,14 @@ int ubifs_purge_xattrs(struct inode *host)
> 
>   		clear_nlink(xino);
>   		err = remove_xattr(c, host, xino, &nm);
> +		iput(xino);
>   		if (err) {
>   			kfree(pxent);
>   			kfree(xent);
> -			iput(xino);
>   			ubifs_err(c, "cannot remove xattr, error %d", err);
>   			goto out_err;
>   		}
> 
> -		iput(xino);
> -
>   		kfree(pxent);
>   		pxent = xent;
>   		key_read(c, &xent->key, &key);
> --
> 2.46.1
> 
> .
> 


