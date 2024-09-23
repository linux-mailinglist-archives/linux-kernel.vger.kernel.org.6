Return-Path: <linux-kernel+bounces-335366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C397E4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93234B20CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D3256E;
	Mon, 23 Sep 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EFYPS6B9"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D210E9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055403; cv=none; b=AUaCSCeuwln88Twy27AduLWTw+mZzXFt2rfEBad5CsL9/0tR1wQM+iZ6vuMa6m4bdQU0NkbMrtfycrtMZg+/CA+gye7bc6CyS0t+hwjGbwm8fe++5jwox39eT0TOv51YMx+eECkdC0tREKOZl0+kTgJNgaaLRtIe52jauKjx7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055403; c=relaxed/simple;
	bh=HlZ6fUQfLH1H7CZhZH/SQhSK1lkDN0Ds0xwdN4XItLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqgldRmS8qpqj4x49QuA/URXXK2qSIaUrrI5q8wRmoFe+nhrwyC7BHwK2TgZykLxbNqHmupTspnQyTzj9ObSf41UhcFq2vXnDSO8BEqHknP3qcnUvfgIm9dNFIaHL7nkF6bGYGTZfXNhuvqq+5U1a26fegVyvY/DcKdDbim8Mos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EFYPS6B9; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=moG8l5RjdTjo67c09ctl2LVn8DlgPPZnW1CGMz9jceo=;
	b=EFYPS6B9ZK9r5EQYvI4INMjbJpiz+mkPt2Vnkxv3vfgG3Vww+kqztOGEwXoyEZ
	2s8qD3AjnZIwi7aIooY0K2jwcqgWKrJKoQ2wE4CLMFipG2bUkt/1nmA8sBAJLpNq
	VdYJHzjxUScFwrpbyg+oKl8MCuecYaJslNN0ET1Wo0nfU=
Received: from [192.168.109.86] (unknown [123.149.2.202])
	by gzsmtp3 (Coremail) with SMTP id pykvCgDXj+3uxfBm9lADAQ--.5470S2;
	Mon, 23 Sep 2024 09:35:42 +0800 (CST)
Message-ID: <9a493354-444a-4d2e-820e-fb6eaeb31b74@126.com>
Date: Mon, 23 Sep 2024 09:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] udf: refactor udf_current_aext() to handle error
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-2-zhaomzhao@126.com>
 <20240920150952.bqzxuhnvgh6zx5rg@quack3>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <20240920150952.bqzxuhnvgh6zx5rg@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:pykvCgDXj+3uxfBm9lADAQ--.5470S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1kAr18JFWfXF43tFWDJwb_yoW5JF1kpr
	W7CFZFkFn0qrW7Zr4Fvws8Za4aqay5Ar4UWr4jg3Z3tF4jgr93t3W7Kr43uF1UKrn3uw4I
	vFs5tw1v9w1xtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyKZXUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6A5jd2bwv7CAvwAAsU

On 2024/9/20 23:09, Jan Kara wrote:
> On Wed 18-09-24 17:36:32, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> As Jan suggested in links below, refactor udf_current_aext() to
>> differentiate between error and "hit EOF", it now takes pointer to etype
>> to store the extent type, return 0 when get etype success; return -ENODATA
>> when hit EOF; return -EINVAL when i_alloc_type invalid.
>>
>> Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
>>
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Two comments below.
> 
>> @@ -1999,10 +2000,12 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>>  	if (epos->offset + adsize > sb->s_blocksize) {
>>  		struct kernel_lb_addr cp_loc;
>>  		uint32_t cp_len;
>> -		int cp_type;
>> +		int8_t cp_type;
>>  
>>  		epos->offset -= adsize;
>> -		cp_type = udf_current_aext(inode, epos, &cp_loc, &cp_len, 0);
>> +		err = udf_current_aext(inode, epos, &cp_loc, &cp_len, &cp_type, 0);
>> +		if (err < 0)
>> +			goto err_out;
>>  		cp_len |= ((uint32_t)cp_type) << 30;
>>  
>>  		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
>> @@ -2017,6 +2020,9 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>>  	*epos = nepos;
>>  
>>  	return 0;
>> +err_out:
>> +	brelse(epos->bh);
>> +	return err;
>>  }
> 
> So here I don't think we want to release epos->bh. Rather we need to
> release 'bh' itself which we have got because we did't replace epos->bh yet
> with it.
Yes, should be bh as we haven't done `*epos = nepos`. Will fix.
 
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
>>  		udf_pblk_t block;
>>  
>>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
>> @@ -2190,14 +2199,14 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>>  		}
>>  	}
>>  
>> -	return etype;
>> +	return err;
>>  }
> 
> This doesn't look right. Probably it gets fixed up in the following patches
> but here should be something like: !err ? etype : -1
> to keep udf_next_aext() compatible with its users.
> 
> Otherwise the patch looks good.
> 
> 								Honza
> 

Will do


