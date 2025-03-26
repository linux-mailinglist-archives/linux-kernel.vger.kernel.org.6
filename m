Return-Path: <linux-kernel+bounces-576624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74EA71202
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57A8188C593
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF019D884;
	Wed, 26 Mar 2025 08:04:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18411F94A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976291; cv=none; b=jWq7Z8jxD1AjUIN3oQeFmL6no7T+Pm/3B/SANI1VkyEGRSsqVCTPlxw3W7egq2bGaMXE0h6ZAWaeweF624wtz2kDgkRTGwue0ewvHVWcqf2Aje1x4NQoFbq6D/UpLZryaL0YmP459v/i1s8q0S/VmPm+8ZYTFlnwkLW2vZb4ETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976291; c=relaxed/simple;
	bh=MwQfeMm2+eCxQqPWJ6oAb1gzgIa1dnQGEuwzrDI2GRg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tfsgU43cZ6/7ygtgkqtZufjHQozED+iW/orndxsx/2XwRD3SVaaQUL/v64WiO9OM5CpcCXfiEiXitYKRJ5piwekKXZ1+qja13pPPAtQDKmE8uVxMnb1CTwN2WRl7vyQ9TLFZGjvMFTrvO2QNYS30wfLIGDww1W8NwBE7KjH8a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZMzmw1LQkztRLS;
	Wed, 26 Mar 2025 16:03:12 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id AB24D1401F4;
	Wed, 26 Mar 2025 16:04:38 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Mar 2025 16:04:37 +0800
Subject: Re: [RFC 1/1] fs/jffs2: Avoid a possible deadlock in
 jffs2_wbuf_recover
To: Wang Zhaolong <wangzhaolong1@huawei.com>, <dwmw2@infradead.org>,
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20250319024700.10364-1-wangzhaolong1@huawei.com>
 <20250319024700.10364-2-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6610d627-dfab-7b9b-c616-cccaf40ea948@huawei.com>
