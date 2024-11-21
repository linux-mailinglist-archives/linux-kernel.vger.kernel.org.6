Return-Path: <linux-kernel+bounces-416883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A868D9D4BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD7C1F215B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419B1D3562;
	Thu, 21 Nov 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr0uU8nM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307A3C47B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188672; cv=none; b=N5wAyaM/Zg0cmTQwJqE1pFpEszihnSXUsu1IaBqD2U+Pjk8m2UYGVqLQVF9kYcJSrg34H9K5MSZTkNW5Us8t9TWTZAf71oRZtILQCOnwn1+qGDW8uGOd7ks3Gp0IhuMAbwFBlgpWlt1SlFNNNcns63PLKBvkVaRaDJ62TG5Fi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188672; c=relaxed/simple;
	bh=M5wNV0dk0k9R26ViEi3e7jiU+B0KQKh+sc/VkEx7k2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSLVuFD4Y6ivvSj8+pF0JY5MYlHBlsc+PekpxDbYsSc4DYYhK63Y7n3WY5MhKvmwFLvDG9/6ajJfeTHWYg6kYxyafwxHjnJf02adiNP7Zau/bYo4AoMGFEvDrFY77shMwZ8wZopz/kC+s/+gdCgwt82tnin3QRDIdI0QXzxrBws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr0uU8nM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732188668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09vF4pX8kaQ+dR6O2t20RwvdrQl+POuIrCNnkaiSmgA=;
	b=Vr0uU8nM2ZQwZ/ej+MQ25tawTbIeMpFNVzL8lBwKhsWl2zV0qQT8x7Mv7AR4Pg/tDlsKHs
	qrCgyqj7YyoQfM04vMfIZkD15c/OCrGMHDS+vgel3AEUbacdpyYhQ5kueE/FiPw7miZ02R
	Dd5LnT/M3yvobPS3Q2aAzBoMbjxF6k4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-VkpqpWfkOBifU72Bt2MalA-1; Thu,
 21 Nov 2024 06:31:05 -0500
X-MC-Unique: VkpqpWfkOBifU72Bt2MalA-1
X-Mimecast-MFC-AGG-ID: VkpqpWfkOBifU72Bt2MalA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 646091955D62;
	Thu, 21 Nov 2024 11:31:03 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.137])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F81195607C;
	Thu, 21 Nov 2024 11:31:00 +0000 (UTC)
Date: Thu, 21 Nov 2024 06:30:58 -0500
From: Phil Auld <pauld@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
Message-ID: <20241121113058.GA394828@pauld.westford.csb>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


Hi,

On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
> On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> > On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
> >> Hi,
> >>
> >> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
> >>
> >> Bisect root cause commit
> >> ===================
> >> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
> >>
> >>
> >> Test details
> >> =========
> >> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
> >> - Test is on ext4 filesystem
> >> - System has 4 NVMe disks
> >>
> > 
> > Thanks a lot for the report, to narrow down this problem can you
> > please :-
> > 
> > 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
> >     have used for this benchmark ?
> > 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> > 
> > This way we will know if there is an issue only with the ext4 or
> > with other file systems are suffering from this problem too or
> > it is below the file system layer such as block layer and nvme pci driver ?
> > 
> > It will also help if you can repeat these numbers for io_uring fio io_engine
> > to narrow down this problem to know if the issue is ioengine specific.
> > 
> > Looking at the commit [1], it only sets the max value to write zeroes 
> > sectors
> > if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
> > write zeroes value.
> 
> There's no way that commit is involved, the test as quoted doesn't even
> touch write zeroes. Hence if there really is a regression here, then
> it's either not easily bisectable, some error was injected while
> bisecting, or the test itself is bimodal.

I was just going to ask how confident we are in that bisect result.

I suspect this is the same issue I've been fighting here:

https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/

Saeed, can you try your randwrite test after

  "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"

please?

We don't as yet have a general fix for it as it seems to be a bit of
a trade off.


Cheers,
Phil

> 
> -- 
> Jens Axboe
> 

-- 


