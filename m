Return-Path: <linux-kernel+bounces-255765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE529344D6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F9A2822C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2E4D8A7;
	Wed, 17 Jul 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/YEt22p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D44685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255509; cv=none; b=rLBn3K4Adc9dX/+Ux8nvrlRBFNQ5+GFEKw0mPVmj9YPy2QDeQrfhvA8AHQa+bVMJonq+zkaIBKm9qmwAVyXYKw2sELp8zG3wYQeGdpcUSGwNBkOjkDxymnihsnxi+naGN5U/P4N3iv9C4svq2o6R8qlZGcovjE0Uf46iQEfKzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255509; c=relaxed/simple;
	bh=ZeVb4NV1UtDsKj/hoB610U1gFo/rAq+Zrk+VLQva224=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fngkKY45ZG78ejqxqdljH9G92jj95TzpEVDyT2jLQME8t/mA15Pehde6BS/x7BnYQL1CvH7RawYsw0qGmlVv3ORsW59CTjnMmLFhzP1hRop65l2SYuFprX6LtG+j9AdxKa3fmhnUHtKsPRgg1OfafCe2HXkF4j47Ix8TBBYEYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/YEt22p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721255507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBsCYjvHFqCofeJfqJ0FDpq4lR84OryByqZWEVkFAUs=;
	b=E/YEt22prWZzu2ECYMGb9An6VXIMMSyX2/fVsZfr+goRiM+c2e95bDBxXy8nPVl9vQuOn7
	0vIHrUoscdyULVQh8ss07TJ8JBAVGMQDrXrryTNQL4l7C4KhNl+d4XNrBtgdMhszJPYHHU
	9Q9Fg5ECexuLyboiCnm2VdROHNZoZoc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-s2j_lkfqOY2ewpokd66eEw-1; Wed, 17 Jul 2024 18:31:45 -0400
X-MC-Unique: s2j_lkfqOY2ewpokd66eEw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8152f0c4837so25813739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255505; x=1721860305;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBsCYjvHFqCofeJfqJ0FDpq4lR84OryByqZWEVkFAUs=;
        b=mbWnZkBMsM82vV9I5xtv/gx7nzeHlHyNTLJLlO1hO3mv6A52NyqCeGoblSWh6UxnRy
         BQVW6lr2TYsU94+Vdj5r6yNVcznIpEvxtLTrMF3MD1CsR6ICq78YbBcmfsM0wlbgO2MB
         IBPUCIMQ4x2278zvZfg3DCmXPugPp5K28cMzB2tvRBiAdCPot8gdNcZjv+qBznM/URvc
         6FO7Wa526ENlkode+iu9GzQ0JQ+tDg8VO3o+qqdxRQ/IIAHeXm3Gl/eYKd0U89HNFPCj
         Hjf9EZnSnkEOWsIDb5L+JBluyHW45J/rTwwiSJrBR7FlMrpabfEwfmY4qfZbPdINC8rN
         uS6w==
X-Forwarded-Encrypted: i=1; AJvYcCXZHItImeJ90OIIgInbcR7+Onv6NE6Z6peVNIp7n9QSy5rCpqjThlXNxlv82YYQIxKAQ+J6QPp57qjJMxjNFBwUf6Mx9dHlbWw2xnl1
X-Gm-Message-State: AOJu0Yw+HRaI0Mywla2QxeEEuIDHZRwhK3IZYbuvOMGAnPi8k40LKikL
	J1TViNpgpxVgFk1V9q/uLLNGda2K+Pxghqalk0pP0g6dl0/5R9aN0YQw72QCniscsj8tF7Re+vE
	Q+fWWOlfk/qWr/CQcUHiTwUoIzbok/WyrFCYKgFu2xjfQz5M/nkv/v8XeZMg6EQ==
X-Received: by 2002:a05:6602:29c2:b0:806:2e60:d169 with SMTP id ca18e2360f4ac-817123e1c6fmr434707639f.17.1721255505088;
        Wed, 17 Jul 2024 15:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPb97hbNXON2ByzzRKRynxRHlbiYrD3yDjp2uo84hIKMI6iQ+GFeGYUQQkaZREiI+LQxB6iA==
X-Received: by 2002:a05:6602:29c2:b0:806:2e60:d169 with SMTP id ca18e2360f4ac-817123e1c6fmr434705739f.17.1721255504742;
        Wed, 17 Jul 2024 15:31:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c17c5044sm92133839f.19.2024.07.17.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:31:44 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:31:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik
 <leah.rumancik@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 0/3] Backport VFIO refactor to fix fork ordering bug
Message-ID: <20240717163143.49b914cb.alex.williamson@redhat.com>
In-Reply-To: <20240717222429.2011540-1-axelrasmussen@google.com>
References: <20240717222429.2011540-1-axelrasmussen@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 15:24:26 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> 35e351780fa9 ("fork: defer linking file vma until vma is fully initialized")
> switched the ordering of vm_ops->open() and copy_page_range() on fork. This is a
> bug for VFIO, because it causes two problems:
> 
> 1. Because open() is called before copy_page_range(), the range can conceivably
>    have unmapped 'holes' in it. This causes the code underneath untrack_pfn() to
>    WARN.
> 
> 2. More seriously, open() is trying to guarantee that the entire range is
>    zapped, so any future accesses in the child will result in the VFIO fault
>    handler being called. Because we copy_page_range() *after* open() (and
>    therefore after zapping), this guarantee is violated.
> 
> We can't revert 35e351780fa9, because it fixes a real bug for hugetlbfs. The fix
> is also not as simple as just reodering open() and copy_page_range(), as Miaohe
> points out in [1]. So, although these patches are kind of large for stable, just
> backport this refactoring which completely sidesteps the issue.
> 
> Note that patch 2 is the key one here which fixes the issue. Patch 1 is a
> prerequisite required for patch 2 to build / work. This would almost be enough,
> but we might see significantly regressed performance. Patch 3 fixes that up,
> putting performance back on par with what it was before.
> 
> Note [1] also has a more full discussion justifying taking these backports.
> 
> I proposed the same backport for 6.9 [2], and now for 6.6. 6.6 is the oldest
> kernel which needs the change: 35e351780fa9 was reverted for unrelated reasons
> in 6.1, and was never backported to 5.15 or earlier.

AFAICT 35e351780fa9 was reverted in linux-6.6.y as well, so why isn't
this one a 4-part series concluding with a new backport of that commit?
I think without that, we don't need these in 6.6 either.  Thanks,

Alex

> 
> [1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
> [2]: https://lore.kernel.org/r/20240717213339.1921530-1-axelrasmussen@google.com
> 
> Alex Williamson (3):
>   vfio: Create vfio_fs_type with inode per device
>   vfio/pci: Use unmap_mapping_range()
>   vfio/pci: Insert full vma on mmap'd MMIO fault
> 
>  drivers/vfio/device_cdev.c       |   7 +
>  drivers/vfio/group.c             |   7 +
>  drivers/vfio/pci/vfio_pci_core.c | 271 ++++++++-----------------------
>  drivers/vfio/vfio_main.c         |  44 +++++
>  include/linux/vfio.h             |   1 +
>  include/linux/vfio_pci_core.h    |   2 -
>  6 files changed, 125 insertions(+), 207 deletions(-)
> 
> --
> 2.45.2.993.g49e7a77208-goog
> 


