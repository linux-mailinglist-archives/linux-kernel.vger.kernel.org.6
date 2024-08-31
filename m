Return-Path: <linux-kernel+bounces-309767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5A967037
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01CB1C21609
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3F16F271;
	Sat, 31 Aug 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nBgR0b/z"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1E14A4F1
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090872; cv=none; b=s6r3BB0GLVMtZP0zutNtXHw04LYvwNM2A5Ttv+71qKyfsk4Un92TNQCrdExawgzYj8jJhmIJU9mqAoGSiydt9QZ+sJDnSYHWGHuIVkAokGsx0K+W75eY8g9JA7Ak7NvzCGdosRpEVxEycT2DJoc6xtC6abcRPKxEaoy9CGfdy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090872; c=relaxed/simple;
	bh=DZ8S1Aee/N4vUBnqNXEi7vz/WyG0qQ6eChEBRuS1t3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pylyijut/PxUvZmkPsnm8F2GtpPLOkiHzkr6ayMBDZ3xOtSJoH68czmFZjzggCzxUe94FpyF7GR6+gCggjBfQAoVHBPQkDEaXLLJf+w0sVRQJdoI+zDD6jY3tEsvCC/IdQtKvJU+nbAUzCqIDNgOIUEooWKquiG7DkNxwN82F64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nBgR0b/z; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725090860; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IVHD1JoOPLTNC1z7HLWfx5FZbwBkOQQXHvKOSp/vnz0=;
	b=nBgR0b/zI1bXOf0xBtW0/Ajpi40cf5SDm0EmigQlgz51dPl9Yx7GGAyv0cGmMJH4E86EAVnKwsXT/kMF/aI9XIDtSNRZqZO4ja/ptKtg6vuZnFY05oOt6rcIapZJhpp+AiaH4W/dEsl6EeZXJvH21q8hi1Vscg3W7QeuNTFoaaE=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDyp2-a_1725090859)
          by smtp.aliyun-inc.com;
          Sat, 31 Aug 2024 15:54:20 +0800
Message-ID: <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
Date: Sat, 31 Aug 2024 15:54:19 +0800
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
 <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/31 12:25, Sandeep Dhavale wrote:
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
> Hi Gao,
> Is this change intentional? At out label, we set this again as err is 0.

Yes, that is intentional, we will return the post-EOF extent as
m_plen == map->m_llen == passed in m_llen and an unmapped extent

so that the logic can be simplified and it's still compatible.

Thanks,
Gao Xiang

