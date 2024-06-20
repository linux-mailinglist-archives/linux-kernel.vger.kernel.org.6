Return-Path: <linux-kernel+bounces-222080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D646C90FC98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADEC285018
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7F3A1AC;
	Thu, 20 Jun 2024 06:14:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D1639856
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864081; cv=none; b=Htl1SD4P2iDxF5feARvbKY/62UgLF7D2DPsxs0Hh+0LdHrAM5PSg0jB4reuF6rJ/foGuvNqd6zZ7Xs7jIvxwePCJTAN87Igjyx7Nv52NZIWJRE4PSLEo50cV62WSQixjnTEjIvEQu5LMTkaJQLhPLj1cJu7ALHn3WIC+PegpK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864081; c=relaxed/simple;
	bh=nCMv9C0POuqD3meDkzxL7V4wWH0imtTOeagZ1TPV9XQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=brc2pV1QSzhH5dSc08iVcRgXRCxCt346vnmwkg0WfUFVZApoDQjsttwpf6PwPcxtMv2NeWDOZfRIgBxuSONH5n7XoxFLCz4jqQBhbuXW12RPEczCPOt8gO5CpSooUTM55qGtIjRnER25vSUmKi9lTbM2gtQkYyWo8XpN93IOjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W4VTR1wwlzwTcQ;
	Thu, 20 Jun 2024 14:10:19 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F203140120;
	Thu, 20 Jun 2024 14:14:35 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 14:14:34 +0800
Subject: Re: [PATCH] ubifs: add check for crypto_shash_tfm_digest
To: Chen Ni <nichen@iscas.ac.cn>, <richard@nod.at>, <ebiggers@google.com>,
	<herbert@gondor.apana.org.au>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240620034533.569099-1-nichen@iscas.ac.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <12a768cb-8ced-0b59-59f3-b05833e41bf3@huawei.com>
Date: Thu, 20 Jun 2024 14:14:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620034533.569099-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/6/20 11:45, Chen Ni Ð´µÀ:
> Add check for the return value of crypto_shash_tfm_digest() and return
> the error if it fails in order to catch the error.
> 
> Fixes: f80df3851246 ("ubifs: use crypto_shash_tfm_digest()")

I think the fix tag should 
817aa094842dfc3a6b98c9582d4a647827f66201("ubifs: support offline signed 
images"), otherwise:
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   fs/ubifs/master.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
> index 7adc37c10b6a..a148760fa49e 100644
> --- a/fs/ubifs/master.c
> +++ b/fs/ubifs/master.c
> @@ -67,10 +67,13 @@ static int mst_node_check_hash(const struct ubifs_info *c,
>   {
>   	u8 calc[UBIFS_MAX_HASH_LEN];
>   	const void *node = mst;
> +	int ret;
>   
> -	crypto_shash_tfm_digest(c->hash_tfm, node + sizeof(struct ubifs_ch),
> +	ret = crypto_shash_tfm_digest(c->hash_tfm, node + sizeof(struct ubifs_ch),
>   				UBIFS_MST_NODE_SZ - sizeof(struct ubifs_ch),
>   				calc);
> +	if (ret)
> +		return ret;
>   
>   	if (ubifs_check_hash(c, expected, calc))
>   		return -EPERM;
> 


