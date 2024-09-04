Return-Path: <linux-kernel+bounces-316055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75596CA7E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38D01C21CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588217A938;
	Wed,  4 Sep 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="E7WNbKTs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CA146D7F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489284; cv=none; b=XN68sr+jIWNUv44bFc2MKk9MlHyCuePwJ2ja19KCmRdj400THkNxGLt873Nu02fDwQL+IBoV41SxeKa2zd/CHDQl6UYlRsaTvRHRAiQZDIegbgL+4ScqDwG2hZ1wLJfheZ/c8lxdSve6des06FhfBn5k1ubv8lltniIYHQXhipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489284; c=relaxed/simple;
	bh=azNdSubL/Np7rjlyzstSXo50QK9v1c6dCaOiUjTAdec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLbhy2o9Dapp2wam4B0PzswHFyRRVTiBHsVVgeMANsoV8t35DGb6G1D4IUgTK6IdwkTvOQb2wnkgrTJkjnWdY6L+kdl9zUEn+wFlxbcK6xeOhyq8WG1u7uUwJyAojeKjqaP1506rM4AKwQgxiXzMZJvTkz+yZgWnh7wZdmFiwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=E7WNbKTs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2054e22ce3fso1603895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725489282; x=1726094082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WyO77SPTX9aXQDMtbIN6DxC5ZyN7lMLaLLUCQ5eXYrk=;
        b=E7WNbKTs4JxJo1MMAfhzzJrvcBfpWzZkQPIsKx/nbaOW90cPsqOJxCi6ur5obuYqKb
         pI2JVy18sRsboGfciA1ncu0Zx32TfTuswu1PAJOSgX1pfdn7+6uHqUouQs35btQ1qf5J
         AmqIer4O8zLHwi6bOjtgK1kR4U2fGY28QzThbrY/rmjLdaaeXN0W5iH0Ls7LgRf9e41V
         2Ck0l55dFHeNBvCoeZiot1M/90HIL3ki7vgWdqKvFV/PZNJ9edeqrUpvnqhRWYzBzIEA
         podSwNjgK1uObHw5rUTuDJK5RiTjeTG7Ct3frDGy5+CM9XN5ZzrXKt9owdnEl5H72ub5
         fZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725489282; x=1726094082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyO77SPTX9aXQDMtbIN6DxC5ZyN7lMLaLLUCQ5eXYrk=;
        b=kfoW4vS3xQ6z0b8IKuqWpyLldbSofhwyMuthvFiKbz2w83ik23p5Ig7zzmkgHXKtMm
         BADQdYbI7ETv3gSlkjgYDCMpYpPABJO49IR49H8l21/ovZ2MAckJcPHfoGgnSoFaUavw
         k8Bbb7f7Q4rU45DEPYNYhybVUPzHxSBNcxRRnAhuxqrycVicI2CWvIpi24sBnGrlIKpY
         Sk0FAlJDt7pLfk+qrevbm2f922Jc6ROxdzLfoNHdA7SPtMASOlmGpJRI0l3SLNEQ7qJS
         PC0YF9Fhaqsyd98z5YMqZ2xZOheJb1DWv8uGMbw2R7YAMrc4giuPMkcyJ4QBqPZb9G9K
         3Hhg==
X-Forwarded-Encrypted: i=1; AJvYcCV9/7/xaK7OkWBU1TpZ0bs0umsof/SV0h1q9PnzWW84DVHlo2jbpaI+ryorH4V221mofniWa/7qv2w90rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrw57CYK5iTV0AJ7fVLSnScBdTT1W8cyt2WMQYyBNryeWVUnZh
	Ls7QBsFlqVzg577T+nPcd2y3yM/yIgzkn/ACA0p37hVN9gWk+DIs2s/Dz4kPj1E=
