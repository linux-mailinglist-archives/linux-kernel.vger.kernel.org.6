Return-Path: <linux-kernel+bounces-366797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007999FA89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF757281BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0D21E3CF;
	Tue, 15 Oct 2024 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Qcx4UqRC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAF21E3B6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029066; cv=none; b=cCPauoriWLboGDvrh/Cn6dKkrmv1gq7JrwCidr6N52nyOypPyJDfxAbzg8q0gRG16qF1A7D67RpW51Qc662JxdAZYU9JlKw4W13Hon2Is0Rffqyf3uB1Nq21w//oLpuHRLccWMMI1y21o/GXiSn87ARrDSgUdPx49ID36pi5umM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029066; c=relaxed/simple;
	bh=hSozEFv8m/TbtSvxb0FHznXq89oiylmQ9bp16lbzkB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH1KRI19Kov4uhiIcAH8Vtw80bV4FKpYq6DI795TwGR4GyjY2fTkZn6AfzxZfEQuO1Chyq8/Z+ZM/EafPi9iILCElAVDwdCiWMR4mbwjry2MC2Z8am47/fFtnRlVH76bfm56nrZWiV3eNTus8x17p3qgkf+y/0JI/m4YHyecaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Qcx4UqRC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb7088cbcso32231585ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1729029063; x=1729633863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIbql7FxBLA7l3QYk3auusd9TTm3/LPL/t4lU1Jlbps=;
        b=Qcx4UqRC0/q1yvmF0cq6qb2ln2IOw0V7pz660dh7RGdkrk9rzaZH7urKzToL4PAy2d
         g9KxHAKcx7V8Enq8r+lKjmicN/YYMsGLb8AXTGNIq7ZRZuwOnR3I0/JM+4JvTfD5L9aj
         jZUENy2VWH605SvNfCN29LL5G2RZBSQ6LCwH8gm8P334ZgZPhQlCMmqguCJcXP2hbku7
         YV7O/Tu7gBOAOhiLbKaCu13iRJ6PR+enu0MiaJSgN/fo6pe+24n0sy25aevI2CH1qlPY
         iWjsfwIvdhartKxi2mlbQFSB+Uh5PF1dCUhIizekvx48scQJI6IK8psAQyAIsWhCEg/I
         aFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029063; x=1729633863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIbql7FxBLA7l3QYk3auusd9TTm3/LPL/t4lU1Jlbps=;
        b=qdvD3dcouEMAJXjVcu97YKYZP8U+YP7wzVkb/b2LIj0BKT3nPjCsgoQGsRiB+3hdNA
         DCaK0uL4N745lVANpFKO2BzEAGLErlL5DhsKLTPE0ZDilazCMbqxdmAmQ/+4Gi2mws7y
         kgePGXK7R+2lBVU7ufEXcWBMxH5NdRmFTSPZwj9JaXoGmiEwTH0P1BfsWKdGEi/1sW6T
         8raYTvATN+bo8TOGF/zgQ+ovWo/YjzT1QcrvIlmXRmbMLGH67qSPUV/QpNRR4uP/uqiA
         vPLUgSdT3o4Uw/eqyk7cgnJgObTTMLIokoDr2csQHQAGIa2zkaq0U1XTvBzk/6BtvA/m
         ACGA==
X-Forwarded-Encrypted: i=1; AJvYcCUzPKzXxYzq6RAagq0/eZaCLj52WhWBEinB1snmTiNXcI63yli1zddY8I9F6FOP4Z6iejznIo1Tqr7TPsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt88LMSHfqeGAA5AHMzyFKCFygfyUllxlDrMJSPik4t1o5TDZP
	JUx/YiNhBZes9kWTyQHBOwclLC6dQA2Y+J7D+t8oLYQkx6+/odkLnpVoNuucj1I=
