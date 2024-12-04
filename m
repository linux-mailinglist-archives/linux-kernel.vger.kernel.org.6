Return-Path: <linux-kernel+bounces-430522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E991E9E3216
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F8C167FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A614A4FF;
	Wed,  4 Dec 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWJ3vB/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36F2745E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282865; cv=none; b=lcHkA5KaWGLOO++9tYmCJktgRbP3/yrjchbQs0ORp8XMtYaEs7ICmuQ/9C2SdaQkksEjEd9awDhw/PJuQZku5v5NCDEQeJ2yEbBZawisRrDOVH2rMO9qCfeo3fJoCBebpESXdqYS7RrEYjTUt+HRIdLKqfPc1LGnRQxYu4IUc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282865; c=relaxed/simple;
	bh=X3AwAac/lMVFSBInqbjX0ssHyFnJ9FpZcjFliqWPgww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkbcmxKMSSTEYuapRCp8sHZB5h942haM45aL6gsobFiZoR3WC7Udbb2ixmBn8UrAl78md0lpuVFvG1+TbF6HH8fmQTPrc7wsrwPhhhjLeQr/R/43aJmHqgC4Q9BF0VdUDU6XJ5ptPrFRMzCuqdJV8u9rTKiL2sZMUKhrU48fPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWJ3vB/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733282861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVDX23kxpqYyfSj/9nweVblH8nDmt/DkHCei6BFv/L4=;
	b=CWJ3vB/mmGlW8eSyPu/0Htww3d9PJOUgOJxq6mFHmwmZqFS68IwiiNO3en6vlwob93j9i1
	s0Beli2ZPqxhbMGG7oLOa6ppBLWCdxIG93k4j3hupL7GLxrQJ2tkLf/Fefg807MxQvG05h
	Cz/+Gpe1LbQ7af6YF2uNjfGlI7m7/Q0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-f_RUcPGcN1OWKwpdDmQbbQ-1; Tue,
 03 Dec 2024 22:27:37 -0500
X-MC-Unique: f_RUcPGcN1OWKwpdDmQbbQ-1
X-Mimecast-MFC-AGG-ID: f_RUcPGcN1OWKwpdDmQbbQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C4A1956095;
	Wed,  4 Dec 2024 03:27:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33491956052;
	Wed,  4 Dec 2024 03:27:29 +0000 (UTC)
Date: Wed, 4 Dec 2024 11:27:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: resctrl mount fail on v6.13-rc1
Message-ID: <Z0_MHEoSNdiQvXNK@fedora>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
 <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
 <542a0c87-935a-4b39-8210-22a7d46de6e5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542a0c87-935a-4b39-8210-22a7d46de6e5@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 02, 2024 at 09:02:45PM -0800, Reinette Chatre wrote:
> 
> 
> On 12/2/24 8:54 PM, Reinette Chatre wrote:
> > 
> > 
> > On 12/2/24 6:47 PM, Luck, Tony wrote:
> >> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
> >>> Hi Tony,
> >>>
> >>> On 12/2/24 1:42 PM, Luck, Tony wrote:
> >>>> Anyone better a decoding lockdep dumps then me make sense of this?
> >>>>
> >>>> All I did was build v6.13-rc1 with (among others)
> >>>>
> >>>> CONFIG_PROVE_LOCKING=y
> >>>> CONFIG_PROVE_RAW_LOCK_NESTING=y
> >>>> CONFIG_PROVE_RCU=y
> >>>>
> >>>> and then mount the resctrl filesystem:
> >>>>
> >>>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> >>>>
> >>>> There are only trivial changes to the resctrl code between
> >>>> v6.12 (which works) and v6.13-rc1:
> >>>>
> >>>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
> >>>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >>>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
> >>>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
> >>>>
> >>>> So something in kernfs? Or the way resctrl uses kernfs?
> >>>
> >>> I am not seeing this but that may be because I am not testing with
> >>> selinux enabled. My test kernel has:
> >>> # CONFIG_SECURITY_SELINUX is not set
> >>>
> >>> I am also not running with any btrfs filesystems. 
> >>>
> >>> Is this your usual setup in which you are seeing this the first time? Is it
> >>> perhaps possible for you to bisect?
> >>
> >> Bisection says:
> >>
> >> $ git bisect bad
> >> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> >> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> >> Author: Ming Lei <ming.lei@redhat.com>
> >> Date:   Fri Oct 25 08:37:20 2024 +0800
> >>
> >>     block: model freeze & enter queue as lock for supporting lockdep
> >>
> > 
> > Thank you very much Tony. Since you did not respond to the question about
> > bisect I assumed that you would not do it. I ended up duplicating the bisect
> > effort after getting an environment in which I can reproduce the issue. Doing so
> > I am able to confirm the commit pointed to by bisect. 
> > The commit cannot be reverted cleanly so I could not test v6.13-rc1 with it
> > reverted.
> > 
Gi> > Ming Lei: I'd be happy to help with testing if you do not have hardware with
> > which you can reproduce the issue.
> 
> One datapoint that I neglected to mention: btrfs does not seem to be required. The system
> I tested on used ext4 filesystem resulting in trace below:

Hi Reinette and Tony,

The warning is triggered because the two subsystems are connected with
&cpu_hotplug_lock.

rdt_get_tree():
	cpus_read_lock();
    mutex_lock(&rdtgroup_mutex);
	...

blk_mq_realloc_hw_ctxs()
	mutex_lock(&q->sysfs_lock);
	...
	blk_mq_alloc_and_init_hctx()
		blk_mq_init_hctx
			cpuhp_state_add_instance_nocalls
				__cpuhp_state_add_instance
					cpus_read_lock();

Given cpus_read_lock() is often implied in cpuhp APIs, I feel rdt_get_tree()
may re-order the two locks for avoiding the dependency.


Thanks,
Ming


