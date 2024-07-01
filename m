Return-Path: <linux-kernel+bounces-235920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD691DB47
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DF5B26CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0210B84DE9;
	Mon,  1 Jul 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTNl0fyO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61484A5E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825394; cv=none; b=a5UtAjuvGAZqPCP52CDxeJ8r9TUbXkftN+a2WBmrZZRbqXkPyUD4O6Gsg9kCY4u523wT1c3HPRAScFUSwzwSR6oDAQ4XqGg1fKmRTt+/L/ig07GoJaLmatLUnMhodbRYDH4KlLUqsUwA+NrJtg6AXMr5LO2bSZz6yJX/nnHsEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825394; c=relaxed/simple;
	bh=cwp5rplcY8DjZiq1lafOEd2HSNWPSJdoC6cJyocB40Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8e0+RcWixmWLZpNOBc89YoPtd/oqgJae86PR4YviNKR7caELpnylaqGyCNbNChwlNpp9m+SOgwe3y48g4z9I35sy6jNnuNwFmWXpS/8nLbI6mlc5FJ8jkeebInWxzjQlj3hiAZWhJMYfH6iIPE4hfKwqycpFDYdZqBIiXSV2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTNl0fyO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719825391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDqyRdhYnb9M1XMOG4X5CSh/FJ2XKI6Btl8RCyPZq18=;
	b=cTNl0fyOHcEMT7X2y43m8dtIGNFEHBixrPLc+qDdEmWfP1LBMg0IU8VO1TXCTsY3x8iIcC
	mYNt53X9+CSRV1AH8KSPP0/YxO+7qloVBkftCyKXeNbzeWseRkJlvMo7GoxPAkvqI+sFWy
	1kwt37Gt8IhOptrV5aVKNLlXMa8itYI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-NPstdspGOHmTb05q43_i_A-1; Mon,
 01 Jul 2024 05:16:28 -0400
X-MC-Unique: NPstdspGOHmTb05q43_i_A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFCFB19560AD;
	Mon,  1 Jul 2024 09:16:25 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85E941956089;
	Mon,  1 Jul 2024 09:16:16 +0000 (UTC)
Date: Mon, 1 Jul 2024 17:16:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoJz23UJLQ0NKpH4@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
 <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jul 01, 2024 at 10:43:14AM +0200, Hannes Reinecke wrote:
> On 7/1/24 09:21, Ming Lei wrote:
> > On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
> > > On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > > > > Make group_cpus_evenly aware of isolcpus configuration and use the
> > > > > housekeeping CPU mask as base for distributing the available CPUs into
> > > > > groups.
> > > > > 
> > > > > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> > > > 
> > > > isolated CPUs are actually handled when figuring out irq effective mask,
> > > > so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> > > > patch from user viewpoint?
> > > 
> > > IO queues are allocated/spread on the isolated CPUs and if there is an
> > > thread submitting IOs from an isolated CPU it will cause noise on the
> > > isolated CPUs. The question is this a use case you need/want to support?
> > 
> > I have talked RH Openshift team weeks ago and they have such usage.
> > 
> > userspace is free to run any application from isolated CPUs via 'taskset
> > -c' even though 'isolcpus=' is passed from command line.
> > 
> > Kernel can not add such new constraint on userspace.
> > 
> > > We have customers who are complaining that even with isolcpus provided
> > > they still see IO noise on the isolated CPUs.
> > 
> > That is another issue, which has been fixed by the following patch:
> > 
> > a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> > 
> Hmm. Just when I thought I understood the issue ...
> 
> How is this supposed to work, then, given that I/O can be initiated
> from the isolated CPUs?
> I would have accepted that we have two scheduling domains, blk-mq is
> spread across all cpus, and the blk-mq cpusets are arranged according
> to the isolcpu settings.
> Then we can initiate I/O from the isolated cpus, and the scheduler
> would 'magically' ensure that everything is only run on isolated cpus.

blk-mq issues IO either from current context or kblockd context.

> 
> But that patch would completely counteract such a setup, as during
> I/O we more often than not will invoke kblockd, which then would cause
> cross-talk on non-isolated cpus.

If IO is submitted from isolated CPU, blk-mq will issue this IO via
unbound kblockd WQ, which is guaranteed to not run on isolated CPUs.


Thanks,
Ming


