Return-Path: <linux-kernel+bounces-443847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33F9EFCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3D1695A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19EE192D97;
	Thu, 12 Dec 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KOXkGCnd"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C418A6B5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032483; cv=none; b=hQed2HbHsQi5bQny/fmRYU3R4iBiV1lH3GKRWTXNhJjBKG/K/ae64er2WFmYN5y5MTqquU2rA7NO+nfLAmGLURgcwBCRDHaExzlXlhTBDLwnr3jkjgYOPxw2iTRmKZOZjPXgJTRj3qcVTtYu0vNvmIx89Njt93faqAufOHwC+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032483; c=relaxed/simple;
	bh=1fUaxnIWQ14Cl7MyHDiaPh/lA3BwLlrrlhJtMV8mhgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqIvxD2wmOiI3v8nRp78WHcMJnWljGaDbMomVoAiH/7LvrPDq9mg/Ihn8HR9546are9c9ptL10RLtds5vYuoGlADQiOjlqN2XtGzwzaU2m0vHj91R06vu5aZTzV43+Kc0nEHn0BCxWM7MvhfqpqWWmM8F0bY39s3Ieza44aF6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KOXkGCnd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6e7f04c98so53085185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1734032481; x=1734637281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3Kc4OCgSvKd/epZOxEeCEHon8tDHQaK9PORYrELsJ0=;
        b=KOXkGCndc+nkHohzWFHcXNx+JAzX0s8GY0Rndodu4+sXFpZuPewbvstErT3+8EQF0X
         YVKvlRw3zOSSsSEaLfqn4ZChh3fwjJ3Ffki78NbboC/uoFh2TqpAqkhGZqWSkQbN2jbw
         M1Iv5W16HbJbT5U0ya1A261dOByVZIzSvnR4y8iZch5SP7PCmuWRFPUR6XFzOSjEO2FE
         P9D7OkuFk5WvvQHj3fx8huOk2x/8tID8RrHJWxr4U7S3GxoM1C82VGOAoO3ZTIyp4nIH
         Z2D+2XQx6N1wWH+aGxWIOuYt4oK1RnnivyhO/mlKi464H5xMRU0iLAaXxExHP0LB5Ctx
         Kx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032481; x=1734637281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3Kc4OCgSvKd/epZOxEeCEHon8tDHQaK9PORYrELsJ0=;
        b=JPjWJ3z5erZfvw7l3TWAeTOznqpa8ARiH89igLJF8TtuVA4gI5+KSzxBk3s+qH1Qm1
         jjHnc4bbLDBL+FPleAdsuEJDMA+/fuMhI3590ygzupNIjJKNITCrhtcvfkvmOMJNuCMj
         U9My3NUmPSQMGsCDlUm/diHSvD6X4pbryPWgx965LKtHXuXX8RqhQ+Y3sbFbq9ZbtU9v
         wPdhoh/JIjwJ3bHcIOt1/W6oFWrHK8YoehSko4rE3C5H7blaYwojLoIo5YPlnbhYOezD
         +UpHWTzexjtgJxcVC5tY8JsutiOTE0AaTa9y+or5noPp+VrXURBJZ2NwBaBjFEBOvKjO
         MRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkrsHNW8Qnh798GK192nwuq7uTey/rX+scxY+ITxE3YzwCb9bOV/Axu+2qizjbniCa2SY3xXyGs8jgSuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PZdQavNBVVlkEAjIrUTf5EmvX3EjzcDT7s+xSX6LF1edS0HT
	3xkZbI7hteIpuFCWmMLVtmiZICKL0T8gLcvrvcmxH+Ju3ORCxQztxGKEhRoIrSY=
X-Gm-Gg: ASbGncudA51MbRMbpb9WeNect59pubUhjIV/nNJB34idSVXxS76s6QgVs7Q9NmOBfQk
	BPGDbeN5Yxq5uDbWe0OBy2LwkuICCS6L5fxbGcFZFTW655xGBkRny4XtXgug4gM3kE5MWNNk2+s
	T8Ks7LWD/mWNiCMvdoYP6QFZbkUL4XcHTNPDmxzqWbooIvsJg+KuyvkaLe4FL2PpJmagy2pEu7Y
	ueqpr28N7fzZB6a5VTxAD/EPh0GUsoPpASUyRiH+ui0HmBMkPeBL52b4zzBbXOzIMlMu16ULsYa
	60dt1f4b4RDVCSnMIDmnnfKQmUB5iA==
X-Google-Smtp-Source: AGHT+IEAIplt0z2RMr+HjydESxf+Hn46nEN6kxVZTLt1QJkSzwAdttK3JwjCrGJqs05d0XfX9mfmMg==
X-Received: by 2002:ad4:5c66:0:b0:6d8:9124:8794 with SMTP id 6a1803df08f44-6db0f6ebbe6mr22392236d6.5.1734032480736;
        Thu, 12 Dec 2024 11:41:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6eed3d22dsm162122185a.31.2024.12.12.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:41:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLp3n-000000001YW-1idH;
	Thu, 12 Dec 2024 15:41:19 -0400
