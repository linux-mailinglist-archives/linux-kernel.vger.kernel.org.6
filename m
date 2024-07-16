Return-Path: <linux-kernel+bounces-254117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3972932F27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7019A283523
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9D1A00E6;
	Tue, 16 Jul 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eb/zTCU5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE9F9E8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151299; cv=none; b=poMR/Jxx6qmDVYQfb8S8VnvauSE1lX7IL9FDPScIGq+Z9/DXqexQlT0o0n6gEc0loW60aANhDMnUklv4k1G28QdiFQWDX2H2Fgzhiu6Ew+YdrpQ4Njaib8j3msYz0+VQsGjZ7oJpFipA5Biw8QcBLigQVc0DxtWSRIX0AX5w9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151299; c=relaxed/simple;
	bh=3M0QByp5nIuBwkxRifE56E0QWbZdgARiPYYVK/zs0M4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHVCgpKI7tLjxEQ+SWG9vml2RxLFdJHm+eLhcaGiTDT3TshPqwXOsDURrGbM6cIgrEFd5v1j6aozSrpA/bfMv+uegaI/YNFXyNUkVsNnBmo052VVibjqzo6Ccs+BGcghu8nGTURAxn92FksCwTAfjOQ/4Yc4HD/V2CVFjkAOibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eb/zTCU5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c95c80c6f7so5094025a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721151297; x=1721756097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzncl9L3e27llWjrAt0uSGnBBcBzotmsp09OvMIhHpc=;
        b=Eb/zTCU5kPhzS0/bk11Payd+5kyJ5P2aPcU0yqX7V8Y4LtmgT0sDl/yHktUTM0Mb7e
         z5CaMMry8WZjMr5ZtlxQ87ORckr2HKdH4DQNITPpw9aS71YoA9TgD07EukwUOenFSQpo
         7sE/rSzawBqGFpZSZo33IEuluLPX35cCdKe/yMWDsQypYBEBvgsBkxJB62ksxnOWSts9
         9mv2eGtomZymF8HSMD+UFj7wZifkS1l1Fc0HLYVkEQlqKTJsMosmVePzRZhL8EqitXyK
         tTYiarBJJM/8pKKq28QrQMz57hDBMA2kBG28/SP+ikuUyjJw6ZV/0skeTvjYY9C/Unpv
         u+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151297; x=1721756097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzncl9L3e27llWjrAt0uSGnBBcBzotmsp09OvMIhHpc=;
        b=TFWIdYCYf43LSO2Oe8DJirck9yU2l6tAS+Y2fQK36gZyHsQIiDkZuPUdTqse2gL4l+
         PLmhVK8fvdlgtMrCxXmW4Y9ps8TcJxgwQnUt4pcfqAH4L7xC2aW3YMuIFbS1kbEeELqW
         4eA1EfNtQCamCvdtbPKOZorWNRRmK06OX/smYQZnFSfYEyJkmizw33jLYh03aGAk+gG4
         lJlpz3TnOHKlCmAD9jPUqxPOXyCzLoOFH05miyvfowbktPUI4H6pTU6KLl7BLGYWyC14
         O2h2XKj3cEZHUPL+M79Tp10ngvNhxgo6P9rE6rC4dxy4I9mYiDIswm7iHSkMXGtBKorA
         EgQA==
X-Forwarded-Encrypted: i=1; AJvYcCWgA4lA/reK7lyhfUyKLFbQKjKgzC1a0wzMzvXqSMmQDqQ3C8Zgq3gv/mlM+GnE6g2yhHPq1gsNXMqNqfHG1iEHc1EEpHE0ZLULHMZj
X-Gm-Message-State: AOJu0YyhXgBAcHvH4ZzBpGIDmUjxQJcditXQ2+hBZCGVDJGfl51FiSXb
	IbwEfxx8rzq9r+SneVIedOcFCWIRsaHTIA40QSAj5vYnedFvop2L0IxwUlaQBcpFT7fgA5YFyg+
	k+A==
X-Google-Smtp-Source: AGHT+IG32VHtdxdaUsDDPJunrvckiTWNO91gPhz+tHm9yc4gkYSQ85JHqlVjFo5Nvdj8OgpwD3v6pjKH7w4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:b96:b0:2c9:ba2b:42ac with SMTP id
 98e67ed59e1d1-2cb36d483c4mr6722a91.4.1721151297229; Tue, 16 Jul 2024 10:34:57
 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:34:55 -0700
In-Reply-To: <20240716160842.GD1482543@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <20240712232937.2861788-1-ackerleytng@google.com> <ZpaZtPKrXolEduZH@google.com>
 <20240716160842.GD1482543@nvidia.com>
Message-ID: <ZpavP3K_xAMiu4kE@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ackerley Tng <ackerleytng@google.com>, quic_eberman@quicinc.com, 
	akpm@linux-foundation.org, david@redhat.com, kvm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, maz@kernel.org, 
	pbonzini@redhat.com, shuah@kernel.org, tabba@google.com, willy@infradead.org, 
	vannapurve@google.com, hch@infradead.org, rientjes@google.com, 
	jhubbard@nvidia.com, qperret@google.com, smostafa@google.com, fvdl@google.com, 
	hughd@google.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 16, 2024, Jason Gunthorpe wrote:
> On Tue, Jul 16, 2024 at 09:03:00AM -0700, Sean Christopherson wrote:
> 
> > > + To support huge pages, guest_memfd will take ownership of the hugepages, and
> > >   provide interested parties (userspace, KVM, iommu) with pages to be used.
> > >   + guest_memfd will track usage of (sub)pages, for both private and shared
> > >     memory
> > >   + Pages will be broken into smaller (probably 4K) chunks at creation time to
> > >     simplify implementation (as opposed to splitting at runtime when private to
> > >     shared conversion is requested by the guest)
> > 
> > FWIW, I doubt we'll ever release a version with mmap()+guest_memfd support that
> > shatters pages at creation.  I can see it being an intermediate step, e.g. to
> > prove correctness and provide a bisection point, but shattering hugepages at
> > creation would effectively make hugepage support useless.
> 
> Why? If the private memory retains its contiguity seperately but the
> struct pages are removed from the vmemmap, what is the downside?

Oooh, you're talking about shattering only the host userspace mappings.  Now I
understand why there was a bit of a disconnect, I was thinking you (hand-wavy
everyone) were saying that KVM would immediately shatter its own mappings too.

> As I understand it the point is to give a large contiguous range to
> the private world and use only 4k pages to give the hypervisor world
> access to limited amounts of the memory.
> 
> Is there a reason that not having the shared memory elevated to higher
> contiguity a deal breaker?

Nope.  I'm sure someone will ask for it sooner than later, but definitely not a
must have.

