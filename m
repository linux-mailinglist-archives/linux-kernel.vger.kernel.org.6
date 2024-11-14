Return-Path: <linux-kernel+bounces-410064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D69C9613
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EE21F228BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB111B21A0;
	Thu, 14 Nov 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jHshrpyZ"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D41AC428
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626804; cv=none; b=kwZnnmIoY2HbDU8/mLiDA0DxWWMaxGXsLi6/0IiWyh2MOk7CJczxralCTeSVnVAYL+xnn2wa5p0AT5MBgENCx0HUD6ggT4RhS9AEBEpaZq5oYOL6+Brn/OKNDfylq+S27GTNkekn+FxY2/SDPKUmN4A9DxSrdKHF9N7m5LmOVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626804; c=relaxed/simple;
	bh=KvTcAydtgrBjPumsHcsRu27BEE+OBHdmYnbv5GWGofc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbjOkiOfP6yfQDRRTRbxzmpAn17FyZ7h/ATC0ROaAt/5ySiSaDqvR8g2pjGnr4a7rg4CaTeDfQVMoCC1o+C2TJot7T8SaB46+JbHBo3nusWnt7HYfJ7OgbyfutnRTESYQwRIjVIZq/iGIf2bDIm5dTpNBpKTBGgG4SFIMYkK80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jHshrpyZ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731626793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tnZw5adGdOhJwCinqZvM/nZSomtSMm0guGslbdNkndU=;
	b=jHshrpyZZgXmdImFEc8ZOEsluJmADMTxDCuxSRmIgZoUhWGTjp+hqw0vhnAvvnfecjt4ZewsPttzTjCn5RfSTQZ+0PZ4RiokMnyT8epzCMiDFgc2qn/Plei4JGrQc/8vcIMWnVi5t7kQ8v80/upk8WWgYK5uTtsn38n7ylt6Q0w=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJQNHih_1731626792 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 07:26:33 +0800
Message-ID: <e878e14a-eec7-4df4-b33d-f2defa8a92cb@linux.alibaba.com>
Date: Fri, 15 Nov 2024 07:26:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
References: <20241114090109.757690-1-hsiangkao@linux.alibaba.com>
 <20241114161823.GN3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114161823.GN3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/15 00:18, Al Viro wrote:
> On Thu, Nov 14, 2024 at 05:01:09PM +0800, Gao Xiang wrote:
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -38,7 +38,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>>   	}
>>   	if (!folio || !folio_contains(folio, index)) {
>>   		erofs_put_metabuf(buf);
>> -		folio = read_mapping_folio(buf->mapping, index, NULL);
>> +		folio = buf->file ? read_mapping_folio(buf->file->f_mapping,
>> +					index, buf->file) :
>> +			read_mapping_folio(buf->mapping, index, NULL);
>>   		if (IS_ERR(folio))
>>   			return folio;
>>   	}
>> @@ -61,8 +63,8 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (erofs_is_fileio_mode(sbi))
>> -		buf->mapping = file_inode(sbi->fdev)->i_mapping;
>> +	if (erofs_is_fileio_mode(sbi))	/* some fs like FUSE needs it */
>> +		buf->file = sbi->fdev;
> 
> Would be easier to set *both* ->mapping and ->file at that point, so that
> erofs_bread() would just have read_mapping_folio(buf->mapping, index, buf->file),
> unconditionally...

Ok, will do the next version.

Thanks,
Gao Xiang

