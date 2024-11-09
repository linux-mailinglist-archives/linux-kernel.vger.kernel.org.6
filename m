Return-Path: <linux-kernel+bounces-402598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8999C2984
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB381C2109F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA83C488;
	Sat,  9 Nov 2024 02:34:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384827735
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119680; cv=none; b=nArHnjaQkHf9s5im5mJnjq9QRDq/tvjnzqVIPNsO5u7VaRT0xIcfUt3Qj7dUIOay1a3zXkclnpwpXd6wzrt8KejRIA/LAv2A6ZGxVPbx88t7/hz9srEqI30nBYjZp+aj15K5fq4z6oHY03+/gcO4ii9eONyDJp1zlMuwsyL1SwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119680; c=relaxed/simple;
	bh=GHDPmfjb7lQ2FetosnyA9hhyjUkLqIH93Ye5QamASJY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wkanakf1uWdAqaUp1Y5rRa0PnmoJvNW3swlk3mVLUcFhoHk2sW8EDN2/ObnBEYXIH6m3sbHz/ZpnSfhndSfhwk0JAxVkP/9s9eizkkECc0wEdU/HScICG2gUAo01DQ78iaDPuGMSwqPrTr268tBdIHrikjAcp4jl5srBxTQladg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xlfvn0klgzkWnS;
	Sat,  9 Nov 2024 10:31:49 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 32A40180064;
	Sat,  9 Nov 2024 10:34:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 10:34:26 +0800
Subject: Re: [PATCH v2] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>,
	Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3c46013e-809e-cdcf-8648-2ffe2ab6c32b@huawei.com>
Date: Sat, 9 Nov 2024 10:34:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/9 22:46, Waqar Hameed Ð´µÀ:
3 nits below.

1. Make the title as 'ubifs: authentication: Fix use-after-free in 
ubifs_tnc_end_commit'

2. At the begining of the commit msg, describe the problem:
After TNC tree inserting(which may trigger a znode split and change the 
znode->parent) and deleting(which may trigger znode freeing), the 
znode->cparent(which still points to a freed znode) may not be updated 
at the begining of commit, which could trigger an UAF problem while 
accessing znode->cparent in write_index().

> Running
> 
>    rm -f /etc/test-file.bin
>    dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync
> 
> in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:
> 
>    BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
>    Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153
> 
>    Call trace:

[...]
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..a464eb557585 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -657,6 +657,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>   		znode->alt = 0;
>   		cnext = find_next_dirty(znode);
>   		if (!cnext) {

3. I'd like to add the the assertion 'ubifs_assert(c, !znode->parent);'
> +			znode->cparent = NULL;
>   			znode->cnext = c->cnext;
>   			break;
>   		}
> 


