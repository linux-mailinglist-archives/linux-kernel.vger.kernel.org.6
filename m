Return-Path: <linux-kernel+bounces-287852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79458952D39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0861F22B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F61AC8AE;
	Thu, 15 Aug 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZxMTcS9P"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C721AC89A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720213; cv=none; b=j7CMFgW/+0q8nj6BMLGjL8CwIO0Gao3pFAUtpZ70juiWufZ95PCTmNAFiMdJcJhqrWDANpkIUw3uywBj7hJIgK2Z2rzkxaZEGQYkkWlE0kIbxVpAceo521+nHq/QSnbgkOvpLsFVZMnVwbkU8LjMKiVZD4oglTmhS4+Gc9gxupE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720213; c=relaxed/simple;
	bh=+BVtBNOwoy/psWLQrFqbruNaaaHrGQ2ydW9EtrDk2gw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lH6XL1pYOYoZPHr6VhC2glLZt+UjKQ5054TbLsGuUKL3UIPjEP2JfWwFi8fdEipF/WT2DFuEdSlK9JPER35HpVCcWmrxDqffZ26hLDVzPK4bnHGv1HzYrJp0l8IYsG14gIxuIXidScySbGNeHZMLnk3/FzyMTygUY/z5cPOlB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZxMTcS9P; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240815111001epoutp01bcb28b2054010f1165fdd798cb0d80e8~r4mQHnGaM2310423104epoutp014
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:10:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240815111001epoutp01bcb28b2054010f1165fdd798cb0d80e8~r4mQHnGaM2310423104epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723720201;
	bh=mrWBCO+0MwfF0eL0rZJQIFUJz6VpYKcoQezU8j26Di4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZxMTcS9PAzRoVLyS01eCuYseyMTmQ5zw2BCFwR2/0xUo1xrL80k+aVDd32S3YCBYr
	 X5525BlUJvwp4VUfCgVu/0eZoVQAct+tKPbXX2wnqrzRJBhMdh9iFEl96KzTnIVQSa
	 9kHOmT+zldW813K9O0UdYAOqypOVaMtGugT53ACE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240815111001epcas1p461480f53e0e035d33a909ea84e6068c6~r4mPqGSqO2852428524epcas1p4Y;
	Thu, 15 Aug 2024 11:10:01 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.249]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wl2TP0P6Fz4x9Pq; Thu, 15 Aug
	2024 11:10:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.85.08992.802EDB66; Thu, 15 Aug 2024 20:10:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240815111000epcas1p481c62b09e67c00e1da13b03d0e2609de~r4mPAn0fy2535125351epcas1p4x;
	Thu, 15 Aug 2024 11:10:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240815111000epsmtrp15f82c19d8e33276db48e339dd388c198~r4mPAAZGK1040610406epsmtrp1_;
	Thu, 15 Aug 2024 11:10:00 +0000 (GMT)
