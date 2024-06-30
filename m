Return-Path: <linux-kernel+bounces-235163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DDC91D0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB4D1F21516
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85412F5A1;
	Sun, 30 Jun 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQrNtJn+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0B12DDBF
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740996; cv=none; b=OOBL423gTkdlvRYH5MbZh3LijZ0cj4h1NnoNNGNLX+nZf5axcP3erHo01x9asutg+8wlov/7RafR/TS2ATOwVRKn5tZ3ovfG7KOOWsOF/sizYhPF2Y8st/SzJnyFLfvLihYKKL2Ga8HkQHYpkaYnkGCRMZo4bRLcYrQ1DM2E7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740996; c=relaxed/simple;
	bh=+Hj+ej1yELwJpTLeFNY7s0JvVDII4lE0COM7CkqbpyU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DZVPcmoR2AMg77QwmpzHJfnjgsyST2kDVZdaEQqiKsGCp1Cbeur/O8oX1sduUzBqm2wVeLvWPrjHNFfsqu32ESiq3XLKcHouScXouc3x5bprCgue3leivxZpfxRnEXYVIqyheBjQQ7o5XzOGQT7NWVcu25lyagNF/Afjya5egt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQrNtJn+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719740993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxkrqXVgzzzEksGK9Qx5+Z70+SzFjaVw0EtwfNJwAVQ=;
	b=IQrNtJn+m2Z5HFBT3RbIyUuYG54So+jMdjJNMozikp/7Z//J20q+IzqeH6Q6lhtX/SMq/O
	TxQfEUj/o5FfPWDC5FeNvGzvtcQeDiIqr7SS/CGcCZKu5xXVJEzwztdeiOZrZ9AVSFB1eM
	UFUiplPiGnf4zXS1VZLvufEeRfxGFUI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-6FQfftPNP9-_kT62E-oubA-1; Sun,
 30 Jun 2024 05:49:49 -0400
X-MC-Unique: 6FQfftPNP9-_kT62E-oubA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E618C19560AB;
	Sun, 30 Jun 2024 09:49:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1F673000218;
	Sun, 30 Jun 2024 09:49:46 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 8398130C1C14; Sun, 30 Jun 2024 09:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 80C2E40D0E;
	Sun, 30 Jun 2024 11:49:45 +0200 (CEST)
Date: Sun, 30 Jun 2024 11:49:45 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Waiman Long <longman@redhat.com>
cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
    Mike Snitzer <snitzer@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
    Jonathan Brassow <jbrassow@redhat.com>, Ming Lei <minlei@redhat.com>, 
    Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
    linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: dm-crypt performance regression due to workqueue changes
In-Reply-To: <a699a394-d36a-4f42-bd49-9a5a573fd58f@redhat.com>
Message-ID: <e5e5b436-17a6-aafe-2f61-eb659fa35ae2@redhat.com>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com> <a699a394-d36a-4f42-bd49-9a5a573fd58f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-1505880377-1719740985=:507932"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1505880377-1719740985=:507932
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 29 Jun 2024, Waiman Long wrote:

> On 6/29/24 14:15, Mikulas Patocka wrote:
> > Hi
> >
> > I report that the patch 63c5484e74952f60f5810256bd69814d167b8d22
> > ("workqueue: Add multiple affinity scopes and interface to select them")
> > is causing massive dm-crypt slowdown in virtual machines.
> >
> > Steps to reproduce:
> > * Install a system in a virtual machine with 16 virtual CPUs
> > * Create a scratch file with "dd if=/dev/zero of=Scratch.img bs=1M
> >    count=2048 oflag=direct" - the file should be on a fast NVMe drive
> > * Attach the scratch file to the virtual machine as /dev/vdb; cache mode
> >    should be 'none'
> > * cryptsetup --force-password luksFormat /dev/vdb
> > * cryptsetup luksOpen /dev/vdb cr
> > * fio --direct=1 --bsrange=128k-128k --runtime=40 --numjobs=1
> >    --ioengine=libaio --iodepth=8 --group_reporting=1
> >    --filename=/dev/mapper/cr --name=job --rw=read
> >
> > With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
> >
> > The reason is that virt-manager by default sets up a topology where we
> > have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue
> > patch avoids moving work items across sockets, so it processes all
> > encryption work only on one virtual CPU.
> >
> > The performance degradation may be fixed with "echo 'system'
> >> /sys/module/workqueue/parameters/default_affinity_scope" - but it is
> > regression anyway, as many users don't know about this option.
> >
> > How should we fix it? There are several options:
> > 1. revert back to 'numa' affinity
> > 2. revert to 'numa' affinity only if we are in a virtual machine
> > 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
> > 4. any other solution?
> 
> Another alternative  is to go back to the old "numa" default if the kernel is
> running under a hypervisor since the cpu configuration information is likely
> to be incorrect anyway. The current default of "cache" will remain if not
> under a hypervisor.
> 
> Cheers,
> Longman

Yes. How could we detect that we run under a hypervisor portably? There's 
a flag X86_FEATURE_HYPERVISOR, but it's x86-only.

Mikulas
--185210117-1505880377-1719740985=:507932--


