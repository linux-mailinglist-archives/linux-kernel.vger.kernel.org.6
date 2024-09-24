Return-Path: <linux-kernel+bounces-337115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E8984595
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B6E1C2199C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4101A7076;
	Tue, 24 Sep 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PeYwUKB2"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F9126C04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179762; cv=none; b=mNoC4Bp4ud3AwgKXGziIqUcbW5X4vnHDnCrRLH4BAINIJ8vpAWMOMbmw+KnB/Aup0riqk7DkZ30zxkbffHOHLvrRdjjsEUEwrZsS4iivfV/Lpc/qqxwBuB0YzzG/bTwExvoyrwI8M2PyB7kEJrQ2H1qmF0UQ2Ci9BimyCZVcV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179762; c=relaxed/simple;
	bh=yr/6p1XuaflXZcbWcYM7BNT0tAUaUqmryFgL6upSusY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR9Rmm7i4mBapMEGgMm4vIdW3RybtDAIqV4Jv2mQNNEsRjbvvYuaa5i6LKItiGGrIQxt+1LwAqwKdd/E5ifuD+P5PiSJ77Rat3e7VML6jqJi62EXroqH7VjCbsu3fd1kNabbHaZGzLIgqBpENCskKhKkVIk6XZvfEy2csEU3w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PeYwUKB2; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=dzYX9L6IeUKBp98QvN+GVTSyWqQvMJBA1AMuWxDdckc=;
	b=PeYwUKB2VSKhaCRU5KTS65gQqJ7DuFtjFAvWWABiVLEtXQzKcXnLHOE04l66cV
	beVbHNnoM0SPK3wvCqe5/BXIIHe1bbsP2e2AA6EdfXn0M445EyWnx6oRL8jiyZIl
	9eFVpc6mpsXDr5Pgl8lzkC2WnASHkPXBZB8aNnwDVrmg8=
Received: from [192.168.109.86] (unknown [123.149.2.202])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3n5TZq_JmYlAkDA--.13825S2;
	Tue, 24 Sep 2024 20:08:57 +0800 (CST)
Message-ID: <6b22baa6-a75f-45ff-a0cb-33ae0ecf4720@126.com>
Date: Tue, 24 Sep 2024 20:08:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] udf: refactor udf_next_aext() to handle error
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-3-zhaomzhao@126.com>
 <20240920154701.xotlrf37bjlwtg3i@quack3>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <20240920154701.xotlrf37bjlwtg3i@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3n5TZq_JmYlAkDA--.13825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr47CF1fGr47Zry5KF45KFg_yoW3AF1rpr
	97KayqyayYgFW7ur4IqF4DZr10qa42kF4UCrnYqasxtF48Xr15KFyFkryY9F1Uurs3Xw4S
	qr4rK34DCw1xKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyKZXUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6BBkd2bymnOv9AAAsN

