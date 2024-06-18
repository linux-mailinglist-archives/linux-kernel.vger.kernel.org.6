Return-Path: <linux-kernel+bounces-218695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265290C3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280031F24C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D22F61FC9;
	Tue, 18 Jun 2024 06:47:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4C18645
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693252; cv=none; b=tWVQbye2ObZb2PS/E9Jex5QFu9rQI7H7FtyiTcPFlnmp7Tpt70V/7+uXh+EwQDCurF35w7myWm4oYB/VE2OrwLWNPy/hHVr4/IglXEH4U6xQ4FWqPbFH5+Pl6XccCOrdsupqdMqiRozDADVomBY5Q14rgmx3NtWpR6hp4iEOJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693252; c=relaxed/simple;
	bh=0DiElqRHtRTle+TzF4XGUmGWzDFIM9fJLtK7EwKVvjs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=peDXdc75U3pPCHRlH5IwsrAEtqDS+lyEpExvWROP2+QJVJXZSYfvvyxbhVlstSBr5PPP89gKeP8G6azg+w7Ksaxw9pKHLZven9HiCiqUi7BXcZvDU3cC+OXY58pDL4uz7SgcdzoYxXWRnBriW+35ykOKAOfbKKeZrFTXJ7cyM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W3HJD6LfmzwT9K;
	Tue, 18 Jun 2024 14:43:08 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A2AD140123;
	Tue, 18 Jun 2024 14:47:22 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Jun 2024 14:47:22 +0800
Subject: Re: [PATCH v1] ACPI /amba: Fix meaningless code for
 amba_register_dummy_clk()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Youwan Wang
	<youwan@nfschina.com>, <lpieralisi@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<lenb@kernel.org>
References: <20240616100054.241482-1-youwan@nfschina.com>
 <1a6fda13-3a06-420d-a62a-896a7f4866d9@wanadoo.fr>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <56ecbfda-50b6-ee7f-aa62-28295d7121c0@huawei.com>
Date: Tue, 18 Jun 2024 14:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a6fda13-3a06-420d-a62a-896a7f4866d9@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/16 21:05, Christophe JAILLET wrote:
> Le 16/06/2024 à 12:00, Youwan Wang a écrit :
>> Defining `amba_dummy_clk` as static is meaningless.
>>
>> The conditional check `if (amba_dummy_clk)` is intended to
>> determine whether the clock has already been registered.
>> However,in this function, the variable `amba_dummy_clk`
>> will always be NULL.
> 
> Hi,
> 
>   can you elaborate on this "will always be NULL"?
> 
> I think that it is NULL on the first call of amba_register_dummy_clk(), 
> but if it is called again, it will have the value of 
> clk_register_fixed_rate() just a few lines after, doing exactly what the 
> comment says.

I think Youwan is arguing that amba_register_dummy_clk() will
never be called more than once, so the static define and check is
redundant.

Thanks
Hanjun

