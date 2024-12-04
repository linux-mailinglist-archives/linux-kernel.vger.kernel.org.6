Return-Path: <linux-kernel+bounces-430524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBB9E321E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1EA282D87
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67F11465B8;
	Wed,  4 Dec 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBDVUjiC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A52F26
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283071; cv=none; b=s61HOb0eG9cj6D2OeseSyJdHKr/KV2yO3/+EyCI/dXTmNbqhKG3jYEDesAdkyLddQGDLhXNFlparjYTU+Cgdr0u+d2CuT+15DptZtdY4YZDZvePogceuNMHLFGXYPEXnA6XK6tEbTnwwJPrtPJ0+LcyV/tfoZ8+Qp4PRZUCmIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283071; c=relaxed/simple;
	bh=78xKjgzmKccYqk9MN+2ZNSKEy04PeIayLcppN3YuoZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEQS0s3tTtkyvdWxg0wyzH94q8wazSUW/wHEIffGjfEAYL5DmwpFv3sAAg9IdD2VlktCCbm/fl6f3RJz/F1FKezm6/T2uTQtBLVG8vPt97CouVbZmpcbs1T8f5mzWAPysafhJ/BWTXEFXR4V6KuuhbO+ElHM/cd09gMMRXHBEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBDVUjiC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733283068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFVN9L1M5C/3rUxYgdCRn6LmESJ5h77zt+6Lt3J9p9Q=;
	b=QBDVUjiCEOGeO5yD65MFLfzepGR5Ibfg6RlqyVdjTdaUoHKJX+bwcXHq3/ETDGBhZWhiRP
	g00DFmOK3sfRB6ffDRwWjjOFrvtHWwS18YGlpg2ARFWmVXrYD7Lj6v3ph/tphM5gd/rwC3
	nWDEyIYjW5Y4a10T/5qTyJabMQ56mZg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-GdOrHiRDM6K5BbDCZBGbzw-1; Tue,
 03 Dec 2024 22:31:04 -0500
X-MC-Unique: GdOrHiRDM6K5BbDCZBGbzw-1
X-Mimecast-MFC-AGG-ID: GdOrHiRDM6K5BbDCZBGbzw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30479195608C;
	Wed,  4 Dec 2024 03:31:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30AB30000DF;
	Wed,  4 Dec 2024 03:30:53 +0000 (UTC)
Date: Wed, 4 Dec 2024 11:30:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z0_M5_lbObp-EbZW@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0/K0bDHBUWlt0Hl@ly-workstation>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 04, 2024 at 11:21:53AM +0800, Lai, Yi wrote:
> On Wed, Oct 30, 2024 at 07:08:48PM +0800, Ming Lei wrote:
> > On Wed, Oct 30, 2024 at 06:39:13PM +0800, Lai, Yi wrote:
> > > On Wed, Oct 30, 2024 at 05:50:15PM +0800, Ming Lei wrote:
> > > > On Wed, Oct 30, 2024 at 4:51 PM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, Oct 30, 2024 at 03:13:09PM +0800, Ming Lei wrote:
> > > > > > On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> > > > ...
> > > > > >
> > > > > > It should be addressed by the following patch:
> > > > > >
> > > > > > https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/
> > > > > >
> > > > >
> > > > > I have applied proposed fix patch on top of next-20241029. Issue can
> > > > > still be reproduced.
> > > > >
> > > > > It seems the dependency chain is different from Marek's log and mine.
> > > > 
> > > > Can you post the new log since q->q_usage_counter(io)->fs_reclaim from
> > > > blk_mq_init_sched is cut down by the patch?
> > > >
> > > 
> > > New possible deadlock log after patch applied:
> > 
> > This one looks like one real deadlock, any memory allocation with
> > q->sysfs_lock held has such risk.
> > 
> > There is another similar report related with queue sysfs store operation:
> > 
> > https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
> >  
> >
> For v6.13-rc3, there is possible deadlock in
> blk_trace_ioctl/perf_event_ctx_lock_nested/in blk_trace_ioctl. Based on
> my bisection log, it all bisected to your commit f1be1788a32e block:
> model freeze & enter queue as lock for supporting lockdep.
> 
> I am hoping this will be insightful to you.
> 
> possible deadlock in blk_trace_ioctl:
> [   33.317360] ffff88800fc8f3e0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xf1/0x1b0
> [   33.317859]
> [   33.317859] but task is already holding lock:
> [   33.318206] ffff8880109b92e0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_ioctl+0xaa/0x290
> [   33.318722]
> [   33.318722] which lock already depends on the new lock.
> [   33.318722]

The warning has been fixed by the following patches in for-6.14/block:

blktrace: move copy_[to|from]_user() out of ->debugfs_lock
blktrace: don't centralize grabbing q->debugfs_mutex in blk_trace_ioctl

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.14/block


Thanks,
Ming


