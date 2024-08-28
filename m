Return-Path: <linux-kernel+bounces-304237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56709961C67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA936B20E35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254612CD8B;
	Wed, 28 Aug 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO++8kg9"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A771DA32
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813729; cv=none; b=HiX/vY1CMiZNr03YurIMy7oRfiHJQM9PkFZN/QK52hj0HJxX6BGwUKiPX3IvyGI/kKAqO2Mqylxjtgz5SopC8XN+BLdYmgJKD+Wu8UoMvwDE0oFw3jEkQYMJi5yrIj2vbmzghcb3ReXsbds7WVy/si0MCz5fCw5Knryjv3DsVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813729; c=relaxed/simple;
	bh=pJEgJeTQwVs5vx66mBxar+N9b1m9N3pdSmF9ogkPcWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6y3rS7AxgNMLS+5efyo/IXLcon8EhplZkdZ1i/MFUvNJj9ZxuAY/AbQ57wxdEl3nZSL/CTXEedvlVDcnWS6mRCoz50oOQkASJ5Aa4X/ihDxn41Y3W3UTJEHGpdIF6IBfuRZF3TaCtGRPuhdXpsTmA+vnJrdR5c8eY8Kt0j49Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AO++8kg9; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d2cad030cso93995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724813727; x=1725418527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fLdemAYHyaRjrEjX/PyMbIb7irsWTXj+jd0WtbNIYg=;
        b=AO++8kg9U+gLr3sIFi2wteqpHAY1ALP6PCclv+9wmfMKrxKulGggBxYLS5ElJ68zhI
         M/8x7zPk/pVKvDvu40BO64rScUss26fZcJUykyNNST6JrHUwmEMgyPLU9CWjAm/GWpM4
         DqYyaf5eSQF0Xt/Uljw1ffsDQg/n+vf5bmR1DqrK7z0zJwvnB1RZ+HHby5Svr1/sjZCz
         fa0LhcqlwZ4d1w2TetDbKzoxGHPx6JD+rTi9AFLnAiUnEG2r0H2OC4LSbl5EU7LEw+U6
         TfkfG/5yOfuY7gjoyTnJskSpoTUCHzLmGCl13vdYb5yNCzGPDAyMwbB52XR58zIhUTZB
         tEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724813727; x=1725418527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fLdemAYHyaRjrEjX/PyMbIb7irsWTXj+jd0WtbNIYg=;
        b=JBF/wryjL2zc4+utSe/3I2dDujPS4jUqHLd5Jj1ClWVWnKxcGEuB9H5P3aMULKiaGW
         U2clbwaSNVOBrDiSw4BmMViZnvBPEv8Myb1wBb19z+uI65lY9hWmUx/B0YgI2/1gEA0F
         wZlFMmyijW+z4xLY3HPE3S9qrhxkT+AbipGbYGi2FNIvJjsVq4irRoTGc+icp6QCVAnT
         KnJW30gWlsz1eh8U/mKGSeuhUHfteib4MVWaA3Grs4CPPSXgF0FJ9+JQy6i159OBp+p4
         RpQN4ckIoa/Q+c3vHarvWKp//rt8kJw/OHwiND2IOBfYZvH4K2gFrvIzA4sfId8uE02e
         bzCA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/BBF1RT/zKINN8PPGkTzKGG8TEFo1z/JblmS/W87+MASevF5vpXUSVw1e781TmjItl4zy1rS5cBTR1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi221kUlmYkkCUyNLmGGF+gON09cDxXB8KpZyyzw/kks7tmzX1
	mYpd+Sx8dzNYFExc0JsARyJ/fPmegh8KaPgbYq9OJEtngfohAp69K9Jfu5rxVo80/VkUN4vBWUB
	V4fYbdNVo6XMRPHqbYmgp2/bO/ZrlpOx4fq8I
X-Google-Smtp-Source: AGHT+IHxQMCM8ygBU1B/o9noyTf8DTeb1f+v9mIev+ysxWN/9s4XOVSoquTlsvNsVPNlXOyOwHBmh6KJiTTKZW7YvPA=
X-Received: by 2002:a92:cd8b:0:b0:39d:24d4:708c with SMTP id
 e9e14a558f8ab-39f320a721emr1116765ab.7.1724813726715; Tue, 27 Aug 2024
 19:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
 <20240826110447.6522e0a7.alex.williamson@redhat.com> <20240826231749.GM3773488@nvidia.com>
 <a0cfcbe4-cab4-48b2-bcba-0bc28d97e996@arm.com>
In-Reply-To: <a0cfcbe4-cab4-48b2-bcba-0bc28d97e996@arm.com>
From: Manoj Vishwanathan <manojvishy@google.com>
Date: Tue, 27 Aug 2024 19:55:15 -0700
Message-ID: <CA+M8utNVshFNJyrw1PcrVSJbFbDqPRkM_PjpF8CGy7Nf8pJRjQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] vfio/iommu: Flag to allow userspace to set DMA
 buffers system cacheable
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, David Decotigny <decot@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:31=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 27/08/2024 12:17 am, Jason Gunthorpe wrote:
> > On Mon, Aug 26, 2024 at 11:04:47AM -0600, Alex Williamson wrote:
> >> On Mon, 26 Aug 2024 07:16:37 +0000
> >> Manoj Vishwanathan <manojvishy@google.com> wrote:
> >>
> >>> Hi maintainers,
> >>>
> >>> This RFC patch introduces the ability for userspace to control whethe=
r
> >>> device (DMA) buffers are marked as cacheable, enabling them to utiliz=
e
> >>> the system-level cache.
> >>>
> >>> The specific changes made in this patch are:
> >>>
> >>> * Introduce a new flag in `include/linux/iommu.h`:
> >>>      * `IOMMU_SYS_CACHE` -  Indicates if the associated page should b=
e cached in the system's cache hierarchy.
> >>> * Add `VFIO_DMA_MAP_FLAG_SYS_CACHE` to `include/uapi/linux/vfio.h`:
> >
> > You'll need a much better description of what this is supposed to do
> > when you resend it.
> >
Thanks Jason, I will add more information before re-sending the patch.
> > IOMMU_CACHE already largely means that pages should be cached.
> >
> > So I don't know what ARM's "INC_OCACHE" actually is doing. Causing
> > writes to land in a cache somewhere in hierarchy? Something platform
> > specific?
>
> Kinda both - the Inner Non-Cacheable attribute means it's still
> fundamentally non-snooping and non-coherent with CPU caches, but the
> Outer Write-back Write-allocate attribute can still control allocation
> in a system cache downstream of the point of coherency if the platform
> is built with such a thing (it's not overly common).
>
> However, as you point out, this is in direct conflict with the Inner
> Write-back Write-allocate attribute implied by the IOMMU_CACHE which
> VFIO adds in further down in vfio_iommu_map(). Plus the way it's
> actually implemented in patch #2, IOMMU_CACHE still takes precedence and
> would lead to this new value being completely ignored, so there's a lot
> which smells suspicious here...
>
Thanks for your quick feedback.
I tested this with a 5.15-based kernel and applied the patch to get
early results.
I see the issue with IOMMU_CACHE overriding IOMMU_SYS_CACHE in patch #2.
This would likely be a problem on 5.15 as well, and I need to
investigate further
to understand how we observed better performance in our tests
while trying to exercise the system cache.
Let me do some more testing and get back.
Thanks,
Manoj
> Thanks,
> Robin.
>
> > I have no idea. By your description it sounds similar to the
> > x86 data placement stuff, whatever that was called, and the more
> > modern TPH approach.
> >
> > Jason

