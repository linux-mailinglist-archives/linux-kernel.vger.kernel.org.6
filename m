Return-Path: <linux-kernel+bounces-241687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49573927DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85081F23E13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9613CA81;
	Thu,  4 Jul 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRgzAyGp"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165004C637
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122372; cv=none; b=MgxgozuBtRBZW1+dBJN832auJ75YvIv3d2QdDO+s9Oz+RrJsqXcUmUglQ4Jg9kLEFtBOd0rAGBxkvASERCPJJDTSMBF1hE/SMy1SSxws2FaM6P6gocz/f9Yqsur6ZB76/VTKkzQN5LeILaRAelxUpIZkbx78HPo89KLCIymsfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122372; c=relaxed/simple;
	bh=SckqjxUr8L8tVX8Nso0MjaJPODmapwTAUO49uv7Yfqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL81l4T9b6N7zt5CJ+4W8vM+suBBy1+Yv7BcvjSXX+etvTKDbqEuoMoX46Tb+TJGULV8g3/RUsTqivsGDm8nYAHbvzHhXGw2h+EkKtajTDAvOqe0VnmDS5zfVDfzNKbaEXpcpsk/KrvQ4BCH4mxcPHczPpo+dWU0u5V7exxH2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRgzAyGp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44664ad946eso336371cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720122370; x=1720727170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfTs+c6tWogjOwpdCdqI/4bO1J7Lrmxq3+VtWrtGVqc=;
        b=SRgzAyGpZZbgv4hBA678s7iundz8Tfdphhi3hZiJlvvK60M99DO2NQXIHvuGtuXRe2
         d/trDet/nytFNSpjT/6XDvafFcnFvhrJVe0adZ0fOxD+f5dJO44YJsHFAL5Pk4WltpLq
         8nhHmrP+Uqj8TRy05OFzZa0A34hv0DEmUcer0QqG5FpXxmcVcPxpAtZ6cYCpdCURpeQb
         if8Ot02y44ewUf960C53qNcbjkJyvMyYedzZVd/JUWzSHZG57JdPamO/Mhg6yH9WIy2u
         p5bCcYp9rJeqhpaDxorkJonoorfcgF2Oklm0Lnsw35o3XHz7l/6PlVTkeqGQ9hL86rJo
         jpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720122370; x=1720727170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfTs+c6tWogjOwpdCdqI/4bO1J7Lrmxq3+VtWrtGVqc=;
        b=lHEdojT0YGzoZ/OxF7msjspMo6Tjs3UunCeDChownwFOreO7qoC3IOUMPXggxJJWco
         jtkrlxlHcTJfK5bU7KRpEqY6sVjnkBbLaZa5CUsFB3YkjwdgkOgPS3taFpDXTmVhLVhc
         RpNjngPlwh4iP/rJ/sU040YAxzsSeVzg8kMx2YbpZshAkjdPvvTv6DrohhX/0oafrSQc
         XAj6ezmPZGcOVn4wjB772NIA5P2B68s24+BKE5mMcggIDe0rbm/7FhmWzb+L4SXqXxAh
         mA9t5h0ZFJwelmHqJxmIU6d6PMAz/YDlNdwdsGI6TnVVMjAUoN8aCUL02N3jrQobbzM7
         hicQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9pxrKM0LVJWIgM87gEhc3GoxZdVINZdc2rLpPsfs5gNh0JVqdwvV84ka85H0Vg433aKRl6G+r4YFGiSfezSWWnggX6Gfdo+P2LFwN
X-Gm-Message-State: AOJu0YybkYJnihqBmWl/qWhkMLQ1DzMseQ5YRT63l1MBLxpexhQcRhwx
	tae84un2Ig+WqBJWnSVYCOPzf6IIXt/ezfawL5OoR1aCmTbQjariHnbuWbr3Sbw0xe80ZKNem78
	hL9i1ze8f0yVVc276MDvMq/s19OVIL5n7VdB6
