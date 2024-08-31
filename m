Return-Path: <linux-kernel+bounces-309666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446C4966EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED33F2835AD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B142AA1;
	Sat, 31 Aug 2024 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MnJPC1Vx"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357E19BB7
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725072855; cv=none; b=rTctUhh0vM+V8o9sAqmYAmgaGlkB8fR85wqUxoqVaH+ev9pVC+7msiLHwVcxcwdD4nTr8FO7inzLpV2o9sA0YRtsmeWHLYkyDlzJZZl5KSTkkHh+LvhUyrrMEufvHhvhbrRS9GugeYBqyoIU6PGcMB8xGjc5Pc2Dz40j92osQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725072855; c=relaxed/simple;
	bh=mE6OSz3I8kvOm99ejJ5TT96XrPNlPp5/JiIQKiXkvRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIzZCrvejNZwcLV8X9/bR5CPS9tVqqnYvJs6Hyw/lAwR7WWDuMhMNzxhHRQIJBno/1nXm6vwzsTA7t6Dy8QLfR+y/HsTqfOQSvePX72g8EZps60XpHG/M7nETJqiIhVQCAAyjQlGOElpwHEHmBSys9CUhcBj1VZmA/GF1ddt7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MnJPC1Vx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725072843; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zZJJrwNuQqZJmQm0d3gc2XhF2BtCX1ZJsTSpftN+ZuM=;
	b=MnJPC1VxH2AXo6WRgMEoMCpQuUfpNiAsmWl/jNybNT8GCtyuvLX7iQMEhMSRSkLLhHe+jOcPhkj+rGOHUWNLyabJuekaBdT3cB3InDKeRPnHyn7YjtFqlyDZzq11hDl+656/Pbr3fwBuxGdVfbmixJ1swrRxebFXJibqWVkUqUY=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyK-lV_1725072842)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 10:54:03 +0800
Message-ID: <474573b0-14d3-4534-82ad-8b4942567008@linux.alibaba.com>
Date: Sat, 31 Aug 2024 10:54:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
 <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/31 08:19, Sandeep Dhavale wrote:
