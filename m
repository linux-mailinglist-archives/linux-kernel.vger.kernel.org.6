Return-Path: <linux-kernel+bounces-432875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7A19E5152
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA111640AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C21D3566;
	Thu,  5 Dec 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxQKoG86"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BE18E028
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390973; cv=none; b=DJxpU0R0KlXgTy8L5Wn6JN5gL/l8BTwKkOp7wy0kA4prXD0yvZLp+mqGO80flf/o2lTgB8/ais8DvedZ3eFUuctvjVq3FzZtB9FW8EsYOLv5cOMucsc2vVXo6b+TUjt1uHyRtwkq9QnMIuYYHEG02rOXvHfLLPfLbX2+OI9qy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390973; c=relaxed/simple;
	bh=/d8DXBAOtnn+OLJZSSBLDnfwfD79hhythMRdp+dWoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swvCcquu/jdJICNykzzJmHmi+Focr34WIfqRZhbG0MjCPcEzD4YRuRNv1ZdaJsjE/LwBPYYpbS8sPtNa3J+SApZoHv/PXiA3yRemtyDJgTEemKpuR98CT/Tk2lD2UfR1/LC4+EmXQps0NUHyFDdXkAvaMBPx132T/6TROQg7+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxQKoG86; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733390970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nD0fL9mfgvNn6M15PEytrZ+HfCY+plMFNeRxzCSq1x8=;
	b=TxQKoG86U5e34R7oEZcsyPVRLl3jfJLm1lyPBjEmATl3tRftqLDjZ42nHU2LET1IGY6DE1
	l3hwM8j3WAhy6DNATZmlyvynB+6166x6CFzKuGnkybjVTMWXfHnjkzB9l5aIMd+kYGCBtW
	abTkP4Yu+LezlWKfmEoubbZC7u7Xfrs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-ql6JYojoNYKZlxA9eo-AVA-1; Thu,
 05 Dec 2024 04:29:27 -0500
X-MC-Unique: ql6JYojoNYKZlxA9eo-AVA-1
X-Mimecast-MFC-AGG-ID: ql6JYojoNYKZlxA9eo-AVA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5175F195605E;
	Thu,  5 Dec 2024 09:29:25 +0000 (UTC)
Received: from fedora (unknown [10.72.112.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C814619560A2;
	Thu,  5 Dec 2024 09:29:19 +0000 (UTC)
Date: Thu, 5 Dec 2024 17:29:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: resctrl mount fail on v6.13-rc1
Message-ID: <Z1FyabRPB2UrR3UA@fedora>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
 <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
 <542a0c87-935a-4b39-8210-22a7d46de6e5@intel.com>
 <Z0_MHEoSNdiQvXNK@fedora>
 <95e33677-66e7-458d-937d-e1b5842666d3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e33677-66e7-458d-937d-e1b5842666d3@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 04, 2024 at 08:48:14AM -0800, Reinette Chatre wrote:
> Hi Ming,
> 
> On 12/3/24 7:27 PM, Ming Lei wrote:
> > On Mon, Dec 02, 2024 at 09:02:45PM -0800, Reinette Chatre wrote:
> >>
> >>
> >> On 12/2/24 8:54 PM, Reinette Chatre wrote:
> >>>
> >>>
> >>> On 12/2/24 6:47 PM, Luck, Tony wrote:
> >>>> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
> >>>>> Hi Tony,
> >>>>>
> >>>>> On 12/2/24 1:42 PM, Luck, Tony wrote:
> >>>>>> Anyone better a decoding lockdep dumps then me make sense of this?
> >>>>>>
> >>>>>> All I did was build v6.13-rc1 with (among others)
> >>>>>>
> >>>>>> CONFIG_PROVE_LOCKING=y
> >>>>>> CONFIG_PROVE_RAW_LOCK_NESTING=y
> >>>>>> CONFIG_PROVE_RCU=y
> >>>>>>
> >>>>>> and then mount the resctrl filesystem:
> >>>>>>
> >>>>>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> >>>>>>
> >>>>>> There are only trivial changes to the resctrl code between
> >>>>>> v6.12 (which works) and v6.13-rc1:
> >>>>>>
> >>>>>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
> >>>>>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >>>>>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
> >>>>>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
> >>>>>>
> >>>>>> So something in kernfs? Or the way resctrl uses kernfs?
> >>>>>
> >>>>> I am not seeing this but that may be because I am not testing with
> >>>>> selinux enabled. My test kernel has:
> >>>>> # CONFIG_SECURITY_SELINUX is not set
> >>>>>
> >>>>> I am also not running with any btrfs filesystems. 
> >>>>>
> >>>>> Is this your usual setup in which you are seeing this the first time? Is it
> >>>>> perhaps possible for you to bisect?
> >>>>
> >>>> Bisection says:
> >>>>
> >>>> $ git bisect bad
> >>>> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> >>>> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> >>>> Author: Ming Lei <ming.lei@redhat.com>
> >>>> Date:   Fri Oct 25 08:37:20 2024 +0800
> >>>>
> >>>>     block: model freeze & enter queue as lock for supporting lockdep
> >>>>
> >>>
> >>> Thank you very much Tony. Since you did not respond to the question about
> >>> bisect I assumed that you would not do it. I ended up duplicating the bisect
> >>> effort after getting an environment in which I can reproduce the issue. Doing so
> >>> I am able to confirm the commit pointed to by bisect. 
> >>> The commit cannot be reverted cleanly so I could not test v6.13-rc1 with it
> >>> reverted.
> >>>
> > Gi> > Ming Lei: I'd be happy to help with testing if you do not have hardware with
> >>> which you can reproduce the issue.
> >>
> >> One datapoint that I neglected to mention: btrfs does not seem to be required. The system
> >> I tested on used ext4 filesystem resulting in trace below:
> > 
> > Hi Reinette and Tony,
> > 
> > The warning is triggered because the two subsystems are connected with
> > &cpu_hotplug_lock.
> > 
> > rdt_get_tree():
> > 	cpus_read_lock();
> >     mutex_lock(&rdtgroup_mutex);
> > 	...
> > 
> > blk_mq_realloc_hw_ctxs()
> > 	mutex_lock(&q->sysfs_lock);
> > 	...
> > 	blk_mq_alloc_and_init_hctx()
> > 		blk_mq_init_hctx
> > 			cpuhp_state_add_instance_nocalls
> > 				__cpuhp_state_add_instance
> > 					cpus_read_lock();
> > 
> > Given cpus_read_lock() is often implied in cpuhp APIs, I feel rdt_get_tree()
> > may re-order the two locks for avoiding the dependency.
> 
> This is not possible for exactly the reason you provide ("cpus_read_lock() is
> often implied in cpuhp APIs").
> 
> resctrl relies on hotplug state callbacks for its initialization. You can find
> the callback setup in:
> 
> arch/x86/kernel/cpu/resctrl/core.c:
> 
> static int __init resctrl_late_init(void)
> {
> 
> 	...
> 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> 				  "x86/resctrl/cat:online:",
> 				  resctrl_arch_online_cpu,
> 				  resctrl_arch_offline_cpu);
> 	...
> }
> 
> Since resctrl code is called by the CPU hotplug subsystem with cpu_hotplug_lock
> already held it is not possible for resctrl to change the lock ordering.

OK, I see now, and thanks for the explanation.

I will try to figure out moving cpuhp_state_add_instance_nocalls out of
q->sysfs_lock, and it should be fine in case that queue is live.

Thanks,
Ming


