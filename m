Return-Path: <linux-kernel+bounces-177403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381E8C3E12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143471F22733
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE71487E4;
	Mon, 13 May 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODoUV6xi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C371474B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592325; cv=none; b=QWhLBftG9oI8K8spaLf5n1FVK1zbNzcKA29Bb0dnEQ/cuq61BPff0BSZ7xB/HD4pbb74o5nKtLFmgug8Lyb6KXBsMjOuKaeoXhIJly66r2p0qrFMEmkKC7PxKquZlWdXGEZ/5K2j0pNs+IBSU1ctttPThBLjHekNw0kk0Pxs4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592325; c=relaxed/simple;
	bh=521GkDNEQgWD1StlhMUyIOf6nie7v0TB6vArxyvRoto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOKj5VMdzsSIv4BtHvlt00rUHXyWocMdXIq/sVcnOpcTNVjxuWyt+AJw26a+CW1gX0hPf5abcFXStNvzzL+p66NGNwgs/3K4Ou8MifTLwYUQntnjNG3tXUNk0S5tnp45rRtsbn/2aV9ydf4PxYv/UpofkhdpJz5dFGyO8PIVO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODoUV6xi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715592322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eplj5woXuwxNWJmXkAk/duK4v46oSiFrIF6Ysmgfp8I=;
	b=ODoUV6xi5PT7YzJkxT2bIgpfskItjEEUmZ5tF3a7/Qy1KhaAR0Kj/ssC5VR6LsizedBZxV
	x8IlhWYMjLkDvBtEFhtw3Fu/LfGNDAKgEwXgtPgGQT5xVnPqoKuugac9nWCak1GHAvENTD
	KpLLMFYllnw6ZhIff2jYqdnvAb5MDo0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-FrgIOgcqMLiJDZceVrKlDQ-1; Mon, 13 May 2024 05:25:18 -0400
X-MC-Unique: FrgIOgcqMLiJDZceVrKlDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AACB08016FF;
	Mon, 13 May 2024 09:25:17 +0000 (UTC)
Received: from fedora (unknown [10.72.112.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7CFB2026D6E;
	Mon, 13 May 2024 09:25:13 +0000 (UTC)
Date: Mon, 13 May 2024 17:25:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Benjamin Meier <benjamin.meier70@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, kbusch@meta.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkHcde1xeBOiEikg@fedora>
References: <ZkHR1L/cJesDEn60@fedora>
 <0ed958b4-cbc9-4136-9113-e7a43a3f91e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed958b4-cbc9-4136-9113-e7a43a3f91e6@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Mon, May 13, 2024 at 10:59:02AM +0200, Benjamin Meier wrote:
> > > The application which we develop and maintain (in the company I work)
> > > has very high requirements regarding latency. We have some isolated
> cores
> >
> > Are these isolated cores controlled by kernel command line `isolcpus=`?
> 
> Yes, exactly.
> 
> > > and we run our application on those.
> > >
> > > Our system is using kernel 5.4 which unfortunately does not support
> > > "isolcpus=managed_irq". Actually, we did not even know about that
> > > option, because we are focussed on kernel 5.4. It solves part
> > > of our problem, but being able to specify where exactly interrupts
> > > are running is still superior in our opinion.
> > >
> > > E.g. assume the number of house-keeping cores is small, because we
> > > want to have full control over the system. In our case we have threads
> > > of different priorities where some get an exclusive core. Some other
> threads
> > > share a core (or a group of cores) with other threads. Now we are still
> > > happy to assign some interrupts to some of the cores which we consider
> as
> > > "medium-priority". Due to the small number of non-isolated cores, it can
> >
> > So these "medium-priority" cores belong to isolated cpu list, you still
> expect
> > NVMe interrupts can be handled on these cpu cores, do I understand
> correctly?
> 
> We want to avoid that the NVMe interrupts are on the "high priority" cores.
> Having
> noise on them is quite bad for us, so we wanted to move some interrupts to
> house
> keeping cores and if needed (due to performance issues) keep some on those
> "medium-priority" isolated cores. NVMe is not that highest priority for us,
> but possibly running too much on the house-keeping cores could also be bad.
> 
> > If yes, I think your case still can be covered with 'isolcpus=managed_irq'
> which
> > needn't to be same with cpu cores specified from `isolcpus=`, such as
> > excluding medium-priority cores from 'isolcpus=managed_irq', and
> > meantime include them in plain `isolcpus=`.
> 
> Unfortunately, our kernel version (5.4) does not support "managed_irq" and
> due
> to that we're happy with the patch. However, I see that for newer kernel
> versions
> the already existing arguments could be sufficient to do everything.

'isolcpus=managed_irq' enablement patches are small, and shouldn't be very
hard to backport.

> 
> > > be tricky to assign all interrupts to those without a
> performance-penalty.
> > >
> > > Given these requirements, manually specifying interrupt/core assignments
> > > would offer greater flexibility and control over system performance.
> > > Moreover, the proposed code changes appear minimal and have no
> > > impact on existing functionalities.
> >
> > Looks your main concern is performance, but as Keith mentioned, the
> proposed
> > change may degrade nvme perf too:
> >
> > https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/
> 
> Yes, but for NVMe it's not that critical. The most important point for us is
> to keep them away from our "high-priority" cores. We still wanted to have
> control
> where we run those interrupts, but also because we just did not know the
> "managed_irq"
> option.

OK, thanks for share the input!

Now from upstream viewpoint, 'isolcpus=managed_irq' should work for your case,
and seems not necessary to support nvme unmanaged irq for this requirement
at least.


thanks,
Ming


