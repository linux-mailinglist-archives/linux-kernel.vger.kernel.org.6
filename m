Return-Path: <linux-kernel+bounces-237000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479BC91E9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786801C22080
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F7171640;
	Mon,  1 Jul 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HKxKuu6I"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAAB18635
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866095; cv=none; b=Q6SSkNAAzMOv+S1S3t9zKVZTp6mGmKmox8vhpftNkp37mPvewOKv0eXoNKmISCwb+rQAXW8/fnau/yj5n99Xzvh27250HByrOUB9E0q8pq3SZbZys39b8hwWDYrTEpMUfPin+O+aEfIAAl+FtqfJtmdmZXnyxOZE8nIe8QoA4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866095; c=relaxed/simple;
	bh=pEuBrcitgvmBdTU+pzOHCoQC3u1MqREBXDnbJ7aAnT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdrMpjHB5D4SezCNpFRN7+C+dzPqZlNoO084DM11y7StksFM8rjbEBShBY+lgy+Ai9hEGwzjWk33Xp3EE/CyAtA1MHfns9iwiI6DTbKMromN8ZHtOdHh3F7kRKQ5Xj9NHgAdI3OKxyeKA0qjyW25xNJmYSD2je9MWBzaKldZjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HKxKuu6I; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80f6525a0c2so986660241.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719866093; x=1720470893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozJECDpXSrQuKE8DEY40zEUib6xwQXmEwyD/DI8MRRk=;
        b=HKxKuu6IbnjlRm9dj5gxAoW/+NsNISi2cJxVfPetq1MPiJemQac1kj6+3zRU4bbQJx
         Kn4awHlUIKHgFv6w3V6o4rHJHKMt8QMvPCt7kf9CpIpPhjYhanhIQGrt/iCztRcMVQ9W
         v+X95uHkQoyiivmYcItvhdgJrNkfQJqY8tXmMwvWS9PDgLqTfbu1T1MnY47NQHyYZse6
         h6Eh7PK8ylLeCiGTJpOlwVzTPRkE6Wxc7bO+3IuzZGAGvHkeDqlFcD0undfOYKMVFyil
         KEiDC6r1M8xOaEcpwMoIjpKUOpRe03JyHdkeXu1I3ShONMsWNyP2bur0VwdX7Tcht0yN
         pXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866093; x=1720470893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozJECDpXSrQuKE8DEY40zEUib6xwQXmEwyD/DI8MRRk=;
        b=qcXh09Y2IE2ELqzI82408K33heTvffm1F6ge9OVEe1SzjhdX/3VDVtTgIvwjCsxTGJ
         8oDZvnWfTxkIOU3njDdYwNYDTEUOEsBM2T+9GUX2LyMmvEtbDp4NXpgbF0cDmPsbytpa
         FmPu1AbU1RyyHA73oD8oK6w3+LV1vmdv3yjIR1dAvr+EVYK0iOEWpPJajY7dXMYDTsol
         pskEisygLAA7xjm6frAFaVS1BLfrbLC0AQPeJ//lCMHj+5eSptYRemCyY6AxCdL9A40m
         RL1CFixCFuC/O6MRlRYaz2WA/8xQ5Ak6xg49QQ8HtHwHIIRpU09aFRspv1vIjkBCtig8
         8aEg==
X-Forwarded-Encrypted: i=1; AJvYcCXbOxQZ65tOWp2JjR4ZNHVuTrKzfhCrYSkqN1/cR8fg8POlT3c2efjd/1hiFT3wXhMAiYMxQULFHh+KTC8vhHv/YxTG1jPe2HUVQ+66
X-Gm-Message-State: AOJu0Yw02LkBD7eDfjBaDO+RHoL5+9W7qVT1OBw8omBu4VMrEiQ7PxSh
	OCf46nKUhWT4PLChPnvWtFXH043hSxM9a1Ea5/BRkz8qd7OZCBrPK/zBWeyQbcY=
X-Google-Smtp-Source: AGHT+IHw3wIO6EWVDBs9VEb4k7K62FCyOBS2Dxfr1BuMYfu7sBepoSSnE3yVMSEuytYhGV4QJE8Gyg==
X-Received: by 2002:a05:6122:4fa6:b0:4ec:f8f0:7175 with SMTP id 71dfb90a1353d-4f2a5704fd3mr8693225e0c.11.1719866092656;
        Mon, 01 Jul 2024 13:34:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308d8esm383412185a.124.2024.07.01.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:34:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:34:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Message-ID: <20240701203451.GB510298@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
 <20240701135755.GE504479@perftesting>
 <0819d7c2-bb91-4dea-ac20-09191c0b2240@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0819d7c2-bb91-4dea-ac20-09191c0b2240@wdc.com>

On Mon, Jul 01, 2024 at 03:08:22PM +0000, Johannes Thumshirn wrote:
> On 01.07.24 15:58, Josef Bacik wrote:
> > On Mon, Jul 01, 2024 at 12:25:15PM +0200, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> If we can't insert a stripe extent in the RAID stripe tree, because
> >> the key that points to the specific position in the stripe tree is
> >> already existing, we have to remove the item and then replace it by a
> >> new item.
> >>
> >> This can happen for example on device replace operations.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> >> index e6f7a234b8f6..3020820dd6e2 100644
> >> --- a/fs/btrfs/raid-stripe-tree.c
> >> +++ b/fs/btrfs/raid-stripe-tree.c
> >> @@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
> >>   	return ret;
> >>   }
> >>   
> >> +static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
> >> +				    struct btrfs_key *key,
> >> +				    struct btrfs_stripe_extent *stripe_extent,
> >> +				    const size_t item_size)
> >> +{
> >> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> >> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> >> +	struct btrfs_path *path;
> >> +	int ret;
> >> +
> >> +	path = btrfs_alloc_path();
> >> +	if (!path)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
> >> +	if (ret)
> >> +		goto err;
> > 
> > This will leak 1 and we'll get an awkward btrfs_abort_transaction() call.  This
> > should be
> > 
> > if (ret) {
> > 	ret = (ret == 1) ? -ENOENT : ret;
> > 	goto err;
> > }
> > 
> > or whatever.  Thanks,
> 
> I wonder why I've never seen this in my testing. Could it be, that due 
> to the fact that btrfs_insert_item() returns -EEXIST on the same 
> key.objectid, we're more or less guaranteed it'll exist.

Yeah it's fine in the way it is currently, but if anything changes in the future
we're going to figure it out and be super sad we didn't just handle it right in
the first place.  Thanks,

Josef

