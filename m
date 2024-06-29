Return-Path: <linux-kernel+bounces-235024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF291CE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E791F21C40
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E085132137;
	Sat, 29 Jun 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhddntiy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381417736
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719685791; cv=none; b=q5VmKTUtGO1n1GPjDrlDmZWyQ2NRsoXk3rQVGqN3KFmwQJEqtt9RLUWQxhVtImUrb0tVw6VMRDO/AmIbbAfQTMk7gtXVNFF/gtAO7IQ2g7n3YZyuha4mKVdspnj67IOipjNRbUwWnppRubGTW/48t1pTnv/fH/YoKDJV4Qghx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719685791; c=relaxed/simple;
	bh=DxFRM6Luwa32I0i4KUXb+ztqinPYS00QjAJMfNusJnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+KR6ZHBfLNo6pxwB0MT8++BV2swYXyQAQEZJaskY7pQjQsZReAOFstLbMYSu3N3oWd0Si1jtLg/dUzA2UajzWkgt40+tT562vBeOZvwGJ3ZrFlL31nJ7PrThskoybVW7yXJEVd/2zBKYG+ZdKv8/Aunj84UtrCcUfSQ70gycAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qhddntiy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719685788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdtH/YRTYX2dEvtJvsBFmXZuN+mOEts2uld+YHoIBmk=;
	b=QhddntiyOFO5v1zT0QDfYB9Ag6GCaB40Cr/FqA2nlWYyGmv3FDi13ei1QgB/eKFlsDhDH0
	KVNyjfhrQD5/X7z/WnGB3GOl0kIqwv24tBhIo3So1FCgdKo+3tIkr6wV8FGUYRiCEYodlb
	QDBxErOG7tCATQlPrVPMu+WaPJEINsg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-rkyJPGPwOluijvoCq5ubtw-1; Sat,
 29 Jun 2024 14:29:46 -0400
X-MC-Unique: rkyJPGPwOluijvoCq5ubtw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F4A19560A2;
	Sat, 29 Jun 2024 18:29:44 +0000 (UTC)
Received: from [10.22.16.40] (unknown [10.22.16.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E741419560AA;
	Sat, 29 Jun 2024 18:29:41 +0000 (UTC)
Message-ID: <a699a394-d36a-4f42-bd49-9a5a573fd58f@redhat.com>
Date: Sat, 29 Jun 2024 14:29:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm-crypt performance regression due to workqueue changes
To: Mikulas Patocka <mpatocka@redhat.com>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Laurence Oberman
 <loberman@redhat.com>, Jonathan Brassow <jbrassow@redhat.com>,
 Ming Lei <minlei@redhat.com>, Ondrej Kozina <okozina@redhat.com>,
 Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 6/29/24 14:15, Mikulas Patocka wrote:
> Hi
>
> I report that the patch 63c5484e74952f60f5810256bd69814d167b8d22
> ("workqueue: Add multiple affinity scopes and interface to select them")
> is causing massive dm-crypt slowdown in virtual machines.
>
> Steps to reproduce:
> * Install a system in a virtual machine with 16 virtual CPUs
> * Create a scratch file with "dd if=/dev/zero of=Scratch.img bs=1M
>    count=2048 oflag=direct" - the file should be on a fast NVMe drive
> * Attach the scratch file to the virtual machine as /dev/vdb; cache mode
>    should be 'none'
> * cryptsetup --force-password luksFormat /dev/vdb
> * cryptsetup luksOpen /dev/vdb cr
> * fio --direct=1 --bsrange=128k-128k --runtime=40 --numjobs=1
>    --ioengine=libaio --iodepth=8 --group_reporting=1
>    --filename=/dev/mapper/cr --name=job --rw=read
>
> With 6.5, we get 3600MiB/s; with 6.6 we get 1400MiB/s.
>
> The reason is that virt-manager by default sets up a topology where we
> have 16 sockets, 1 core per socket, 1 thread per core. And that workqueue
> patch avoids moving work items across sockets, so it processes all
> encryption work only on one virtual CPU.
>
> The performance degradation may be fixed with "echo 'system'
>> /sys/module/workqueue/parameters/default_affinity_scope" - but it is
> regression anyway, as many users don't know about this option.
>
> How should we fix it? There are several options:
> 1. revert back to 'numa' affinity
> 2. revert to 'numa' affinity only if we are in a virtual machine
> 3. hack dm-crypt to set the 'numa' affinity for the affected workqueues
> 4. any other solution?

Another alternative  is to go back to the old "numa" default if the 
kernel is running under a hypervisor since the cpu configuration 
information is likely to be incorrect anyway. The current default of 
"cache" will remain if not under a hypervisor.

Cheers,
Longman


