Return-Path: <linux-kernel+bounces-399490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232D9BFFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797131F23374
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA01D3644;
	Thu,  7 Nov 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1FOwYpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03B1CF7BB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966964; cv=none; b=IpbIJmgg6t2Ay7EzAUOOYctJeKbwODgMuRyWOnSm6osx368f/85CgqVJFAGr7hN2PtwRdI4OKdR64zYnovGGxkgzqAbvK1xAfaDbBBFT6nyoeNbSP8eF3AGoVYgIWW9eBDMbVs7txnQCilFefE0wEEiMsbyF1SvBVPh5QntR0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966964; c=relaxed/simple;
	bh=OJ4qKLhDnrQM+7VYMQsTUZS7sbbVTE531znMDXJYjcE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QPa24yPocWlSX6W4pPR8GirIrfDkZtEVCI2pZhAcsRxxcyNBMbIEqTtSeZWdSK6JkrA6dCQxBOLutfHwBiE40zU7Br4AdnanQqWFAAOVVzTuxhxpJWsfIU3ahCJoV6BGeywnCIB8CsuWy2viNf357VGTRwckE1Y9k3iXPgJ1uUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1FOwYpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE41DC4CECC;
	Thu,  7 Nov 2024 08:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730966964;
	bh=OJ4qKLhDnrQM+7VYMQsTUZS7sbbVTE531znMDXJYjcE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=q1FOwYpWAIzDL9xpdnx9IAIepNGIMajpBNJWw5og933jGPw9afWUFLtakb7XPevFu
	 bnhiGqDFwrQkhRmGjVjkcZQ6iK4I+D6DPdtJ1clnVG/9JD5MJOJ4x9l4nHGRYTTzSK
	 DdOZpF9FlIsChvhBPgmnbvobYKzuoWkt6omtVZ3TjuEtLWcJkmVcxqmz2aUEm9lP4m
	 x+TxoKpep2II94mwUAmS5yQylvmLDxzxtMFoLHsXakEYZzOIiMQ2h6d73FTT964JOK
	 OQw60+7jVNh94feQaNSlV0+nlZSoCZ7xMo1gyrQXbsnVZHgPjtr5WGKqXw1sSXqr/i
	 2IdwrCbIGUIIQ==
Message-ID: <3f5de1be-43a0-469f-837c-15c61297c823@kernel.org>
Date: Thu, 7 Nov 2024 16:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
 Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK}
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20241107014602.3638020-1-chao@kernel.org>
 <CAHJ8P3LUTz9XGji5Xa2Jy-KeSuaG9HhtDhxz_aM1hE=-K+zsGw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LUTz9XGji5Xa2Jy-KeSuaG9HhtDhxz_aM1hE=-K+zsGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/7 11:19, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2024年11月7日周四 09:50写道：
>>
>> f2fs doesn't support different blksize in one instance, so
>> bytes_to_blks() and blks_to_bytes() are equal to F2FS_BYTES_TO_BLK
>> and F2FS_BLK_TO_BYTES, let's use F2FS_BYTES_TO_BLK/F2FS_BLK_TO_BYTES
>> instead for cleanup.
>>
>> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> feel free to add:
> Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

I encounter filesystem corruption w/ this patch while testing generic/051,
since we missed to cast bytes/blk argument to unsigned long long type.

-#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
-#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
+#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
+#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)

Will fix this in a separate patch.

Thanks,