X-Google-Smtp-Source: AGHT+IEcqpbDsCmz8L+dNVIWPBxow0ZX8QbEgnZTJCk4plKWtw4268sklGrFIEoyqu4GemhN0khOwgHpS8Snam3Hy3w=
X-Received: by 2002:ac8:5652:0:b0:444:d4d0:8a8e with SMTP id
 d75a77b69052e-447c8fbee38mr3470821cf.14.1720122369618; Thu, 04 Jul 2024
 12:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck> <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <ZcN1hTrAhy-B1P2_@arm.com> <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck> <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
 <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com> <ZnkGps-vQbiynNwP@google.com>
 <17232655-553d-7d48-8ba1-5425e8ab0f8b@huawei.com> <CAOUHufY8AZ7Td=OKg+Bbbnk+B-XspJQH2XDsEeZsiDJ-GuQgcQ@mail.gmail.com>
 <06252b78-2b61-73d1-ddf8-920dd744c756@huawei.com>
In-Reply-To: <06252b78-2b61-73d1-ddf8-920dd744c756@huawei.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 4 Jul 2024 13:45:31 -0600
Message-ID: <CAOUHufbq5LN+crcZ0hV1uKNCvSa2Z9fmc55SvpEqb1CTqDRSTw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: David Rientjes <rientjes@google.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Matthew Wilcox <willy@infradead.org>, muchun.song@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, anshuman.khandual@arm.com, 
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Sourav Panda <souravpanda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 5:47=E2=80=AFAM Nanyong Sun <sunnanyong@huawei.com> =
wrote:
>
> On 2024/6/28 5:03, Yu Zhao wrote:
> > On Thu, Jun 27, 2024 at 8:34=E2=80=AFAM Nanyong Sun <sunnanyong@huawei.=
com> wrote:
> >>
> >> =E5=9C=A8 2024/6/24 13:39, Yu Zhao =E5=86=99=E9=81=93:
> >>> On Mon, Mar 25, 2024 at 11:24:34PM +0800, Nanyong Sun wrote:
> >>>> On 2024/3/14 7:32, David Rientjes wrote:
> >>>>
> >>>>> On Thu, 8 Feb 2024, Will Deacon wrote:
> >>>>>
> >>>>>>> How about take a new lock with irq disabled during BBM, like:
> >>>>>>>
> >>>>>>> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t p=
te)
> >>>>>>> +{
> >>>>>>> +     (NEW_LOCK);
> >>>>>>> +    pte_clear(&init_mm, addr, ptep);
> >>>>>>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> >>>>>>> +    set_pte_at(&init_mm, addr, ptep, pte);
> >>>>>>> +    spin_unlock_irq(NEW_LOCK);
> >>>>>>> +}
> >>>>>> I really think the only maintainable way to achieve this is to avo=
id the
> >>>>>> possibility of a fault altogether.
> >>>>>>
> >>>>>> Will
> >>>>>>
> >>>>>>
> >>>>> Nanyong, are you still actively working on making HVO possible on a=
rm64?
> >>>>>
> >>>>> This would yield a substantial memory savings on hosts that are lar=
gely
> >>>>> configured with hugetlbfs.  In our case, the size of this hugetlbfs=
 pool
> >>>>> is actually never changed after boot, but it sounds from the thread=
 that
> >>>>> there was an idea to make HVO conditional on FEAT_BBM.  Is this bei=
ng
> >>>>> pursued?
> >>>>>
> >>>>> If so, any testing help needed?
> >>>> I'm afraid that FEAT_BBM may not solve the problem here
> >>> I think so too -- I came cross this while working on TAO [1].
> >>>
> >>> [1] https://lore.kernel.org/20240229183436.4110845-4-yuzhao@google.co=
m/
> >>>
> >>>> because from Arm
> >>>> ARM,
> >>>> I see that FEAT_BBM is only used for changing block size. Therefore,=
 in this