On 2024/9/20 23:47, Jan Kara wrote:
> On Wed 18-09-24 17:36:33, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> Same as udf_current_aext(), take pointer to etype to store the extent
>> type, while return 0 for success and <0 on error.
>>
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> ...
> 
>> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
>> index 93153665eb37..f865538c985d 100644
>> --- a/fs/udf/directory.c
>> +++ b/fs/udf/directory.c
>> @@ -166,13 +166,16 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
>>   */
>>  static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
>>  {
>> +	int8_t etype;
>> +	int err = 0;
> 
> Nit: please add empty line between declaration and the code.
> 
>>  	iter->loffset++;
>>  	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
>>  		return 0;
>>  
>>  	iter->loffset = 0;
>> -	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
>> -			!= (EXT_RECORDED_ALLOCATED >> 30)) {
>> +	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen,
>> +			    &etype, 1);
>> +	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>>  		if (iter->pos == iter->dir->i_size) {
>>  			iter->elen = 0;
>>  			return 0;
> 
> ...
> 
>> @@ -555,7 +556,7 @@ static int udf_do_extend_file(struct inode *inode,
>>  		 * empty indirect extent.
>>  		 */
>>  		if (new_block_bytes)
>> -			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
>> +			udf_next_aext(inode, last_pos, &tmploc, &tmplen, &tmptype, 0);
>>  	}
>>  	iinfo->i_lenExtents += add;
>>  
> 
> Hum, this will need error checking but we can leave that for future
> patches.
> 
>> @@ -674,8 +675,8 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>>  		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
>>  	} else {
>>  		epos.offset -= adsize;
>> -		etype = udf_next_aext(inode, &epos, &extent.extLocation,
>> -				      &extent.extLength, 0);
>> +		udf_next_aext(inode, &epos, &extent.extLocation,
>> +				&extent.extLength, &etype, 0);
>>  		extent.extLength |= etype << 30;
>>  	}
>>  
>> @@ -712,7 +713,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>>  	loff_t lbcount = 0, b_off = 0;
>>  	udf_pblk_t newblocknum;
>>  	sector_t offset = 0;
>> -	int8_t etype;
>> +	int8_t etype, tmpetype;
>>  	struct udf_inode_info *iinfo = UDF_I(inode);
>>  	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
>>  	int lastblock = 0;
>> @@ -748,8 +749,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>>  		prev_epos.offset = cur_epos.offset;
>>  		cur_epos.offset = next_epos.offset;
>>  
>> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
>> -		if (etype == -1)
>> +		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
>> +		if (ret)
>>  			break;
> 
> I think here we need to add error handling as well and we should probably
> do it in this patch / patch series. If ret is ENODATA, we just break out
> from the cycle but if ret is some other error, we need to return that error
> from inode_getblk().
> 
>> @@ -771,8 +772,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>>  	 * Move prev_epos and cur_epos into indirect extent if we are at
>>  	 * the pointer to it
>>  	 */
>> -	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
>> -	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
>> +	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
>> +	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
> 
> Again, this should have error handling now.
> 
>>  
>>  	/* if the extent is allocated and recorded, return the block
>>  	   if the extent is not a multiple of the blocksize, round up */
>> @@ -793,7 +794,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>>  	}
>>  
>>  	/* Are we beyond EOF and preallocated extent? */
>> -	if (etype == -1) {
>> +	if (ret < 0) {
> 
> I'd prefer ret == -ENODATA to make this explicit.
> 
>>  		loff_t hole_len;
>>  
>>  		isBeyondEOF = true;
>> @@ -846,8 +847,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>>  
>>  		/* if the current block is located in an extent,
>>  		   read the next extent */
>> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
>> -		if (etype != -1) {
>> +		if (!udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0)) {
>>  			laarr[c + 1].extLength = (etype << 30) | elen;
>>  			laarr[c + 1].extLocation = eloc;
>>  			count++;
> 
> And this should be distinguisting between EOF and other errors so that we
> don't set lastblock wrongly. Instead we should bail with error.
> 
>> @@ -1190,13 +1191,13 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
>>  			if (err < 0)
>>  				return err;
>>  			udf_next_aext(inode, epos, &laarr[i].extLocation,
>> -				      &laarr[i].extLength, 1);
>> +				      &laarr[i].extLength, &tmptype, 1);
>>  			start++;
>>  		}
>>  	}
>>  
>>  	for (i = start; i < endnum; i++) {
>> -		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
>> +		udf_next_aext(inode, epos, &tmploc, &tmplen, &tmptype, 0);
>>  		udf_write_aext(inode, epos, &laarr[i].extLocation,
>>  			       laarr[i].extLength, 1);
>>  	}
> 
> Again these two calls should have error handling now. udf_update_extents()
> is already able to return errors.
> 
>> @@ -2267,7 +2268,7 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
>>  	if (epos.bh)
>>  		get_bh(epos.bh);
>>  
>> -	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
>> +	while (!udf_next_aext(inode, &epos, &oeloc, &oelen, &etype, 0)) {
>>  		udf_write_aext(inode, &epos, &neloc, nelen, 1);
>>  		neloc = oeloc;
>>  		nelen = (etype << 30) | oelen;
> 
> Here, we should check if udf_next_aext() returned error (other than
> ENODATA) and bail in that case instead of trying to insert new extent.
> 
>> @@ -2302,10 +2303,10 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>>  		adsize = 0;
>>  
>>  	oepos = epos;
>> -	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
>> +	if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1))
>>  		return -1;
>>  
>> -	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
>> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1)) {
>>  		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
>>  		if (oepos.bh != epos.bh) {
>>  			oepos.block = epos.block;
>> @@ -2379,8 +2380,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>>  	}
>>  	*elen = 0;
>>  	do {
>> -		etype = udf_next_aext(inode, pos, eloc, elen, 1);
>> -		if (etype == -1) {
>> +		if (udf_next_aext(inode, pos, eloc, elen, &etype, 1)) {
>>  			*offset = (bcount - lbcount) >> blocksize_bits;
>>  			iinfo->i_lenExtents = lbcount;
>>  			return -1;
> 
> Again, here we need to distinguish ENODATA from other errors so that we
> don't wrongly consider failure to read extent like EOF.
> 
>> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
>> index 91b6e2698e7e..b7361222f988 100644
>> --- a/fs/udf/truncate.c
>> +++ b/fs/udf/truncate.c
>> @@ -85,7 +85,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>>  		BUG();
>>  
>>  	/* Find the last extent in the file */
>> -	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
>> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1)) {
>>  		etype = netype;
>>  		lbcount += elen;
>>  		if (lbcount > inode->i_size) {
> 
> This should be checking for error (after the loop) so that we don't
> accidentally try to truncate extents early in case of error.
> 
Sorry to bother, in case of error(including EOF), it won't go into the loop and
has chance to call extent_trunc(). After the loop, only some update and clean op,

	iinfo->i_lenExtents = inode->i_size;
	brelse(epos.bh);

So I'm a little confused which part of this piece of code needs to change?
 


