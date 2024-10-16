Return-Path: <linux-kernel+bounces-367982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8B9A0912
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABA81C22137
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A6207A2D;
	Wed, 16 Oct 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BxwBo8DU"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59C206059
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080813; cv=none; b=PRXskY/pBPw86ejkePFfIVXYMDceVuVyD9fyNHZRl1L15Y/2g+QxJhXhclLL0VW6QVJ7mHXCszs80Aupe1mYuF7ngY0ZFia5pqrljvSI/XWPbi9hrlRSBFj43PYi/HdjGqO+vcgQ5iGHlZxNRvVtLCyEzMHiZsNmzBPRnhcdmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080813; c=relaxed/simple;
	bh=lhrys511yL1W4dtn76jP8WLvQDnXttvg9bHdZefw9GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHsTKbAsBLp5GkRMpaJQ4vIgbK10Xz1v2750eXZhftHzLnDeWNdXOAFVrFEC2j70Am6xN8IuhCNjm4KKstalktdWGOiZ1/7xVD6icloOw2YOP8MlFY9tgZaCcYm+iUPNzeV5RBEss6ecY8kOpZZBIgxzu8mLNBfVtN1cJg2gwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BxwBo8DU; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729080807; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=50X2d5mJ1mTer4m/T3roUxtqI6N+qyH8YM5P+58NkyE=;
	b=BxwBo8DUZghd6dE35D2vf0mzB+aKjK6PXIrYssxK2WoMbDt6KWk0SpSEfm7DfOYTv6tRX3Uocop3fJLCewSYGgQN2VH3CiCdhkifbe0pQelsIOFBaK4xnt76sL+PnV05LaD2YowQMz5LdWqQnRb3/ZhBw+XwcTn0RVBgpumDb6M=
Received: from 30.221.129.144(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WHHR2KM_1729080805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 20:13:26 +0800
Message-ID: <d2315d44-8c45-4e1a-adcf-a818a5e31fef@linux.alibaba.com>
Date: Wed, 16 Oct 2024 20:13:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] ocfs2: add a sanity check for i_size
To: Edward Adam Davis <eadavis@qq.com>
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <106ceb9b-0f7f-4962-98e7-d9fa86d08a0a@linux.alibaba.com>
 <tencent_A6B4645A17675769C6D6F37A8362C9660305@qq.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_A6B4645A17675769C6D6F37A8362C9660305@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 7:57 PM, Edward Adam Davis wrote:
> On Wed, 16 Oct 2024 19:08:26 +0800, Joseph Qi wrote:
>> On 10/16/24 11:52 AM, Edward Adam Davis wrote:
>>> On Wed, 16 Oct 2024 10:06:27 +0800, Joseph Qi wrote:
>>>>> Reported-and-tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
>>>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>>>> ---
>>>>> V1 -> V2: keep rc to 0 when falgs contains READHEAD
>>>>> V2 -> V3: check i_size only and alert subject and comments
>>>>>
>>>>>  fs/ocfs2/extent_map.c | 6 +++++-
>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> #syz test
>>>>>
>>>>> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
>>>>> index f7672472fa82..29d27a70dbdd 100644
>>>>> --- a/fs/ocfs2/extent_map.c
>>>>> +++ b/fs/ocfs2/extent_map.c
>>>>> @@ -961,13 +961,17 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>>>>>  	int rc = 0;
>>>>>  	u64 p_block, p_count;
>>>>>  	int i, count, done = 0;
>>>>> +	loff_t i_size = i_size_read(inode);
>>>>>
>>>>>  	trace_ocfs2_read_virt_blocks(
>>>>>  	     inode, (unsigned long long)v_block, nr, bhs, flags,
>>>>>  	     validate);
>>>>>
>>>>> +	if (!i_size)
>>>>> +		return -EINVAL;
>>>>> +
>>>>
>>>> Take a more consideration, inode size 0 doesn't mean it has no blocks,
>>>> since we have a case that fallocate with KEEP_SIZE.
>>>> Could you please check inode->i_blocks in above coredump?
>>> I have previously verified the value of inode->i_blocks in my testing environment, which is 0.
>>>
>> So it seems the check condition should be:
>>
>>   (v_block + nr) > (inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9))
> Do you mean like this?
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index f7672472fa82..9613cd356ac5 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -966,6 +966,9 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>              inode, (unsigned long long)v_block, nr, bhs, flags,
>              validate);
> 
> +       if ((v_block + nr) > (inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9)))
> +               return -EINVAL;
> +
>         if (((v_block + nr - 1) << inode->i_sb->s_blocksize_bits) >=
>             i_size_read(inode)) {
>                 BUG_ON(!(flags & OCFS2_BH_READAHEAD));
> 
Right, which mean the block read request is invalid.


