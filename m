Return-Path: <linux-kernel+bounces-386809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A79B4821
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CB51C22529
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8BF204F6C;
	Tue, 29 Oct 2024 11:19:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A320492E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200759; cv=none; b=Hw1UZUOgrpBCVzcQCmXeZ8pM9Ua//Ciixqt1ompp+hGumfjd8PHT6KJfH8GFL+bcOnrdobbs3iVQtrJcobyt9Kp7NgGfF36C1TGIZHFhR6gn80oKPIVd6e3J3nrSZIwfdX4yi1fqdRgT2M9YPJiLvRHMjWbRUJiCU1Cpv87JQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200759; c=relaxed/simple;
	bh=xtwkP9Gjr9xEtUhAXHlbW3lr7GpkW23zMPU/exC7FF8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=awYTwkW/8Emgo2TG8qUnqKn/LnMztYgegRlkvG+rF2MTERc3wLymTzhbEXErHRQgMjMGOdw3rVoSxQBgvkKL4zE1ZzPFsO9XssSigMYpZEcEvxJh/d0VZRGVIOLiEZbwUrffhPpeXCtQzDDC47iqQtes04HhnVtuNsgJ+EnvKNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xd72B2G1nz1HLdc;
	Tue, 29 Oct 2024 19:14:42 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id C1BC21A016C;
	Tue, 29 Oct 2024 19:19:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 19:19:08 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Ryder Wang <rydercoding@hotmail.com>, Waqar Hameed
	<waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>
CC: "kernel@axis.com" <kernel@axis.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <MEYP282MB316412B08A32373E5ED9B896BF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
 <fc567699-59c7-265a-b7c8-7b658cc6fc05@huawei.com>
 <MEYP282MB316491A32BE6F870B093540FBF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6c1295c2-5399-793b-02f4-0e078dc68d0a@huawei.com>
Date: Tue, 29 Oct 2024 19:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <MEYP282MB316491A32BE6F870B093540FBF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/29 17:56, Ryder Wang Ð´µÀ:
>> Thanks for reporting that :-). I noticed it a period time ago too, and I
>> found 'c->znext', 'c->cnext' and 'znode->cnext' won't be accessed (in
>> write mode) by other tasks, because there is only one function
>> do_commit() modifying them and do_commit() can be executed by at most
>> one task in any time.
> 
> It looks the race condition can really happen in this case from the issue reporter.
> 1. do_commit (ubifs_bg_thread): it can finally touch unprotected znode while calling the function write_index().
> 2. ubifs_evict_inode (other kernel thread than ubifs_bg_thread): it can finally touch the znode in the function tnc_delete(). Even there is mutex protection for tnc_delete(), but it has no meaning because of do_commit (at the point 1) doesn't have such mutex protection while calling write_index().
> .
> 

Emm.., this has been discussed in previous sessions.
All dirty znodes are gathered by function get_znodes_to_commit() which 
is protected by c->tnc_mutex, and the 'cparent' member in all dirty 
znodes is assigned with non-NULL. Then I think the znode memory freeing 
path 'tnc_delete->kfree(znode)' cannot happen, because:
1) If a znode is dirtied, all its' ancestor znodes(a path from znode to 
root znode) must be dirtied, which is guaranteed by UBIFS. See 
dirty_cow_bottom_up/lookup_level0_dirty.
2) A dirty znode waiting for commit cannot be freed before write_index() 
finished, which is guaranteed by tnc_delete:
   if (znode->cnext) {
     __set_bit(OBSOLETE_ZNODE, &znode->flags);
     ...
   } else {
     kfree(znode);
   }

