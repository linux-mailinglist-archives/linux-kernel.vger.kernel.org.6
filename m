Return-Path: <linux-kernel+bounces-181248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014778C7983
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BBE1F22506
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F014D2BD;
	Thu, 16 May 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TG3CMTYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15414D2A8
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873388; cv=none; b=PYvEULzNEEXzcdsbpoPvUVIXSzTZx/jF6rDaaSSCA/11WeyhwnO4m4FFzJxmd48HOFAsI0R+8wKz6KRvCogNeq6+g/0zLKZbFopLwt1Hmiw9oDggJsjuAdGEAIJD9beULQKcn23YcVYBONc2xjXeAvVcwn8vv16XE+sJfB2H+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873388; c=relaxed/simple;
	bh=RhDKxBqRK8qQ+lHwtauQVcSSfhbRWVtAUQmU6/Q1Bn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/3D1Q4fw7Ytlt+Bn+5oRvec1bd2U4UBw12h9WG/JSdHbsyDR0SAkKKyFp/xQY502ehFa6vODPb7YeaWeQwl3efn6VsqPyd4XkW3oXpJVdB0srbSKI3Zpuzw5oE9yU2eqWcpd9aqbjXeXknnDYz0FRxW25K1VEsJ13ByozIoP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG3CMTYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715873385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkKvfHDsq1+5iaz2UmJ8RA3u/nWfPXsKWMGU/Ix3SVM=;
	b=TG3CMTYZGBcyXIB5tO25nYgfGTXqfQckOkpmaHlWvTqN2+6McuRVgrNew0Bfd8vmk9Uois
	qpEgTBniNExQ62XKjktLon8zLXu7HboRWQ+qGjdV9A7fitbPntpX/fxQ2uQ21FVhJD7NJ9
	NNB7SvKlmrNOPqM4wj69KUnLLZFt5AY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Rj9S7aawNVmNtB3WY_wnFA-1; Thu, 16 May 2024 11:29:43 -0400
X-MC-Unique: Rj9S7aawNVmNtB3WY_wnFA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 320EA80021D;
	Thu, 16 May 2024 15:29:43 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 159D14B400E;
	Thu, 16 May 2024 15:29:42 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 44GFTgLQ131923
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 11:29:42 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 44GFTfQh131922;
	Thu, 16 May 2024 11:29:41 -0400
Date: Thu, 16 May 2024 11:29:41 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dm: support retrieving struct dm_target from struct
 dm_dev
Message-ID: <ZkYmZaGWPtGIwedG@redhat.com>
References: <20240514090445.2847-1-yang.yang@vivo.com>
 <20240514090445.2847-4-yang.yang@vivo.com>
 <ZkTXzG1yrPmW64Z6@redhat.com>
 <80ddcd90-2e1c-4fbf-a45a-b1b5ff4d60fb@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ddcd90-2e1c-4fbf-a45a-b1b5ff4d60fb@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Thu, May 16, 2024 at 09:55:53AM +0800, YangYang wrote:
> On 2024/5/15 23:42, Benjamin Marzinski wrote:
> > On Tue, May 14, 2024 at 05:04:42PM +0800, Yang Yang wrote:
> > > Add a list to the struct dm_dev structure to store the associated
> > > targets, while also allowing differentiation between different target
> > > types.
> > 
> > I still think this is more complex than it needs to be. If devices that
> > support flush_pass_around can guarantee that:
> > 
> > 1. They will send a flush bio to all of their table devices
> > 2. They are fine with another target sending the flush bio to their
> >     table devices
> > 
> > Then I don't see why we need the table devices to keep track of all the
> > different target types that are using them. Am I missing something here?
> 
> I attempted to enhance this solution to support additional target types,
> such as those with num_flush_bios greater than 1.

I'm still missing why sending a flush to each target type is necessary
to handle num_flush_bios > 1. As long as the targets meet the
requirements I listed before, AFAICS it should still work with only one
of the targets mapped to each device.

Say the table devices are sda, sdb, sdc, and sdd.  If you have 4 linear
targets, each mapped to a different table device, and one stripe target
mapped to all of them.  It doesn't really matter if you don't call
__send_empty_flush_bios() for the stripe target, does it? all if its
stripe devs will still get flushes. Similarly, it's fine if one of the
linear targets doesn't get called (in fact it's fine if all the linear
targets don't get called, since the stripe target will send flushes to
all the devices). If there were only 3 linear targets, then the stripe
target would get linked to a table device, so it would get a flush sent
to it. Can you explain a situation where you need the to send a flush to
multiple targets per table device for this to work, if you assume the 2
guarantees I mentioned above (the target sends flushes to all their
devices, and they don't do something special so they need to be the one
to send the flushes).

