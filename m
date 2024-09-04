Return-Path: <linux-kernel+bounces-315592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7D96C498
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D012B23202
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443661E00BF;
	Wed,  4 Sep 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEnzQq7/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670F1E1337
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469149; cv=none; b=VLDwSiKpYWBwoLE1MV6OJysVDj9CWb4K7LkglxOe2AelTYlGatSt1+Eagz8iHBSdqycOleeT5oGTzgn60jWknaFXDOWhHqJkHbqiYMiNq9Md2fRbf+3mTwlyz6kdFewXHWEbuFaXvxWKKhgwiZwN+KHXCXg+YOpSdrAPM8yR7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469149; c=relaxed/simple;
	bh=v1CB9ImWnBS09j2TzKRaEV5BswHxsHTE4CMEUnt0+yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKHkiVxz7foTase23g49AS1CLvwajXKXlk2VijgnFVEoFgB2HKQq6Fnj42D774clh1yMNiRsuaVnFFSTOoFL+Kn16TpFvxTstkhHqrdkvzuZDeg5TIZXnfOUMDIqCx/xCqaHwcp+sQYpSyf8peLx2adQoQpLdxNZvsw+JLeETPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEnzQq7/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso670a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725469146; x=1726073946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1CB9ImWnBS09j2TzKRaEV5BswHxsHTE4CMEUnt0+yw=;
        b=tEnzQq7/FzPV8MaU1hW1anKblz1v7iaBGgW60wE+ACzQdptlkiBYRfOJEhtlgbtCfK
         U5u496qndXnVMh7KPl4Yzla28jLTXmdlvQGEi52bMg360cwsbs7/tjEE5xvjm/8rDh9n
         gYKfhfi+B7hzplSmFNrZQlV7U4CDY27P8VDhCuMWuPlkVnX3kQYWVTXp2vvzi01zxTOK
         u2leck/QLIAxAnGep980EYHFAq7RvZyL0EyjqRuWJIZGWloWpR6fjiQJ42X5GWvQTI3A
         ZoWsmi6hXqjr+5yHzQQWeKTEmY4BqAHRpbTQMRXVXNE7SgK7EVlFM4Z+Ky/wrFhwQxg6
         YMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469146; x=1726073946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1CB9ImWnBS09j2TzKRaEV5BswHxsHTE4CMEUnt0+yw=;
        b=Rb0t1beVOQlRnpki6KG/btp72eV4fRAH/WvMmDcQMES6AE3X6g1AOGvmwsLoVBZIs3
         JN/nrWlSQEWa2TQcINLBIgXQtaW7wdd81Siujx79Wm9P7Z0nxPNsC5HZzQtaC2uBdI7X
         4ckGOtE57xyYTzJqV+YsiNxyh8Uhx99CLE8khYCzpDYz+Tp7ZFKHc4X+HjgIaarVt22K
         Y3YBwVAJ/YWel7Xi9kb/qOVbh3ClW2Via4LdJVpWM3EcCmhteiPfOdlG8I2yjOZYzJQj
         gPJRhP2l5uKJC0wZxXaDMBOw9zam8g+VnxXxw8mxZj7tapr+47pozVKukYXi2/QC4b/O
         8nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyKVGQ4AUs3Tle5Nr5dGbvGAPd08LubBOSj2gT8mY/bpO7uV1lI351sN1tlEtqNgUrMne2NpUbMmp8Qao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZWEEtlkdnGA8cc7uLBOzyjpCqqInu3rd5a3VIkraNeg5crLZu
	pQgjPnQ1ZKDZy5CJuL2RgP2+qarW9fize41dsWD8FWJGjvolIi8vERjtlyF1IfEzktIrw1JRu0l
	8HppNWY/XUVz1fUtgwmON/OisaV2ILxbGD6U/
X-Google-Smtp-Source: AGHT+IG0aERy7faC+1a6oZmkUUhuQ4K85jcFSSvvPHiUncBSURkpbe0WpQYOSgoRnbA5jZ9RY4ycgAXL88BusZEB1Ro=
X-Received: by 2002:a05:6402:1c86:b0:5c3:c2fc:8de6 with SMTP id
 4fb4d7f45d1cf-5c3c2fc98ddmr144634a12.3.1725469145666; Wed, 04 Sep 2024
 09:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826204353.2228736-1-peterx@redhat.com> <CACw3F50Zi7CQsSOcCutRUy1h5p=7UBw7ZRGm4WayvsnuuEnKow@mail.gmail.com>
 <Zs5Z0Y8kiAEe3tSE@x1n> <CACw3F52_LtLzRD479piaFJSePjA-DKG08o-hGT-f8R5VV94S=Q@mail.gmail.com>
 <20240828142422.GU3773488@nvidia.com> <CACw3F53QfJ4anR0Fk=MHJv8ad_vcG-575DX=bp7mfPpzLgUxbQ@mail.gmail.com>
 <20240828234958.GE3773488@nvidia.com> <CACw3F52dyiAyo1ijKfLUGLbh+kquwoUhGMwg4-RObSDvqxreJw@mail.gmail.com>
 <20240904155203.GJ3915968@nvidia.com> <CACw3F52qyX-Ea99zV4c8NjyWKgtqAKtNc8GP0JTcLOCOjnEajg@mail.gmail.com>
 <20240904164324.GO3915968@nvidia.com>
In-Reply-To: <20240904164324.GO3915968@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 4 Sep 2024 09:58:54 -0700
Message-ID: <CACw3F53ojc+m9Xq_2go3Fdn8aVumxwmBvPgiUJgmrQP3ExdT-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] mm: Support huge pfnmaps
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>, 
	Oscar Salvador <osalvador@suse.de>, Borislav Petkov <bp@alien8.de>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Hildenbrand <david@redhat.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Alex Williamson <alex.williamson@redhat.com>, 
	ankita@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Wed, Sep 04, 2024 at 09:38:22AM -0700, Jiaqi Yan wrote:
> > On Wed, Sep 4, 2024 at 8:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> > >
> > > On Thu, Aug 29, 2024 at 12:21:39PM -0700, Jiaqi Yan wrote:
> > >
> > > > I think we still want to attempt to SIGBUS userspace, regardless of
> > > > doing unmap_mapping_range or not.
> > >
> > > IMHO we need to eliminate this path if we actually want to keep thing=
s
> > > mapped.
> > >
> > > There is no way to generate the SIGBUS without poking a 4k hole in th=
e
> > > 1G page, as only that 4k should get SIGBUS, every other byte of the 1=
G
> > > is clean.
> >
> > Ah, sorry I wasn't clear. The SIGBUS will be only for poisoned PFN;
> > clean PFNs under the same PUD/PMD for sure don't need any SIGBUS,
> > which is the whole purpose of not unmapping.
>
> You can't get a SIGBUS if the things are still mapped. This is why the
> SIGBUS flow requires poking a non-present hole around the poisoned
> memory.
>
> So keeping things mapped at 1G also means giving up on SIGBUS.

SIGBUS during page fault is definitely impossible when memory is still
mapped, but the platform still MCE or SEA in case of poison
consumption, right? So I wanted to propose new code to SIGBUS (either
BUS_MCEERR_AR or BUS_OBJERR) as long as the platform notifies the
kernel in the synchronous poison consumption context, e.g. MCE on X86
and SEA on ARM64.

>
> Jason

