Return-Path: <linux-kernel+bounces-242888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E23928E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BC1F25784
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A4145B12;
	Fri,  5 Jul 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cX2laUmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC814533C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213153; cv=none; b=pu/EfoPb9aXlHoK0SV4JkKU7qUUxY8cxVd4+F5PhgakS8HTdofw7KbelpJx9sqK3KqLk7B2oSWVPhw1yxOCGDub9SIe/LxdfrGxKAHcfBIvSDLld1gPutpVtxUNWaOk+0i5JKPkOJw/TAis19xTp55/lPOxrv4RPr5cOzgyrAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213153; c=relaxed/simple;
	bh=0grfUY/O+w2jvNUQdMGCDfoJk9yIgsZwGnLPHBTNo3Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BhmN9c0UjcTMz57ASRcaLB767JTX1pzR6cstCfCIPkT34GHO6+8ixVsVfvnpQyYe2YK1YHj0Vg+Gr1Fsv1S8UyJb6WN0G5n+AmKQgqlasRDyCgUa6T0J/QR26u52dHs0teebfQdkQ5L62YWMwoUVgR5YIC2z4mEY7KrUNbpbpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cX2laUmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B7FC116B1;
	Fri,  5 Jul 2024 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720213152;
	bh=0grfUY/O+w2jvNUQdMGCDfoJk9yIgsZwGnLPHBTNo3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cX2laUmqC9LHOCBPtEyNj+HX7bYu9jugElfXAppLd8JVmdk9bnrIIVsQIi/sKN32g
	 9VFOSfJX+DytaVJXmh8pK5NLkd1By7T9S8WIYcQti69H/CiMmXlnVBcCfRHMP0PEXr
	 ldxLBs2iqAKZWN2pdN16McvfYSONf4lHtoEubv5Q=
Date: Fri, 5 Jul 2024 13:59:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-Id: <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org>
In-Reply-To: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 01:48:21 -0700 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:

> refresh_zone_stat_thresholds function has two loops which is expensive for
> higher number of CPUs and NUMA nodes.
> 
> Below is the rough estimation of total iterations done by these loops
> based on number of NUMA and CPUs.
> 
> Total number of iterations: nCPU * 2 * Numa * mCPU
> Where:
>  nCPU = total number of CPUs
>  Numa = total number of NUMA nodes
>  mCPU = mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> 
> For the system under test with 16 NUMA nodes and 1024 CPUs, this
> results in a substantial increase in the number of loop iterations
> during boot-up when NUMA is enabled:
> 
> No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> takes around 224 ms total for all the CPUs in the system under test.
> 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> takes around 4.5 seconds total for all the CPUs in the system under test.

Did you measure the overall before-and-after times?  IOW, how much of
that 4.5s do we reclaim?

> Calling this for each CPU is expensive when there are large number
> of CPUs along with multiple NUMAs. Fix this by deferring
> refresh_zone_stat_thresholds to be called later at once when all the
> secondary CPUs are up. Also, register the DYN hooks to keep the
> existing hotplug functionality intact.
> 

Seems risky - we'll now have online CPUs which have unintialized data,
yes?  What assurance do we have that this data won't be accessed?

Another approach might be to make the code a bit smarter - instead of
calculating thresholds for the whole world, we make incremental changes
to the existing thresholds on behalf of the new resource which just
became available?


