Return-Path: <linux-kernel+bounces-538929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CACAA49EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FE9177E30
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3F26FDA6;
	Fri, 28 Feb 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgLiZfF7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D8275611
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760362; cv=none; b=ZpYP6bLEmYb0tytAyqZr9Z1sYAfYNytXgj1eC0x19qhCHNwxGH4btfNZ5Y6+bamfM9UGA1+lTtHWtcczU/+1IoeuksF6l0QuspsgXtDiPp2NVbhGTJe9+gAM85ZCdLtZAkLpOJ88bR0KW0hXhCjS30PrRlrWAP19Gi9tTXrrlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760362; c=relaxed/simple;
	bh=5S1C6+wr8GrU2eVbvvKeo8m0srDxNtxTZ1gK9o+lW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxtoT0nrPb7RK5tLBNdYq/IBjRWqGTc/ZoiMZpLsXna3kt6crNKPVnsZqXSIBHKO3TmHjAetPAQRoujlkzhaVN9MqVy79INTZmKW2jerDeCvp2ay+4ryBPgnaxXUj8nVa5WMETi2bW8uU6awxGqHK8kkP1/N/URc58Eb5T2XdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgLiZfF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740760359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmEeb9lKrGzm9PpnwIENCXTvdUKNgeT1Zk6eq2x1XqY=;
	b=bgLiZfF7wlOlJEbAkLAXCI9luQBb2Ea/ofPWmtRp2TJ3Z5c9fR/Pk8IZm2TZzfucouyRbn
	ev4u4Vhy97EWPNMPj8lt+IcPCipPb9mr6GztTpyYBNQSiwvkYARxl1pCb2FJT++PjBwVST
	FlCZGBBDVC1A08MJkPiJNB5LYXQt0Ts=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-pAjNxFAYPROAL6I-SDzN9Q-1; Fri, 28 Feb 2025 11:32:38 -0500
X-MC-Unique: pAjNxFAYPROAL6I-SDzN9Q-1
X-Mimecast-MFC-AGG-ID: pAjNxFAYPROAL6I-SDzN9Q_1740760358
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8c06be57so1867185ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760357; x=1741365157;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmEeb9lKrGzm9PpnwIENCXTvdUKNgeT1Zk6eq2x1XqY=;
        b=f4OuIKe+DJZeg4NJPnhFN1lTCRCy6DJXwbbQ5euMB6HKJrBO5EiuQFaivXFK/3xvTW
         qAsh2GIFixJgvXpsMLeZweq5oZJvdyYU6gTA1AASPpKVVgd77dV1wY1rM+5YlxP6CrlA
         kAbayY5Tp9oD8ni3YwXrr3zFp2uR9v/V2cH2eET2EkGkhCjmHloUZ3Zs83vLfXKp6gL8
         cO2MHaNnFeBiY3UFz8ymCbuvUZ4r6HnzcklryZagKxFhSpOhEoYpyIZtG4IJzFRNK3ne
         vJKQx2+LMVEelbMcHtWbB/Uk+Qll8ymbem+EpD4CoHjkotXou8B6Z0EFSakAojKnikvn
         BeDw==
X-Forwarded-Encrypted: i=1; AJvYcCUTWMTxyVnOky8M6OV5DFrUqwdj/cZXdlT9JlrMfgi0IJhONhqx13O4aOCYXoz06NfmnxNiI8NAsZjC2RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9flR7ku/8OJn8zwsqY93kRWg2EyuZenLRZuq/M/3F/9seN8l
	KO0MWsbXa6FGbg8k7TN7QyrrPxWRqfjFKn/3815nL2Zp+IOmTTCKL9wdFqed/0iKfUpmfzCYOmP
	ke1LtKnzQ1juR4nMN5JjfN84FMu+lj6xbjUZOPlfG1VsV/SsWaq3BiecCPU0vyaQLFMrdsA==
