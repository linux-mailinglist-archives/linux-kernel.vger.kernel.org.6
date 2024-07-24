Return-Path: <linux-kernel+bounces-260534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FFD93AA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02693283BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816ACBE4F;
	Wed, 24 Jul 2024 01:34:54 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD29474
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784894; cv=none; b=aHxC1AaX7z+b5WoOYSwqLpz2cVYf2fB7+j4fUO/DJ6uAmTdsNVsphpzvlRBXJAx/Xe8/B0meX/2mngdjKWJiusjdfMigWAiVe93pJti6OI/raauO8T5vX0kMTrguvvMNrICdW20j5XR06mqlwjtF8IIGitM8rxV/JeojtCgIs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784894; c=relaxed/simple;
	bh=TBnCPJuMwPEW3kZvsBENLxGfgXgXnmqghFKqHnv0SJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PPYurgupN4Gt8gZZskA63zUpsblhJa1vvIrRshiePZbv74uGRhKoVg6lHgXVW4JumFhSdmCjs1ppWLKuCFmaIFy7b6gnaCAiCZE92PYOOtZfDqfrtVT2wVzmGUhLMhv7xJPqGPY2SQzRsGRE5GHpyKX2kFiZBxG8Rt3Hfr3Q/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTGg224jJzQms3;
	Wed, 24 Jul 2024 09:30:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 18D4B1800A3;
	Wed, 24 Jul 2024 09:34:49 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 09:34:48 +0800
Message-ID: <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com>
Date: Wed, 24 Jul 2024 09:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML/hostfs - mount failure at tip of tree
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, Matthew Wilcox
	<willy@infradead.org>
CC: Kernel hackers <linux-kernel@vger.kernel.org>, Patrick Rohr
	<prohr@google.com>, Christian Brauner <brauner@kernel.org>
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/24 9:14, Linus Torvalds wrote:
> On Tue, 23 Jul 2024 at 15:33, Maciej Żenczykowski <maze@google.com> wrote:
>>
>> Reverting the following 3 patches:
>> - 104eef133fd9 hostfs: Add const qualifier to host_root in hostfs_fill_super()
>> - cd140ce9f611 hostfs: convert hostfs to use the new mount API
>> - e3ec0fe944d2 hostfs: Convert hostfs_read_folio() to use a folio
>>
>> appears to be necessary to get the Android net test framework to boot
>> with tip of tree,
>> *without* the reverts we get:
>>    mount: /host: special device hostfs does not exist.
>> (if I don't revert the folio change then it mounts, but appears to not
>> actually work)
> 
> Interesting. That folio change was clearly supposed to be a no-op, but
> isn't. Which makes a revert the right thing to do regardless.
> 
> That code was odd before too, but clearly that commit is completely broken.
> 
> I think this part is buggy:
> 
>                  buffer = folio_zero_tail(folio, bytes_read, buffer);
> 
> because while the documentation for folio_zero_tail() does imply that
> usage, the third argument is supposed really looks like it should be
> "buffer + bytes_read".
> 
> So  instead of reverting that commit, does it help to just do that instead:
> 
> -               buffer = folio_zero_tail(folio, bytes_read, buffer);
> +               buffer = folio_zero_tail(folio, bytes_read, buffer +
> bytes_read);
> 
> Willy, that function is really bad. It's not helpful when it
> apparently confused even you, and the calling convention really is
> broken. I think that folio_zero_tail() needs to be rewritten to have
> sane calling conventions (like matching the docs!) or just die.
> 
> The mount API change is somethign else. Again, it wasn't supposed to
> break anything, but clearly does, and so reverting it sounds sane
> unless somebody sees what the problem is.
> 
I apologize for causing this issue. I am currently tracking it down.  If 
reverting this can solve the problem, you can revert it first.

Thanks,
Hongbo

> I'm not even guessing at what might have been wrong in that mount API
> conversion.
> 
>             Linus