> >>>> HVO feature,
> >>>> it can work in the split PMD stage, that is, BBM can be avoided in
> >>>> vmemmap_split_pmd,
> >>>> but in the subsequent vmemmap_remap_pte, the Output address of PTE s=
till
> >>>> needs to be
> >>>> changed. I'm afraid FEAT_BBM is not competent for this stage. Perhap=
s my
> >>>> understanding
> >>>> of ARM FEAT_BBM is wrong, and I hope someone can correct me.
> >>>> Actually, the solution I first considered was to use the stop_machin=
e
> >>>> method, but we have
> >>>> products that rely on /proc/sys/vm/nr_overcommit_hugepages to dynami=
cally
> >>>> use hugepages,
> >>>> so I have to consider performance issues. If your product does not c=
hange
> >>>> the amount of huge
> >>>> pages after booting, using stop_machine() may be a feasible way.
> >>>> So far, I still haven't come up with a good solution.
> >>> I do have a patch that's similar to stop_machine() -- it uses NMI IPI=
s
> >>> to pause/resume remote CPUs while the local one is doing BBM.
> >>>
> >>> Note that the problem of updating vmemmap for struct page[], as I see
> >>> it, is beyond hugeTLB HVO. I think it impacts virtio-mem and memory
> >>> hot removal in general [2]. On arm64, we would need to support BBM on
> >>> vmemmap so that we can fix the problem with offlining memory (or to b=
e
> >>> precise, unmapping offlined struct page[]), by mapping offlined struc=
t
> >>> page[] to a read-only page of dummy struct page[], similar to
> >>> ZERO_PAGE(). (Or we would have to make extremely invasive changes to
> >>> the reader side, i.e., all speculative PFN walkers.)
> >>>
> >>> In case you are interested in testing my approach, you can swap your
> >>> patch 2 with the following:
> >> I don't have an NMI IPI capable ARM machine on hand, so I think this f=
eature
> >> depends on a higher version of the ARM cpu.
> > (Pseudo) NMI does require GICv3 (released in 2015). But that's
> > independent from CPU versions. Just to double check: you don't have
> > GICv3 (rather than not have CONFIG_ARM64_PSEUDO_NMI=3Dy or
> > irqchip.gicv3_pseudo_nmi=3D1), is that correct?
> >
> > Even without GICv3, IPIs can be masked but still works, with a less
> > bounded latency.
> Oh=EF=BC=8CI misunderstood. Pseudo NMI is available. We have
> CONFIG_ARM64_PSEUDO_NMI=3Dy
> but did not set irqchip.gicv3_pseudo_nmi=3D1 by default. So I can test
> this solution after
> opening this in cmdline.
>
> >> What I worried about was that other cores would occasionally be interr=
upted
> >> frequently(8 times every 2M and 4096 times every 1G) and then wait for=
 the
> >> update of page table to complete before resuming.
> > Catalin has suggested batching, and to echo what he said [1]: it's
> > possible to make all vmemmap changes from a single HVO/de-HVO
> > operation into *one batch*.
> >
> > [1] https://lore.kernel.org/linux-mm/ZcN7P0CGUOOgki71@arm.com/
> >
> >> If there are workloads
> >> running on other cores, performance may be affected. This implementati=
on
> >> speeds up stopping and resuming other cores, but they still have to wa=
it
> >> for the update to finish.
> > How often does your use case trigger HVO/de-HVO operations?
> >
> > For our VM use case, it's generally correlated to VM lifetimes, i.e.,
> > how often VM bin-packing happens. For our THP use case, it can be more
> > often, but I still don't think we would trigger HVO/de-HVO every
> > minute. So with NMI IPIs, IMO, the performance impact would be
> > acceptable to our use cases.
> >
> > .
> We have many use cases so that I'm not thinking about a specific use case=
,
> but rather a generic one. I will test the performance impact of different
> HVO trigger frequencies, such as triggering HVO while running redis.

Thanks, and if it's not good enough for whatever you are going to
test, we can batch the updates at least at the PTE level, or even at
the PMD level.

