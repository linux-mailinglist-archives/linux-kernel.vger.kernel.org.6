Return-Path: <linux-kernel+bounces-219857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7042690D8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BCB1F277AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C874070;
	Tue, 18 Jun 2024 16:17:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411144DA0C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727420; cv=none; b=rqPgNo7LOtnDzTy22L3qEn2fecbr1KQXHS+0FQymF179T4RYSv5VX0i7hVs9YLtV/1Uja04A9qV0OfRRR6Ey2JWnAX+O2iuNFIRbFF6wefjhVmLAJ11H8kscfsUlF9jcirZ/7NXYjFVO9ZrVH4nY1jh+N6D8O/AfJstF/euI1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727420; c=relaxed/simple;
	bh=NbxLqfJp0zYtX9blzUoNH7ACgEj2ATU5B/RHkNXhUeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLshWipyKnLAn9uy5qe1+MZfJNi2tGZSTD5KG415iWWyaypE9WjkF1jEIKQpZq9voSIKAY5kbYbJ9M0SjGBy4A3VF5QByfdJz1+P+DgtwalE9PouTuP2jbN+74SexOBZX/Ev/zcQLVIpfeEwYugO9xQyfDWY61WA/vw6RYBPL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287C1DA7;
	Tue, 18 Jun 2024 09:17:22 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8783F6A8;
	Tue, 18 Jun 2024 09:16:54 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:16:48 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, dfustini@baylibre.com,
	amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
Message-ID: <ZnGy8B4FA+q3YkhC@e133380.arm.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
 <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
 <ZnFTnzm/jctgN2wf@e133344.arm.com>
 <d476585b-3cfb-494d-b25c-4aeb6244e21d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d476585b-3cfb-494d-b25c-4aeb6244e21d@intel.com>

Hi Reinette,

On Tue, Jun 18, 2024 at 08:43:51AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 6/18/24 2:30 AM, Dave Martin wrote:
> > On Mon, Jun 17, 2024 at 08:53:38AM -0700, Reinette Chatre wrote:
> > > On 6/17/24 4:55 AM, Dave Martin wrote:
> 
> > > > As it happens I tested with rdt=cmt,mbmtotal,mbmlocal,l3cat,l3cdp
> > > > (though I made no effort to exercise these features other than running
> > > > the selftests).  I can note this in the commit if you prefer.
> > > 
> > > hmmm ... those parameters should not be necessary unless the system
> > > has those features forced off by default because of errata. Doing
> > > functional testing on these systems via such enabling is fine
> > > though.
> > > 
> > > Reinette
> > 
> > I got these kernel args from James.  Apparently some of these features
> > are defaulted to off by the firmware on the box I'm using, but we're not
> > sure why.  I haven't dug into it.
> 
> resctrl does not provide capability to override features that the hardware
> does not advertise as supporting. resctrl does sometimes force hardware
> advertised features off because of errata (for example, see [1]) and the
> kernel "rdt=" parameter can be used to override that. This same option also
> enables administrators to ignore some features on their platforms.
> 
> Reinette
> 
> [1] https://lore.kernel.org/all/3aea0a3bae219062c812668bd9b7b8f1a25003ba.1503512900.git.tony.luck@intel.com/

Possibly the box in question falls under this case.  I'll need to check
with James and/or experiment.

Either way, I don't think this impacts the tested-ness of this patch,
but please shout if you have concerns.

Cheers
---Dave

