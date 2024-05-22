Return-Path: <linux-kernel+bounces-186731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D88CC81B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EAC1C210AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A37145B14;
	Wed, 22 May 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOaFheRZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52986F4E7
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412904; cv=none; b=WBeXkaYxftrlGwDA9J1D4xrGeMYi9FoMjqpGt5xbjVYf7cqKsH+Jn/6pGrKflGG9nczWFJ/yHYeJtTtRJ0cH7J32hFa6wRgSNyWrtg4K0KL2/sUs5sPshqIkuLur0QVDFRYtJUV1MSbVGBQiZ4da3BepkSKEd/AI9nH6CN9rETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412904; c=relaxed/simple;
	bh=Qz9tt6pR5oDF6TcAN7hxYGGPefSmU4S9CgeaMIOuHpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD9Mk90v4jZblZjLDffrL2LbOvzDOtVWPZ1KK1pKvi5l6gTrPxtlnkS8a70PVWi1dRoYKYAqt4MfCk6iJOnGkD1242rJVUoXT8mXJp3eazJTElEfdw3Bc43Tbq7Up7pjHMTtITvWpbewXo9B1g9KjBhZcPIA43SHT4uGMOVWuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOaFheRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716412902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/BUu4duYYbCSIQnv0ATgpzH3sdluqP4G2MqncwvuYRY=;
	b=FOaFheRZj1rSbwmUDDaOyUUkRT0GfJkvDHcYhcya1SpYMtCxkcP/aliAczzrflMqW8rPOR
	mDtGhmNUia3+SIVYPQvW5oT5UI007Q5ArgwToDDs3zG2EIM9pfKXuhD1+mC7NBXFEbmsVH
	2DergJ+mhkEC6j4RPJ0GWQJvnS0S2TI=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-LXVcExpgPLWQ-60ssVlsqQ-1; Wed, 22 May 2024 17:21:41 -0400
X-MC-Unique: LXVcExpgPLWQ-60ssVlsqQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5b215e5d404so116114eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412900; x=1717017700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BUu4duYYbCSIQnv0ATgpzH3sdluqP4G2MqncwvuYRY=;
        b=a8jDxj8sQpUDA/WRWzjrGgW8SIi1myR3P2WqbO+/qThqNNjprgxL3SUL87ruisZJVw
         4Dd+MciEKosdiz2utAq4bloyvlYOdtx6nUyBKfBMMBCMpg1xy8Cs05pgw+mGH0mcUGtt
         kD1cIaAgv/p2HLdz8UeEvUv7wFTjk5mXl1ZigBnvLSPFQCLo2jJ571v9T34mChBHEiO6
         s1e+al+011RU/I1+5dcbKBUWKafm+n9DhOcMeazX6i6BzpLr47fwqxq/d7mWPREydVwX
         Wy/4u/8b95664me5Iaj3Lk+SeSM0MNYkwEbljyNv/yY328gvLCBO3PPv9WpS+nakhoJ5
         Rqlg==
X-Forwarded-Encrypted: i=1; AJvYcCWccpM58kn/V0IyO5zI1A0biKBWcM88PijlwkhSZVnVuah18DUinhY6mT5vYvF0V+rjqwb6OmV2iHIcZPk9X8RkNTh7QMObu38TH3ox
X-Gm-Message-State: AOJu0Yy/m68T+SnFx4ClCtbj4ex6Ylrb8c52pU0SDGhWc99musZ5AyM4
	cqBjdUKFqLWLvinl+NG6N3hlYFk4W1HTnNs7IL+PcKOHdgdh09Xsp/XujIMLNT8vgUct7fMWag5
	MK54vhTDWgspIDs7ExOQ2+l31fmGXIJ4Mr1Xwmmjvx1knoM3i0my37wJUMMrRsw==
X-Received: by 2002:a05:6358:9489:b0:192:5236:b1d9 with SMTP id e5c5f4694b2df-1979193b80fmr316851855d.2.1716412899924;
        Wed, 22 May 2024 14:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwmCqt+xh/cZzgdi3/vI+4gv7akS2ZD5pP2sH4xzmrmjQTtwWo7DH2HtQpg4Y2yNagbT5Nkg==
X-Received: by 2002:a05:6358:9489:b0:192:5236:b1d9 with SMTP id e5c5f4694b2df-1979193b80fmr316848555d.2.1716412899113;
        Wed, 22 May 2024 14:21:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aa3280f16fsm36409786d6.12.2024.05.22.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:21:38 -0700 (PDT)
Date: Wed, 22 May 2024 17:21:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Yan Zhao <yan.y.zhao@intel.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin.tian@intel.com, jgg@nvidia.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Message-ID: <Zk5h3yfuZzlo2VzN@x1n>
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
 <20240522-b1ef260c9d6944362c14c246@orel>
 <20240522115006.7746f8c8.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522115006.7746f8c8.alex.williamson@redhat.com>

On Wed, May 22, 2024 at 11:50:06AM -0600, Alex Williamson wrote:
> I'm not sure if there are any outstanding blockers on Peter's side, but
> this seems like a good route from the vfio side.  If we're seeing this
> now without lockdep, we might need to bite the bullet and take the hit
> with vmf_insert_pfn() while the pmd/pud path learn about pfnmaps.

No immediate blockers, it's just that there're some small details that I
may still need to look into.  The current one TBD is pfn tracking
implications on PAT.  Here I see at least two issues to be investigated.

Firstly, when vfio zap bars it can try to remove VM_PAT flag.  To be
explicit, unmap_single_vma() has:

	if (unlikely(vma->vm_flags & VM_PFNMAP))
		untrack_pfn(vma, 0, 0, mm_wr_locked);

I believe it'll also erase the entry on the memtype_rbroot.. I'm not sure
whether that's correct at all, and if that's correct how we should
re-inject that.  So far I feel like we should keep that pfn tracking stuff
alone from tearing down pgtables only, but I'll need to double check.
E.g. I at least checked MADV_DONTNEED won't allow to apply on PFNMAPs, so
vfio zapping the vma should be the 1st one can do that besides munmap().

The other thing is I just noticed very recently that the PAT bit on x86_64
is not always the same one.. on 4K it's bit 7, but it's reused as PSE on
higher levels, moving PAT to bit 12:

#define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */
#define _PAGE_BIT_PAT		7	/* on 4KB pages */
#define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */

We may need something like protval_4k_2_large() when injecting huge
mappings.

From the schedule POV, the plan is I'll continue work on this after I flush
the inbox for the past two weeks and when I'll get some spare time.  Now
~160 emails left.. but I'm getting there.  If there's comments for either
of above, please shoot.

Thanks,

-- 
Peter Xu


