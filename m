Return-Path: <linux-kernel+bounces-293101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60458957ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34DC282D14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84E17740;
	Tue, 20 Aug 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HhI4wTR/"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6212E71
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116367; cv=none; b=RSHGV+Sh+bgmV5/MXTXX9cJSjs2WZ8On5wcUwqfWiEO0h3J7ievchliPtOiKHqvx7/unD9Pp+SCXdKspgPmkxp0SbOCLG61WHsyazJVIfN8I4FFopkQzXCkvyeHO1YSX1/RqIOAh/W2cOsWFtKaGFkt/+dAqn3Yj/eLJl06JXZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116367; c=relaxed/simple;
	bh=WwQoy1W42BcBNh9BniFKEqko+jEknkzHc1M1T0KFG8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WX7sOeOzkedQ5qgKNRrbjDzZTPPEo48Gi5d/Qx40RtXIFZP5xPA9cQ8frPuqilJfOn/EvD9yLlXl3emLYBFVAT3clt1r63x26CaGIKL3xJR+w4kD8i+1IWXsrobytXUVKzPjDVuCajHIzk2Zn0Z6zgF97cVCvLEfgyix4X1bPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HhI4wTR/; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724116362; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V55tWFOs2j/7hQOblUxqoNa9+AFP1aq2zN62h7AYCVM=;
	b=HhI4wTR/p50MoykDoP8qn9oeAOxi+xmffx4cJAJLejuwKaguwFFdx3MzTPLe/DTkz0Q6P3QWv41nx38+hD0A55JWN3hj480OVhCX7VO3IMmzOy8ql2wGAUvgmKQLr3/r7FW4pB86evgVinwCr+kuoM3wMb+1GsDRBeNo0UDACt4=
Received: from 30.221.128.199(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDGQC6S_1724116361)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 09:12:42 +0800
Message-ID: <d10a4f92-00f7-48a7-b6fd-e0fa5e8e3013@linux.alibaba.com>
Date: Tue, 20 Aug 2024 09:12:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
To: qasdev <qasdev00@gmail.com>, Heming Zhao <heming.zhao@suse.com>,
 mark@fasheh.com, jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zr9XJJlZ+RzkLK/M@hostname>
 <cbd30b80-d213-4997-b447-10e455f20196@suse.com>
 <e5fb0013-ea4e-4da7-89e5-6b2b0879ecc9@linux.alibaba.com>
 <ZsPrbmbnAgGRgqLw@hostname>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <ZsPrbmbnAgGRgqLw@hostname>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/20/24 9:03 AM, qasdev wrote:
> On Mon, Aug 19, 2024 at 10:52:29AM +0800, Joseph Qi wrote:
>>
>>
>> On 8/18/24 7:43 PM, Heming Zhao wrote:
>>> On 8/16/24 21:41, qasdev wrote:
>>>>  From ad1ca2fd2ecf4eb7ec2c76fcbbf34639f0ad87ca Mon Sep 17 00:00:00 2001
>>>> From: Qasim Ijaz <qasdev00@gmail.com>
>>>> Date: Fri, 16 Aug 2024 02:30:25 +0100
>>>> Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
>>>>   ocfs2_verify_volume()
>>>>
>>
>> The above should be eliminated from patch body. 
>>
>>>> This patch addresses a shift-out-of-bounds error in the
>>>> ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
>>>> by an invalid s_clustersize_bits value (e.g., 1548), which caused the
>>>> expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
>>>> to exceed the limits of a 32-bit integer,
>>>> leading to an out-of-bounds shift.
>>>>
>>>> Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
>>>> Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
>>>> Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
>>>> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
>>>> ---
>>>>   fs/ocfs2/super.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
>>>> index afee70125ae3..1e43cdca7f40 100644
>>>> --- a/fs/ocfs2/super.c
>>>> +++ b/fs/ocfs2/super.c
>>>> @@ -2357,8 +2357,12 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>>>>                    (unsigned long long)bh->b_blocknr);
>>>>           } else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
>>>>                   le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
>>>> -            mlog(ML_ERROR, "bad cluster size found: %u\n",
>>>> -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>>>> +            if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 32)
>>>> +                mlog(ML_ERROR, "bad cluster size found: %u\n",
>>>> +                     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>>>> +            else
>>>> +                mlog(ML_ERROR, "invalid cluster size bit value: %u\n",
>>>> +                     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>>>
>>> I prefer to use concise code to fix the error.
>>> Do you like below code?
>>> -        mlog(ML_ERROR, "bad cluster size found: %u\n",
>>> -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>>> +        mlog(ML_ERROR, "bad cluster size bit found: %u\n",
>>> +                 le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>>>
>>
>> Agree. qasdev, Could you please update and send v2?
>>
>> Thanks,
>> Joseph
> 
> Thanks for the feedback. After considering the input, I've refined the patch 
> to make it more concise. I've updated the patch and included it below:
> 
Hi, please send v2 as a standalone thread.

Thanks,
Joseph

