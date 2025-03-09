Return-Path: <linux-kernel+bounces-553316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C579CA5875B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A6E169895
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BE1F8752;
	Sun,  9 Mar 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCg6vyX4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FF2556E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546341; cv=none; b=T4D/reA85gBh1TFbK2pS8cvxTlBB8juqBUd4fITQcW10mJmc9BugMaDgvb/p/IdCaNiAJZMh8EneIkhobqxef4r1L6CyRU+gnyVL0qZBNcQte+41z5X7RQ7ruIti94jRBKdyPtjArCYfPMbigOLyiWfhVAoUDNIZ06p9NW18dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546341; c=relaxed/simple;
	bh=zXJZIdGJR4OS9afIEosSDb+g7DJuyc8R4tm7TR6XlYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu7rPzvriaryM+20/lvC9Q2W7mA1kC7fbLIkNk6Eua2Wed8HSbOQml+2EH7KWiC5TwxjXKtdGxjFmUW/puqSTzy0rSzNdDK1YYZ/eh1T+t00hqkF4YtYfXMGKlYqY0ng/EVfT36J1icrhjkRfiZHtWmNC3K+p9ZXRnp1xuHjaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCg6vyX4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2242aca53efso145385ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741546339; x=1742151139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0F9uAQ7tctvQCnO0ZWm2wGaaH5f4voNwAJg6oGX9SI=;
        b=NCg6vyX4WZXQu6zrAm1Nis9GmixG/GZ7SVWr512m9nfSu/RMgQ+J2G6wwBc0J0V4dc
         I7kURwAzsFCFDNr7V4HCqNIRCwhjwRJPGjFDWxnqMGc10kpuRejJivB02NC/36EBC9oH
         uemrg86+eZw4WvV6I+vjC0p7Tps5KxPAOSN6RcDRS1HJvY7Yyu57K4nw8BE+17hF29l9
         skWZnPR4woVP3z4gSJLYXpQYEOeWTt87qSu7i1Jdu8/HkgfbpT2Tg7LyQ8oCKghkPCrM
         QP3R7CVNTwNWeSpOMAh/ztweNUF7WJhDPf5HdT5rovyeFS45FKx7vUlla9kTRsLZqM7f
         0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741546339; x=1742151139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0F9uAQ7tctvQCnO0ZWm2wGaaH5f4voNwAJg6oGX9SI=;
        b=tCel5X75F6xGkeK8DjCpCSNd8zRmTSMwaR7VW1/H4LVBdRx7sYIygBqaNRaSOye670
         UaouDilL5R7rzoA5CKsCXJCEayHY9unk4Z0O96X7StQZFsOnObjdxqk+CA1Ved1hRvKY
         qwpWB2qAsma6DG0mX+CgsQFd+69TB3mjcp+HCenz/UeZtg3cmhaSdrJwKPAPzfEGaD9z
         pYBhAZnQq16qil8owaz7s1TEk0t0ZyEtaddrZbg/CmD3ViJNkeT9YLFafZO370pA1rgW
         R7k6BsMBNsZ2g7URmiY6tspOKJ3Os7AHr1MLdJtDr+POb7aPZMv3pIVbOSf2zduJY189
         erqw==
X-Forwarded-Encrypted: i=1; AJvYcCVmm9OxSjF6Fcec7mmLg6LJJtqSQMioB+Nmr15pgxJH26tKQYQxyfVHt2Renk+/uWhmRCezV2ok1VTpQjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgFnhSKje4iYtykrxQOio3YVvMfgMFcTjY7v7m6HZScpFzrji
	wFTkF0l2tvH7rIEsOxhZ9nYOKh5+d+Hr7H8qA+joeVPzlKxkqAaMl4/46o05H04KmDv42cXj6qY
	Y0JSvd+ka8OKBYqoNctyDOgz3wB9bksm8yCgyzQpBtRlA8Lwh8S/v
X-Gm-Gg: ASbGncu+d/zp1U6IqxdyR3gOf0NDd0Dc0vWPTCy1K4Ij8DH5gr9ycKVuYbbSmhFR8KJ
	TqGLiZCvhRIVucEpFyrQ/eyivfgAVS7QmCsoUrWxE4hl4uvhTCD1w/bBV7bmRUXEd1BlBaP8V/a
	z8xaZWbb4BvUHY9hbht/2xgHyVwticmCAN/nJ0U9GXkY7WtxlaG6UzDnk5N2M=
X-Google-Smtp-Source: AGHT+IFG9SSJTufI0eFYbf0wQm2WofP3DAL5foaE083K56zTD/V1FvHHIehtuzbAThLlpAJshuGX+RU/r/N5IlTVF58=
X-Received: by 2002:a17:903:32c7:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-22540e5a9aemr2472185ad.6.1741546338366; Sun, 09 Mar 2025
 11:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226082549.6034-1-shivankg@amd.com> <CAGtprH8akKUF=8+RkX_QMjp35C0bU1zxGi4v1Zm5AWCw=8V8AQ@mail.gmail.com>
