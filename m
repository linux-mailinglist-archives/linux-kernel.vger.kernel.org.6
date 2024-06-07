Return-Path: <linux-kernel+bounces-206219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65B9005E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5341E1C208D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9A0195985;
	Fri,  7 Jun 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvY2CVq8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE7192B89
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769455; cv=none; b=MnipIiBNDsnngQtIKv32OgtKCROYzxxNopXZXjP9DiofGY1q3QvTfFVhdBGAqmGUyMnjne6MT4RbNAhMSS+mP1h8D+dsV1vVnT02x5tqgjcz74DsYOf4ZbhCyS6YkS5fCQHsQvdFHOEdIbC3r/okKHM3RGrUf6jpnhR0akZANhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769455; c=relaxed/simple;
	bh=sciOujBFI9gvywDifAfAlIe7Qf9PZPeyUwNpz1jEwuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gsfi5cOI+8267uexweup6oMvvtA+lQQbrDWZhufNpTu2arrm8DTaTa4I15b6KCRJWTYc9zUdLGn0rwd8kjiezhVeMLf+g07HYb+TLy+KPuwRvL8NkM7qAj/UP5/YOvO1YpQuyMM7Px6Adox966k0J+5YUBNyHOYL/VNEH8e0WwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvY2CVq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0159C32782;
	Fri,  7 Jun 2024 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717769455;
	bh=sciOujBFI9gvywDifAfAlIe7Qf9PZPeyUwNpz1jEwuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pvY2CVq82lHS2IuDhm/tTt7LaBqa4lOD0C8bwAzVku489mHX+y2OC85cRr3L2Pph7
	 4mb+lgTl65sM9E++pv74B969fSm0Pt2Czp1IqR9G5PcNNHJdJBK5KIdsw8rnws+rJC
	 Uo6v5NlFYxNpulwetYMqEb637dfuqyrbjIOvi82SA9g9OKn7+5IkSagf28rruqrGAL
	 iq57r5eY66ppTyjE4SUObD83ZOZ1C2p+CZUsYUOU8tHR7pA+HizK00eg/ilRvR06D4
	 xxHCD+S8EjNKPa5vdR9sFQaewZdWWcTr9XXmfVvcHsxtOaCjCyonNZkXT4Eoy7b9/a
	 i65rb4AsfWNvw==
Message-ID: <e56b6166-1bb4-411a-a701-51bf452d2369@kernel.org>
Date: Fri, 7 Jun 2024 22:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: get rid of buffer_head use
To: Matthew Wilcox <willy@infradead.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240607101829.389015-1-chao@kernel.org>
 <ZmMMDy9eeCU2igqj@casper.infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <ZmMMDy9eeCU2igqj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/7 21:33, Matthew Wilcox wrote:
> On Fri, Jun 07, 2024 at 06:18:29PM +0800, Chao Yu wrote:
>> @@ -1990,6 +1989,12 @@ static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
>>   	return (struct f2fs_super_block *)(sbi->raw_super);
>>   }
>>   
>> +static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio)
>> +{
>> +	return (struct f2fs_super_block *)(page_address(folio_page(folio, 0)) +
>> +							F2FS_SUPER_OFFSET);
>> +}
> 
> This assumes that the superblock is in the first page of the folio.
> That's not necessarily guaranteed; let's say you have a 64KiB folio
> that covers the start of the bdev.

Oh, I missed to add large folio support in this version.

For the case: page size is 4KiB, and folio size is 64KiB,
read_mapping_folio(mapping, 0, NULL) and read_mapping_folio(mapping,
1, NULL) will return the same #0 folio, right?

> 
> I don't quite know how to write this because f2fs defines its block size
> in terms of PAGE_SIZE, which just seems like nonsense to me.  If you
> format a filesystem on a 16KiB PAGE_SIZE machine and then try to mount
> it on a machine with a 4KiB PAGE_SIZE, it's going to go horribly wrong.

f2fs will check on-disk block size w/ PAGE_SIZE in sanity_check_raw_super()
as below:

	/* only support block_size equals to PAGE_SIZE */
	if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS) {
		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
			  le32_to_cpu(raw_super->log_blocksize),
			  F2FS_BLKSIZE_BITS);
		return -EFSCORRUPTED;
	}

> 
> You'd need to pass in something that indicates whether you're trying to
> access the first or second superblock; there's no way to tell from the
> folio which one it is.
> 
>> +static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
>> +								bool update)
>>   {
>> -	lock_buffer(bh);
>> -	if (super)
>> -		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
>> -	set_buffer_dirty(bh);
>> -	unlock_buffer(bh);
>> -
>> +	struct bio *bio;
>>   	/* it's rare case, we can do fua all the time */
>> -	return __sync_dirty_buffer(bh, REQ_SYNC | REQ_PREFLUSH | REQ_FUA);
>> +	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA;
>> +	int ret;
>> +
>> +	folio_lock(folio);
>> +	folio_wait_writeback(folio);
>> +	if (update)
>> +		memcpy(F2FS_SUPER_BLOCK(folio), F2FS_RAW_SUPER(sbi),
>> +					sizeof(struct f2fs_super_block));
>> +	folio_mark_dirty(folio);
>> +	folio_clear_dirty_for_io(folio);
>> +	folio_start_writeback(folio);
>> +	folio_unlock(folio);
>> +
>> +	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
>> +
>> +	/* it doesn't need to set crypto context for superblock update */
>> +	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(folio_index(folio));
>> +
>> +	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
>> +		f2fs_bug_on(sbi, 1);
> 
> Better make that folio_size(folio) to support bs>PS.

Looks better, will update.

Thanks,

> 

