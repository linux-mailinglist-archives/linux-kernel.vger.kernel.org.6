Return-Path: <linux-kernel+bounces-367894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8719A080F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F922B263B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45B2076AD;
	Wed, 16 Oct 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M79v4IGG"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F70207216
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076914; cv=none; b=OTTc73K463KEcTIMbgJjq4YNQUyQxrEMOuaCCVTsmee34HtxBFilQbB96IN1BE89cSxqt0GeF/6Go5pGpK0hOgB2ESCv2YOy/Pjhz5bTCOHtyx8mC2swzpQ7TKh2X7Sh9oBtavFTstquFMmFdK0xWdSDj1ZfhbTEAPpneEe9v5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076914; c=relaxed/simple;
	bh=SoCYVjaqz3dv2KpNcE7x9EdZSutXqMox9KS5XWAY63g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmDwJtgCq2fEBSkS89rePUZN+pNSt0kcruNx5afuAwPVULlv1wmEn16UnHOs8nzvfcVFwmLdvCCXnoozZiNNewHhpGcNQADOBtjB6ib7k7fFtFFVIZHxmAL6IEOGkLnKPzG5a4z+T1NXEpNnTHwdHCOyqbWIxmz/FXMHkr2JpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M79v4IGG; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729076908; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fQFX2pO924HgiGGOPPFwyRN7LBwbGT/o+cYDHumYHwI=;
	b=M79v4IGGRVap2WXMGIxwvkeJ6ucA4d/4kLndyQlKq7/8j8GAJ2iAqS82zenxYrqfAISSMh69wM2B3W87MwYbmpEhGF5xfdTP9Pz7CKGKpcp8t/p+O0LJhOo+YayC6DBnOoOkSIlNKhxCz2+1tV0On3FkKIG+eDBmI2EWtqwiy7Q=
Received: from 30.221.129.144(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WHHN-cm_1729076906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 19:08:27 +0800
Message-ID: <106ceb9b-0f7f-4962-98e7-d9fa86d08a0a@linux.alibaba.com>
Date: Wed, 16 Oct 2024 19:08:26 +0800
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
References: <8947c80d-9fed-4269-8a56-080d4afa782b@linux.alibaba.com>
 <tencent_D0CBD2F8C64B09A0EEDA2EFF0C8367DB0606@qq.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <tencent_D0CBD2F8C64B09A0EEDA2EFF0C8367DB0606@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 11:52 AM, Edward Adam Davis wrote:
> On Wed, 16 Oct 2024 10:06:27 +0800, Joseph Qi wrote:
>>> Reported-and-tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>> ---
>>> V1 -> V2: keep rc to 0 when falgs contains READHEAD
>>> V2 -> V3: check i_size only and alert subject and comments
>>>
>>>  fs/ocfs2/extent_map.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> #syz test
>>>
>>> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
>>> index f7672472fa82..29d27a70dbdd 100644
>>> --- a/fs/ocfs2/extent_map.c
>>> +++ b/fs/ocfs2/extent_map.c
>>> @@ -961,13 +961,17 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
>>>  	int rc = 0;
>>>  	u64 p_block, p_count;
>>>  	int i, count, done = 0;
>>> +	loff_t i_size = i_size_read(inode);
>>>  
>>>  	trace_ocfs2_read_virt_blocks(
>>>  	     inode, (unsigned long long)v_block, nr, bhs, flags,
>>>  	     validate);
>>>  
>>> +	if (!i_size)
>>> +		return -EINVAL;
>>> +
>>
>> Take a more consideration, inode size 0 doesn't mean it has no blocks,
>> since we have a case that fallocate with KEEP_SIZE.
>> Could you please check inode->i_blocks in above coredump?
> I have previously verified the value of inode->i_blocks in my testing environment, which is 0.
> 
So it seems the check condition should be:

  (v_block + nr) > (inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9))


