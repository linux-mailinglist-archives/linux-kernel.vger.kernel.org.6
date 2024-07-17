Return-Path: <linux-kernel+bounces-255719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79423934419
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078E21F228F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7818EFF0;
	Wed, 17 Jul 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRM06IAv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53921188CA9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252673; cv=none; b=aOICKrMwl+jHAZprCkPNSkLydqWvYzjfcePHoMcLmsoC8Nk2NhZvItc65Cyu+1FuSiU/DxhR1WBMCuqIp9EO2UPi0HKB9Z7d29ynE90kuHkvdDqCw+Iwah2S73ZpIOdNjeD92vDEEKn8omFeFV4sMODLT53RkypfGhurqhBL+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252673; c=relaxed/simple;
	bh=nm1sn8H+UwA2gzDfCfCPgna/4ZDRkMbtFZ/jJS2k4dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AipR+w2iqJCabOVCYUYq62chjhjFh7jMOCrX2613xQXwLBX3nlXVWcfMHEvFnrlfBJx6As3Uk+GaoldGgKIPlZRISL7u2I0JM1AHJqkKe/vuT0EuvuodZIOiRlwosdda1dRZmhz1iua1bG8cyNdqyHTTEX9kMN+PQSRkR7GUuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRM06IAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721252670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wjxz20iy8G2qBsoFEZ2vcnJOu/C66k+kPs/38ZB7V8=;
	b=HRM06IAv+K4caEO/Jfu3J0KLvy1sma7fZuNJ/eiSLLdW+Z7kLdsml0JnutnNAbLXeTJUwf
	Lv6QdRo0eO+0EJzlgJ92FLHrx+ao+YLBqmGswXFkA53vnBe2R233DmtclLRFWoHPTv5qfP
	cn4MUS64L9vl+kavou9gA+/+Blg7630=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-4FCJfa8EMu6lR0L_3R_HpQ-1; Wed, 17 Jul 2024 17:44:28 -0400
X-MC-Unique: 4FCJfa8EMu6lR0L_3R_HpQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so16523439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721252668; x=1721857468;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wjxz20iy8G2qBsoFEZ2vcnJOu/C66k+kPs/38ZB7V8=;
        b=heJAk21BgCk/kXT9QbrgWuh6sOZSih0XwX3eA4yS5ccWoPl9B1/HP9lW0I3BoLvoJs
         mqGK6+ndbhPygh/wbZ+RmS59l4hgQvdu3jjbsw9fC18rKYpm3+UbummTMBbdjl2X6PoT
         D7yZAMnmi/zJ+j7NhQ6obJoLV1l8ouRVCm5v2iomc/NVT6ms09ZxScQfVHPN32m8/OMm
         7tv9hYLwTqHhiCR5nGpiO7PUGgFpDmYYDZVsm2YuOJWrFwL16OLq4tula0CCwBLuVLsz
         kLiiCVBOTJg7vxq2dr6qOEggsOYI2A6BMMA+J2jLz2R7ePMLw0rWeILl/EPnxBqROLlB
         mYkA==
X-Forwarded-Encrypted: i=1; AJvYcCXTFact1w1FP774zREVfuMuZqNdH8KEEmXA5YwT0EzbOZf+2FEQtXAZeXsgDv6cTXVLWEi2cDg6sFQ8twZbuTREkhJMdomf8hBkPU8c
X-Gm-Message-State: AOJu0YzzAMLaMMbUKhgngfhyqBcqbmu7WTZwq/uYm3ex+ifDKc4uszzD
	UnA5YazmGLvkTamwywSo/Q2jgogRv9Gdn58YyYjtXPYn15qXb5A+iNaeEaeJa53Gf+erdkw70j5
	MLp03POmcEkwiq2dckr89g5CzcmpRDZXinvle3HnZfLUAVcoSicbZgl3UfQa/eQ==
X-Received: by 2002:a05:6602:2c92:b0:7f6:20d2:7a96 with SMTP id ca18e2360f4ac-81711e18b30mr344228739f.14.1721252668208;
        Wed, 17 Jul 2024 14:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3w+Houb1Be8pF3Zf31Isom/zcA7zD4gXvl4BNJsg1iNrkpkV/hEYMiAVNuTjdPIuOyIyVA==
X-Received: by 2002:a05:6602:2c92:b0:7f6:20d2:7a96 with SMTP id ca18e2360f4ac-81711e18b30mr344226539f.14.1721252667843;
        Wed, 17 Jul 2024 14:44:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210ff4c3bsm961063173.171.2024.07.17.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:44:27 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:44:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, Eric Auger
 <eric.auger@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Kunwu Chan <chentao@kylinos.cn>, Leah Rumancik
 <leah.rumancik@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.9 0/3] Backport VFIO refactor to fix fork ordering bug
Message-ID: <20240717154425.43437eea.alex.williamson@redhat.com>
In-Reply-To: <20240717213339.1921530-1-axelrasmussen@google.com>
References: <20240717213339.1921530-1-axelrasmussen@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 14:33:36 -0700
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
>    therefore after zapping), this guarantee is violatd.
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
> [1]: https://lore.kernel.org/all/20240702042948.2629267-1-leah.rumancik@gmail.com/T/
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

LGTM

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex


