Return-Path: <linux-kernel+bounces-417482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258739D549E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E2B22C18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0F4502F;
	Thu, 21 Nov 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boebQmzq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10D1CB31D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223987; cv=none; b=UyQTAEJ/GkJzf3CcNRHNkYNLIGJsJ5hiinJ1NjQBOhffpJtQSKS9+ryvksg/ZugePH5LcBqInla7OmBcFF/2wmXWql653OAAuyh1xoiuKVmwKwmtko/miWl7TgT494NMxJ6heY4d0EX9Y2QOczQAamf3doC5N64tNfzMyu7QsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223987; c=relaxed/simple;
	bh=nUiGSqJ8FGEOvqp4sJ+x0EoCKS0ELWoJjM4yU5e1RD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFwQFeKeO1yTnCzFUu/oPKrixQPUtwP7VD+vFVxzTbstc4m19M8THCU9qKzzWp1nwgBRLb5DpzbWPILr4JwBHQHupwSh0K71mPjvHcDGnlb21BR4/MrRL207GSBtjkXLgm5xEXr5gOPeJUIgpYsw/jjsAl26FRg3Inc46bnpiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boebQmzq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732223984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNNR6WRAI3KtDJCf3ZPceoJmF1QvFNbsZL3CSMQQu/o=;
	b=boebQmzq/hPIUR7oqD57yg9Fbqc7FsLen//G/WAz2VqKR1qoX1jHTTHCedWYiyIyd47YcZ
	LqylnKo7K5j7k/LfdBpBMNpchkMmU/t/ukLHFXFk6mrZoMrbb9j/tsJ3OSZRUrcdp3+nwe
	0RLf3NWEJDg8PCKp4zY1RzuE/7AOZLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-FG-I4naKN_S5YwZeBwIgPg-1; Thu,
 21 Nov 2024 16:19:39 -0500
X-MC-Unique: FG-I4naKN_S5YwZeBwIgPg-1
X-Mimecast-MFC-AGG-ID: FG-I4naKN_S5YwZeBwIgPg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D9B8195608B;
	Thu, 21 Nov 2024 21:19:36 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83FFE1956086;
	Thu, 21 Nov 2024 21:19:33 +0000 (UTC)
Date: Thu, 21 Nov 2024 16:19:30 -0500
From: Phil Auld <pauld@redhat.com>
To: Paul Webb <paul.x.webb@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241121211930.GF394828@pauld.westford.csb>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Nov 21, 2024 at 09:07:32PM +0000 Paul Webb wrote:
> Hi,
> 
> To answer the various questions/suggestions, I'll just group them here:
> 
> Phil:
> can you try your randwrite test after
> "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
> Performance regression still persists with this setting being used.
>

Okay, thanks. Different FIO randwrite issue I guess.  Nevermind, I'll
go back over to scheduler land...



Cheers,
Phil

> 
> Christoph:
> To check for weird lazy init code using write zeroes
> 
> Values in the 5.15 kernel baseline prior to the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 0
> 0
> 0
> 0
> 
> Values in the 6.11 kernel that contains the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 2199023255040
> 2199023255040
> 2199023255040
> 2199023255040
> 
> 
> 
> Chaitanya:
> 
> Run the same test on the  XFS formatted nvme device instead of ext4 ?
> - XFS runs did not show the performance regression.
> 
> Run the same test on the raw nvme device /dev/nvme0n1 that you    have used for
> this benchmark
> - Will have to check if this was done, and if not, get that test run
> 
> repeat these numbers for io_uring fio io_engine
> - Will look into getting those too
> 
> 
> Another interesting datapoint is that while performing some runs I am seeing
> the following output on the console in the 6.11/6.12 kernels that contain the
> commit:
> 
> [  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> [  473.660502] operation not supported error, dev nvme0n1, sector 14000 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  473.796859] nvme3n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> [  473.922810] operation not supported error, dev nvme3n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> [  474.059169] nvme1n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
> 
> 
> Regards,
> Paul.
> 
> 
> 
> On 21/11/2024 14:49, Jens Axboe wrote:
> 
>     On 11/21/24 4:30 AM, Phil Auld wrote:
> 
>         Hi,
> 
>         On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
> 
>             On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> 
>                 On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
> 
>                     Hi,
> 
>                     I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
> 
>                     Bisect root cause commit
>                     ===================
>                     - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
> 
> 
>                     Test details
>                     =========
>                     - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>                     - Test is on ext4 filesystem
>                     - System has 4 NVMe disks
> 
> 
>                 Thanks a lot for the report, to narrow down this problem can you
>                 please :-
> 
>                 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>                     have used for this benchmark ?
>                 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> 
>                 This way we will know if there is an issue only with the ext4 or
>                 with other file systems are suffering from this problem too or
>                 it is below the file system layer such as block layer and nvme pci driver ?
> 
>                 It will also help if you can repeat these numbers for io_uring fio io_engine
>                 to narrow down this problem to know if the issue is ioengine specific.
> 
>                 Looking at the commit [1], it only sets the max value to write zeroes
>                 sectors
>                 if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
>                 write zeroes value.
> 
>             There's no way that commit is involved, the test as quoted doesn't even
>             touch write zeroes. Hence if there really is a regression here, then
>             it's either not easily bisectable, some error was injected while
>             bisecting, or the test itself is bimodal.
> 
>         I was just going to ask how confident we are in that bisect result.
> 
>         I suspect this is the same issue I've been fighting here:
> 
>         [1]https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/__;!!ACWV5N9M2RV99hQ!PXJXp0zosonkV7jeW9yE0YL-uPElcYI-G-bvm69COWR1Tbl9w9puGc1tLR_ccsDoYPBb9Bs3waNVuuf9Lg$
> 
>         Saeed, can you try your randwrite test after
> 
>           "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
>         please?
> 
>         We don't as yet have a general fix for it as it seems to be a bit of
>         a trade off.
> 
>     Interesting. Might explain some regressions I've seen too related to
>     performance.
> 
> 
> 
> References:
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/__;!!ACWV5N9M2RV99hQ!PXJXp0zosonkV7jeW9yE0YL-uPElcYI-G-bvm69COWR1Tbl9w9puGc1tLR_ccsDoYPBb9Bs3waNVuuf9Lg$

-- 


