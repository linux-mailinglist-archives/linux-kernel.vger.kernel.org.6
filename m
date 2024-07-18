Return-Path: <linux-kernel+bounces-256453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A0934EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CB21F218DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081413FD84;
	Thu, 18 Jul 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnPeRuBs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95513B286
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311392; cv=none; b=XmswtZmmVmfVSZjOpgPx83zgORW9gmi4FZ+LGSAlVetb2qakWot7vfvXK1fYQsfeCjKG/58buUIBkVemGcs5Uch1Rz4wDLEquXyBOG+8sdOki7CKHEe3/7+GUtuwH91qkQoeQTgEKUgW3RpLrm/lJLOFd661CYxdlQ13zJiCegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311392; c=relaxed/simple;
	bh=so0PJQMEtqjm+fVoHW/Rmt7FG7URj5XO+NjCBDJ9M0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRY1M8ICBHscWR78RFw8FtWpDI92c6qGyXAM+swZbWp0A8fQ+pkuJYf7Ma9NGJtkjf6+QkJCHMfUVvfjIrCx2UqCuTXPl70HHUYraGbTqNc3JTd0Yt1U1yIUVjKzrFQ+WUObWModzeSkbCg19JhvwOKHQ/cSH4AdyaTdcdb1Mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnPeRuBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721311390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYE/OG+HdD4Z9VFTdkvvBcDpYtJplAEOdQt9J2Aj6Ug=;
	b=QnPeRuBsvjYtsTWmBGlXZwr13WLpmTAVruyke2/OsKq8S9FBvTNL6hXvbB+KM69W1ZLZyW
	NwiCNKE5QFh4XJLAuZy79BmQr//BJuIs7XXJVQhUzXZTkIJLwlcexeMN6m/Cs6QncGkbAd
	T0Q25VWD0dNo9GslMqQ6B7Z1Fd0rPcg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Aj6CTnr2MUWYU0fuIbKWmw-1; Thu, 18 Jul 2024 10:03:08 -0400
X-MC-Unique: Aj6CTnr2MUWYU0fuIbKWmw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-447f9d993c2so429181cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311388; x=1721916188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYE/OG+HdD4Z9VFTdkvvBcDpYtJplAEOdQt9J2Aj6Ug=;
        b=lN4jlHbybmj7tyh4WcucPFvLRWN8W9XcrKKs9RnugVctFDr4NQw1Jx1x4IUhNj7vMs
         jZs8FTeuVj0GYpuHXIymfix29xnr5sWzCK2bK0kiNyB+R1Jiw5N0yvV0eBXw+BZR2yb2
         o7PyAWOcPnkl0Ks7cNjhk8xpzo6Y/bGb5Rh1GDA3lcu2oZNXv9SekTi4pAgWMSovnTgh
         4twIdS8y6jxP5to9IGs81D4AmLiYNHH0FUpPWsHRLAR72uAIRrO3aTTBn9reBOCoNdnU
         y58E70+yf5MYoT0+QoAtRi/kZ1wTxW6c0KN5AxdORpt8rAc5tDfLVXGrG3nhdEklm3kF
         D4LA==
X-Gm-Message-State: AOJu0YzVODGIwDyFOx+mS8VcimrHzK68Ax86Rtpq4E6GoHADw97KQ790
	M8mvILfTI29ZgDApmkcTdHmhPKod11ht5R4wUwBlMK35LwClijd+Zsh7zA+k9PHVjXv/ojB0Hcd
	MDYrVLp58doG1OO9hI+7E2v5eAexg5agWTI0s8Vf/ZwawbW4s6E9+LULVlKp+tg==
X-Received: by 2002:a05:622a:5d4:b0:447:f0c4:8298 with SMTP id d75a77b69052e-44f969a1bd8mr5919591cf.2.1721311387834;
        Thu, 18 Jul 2024 07:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvMTr15AiWMfY/nf1IKErCxcnjlBaB0HXLzkPMH0ZkZpNC3IMSp9UWIkbhEu5KDhKrV5mNxw==
X-Received: by 2002:a05:622a:5d4:b0:447:f0c4:8298 with SMTP id d75a77b69052e-44f969a1bd8mr5919281cf.2.1721311387188;
        Thu, 18 Jul 2024 07:03:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f969be502sm2678911cf.25.2024.07.18.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:03:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:03:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Hildenbrand <david@redhat.com>, David Wang <00107082@163.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpkglfpbHH7lQSft@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
 <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>

On Thu, Jul 18, 2024 at 09:50:31AM +0800, Yan Zhao wrote:
> Ok. Then if we have two sets of pfns, then we can
> 1. Call remap_pfn_range() in mmap() for pfn set 1.

I don't think this will work..  At least from the current implementation,
remap_pfn_range() will only reserve the memtype if the range covers the
whole vma.

> 2. Export track_pfn_remap() and call track_pfn_remap() in mmap() for pfn
>    set 2.
> 3. Unmap and call vmf_insert_pfn() in the fault handler to map pfn set 2.

IMO this should be the similar case of MMIO being disabled on the bar,
where we can use track_pfn_remap() to register the whole vma in mmap()
first. Then in this case if you prefer proactive injection of partial of
the pfn mappings, one can do that via vmf_insert_pfn*() in mmap() after the
memtype registered.

> 
> However, I'm not sure if we can properly untrack both pfn sets 1 and 2.

Untrack should so far only happen per-vma, AFAIU, so "set 1+2" need to be
done together as they belong to the same vma.

> 
> By exporting untrack_pfn() too? Or, you'll leave VFIO to use ioremap/iounmap()
> (or the variants) to reserve memtype by itself?

Thanks,

-- 
Peter Xu


