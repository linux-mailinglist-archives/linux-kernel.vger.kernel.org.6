Return-Path: <linux-kernel+bounces-241690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B08927DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235DD284FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB9113A3ED;
	Thu,  4 Jul 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWTNjUV3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D02F23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122584; cv=none; b=W8O90BWMHkQ4s2a57vnFPB4zUnvb8VNKsagqpaK/PgkGVAl1iTDIGTckBtWmMzZLsNOPW9HFZE1yl2O+r8hMv1TvHDg3ORJYTUnjIPKnNovGh6a2ozPsKyTAlwxIDP8jVoWcL6PQHtPhLdY0jGiJHfE4CFIl0d7QYMtetMhfN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122584; c=relaxed/simple;
	bh=TfZ3p2zXd8EXIbQZvdGO7Oo1USEJV8UkjxxxDNE5Ap4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfVXJUPH4J4hIHXxpYLIAb13ysvZt5oiNMx+WT/byaAVdgJoy1QYTclxbCw30TX3sgOEXctjQ6Gk2YWacIC47G8O/ryBa/I1cmMrFPOl/XL0l/W7cG6rpm+Ks3z2bn11/FKqEtstBRAEtzZacm15iblis70oRb86YDmX2Di450c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lWTNjUV3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=23UN5iauPHTCS5OpRoEco7H8tb49lnIlqtiELf2idnY=; b=lWTNjUV3Z8NyX6a9ceffRK9Y9v
	TRk1lXW7peMuQNdleWNiDRxHDAcjfsSpv0y+Ukp/xNECrgRKsN+igzgubfSZW1bvmhG07ntg+f9KP
	QjU6JoW++IckVHh86fmXy4xuLIp8TmCh/6QKh7hepr4t19QkcJ0TDEVzSYndNohVSNgXs5bJbuxp8
	czrrfptXFMDrKkP8smQkhCCN8wWWMTrZiE6d01R8ViijzdrTzQvtpVQAVROcMlH/C9UqAU1c+LBSd
	cJwKq17A0pnom7t8K0cdacBg0hOaqBArDJj0MuMQIaNXmWFSlKsJ1YDc+vfazzY9DQi1cP6CNzKqS
	6DgH0QHw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPSSK-00000003Cat-45m7;
	Thu, 04 Jul 2024 19:49:25 +0000
Date: Thu, 4 Jul 2024 20:49:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
	ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
	p.raghav@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Message-ID: <Zob8xI-LWe9H_iJs@casper.infradead.org>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>

On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
> On 04.07.24 21:03, David Hildenbrand wrote:
> > > shmem has two uses:
> > > 
> > >    - MAP_ANONYMOUS | MAP_SHARED (this patch set)
> > >    - tmpfs
> > > 
> > > For the second use case we don't want controls *at all*, we want the
> > > same heiristics used for all other filesystems to apply to tmpfs.
> > 
> > As discussed in the MM meeting, Hugh had a different opinion on that.
> 
> FWIW, I just recalled that I wrote a quick summary:
> 
> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
> 
> I believe the meetings are recorded as well, but never looked at recordings.

That's not what I understood Hugh to mean.  To me, it seemed that Hugh
was expressing an opinion on using shmem as shmem, not as using it as
tmpfs.

If I misunderstood Hugh, well, I still disagree.  We should not have
separate controls for this.  tmpfs is just not that special.

