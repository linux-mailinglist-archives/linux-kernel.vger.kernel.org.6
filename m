Return-Path: <linux-kernel+bounces-253268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5406931ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65D11C21DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B80C8E1;
	Tue, 16 Jul 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JVxlcvEb"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B1BA2F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097024; cv=none; b=o2NJUi9UI0zL53pHI4Mh5dE5uawdVeBs2FEB8wxWFn6YnX7sOrhdVO3IdPW1CK56zb+fv3ojmH9L7B+yocK5ueZYHNIeRM8TIu1s5E/SQr5gsp345sbaSKN540qg36E+0+YaoF9hGR8VAtqdaM4sjhP9D4TRU19cMn+PFiUVQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097024; c=relaxed/simple;
	bh=OaKr5qjBbES4n64xuyucq8RJlf8kjXRqafQUhE1ri2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K12uwrFc6eiFeJd2krbeWRDMHf18Bb7l9mmpOa+gDSlXae5+lV7JSRg5E6uiI/iEltPw7mcWSFG5fxQ1tuEjTw1MTCAHLs9Cw2fUFTHY/HeOgebT/KY0FbQtq9RCyzROiytDwUs5pUC4r/7VvLRgEGDbaVCAwJOcJTgoUWZH6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JVxlcvEb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: youling.tang@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721097020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGTN2sCQn73K01w4hUdt3Y9IcXyDXjcOsX2Dq1gljaI=;
	b=JVxlcvEbAjKLI+7wNQ2Iye/d9GDTLefows3iJrtxddoUdbOvUW0U57cXeYq4NGO4ZNKoNz
	kee5u+IGSjtI+zBB2xrZOoNMCEM4FkTAqhA6vScdM23u0DILiWZqlgWnr43alxvM22hPOc
	LNakSEeHa+PRPt8YTvxh9En8EP022Bk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Envelope-To: zhengqi.arch@bytedance.com
Date: Mon, 15 Jul 2024 22:30:17 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] mm: list_lru: Fix NULL pointer dereference in
 list_lru_add()
Message-ID: <io2g62bk243qo4jzjrkqr5gko5fykrji2xmqeahxnhma53giaz@3li2ozvsbjim>
References: <20240712032554.444823-1-youling.tang@linux.dev>
 <sd32qchit33aafht27utinrz5dizw62qbtwdmwbtugqrlglmtx@6aitsotgqnpi>
 <8ce42a2e-783f-4244-8e75-21dcd578adf5@linux.dev>
 <oxzh24oit3ulkl5at66c4g3bsyo7z6jd54757yrkgqbeftfgjz@qlzktn3nrkpl>
 <7db60e36-9c96-4938-a28d-a9745e287386@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7db60e36-9c96-4938-a28d-a9745e287386@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 16, 2024 at 10:28:33AM GMT, Youling Tang wrote:
> Hi, Kent
> 
> On 12/07/2024 23:49, Kent Overstreet wrote:
> > On Fri, Jul 12, 2024 at 12:28:57PM GMT, Youling Tang wrote:
> > > Hi, Kent
> > > 
> > > On 12/07/2024 12:07, Kent Overstreet wrote:
> > > > On Fri, Jul 12, 2024 at 11:25:54AM GMT, Youling Tang wrote:
> > > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > > 
> > > > > Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
> > > > > to error handle the return value to avoid triggering NULL pointer
> > > > > dereference BUG.
> > > > > 
> > > > > The issue was triggered for discussion [1],
> > > > > Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6
> > > > I see no explanation for why this is the correct fix, and I doubt it is.
> > > > What's the real reason for the NULL lru_list_one, and why doesn't this
> > > > come up on other filesystems?
> > > We can break it down into two questions (independent of each other):
> > > 1) Error handling is necessary when l (lru_list_one) is NULL here.
> > No, you're just hiding the actual bug - since I wasn't clear, I'm naking
> > this patch.
> We should use kmem_cache_alloc_lru() instead of kmem_cache_alloc(),
> similar to the [1] modification.
> 
> Apply the following patch to fix the problem:

Thanks, send it as a proper patch and I'll apply it

> 
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index f9c9a95d7d4c..79a580dfb5e1 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -227,7 +227,8 @@ static struct inode *bch2_alloc_inode(struct super_block
> *sb)
> 
>  static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
>  {
> -       struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache,
> GFP_NOFS);
> +       struct bch_inode_info *inode = alloc_inode_sb(c->vfs_sb,
> bch2_inode_cache, GFP_NOFS);
>         if (!inode)
>                 return NULL;
> 
> Link [1]: https://lwn.net/ml/linux-kernel/20220228122126.37293-5-songmuchun@bytedance.com/
> 
> Thanks,
> Youling.

