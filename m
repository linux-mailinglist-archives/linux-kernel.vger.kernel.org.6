Return-Path: <linux-kernel+bounces-291368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46569956141
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB52D1F21E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D403FB31;
	Mon, 19 Aug 2024 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PGoA75MN"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895238DE4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035960; cv=none; b=HX+jz6tu7RaDcYsEhHKhIbhI8tjbDPLBpb+3/BT59hKpFBbKHGdInSSsYsxbzWhfytCY5hyEUfuOkV9iM9Aa+iwGd41iwu+8RbrjUgWywjjuc2/5cC8JzMpVoQkcGcZC8RS1KK5XpE8D/JPsONr4vYY3DyRWfRPWRVF3+bg7NRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035960; c=relaxed/simple;
	bh=eEkswAzufigPSZfVkrwT5ivSD7I6YVY7iquJw7A13b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUJp6tAqmQI8Qoefi+GRdPp16kChN4HaY38EvoYe9SVCJvPwv9VE2t9p82lHLBQxKib8YpRPqiNojwpVw98yQOWSEOGHm4tPIK/JVvrs8+6osk3qTlLr8b4JgM2R1elkUZSlExE+ZPsn+pJw5g7BrcNDhQP08iyLnoMNh/t9jIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PGoA75MN; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724035950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZEEFnbOI9qdPAaeqWnQy/0ifprCsB9eWCuD8eWBWn5A=;
	b=PGoA75MNWDkThSdDDuC8dsD44748E1sT5NQ5Ye+Ns11Sc+E0EVZpuc4Nk5F+IfexRCiyIRiunziYLaKnmZdFqIv+r+7Sd498lpoj08o3Kgu/A3XPLwo51Uvfq0cpGO6ap6X8lBrjKx1M7BKE7WfMTmNmEfhY5gowRx/OBcqrK5E=
Received: from 30.221.129.125(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WD5AEFf_1724035949)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 10:52:29 +0800
Message-ID: <e5fb0013-ea4e-4da7-89e5-6b2b0879ecc9@linux.alibaba.com>
Date: Mon, 19 Aug 2024 10:52:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
To: Heming Zhao <heming.zhao@suse.com>, qasdev <qasdev00@gmail.com>,
 mark@fasheh.com, jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Zr9XJJlZ+RzkLK/M@hostname>
 <cbd30b80-d213-4997-b447-10e455f20196@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <cbd30b80-d213-4997-b447-10e455f20196@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/18/24 7:43 PM, Heming Zhao wrote:
> On 8/16/24 21:41, qasdev wrote:
>>  From ad1ca2fd2ecf4eb7ec2c76fcbbf34639f0ad87ca Mon Sep 17 00:00:00 2001
>> From: Qasim Ijaz <qasdev00@gmail.com>
>> Date: Fri, 16 Aug 2024 02:30:25 +0100
>> Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
>>   ocfs2_verify_volume()
>>

The above should be eliminated from patch body. 

>> This patch addresses a shift-out-of-bounds error in the
>> ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered
>> by an invalid s_clustersize_bits value (e.g., 1548), which caused the
>> expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)"
>> to exceed the limits of a 32-bit integer,
>> leading to an out-of-bounds shift.
>>
>> Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
>> Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
>> Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
>> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
>> ---
>>   fs/ocfs2/super.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
>> index afee70125ae3..1e43cdca7f40 100644
>> --- a/fs/ocfs2/super.c
>> +++ b/fs/ocfs2/super.c
>> @@ -2357,8 +2357,12 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
>>                    (unsigned long long)bh->b_blocknr);
>>           } else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
>>                   le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
>> -            mlog(ML_ERROR, "bad cluster size found: %u\n",
>> -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>> +            if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 32)
>> +                mlog(ML_ERROR, "bad cluster size found: %u\n",
>> +                     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
>> +            else
>> +                mlog(ML_ERROR, "invalid cluster size bit value: %u\n",
>> +                     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> 
> I prefer to use concise code to fix the error.
> Do you like below code?
> -        mlog(ML_ERROR, "bad cluster size found: %u\n",
> -                 1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> +        mlog(ML_ERROR, "bad cluster size bit found: %u\n",
> +                 le32_to_cpu(di->id2.i_super.s_clustersize_bits));
> 

Agree. qasdev, Could you please update and send v2?

Thanks,
Joseph

