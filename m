Return-Path: <linux-kernel+bounces-555263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A842FA5ABDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E708A1736C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96B21B9F4;
	Mon, 10 Mar 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rXX8coVi"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D11DE887
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648518; cv=none; b=ZZtX0lM7l1ddsyZSq8VhKRFxP+aR6L7fuYTjnFPQd6Uj0JykhU789n72znT7nLDN0RQengfelJRiZInWHV097XlEiKh6zN4hQfwwhniWlzi+NfUfn7tudzO5wA4iR8Lew48WHZjWybbK6es++FMMGn8bWl177wpUcoV9/qBhY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648518; c=relaxed/simple;
	bh=Cd0UuvH5M0q2WuXGxxql1FwUsb/gEvEiXmDyq2p9TbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulQ9upTT+cPiGvNp012pqxpd+8Ue8l7y+ctRuer03CL3OxVvCLEQjhtwTmCB/UX7dzAYobu0vHmD/7XtK3wp/ieT0ndOqVIjrNOCKHm0yqs/9bYbVsBrM1Y0U6ouJtbTpaKWMNZb3QovzuXqykYJ0YafZFj6udtXmKpsoGcfN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rXX8coVi; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Mar 2025 16:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741648513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSyhaK44uXfqSD60mKL0gd8Jj+AtWaOdrlf4IgahYzY=;
	b=rXX8coVilFT0hbMU8ZbZ3AzBK5axdSHrjpeK/E2FlZlNykzX/CDkiHQa7EfVQLB2vnG2kh
	z/U74dLDT+N7tOrfqALoE+2B+dHxul/NOghc3IpC5sGuK8K1it2PPxP74socpKJgpviatf
	nZnOtmE6VQllg3Rk+GG1JZm/os+Npt4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, "Liam R. Howlett" <howlett@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and
 MADV_FREE
Message-ID: <mecl3oimrbzeh3o2gaolmpqeyw7f7npme4zhpnzkqohrgxwotq@qssi4idgvftl>
References: <20250310172318.653630-1-sj@kernel.org>
 <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310153921.47d390c637105e3ad6fc49c0@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 10, 2025 at 03:39:21PM -0700, Andrew Morton wrote:
> On Mon, 10 Mar 2025 10:23:09 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> >  It is unclear if such use case
> > is common and the inefficiency is significant. 
> 
> Well, we could conduct a survey,
> 
> Can you add some logging to detect when userspace performs such an
> madvise() call, then run that kernel on some "typical" machines which
> are running "typical" workloads?  That should give us a feeling for how
> often userspace does this, and hence will help us understand the usefulness
> of this patchset.

Just for the clarification, this patchset is very useful for the
process_madvise() and the experiment results show that. I think what SJ
wants to say is specific to madvise() syscall that this change might or
might not be that helpful. It will be helpful if the user application is
madvising regions comprising of multiple vmas. However this patchset is
very very useful for process_madvise().

