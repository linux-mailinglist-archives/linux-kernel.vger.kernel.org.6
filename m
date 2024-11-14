Return-Path: <linux-kernel+bounces-408747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064699C8307
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C52D1F2375A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDADD1E7C34;
	Thu, 14 Nov 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WdGNSCxP"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C2905
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565423; cv=none; b=MQJfu+/TfXTyxrSxYeYcxy4xPy1T9n69tcm3XfFNCGCHOJMjCJMn9KnC/mSBz4e4/MWwTbfQDK1YRAbB2NAW4UDemhPRBjPGUDPXbddUvldXg+XCaSPr4JXi/3SJ6onmpNhP4Ptcno+pcBFIn65sAv1TYgUVlUhfvhgAZb/FeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565423; c=relaxed/simple;
	bh=X4L+twC1NOgMp94dtJsXHfXYCtRn9MevcAFxmBXxmMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaDuupsGp0rnqIHjjL5qXoE26+rMdOhxY7g0QdKq+YgOcaHw1aPQCd/LwJoE7EscbOC+3RFbS0BkZxqjG5BcRk23hI5F+cysidx1PqoavlXZQGdc2SYZosPWlV7/62qHq2KCQ9618n+hKj1EsaMwBSQ7u9NGB8kNvO0E4OT7OaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WdGNSCxP; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731565409; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G6Rh8YayiJ3l9UGc9UACdDnDVmzCbGcYUPz+C6VwgWI=;
	b=WdGNSCxP3Gqiw14iN6abtjmzGK4baaSbbJDHMPip4IvolRe5aN3gRuLfiGw/VBrMXEpIwOOfmn+meVXDuoWlYaFSgBzFfQdPkeiAWQCYaUt6l6A4loAoPslfPZ/w5W/KpTZXUZGBtQCQ7eAqWt4eqPQJiE5PnnqFBZATrNArxmA=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNRdxs_1731565407 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 14:23:28 +0800
Message-ID: <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
Date: Thu, 14 Nov 2024 14:23:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
 <20241114060434.GL3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114060434.GL3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/11/14 14:04, Al Viro wrote:
> On Thu, Nov 14, 2024 at 01:19:57PM +0800, Gao Xiang wrote:
> 
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 6355866220ff..43c89194d348 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -38,7 +38,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>>   	}
>>   	if (!folio || !folio_contains(folio, index)) {
>>   		erofs_put_metabuf(buf);
>> -		folio = read_mapping_folio(buf->mapping, index, NULL);
>> +		folio = buf->use_fp ?
>> +			read_mapping_folio(file_inode(buf->filp)->i_mapping,
>> +				index, buf->filp) :
>> +			read_mapping_folio(buf->mapping, index, NULL);
> 
> UGH...
> 
> 1) 'filp' is an atrocious identifier.  Please, don't perpetuate
> the piss-poor taste of AST - if you want to say 'file', say so.

ok.

> 
> 2) there's ->f_mapping; no need to go through the file_inode().

Yeah, thanks for the suggestion.

> 
> 3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
> the point of having that as a separate field?

Once buf->kmap_type has EROFS_KMAP and EROFS_KMAP_ATOMIC, but it
seems that it can be cleaned up now.

I will clean up later but it's a seperate story.

> 
> 4) Why bother with union?  Just have buf->file serve as your buf->use_fp
> and be done with that...

I'd like to leave `struct erofs_buf` as small as possible since
it's on stack.

Leave two fields for this are also ok for me anyway.

Thanks,
Gao Xiang

