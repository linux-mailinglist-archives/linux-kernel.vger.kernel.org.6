Return-Path: <linux-kernel+bounces-241794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51CE927FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CC71F222F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382612E40;
	Fri,  5 Jul 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UNwDwHMI"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3202F9C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142339; cv=none; b=RIhB1xDZJoTvO218B5VvQA/ovzBwBUSwR1bctEo3vzHZ1U08Y0spNZfe3To8BeQnkWGmSf20D0jBfpYPcSaNFTLC+UEgGkr1Q1dKbcKBw3n63eOi20tY/c4fw3wCTeOazl6qhX7EE+gKPWR8njcVSl8TEKroV7K/JSulJwecPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142339; c=relaxed/simple;
	bh=t1/aYkpV7V9HCTNO0YMUZAFhVFpbLpd/1zvnFvlw1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izF+j9yUkz6PCpLViRdTdDdsupwUL8pRAP+J8IePYoO0BF6U4Z+I89Rmb42yoUx4OfjrKgdGPrKiwQ/Qto6T6jBSZzoXkA60eHPjj6IpnC+kk27D9zPE3hOwqPSexoaKmePTjPIUIY9L3cuO7KCP7iFKxuwlgCADmoiDOg5qxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UNwDwHMI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lizhi.xu@windriver.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720142333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85/6LBuQAaBN+mbTKPEBbYAV1KKnq1MLct+EJMapHB0=;
	b=UNwDwHMIfH48SxXAlMZ/K4dQ2RmOVMo/oyPConYD4nti+49XDlCjWs8dWEWqsb5y060RK7
	DKX8C4nzPXvQQLynMSWO50EmFx+PGPn1pjQPuJRiUe+DMKBwI12cJseCEClUU73LxQjUTG
	r7RksZLiFEosEyL6h3kUIeiOXv/ArLY=
X-Envelope-To: syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Thu, 4 Jul 2024 21:18:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com, 
	bfoster@redhat.com, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix hung in bch2_fs_read_only_work
Message-ID: <npvjcsr62mknglu6fp222ga7zmsqzewtrbiuvpuup2s5omu77y@ef6vk35ubzpi>
References: <000000000000d4c7f4061a080a7a@google.com>
 <20240701143606.3904202-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701143606.3904202-1-lizhi.xu@windriver.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 10:36:06PM GMT, Lizhi Xu wrote:
> Error logs:
> [ T5078] invalid journal entry, version=1.7: mi_btree_bitmap type=btree_keys in superblock: k->u64s 0, shutting down
> [ T5078] invalid journal entry, version=1.7: mi_btree_bitmap type=btree_keys in superblock: k->u64s 0, shutting down
> [ T5078] invalid journal entry, version=1.7: mi_btree_bitmap type=btree_keys in superblock: k->u64s 0, shutting down
> 
> When hit -BCH_ERR_fsck_errors_not_fixed in journal_entry_err, it will make
> journal_entry_btree_keys_validate output too many same error log, and it will block
> bch2_fs_start to release state_lock.
> 
> Reported-and-tested-by: syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/bcachefs/journal_io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
> index 492426c8d869..67c3f09162e4 100644
> --- a/fs/bcachefs/journal_io.c
> +++ b/fs/bcachefs/journal_io.c
> @@ -415,6 +415,8 @@ static int journal_entry_btree_keys_validate(struct bch_fs *c,
>  					       flags|BCH_VALIDATE_journal);
>  		if (ret == FSCK_DELETED_KEY)
>  			continue;
> +		else if (ret == -BCH_ERR_fsck_errors_not_fixed)
> +			break;

Actually, this is wrong: we need to return the error


commit b2879202fa55861d05088bbffdb529cf5d5ba7f8
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Jul 4 21:18:06 2024 -0400

    bcachefs: Fix missing error check in journal_entry_btree_keys_validate()
    
    Closes: https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 40ed7a619594..7a833a3f1c63 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -415,6 +415,8 @@ static int journal_entry_btree_keys_validate(struct bch_fs *c,
 					       flags|BCH_VALIDATE_journal);
 		if (ret == FSCK_DELETED_KEY)
 			continue;
+		else if (ret)
+			return ret;
 
 		k = bkey_next(k);
 	}