> On Thu, Aug 29, 2024 at 8:29 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Since EROFS only needs to handle read requests in simple contexts,
>> Just directly use vfs_iocb_iter_read() for data I/Os.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v2:
>>   - fix redundant refcount which cause hanging on chunked inodes.
>>
>>   fs/erofs/Makefile   |   1 +
>>   fs/erofs/data.c     |  50 +++++++++++-
>>   fs/erofs/fileio.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/inode.c    |  17 +++--
>>   fs/erofs/internal.h |   7 +-
>>   fs/erofs/zdata.c    |  46 ++---------
>>   6 files changed, 251 insertions(+), 51 deletions(-)
>>   create mode 100644 fs/erofs/fileio.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 097d672e6b14..4331d53c7109 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>> +erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 0fb31c588ae0..b4c07ce7a294 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>>          if (map->m_la >= inode->i_size) {
>>                  /* leave out-of-bound access unmapped */
>>                  map->m_flags = 0;
>> -               map->m_plen = 0;
>> +               map->m_plen = map->m_llen;
>>                  goto out;
>>          }
>>
>> @@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
>>                                      struct erofs_device_info *dif)
>>   {
>>          map->m_bdev = NULL;
>> -       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
>> -               map->m_bdev = file_bdev(dif->file);
>> +       map->m_fp = NULL;
>> +       if (dif->file) {
>> +               if (S_ISBLK(file_inode(dif->file)->i_mode))
>> +                       map->m_bdev = file_bdev(dif->file);
>> +               else
>> +                       map->m_fp = dif->file;
>> +       }
>>          map->m_daxdev = dif->dax_dev;
>>          map->m_dax_part_off = dif->dax_part_off;
>>          map->m_fscache = dif->fscache;
>> @@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>          map->m_daxdev = EROFS_SB(sb)->dax_dev;
>>          map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
>>          map->m_fscache = EROFS_SB(sb)->s_fscache;
>> +       map->m_fp = EROFS_SB(sb)->fdev;
>>
>>          if (map->m_deviceid) {
>>                  down_read(&devs->rwsem);
>> @@ -250,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>>          return 0;
>>   }
>>
>> +/*
>> + * bit 30: I/O error occurred on this folio
>> + * bit 0 - 29: remaining parts to complete this folio
>> + */
>> +#define EROFS_ONLINEFOLIO_EIO                  (1 << 30)
>> +
>> +void erofs_onlinefolio_init(struct folio *folio)
>> +{
>> +       union {
>> +               atomic_t o;
>> +               void *v;
>> +       } u = { .o = ATOMIC_INIT(1) };
>> +
>> +       folio->private = u.v;   /* valid only if file-backed folio is locked */
>> +}
>> +
>> +void erofs_onlinefolio_split(struct folio *folio)
>> +{
>> +       atomic_inc((atomic_t *)&folio->private);
>> +}
>> +
>> +void erofs_onlinefolio_end(struct folio *folio, int err)
>> +{
>> +       int orig, v;
>> +
>> +       do {
>> +               orig = atomic_read((atomic_t *)&folio->private);
>> +               v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
>> +       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
>> +
>> +       if (v & ~EROFS_ONLINEFOLIO_EIO)
>> +               return;
>> +       folio->private = 0;
>> +       folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
>> +}
>> +
>>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>                  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>>   {
>> @@ -399,7 +441,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   }
>>
>>   /* for uncompressed (aligned) files and raw access for other files */
>> -const struct address_space_operations erofs_raw_access_aops = {
>> +const struct address_space_operations erofs_aops = {
>>          .read_folio = erofs_read_folio,
>>          .readahead = erofs_readahead,
>>          .bmap = erofs_bmap,
>> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
>> new file mode 100644
>> index 000000000000..eab52b8abd0b
>> --- /dev/null
>> +++ b/fs/erofs/fileio.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include "internal.h"
>> +#include <trace/events/erofs.h>
>> +
>> +struct erofs_fileio_rq {
>> +       struct bio_vec bvecs[BIO_MAX_VECS];
>> +       struct bio bio;
>> +       struct kiocb iocb;
>> +};
>> +
>> +struct erofs_fileio {
>> +       struct erofs_map_blocks map;
>> +       struct erofs_map_dev dev;
>> +       struct erofs_fileio_rq *rq;
>> +};
>> +
>> +static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
>> +{
>> +       struct erofs_fileio_rq *rq =
>> +                       container_of(iocb, struct erofs_fileio_rq, iocb);
>> +       struct folio_iter fi;
>> +
>> +       DBG_BUGON(rq->bio.bi_end_io);
>> +       if (ret > 0) {
>> +               if (ret != rq->bio.bi_iter.bi_size) {
>> +                       bio_advance(&rq->bio, ret);
>> +                       zero_fill_bio(&rq->bio);
>> +               }
>> +               ret = 0;
>> +       }
>> +       bio_for_each_folio_all(fi, &rq->bio) {
>> +               DBG_BUGON(folio_test_uptodate(fi.folio));
>> +               erofs_onlinefolio_end(fi.folio, ret);
>> +       }
>> +       kfree(rq);
>> +}
>> +
>> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>> +{
>> +       struct iov_iter iter;
>> +       int ret;
>> +
>> +       if (!rq)
>> +               return;
>> +       rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
>> +       rq->iocb.ki_ioprio = get_current_ioprio();
>> +       rq->iocb.ki_complete = erofs_fileio_ki_complete;
>> +       rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
>> +                               IOCB_DIRECT : 0;
> Hi Gao,
> Does this mean, direct IO by default if the backing file supports it
> (technically filesystem where image/backing file reside)?

Yes.

Thanks,
Gao Xiang

