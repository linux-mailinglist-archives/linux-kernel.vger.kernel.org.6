Return-Path: <linux-kernel+bounces-283920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BF94FA64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315FB1C221D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551EA19A2AC;
	Mon, 12 Aug 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x737uPt3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104A16B39A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506283; cv=none; b=Vm2QjJiW4QxBF9YauUJyjRcoBgNQB1Y/BOKBlXCn2QaM5RWFYgaATZUhYswNBnbrAPF39AdwdkDPLuTceiPNn5L9WiaetaaOcCcR1OVf+7FIiN8isDkmLOShH3Qxko2HDaB8MG/IcmaVf2gB3zTl40BFk+8nCSmGt3Z+9uglIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506283; c=relaxed/simple;
	bh=og2jGoSIaOvN+vgjl3Gnk8vzLJN9Kbs7eJ5weuEalGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MR0lVY7zVEZbAFZS3v7dv38t95B2JAGPBDXFk7Of4iq23crwQSmOKEEsPoo63fXvEHBaf4HmEdRGZowSSkOGYg/URANf9sJ8oJaUo5nbZWXGBdJT0mEnfbIL24b+nYzZBlsHqonaVXenHUmQ5pJZPkxiPkJpcjIGo17Y/2zng8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x737uPt3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70e97ac260eso4346290b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723506281; x=1724111081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrUY3rIeJYoBe0Ouux9HKw4xsjRgOYNubTcynFZwH0s=;
        b=x737uPt3x3hICgl3+t4q7oTYK/GhWhPGpqv7T+NFC65QvS7Jdp8eAOHfHy2rLEXBbB
         nnUUneKmjViRDc8LkCjjXpMzqQX5Vaisa5twteOkgEeIPZ+6wbr15ozGIhLpglCgFdcY
         iP6mym4h1ZjUhw/GIUbk5s8hFvL69ItFrccNDEEALs+SOPY94JHrxS/HReZjkJ48gqCl
         qThKthuD/YJ1CpcfabmgqdkOlLd+ojelTMhaGyUrLhZeywZ10ZtZFow2IpJJqmtqzZQe
         SWDlKRWyQ5z56Nmw3WkPLjGBphfIL038JiQIWuOb09BRp+V7duOe2Z9qpP74CtXelUlU
         rM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506281; x=1724111081;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UrUY3rIeJYoBe0Ouux9HKw4xsjRgOYNubTcynFZwH0s=;
        b=WsNhD9moD6eTO3LHT8Ki7z6RgEUCBwbQjTV5Aeix7wtXCLnq+ppe4y3WYNXpkAPcTF
         ssmd8MSbmvMpcX6m5ZoexFBQNGnAi8eDK1m4XdI+2FAIV83O/jwFDzOHf2F0btG+8Mb9
         QNa+KjT/SWft90rYl+BUx22oQcuklR1FPX3GMn4ZBrdTevbglchvt1ErB5zD3FIO/zDA
         AhB8lN3V+YhvOTaResbfGGyWOisezc+DhGPQd6KOtS4LCxYbMF2Ode+8lz3TeQ+j33EB
         8KrhwtdZ9GSt/QvSlYjKF+14vr6TL01R25bKkzt+kKQbJo2f4X+LAIyEORG9cLpllry0
         P1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV5G42d8CvE12mUV51Z6eBZqrmSPrSLCgSuPH4JRedULJTcX8IZ/IDvqgdABMZsEVH3j0zeOTJnyYGYbmSe2DEr2Bm8b/2CpEKvRRHK
X-Gm-Message-State: AOJu0Yw59omfOeC8bKMM+4kO9yD93OJ/4VM5atNc5X8TwD09OKyElzO7
	1i58fHkQmLbpReDcizCCt5dX6EuPlWyUEFj7wVkbOOoPgwq5HM01kCwDBngFu3Dtc49WhFkj4Mc
	GJw==
X-Google-Smtp-Source: AGHT+IGdc2rxTHl1QtaSN9GH/Q9+wvgi/0cyWFA0UrSnLq1lqIiESyoGNp3cjAk7IHs7Im6Tod87VUtigrY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:66e8:b0:710:4d94:f9aa with SMTP id
 d2e1a72fcca58-712552c0336mr7070b3a.6.1723506281370; Mon, 12 Aug 2024 16:44:41
 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:44:40 -0700
In-Reply-To: <CAJHvVchObsUVW2QFroA8pexyXUgKR178knLoaEacMTL6iLoHNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809160909.1023470-1-peterx@redhat.com> <20240809160909.1023470-11-peterx@redhat.com>
 <CAJHvVciF4riGPQBhyBwNeSWHq8m+7Zag7ewEWgLJk=VsaqKNPQ@mail.gmail.com>
 <ZrpbP9Ow9EcpQtCF@x1n> <CAJHvVchObsUVW2QFroA8pexyXUgKR178knLoaEacMTL6iLoHNQ@mail.gmail.com>
Message-ID: <ZrqeaN2zeF8Gw-ye@google.com>
Subject: Re: [PATCH 10/19] KVM: Use follow_pfnmap API
From: Sean Christopherson <seanjc@google.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Oscar Salvador <osalvador@suse.de>, Jason Gunthorpe <jgg@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>, 
	David Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024, Axel Rasmussen wrote:
> On Mon, Aug 12, 2024 at 11:58=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > On Fri, Aug 09, 2024 at 10:23:20AM -0700, Axel Rasmussen wrote:
> > > On Fri, Aug 9, 2024 at 9:09=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > Use the new pfnmap API to allow huge MMIO mappings for VMs.  The re=
st work
> > > > is done perfectly on the other side (host_pfn_mapping_level()).
> > >
> > > I don't think it has to be done in this series, but a future
> > > optimization to consider is having follow_pfnmap just tell the caller
> > > about the mapping level directly. It already found this information a=
s
> > > part of its walk. I think there's a possibility to simplify KVM /
> > > avoid it having to do its own walk again later.
> >
> > AFAIU pfnmap isn't special in this case, as we do the "walk pgtable twi=
ce"
> > idea also to a generic page here, so probably not directly relevant to =
this
> > patch alone.

Ya.  My original hope was that KVM could simply walk the host page tables a=
nd get
whatever PFN+size it found, i.e. that KVM wouldn't care about pfn-mapped ve=
rsus
regular pages.  That might be feasible after dropping all of KVM's refcount=
ing
shenanigans[*]?  Not sure, haven't thought too much about it, precisely bec=
ause
I too think it won't provide any meaningful performance boost.

> > But I agree with you, sounds like something we can consider trying.  I
> > would be curious on whether the perf difference would be measurable in =
this
> > specific case, though.  I mean, this first walk will heat up all the
> > things, so I'd expect the 2nd walk (which is lockless) later be pretty =
fast
> > normally.
>=20
> Agreed, the main benefit is probably just code simplification.

+1.  I wouldn't spend much time, if any, trying to plumb the size back out.
Unless we can convert regular pages as well, it'd probably be more confusin=
g to
have separate ways of getting the mapping size.