X-Google-Smtp-Source: AGHT+IE/XMxkLQRQ+1ybzN2RlD4aGRDcGf735MJ5FdQ2NG2Jfi6aKsAKSmpvMZQwyvpmVGmFPZWcpA==
X-Received: by 2002:a17:902:d490:b0:20c:f3cf:50eb with SMTP id d9443c01a7336-20cf3cf5379mr85213165ad.44.1729029062976;
        Tue, 15 Oct 2024 14:51:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f844b0sm16990155ad.38.2024.10.15.14.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:51:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t0pRT-001IyZ-02;
	Wed, 16 Oct 2024 08:50:59 +1100
Date: Wed, 16 Oct 2024 08:50:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Brian Foster <bfoster@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iomap]  c5c810b94c:
 stress-ng.metamix.ops_per_sec -98.4% regression
Message-ID: <Zw7jwnvBaMwloHXG@dread.disaster.area>
References: <202410141536.1167190b-oliver.sang@intel.com>
 <Zw1IHVLclhiBjDkP@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw1IHVLclhiBjDkP@bfoster>

On Mon, Oct 14, 2024 at 12:34:37PM -0400, Brian Foster wrote:
> On Mon, Oct 14, 2024 at 03:55:24PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -98.4% regression of stress-ng.metamix.ops_per_sec on:
> > 
> > 
> > commit: c5c810b94cfd818fc2f58c96feee58a9e5ead96d ("iomap: fix handling of dirty folios over unwritten extents")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: stress-ng
> > config: x86_64-rhel-8.3
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	nr_threads: 100%
> > 	disk: 1HDD
> > 	testtime: 60s
> > 	fs: xfs
> > 	test: metamix
> > 	cpufreq_governor: performance
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202410141536.1167190b-oliver.sang@intel.com
> > 
> > 
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241014/202410141536.1167190b-oliver.sang@intel.com
> > 
> 
> So I basically just run this on a >64xcpu guest and reproduce the delta:
> 
>   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> 
> The short of it is that with tracing enabled, I see a very large number
> of extending writes across unwritten mappings, which basically means XFS
> eof zeroing is calling zero range and hitting the newly introduced
> flush. This is all pretty much expected given the patch.

Ouch.

The conditions required to cause this regression are that we either
first use fallocate() to preallocate beyond EOF, or buffered writes
trigger specualtive delalloc beyond EOF and they get converted to
unwritten beyond EOF through background writeback or fsync
operations. Both of these lead to unwritten extents beyond EOF that
extending writes will fall into.

All we need now is the extending writes to be slightly
non-sequential and those non-sequential extending writes will not
land at EOF but at some distance beyond it. At this point, we
trigger the new flush code. Unfortunately, this is actually a fairly
common workload pattern.

For example, experience tells me that NFS server processing of async
sequential write requests from a client will -always- end up with
slightly out of order extending writes because the incoming async
write requests are processed concurrently. Hence they always race to
extend the file and slightly out of order file extension happens
quite frequently.

Further, the NFS client will also periodically be sending a write
commit request (i.e. server side fsync), the
NFS server writeback will convert the speculative delalloc that
extends beyond EOF into unwritten extents beyond EOF whilst the
incoming extending write requests are still incoming from the
client.

Hence I think that there are common workloads (e.g. large sequential
writes on a NFS client) that set up the exact conditions and IO
patterns necessary to trigger this performance regression in
production systems...

> I ran a quick experiment to skip the flush on sub-4k ranges in favor of
> doing explicit folio zeroing. The idea with that is that the range is
> likely restricted to single folio and since it's dirty, we can assume
> unwritten conversion is imminent and just explicitly zero the range. I
> still see a decent number of flushes from larger ranges in that
> experiment, but that still seems to get things pretty close to my
> baseline test (on a 6.10 distro kernel).

What filesystems other than XFS actually need this iomap bandaid
right now?  If there are none (which I think is the case), then we
should just revert this change it until a more performant fix is
available for XFS.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

