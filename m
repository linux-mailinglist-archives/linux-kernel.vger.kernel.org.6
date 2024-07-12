Return-Path: <linux-kernel+bounces-250779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC692FCB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B6DB22AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894D172780;
	Fri, 12 Jul 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="H+YYV5Eg"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD8171E66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795090; cv=none; b=YhMxNd4iMhKZPENfnXD49+F0cwQmyR67Y04J56iE9Zb4QH6cdas/YZi7NkSZuoGtW6qY0pZkXFnOVmUBGle/2m3IS61qFJTnrpRQQrmAZQSI/A6A7JrVSvZvho80warrOyrqBJNg0YqopB4/st8GFfU0/8YXrJZavk9v2tvHZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795090; c=relaxed/simple;
	bh=ZvVdjYiodZ2Qxhwg00uPMb5f0YRCM0lxCpNFN0p8HxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvsB4lwBv9cann64gwDV2+2QGeqTTlrrNOoBDztbYlQwWIOsgBnUUf3RX6PnFSr7BtC1AJsaG4v9xivlqGUIsrVoiOYG7t3j9vLsvL8YHgoG+LwXQEdPTxA4i8eeK4MwGnzjFpraNZHu3nu+tVANGPjwEO9xvJNbRx3OoQAp3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=H+YYV5Eg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46CEb8Pq026641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720795032; bh=1Gn6aaaJtlJEaxDX5RF5pO/WPW2zmse3sX2wC3biWbQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=H+YYV5EgAW5YM8jOjPb5/kXfHSNhicmHQvMULSGWZvaL5Jrop5oNBR7HRvskjJZ5u
	 4JFfxYEjjwFeoKEaGdxxpLXj8WvHtpLcqXEuTYGOaJeocdS6VXclSwn8l4XwAFEfeN
	 pTO3ioXk3hG552FmpcbcHaflew3b4fgYCj/Xiuc98EQqM0Q4r5C5MzMjMHxVVer0TE
	 dgXs8jPrHEDiiWDHfIFOrDPHtTS8h95cNU3YkJDgHKvXR+gQ8z3R00yVQhctBzyinJ
	 RKTs684wIDVGAGwbS+y2+nc4jdvkFxRW/bKSItJrLUPfwBUpW9M21AqoStEwRRNVPa
	 G9z+tHBGyuJbQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9F99D15C27B4; Fri, 12 Jul 2024 10:37:08 -0400 (EDT)
Date: Fri, 12 Jul 2024 10:37:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "wangzhaolong (A)" <wangzhaolong1@huawei.com>
Subject: Re: [BUG REPORT] potential deadlock in inode evicting under the
 inode lru traversing context on ext4 and ubifs
Message-ID: <20240712143708.GA151742@mit.edu>
References: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c29c42-7685-d1f0-067d-63582ffac405@huaweicloud.com>

On Fri, Jul 12, 2024 at 02:27:20PM +0800, Zhihao Cheng wrote:
> Problem description
> ===================
> 
> The inode reclaiming process(See function prune_icache_sb) collects all
> reclaimable inodes and mark them with I_FREEING flag at first, at that
> time, other processes will be stuck if they try getting these inodes(See
> function find_inode_fast), then the reclaiming process destroy the
> inodes by function dispose_list().
> Some filesystems(eg. ext4 with ea_inode feature, ubifs with xattr) may
> do inode lookup in the inode evicting callback function, if the inode
> lookup is operated under the inode lru traversing context, deadlock
> problems may happen.
> 
> Case 1: In function ext4_evict_inode(), the ea inode lookup could happen
> if ea_inode feature is enabled, the lookup process will be stuck under
> the evicting context like this:
> 
>  1. File A has inode i_reg and an ea inode i_ea
>  2. getfattr(A, xattr_buf) // i_ea is added into lru // lru->i_ea
>  3. Then, following three processes running like this:
> 
>     PA                              PB
>  echo 2 > /proc/sys/vm/drop_caches
>   shrink_slab
>    prune_dcache_sb
>    // i_reg is added into lru, lru->i_ea->i_reg
>    prune_icache_sb
>     list_lru_walk_one
>      inode_lru_isolate
>       i_ea->i_state |= I_FREEING // set inode state
>       i_ea->i_state |= I_FREEING // set inode state

Um, I don't see how this can happen.  If the ea_inode is in use,
i_count will be greater than zero, and hence the inode will never be
go down the rest of the path in inode_lru_inode():

	if (atomic_read(&inode->i_count) ||
	    ...) {
		list_lru_isolate(lru, &inode->i_lru);
		spin_unlock(&inode->i_lock);
		this_cpu_dec(nr_unused);
		return LRU_REMOVED;
	}

Do you have an actual reproduer which triggers this?  Or would this
happen be any chance something that was dreamed up with DEPT?

       	      	     	       	    		- Ted

