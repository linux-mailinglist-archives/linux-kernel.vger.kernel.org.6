Return-Path: <linux-kernel+bounces-286662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7EC951DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A211B28BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0631B3F01;
	Wed, 14 Aug 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9Ov0I7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07D1B372E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646566; cv=none; b=jrB0dZKcLh2n5PBttAiCUPN+mWI6KXSnPkuboXK+8x8TqJYTbecglNXbfRqdFhKzMjAb0Q8hWeXkeC9ZTJhth0QXKOLizL3Xu61uXaQgNuu/WhvPxYoXuCI+DG0n7806FOvVoDISUtRJf6oPvQcGoD3BcMrP5cEejWht7qkrNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646566; c=relaxed/simple;
	bh=aDnv0IqT062+fKLr04AH2+xuNLUhOsdmpPpXsIdGfVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfSZFBnBmhymQc/X897bFlv/J+DhgM89kec3NOUMfu9ncm7rVb3L7o4hPiOygoBCN7QMWYin554HrVAqLj0+Qp5Zex8s8x1fycHfUJh4K0FFTlxoEW/xOW+cOH/yTFAgcNzAV7yJnfE3OE6/iy4NBaFsbHAgfFkgT80MeYMbQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9Ov0I7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723646563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVYdNdGbsg5hDvwTYOliW2fHo02oz1rG9FEP2u4lRJM=;
	b=X9Ov0I7Y6zMu/rztQMH5/itmeS8Rq4Tf+vFBumDNM+kon1gKQ3BC4EIObnnlXGopQsWGwy
	GWfikL7yVhaMTIgtStjgzqdeRcwh8fluQ3jZegNCyMrkBoPGLpLhDLyOkbdBz2pYVN/aDi
	qJMK3Wt+zxVFb4LocpeDzXcOTzPp9jQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-NhnNhuDYOiqJNQYxj92Kvg-1; Wed, 14 Aug 2024 10:42:42 -0400
X-MC-Unique: NhnNhuDYOiqJNQYxj92Kvg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427b7a2052bso76009015e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646561; x=1724251361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVYdNdGbsg5hDvwTYOliW2fHo02oz1rG9FEP2u4lRJM=;
        b=qsY+90MeW9naQC/WWT9m+DEwvTSvX34xNzpGOAFdOt7sf5HfHPam0GhhfogDQk3pWG
         VnxgFT1G6wp7Qw8jnzWwnksn2KhlJcKKJ/3zVTFOlPGFErBDFZ2mnBvNXwHkKH7JIaB+
         T5WALw+epibqWtgAOPr0xCVfpVTO2r2jcdh9w1JOqUA81ssTrVv1/mYJ0JTswbAa7Ovw
         DMiE11soh72BerXuyicuFOX8Hi73sYvCSNA8HdvCjMKUNO31Q1Oo6epqVI74PvVfuv//
         KomtredLvn4GCoyArUw0q2+URNhhNU9yTXdWIjxZ/YwOqwaa8PI0Q8MBl+71U2CZPpgL
         hK6A==
X-Forwarded-Encrypted: i=1; AJvYcCVZqcBzdIndEh/zhWisHy4ONPKbrESj0YzqJirdf696vRn8ACw/ZU8KuAAshu2AOKaf0rHkComgT+ORHAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pV6Yl4119RDacQh9FYRT5I1d0Bgwa4EMkes6qSmlzjeWlSqz
	Z8fjKo+H6Ad5Y/qUZx26YICvNT9sJgQJao0WrJWH0S1O6LxM/enn3S45yNbs6x6YqhRjOFqV/5P
	HChQTQwbrE1vh6bMf4o6cG+mvYdr4p/wUYggHeiuhdHt0bLFqSWF2PTn030HGvQ/wz8w7/uJwwp
	Y5625hu8SMKJR7cqHKTnzbVicGhVnxnAepDg4D
X-Received: by 2002:a05:6000:2ac:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-37177742ccamr3183757f8f.8.1723646561315;
        Wed, 14 Aug 2024 07:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtP+rSeBmdU6XVoONivIqjh3NiciH9BKIZVBTlvjlI3aofydQJhEqWOqQib+vR63crzrcjSC2qHRhrq2xiWUg=
X-Received: by 2002:a05:6000:2ac:b0:360:75b1:77fb with SMTP id
 ffacd0b85a97d-37177742ccamr3183718f8f.8.1723646560795; Wed, 14 Aug 2024
 07:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809160909.1023470-1-peterx@redhat.com> <20240814123715.GB2032816@nvidia.com>
 <ZrzAlchCZx0ptSfR@google.com>
In-Reply-To: <ZrzAlchCZx0ptSfR@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Aug 2024 16:42:28 +0200
Message-ID: <CABgObfbaRwob74An5=s+HiaRiPa2_z-LFF1sPtEtAHO8_VuF0g@mail.gmail.com>
Subject: Re: [PATCH 00/19] mm: Support huge pfnmaps
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>, 
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:35=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > vfio/iommufd will reassemble the contiguous range from the 4k PFNs to
> > setup the IOMMU, but KVM is not able to do it so reliably.
>
> Heh, KVM should very reliably do the exact opposite, i.e. KVM should neve=
r create
> a huge page unless the mapping is huge in the primary MMU.  And that's ve=
ry much
> by design, as KVM has no knowledge of what actually resides at a given PF=
N, and
> thus can't determine whether or not its safe to create a huge page if KVM=
 happens
> to realize the VM has access to a contiguous range of memory.

Indeed: the EPT is managed as a secondary MMU. It replays the contents
of the primary MMU, apart from A/D bits (which are independent) and
permissions possibly being more restrictive, and that includes the
page size.

Which in turn explains why the VA has to be aligned for KVM to pick up
the hint: aligning the VA allows the primary MMU to use a hugepage,
which is a prerequisite for using it in EPT.

Paolo


