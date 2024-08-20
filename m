Return-Path: <linux-kernel+bounces-293190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14752957BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5922286267
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E042A99;
	Tue, 20 Aug 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiCGNBE3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71EDDAD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123540; cv=none; b=ZIiArziigGOhM7c+hW9rlDp93R1THpOOKOtIYCfi2F2C6p4V8RXlcbr3WRjVo/l+uq+82Id5J8MWPk7V1l67p6T/hdhnJSl62yM2EPMLnmy6OA3lq+QI7K73wvdM2QfIj7DrjpNudp/WRAbjJTrAb0+Kp39CdOgYMyIZKdTPYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123540; c=relaxed/simple;
	bh=QKhlxlwDATkF97MPMQ4ixIJvaRr3OUD3A0KzVY7UtcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/1OzMP4tamFQb0I39e6o98jVPShQS3Qdfp5cmK2P3UhD9DnKM6hY1MGytvCi1mW7f1hCSGCuI/lViPWe29aDTQXqL2F/TW30XyqTuTtpRdUyMLZl3SxWapjR3SiSsoBMJfUI9YmMwMAoo9Qg2nuQsVRqot+bXjAieoHfEsQUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiCGNBE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5A4C32782;
	Tue, 20 Aug 2024 03:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724123540;
	bh=QKhlxlwDATkF97MPMQ4ixIJvaRr3OUD3A0KzVY7UtcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GiCGNBE3xLlyf1xZyuQYHVyVFWFSQoAk0fr4slWSym6noDyAOXLEp9aS/k33Mu0/6
	 67hX9E4u4Yrdg/1tJjdgwus0Esmc7FKecHJ2+dDhgMP/Mp6+IX/c6sSBKn1PFAgKBn
	 3daJZ6VWqOXosqrg+7NN6p4CDxPpk8n9u61ML9BeuIKR1gWXu2mb0D9nYlxA7Edbd7
	 IpRfCftyUW5GHuemsKpGTKey0PSpgwgMKkmtRh8iweWeELQGWYfpMJC4hcQ9ciJhoP
	 kO/O2B18zcEfSH1HWsRoCU8sBQsflrg6e6k3D8LP2tt5GByH3yes3kKk02sBXItHme
	 bjG8J7oovIQmQ==
Message-ID: <3edbddee-3215-4d20-bb74-084acc7fa813@kernel.org>
Date: Tue, 20 Aug 2024 11:12:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] f2fs: convert f2fs_write_end() to use folio
To: Li Zetao <lizetao1@huawei.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20240819012023.3871272-1-chao@kernel.org>
 <20240819012023.3871272-2-chao@kernel.org>
 <52808e24-923d-4758-a08f-7bba87fc42b0@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <52808e24-923d-4758-a08f-7bba87fc42b0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/20 11:04, Li Zetao wrote:
> Hi,
> 
> 在 2024/8/19 9:20, Chao Yu 写道:
>> Convert to use folio, so that we can get rid of 'page->index' to
>> prepare for removal of 'index' field in structure page [1].
>>
>> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
>>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 9e1ade13060c..e114d738b6b4 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -3378,7 +3378,7 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
>>   }
>>   static int prepare_write_begin(struct f2fs_sb_info *sbi,
>> -            struct page *page, loff_t pos, unsigned len,
>> +            struct folio *folio, loff_t pos, unsigned int len,
>>               block_t *blk_addr, bool *node_changed)
>>   {
>>       struct inode *inode = folio->mapping->host;
>> @@ -3425,7 +3425,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>                   set_page_private_inline(ipage);
>>               goto out;
>>           }
>> -        err = f2fs_convert_inline_page(&dn, page);
>> +        err = f2fs_convert_inline_page(&dn, folio_page(folio, 0));
>>           if (err || dn.data_blkaddr != NULL_ADDR)
>>               goto out;
>>       }
>> @@ -3629,7 +3629,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>>       folio = page_folio(page);
>>       if (f2fs_is_atomic_file(inode))
>> -        err = prepare_atomic_write_begin(sbi, folio, pos, len
>> +        err = prepare_atomic_write_begin(sbi, folio, pos, len,

Thanks for your reminder, I removed comma after @len in patch 1/8 by
mistake, let me fix it.

Thanks,

> This has been changed in the first patch, it is redundant here.
>>                       &blkaddr, &need_balance, &use_cow);
>>       else
>>           err = prepare_write_begin(sbi, folio, pos, len,
>> @@ -3698,7 +3698,8 @@ static int f2fs_write_end(struct file *file,
>>               loff_t pos, unsigned len, unsigned copied,
>>               struct page *page, void *fsdata)
>>   {
>> -    struct inode *inode = page->mapping->host;
>> +    struct folio *folio = page_folio(page);
>> +    struct inode *inode = folio->mapping->host;
>>       trace_f2fs_write_end(inode, pos, len, copied);
>> @@ -3707,17 +3708,17 @@ static int f2fs_write_end(struct file *file,
>>        * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
>>        * let generic_perform_write() try to copy data again through copied=0.
>>        */
>> -    if (!PageUptodate(page)) {
>> +    if (!folio_test_uptodate(folio)) {
>>           if (unlikely(copied != len))
>>               copied = 0;
>>           else
>> -            SetPageUptodate(page);
>> +            folio_mark_uptodate(folio);
>>       }
>>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>>       /* overwrite compressed file */
>>       if (f2fs_compressed_file(inode) && fsdata) {
>> -        f2fs_compress_write_end(inode, fsdata, page->index, copied);
>> +        f2fs_compress_write_end(inode, fsdata, folio->index, copied);
>>           f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>>           if (pos + copied > i_size_read(inode) &&
>> @@ -3730,10 +3731,10 @@ static int f2fs_write_end(struct file *file,
>>       if (!copied)
>>           goto unlock_out;
>> -    set_page_dirty(page);
>> +    folio_mark_dirty(folio);
>>       if (f2fs_is_atomic_file(inode))
>> -        set_page_private_atomic(page);
>> +        set_page_private_atomic(folio_page(folio, 0));
>>       if (pos + copied > i_size_read(inode) &&
>>           !f2fs_verity_in_progress(inode)) {


