Return-Path: <linux-kernel+bounces-367862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420279A07BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4352287793
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D62076A4;
	Wed, 16 Oct 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY8tXSo5"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE9206940
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075757; cv=none; b=KJELSnC/saLiGQ3pYK2bJpM9f3TlXE1Va/wdG81ECX9ssuHRmKp0EvzigzrP/MIto3qnL69FrGI4IVveSWB131g/0j4YxEqdHw6AKLZgllh/wMYkiMyS7+QKkoCe58YKHAHL//5tg5YRoG2JoRD64bpF5vPK5EfY2H63uSKdUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075757; c=relaxed/simple;
	bh=p3Uy6zh8Ol2qbVeWD/3mGVLL+TASPb0miaj+Lh6GDmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddY4/WfqCdUyepJZuvarqo8Jd6TykUDV5ya2/L4zHGBmKs0VkcCJOgSGZkuPpzVxA8GrLxUboHV7yZ2wSAvs14CxW3KOlbgl/bmCgD4hEbiOUe+Qei3ca23ihEzD43dkNLxuFPzl17sj4PE+rQhPP9TzzfG2ks4zxnUyEs/b5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY8tXSo5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso10113a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729075754; x=1729680554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqRqGRF1VySphqdyBOb5GNHPJs16AcbMlWU0XE/fB+o=;
        b=hY8tXSo5B2hNXHbPz0kMTx7PcuhgBP6B998zlRKZvuJPkLhb8AoEMfSDlMFYKlLA0U
         boEK6IymXrc9SM2hnwrRDorc8RJ+cztCA/pdKn7OmqgojXpW3m+kIUQUJTbOiabprlAX
         oqDYSGyWWl13GVddXNCiqUeSdTm9OGlD9gmGHIJ0kLMBtJzfJL81sm2MW4sXEK0rcjkt
         UuxP4UixGVPjS0a4WSmoTDOMEhJhAVRMv51SdcqNWIv6huxOM01iRPkKfVVZnBK5kF5U
         OLVQyzkVMwlFZvijofBXJzD4L1q60U8zbJTfV3z8e7UkXUyk85H0/fgek1LtCLM4NDRr
         q3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729075754; x=1729680554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqRqGRF1VySphqdyBOb5GNHPJs16AcbMlWU0XE/fB+o=;
        b=HILGjHr+s3Q8psorIpOpFx1+i46LNvmb86Z9AfRq4g2M6c4G3IcmQKXdu7/RAcjVqb
         P6sEnMPqhbjFUVG5C7kBwAWafMGeSXKBZCgtGECbbnaDpqtObPfQCb1tDvPhJ6+itc5z
         iQ2n8E95OB4sui8s/5hDRJeBZAqN19IF1UAuPL0bojHaOt8TzLyix7DLYecjnEPFFtr9
         BMZcqWXREeHZfkPlqmupLtJxHyHzeODyc0nfv28Pfj5wXMcoqxlVPce1YhLUoSgD1qrj
         QqNfGIFA8NYadnr1NnRbyQVmwm+XxWnIV5Pygu+dhs8RFRI6JRwBj9WJMYxyoxRCvs1F
         F6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUcndT1dmTecyqoUyGtXiuW3Hj5ZMnTXBa3O2XbWfTFQqcQNQSz/2kNoSDtbrWhb3JsopVFRxjMPqjDLeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61P8Q6zSTCRVvOI2bJ8/M4R8ZFoExisP2Ys+9FrqL4Dt8jyy3
	xHE7KfSwHpL2WOgXf1wj9c5puj7c/p7ffHbnwFhxp9KSpT6yPf7fTHOwtehENCEmtrtzJ8RCuOU
	JyYDUCoXkVx+iQOiZGKNhL5DnkwtTXjvXi7g8
X-Google-Smtp-Source: AGHT+IEOaQ4cgkPExzBkgZGD4dOtgPfim6YoQJY1ySC/ykGcUlK7ML3iO3mQ0h89zzZPsHTX3ghBdYyNrM7ENxR9XDk=
X-Received: by 2002:a05:6402:34c6:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5c997a90d4bmr449217a12.4.1729075742925; Wed, 16 Oct 2024
 03:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n> <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n> <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com> <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
In-Reply-To: <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 16 Oct 2024 16:18:49 +0530
Message-ID: <CAGtprH_AiVJAd4rxKZBC9372swf2hW8kFfWG2y7zBdzCmpLRUw@mail.gmail.com>
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: David Hildenbrand <david@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Peter Xu <peterx@redhat.com>, tabba@google.com, 
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com, 
	muchun.song@linux.dev, erdemaktas@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> I also don't know how you treat things like folio_test_hugetlb() on
> >> possible assumptions that the VMA must be a hugetlb vma.  I'd confess =
I
> >> didn't yet check the rest of the patchset yet - reading a large series
> >> without a git tree is sometimes challenging to me.
> >>
> >
> > I'm thinking to basically never involve folio_test_hugetlb(), and the
> > VMAs used by guest_memfd will also never be a HugeTLB VMA. That's
> > because only the HugeTLB allocator is used, but by the time the folio i=
s
> > mapped to userspace, it would have already have been split. After the
> > page is split, the folio loses its HugeTLB status. guest_memfd folios
> > will never be mapped to userspace while they still have a HugeTLB
> > status.
>
> We absolutely must convert these hugetlb folios to non-hugetlb folios.
>
> That is one of the reasons why I raised at LPC that we should focus on
> leaving hugetlb out of the picture and rather have a global pool, and
> the option to move folios from the global pool back and forth to hugetlb
> or to guest_memfd.
>
> How exactly that would look like is TBD.
>
> For the time being, I think we could add a "hack" to take hugetlb folios
> from hugetlb for our purposes, but we would absolutely have to convert
> them to non-hugetlb folios, especially when we split them to small
> folios and start using the mapcount. But it doesn't feel quite clean.

As hugepage folios need to be split up in order to support backing
CoCo VMs with hugepages, I would assume any folio based hugepage
memory allocation will need to go through split/merge cycles through
the guest memfd lifetime.

Plan through next RFC series is to abstract out the hugetlb folio
management within guest_memfd so that any hugetlb specific logic is
cleanly separated out and allows guest memfd to allocate memory from
other hugepage allocators in the future.

>
> Simply starting with a separate global pool (e.g., boot-time allocation
> similar to as done by hugetlb, or CMA) might be cleaner, and a lot of
> stuff could be factored out from hugetlb code to achieve that.

I am not sure if a separate global pool necessarily solves all the
issues here unless we come up with more concrete implementation
details. One of the concerns was the ability of implementing/retaining
HVO while transferring memory between the separate global pool and
hugetlb pool i.e. whether it can seamlessly serve all hugepage users
on the host. Another question could be whether the separate
pool/allocator simplifies the split/merge operations at runtime.

>
> --
> Cheers,
>
> David / dhildenb
>