> 
> > If we don't need to worry about sending a flush bio to a target of each
> > type that is using a table device, then all we need to do is call
> > __send_empty_flush_bios() for enough targets to cover all the table
> > devices. This seems a lot easier to track. We just need another flag in
> > dm_target, something like sends_pass_around_flush.
> > 
> > When a target calls dm_get_device(), if it adds a new table device to
> > t->devices, then it's the first target in this table to use that device.
> > If flush_pass_around is set for this target, then it also sets
> > sends_pass_around_flush. In __send_empty_flush() if the table has
> > flush_pass_around set, when you iterate through the devices, you only
> > call __send_empty_flush_bios() for the ones with sends_pass_around_flush
> > set.
> > 
> > Or am I overlooking something?
> 
> If I understand correctly, you are suggesting to iterate through all the
> targets, handling those with sends_pass_around_flush set, and skipping
> those where sends_pass_around_flush is not set. I believe this approach
> may result in some CPU wastage.
> 
>   for i in {0..1023}; do
>     echo $((8000*$i)) 8000 linear /dev/sda2 $((16384*$i))
>   done | sudo dmsetup create example
> 
> In this specific scenario, a single iteration of the loop is all that
> is needed.

It's just one iteration of the loop either way. You either loop through
the targets or the devices.  It's true that if you have lots of targets
all mapped to the same device, you would waste time looping through all
the targets instead of looping through the devices.  But if you only had
one striped target mapped to lots of devices, you would waste time
looping through all of the devices instead of looping through the
targets.  

-Ben
 
> > 
> > -Ben
> > 
> > > 
> > > Signed-off-by: Yang Yang <yang.yang@vivo.com>
> > > ---
> > >   drivers/md/dm-table.c         | 36 +++++++++++++++++++++++++++++++++++
> > >   include/linux/device-mapper.h |  3 +++
> > >   2 files changed, 39 insertions(+)
> > > 
> > > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > > index bd68af10afed..f6554590b7af 100644
> > > --- a/drivers/md/dm-table.c
> > > +++ b/drivers/md/dm-table.c
> > > @@ -741,6 +741,8 @@ int dm_table_add_target(struct dm_table *t, const char *type,
> > >   	if (ti->flush_pass_around == 0)
> > >   		t->flush_pass_around = 0;
> > > +	INIT_LIST_HEAD(&ti->list);
> > > +
> > >   	return 0;
> > >    bad:
> > > @@ -2134,6 +2136,25 @@ void dm_table_postsuspend_targets(struct dm_table *t)
> > >   	suspend_targets(t, POSTSUSPEND);
> > >   }
> > > +static int dm_link_dev_to_target(struct dm_target *ti, struct dm_dev *dev,
> > > +		sector_t start, sector_t len, void *data)
> > > +{
> > > +	struct list_head *targets = &dev->targets;
> > > +	struct dm_target *pti;
> > > +
> > > +	if (!list_empty(targets)) {
> > > +		list_for_each_entry(pti, targets, list) {
> > > +			if (pti->type == ti->type)
> > > +				return 0;
> > > +		}
> > > +	}
> > > +
> > > +	if (list_empty(&ti->list))
> > > +		list_add_tail(&ti->list, targets);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int dm_table_resume_targets(struct dm_table *t)
> > >   {
> > >   	unsigned int i;
> > > @@ -2162,6 +2183,21 @@ int dm_table_resume_targets(struct dm_table *t)
> > >   			ti->type->resume(ti);
> > >   	}
> > > +	if (t->flush_pass_around) {
> > > +		struct list_head *devices = &t->devices;
> > > +		struct dm_dev_internal *dd;
> > > +
> > > +		list_for_each_entry(dd, devices, list)
> > > +			INIT_LIST_HEAD(&dd->dm_dev->targets);
> > > +
> > > +		for (i = 0; i < t->num_targets; i++) {
> > > +			struct dm_target *ti = dm_table_get_target(t, i);
> > > +
> > > +			if (ti->type->iterate_devices)
> > > +				ti->type->iterate_devices(ti, dm_link_dev_to_target, NULL);
> > > +		}
> > > +	}
> > > +
> > >   	return 0;
> > >   }
> > > diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> > > index 0893ff8c01b6..19e03f9b2589 100644
> > > --- a/include/linux/device-mapper.h
> > > +++ b/include/linux/device-mapper.h
> > > @@ -169,6 +169,7 @@ struct dm_dev {
> > >   	struct dax_device *dax_dev;
> > >   	blk_mode_t mode;
> > >   	char name[16];
> > > +	struct list_head targets;
> > >   };
> > >   /*
> > > @@ -298,6 +299,8 @@ struct dm_target {
> > >   	struct dm_table *table;
> > >   	struct target_type *type;
> > > +	struct list_head list;
> > > +
> > >   	/* target limits */
> > >   	sector_t begin;
> > >   	sector_t len;
> > > -- 
> > > 2.34.1
> > > 
> > 


