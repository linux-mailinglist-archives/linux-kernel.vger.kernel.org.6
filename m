Return-Path: <linux-kernel+bounces-248548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24392DEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DF9284174
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B214A90;
	Thu, 11 Jul 2024 03:13:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0068F72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720667581; cv=none; b=YxV8Rb0icFJct8YWQnBB/vEcdOUygwFTuYTbBtHq8De1Kngv1lx2mbcXr557owYV53CxJh85yDDZDb9V3yk/K95SU7GPArziieWDzGSwp3CFXj65BV0ykDkv26xvFhdjeLH90I9g4nCr9z65eSwhPIGa9yH8QOYkwLHKtr1w4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720667581; c=relaxed/simple;
	bh=mImdMtfQ86F+CAOUGZxYiIKc482Ad9A4+WUDvzsSjNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bXSEnioIfBiI/6r6tieLZL3ODPgRebrHv7EMvqz8zkgcebDYp8wNcyU3wCFZY7RQKAk+RY2geTk2kLIzK4Wqt52oIJCgbYI3NzOOSnPbs1lgYxCCc/i3ilH1N4O27zm4otSLKeOHIwo3x/cvMTsQ4r8p2f9E69mp5+oY10R37To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WKKRc3sSQzwWdn;
	Thu, 11 Jul 2024 11:08:12 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C5B0180ADF;
	Thu, 11 Jul 2024 11:12:56 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 11 Jul 2024 11:12:55 +0800
Message-ID: <099a4327-aa59-d560-8397-fc3fbd345262@huawei.com>
Date: Thu, 11 Jul 2024 11:12:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC 0/1] ubifs: inode deletion deadlock
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <chengzhihao1@huawei.com>
References: <20240711030624.266440-1-wangzhaolong1@huawei.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <20240711030624.266440-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)



> Hi.
> 
> While the previous patch set [1] aimed to address the ABBA deadlock between
> inode reclaiming and deleted inode writing, I discovered that the problem
> still persists in the form of an AA deadlock after applying those changes.
> 
> The core issue is that although [1] avoids the ABBA deadlock by getting the
> xattr inodes before locking BASEHD's wbuf->io_mutex. But the inode reclaiming
> process can still get stuck waiting for the xattr inodes that have already
> been marked as I_FREEING.
> 

My bad, I need to add the link [1]

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=414540 [1]