In-Reply-To: <CAGtprH8akKUF=8+RkX_QMjp35C0bU1zxGi4v1Zm5AWCw=8V8AQ@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sun, 9 Mar 2025 11:52:05 -0700
X-Gm-Features: AQ5f1JrURSpnxKRR4ttTpVJoZfdt94X5FqXT7N9vOmgEqpVIhGKcMYbUZvLcn9Y
Message-ID: <CAGtprH8Rzgg55knK467NEZ3gnhNFhYA8fL3zda188wgcmj1YYA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add NUMA mempolicy support for KVM guest-memfd
To: Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, seanjc@google.com, ackerleytng@google.com, 
	david@redhat.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:09=E2=80=AFPM Vishal Annapurve <vannapurve@google.=
com> wrote:
>
> On Wed, Feb 26, 2025 at 12:28=E2=80=AFAM Shivank Garg <shivankg@amd.com> =
wrote:
> >
> > In this patch-series:
> > Based on the discussion in the bi-weekly guest_memfd upstream call on
> > 2025-02-20[4], I have dropped the RFC tag, documented the memory alloca=
tion
> > behavior after policy changes and added selftests.
> >
> >
> > KVM's guest-memfd memory backend currently lacks support for NUMA polic=
y
> > enforcement, causing guest memory allocations to be distributed arbitra=
rily
> > across host NUMA nodes regardless of the policy specified by the VMM. T=
his
> > occurs because conventional userspace NUMA control mechanisms like mbin=
d()
> > are ineffective with guest-memfd, as the memory isn't directly mapped t=
o
> > userspace when allocations occur.
> >
> > This patch-series adds NUMA binding capabilities to guest_memfd backend
> > KVM guests. It has evolved through several approaches based on communit=
y
> > feedback:
> >
> > - v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
> > - v3: Introduced fbind() syscall for VMM memory-placement configuration=
.
> > - v4-v6: Current approach using shared_policy support and vm_ops (based=
 on
> >       suggestions from David[1] and guest_memfd biweekly upstream call[=
2]).
> >
> > For SEV-SNP guests, which use the guest-memfd memory backend, NUMA-awar=
e
> > memory placement is essential for optimal performance, particularly for
> > memory-intensive workloads.
> >
> > This series implements proper NUMA policy support for guest-memfd by:
> >
> > 1. Adding mempolicy-aware allocation APIs to the filemap layer.
>
> I have been thinking more about this after the last guest_memfd
> upstream call on March 6th.
>
> To allow 1G page support with guest_memfd [1] without encountering
> significant memory overheads, its important to support in-place memory
> conversion with private hugepages getting split/merged upon
> conversion. Private pages can be seamlessly split/merged only if the
> refcounts of complete subpages are frozen, most effective way to
> achieve and enforce this is to just not have struct pages for private
> memory. All the guest_memfd private range users (including IOMMU [2]
> in future) can request pfns for offsets and get notified about
> invalidation when pfns go away.
>
> Not having struct pages for private memory also provide additional benefi=
ts:
> * Significantly lesser memory overhead for handling splitting/merge opera=
tions
>     - With struct pages around, every split of 1G page needs struct
> page allocation for 512 * 512 4K pages in worst case.
> * Enable roadmap for PFN range allocators in the backend and usecases
> like KHO [3] that target use of memory without struct page.
>
> IIRC, filemap was initially used as a matter of convenience for
> initial guest memfd implementation.
>
> As pointed by David in the call, to get rid of struct page for private
> memory ranges, filemap/pagecache needs to be replaced by a lightweight
> mechanism that tracks offsets -> pfns mapping for private memory
> ranges while still keeping filemap/pagecache for shared memory ranges
> (it's still needed to allow GUP usecases). I am starting to think that

Going one step further, If we support folio->mapping and possibly any
other needed bits while still tracking folios corresponding to shared
memory ranges along with private memory pfns in a separate
"gmem_cache" to keep core-mm interaction compatible, can that allow
pursuing the direction of not needing filemap at all?

> the filemap replacement for private memory ranges should be done
> sooner rather than later, otherwise it will become more and more
> difficult with features landing in guest_memfd relying on presence of
> filemap.
>
> This discussion matters more for hugepages and PFN range allocations.
> I would like to ensure that we have consensus on this direction.
>
> [1] https://lpc.events/event/18/contributions/1764/
> [2] https://lore.kernel.org/kvm/CAGtprH8C4MQwVTFPBMbFWyW4BrK8-mDqjJn-UUFb=
Fhw4w23f3A@mail.gmail.com/
> [3] https://lore.kernel.org/linux-mm/20240805093245.889357-1-jgowans@amaz=
on.com/

