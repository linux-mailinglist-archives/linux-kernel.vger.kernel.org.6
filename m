Return-Path: <linux-kernel+bounces-236309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741E91E044
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209041F235E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB915B96D;
	Mon,  1 Jul 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUZ4Pvql"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB715AD86
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839346; cv=none; b=UXZE4mjKcFlOW6JeQVBrzDKKpGyMkaYeFDZ2Tz4Q8+TfBP4eI3bPWY+ef2yzsdCqHWSy7msy7r/12bhRqTXu5jcljP3gQCmzQoXxRLSSSh/ZAYzwEcptgk1c1HsPSH/S0X0EkUZzfe5pvCokOUOw4SvDKesIHx1krIEJzBM6mBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839346; c=relaxed/simple;
	bh=AKOtvwBE+iAb1YgrZ9LxJ7T3pHNxgFd6TqsDNeKoAAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te7bMdpEJyGvY/Mugo1YMztSXmXP4xUnUy0QoVeAKowSwlwx+CDY61soaxN4T7TcOcBcW2qqU8pQs/pG273gY4J+2q7nhTfrpF8zXgewbr4fpdKER0XXze+v1mVF3k79inY4ly1p4hq0LKAIjmuhMjlPpyXsUxUhFFRnY8G4Fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUZ4Pvql; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719839344;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=HDghtGgi9SYDQpIXIitUpG8W1XNWFlatyKAnpi2QbPA=;
	b=jUZ4Pvqltl2xQjqPiB4xpcjvJrjQuYdTwDGK5IFvuiwoslOIJSXwkn8PaMPpWZM4Fp0BPp
	gfoxqu4ixASzFajwr4iHqbl7FLHix7xVYQT8FAhKY4mWqjXg9YzXVnIA5bWbCQ0qcjma9q
	sVzmaxsQVMPYa/X1cfYThoKq3h3oxjg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-y6oZN0DaMpK2Pn4NV72BXA-1; Mon,
 01 Jul 2024 09:09:00 -0400
X-MC-Unique: y6oZN0DaMpK2Pn4NV72BXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 684571944DDB;
	Mon,  1 Jul 2024 13:08:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7C01956089;
	Mon,  1 Jul 2024 13:08:54 +0000 (UTC)
Date: Mon, 1 Jul 2024 14:08:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Laurence Oberman <loberman@redhat.com>,
	Jonathan Brassow <jbrassow@redhat.com>,
	Ming Lei <minlei@redhat.com>, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, users@lists.libvirt.org
Subject: Re: dm-crypt performance regression due to workqueue changes
Message-ID: <ZoKqYg7TKiozapmW@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
 <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
 <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Sun, Jun 30, 2024 at 08:49:48PM +0200, Mikulas Patocka wrote:
> 
> 
> On Sun, 30 Jun 2024, Tejun Heo wrote:
> 
> > Hello,
> > 
> > On Sat, Jun 29, 2024 at 08:15:56PM +0200, Mikulas Patocka wrote:
> > 
> > > With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
> > > 
> > > The reason is that virt-manager by default sets up a topology where we 
> > > have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue 
> > > patch avoids moving work items across sockets, so it processes all 
> > > encryption work only on one virtual CPU.
>
> > > The performance degradation may be fixed with "echo 'system'
> > > >/sys/module/workqueue/parameters/default_affinity_scope" - but it is 
> > > regression anyway, as many users don't know about this option.
> > > 
> > > How should we fix it? There are several options:
> > > 1. revert back to 'numa' affinity
> > > 2. revert to 'numa' affinity only if we are in a virtual machine
> > > 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
> > > 4. any other solution?
> > 
> > Do you happen to know why libvirt is doing that? There are many other
> > implications to configuring the system that way and I don't think we want to
> > design kernel behaviors to suit topology information fed to VMs which can be
> > arbitrary.
> > 
> > Thanks.
> 
> I don't know why. I added users@lists.libvirt.org to the CC.
> 
> How should libvirt properly advertise "we have 16 threads that are 
> dynamically scheduled by the host kernel, so the latencies between them 
> are changing and unpredictable"?

NB, libvirt is just control plane, the actual virtual hardware exposed
is implemented across QEMU and the KVM kernel mod. Guest CPU topology
and/or NUMA cost information is the responsibility of QEMU.

When QEMU's virtual CPUs are floating freely across host CPUs there's
no perfect answer. The host admin needs to make a tradeoff in their
configuration

They can optimize for density, by allowing guest CPUs to float freely
and allow CPU overcommit against host CPUs, and the guest CPU topology
is essentially a lie.

They can optimize for predictable performance, by strictly pinning
guest CPUs 1:1 to host CPUs, and minimize CPU overcommit, and have
the guest CPU topology 1:1 match the host CPU topology.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