X-Google-Smtp-Source: AGHT+IEa7j7zwgb9tFFz5fxY6zFlznbHmhxEaWFrBcv9Z9lGCysxf/bgq/9UC3jOBUkEX0m0MasoXw==
X-Received: by 2002:a17:902:f682:b0:206:9640:e747 with SMTP id d9443c01a7336-20699b21af3mr79663415ad.43.1725489282411;
        Wed, 04 Sep 2024 15:34:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea582f4sm18038375ad.233.2024.09.04.15.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 15:34:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1slyaF-000tWk-0T;
	Thu, 05 Sep 2024 08:34:39 +1000
Date: Thu, 5 Sep 2024 08:34:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <Ztjgf/mzdnhj/szl@dread.disaster.area>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>

On Wed, Sep 04, 2024 at 02:03:13PM -0400, Kent Overstreet wrote:
> On Wed, Sep 04, 2024 at 06:46:00PM GMT, Michal Hocko wrote:
> > On Wed 04-09-24 12:05:56, Kent Overstreet wrote:
> > > But it seems to me that the limit should be lower if you're on e.g. a 2
> > > GB machine (not failing with a warning, just failing immediately rather
> > > than oom killing a bunch of stuff first) - and it's going to need to be
> > > raised above INT_MAX as large memory machines keep growing, I keep
> > > hitting it in bcachefs fsck code.
> > 
> > Do we actual usecase that would require more than couple of MB? The
> > amount of memory wouldn't play any actual role then.
> 
> Which "amount of memory?" - not parsing that.
> 
> For large allocations in bcachefs: in journal replay we read all the
> keys in the journal, and then we create a big flat array with references
> to all of those keys to sort and dedup them.
> 
> We haven't hit the INT_MAX size limit there yet, but filesystem sizes
> being what they are, we will soon. I've heard of users with 150 TB
> filesystems, and once the fsck scalability issues are sorted we'll be
> aiming for petabytes. Dirty keys in the journal scales more with system
> memory, but I'm leasing machines right now with a quarter terabyte of
> ram.

I've seen xfs_repair require a couple of TB of RAM to repair
metadata heavy filesystems of relatively small size (sub-20TB).
Once you get about a few hundred GB of metadata in the filesystem,
the fsck cross-reference data set size can easily run into the TBs.

So 256GB might *seem* like a lot of memory, but we were seeing
xfs_repair exceed that amount of RAM for metadata heavy filesystems
at least a decade ago...

Indeed, we recently heard about a 6TB filesystem with 15 *billion*
hardlinks in it.  The cross reference for resolving all those
hardlinks would require somewhere in the order of 1.5TB of RAM to
hold. The only way to reliably handle random access data sets this
large is with pageable memory....

> Another more pressing one is the extents -> backpointers and
> backpointers -> extents passes of fsck; we do a linear scan through one
> btree checking references to another btree. For the btree we're checking
> references to the lookups are random, so we need to cache and pin the
> entire btree in ram if possible, or if not whatever will fit and we run
> in multiple passes.
> 
> This is the #1 scalability issue hitting a number of users right now, so
> I may need to rewrite it to pull backpointers into an eytzinger array
> and do our random lookups for backpointers on that - but that will be
> "the biggest vmalloc array we can possible allocate", so the INT_MAX
> size limit is clearly an issue there...

Given my above comments, I think you are approaching this problem
the wrong way. It is known that the data set that can exceed
physical kernel memory size, hence it needs to be swappable. That
way users can extend the kernel memory capacity via swapfiles when
bcachefs.fsck needs more memory than the system has physical RAM.

This is a problem Darrick had to address for the XFS online repair
code - we've known for a long time that repair needs to hold a data
set larger than physical memory to complete successfully. Hence for
online repair we needed a mechanism that provided us with pagable
kernel memory. vmalloc() is not an option - it has hard size limits
(both API based and physical capacity based).

Hence Darrick designed and implemented pageable shmem backed memory
files (xfiles) to hold these data sets. Hence the size limit of the
online repair data set is physical RAM + swap space, same as it is
for offline repair. You can find the xfile code in
fs/xfs/scrub/xfile.[ch].

Support for large, sortable arrays of fixed size records built on
xfiles can be found in xfarray.[ch], and blob storage in
xfblob.[ch].

vmalloc() is really not a good solution for holding arbitrary sized
data sets in kernel memory....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

