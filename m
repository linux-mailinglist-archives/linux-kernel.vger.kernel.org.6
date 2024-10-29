Return-Path: <linux-kernel+bounces-386572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983429B4541
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CEB28393F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D020402F;
	Tue, 29 Oct 2024 09:06:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2A1FF5F6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192799; cv=none; b=jyQAj40C7EDCTqCSLnLhmGfgzmeptmTQk4lJ1B0olVtLsfdxIhHEOgzk9HC6B2yLW4hoIEPr4GWxCWi7aR0iTct0B7pCo21absrGY3FTK+iPD71wCQv49i3NmPrrYniLqmxtd6hIlWYFpXhG+zMrcsGHnSHetU38oxNrER5O+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192799; c=relaxed/simple;
	bh=K+JZdznBEzOzTYiwYv7Yqrov3wr13+aS4RqOhRFijAM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JQsMuI/zzWu3j1BJd6RtHA5iEWWM2+tkjNJ8s5OuNH9xE0ZfrU4J0pbjTXrYP329CZWkO/Zq6Q2++GTNYPbaMngu+A9kb0kBthrYP1+ah4srfPk83MgHJEPaglV/ujXI7BbrKYUQ7DbcA6CEf1s3CT0AJuzepdHDRZMr33dZWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xd48Q4682zyTcT;
	Tue, 29 Oct 2024 17:04:54 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EAEF140257;
	Tue, 29 Oct 2024 17:06:32 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 17:06:31 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Ryder Wang <rydercoding@hotmail.com>, Waqar Hameed
	<waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: "kernel@axis.com" <kernel@axis.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <MEYP282MB316412B08A32373E5ED9B896BF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fc567699-59c7-265a-b7c8-7b658cc6fc05@huawei.com>
Date: Tue, 29 Oct 2024 17:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <MEYP282MB316412B08A32373E5ED9B896BF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/29 16:10, Ryder Wang Ð´µÀ:

Hi, Ryder
> I just have some interesting finding.
> 
> The code of the function write_index() has a race condition bug. c->enext is used in write_index(), but it is NOT protected by c->tnc_mutex. So there must be SOME race condition problem. I believe some znode may be corrupted or misread if 2 kernel tasks are operating the same znode concurrently.

Thanks for reporting that :-). I noticed it a period time ago too, and I 
found 'c->znext', 'c->cnext' and 'znode->cnext' won't be accessed (in 
write mode) by other tasks, because there is only one function 
do_commit() modifying them and do_commit() can be executed by at most 
one task in any time.
> 
> The code comment of struct ubifs_info below indicates that c->enext must be protected by c->tnc_mutex.
> --------------------------------------------------------------------------------------------------
>   * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, and
>   *             @calc_idx_sz
> --------------------------------------------------------------------------------------------------
> 
> That's why I don't think this patch can fully fix this issue because the race condition is still there.
> 
> .
> 


