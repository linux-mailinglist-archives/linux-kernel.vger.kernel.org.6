Return-Path: <linux-kernel+bounces-342723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37D989221
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4FB1C228B1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F774A0F;
	Sun, 29 Sep 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hMpb+wbs"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60EEC4
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727569818; cv=none; b=gNKCXTsT1fWo+juZl7OJWxqw4we4Skoo9u7cC3ExL67o1NQMM35U+ArheM2zjZQNuVudgy2hTpbElPAkrpemJItWSoAhm4JQYD2HfATXpAW1r5pSK09kVJbQPzesqG/d+y+jIwBe0pzF6PTsfpkqmehMgZpA6a41aBf8tS8D0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727569818; c=relaxed/simple;
	bh=C/DuLFtqNmloWQZj+S4CIOtOmXIu4ZOpi5Oy8d/vJN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcaGasRWArne5tzc0urSWbx2yTAWnO+sey2Xrw19zFkjZDui9Yo1uJEGtEt2bUbFmd65htfe4J/C7tXfKcx8QWyuub7H/KhelICvBh2n5UYwh6nGA4FJ4SxBRicULGHEwLp4LVF5u9rS9E9p6fMU3tUkXmseXi845nvM+3fkalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hMpb+wbs; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=fdF8Mmjrj/ErzRc6/6+QtfMgdHqEmbP2vcFinYGTDXI=;
	b=hMpb+wbsClPmQgBuowdfwR9fbuld9cqwNoffGEe5XWrYhq5/ByCt9t7x6JXGpl
	EbNLYus7gvGG0U9fcxa21mABoXCLJzHuAceNNm3VMORoVfZQz+PY11QEFc+YcfKm
	YNmbq1bp7SbNBuU69q/GWc0EJALjn5FHxg4Rwu0/L6QT0=
Received: from [192.168.109.86] (unknown [123.149.251.210])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnLyKBn_hmK1R0Ag--.24826S2;
	Sun, 29 Sep 2024 08:29:54 +0800 (CST)
Message-ID: <817e9ada-aeae-44d5-aa74-b44fb992dfb9@126.com>
Date: Sun, 29 Sep 2024 08:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] udf: refactor udf_current_aext() to handle error
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
References: <20240926120753.3639404-1-zhaomzhao@126.com>
 <20240926120753.3639404-2-zhaomzhao@126.com>
 <20240927115509.a6ie4b75c65gjvfu@quack3>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <20240927115509.a6ie4b75c65gjvfu@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnLyKBn_hmK1R0Ag--.24826S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3tr1rKr1xKr1fXw47urg_yoW8Kw4kpr
	yUGa4UK3ZIqry7Z34Iqws09a42q3yrKr4UWr4jg3y3KFWvgr95GF17Kr4avFWDCrn5Xw4I
	v3ZYgryDuw1aya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyWlkUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbiEBNpd2b4e3PoQAAAsj

On 2024/9/27 19:55, Jan Kara wrote:
> On Thu 26-09-24 20:07:51, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> As Jan suggested in links below, refactor udf_current_aext() to
>> differentiate between error and "hit EOF", it now takes pointer to etype
>> to store the extent type, return 0 when get etype success; return -ENODATA
>> when hit EOF; return -EINVAL when i_alloc_type invalid. Add two macroes to
>> test return value.
>>
>> Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>> Suggested-by: Jan Kara <jack@suse.cz>
> ...
>> @@ -2167,9 +2173,12 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>>  {
>>  	int8_t etype;
>>  	unsigned int indirections = 0;
>> +	int err = 0;
>> +
>> +	while ((err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
>> +		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
>> +			break;
>>  
>> -	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
>> -	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
> 
> This looks wrong. If udf_current_aext() succeeds, you'll immediately abort
> the loop now. I'd rather code this as:
> 
> 	while (1) {
> 		err = udf_current_aext(inode, epos, eloc, elen, &etype, inc);
> 		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
> 			break;
> 		...
> 	}

Yes, you are right. I forget the return check, should be:
	while (!(err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
			break;
>> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
>> index 88692512a466..a902652450dd 100644
>> --- a/fs/udf/udfdecl.h
>> +++ b/fs/udf/udfdecl.h
>> @@ -43,6 +43,9 @@ extern __printf(3, 4) void _udf_warn(struct super_block *sb,
>>  #define UDF_NAME_LEN		254
>>  #define UDF_NAME_LEN_CS0	255
>>  
>> +#define UDF_EXT_EOF(err)        ((err) == -ENODATA)
>> +#define UDF_EXT_ERR(err)        (((err) < 0) && (!UDF_EXT_EOF(err)))
>> +
> 
> So I agree the explicit ENODATA checks are a bit ugly but these macros
> aren't really much better. How about the following calling convention:
> 
> On error, ret < 0, on EOF ret == 0, on success ret == 1. This is a similar
> convention as e.g. for read(2) so it is well understood and easy test for
> various combinations.

No problem, I will add some comments on these three functions do it in V3.


