Return-Path: <linux-kernel+bounces-180082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3C8C69E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF431C213DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF20155A53;
	Wed, 15 May 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/pnp8Ze"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C44155749
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787739; cv=none; b=gZySfurlfOmq0kElTeqOiU9sizlZaz0MO6ZocldY8K3Md7aHCF8uT8S2+qTdPz6fpSs1S7QBS/qYa7YEVNHNNEJ/RW8Tb/OP/U6CH17SFMYbR+82jwTv2/wFfK0ES8mDdXUuvQKE8/Cl1lFSMXTW6oiUWy25kHWyT1gH6Bj+ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787739; c=relaxed/simple;
	bh=/deTcq+w80Cb17xbYuE3uBl4Y02GhqRR0ENPYtWyjOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4wxt9GyeW2UAgxLOxr4ywHS5/WjnIQ5wOLcPnnL80UANfjSg2Nclx6/7kTYxL52mkRH+844kGs5jMDXsWVCcHOlCKBBSO0fy6joGx1SWHuCQ4HEvcAQV7pMXNiOxJYxtInSWkFcoKJGQ/Q4r8SDqoop5kHuNDkpDHwhdqphd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/pnp8Ze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715787736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KDC9yVDJQXh1VBgH8zcKx1ck2Zow97M73RPc1/GvQ4U=;
	b=R/pnp8Zeyq+adzat/cco2i0vqQCWeWgF7cEtNGqjDiyqi+sbKFk/KnHpyazxSll6eXyAYP
	bvMijIaOgOU8bAlFEugwiR6M9RhXK1qrmcHMMNinol3pJ8hJzKk5NuX9utWOLsc+35IK56
	2ESQ7vj470wrB1AWZu3JjcsvDja+SjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ewEautHJMya3PrE8ptHmoQ-1; Wed, 15 May 2024 11:42:05 -0400
X-MC-Unique: ewEautHJMya3PrE8ptHmoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7218E80118E;
	Wed, 15 May 2024 15:42:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6641028E2;
	Wed, 15 May 2024 15:42:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 44FFg4f3119750
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:42:04 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 44FFg4q7119749;
	Wed, 15 May 2024 11:42:04 -0400
Date: Wed, 15 May 2024 11:42:04 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Yang Yang <yang.yang@vivo.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dm: support retrieving struct dm_target from struct
 dm_dev
Message-ID: <ZkTXzG1yrPmW64Z6@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com>
 <20240514090445.2847-4-yang.yang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514090445.2847-4-yang.yang@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, May 14, 2024 at 05:04:42PM +0800, Yang Yang wrote:
> Add a list to the struct dm_dev structure to store the associated
> targets, while also allowing differentiation between different target
> types.

I still think this is more complex than it needs to be. If devices that
support flush_pass_around can guarantee that:

1. They will send a flush bio to all of their table devices
2. They are fine with another target sending the flush bio to their
   table devices

Then I don't see why we need the table devices to keep track of all the
different target types that are using them. Am I missing something here?

If we don't need to worry about sending a flush bio to a target of each
type that is using a table device, then all we need to do is call
__send_empty_flush_bios() for enough targets to cover all the table
devices. This seems a lot easier to track. We just need another flag in
dm_target, something like sends_pass_around_flush.

When a target calls dm_get_device(), if it adds a new table device to
t->devices, then it's the first target in this table to use that device.
If flush_pass_around is set for this target, then it also sets
sends_pass_around_flush. In __send_empty_flush() if the table has
flush_pass_around set, when you iterate through the devices, you only
call __send_empty_flush_bios() for the ones with sends_pass_around_flush
set.

Or am I overlooking something?

-Ben

> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  drivers/md/dm-table.c         | 36 +++++++++++++++++++++++++++++++++++
>  include/linux/device-mapper.h |  3 +++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bd68af10afed..f6554590b7af 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -741,6 +741,8 @@ int dm_table_add_target(struct dm_table *t, const char *type,
>  	if (ti->flush_pass_around == 0)
>  		t->flush_pass_around = 0;
>  
> +	INIT_LIST_HEAD(&ti->list);
> +
>  	return 0;
>  
>   bad:
> @@ -2134,6 +2136,25 @@ void dm_table_postsuspend_targets(struct dm_table *t)
>  	suspend_targets(t, POSTSUSPEND);
>  }
>  
> +static int dm_link_dev_to_target(struct dm_target *ti, struct dm_dev *dev,
> +		sector_t start, sector_t len, void *data)
> +{
> +	struct list_head *targets = &dev->targets;
> +	struct dm_target *pti;
> +
> +	if (!list_empty(targets)) {
> +		list_for_each_entry(pti, targets, list) {
> +			if (pti->type == ti->type)
> +				return 0;
> +		}
> +	}
> +
> +	if (list_empty(&ti->list))
> +		list_add_tail(&ti->list, targets);
> +
> +	return 0;
> +}
> +
>  int dm_table_resume_targets(struct dm_table *t)
>  {
>  	unsigned int i;
> @@ -2162,6 +2183,21 @@ int dm_table_resume_targets(struct dm_table *t)
>  			ti->type->resume(ti);
>  	}
>  
> +	if (t->flush_pass_around) {
> +		struct list_head *devices = &t->devices;
> +		struct dm_dev_internal *dd;
> +
> +		list_for_each_entry(dd, devices, list)
> +			INIT_LIST_HEAD(&dd->dm_dev->targets);
> +
> +		for (i = 0; i < t->num_targets; i++) {
> +			struct dm_target *ti = dm_table_get_target(t, i);
> +
> +			if (ti->type->iterate_devices)
> +				ti->type->iterate_devices(ti, dm_link_dev_to_target, NULL);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 0893ff8c01b6..19e03f9b2589 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -169,6 +169,7 @@ struct dm_dev {
>  	struct dax_device *dax_dev;
>  	blk_mode_t mode;
>  	char name[16];
> +	struct list_head targets;
>  };
>  
>  /*
> @@ -298,6 +299,8 @@ struct dm_target {
>  	struct dm_table *table;
>  	struct target_type *type;
>  
> +	struct list_head list;
> +
>  	/* target limits */
>  	sector_t begin;
>  	sector_t len;
> -- 
> 2.34.1
> 


