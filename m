Return-Path: <linux-kernel+bounces-222249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060990FED0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9611F22209
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6183198A3D;
	Thu, 20 Jun 2024 08:29:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1283CF65
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872157; cv=none; b=uHCOCbFtV924SvIsA/qqAFJll62kw94F/3jqJ/UmFm/4tHoy7VaJk2jnh6wgU37h0ahJyEE3FJZNAWSA1UbMvVTjA7//05Lj02C/Zi6mJh1ZuVSblKUhhBsNgFWFLMwklAmin1fKTOmb0snBTvg2O4mBhzhRfaNlfMNADHQ+At8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872157; c=relaxed/simple;
	bh=5HPHOVjgpO/C841JgY0vOeZN1CqaLyJHR+AVYI3kPsM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rtpDkbcyRziTygvAG/rVJS1y+9Xk0hsQPfdWDbjviQCqNT209TZpkxYw5hApfxeQZBVFgq0lKdNFL/zF+oWmHSxLIwxNKbbV/SKrXBz7Shyf2ksxAc3fZexvNMDnAvom09GLp5V2nd1xCI33GFAlKYE9PqmRtw899Kgn48MxDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W4YTS6WvNzPrgn;
	Thu, 20 Jun 2024 16:25:32 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id A32D3140134;
	Thu, 20 Jun 2024 16:29:06 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 16:29:05 +0800
Subject: Re: [PATCH v2] ubifs: add check for crypto_shash_tfm_digest
To: Chen Ni <nichen@iscas.ac.cn>, <richard@nod.at>, <s.hauer@pengutronix.de>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240620081926.1135571-1-nichen@iscas.ac.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <829bbfb2-ea9d-9b77-27ed-1c57643e75d4@huawei.com>
Date: Thu, 20 Jun 2024 16:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620081926.1135571-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/6/20 16:19, Chen Ni Ð´µÀ:
> Add check for the return value of crypto_shash_tfm_digest() and return
> the error if it fails in order to catch the error.
> 
> Fixes: 817aa094842d ("ubifs: support offline signed images")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Update fix tag.
> ---
>   fs/ubifs/master.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
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


