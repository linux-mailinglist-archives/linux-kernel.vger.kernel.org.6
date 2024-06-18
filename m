Return-Path: <linux-kernel+bounces-219479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3990D384
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E72B2D6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8693715748B;
	Tue, 18 Jun 2024 13:37:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2181725
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717870; cv=none; b=AGDZI06kcb3dwI+KRhsXItEabOUsTJ+hGMRQbXsVPxspHLBRI9rTzcO7hCMIUbW9foNN6rjQGG/JJX9srOgwozw8kw7RQMqJkVwWSG0HWGkFdp0bCfHxuALoWCvP4twptBZj8gFoGTXXZRiERBr81ssJmMNxIOskbmWMqu8a0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717870; c=relaxed/simple;
	bh=KssnqUamADmWVBsMeaGkbmuidtbL8xmrw+FgZlCyEus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WuUWjxPj8ezAUoAq9UTOKsVDwWoayUrP+/GOviVKiYQaV0LacUz7nnrSPkbY/XMjSo9jiLzinL3NZaFXfrYpQBTNgcCvvDwiS92HYZ0wUhugHubkejAbU0wKq7VTFBSoV9CwsaM2x/JR3dKXf1nOGSEIdl/HKlyv1f8piH1OShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W3SQR0pw8zPrGw;
	Tue, 18 Jun 2024 21:34:07 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id DBB2818007A;
	Tue, 18 Jun 2024 21:37:38 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Jun 2024 21:37:37 +0800
Message-ID: <6ffcbc02-b059-4e56-8900-53820d2d3caa@huawei.com>
Date: Tue, 18 Jun 2024 21:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: modify inappropriate error return value in
 cachefiles_daemon_secctx
To: <dhowells@redhat.com>, <steved@redhat.com>, <Trond.Myklebust@netapp.com>,
	<viro@zeniv.linux.org.uk>
CC: <netfs@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	<jefflexu@linux.alibaba>, <zhujia.zj@bytedance.com>, <libaokun1@huawei.com>,
	<houtao1@huawei.com>, Yu Kuai <yukuai3@huawei.com>
References: <20240604071334.3982185-1-wozizhi@huawei.com>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20240604071334.3982185-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

friendly ping

在 2024/6/4 15:13, Zizhi Wo 写道:
> In cachefiles_daemon_secctx(), if it is detected that secctx has been
> written to the cache, the error code returned is -EINVAL, which is
> inappropriate and does not distinguish the situation well.
> 
> Like cachefiles_daemon_dir(), fix this issue by return -EEXIST to the user
> if it has already been defined once.
> 
> Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   fs/cachefiles/daemon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..1b14849804f3 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -586,7 +586,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
>   
>   	if (cache->secctx) {
>   		pr_err("Second security context specified\n");
> -		return -EINVAL;
> +		return -EEXIST;
>   	}
>   
>   	secctx = kstrdup(args, GFP_KERNEL);