> thanks!
>> ---
>>   fs/f2fs/data.c | 68 +++++++++++++++++++++-----------------------------
>>   1 file changed, 29 insertions(+), 39 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index b33aca24b9ef..0e8390cbdb5b 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1819,16 +1819,6 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
>>          return true;
>>   }
>>
>> -static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
>> -{
>> -       return (bytes >> inode->i_blkbits);
>> -}
>> -
>> -static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
>> -{
>> -       return (blks << inode->i_blkbits);
>> -}
>> -
>>   static int f2fs_xattr_fiemap(struct inode *inode,
>>                                  struct fiemap_extent_info *fieinfo)
>>   {
>> @@ -1854,7 +1844,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>>                          return err;
>>                  }
>>
>> -               phys = blks_to_bytes(inode, ni.blk_addr);
>> +               phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
>>                  offset = offsetof(struct f2fs_inode, i_addr) +
>>                                          sizeof(__le32) * (DEF_ADDRS_PER_INODE -
>>                                          get_inline_xattr_addrs(inode));
>> @@ -1886,7 +1876,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>>                          return err;
>>                  }
>>
>> -               phys = blks_to_bytes(inode, ni.blk_addr);
>> +               phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
>>                  len = inode->i_sb->s_blocksize;
>>
>>                  f2fs_put_page(page, 1);
>> @@ -1948,16 +1938,16 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>                          goto out;
>>          }
>>
>> -       if (bytes_to_blks(inode, len) == 0)
>> -               len = blks_to_bytes(inode, 1);
>> +       if (F2FS_BYTES_TO_BLK(len) == 0)
>> +               len = F2FS_BLKSIZE;
>>
>> -       start_blk = bytes_to_blks(inode, start);
>> -       last_blk = bytes_to_blks(inode, start + len - 1);
>> +       start_blk = F2FS_BYTES_TO_BLK(start);
>> +       last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
>>
>>   next:
>>          memset(&map, 0, sizeof(map));
>>          map.m_lblk = start_blk;
>> -       map.m_len = bytes_to_blks(inode, len);
>> +       map.m_len = F2FS_BYTES_TO_BLK(len);
>>          map.m_next_pgofs = &next_pgofs;
>>          map.m_seg_type = NO_CHECK_TYPE;
>>
>> @@ -1974,7 +1964,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>          if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
>>                  start_blk = next_pgofs;
>>
>> -               if (blks_to_bytes(inode, start_blk) < maxbytes)
>> +               if (F2FS_BLK_TO_BYTES(start_blk) < maxbytes)
>>                          goto prep_next;
>>
>>                  flags |= FIEMAP_EXTENT_LAST;
>> @@ -2011,14 +2001,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>          } else if (compr_appended) {
>>                  unsigned int appended_blks = cluster_size -
>>                                                  count_in_cluster + 1;
>> -               size += blks_to_bytes(inode, appended_blks);
>> +               size += F2FS_BLK_TO_BYTES(appended_blks);
>>                  start_blk += appended_blks;
>>                  compr_cluster = false;
>>          } else {
>> -               logical = blks_to_bytes(inode, start_blk);
>> +               logical = F2FS_BLK_TO_BYTES(start_blk);
>>                  phys = __is_valid_data_blkaddr(map.m_pblk) ?
>> -                       blks_to_bytes(inode, map.m_pblk) : 0;
>> -               size = blks_to_bytes(inode, map.m_len);
>> +                       F2FS_BLK_TO_BYTES(map.m_pblk) : 0;
>> +               size = F2FS_BLK_TO_BYTES(map.m_len);
>>                  flags = 0;
>>
>>                  if (compr_cluster) {
>> @@ -2026,13 +2016,13 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>                          count_in_cluster += map.m_len;
>>                          if (count_in_cluster == cluster_size) {
>>                                  compr_cluster = false;
>> -                               size += blks_to_bytes(inode, 1);
>> +                               size += F2FS_BLKSIZE;
>>                          }
>>                  } else if (map.m_flags & F2FS_MAP_DELALLOC) {
>>                          flags = FIEMAP_EXTENT_UNWRITTEN;
>>                  }
>>
>> -               start_blk += bytes_to_blks(inode, size);
>> +               start_blk += F2FS_BYTES_TO_BLK(size);
>>          }
>>
>>   prep_next:
>> @@ -2070,7 +2060,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
>>                                          struct readahead_control *rac)
>>   {
>>          struct bio *bio = *bio_ret;
>> -       const unsigned blocksize = blks_to_bytes(inode, 1);
>> +       const unsigned int blocksize = F2FS_BLKSIZE;
>>          sector_t block_in_file;
>>          sector_t last_block;
>>          sector_t last_block_in_file;
>> @@ -2080,8 +2070,8 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
>>
>>          block_in_file = (sector_t)index;
>>          last_block = block_in_file + nr_pages;
>> -       last_block_in_file = bytes_to_blks(inode,
>> -                       f2fs_readpage_limit(inode) + blocksize - 1);
>> +       last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
>> +                                                       blocksize - 1);
>>          if (last_block > last_block_in_file)
>>                  last_block = last_block_in_file;
>>
>> @@ -2181,7 +2171,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>>          struct bio *bio = *bio_ret;
>>          unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
>>          sector_t last_block_in_file;
>> -       const unsigned blocksize = blks_to_bytes(inode, 1);
>> +       const unsigned int blocksize = F2FS_BLKSIZE;
>>          struct decompress_io_ctx *dic = NULL;
>>          struct extent_info ei = {};
>>          bool from_dnode = true;
>> @@ -2190,8 +2180,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>>
>>          f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
>>
>> -       last_block_in_file = bytes_to_blks(inode,
>> -                       f2fs_readpage_limit(inode) + blocksize - 1);
>> +       last_block_in_file = F2FS_BYTES_TO_BLK(f2fs_readpage_limit(inode) +
>> +                                                       blocksize - 1);
>>
>>          /* get rid of pages beyond EOF */
>>          for (i = 0; i < cc->cluster_size; i++) {
>> @@ -3957,7 +3947,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
>>           * to be very smart.
>>           */
>>          cur_lblock = 0;
>> -       last_lblock = bytes_to_blks(inode, i_size_read(inode));
>> +       last_lblock = F2FS_BYTES_TO_BLK(i_size_read(inode));
>>
>>          while (cur_lblock < last_lblock && cur_lblock < sis->max) {
>>                  struct f2fs_map_blocks map;
>> @@ -4200,8 +4190,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>          pgoff_t next_pgofs = 0;
>>          int err;
>>
>> -       map.m_lblk = bytes_to_blks(inode, offset);
>> -       map.m_len = bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
>> +       map.m_lblk = F2FS_BYTES_TO_BLK(offset);
>> +       map.m_len = F2FS_BYTES_TO_BLK(offset + length - 1) - map.m_lblk + 1;
>>          map.m_next_pgofs = &next_pgofs;
>>          map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>                                                  inode->i_write_hint);
>> @@ -4212,7 +4202,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>          if (err)
>>                  return err;
>>
>> -       iomap->offset = blks_to_bytes(inode, map.m_lblk);
>> +       iomap->offset = F2FS_BLK_TO_BYTES(map.m_lblk);
>>
>>          /*
>>           * When inline encryption is enabled, sometimes I/O to an encrypted file
>> @@ -4232,21 +4222,21 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>                  if (WARN_ON_ONCE(map.m_pblk == NEW_ADDR))
>>                          return -EINVAL;
>>
>> -               iomap->length = blks_to_bytes(inode, map.m_len);
>> +               iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
>>                  iomap->type = IOMAP_MAPPED;
>>                  iomap->flags |= IOMAP_F_MERGED;
>>                  iomap->bdev = map.m_bdev;
>> -               iomap->addr = blks_to_bytes(inode, map.m_pblk);
>> +               iomap->addr = F2FS_BLK_TO_BYTES(map.m_pblk);
>>          } else {
>>                  if (flags & IOMAP_WRITE)
>>                          return -ENOTBLK;
>>
>>                  if (map.m_pblk == NULL_ADDR) {
>> -                       iomap->length = blks_to_bytes(inode, next_pgofs) -
>> -                                                               iomap->offset;
>> +                       iomap->length = F2FS_BLK_TO_BYTES(next_pgofs) -
>> +                                                       iomap->offset;
>>                          iomap->type = IOMAP_HOLE;
>>                  } else if (map.m_pblk == NEW_ADDR) {
>> -                       iomap->length = blks_to_bytes(inode, map.m_len);
>> +                       iomap->length = F2FS_BLK_TO_BYTES(map.m_len);
>>                          iomap->type = IOMAP_UNWRITTEN;
>>                  } else {
>>                          f2fs_bug_on(F2FS_I_SB(inode), 1);
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


