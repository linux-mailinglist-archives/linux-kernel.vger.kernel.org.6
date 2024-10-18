Return-Path: <linux-kernel+bounces-370784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CB9A3204
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67E91C21FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394EA55E53;
	Fri, 18 Oct 2024 01:24:11 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B83A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214650; cv=none; b=CzYthbE7aKENdtbL5b7XCMaqbGdx4/Wl4SHNCOPWpeImaYKArNX0iBqoqCrNrfbCgU0wCUtF3XVP9XB+hWm5zdIsACfo/RTU1mbe+II07gQ/X2h0JdHZeU7bgn3mjn6AvhEKuDVZ9eu72FGDVNI14XjWc9LWNCi92SWqT8TJmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214650; c=relaxed/simple;
	bh=h+EJSF4lmJW8nAPLBUKeGpmhI/bD3dbOIJ6FidO6CUk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N2wM6qnm5gQ33qrxRdNt5TOsmZixDP7wwjJ1fT5gvfAVJIb4cZmXkhgvqe8YShSkg/YEUBaXXlkmGJVudNk7sntLXeWy5a9C6p6LiFY8w+ohKk5pnOG2lrFOIHHiBa2UWSkWNnbKm4Szq5GXsHOBXBLg3/GjzKdryG5fZCoCpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XV6Qv0ZhWz20qXG;
	Fri, 18 Oct 2024 09:23:19 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id F0593180041;
	Fri, 18 Oct 2024 09:24:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 09:24:04 +0800
Subject: Re: [PATCH] ubifs: Move update of cnt in get_znodes_to_commit
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>
CC: <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <ebf1570e3d28462a97b1a595794e1969a4c27d81.1729191143.git.waqar.hameed@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <4751d3df-99a6-ec67-1175-ea5375290726@huawei.com>
Date: Fri, 18 Oct 2024 09:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ebf1570e3d28462a97b1a595794e1969a4c27d81.1729191143.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/18 2:41, Waqar Hameed Ð´µÀ:
> There is no need to update `cnt` for the first dirty node just before
> the loop, and then again update it at the end of each iteration for the
> next dirty nodes. Just update `cnt` at the beginning of each iteration
> instead. This way, the first iteration will count the first dirty node
> and any subsequent iterations will count the next dirty nodes.

Well, from my own view, I prefer the orignal style because it looks more 
readable.
   c->cnext = find_first_dirty(c->zroot.znode);
   znode = c->enext = c->cnext;
   cnt += 1;  // We get the first one.

   while (1) {
     cnext = find_next_dirty(znode);
     znode = cnext;
     cnt += 1; // We get another one.
   }

After applying this patch, the intention of 'cnt' updating is not so 
obviously. However, it does reduce the duplicated codes. I will add an 
acked-by to let Richard determine whether or not apply this patch.

Acked-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>   fs/ubifs/tnc_commit.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..d42f7829389c 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -650,8 +650,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>   		dbg_cmt("no znodes to commit");
>   		return 0;
>   	}
> -	cnt += 1;
>   	while (1) {
> +		cnt += 1;
>   		ubifs_assert(c, !ubifs_zn_cow(znode));
>   		__set_bit(COW_ZNODE, &znode->flags);
>   		znode->alt = 0;
> @@ -664,7 +664,6 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>   		znode->ciip = znode->iip;
>   		znode->cnext = cnext;
>   		znode = cnext;
> -		cnt += 1;
>   	}
>   	dbg_cmt("committing %d znodes", cnt);
>   	ubifs_assert(c, cnt == atomic_long_read(&c->dirty_zn_cnt));
> 