Date: Wed, 26 Mar 2025 16:04:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250319024700.10364-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/19 10:47, Wang Zhaolong Ð´µÀ:
> jffs2_wbuf_recover can deadlock when called from __jffs2_flush_wbuf
> error path, because both functions try to acquire c->wbuf_sem.
> 
>   jffs2_write_end
>     jffs2_write_inode_range
>       jffs2_write_dnode
>         jffs2_flash_writev
>           down_write(&c->wbuf_sem)            # first hold lock
>           __jffs2_flush_wbuf
>             mtd_write()                       # return error
>             jffs2_wbuf_recover
>               jffs2_reserve_space_gc
>                 jffs2_do_reserve_space
>                   jffs2_flush_wbuf_pad
>                     down_write(&c->wbuf_sem)  # AA deadlock
> 
> Fix this by adding a wbuf_sem_held parameter to jffs2_reserve_space_gc
> and jffs2_do_reserve_space, which can be used to indicate that the caller
> already holds c->wbuf_sem. If this is the case, jffs2_do_reserve_space
> will directly call __jffs2_flush_wbuf instead of going through
> jffs2_flush_wbuf_pad, which would try to acquire the lock again.
> 
> Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
> ---
>   fs/jffs2/gc.c       | 12 ++++++------
>   fs/jffs2/nodelist.h | 12 +++++++++++-
>   fs/jffs2/nodemgmt.c | 16 ++++++++++------
>   fs/jffs2/os-linux.h |  1 +
>   fs/jffs2/wbuf.c     | 13 ++-----------
>   fs/jffs2/write.c    |  4 ++--
>   fs/jffs2/xattr.c    |  4 ++--
>   7 files changed, 34 insertions(+), 28 deletions(-)
> 
[...]
> @@ -416,11 +416,15 @@ static int jffs2_do_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
>   
>   			if (jffs2_wbuf_dirty(c)) {
>   				spin_unlock(&c->erase_completion_lock);
>   				jffs2_dbg(1, "%s(): Flushing write buffer\n",
>   					  __func__);
> -				jffs2_flush_wbuf_pad(c);
> +				if (wbuf_sem_held) {
> +					__jffs2_flush_wbuf(c, PAD_NOACCOUNT);
> +				} else {
> +					jffs2_flush_wbuf_pad(c);
> +				}
Hi, Zhaolong
Perhaps the __jffs2_flush_wbuf is not equalivelent to the lockless 
version of jffs2_flush_wbuf_pad, for 2 reasons:
1. jffs2_flush_wbuf_pad will do nothing when CONFIG_JFFS2_FS_WRITEBUFFER 
is disabled.
2. jffs2_flush_wbuf_pad also checks 'c->wbuf', will it be ok to remove 
the check?

>   				spin_lock(&c->erase_completion_lock);
>   				jeb = c->nextblock;
>   				goto restart;
>   			}
>   
> diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
> index 86ab014a349c..c9dda7126850 100644
> --- a/fs/jffs2/os-linux.h
> +++ b/fs/jffs2/os-linux.h
> @@ -76,10 +76,11 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
>   #define jffs2_cleanmarker_oob(c) (0)
>   #define jffs2_write_nand_cleanmarker(c,jeb) (-EIO)
>   
>   #define jffs2_flash_write(c, ofs, len, retlen, buf) jffs2_flash_direct_write(c, ofs, len, retlen, buf)
>   #define jffs2_flash_read(c, ofs, len, retlen, buf) (mtd_read((c)->mtd, ofs, len, retlen, buf))
> +#define __jffs2_flush_wbuf(c, pad) ({ do{} while(0); (void)(c), 0; })
>   #define jffs2_flush_wbuf_pad(c) ({ do{} while(0); (void)(c), 0; })
>   #define jffs2_flush_wbuf_gc(c, i) ({ do{} while(0); (void)(c), (void) i, 0; })
>   #define jffs2_write_nand_badblock(c,jeb,bad_offset) (1)
>   #define jffs2_nand_flash_setup(c) (0)
>   #define jffs2_nand_flash_cleanup(c) do {} while(0)
> diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
> index 4061e0ba7010..799559760dc1 100644
> --- a/fs/jffs2/wbuf.c
> +++ b/fs/jffs2/wbuf.c
> @@ -384,11 +384,11 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
>   	}
>   	/* OK... we're to rewrite (end-start) bytes of data from first_raw onwards.
>   	   Either 'buf' contains the data, or we find it in the wbuf */
>   
>   	/* ... and get an allocation of space from a shiny new block instead */
> -	ret = jffs2_reserve_space_gc(c, end-start, &len, JFFS2_SUMMARY_NOSUM_SIZE);
> +	ret = jffs2_reserve_space_gc(c, end-start, &len, JFFS2_SUMMARY_NOSUM_SIZE, 1);
>   	if (ret) {
>   		pr_warn("Failed to allocate space for wbuf recovery. Data loss ensues.\n");
>   		kfree(buf);
>   		return;
>   	}
> @@ -566,20 +566,11 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
>   	jffs2_dbg(1, "wbuf recovery completed OK. wbuf_ofs 0x%08x, len 0x%x\n",
>   		  c->wbuf_ofs, c->wbuf_len);
>   
>   }
>   
> -/* Meaning of pad argument:
> -   0: Do not pad. Probably pointless - we only ever use this when we can't pad anyway.
> -   1: Pad, do not adjust nextblock free_size
> -   2: Pad, adjust nextblock free_size
> -*/
> -#define NOPAD		0
> -#define PAD_NOACCOUNT	1
> -#define PAD_ACCOUNTING	2
> -
> -static int __jffs2_flush_wbuf(struct jffs2_sb_info *c, int pad)
> +int __jffs2_flush_wbuf(struct jffs2_sb_info *c, int pad)
>   {
>   	struct jffs2_eraseblock *wbuf_jeb;
>   	int ret;
>   	size_t retlen;
>   
> diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
> index cda9a361368e..1764cf0466fc 100644
> --- a/fs/jffs2/write.c
> +++ b/fs/jffs2/write.c
> @@ -137,11 +137,11 @@ struct jffs2_full_dnode *jffs2_write_dnode(struct jffs2_sb_info *c, struct jffs2
>   			jffs2_dbg_acct_sanity_check(c,jeb);
>   			jffs2_dbg_acct_paranoia_check(c, jeb);
>   
>   			if (alloc_mode == ALLOC_GC) {
>   				ret = jffs2_reserve_space_gc(c, sizeof(*ri) + datalen, &dummy,
> -							     JFFS2_SUMMARY_INODE_SIZE);
> +							     JFFS2_SUMMARY_INODE_SIZE, 0);
>   			} else {
>   				/* Locking pain */
>   				mutex_unlock(&f->sem);
>   				jffs2_complete_reservation(c);
>   
> @@ -289,11 +289,11 @@ struct jffs2_full_dirent *jffs2_write_dirent(struct jffs2_sb_info *c, struct jff
>   			jffs2_dbg_acct_sanity_check(c,jeb);
>   			jffs2_dbg_acct_paranoia_check(c, jeb);
>   
>   			if (alloc_mode == ALLOC_GC) {
>   				ret = jffs2_reserve_space_gc(c, sizeof(*rd) + namelen, &dummy,
> -							     JFFS2_SUMMARY_DIRENT_SIZE(namelen));
> +							     JFFS2_SUMMARY_DIRENT_SIZE(namelen), 0);
>   			} else {
>   				/* Locking pain */
>   				mutex_unlock(&f->sem);
>   				jffs2_complete_reservation(c);
>   
> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
> index defb4162c3d5..b7b1eb8f012c 100644
> --- a/fs/jffs2/xattr.c
> +++ b/fs/jffs2/xattr.c
> @@ -1241,11 +1241,11 @@ int jffs2_garbage_collect_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xatt
>   		goto out;
>   	}
>   	old_ofs = ref_offset(xd->node);
>   	totlen = PAD(sizeof(struct jffs2_raw_xattr)
>   			+ xd->name_len + 1 + xd->value_len);
> -	rc = jffs2_reserve_space_gc(c, totlen, &length, JFFS2_SUMMARY_XATTR_SIZE);
> +	rc = jffs2_reserve_space_gc(c, totlen, &length, JFFS2_SUMMARY_XATTR_SIZE, 0);
>   	if (rc) {
>   		JFFS2_WARNING("jffs2_reserve_space_gc()=%d, request=%u\n", rc, totlen);
>   		goto out;
>   	}
>   	rc = save_xattr_datum(c, xd);
> @@ -1274,11 +1274,11 @@ int jffs2_garbage_collect_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_
>   		goto out;
>   
>   	old_ofs = ref_offset(ref->node);
>   	totlen = ref_totlen(c, c->gcblock, ref->node);
>   
> -	rc = jffs2_reserve_space_gc(c, totlen, &length, JFFS2_SUMMARY_XREF_SIZE);
> +	rc = jffs2_reserve_space_gc(c, totlen, &length, JFFS2_SUMMARY_XREF_SIZE, 0);
>   	if (rc) {
>   		JFFS2_WARNING("%s: jffs2_reserve_space_gc() = %d, request = %u\n",
>   			      __func__, rc, totlen);
>   		goto out;
>   	}
> 


