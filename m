Return-Path: <linux-kernel+bounces-382834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0F9B13D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4E282E87
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D226AA1;
	Sat, 26 Oct 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XE7yxH5M"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C802594
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729902639; cv=none; b=ooxIG+PNzvR9U3XK1ODt9FzwRiVpfw5xZqVESEmY4FWN2vIP381NdHjZHBn33wMRvYcmUyiA1Uq0aE2yL/WfOiugZ6uj9kkJm2OdhB3l4dk0KuSLBl44QrIn1PbKjUzFQkpMuwNv1s87/QVKw09r1HS0ODDrYzLGf5Ts5FgmGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729902639; c=relaxed/simple;
	bh=WFtzCjILwJ2gzG9mkuOMQoIVud6eAhhFNfFeFNQL96o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htpkJ2F2+9nbuMHUH7/VcBHYGtM0AdTNd/BCo71HnIWNJRyvhu8YppMf95fVqnQ+AZZR6bK6JLc2nxymSPuRk4dGoygxtOg+qC1PnVrPXdkTNM7cSQlFOia2H/rktvlc5pL/b9D4XXM6/aws/E1Lq+zTEoGNb/QU+M20p7UHqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XE7yxH5M; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 20:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729902634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjcXswSTvboDAwi6CGAaOWxN2ytTamn8Yc0W4xV+hm4=;
	b=XE7yxH5Mzy02G+n6/ukIFvuJ6LxcLfPMoF2c/LOex4z7nb+8smTOnRgomPbtqnzJk4HTOW
	+xrifjPehk2DktjVb8WngKc7kjMI7/cUYmZ3D7rx+buIEqVO134fcIuIApEOsFfVJYuycP
	hwbb6DxtCPcmEd2vyAH3o0gra24UhXc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] bcachefs: init freespace inited bits to 0 in
 bch2_fs_initialize
Message-ID: <zks5hk34if64nu4t7tsnjc2om4cdyo7fs62fgyxjzetr6njo72@ajmllmpmex45>
References: <20241026001004.10470-2-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026001004.10470-2-pZ010001011111@proton.me>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 26, 2024 at 12:15:49AM +0000, Piotr Zalewski wrote:
> Initialize freespace_initialized bits to 0 in member's flags and update
> member's cached version for each device in bch2_fs_initialize.
> 
> It's possible for the bits to be set to 1 before fs is initialized and if
> call to bch2_trans_mark_dev_sbs (just before bch2_fs_freespace_init) fails
> bits remain to be 1 which can later indirectly trigger BUG condition in
> bch2_bucket_alloc_freelist during shutdown.
> 
> Reported-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2b6a17991a6af64f9489
> Fixes: bbe682c76789 ("bcachefs: Ensure devices are always correctly initialized")
> Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
> ---
> 
> Notes:
>     changes in v3:
>         - v2 rebased
> 
>     changes in v2:
>         - unconditionally set freespace initialized bits to false at
>           the top of bch2_fs_initialized instead of only if
>           bch2_trans_mark_dev_sbs fails
> 
>     Link to v2: https://lore.kernel.org/linux-bcachefs/20241021174151.37692-2-pZ010001011111@proton.me/
>     Link to v1: https://lore.kernel.org/linux-bcachefs/20241020170708.67044-2-pZ010001011111@proton.me/
> 
>  fs/bcachefs/recovery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
> index fdf2aa2ffc13..8d4c93a1f5aa 100644
> --- a/fs/bcachefs/recovery.c
> +++ b/fs/bcachefs/recovery.c
> @@ -1029,6 +1029,7 @@ int bch2_fs_initialize(struct bch_fs *c)
>  	struct bch_inode_unpacked root_inode, lostfound_inode;
>  	struct bkey_inode_buf packed_inode;
>  	struct qstr lostfound = QSTR("lost+found");
> +	struct bch_member *m;
>  	int ret;
>  
>  	bch_notice(c, "initializing new filesystem");
> @@ -1045,6 +1046,13 @@ int bch2_fs_initialize(struct bch_fs *c)
>  		SET_BCH_SB_VERSION_UPGRADE_COMPLETE(c->disk_sb.sb, bcachefs_metadata_version_current);
>  		bch2_write_super(c);
>  	}
> +
> +	for_each_member_device(c, ca) {
> +		m = bch2_members_v2_get_mut(c->disk_sb.sb, ca->dev_idx);
> +		SET_BCH_MEMBER_FREESPACE_INITIALIZED(m, false);
> +		ca->mi = bch2_mi_to_cpu(m);
> +	}
> +

I'm also adding a write_super() call here: that's what updates
ca->mi.freespace_initialized which the freespace init path will later
check.

>  	mutex_unlock(&c->sb_lock);
>  
>  	c->curr_recovery_pass = BCH_RECOVERY_PASS_NR;
> -- 
> 2.47.0
> 
> 

