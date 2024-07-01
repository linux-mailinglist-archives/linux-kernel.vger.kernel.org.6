Return-Path: <linux-kernel+bounces-236373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B489191E147
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B93E1F24336
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B615ECFA;
	Mon,  1 Jul 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RU4zWI+V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AB15B542
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841955; cv=none; b=rl5sC1QYy+h3CCz54RwVcsTjcPHlebb5CE7g+XD/5qChLzVMn/kjO77OLtBj5WTciti2tIRz4ZzlZqEjWARAX6WwqNwykdQbirGDBN6WL51I8zq1cy9nJ/IDUkrtd/o5B9hKPimucujFDlqjskHBfk+hXzpWMS/XOJ7zfQxWppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841955; c=relaxed/simple;
	bh=fQuVbcfepCBPcjWz1qR5Q0Co13YLEIkiBggEBvLmaiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i49B9xquezUKJjaIfPqnotqprrB9IH7T24cilti9F0gudlGx1vi6IUquv+2SYmz4JoLc+Mf2a8IXw/GBXMongyKk64KuLDzc2eU09iBS8qVQt1znlDs3ZLset+wy14XPwWzAsKYfhSWGTSj2yqNs13NndsSz5nbxMFOYslBKpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RU4zWI+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719841952;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4F3lH+ReQNo4WY9zXX7OuALuxOcU2yXfUaanHhrEeY=;
	b=RU4zWI+V3bBfuHWqVF41U11FEuVbDZ6NjqPYdJ1X0DP1M1Cyuv2G4cRuyZw5LobLBfXCzu
	pX4iEbLfMzlh4P2j8mtKjqO4XfTqVM7HR0KQZli2JFxSNVjCucyd7+KmYdkIYbfSIygyCu
	UPimIrTG25Y/xeZnEKJMopt/rWBoNcg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-9c1miWGYMrG3vbKrh-HmlQ-1; Mon,
 01 Jul 2024 09:52:28 -0400
X-MC-Unique: 9c1miWGYMrG3vbKrh-HmlQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F7E319560B0;
	Mon,  1 Jul 2024 13:52:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A36F219560AD;
	Mon,  1 Jul 2024 13:52:22 +0000 (UTC)
Date: Mon, 1 Jul 2024 14:52:19 +0100
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
Message-ID: <ZoK0kwzis1iWVyLr@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
 <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
 <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
 <ZoKqYg7TKiozapmW@redhat.com>
 <e52c5a40-8ca9-38ae-1595-3785c6ac435@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e52c5a40-8ca9-38ae-1595-3785c6ac435@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jul 01, 2024 at 03:42:29PM +0200, Mikulas Patocka wrote:
> 
> 
> On Mon, 1 Jul 2024, Daniel P. Berrangé wrote:
> 
> > On Sun, Jun 30, 2024 at 08:49:48PM +0200, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Sun, 30 Jun 2024, Tejun Heo wrote:
> > > 
> > > > Do you happen to know why libvirt is doing that? There are many other
> > > > implications to configuring the system that way and I don't think we want to
> > > > design kernel behaviors to suit topology information fed to VMs which can be
> > > > arbitrary.
> > > > 
> > > > Thanks.
> > > 
> > > I don't know why. I added users@lists.libvirt.org to the CC.
> > > 
> > > How should libvirt properly advertise "we have 16 threads that are 
> > > dynamically scheduled by the host kernel, so the latencies between them 
> > > are changing and unpredictable"?
> > 
> > NB, libvirt is just control plane, the actual virtual hardware exposed
> > is implemented across QEMU and the KVM kernel mod. Guest CPU topology
> > and/or NUMA cost information is the responsibility of QEMU.
> > 
> > When QEMU's virtual CPUs are floating freely across host CPUs there's
> > no perfect answer. The host admin needs to make a tradeoff in their
> > configuration
> > 
> > They can optimize for density, by allowing guest CPUs to float freely
> > and allow CPU overcommit against host CPUs, and the guest CPU topology
> > is essentially a lie.
> > 
> > They can optimize for predictable performance, by strictly pinning
> > guest CPUs 1:1 to host CPUs, and minimize CPU overcommit, and have
> > the guest CPU topology 1:1 match the host CPU topology.
> 
> The problem that we have here is that the commit 
> 63c5484e74952f60f5810256bd69814d167b8d22 ("workqueue: Add multiple 
> affinity scopes and interface to select them") changes the behavior of 
> unbound workqueues, so that work items are only executed on CPUs that 
> share last level cache with the task that submitted them.
> 
> If there are 16 virtual CPUs that are freely floating across physical 
> CPUs, virt-manager by default selects a topology where it advertises 16 
> sockets, 1 CPU per socket, 1 thread per CPU. The result is that the 
> unbound workqueues are no longer unbound, they can't move work across 
> sockets and they are bound to just one virtual CPU, causing dm-crypt 
> performance degradation. (the crypto operations are no longer 
> parallelized).
> 
> Whose bug is this? Is it a bug in virt-manager because it advertises 
> invalid topology? Is this a bug in that patch 63c5484e7495 because it 
> avoids moving work items across sockets?

It is hard to call it is a bug in anything. The Linux patch is reasonable
in honouring the CPU topology. The hypervisor is reasonable to exposing
sockets=N,cores=1 as there's no right answer for the topology choice, and
it has no idea how it may or may not impact guest OS behaviour or perf.
Letting CPUs float freely is sensible default behaviour too. All of them
conspire to have a perf impact here, but the deployment is not seeking
to maximise performance, rather to maximise flexibility & density.

None the less, I'd suggest that virt-manager should be a explicitly
asking for sockets=1,cores=N, as that has broader guest OS compatibility.
By chance that would also help this scenario, but that woudn't be a
driving factor as we can't pick defaults based on the needs of particular
versions of a particular guest kernel.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


