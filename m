Return-Path: <linux-kernel+bounces-282558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D494E5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D231C21437
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179A149C42;
	Mon, 12 Aug 2024 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GQAQP51j"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E226F06B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437481; cv=none; b=IxFTngffqUzA16FghOoTEym/A+oHhHX/C1JY4WD3pFM24uIqQaFWdxtivK0XdY13MsK6mAoKgMhB4EVcZ657HDFO+2xYFxCBobdkj0unw4nTDcidebjP7LBMGTmOrRej2UTr6QbaXTQNg5DIY2UE8zA4LkfnUY5VQ/zxRSmrg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437481; c=relaxed/simple;
	bh=1/ihCKw3BEHigRzXsJWs0Kx2Np1fvayADR11OHoc7yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRSYGI8K2/ikXHcK/kOB7Kjd+x+40s/FEXP3YyKokOwPSXkzJPV4wdmceAJTJysdmvV5QXngFIyLNyH5svWb133JAaWQGy0iTvTRW2Ye3KaMEWkJXcW5tyxRgPqGQ17FqBU16zpAh2y6lctcn//4fIof5pR2QD/PdEUMDWjIRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GQAQP51j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 91D3920B7165; Sun, 11 Aug 2024 21:37:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91D3920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723437474;
	bh=DCVsmLc/y5IKUr9kjksb3wZsyvxdPdU6UCqCMlrYuxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQAQP51jzsSrUS00Io0tPvi/0Eu0iA5FpsPmMtqDGZpQ3I1RxYjbrTop54aIgagJw
	 hQkt82qGJbneauj6jmtDNcfB6Zf95bdVr8ym6qtg9EhNkwi++hZkxGNciS91k5GvG4
	 f2xS3gSwzEZnHTTLGhNcEZnk1jm3wsKJ0W0bLV6M=
Date: Sun, 11 Aug 2024 21:37:54 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-ID: <20240812043754.GA7619@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
 <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
 <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240810000404.b08cb06ebbba7e0de9bb8c72@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810000404.b08cb06ebbba7e0de9bb8c72@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 10, 2024 at 12:04:04AM -0700, Andrew Morton wrote:
> On Mon, 8 Jul 2024 21:57:50 -0700 Saurabh Singh Sengar <ssengar@linux.microsoft.com> wrote:
> 
> > > > No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> > > > takes around 224 ms total for all the CPUs in the system under test.
> > > > 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> > > > takes around 4.5 seconds total for all the CPUs in the system under test.
> > > 
> > > Did you measure the overall before-and-after times?  IOW, how much of
> > > that 4.5s do we reclaim?
> > 
> > This entire gain is accounted in over all boot processi time. Most of the Linux
> > kernel boot process is sequential and doesn't take advantage of SMP.
> 
> Again, if you were able to measure 4.5s without the patch then you are
> able to measure how long this delay is with the patch.  Please share
> that number.

If I understand your question correctly, you're asking about the total time taken by
refresh_zone_stat_threshold for all its executions before and after the fix.

Without this patch, refresh_zone_stat_threshold was being called 1024 times.
After applying the patch, it is called only once, which is same as the last
iteration of the earlier 1024 calls. Further testing with this patch, I observed
a 4.5-second improvement in the overall boot timing due to this fix, which is
same as the total time taken by refresh_zone_stat_thresholds without thie patch,
leading me to reasonably conclude that refresh_zone_stat_threshold now takes a
negligible amount of time (likely just a few milliseconds). If you would like
precise timing details on single refresh_zone_stat_threshold execution, please
let me know, and I can conduct the tests again and provide the results in few days.

- Saurabh

