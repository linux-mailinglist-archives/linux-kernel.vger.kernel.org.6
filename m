Return-Path: <linux-kernel+bounces-204798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0448FF3B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CC11F27C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF54199225;
	Thu,  6 Jun 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OldNq88M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CB1990DA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694845; cv=none; b=ZC/DXtguNVYDGbS4JSjUjKxytYGYfBEnSOwlaVFOYI0v5P395kEsf6KHirja/zbHdc3hdgMRwFElrSNAPLkZGTYItQO5P0TlvdJGO6H3sAzu/kfqyhuHmaLdelqfAF87hidKj7fw29L40MRHKPgPridAcmKONgojnCtdGgLHkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694845; c=relaxed/simple;
	bh=Vrj6by7HZ5znl+cZYgtRvTbs4mioHISFswzBIkufzzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6oMePMtijSg2x1hf+CXqeqesbV2JDd7pU3G7dw2nSq7YRgLvn4L3//k8+tJZVm3lpwEV4fOChD+CRSLE/yvBcQ5gVoKHZdnZlQa/fGxdziW+7VZfkZ86dCyJrZwM3cwCr3FB/98aWpGpK2nHlDdmudwy/B0DbOHSUOvqBQwnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OldNq88M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717694842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sz0RERWk5Ecm+O3n3osXuRqBMwh86v1zD3ET+YEnd50=;
	b=OldNq88MjcP6wkIoMum+VFpMKTeJGxuqrBgpa39Alj6NM31UkWAdc7JsNXadqVwv61F0cj
	Z6RVNI16ionKyZrR5t91Nhwj1ka1xB6jkWsmFH3xg6j/bJVpFyiGUqgPjmH5CGB2D3Kgre
	sr1klHOGtAHmfYJ/ABTBvTopjeifY1Y=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-xw4ZDV4gOgqDvDE55Aotcg-1; Thu, 06 Jun 2024 13:27:21 -0400
X-MC-Unique: xw4ZDV4gOgqDvDE55Aotcg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3746147204eso11282215ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694840; x=1718299640;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sz0RERWk5Ecm+O3n3osXuRqBMwh86v1zD3ET+YEnd50=;
        b=mtQsObHNZa1LYc2HEKZ3Y704bHB5EPhRtVm7AzwTJ3twrJAYvnv+mFb5YaLrdkHhGf
         V0E7odmWBuxUd8OfH92vWOUO4yg6BEMvq9k/5ZYxDVVTGgM0i0W/+PC9QGqeIg8SwcwH
         kJu3ps80mNcUMj8KcF1/sfuA+JmiHJ1WGN+KM9/U/v0z5P3Av+KdjUXtaby7R+1nKb3I
         PtbeSgxeXzFuFogskXxkxxFSNCOtqZRXRw8TC5W8WqdM1oTMGKZ2HPPUBGKYNaKbFnGu
         0m6nO2JD/DvbwMyMyCIGx1djoQ4iY0AgNfkZfnDHa74GT6b6VVbfO24FuHPz9PRbxe9I
         extQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEittrWSJC3XpaXJ60d9s7jMrHogjXZHKZPFWwfY5Agn/Z8zwhYI1Nc6ZqRUzlTZkEepCwDyMAng0kxMys3kcakrGdnjb4ocTV+hi4
X-Gm-Message-State: AOJu0Yy9j7KF9xURtPmkgPuv+FvLbUE55e0q7xYsVwuAXTg6G6649R3r
	8D/CKcLok7wdrtDdreUqUxmOsbfYuZLF9BJDeo+BEBXTKw6FsInvYJAMImk99ALVo8Xf+UGu2Kf
	BH7qi83EbXpold96cBHEKP4SJsW5C+L+TYH2+5qD2qANGPacMcB15zWy0ky2LMZMB72ov9A==
X-Received: by 2002:a05:6e02:218b:b0:374:a667:fc06 with SMTP id e9e14a558f8ab-37580309f62mr4417515ab.8.1717694840571;
        Thu, 06 Jun 2024 10:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFckJLvv9jZB8litqQUIqmCS99LH6RC9Z9rWoLoaNkdTMJWgv2uggN2xOA/AH43OBZbA27vbg==
X-Received: by 2002:a05:6e02:218b:b0:374:a667:fc06 with SMTP id e9e14a558f8ab-37580309f62mr4417285ab.8.1717694840192;
        Thu, 06 Jun 2024 10:27:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-374bc15dca5sm3869215ab.49.2024.06.06.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:27:19 -0700 (PDT)
Date: Thu, 6 Jun 2024 11:27:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] vfio/pci: s390: Fix issues preventing
 VFIO_PCI_MMAP=y for s390 and enable it
Message-ID: <20240606112718.0171f5b3.alex.williamson@redhat.com>
In-Reply-To: <0a4622ce-3826-4b08-ab81-375887ab6a46@linux.ibm.com>
References: <20240529-vfio_pci_mmap-v3-0-cd217d019218@linux.ibm.com>
	<0a4622ce-3826-4b08-ab81-375887ab6a46@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 17:50:13 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 29.05.24 um 13:36 schrieb Niklas Schnelle:
> > With the introduction of memory I/O (MIO) instructions enbaled in commit
> > 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions") s390
> > gained support for direct user-space access to mapped PCI resources.
> > Even without those however user-space can access mapped PCI resources
> > via the s390 specific MMIO syscalls. There is thus nothing fundamentally
> > preventing s390 from supporting VFIO_PCI_MMAP allowing user-space drivers
> > to access PCI resources without going through the pread() interface.
> > To actually enable VFIO_PCI_MMAP a few issues need fixing however.
> > 
> > Firstly the s390 MMIO syscalls do not cause a page fault when
> > follow_pte() fails due to the page not being present. This breaks
> > vfio-pci's mmap() handling which lazily maps on first access.
> > 
> > Secondly on s390 there is a virtual PCI device called ISM which has
> > a few oddities. For one it claims to have a 256 TiB PCI BAR (not a typo)
> > which leads to any attempt to mmap() it fail with the following message:
> > 
> >      vmap allocation for size 281474976714752 failed: use vmalloc=<size> to increase size
> > 
> > Even if one tried to map this BAR only partially the mapping would not
> > be usable on systems with MIO support enabled. So just block mapping
> > BARs which don't fit between IOREMAP_START and IOREMAP_END.
> > 
> > Note:
> > For your convenience the code is also available in the tagged
> > b4/vfio_pci_mmap branch on my git.kernel.org site below:
> > https: //git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/  
> 
> 
> I guess its now mostly a question of who picks those patches? Alex?
> 
> Any patch suitable for stable?

Nothing here looks like stable material to me.  1/ only becomes an
issue when mmap of MMIO is allowed on s390 (ie. 3/), 2/ is generic, but
only really targets a device found on s390, and finally 3/ is
essentially enabling a new feature.

If we expect any conflicts with 1/ in the next merge window I can take
a branch for it and apply 2/ and 3/ through the vfio tree, otherwise I
can bring them all through the vfio tree if the s390 folks agree.
Thanks,

Alex


