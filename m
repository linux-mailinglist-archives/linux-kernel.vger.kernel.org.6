Return-Path: <linux-kernel+bounces-337192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC579846BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDCC1F2343B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E41A7ADD;
	Tue, 24 Sep 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ytc167/7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434711A7AD8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184617; cv=none; b=Rrqwu7CfKptu6/S5WObR3/GB+EidYRODWVdVHITN1tgiod34QPyPEovq7jP5M1AEJsYeDqMBst1tc24GXSaN3rvJs4Ul9ms+iZA/0TBU+ygHAEYNmCoovrV/VZVJajNh89yDpyUR7u+bHUE9L2fhCc8f9iDZR60lzIzvAKmDMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184617; c=relaxed/simple;
	bh=QHHq8Cr0Qh/e8CdARu1GwMnudjIsQH2f36zFKbQT8DQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mskY1+xjR+wnRDKNaFeKX1baQ8ji6oB3FClU2Ba3f40Fp/tciwgcvQ9VgvMk20F97134bpKEM39fJaxHDOfeck7wMof+PbqxmkpqpAl5n/tk5IQT5XtqIsialGGvMmy6RzIXhBN1CW2/NESjuKMvogdvJQcHGuw0wpOFg9J+W/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ytc167/7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727184612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnhTz+MJmpzIfB8gnq4thTTrTSgvngwAywtw5oQl+SA=;
	b=Ytc167/7s0R1hLorjowH+FaICF18eioe112aAlAGr+tSARAwG33uZf0N3UCzlgPjiwxdQW
	U62o3A9j3Htmmt/NemPeOY8C8GT9zsjQfeNrKyXemo3zaaFu1A+k9/xH2Vlow6PuJtoDC3
	m3LoaXc3k/A2cEZbSrk486IAfs7WVh0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-KNi4YbxHMo-cF07Ey4zLvg-1; Tue,
 24 Sep 2024 09:30:06 -0400
X-MC-Unique: KNi4YbxHMo-cF07Ey4zLvg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24EA718EA974;
	Tue, 24 Sep 2024 13:30:03 +0000 (UTC)
Received: from [10.45.226.79] (unknown [10.45.226.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8EF218D5349;
	Tue, 24 Sep 2024 13:23:10 +0000 (UTC)
Date: Tue, 24 Sep 2024 15:23:08 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Shen Lichuan <shenlichuan@vivo.com>
cc: colyli@suse.de, kent.overstreet@linux.dev, agk@redhat.com, 
    snitzer@kernel.org, song@kernel.org, yukuai3@huawei.com, 
    linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-raid@vger.kernel.org
Subject: Re: [PATCH v1] md: Correct typos in multiple comments across various
 files
In-Reply-To: <20240924091733.8370-1-shenlichuan@vivo.com>
Message-ID: <d95d7419-7bac-802f-a5d6-456900539c32@redhat.com>
References: <20240924091733.8370-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi

I've applied the device mapper part of the patch.

Mikulas


On Tue, 24 Sep 2024, Shen Lichuan wrote:

> Fixed some confusing spelling errors that were currently identified,
> the details are as follows:
> 
> -in the code comments:
> 	writeback.c: 124:		overrite	==> overwrite
> 	dm-cache-target.c: 1371:	exclussive	==> exclusive
> 	dm-raid.c: 2522:		repective	==> respective
> 	md-cluster.c: 552:		daemaon		==> daemon
> 	md.c: 511:			entred		==> entered
> 	raid5-ppl.c: 990:		parial		==> partial
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/md/bcache/writeback.c | 2 +-
>  drivers/md/dm-cache-target.c  | 2 +-
>  drivers/md/dm-raid.c          | 2 +-
>  drivers/md/md-cluster.c       | 2 +-
>  drivers/md/md.c               | 2 +-
>  drivers/md/raid5-ppl.c        | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index c1d28e365910..3354a5cd587c 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -121,7 +121,7 @@ static void __update_writeback_rate(struct cached_dev *dc)
>  		}
>  		fps = div_s64(dirty, dirty_buckets) * fp_term;
>  		if (fragment > 3 && fps > proportional_scaled) {
> -			/* Only overrite the p when fragment > 3 */
> +			/* Only overwrite the p when fragment > 3 */
>  			proportional_scaled = fps;
>  		}
>  	}
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 17f0fab1e254..3e8be29c0a5e 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -1368,7 +1368,7 @@ static void mg_copy(struct work_struct *ws)
>  			 */
>  			bool rb = bio_detain_shared(mg->cache, mg->op->oblock, mg->overwrite_bio);
>  
> -			BUG_ON(rb); /* An exclussive lock must _not_ be held for this block */
> +			BUG_ON(rb); /* An exclusive lock must _not_ be held for this block */
>  			mg->overwrite_bio = NULL;
>  			inc_io_migrations(mg->cache);
>  			mg_full_copy(ws);
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 63682d27fc8d..1e0d3b9b75d6 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -2519,7 +2519,7 @@ static int super_validate(struct raid_set *rs, struct md_rdev *rdev)
>  		rdev->saved_raid_disk = rdev->raid_disk;
>  	}
>  
> -	/* Reshape support -> restore repective data offsets */
> +	/* Reshape support -> restore respective data offsets */
>  	rdev->data_offset = le64_to_cpu(sb->data_offset);
>  	rdev->new_data_offset = le64_to_cpu(sb->new_data_offset);
>  
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 6595f89becdb..867af995b767 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -549,7 +549,7 @@ static void process_metadata_update(struct mddev *mddev, struct cluster_msg *msg
>  
>  	dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_CR);
>  
> -	/* daemaon thread must exist */
> +	/* daemon thread must exist */
>  	thread = rcu_dereference_protected(mddev->thread, true);
>  	wait_event(thread->wqueue,
>  		   (got_lock = mddev_trylock(mddev)) ||
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 179ee4afe937..11078a4e4951 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -508,7 +508,7 @@ static void __mddev_resume(struct mddev *mddev, bool recovery_needed)
>  		return;
>  	}
>  
> -	/* entred the memalloc scope from mddev_suspend() */
> +	/* entered the memalloc scope from mddev_suspend() */
>  	memalloc_noio_restore(mddev->noio_flag);
>  
>  	percpu_ref_resurrect(&mddev->active_io);
> diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
> index a70cbec12ed0..5323025e7dd9 100644
> --- a/drivers/md/raid5-ppl.c
> +++ b/drivers/md/raid5-ppl.c
> @@ -987,7 +987,7 @@ static int ppl_recover(struct ppl_log *log, struct ppl_header *pplhdr,
>  		crc = ~0;
>  		crc_stored = le32_to_cpu(e->checksum);
>  
> -		/* read parial parity for this entry and calculate its checksum */
> +		/* read partial parity for this entry and calculate its checksum */
>  		while (pp_size) {
>  			int s = pp_size > PAGE_SIZE ? PAGE_SIZE : pp_size;
>  
> -- 
> 2.17.1
> 


