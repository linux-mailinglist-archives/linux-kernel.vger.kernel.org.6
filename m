Return-Path: <linux-kernel+bounces-245169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892692AF36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88BC1F223CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7512CDB6;
	Tue,  9 Jul 2024 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PK4rekXG"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA63F8F7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501078; cv=none; b=KRdoLfVsaOA8iNuLSNQwOOAYbx1NMOFFmOgd72xhhug3cxWSNceozDV+d0HqhoyTlF9Z7ayxhRPMPLK8gCqb6p45YxrgYLdi3YYDZdXSmjucfUT/awkUxt//AIcx0Sco4tpuTwoc8bjrCASbI401UqyItjPEoUII6H0fZH0y75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501078; c=relaxed/simple;
	bh=wn3dp0gXg6ndpP5LiLFqgRvJUOywl1xD/Gx2ll2syyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXbNl2TbFyrLdcUFwmSh/kIb/4MdGoxKlxoU4UhcKjtm0KvnhHQ9DUKBsZvV+zOy5IcZnmh+RMuZ1L7op53GdT1L7KHSrlX9cp9kmEA3ON7zvGsRVwE3SA6BAKIm3FIdr3E8iByhlkgq1rWtY1z0kcz8e3Ci1y1xvjrCdHbfUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PK4rekXG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 8972E20B7165; Mon,  8 Jul 2024 21:57:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8972E20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720501070;
	bh=DYB+5c7dR2RtFbylwSCFyX/WQFMuYrmuD6DA/31T/pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK4rekXG71/2Ylo70/z08bazi5PzlA9lHMnlpNc4/H/IKRWG9Qq+luTUxkPAQnzZe
	 4HdKCGEuZv45fEOFJE/x0+x4nalq0BA6MMnNcM49l/ZvIGBEk+SGgQGSVhDPxVgCKY
	 IWP7DsWymT3PeGptE3K3B/7kaDMOeRa/EGMzqGXE=
Date: Mon, 8 Jul 2024 21:57:50 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-ID: <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
 <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 05, 2024 at 01:59:11PM -0700, Andrew Morton wrote:
> On Fri,  5 Jul 2024 01:48:21 -0700 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:
> 
> > refresh_zone_stat_thresholds function has two loops which is expensive for
> > higher number of CPUs and NUMA nodes.
> > 
> > Below is the rough estimation of total iterations done by these loops
> > based on number of NUMA and CPUs.
> > 
> > Total number of iterations: nCPU * 2 * Numa * mCPU
> > Where:
> >  nCPU = total number of CPUs
> >  Numa = total number of NUMA nodes
> >  mCPU = mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> > 
> > For the system under test with 16 NUMA nodes and 1024 CPUs, this
> > results in a substantial increase in the number of loop iterations
> > during boot-up when NUMA is enabled:
> > 
> > No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> > takes around 224 ms total for all the CPUs in the system under test.
> > 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> > takes around 4.5 seconds total for all the CPUs in the system under test.
> 
> Did you measure the overall before-and-after times?  IOW, how much of
> that 4.5s do we reclaim?

This entire gain is accounted in over all boot processi time. Most of the Linux
kernel boot process is sequential and doesn't take advantage of SMP.

> 
> > Calling this for each CPU is expensive when there are large number
> > of CPUs along with multiple NUMAs. Fix this by deferring
> > refresh_zone_stat_thresholds to be called later at once when all the
> > secondary CPUs are up. Also, register the DYN hooks to keep the
> > existing hotplug functionality intact.
> > 
> 
> Seems risky - we'll now have online CPUs which have unintialized data,
> yes?  What assurance do we have that this data won't be accessed?

I understand that this data is only accessed by userspace tools, and they can
only access it post late_initcall. Please let me know if there are any other
cases, I will look to address them.

> 
> Another approach might be to make the code a bit smarter - instead of
> calculating thresholds for the whole world, we make incremental changes
> to the existing thresholds on behalf of the new resource which just
> became available?

I agree, and I have spent good amount of time undertanding the calculation,
but couldn't find any obvious way to code everything it does in incremental way.

I would be happy to assist if you have any suggestions how to do this.

- Saurabh