X-Gm-Gg: ASbGnctq5H8uv5cWnYfa1bIu5deIp2PtKixS1f0JcPGLCntAP7MIqaJnUlZe2pQQspp
	TNQo2PlYBww02cuovVIkg6+bh91c2uP7zEGv/WycG93I9/M8h/KyFcPlAVboPetJVZRJV8Kwkse
	EL0G1YkFzTgE80Z7sMfUpUYGNJCoanHCNH5VYKo5pwhMzc5G4JS0wStjpJAz8cjAaTcb4so+rIi
	GWhdXCHI8EXIEELlwK1dFH/MPsdumUfTbIzNwy6068lSoyyJmYqRLd7Abo3dVTclanoIVurQ3ZW
	iGhFCR4ICaZLTroIOTA=
X-Received: by 2002:a05:6e02:1748:b0:3d3:d156:7836 with SMTP id e9e14a558f8ab-3d3e6f97e8bmr12715845ab.7.1740760356999;
        Fri, 28 Feb 2025 08:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1OqqoD77aeXTkALnv9pFGNxbF4QLi2N/iLQZh/bOT8+63cQ478MEpB3v7yPmmrcMIMSMziQ==
X-Received: by 2002:a05:6e02:1748:b0:3d3:d156:7836 with SMTP id e9e14a558f8ab-3d3e6f97e8bmr12715695ab.7.1740760356621;
        Fri, 28 Feb 2025 08:32:36 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3dee6ff9fsm9202015ab.32.2025.02.28.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:32:34 -0800 (PST)
Date: Fri, 28 Feb 2025 09:32:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com,
 willy@infradead.org
Subject: Re: [PATCH v2 0/6] vfio: Improve DMA mapping performance for huge
 pfnmaps
Message-ID: <20250228093231.338c9f06.alex.williamson@redhat.com>
In-Reply-To: <20250218222209.1382449-1-alex.williamson@redhat.com>
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:22:00 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> v2:
>  - Rewrapped comment block in 3/6
>  - Added 4/6 to use consistent types (Jason)
>  - Renamed s/pgmask/addr_mask/ (David)
>  - Updated 6/6 with proposed epfn algorithm (Jason)
>  - Applied and retained sign-offs for all but 6/6 where the epfn
>    calculation changed
> 
> v1: https://lore.kernel.org/all/20250205231728.2527186-1-alex.williamson@redhat.com/
> 
> As GPU BAR sizes increase, the overhead of DMA mapping pfnmap ranges has
> become a significant overhead for VMs making use of device assignment.
> Not only does each mapping require upwards of a few seconds, but BARs
> are mapped in and out of the VM address space multiple times during
> guest boot.  Also factor in that multi-GPU configurations are
> increasingly commonplace and BAR sizes are continuing to increase.
> Configurations today can already be delayed minutes during guest boot.
> 
> We've taken steps to make Linux a better guest by batching PCI BAR
> sizing operations[1], but it only provides and incremental improvement.
> 
> This series attempts to fully address the issue by leveraging the huge
> pfnmap support added in v6.12.  When we insert pfnmaps using pud and pmd
> mappings, we can later take advantage of the knowledge of the mapping
> level page mask to iterate on the relevant mapping stride.  In the
> commonly achieved optimal case, this results in a reduction of pfn
> lookups by a factor of 256k.  For a local test system, an overhead of
> ~1s for DMA mapping a 32GB PCI BAR is reduced to sub-millisecond (8M
> page sized operations reduced to 32 pud sized operations).
> 
> Please review, test, and provide feedback.  I hope that mm folks can
> ack the trivial follow_pfnmap_args update to provide the mapping level
> page mask.  Naming is hard, so any preference other than pgmask is
> welcome.  Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/all/20250120182202.1878581-1-alex.williamson@redhat.com/
> 
> 
> Alex Williamson (6):
>   vfio/type1: Catch zero from pin_user_pages_remote()
>   vfio/type1: Convert all vaddr_get_pfns() callers to use vfio_batch
>   vfio/type1: Use vfio_batch for vaddr_get_pfns()
>   vfio/type1: Use consistent types for page counts
>   mm: Provide address mask in struct follow_pfnmap_args
>   vfio/type1: Use mapping page mask for pfnmaps
> 
>  drivers/vfio/vfio_iommu_type1.c | 123 ++++++++++++++++++++------------
>  include/linux/mm.h              |   2 +
>  mm/memory.c                     |   1 +
>  3 files changed, 80 insertions(+), 46 deletions(-)

With David's blessing relative to mm, applied to vfio next branch for
v6.15.  Thanks all for the reviews and testing!

Alex


