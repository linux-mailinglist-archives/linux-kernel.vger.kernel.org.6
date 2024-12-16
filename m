Return-Path: <linux-kernel+bounces-447592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3569F34A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3067A1E79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4E149DF7;
	Mon, 16 Dec 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTer/HKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6B1494B0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363530; cv=none; b=JcZBHnx8Cu5caLkNJ32SfXJ/CRh2pMun3lG3RkOr35oyHQnOrKBc0wU8CfjlXxH4kvxfofqoqWWRtctCr3KrThp4RoS84B1TiMtlHr8YWVLOAIzWl0FQalUIIJMalX+AAgW155FLlYKaULs7eUB9YNDGtmdsL+yiRzGLkIkcsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363530; c=relaxed/simple;
	bh=PjgTGWa37ZcSr/2jgtcKaCjNlthVOPFoC83gHM/tQRI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HuhzdKW+udVylxA29+FPZ/ZAlCrpifh1vcx//TyFjGrF1bmWlUuqQ4Frl7cHe4pTUIyfyRlX4ZosRjd42MedpIG7vg1DGumu6vUmT1MQrt9G0U6h48kGWcYG3dzb5STbLPee3PkSNzaK/n6lO/Xeiw1DFspIi8tAW3Zg0pP0l+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTer/HKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3294C4CED0;
	Mon, 16 Dec 2024 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734363530;
	bh=PjgTGWa37ZcSr/2jgtcKaCjNlthVOPFoC83gHM/tQRI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fTer/HKOcTJYfAqsOMfMTG5P8+w6VIESaiXd7pxu4EJGQj7KkBZgVF3uj7iEUwB8q
	 1eqJcKe+N3h0IGnwKW1c51Vivj4kPlQCdBFVRN6WDEv4QekBxgnRzt8TsnQMsrMR1C
	 mfrg9EtmoBEEX9heIfUa3E0CERcV/3FDbDJSe6CjCZkdPXqMnV4sWZFOisLr5ceMiv
	 4/A/5lnEspgPjS1mD7YsRzsVOiplC+ohzY8pln4l5mywKF+FPVK4expNxDjQtE4ACD
	 ID3FCVOwgQt49usW+bBc2aUbO8sH3d9y9JFiLKr34g8rBwJn1H9VOuQFSxBpEfq4f3
	 02pD2WwmvydfA==
Message-ID: <8530b8c3-ba11-42f8-970f-1cd5d729fc0f@kernel.org>
Date: Mon, 16 Dec 2024 23:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Yeongjin Gil <youngjin.gil@samsung.com>,
 daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Sunmin Jeong <s_min.jeong@samsung.com>, Jaewook Kim <jw5454.kim@samsung.com>
Subject: Re: [PATCH v2] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <CGME20240819083433epcas1p3861b773a5b21eea6f0332036a71bb5d7@epcas1p3.samsung.com>
 <20240819083430.31852-1-youngjin.gil@samsung.com>
 <644671fc-b35d-4c53-ae25-356963466339@stanley.mountain>
 <Z1sLKDtRa3wX2Z9g@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <Z1sLKDtRa3wX2Z9g@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/13 0:11, Jaegeuk Kim wrote:
> On 12/12, Dan Carpenter wrote:
>> On Mon, Aug 19, 2024 at 05:34:30PM +0900, Yeongjin Gil wrote:
>>> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
>>> writepage considering that it has been already truncated.
>>> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
>>> cleared during the writeback process for a compressed file including
>>> NULL_ADDR in compress_mode=user.
>>>
>>> This is the reproduction process:
>>>
>>> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
>>> 2. f2fs_io compress testfile
>>> 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
>>> 4. f2fs_io decompress testfile
>>>
>>> To prevent the problem, let's check whether the cluster is fully
>>> allocated before redirty its pages.
>>>
>>
>> We were discussing how to detect these sorts of things in the future.
>> Presumably a user found this by chance?  Xfstests has two tests which deal
>> with compression tests/f2fs/002 and tests/f2fs/007.  But it feels like
>> xfstests is not really the right place for this sort of thing, it would
>> be better as part of some sort of fuzz testing.
>>
>> What do you think?
> 
> Yeah, agreed that we must have tests to catch this. One way may be creating
> some basic disk images having some possible valid layout to see f2fs can
> work as intended. I feel we can put it in xfstests as wel?
 > > Chao, thoughts?

Hi Jaegeuk, Dan,

I'd like to continue to add regression testcases like f2fs/[003-008]
to xfstests, so that, we can make sure last change of f2fs won't cause
any regression by checking w/ those testcases.

Recently, Sheng Yong has introduced a new tool named inject.f2fs [1], and
then, built an auto testsuit in f2fs-tools based on inject.f2fs [2], w/
this testsuit, we can construct image by injecting specified fields, and
check the image w/ fsck to see whether result is as expected.

IMO, it's fine to add new testcases into testsuit to check whether f2fs'
behavior is as expected on constructed image w/ valid data layout.

So, regression testcase goes into xfstests, and fuzz/common image testcase
goes into testsuit of f2fs-tools? what do you think?

[1] "f2fs-tools: introduce inject.f2fs" https://lore.kernel.org/linux-f2fs-devel/20240704025740.527171-1-shengyong@oppo.com/
[2] "f2fs-tools: add testcases" https://lore.kernel.org/linux-f2fs-devel/20241029120956.4186731-1-shengyong@oppo.com/

Thanks,

> 
>>
>> regards,
>> dan carpenter


