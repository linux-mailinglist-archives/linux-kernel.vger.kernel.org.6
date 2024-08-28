Return-Path: <linux-kernel+bounces-305309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57545962CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A4B2877E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38151A4F02;
	Wed, 28 Aug 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="bEcO7Uxx"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42B1A4B82
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859843; cv=none; b=QY8pCbn3haNLnMXY1tbVy6QB/+ARRYN0hvtGWAuGZFP2DKDUSRG5C7RENgIo9RHZwoI4GgvKoJafDokG+Sn/TzAYXy8rCfKmRYjft7dX8lg3qP1D77y3tH44VOhVNDNKAMAvg0lH+pKId0sqNisrRUdJxKrok9FQuGM5swPzgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859843; c=relaxed/simple;
	bh=FHYVY+k7BssHtfBfIYbDq+uSTsGT0+DH65PfsZIPS2I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZKFMQabr1QenWaKaoy5Ex0jY7VCOF4tPoAGEDl4nrct69soxmg/H8ck6DGf6RoPSdPbGc7esFH0RrBGy4t5DO6m6NwvAKHfabDRbS6Mt7RDdtzIBg7rruIKL7WBqeQjix9vxP0vXby+MFdK/qwzm37D2MlEb0bJQuKxNPSXASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=bEcO7Uxx; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724859835;
	bh=FHYVY+k7BssHtfBfIYbDq+uSTsGT0+DH65PfsZIPS2I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bEcO7Uxx1CMcFxUAXHbV9TEQzQDfq2Dxi6iwfi4T2n+wSU3+q2glpG+5Fw9sYnI6q
	 Lv3XqiuGtcHnLzRKTD7aQG0u8mO6czpZm+KA61v1JztZQd5cdIAin0C/4vwJOYZURO
	 BakTh/rpqI2GCkQhjBOu0qceS74O1pNAbfMYPFWE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 8084B404BD; Wed, 28 Aug 2024 08:43:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7F76C404BA;
	Wed, 28 Aug 2024 08:43:55 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:43:55 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, ssengar@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
In-Reply-To: <20240828053737.GA22322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Message-ID: <8dcf25e3-1acd-f629-cea0-bfeebf06e7a5@gentwo.org>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com> <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org> <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net> <5a18105c-8e6f-39fa-370f-2d839d9ab843@gentwo.org>
 <20240828053737.GA22322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Saurabh Singh Sengar wrote:

> Thank you for your review. I would like to gain a better understanding of how
> to measure contention. Could you please inform me if there is any recommended
> method for doing so?
>
> In my testing, this patch has resulted in a significant improvement in boot time.

Good.

There was the question by Andrew as to what happens if the
threshold is not initialized. I have no specific benchmarks to measure the
effect.

> > What may be more promising is to make it possible to calculate the
> > threshholds per cpu instead of recalculating the thresholds for every zone
> > again and again.
>
> I am happy to explore alternatives, can you please share more details around
> this approach. Are you referring to avoiding the repetition of the calculation
> below?
>
> mem = zone_managed_pages(zone) >> (27 - PAGE_SHIFT);

The thresholds vary per the zone setup in a NUMA node. So one approach
would be to calculate  these values for each new NODE once and only
update them when memory is brought online or offlines.

Then the parameters for each per cpu pcp could be set from the per NODE /
zone information when a cpu is brought up. The overhead would be minimal
and there would not be a need for the loops.

My company has similar amounts of cpus and it would be great to have a
clean solution here.


