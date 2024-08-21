Return-Path: <linux-kernel+bounces-294808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC29592ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6BF1F23F67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926C14BF8B;
	Wed, 21 Aug 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iVIqwJuh"
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05AD146D75
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207699; cv=none; b=GcqqGUPAoVz+b1l/S0pkjR7oRpwKYAL9C93YAiE8dRU3LeGfNU/UFhE2eMh7GkuQlDVyVpJfqP6NKa7p0iwLxeynGRBgZJgg3CWz82sejBYdej5tg0ZuAbU8Ta4AhauC2fOCQKj1HJ9fyH3kY1y3SMGpOYuHgkFR+wI4bV633Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207699; c=relaxed/simple;
	bh=2vIZoAkI1Z9uABYuBIDeLBVi4Sea2hT1Cb7RdlLY72Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P+7ELsEea9kbWCrWaBtxOuCsNQ+0pzoZA5gacp4ZMew1ELMpJtZMqOu1HDidEP8X9x3oS/q80a26AAm05+LcmFFVd0RS1fiXZvcziVdUmvuIRMeYhBx6sWI+E857wzsxs89YBrxi5as5LlcWLVM1nx925EkhR7zKn30aNHcaWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iVIqwJuh; arc=none smtp.client-ip=47.90.199.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724207689; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=xh6r/ko5G9TK3mJe6TGl9rTenCN9wEzZQt+59fp/fb8=;
	b=iVIqwJuhLO9OdmPgg1Ab2MdK5Bi84eN47rTZPJ1ocgUX6u/lS/35xoQ1NqSFgeCsWPyFFepTXypY56hRCh5Hv9HLq7w5qq20RdQlA2NQ2kVsou5tbq0MNly/p+fBWV7jruX6VDuIdEp6TRg9dWCdY9tBFdXkC024KwzEzBdSsDI=
Received: from 30.221.129.221(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDKIOcs_1724207688)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 10:34:49 +0800
Message-ID: <416247e6-5da7-401c-815f-a4cf8ae37d51@linux.alibaba.com>
Date: Wed, 21 Aug 2024 10:34:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Lizhi Xu <lizhi.xu@windriver.com>, heming.zhao@suse.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
 <20240820094512.2228159-1-lizhi.xu@windriver.com>
 <20240820094512.2228159-2-lizhi.xu@windriver.com>
 <7da687ce-ffb7-44e3-bddc-d5c2f4f48c95@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <7da687ce-ffb7-44e3-bddc-d5c2f4f48c95@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

And this is not a UAF case, but NULL pointer dereference.
So I suggest change the subject to:
ocfs2: fix possible NULL pointer dereference in ocfs2_set_buffer_uptodate

On 8/21/24 8:08 AM, Joseph Qi wrote:
> 
> 
> On 8/20/24 5:45 PM, Lizhi Xu wrote:
>> In the for-loop after the 'read_failure' label, the condition
>> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
>> When this contidion is true, this for-loop will call ocfs2_set_buffer
>> _uptodate(ci, bh), which then triggers a NULL pointer access error.
>>
> 
> Or it may simplified as the following:
> 
> When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
> NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
> bh is NULL.
> 
>> Changes from V2:
>> * Make the code more concise
>>
> 
> This is not the right place for changelog.
> 
> Thanks,
> Joseph
> 
>> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>> Reviewed-by: Heming Zhao <heming.zhao@suse.com>
>> ---
>>  fs/ocfs2/buffer_head_io.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
>> index e62c7e1de4eb..8f714406528d 100644
>> --- a/fs/ocfs2/buffer_head_io.c
>> +++ b/fs/ocfs2/buffer_head_io.c
>> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>>  		/* Always set the buffer in the cache, even if it was
>>  		 * a forced read, or read-ahead which hasn't yet
>>  		 * completed. */
>> -		ocfs2_set_buffer_uptodate(ci, bh);
>> +		if (bh)
>> +			ocfs2_set_buffer_uptodate(ci, bh);
>>  	}
>>  	ocfs2_metadata_cache_io_unlock(ci);
>>  

