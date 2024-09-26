Return-Path: <linux-kernel+bounces-340384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AC987288
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDCB1F22754
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB71AE871;
	Thu, 26 Sep 2024 11:13:11 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061961AD5EB;
	Thu, 26 Sep 2024 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349191; cv=none; b=scXFKRRM+ebWBiqXt0C1eOUuO2CgIMla/dTqmoP7ZsekON0LEVQT9JVB8YogOV72wJzbehZmtPDAPAY4Qw+HTu40Im/K8qLYd+6B1i0KyrXaYz8siyxjUXqzCEFH3BRyBClXl18gZ4XQEvPWYQYYFL0twAVIVNULwfU7eIY5Wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349191; c=relaxed/simple;
	bh=DqF2P0uN7eo/a6JC+6vSVVzAhjnsN970IyPss9bgTCI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eVxxCJUTfN0fR9aUYCEOgFpHE8t87rDRJhFu2qTeqAdkFkr/+7/Rbjax1wLugfpEAHIsDIsHPQnBNgM8Rm718sxM0PbeMUypXmazXhtWja5mRC5jEfAbVITx72Sm4zxTp5VdzXSHO9yBHpXqKsE+oig0UMLTwXFqgdG7RisTU0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XDrY74Sk8zFqqd;
	Thu, 26 Sep 2024 19:12:43 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 409D7140390;
	Thu, 26 Sep 2024 19:13:06 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 19:13:05 +0800
Subject: Re: [PATCH 2/2] ubifs: Reduce kfree() calls in ubifs_purge_xattrs()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-mtd@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
 <fc35a4b0-9a41-4f14-9558-99fc0b7e2ad8@web.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2012c8b6-b960-d597-481d-5f051686ffe1@huawei.com>
Date: Thu, 26 Sep 2024 19:13:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fc35a4b0-9a41-4f14-9558-99fc0b7e2ad8@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/9/26 17:50, Markus Elfring 写道:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2024 11:28:48 +0200
> 
> Move a pair of kfree() calls behind the label “out_err”
> so that two statements can be better reused at the end of
> this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   fs/ubifs/xattr.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 7757959e9f09..a514dc4dc535 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -532,8 +532,6 @@ int ubifs_purge_xattrs(struct inode *host)
>   			ubifs_err(c, "dead directory entry '%s', error %d",
>   				  xent->name, err);
>   			ubifs_ro_mode(c, err);
> -			kfree(pxent);
> -			kfree(xent);
>   			goto out_err;
>   		}
> 
> @@ -543,8 +541,6 @@ int ubifs_purge_xattrs(struct inode *host)
>   		err = remove_xattr(c, host, xino, &nm);
>   		iput(xino);
>   		if (err) {
> -			kfree(pxent);
> -			kfree(xent);
>   			ubifs_err(c, "cannot remove xattr, error %d", err);
>   			goto out_err;
>   		}
> @@ -564,6 +560,8 @@ int ubifs_purge_xattrs(struct inode *host)
>   	return 0;
> 
>   out_err:
> +	kfree(pxent);
> +	kfree(xent);
>   	up_write(&ubifs_inode(host)->xattr_sem);
>   	return err;
>   }
> --
> 2.46.1
> 
> .
> 