X-AuditID: b6c32a33-70bff70000002320-3c-66bde208bbc7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.AB.08456.802EDB66; Thu, 15 Aug 2024 20:10:00 +0900 (KST)
Received: from youngjingil02 (unknown [10.253.98.199]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240815111000epsmtip17f1b953dcec368a9f6076ee6f1521e15~r4mOqsORp2775727757epsmtip1z;
	Thu, 15 Aug 2024 11:10:00 +0000 (GMT)
From: "Yeongjin Gil" <youngjin.gil@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, "'Sungjong Seo'" <sj1557.seo@samsung.com>,
	"'Sunmin Jeong'" <s_min.jeong@samsung.com>, "'Jaewook Kim'"
	<jw5454.kim@samsung.com>
In-Reply-To: <8dbdca2c-0ef9-4e93-87ca-db275675017f@kernel.org>
Subject: RE: [PATCH] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
Date: Thu, 15 Aug 2024 20:10:00 +0900
Message-ID: <284301daef03$ab834c60$0289e520$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQHE+ENkweQ1utuRK/iDlseKlptTTAITvPaRAw5kY9KyKwU7UA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmvi7Ho71pBhvWG1mcnnqWyeLJ+lnM
	Fiuv/GaxuLTI3eLyrjlsFgtagbwt/46wOrB7bFrVyeaxe8FnJo++LasYPT5vkgtgiWpgtEks
	Ss7ILEtVSM1Lzk/JzEu3VQoNcdO1UFLIyC8usVWKNjQ00jM0MNczMjLSMzWKtTIyVVLIS8xN
	tVWq0IXqVVIoSi4Aqs2tLAYakJOqBxXXK07NS3HIyi8FuVqvODG3uDQvXS85P1dJoSwxpxRo
	hJJ+wjfGjKabPgV/3SvWnFjJ2MDYYdXFyMkhIWAisbntAxOILSSwg1Fi6nu2LkYuIPsTo8S3
	xZtZIZxvjBJbT85g72LkAOu4tcwHIr6XUeL6jfnMEN2vGSV+NAiC2GwC+hK/jp1jAbFFBMwl
	9ix+BTaVWeAyo8STZz/AGjgF7CTO7u5gA7GFBSIk5m76CnYGi4CqxKunrWBxXgFLidPXtrBD
	2IISJ2c+ARvKLCAvsf3tHGaIFxQkdn86ygoRF5GY3dnGDLHYSeLmzA4WkMUSAr0cEm9+nWWH
	aHCRuDJvHxuELSzx6vgWqLiUxMv+NnaIhlWMEm9aPzFBONsZJaY/7oHqsJdobm1mA4UFs4Cm
	xPpd+hCb+STefe1hhSgRBLq6mxkSXLwSHW1CEGE1iSuTfkGVyEj0PZjFPoFRaRaS32Yh+W0W
	kn9mISxbwMiyilEstaA4Nz012bDAEDm+NzGCk6yW8Q7Gy/P/6R1iZOJgPMQowcGsJMIbaLIr
	TYg3JbGyKrUoP76oNCe1+BBjMjC0JzJLiSbnA9N8Xkm8oZmZpYWlkYmhsZmhIWFhE0sDEzMj
	EwtjS2MzJXHeM1fKUoUE0hNLUrNTUwtSi2C2MHFwSjUwSfT/Xfqu4yLLxxQRkSb3FUtv7LD9
	8v5TnPPXTeuUZppFPLi9d0vuHo+SpVZXkqNUHgQ2ubh9nVkfcfhXnmjXrskBelcvl2rbOIT6
	N01X6T2043Lq4iaPp/92T1cvNvNSY+4NfpfiFBvN9oR7kfmKYv29Wy3PC5y3viNXtWV1CtuK
	J7Li7UvmGaobL6z99m3+jadB587aBj7eriXjf8H682TVzMlOahdOBuz7JLVl+UyfidnJi2R2
	y5zVefZAuX/e4vsWN1UFi1YbinGahv2Y3FuVciPp6pqKUydiFtxdn5/9a9H0i3w+bXlyen1J
	E08+fRQ//TBXum3KK0vOVJUGwaCYZ9t36K+a/kY4+EHnQSWW4oxEQy3mouJEAJ7GbvFpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnC7Ho71pBjf+81mcnnqWyeLJ+lnM
	Fiuv/GaxuLTI3eLyrjlsFgtagbwt/46wOrB7bFrVyeaxe8FnJo++LasYPT5vkgtgieKySUnN
	ySxLLdK3S+DKaLrpU/DXvWLNiZWMDYwdVl2MHBwSAiYSt5b5dDFycQgJ7GaUWLhwAXsXIydQ
	XEbiz8T3bBA1whKHDxdD1LxklNh99DwLSA2bgL7Er2PnwGwRAUuJBbNAbC4OZoGrjBIbGl8z
	QXQcYJT4OPc2G0gVp4CdxNndHWC2sECYxL2+2UwgNouAqsSrp61gcV6gSaevbWGHsAUlTs58
	AraBWUBbovdhKyOELS+x/e0cZohLFSR2fzrKChEXkZjd2cYMcZGTxM2ZHSwTGIVnIRk1C8mo
	WUhGzULSvoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAEaWntYNyz6oPeIUYm
	DsZDjBIczEoivIEmu9KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoE
	k2Xi4JRqYKreqvg4de8yiecJaycKta0I01+hff5MMd9PzfBs/sNnJ6W/ijaLlS76tG3+HDeG
	Zf2n6j7V1F9qOfhhxadr0seEzRY7PN0xJyyl6LsQX4CF4do32REXF7t1PpmYr7/c7f72XR8C
	38cvfawp+Tp37S6p9P9lWw3svu45V7w2cFlai7Bz5b81D9zWHl/qs3/rrUt9Kee/fVwgcNhl
	qazczPj/9QdulDzdxpYlmM9Zvap0LkPMkecLW14ZF1cHv5785kNL2cP+bMU/P+IqG05O2ZO6
	34tls8SNUJnLHPO0MifvYpi2jcFX9KLw93uMCx4J9L6Y9feT8yG176teKZ1b/YfNI+559n2v
	qV/ltohdu7QoUYmlOCPRUIu5qDgRAIvGMFQPAwAA
X-CMS-MailID: 20240815111000epcas1p481c62b09e67c00e1da13b03d0e2609de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff
References: <CGME20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff@epcas1p4.samsung.com>
	<20240813061104.1052-1-youngjin.gil@samsung.com>
	<8dbdca2c-0ef9-4e93-87ca-db275675017f@kernel.org>

Thanks for your review. I will send patch v2.

>On 2024/8/13 14:11, Yeongjin Gil wrote:
>> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
>> writepage considering that it has been already truncated.
>> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is
>> not cleared during the writeback process for a compressed file
>> including NULL_ADDR in compress_mode=user.
>>
>> This is the reproduction process:
>>
>> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile 2. f2fs_io
>> compress testfile 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc
>> of=testfile 4. f2fs_io decompress testfile
>
>Good catch!
>
>>
>> To prevent the problem, let's check whether the cluster is fully
>> allocated before redirty its pages.
>>
>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
>> Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
>> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
>
>Need a fixes line?
>
>> ---
>>   fs/f2fs/compress.c | 34 ++++++++++++++++++++++++++--------
>>   fs/f2fs/f2fs.h     | 12 ++++++++++++
>>   fs/f2fs/file.c     | 39 +++++++++++++++++++++------------------
>>   3 files changed, 59 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c index
>> 990b93689b46..09b91d725807 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -945,7 +945,7 @@ static int __f2fs_get_cluster_blocks(struct inode
>*inode,
>>   	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
>>   	int count, i;
>>
>> -	for (i = 1, count = 1; i < cluster_size; i++) {
>> +	for (i = 0, count = 0; i < cluster_size; i++) {
>>   		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
>>   							dn->ofs_in_node + i);
>>
>> @@ -956,8 +956,8 @@ static int __f2fs_get_cluster_blocks(struct inode
>*inode,
>>   	return count;
>>   }
>>
>> -static int __f2fs_cluster_blocks(struct inode *inode,
>> -				unsigned int cluster_idx, bool compr_blks)
>> +static int __f2fs_cluster_blocks(struct inode *inode, unsigned int
>cluster_idx,
>> +				enum cluster_check_type type)
>>   {
>>   	struct dnode_of_data dn;
>>   	unsigned int start_idx = cluster_idx << @@ -978,10 +978,12 @@
>> static int __f2fs_cluster_blocks(struct inode *inode,
>>   	}
>>
>>   	if (dn.data_blkaddr == COMPRESS_ADDR) {
>> -		if (compr_blks)
>> -			ret = __f2fs_get_cluster_blocks(inode, &dn);
>> -		else
>> +		if (type == COMPR_BLKS)
>> +			ret = 1 + __f2fs_get_cluster_blocks(inode, &dn);
>> +		else if (type == COMPR_CLUSTER)
>>   			ret = 1;
>> +	} else if (type == DECOMPR_BLKS) {
>> +		ret = __f2fs_get_cluster_blocks(inode, &dn);
>>   	}
>>   fail:
>>   	f2fs_put_dnode(&dn);
>> @@ -991,7 +993,14 @@ static int __f2fs_cluster_blocks(struct inode *inode,
>>   /* return # of compressed blocks in compressed cluster */
>>   static int f2fs_compressed_blocks(struct compress_ctx *cc)
>>   {
>> -	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
>> +	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx,
>> +COMPR_BLKS); }
>> +
>> +/* return # of raw blocks in non-compressed cluster */ static int
>> +f2fs_decompressed_blocks(struct inode *inode,
>> +				unsigned int cluster_idx)
>> +{
>> +	return __f2fs_cluster_blocks(inode, cluster_idx, DECOMPR_BLKS);
>>   }
>>
>>   /* return whether cluster is compressed one or not */ @@ -999,7
>> +1008,16 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t
>index)
>>   {
>>   	return __f2fs_cluster_blocks(inode,
>>   		index >> F2FS_I(inode)->i_log_cluster_size,
>> -		false);
>> +		COMPR_CLUSTER);
>> +}
>> +
>> +/* return whether the cluster is filled with raw blocks */ bool
>> +f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index)
>
>f2fs_is_sparse_cluster()?
>
>> +{
>> +	unsigned int cluster_idx = index >>
>> +F2FS_I(inode)->i_log_cluster_size;
>> +
>> +	return f2fs_decompressed_blocks(inode, cluster_idx) ==
>> +		F2FS_I(inode)->i_cluster_size;
>>   }
>>
>>   static bool cluster_may_compress(struct compress_ctx *cc) diff --git
>> a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index 51fd5063a69c..6f26c8cb8857
>> 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4302,6 +4302,11 @@ static inline bool
>f2fs_meta_inode_gc_required(struct inode *inode)
>>    * compress.c
>>    */
>>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>> +enum cluster_check_type {
>> +	COMPR_CLUSTER,
>> +	COMPR_BLKS,
>> +	DECOMPR_BLKS
>
>How about?
>
>CLUSTER_IS_COMPR,
>CLUSTER_COMPR_BLKS,
>CLUSTER_RAW_BLKS
>
>> +};
>
>Can you please add some comments for these enums?
>
>>   bool f2fs_is_compressed_page(struct page *page);
>>   struct page *f2fs_compress_control_page(struct page *page);
>>   int f2fs_prepare_compress_overwrite(struct inode *inode, @@ -4328,6
>> +4333,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>>   						struct writeback_control *wbc,
>>   						enum iostat_type io_type);
>>   int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
>> +bool f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index);
>>   void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>>   				pgoff_t fofs, block_t blkaddr,
>>   				unsigned int llen, unsigned int c_len); @@ -
>4414,6 +4420,12 @@
>> static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
>>   static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info
>*sbi,
>>   							nid_t ino) { }
>>   #define inc_compr_inode_stat(inode)		do { } while (0)
>> +static inline int f2fs_is_compressed_cluster(
>> +				struct inode *inode,
>> +				pgoff_t index) { return 0; }
>> +static inline bool f2fs_is_non_sparse_cluster(
>> +				struct inode *inode,
>> +				pgoff_t index) { return false; }
>>   static inline void f2fs_update_read_extent_tree_range_compressed(
>>   				struct inode *inode,
>>   				pgoff_t fofs, block_t blkaddr,
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
>> 270c32e3385f..fba8b5f216f9 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4220,9 +4220,8 @@ static int f2fs_ioc_decompress_file(struct file
>*filp)
>>   	struct inode *inode = file_inode(filp);
>>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>> -	pgoff_t page_idx = 0, last_idx;
>> -	int cluster_size = fi->i_cluster_size;
>> -	int count, ret;
>> +	pgoff_t page_idx = 0, last_idx, cluster_idx;
>> +	int ret;
>>
>>   	if (!f2fs_sb_has_compression(sbi) ||
>>   			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER) @@ -
>4257,10
>> +4256,15 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>>   		goto out;
>>
>>   	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>> +	last_idx >>= fi->i_log_cluster_size;
>> +
>> +	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
>> +		page_idx = cluster_idx << fi->i_log_cluster_size;
>> +
>> +		if (!f2fs_is_compressed_cluster(inode, page_idx))
>> +			continue;
>>
>> -	count = last_idx - page_idx;
>> -	while (count && count >= cluster_size) {
>> -		ret = redirty_blocks(inode, page_idx, cluster_size);
>> +		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
>>   		if (ret < 0)
>>   			break;
>>
>> @@ -4270,9 +4274,6 @@ static int f2fs_ioc_decompress_file(struct file
>*filp)
>>   				break;
>>   		}
>>
>> -		count -= cluster_size;
>> -		page_idx += cluster_size;
>> -
>>   		cond_resched();
>>   		if (fatal_signal_pending(current)) {
>>   			ret = -EINTR;
>> @@ -4299,9 +4300,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
>>   {
>>   	struct inode *inode = file_inode(filp);
>>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	pgoff_t page_idx = 0, last_idx;
>> -	int cluster_size = F2FS_I(inode)->i_cluster_size;
>> -	int count, ret;
>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>> +	pgoff_t page_idx = 0, last_idx, cluster_idx;
>> +	int ret;
>>
>>   	if (!f2fs_sb_has_compression(sbi) ||
>>   			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER) @@ -
>4335,10
>> +4336,15 @@ static int f2fs_ioc_compress_file(struct file *filp)
>>   	set_inode_flag(inode, FI_ENABLE_COMPRESS);
>>
>>   	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>> +	last_idx >>= fi->i_log_cluster_size;
>>
>> -	count = last_idx - page_idx;
>> -	while (count && count >= cluster_size) {
>> -		ret = redirty_blocks(inode, page_idx, cluster_size);
>> +	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
>> +		page_idx = cluster_idx << fi->i_log_cluster_size;
>> +
>> +		if (!f2fs_is_non_sparse_cluster(inode, page_idx))
>
>if (f2fs_is_sparse_cluster())
>	continue;
>
>Thanks,
>
>> +			continue;
>> +
>> +		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
>>   		if (ret < 0)
>>   			break;
>>
>> @@ -4348,9 +4354,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
>>   				break;
>>   		}
>>
>> -		count -= cluster_size;
>> -		page_idx += cluster_size;
>> -
>>   		cond_resched();
>>   		if (fatal_signal_pending(current)) {
>>   			ret = -EINTR;



