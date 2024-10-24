Return-Path: <linux-kernel+bounces-380363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0689AED16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AE6B22BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC821F9EDB;
	Thu, 24 Oct 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqBIpcqo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A91F81BC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789592; cv=none; b=hQlSvS7YE9qgM5uezemt7o6/sJ43H/0Zn9MZWejv6rqauW4kXqKD2+gC8ahgfcJ1bW2WkLXjPo6sfFb3WSipY/3KHBq/wHy88OuTSY2AaZTDiP3DjK3MVeUzbXV2/0deYHpwwx6beQWHLsR7J9BLFE7WlRFpDpbps1gUKpwrxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789592; c=relaxed/simple;
	bh=klh9W07z9dnYrx+WDBXVU7Y7gwPoTbnFgZFMj8f913U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ8ceXN+ktsjymQO+isM4f8RfsV7XY/ydj+Vl2/8RmRcrNAD0iRJxJ3SikgEs7H5U8AOtUWTJ9kSufj2gcZ8ptLV/NXm6aVicpCKPoM1SW8D/+ujVPcJ9RrwqTBuvVZ8jkhJy+ni9X6CQtbDw4Mab0IM4zCPSNDHIiCybV/4800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqBIpcqo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729789588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJivlp5+vY5saGH+G4HFhSzZKNWMZaI7pdxEbQ8gMx4=;
	b=DqBIpcqoBq5FJUlriT1dOxYDgPKAAeS/rzfCyTUhM8E3NskQrMtgm1cM8WKLdVLq00ZEO+
	iUANiJ20jFrhIpiRD7IwM1lvE8YDhLUprgmHxxa/eOEWaTBN8IT59czUAaRpmFo2JX/I6N
	iZPMA3SbTgT5+xgF89p2bHSBXXriEVI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-NscuuIdgNPmLWurkTKlVCQ-1; Thu, 24 Oct 2024 13:06:27 -0400
X-MC-Unique: NscuuIdgNPmLWurkTKlVCQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ab023bc99so17862839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789587; x=1730394387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJivlp5+vY5saGH+G4HFhSzZKNWMZaI7pdxEbQ8gMx4=;
        b=GY6RXm2PayRzlJpygrnHVHQs/+3Bm6wZfZ7ppVCAA9/umDZZEOwtbq2HhmOEoobxCI
         CrjEQqKfNZabCYYDU0QQNZ3WZPJdJFycl53p22U2cWCM16IUMayPeBEFcjLFfQK+AkT5
         HeYsCgIYPjsmLztKkwbbuo3y2KEURXuPowKJg5DGwnpgp4IRuDlUjcQHhnzgAb2/0Oec
         UcirCoUR3A1BS2FOGZQsTSKTNd9OyAOt5ONpJ5zu67Cwbvggn5INScpcxAxToLqv2Z60
         SiR3McQeUwTNgoYS6X4WbhunZwrFtXvpmYIUqYmBZmSnp+R32pEVJSvNwnvxmLLImIIq
         HKGg==
X-Forwarded-Encrypted: i=1; AJvYcCUFyApD7LY0ulBL9iEhe9Dqi4eidzSGc5UZ52cYVz0c1IQ9CVHutHBeFnH6vWRzgyQfBG512YXkK55pb0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YznowJ87xivpmT50hyRNS3AkqXUCDhj9GAMeN9JPrYJofTCQhXI
	f1eirG4xGu+J1GQUV25qoa0UkVX6VR25DO+QmhxqOlmen2OAG/P1loBON8JRfwzOyIyeoTLMA+W
	G7E8zwfaf8Q55+gTJmPG2WUIP6cnQ0OPOrD7/smBdD9ccqM9JP7HFunHpkeVGow==
X-Received: by 2002:a05:6602:2564:b0:83a:9c22:23b3 with SMTP id ca18e2360f4ac-83af6460bd2mr172822039f.4.1729789586994;
        Thu, 24 Oct 2024 10:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0kqiNgE1U9eRrDe1V4C/y24cuS+s9R9LQzqi7g3Sgz9abY/IAJocZ7cw6oH4QmP1S6Y7LyQ==
X-Received: by 2002:a05:6602:2564:b0:83a:9c22:23b3 with SMTP id ca18e2360f4ac-83af6460bd2mr172819539f.4.1729789586416;
        Thu, 24 Oct 2024 10:06:26 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ad1c4e380sm286926339f.13.2024.10.24.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:06:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:06:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1: vfio: avoid unnecessary pin memory when dma map io
 address space 0/2]
Message-ID: <20241024110624.63871cfa.alex.williamson@redhat.com>
In-Reply-To: <cover.1729760996.git.qinyuntan@linux.alibaba.com>
References: <cover.1729760996.git.qinyuntan@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 17:34:42 +0800
Qinyun Tan <qinyuntan@linux.alibaba.com> wrote:

> When user application call ioctl(VFIO_IOMMU_MAP_DMA) to map a dma address,
> the general handler 'vfio_pin_map_dma' attempts to pin the memory and
> then create the mapping in the iommu.
> 
> However, some mappings aren't backed by a struct page, for example an
> mmap'd MMIO range for our own or another device. In this scenario, a vma
> with flag VM_IO | VM_PFNMAP, the pin operation will fail. Moreover, the
> pin operation incurs a large overhead which will result in a longer
> startup time for the VM. We don't actually need a pin in this scenario.
> 
> To address this issue, we introduce a new DMA MAP flag
> 'VFIO_DMA_MAP_FLAG_MMIO_DONT_PIN' to skip the 'vfio_pin_pages_remote'
> operation in the DMA map process for mmio memory. Additionally, we add
> the 'VM_PGOFF_IS_PFN' flag for vfio_pci_mmap address, ensuring that we can
> directly obtain the pfn through vma->vm_pgoff.
> 
> This approach allows us to avoid unnecessary memory pinning operations,
> which would otherwise introduce additional overhead during DMA mapping.
> 
> In my tests, using vfio to pass through an 8-card AMD GPU which with a
> large bar size (128GB*8), the time mapping the 192GB*8 bar was reduced
> from about 50.79s to 1.57s.

If the vma has a flag to indicate pfnmap, why does the user need to
provide a mapping flag to indicate not to pin?  We generally cannot
trust such a user directive anyway, nor do we in this series, so it all
seems rather redundant.

What about simply improving the batching of pfnmap ranges rather than
imposing any sort of mm or uapi changes?  Or perhaps, since we're now
using huge_fault to populate the vma, maybe we can iterate at PMD or
PUD granularity rather than PAGE_SIZE?  Seems like we have plenty of
optimizations to pursue that could be done transparently to the user.
Thanks,

Alex