Date: Thu, 12 Dec 2024 15:41:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <20241212194119.GA4679@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>

On Thu, Dec 12, 2024 at 06:03:24PM +0000, Mostafa Saleh wrote:

> This series adds a hypervisor driver for the Arm SMMUv3 IOMMU. Since the
> hypervisor part of pKVM (called nVHE here) is minimal, moving the whole
> host SMMU driver into nVHE isn't really an option. It is too large and
> complex and requires infrastructure from all over the kernel. We add a
> reduced nVHE driver that deals with populating the SMMU tables and the
> command queue, and the host driver still deals with probing and some
> initialization.

The cover letter doesn't explain why someone needs page tables in the
guest at all?

If you are able to implement nested support then you can boot the
guest with no-iommu and an effective identity translation through a
hypervisor controlled S2. ie no guest map/unmap. Great DMA
performance.

I thought the point of doing the paravirt here was to allow dynamic
pinning of the guest memory? This is the primary downside with nested.
The entire guest memory has to be pinned down at guest boot.

> 1. Paravirtual I/O page tables
> This is the solution implemented in this series. The host creates
> IOVA->HPA mappings with two hypercalls map_pages() and unmap_pages(), and
> the hypervisor populates the page tables. Page tables are abstracted into
> IOMMU domains, which allow multiple devices to share the same address
> space. Another four hypercalls, alloc_domain(), attach_dev(), detach_dev()
> and free_domain(), manage the domains, the semantics of those hypercalls
> are almost identical to the IOMMU ops which make the kernel driver part
> simpler.

That is re-inventing virtio-iommu. I don't really understand why this
series is hacking up arm-smmuv3 so much, that is not, and should not,
be a paravirt driver. Why not create a clean new pkvm specific driver
for the paravirt?? Or find a way to re-use parts of virtio-iommu?

Shouldn't other arch versions of pkvm be able to re-use the same guest
iommu driver?

> b- Locking: The io-pgtable-arm is lockless under some guarantees of how
>    the IOMMU code behaves. However with pKVM, the kernel is not trusted
>    and a malicious kernel can issue concurrent requests causing memory
>    corruption or UAF, so that it has to be locked in the hypervisor.

? I don't get it, the hypervisor page table has to be private to the
hypervisor. It is not that io-pgtable-arm is lockless, it is that it
relies on a particular kind of caller supplied locking. pkvm's calls
into its private io-pgtable-arm would need pkvm specific locking that
makes sense for it. Where does a malicious guest kernel get into this?

> 2. Nested SMMUv3 translation (with emulation)
> Another approach is to rely on nested translation support which is
> optional in SMMUv3, that requires an architecturally accurate emulation
> of SMMUv3 which can be complicated including cmdq emulation.

The confidential compute folks are going in this direction.

> The trade off between the 2 approaches can be roughly summarised as:
> Paravirtualization:
> - Compatible with more HW (and IOMMUs).
> - Better DMA performance due to shorter table walks/less TLB pressure
> - Needs extra complexity to squeeze the last bit of optimization (around
>   unmap, and map_sg).

It has better straight line DMA performance if the DMAs are all
static. Generally much, much worse performance if the DMAs are
dynamically mapped as you have to trap so much stuff.

The other negative is there is no way to get SVA support with
para-virtualization.

The positive is you don't have to pin the VM's memory.

> Nested Emulation
> - Faster map_pages (not sure about unmap because it requires cmdq
>   emulation for TLB invalidation if DVM not used).

If you can do nested then you can run in identity mode and then you
don't have any performance down side. It is a complete win.

Even if you do non-idenity nested is still likely faster for changing
translation than paravirt approaches. A single cmdq range invalidate
should be about the same broad overhead as a single paravirt call to
unmap except they can be batched under load.

Things like vCMDQ eliminate this overhead entirely, to my mind that is
the future direction of this HW as you obviously need to HW optimize
invalidation...

> - Needs extra complexity for architecturally emulating SMMUv3.

Lots of people have now done this, it is not really so bad. In
exchange you get a full architected feature set, better performance,
and are ready for HW optimizations.

> - Add IDENTITY_DOMAIN support, I already have some patches for that, but
>   didn’t want to complicate this series, I can send them separately.

This seems kind of pointless to me. If you can tolerate identity (ie
pin all memory) then do nested, and maybe don't even bother with a
guest iommu.

If you want most of the guest memory to be swappable/movable/whatever
then paravirt is the only choice, and you really don't want the guest
to have any identiy support at all.

Really, I think you'd want to have both options, there is no "best"
here. It depends what people want to use the VM for.

My advice for merging would be to start with the pkvm side setting up
a fully pinned S2 and do not have a guest driver. Nesting without
emulating smmuv3. Basically you get protected identity DMA support. I
think that would be a much less sprawling patch series. From there it
would be well positioned to add both smmuv3 emulation and a paravirt
iommu flow.

Jason

