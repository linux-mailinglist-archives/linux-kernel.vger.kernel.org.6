Return-Path: <linux-kernel+bounces-257029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CA93742E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B537C1F21D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9044AEEA;
	Fri, 19 Jul 2024 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIMuntIy"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA12AEE3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721372817; cv=none; b=DHk9rb3LCjYqZQd51YXz+zwX56Gojg4qPqoLZQNLIJco1JgWF3Mkc6mXLogUVrV7pieZkwsNBvBRyXDyo8bA3iUXeQYGjQgPgjo9/XSRkUkD3CL5xpf4f6m5NYAeaWqYBwS4Oyc94rCdswYTM1CxODm0QNxd5RWAbtQuReMUg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721372817; c=relaxed/simple;
	bh=W7EKREv+TWYXZLHQ4XFUMTMiZGvj4GTx31dmk0hgDHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPnGWRvqDsgC3dYLnYSW/WM0j0byM0zYjOWukXfxgS+/dYFeaO4VmxVrQNzZDVafnN5T/0iKHvXLC9d6AwzMdsM7IODDNN49sbxhgvAzykn/OxicEZGzQr1NsUuxSIEpZdllWpk2duPLWxtYuoWYm46aMEwsue0GgbCKlhQwghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIMuntIy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44e534a1fbeso121481cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721372815; x=1721977615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE/dwtCx4oAQ+/i+dkdCGR6u+7VYJgdr2zsUeg2Do6M=;
        b=OIMuntIywoW1Bhyb/r+d60v2NkFOaQO0CvTuiCXa84MHj02AXdgKZZ3XYzSgHzAfsz
         uwV6DG6iA5gOuwsagVCO2iy/DPVFzY5okQCGfw2m6q8w1pxD9f/yJhe/Zp8VSqy0YKDN
         7AjOWcgzubq7tD3l9oS5XgLnGV6MOT+InWfj503rwwI4b4Qj9giuNwxy3VSVYonaVb25
         l832Yn0OKKHQmfsllpJ9VdV+02MJhIXESs4zmpzYL454Y0ZRvTrGqleAUC9DjiVvzGO5
         1X8S/NM1oD3IYzKyVnJqst48NPEpn3zHc5kUAKEhdUpuiOJ/QEPH/ixdcDqB5J6Fh679
         A3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721372815; x=1721977615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE/dwtCx4oAQ+/i+dkdCGR6u+7VYJgdr2zsUeg2Do6M=;
        b=gUd/SS8MqH1CY1Lp4v5C89IBfX6b2r5+A7mTsJcZTE8nzgt5a51tbas67yFBdpr0Qd
         VdcoCjhfRgH3sjdppSd1AVAfpaboDoeHDqdQeTj8lUZuqqfU5vUujL2wTqfrDQVKHzrw
         +46roDbqLAM9RpVrilvmdLV1KQcKreiBJkiSrqB+YuiYTDqDznhxsvasEhHNYJuZyX/B
         Iinup/8Erb3F14+3g8aFlYDywOigOXLmNlTdPBN17ooPxhE3YekUgRJUbO3+WjJ5nHJl
         2oJu0cZp7Ca1nRXaPugAHfVVZmkqNXYnp6vWKSAVkHqwaZf3NpO9MdxjQ51HaJSCVOn3
         73cg==
X-Forwarded-Encrypted: i=1; AJvYcCUFMlvQqfnkGU1Xz6GOgTHWHizsSfblu/wutDq6rrvGkakdN+nGxJkR0Ax48YJTsfLxK15zIIRbw3pTf6Jm7tvlHtTcN3s4HdYCq0VT
X-Gm-Message-State: AOJu0Yz01LKF7F0m+tFgO0D9OVSUEZYJcTlkx9EjPwalFspZxlN1HLvX
	MaqiK7kwlEeKA/nez2COeYjzRRiI0N3zIZKuuxb38a/6KRfyYP/kE9E9xEEhXFcV4yh1MjpwMoj
	Fe4V06DBAoGglor2wY4ODB9SZ4/FrG/UxGVch
X-Google-Smtp-Source: AGHT+IHZdcXWzegcKDolB1QWDnUlnCr1EWA+sDCaiSsPTYBd0kpLlbc4tdienODc3H6rInybnYMpfnpZxrmhZ8LwkpU=
X-Received: by 2002:a05:622a:2b0d:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-44f9c60c88dmr1643121cf.1.1721372814910; Fri, 19 Jul 2024
 00:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
 <CAGudoHESB-+kHPJO+4MHnUDPJXGP87=yJ2QrW3q8pkO5z7OLRw@mail.gmail.com>
 <44fb1971-f3d3-4af8-9bac-aceb2fedd2a6@amd.com> <CAGudoHFDZi=79GgtWHWw52kyu81ZK2O4=30YrKhPerDxXdxbKg@mail.gmail.com>
 <584ecb5e-b1fc-4b43-ba36-ad396d379fad@amd.com>
In-Reply-To: <584ecb5e-b1fc-4b43-ba36-ad396d379fad@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 19 Jul 2024 01:06:16 -0600
Message-ID: <CAOUHufbWNSEb6Mg4TOcnycD=aO0om0devY70NBqNNhwnwRzKvw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 12:16=E2=80=AFAM Bharata B Rao <bharata@amd.com> wr=
ote:
>
> On 18-Jul-24 5:41 PM, Mateusz Guzik wrote:
> > On Thu, Jul 18, 2024 at 11:00=E2=80=AFAM Bharata B Rao <bharata@amd.com=
> wrote:
> >>
> >> On 17-Jul-24 4:59 PM, Mateusz Guzik wrote:
> >>> As for clear_shadow_entry mentioned in the opening mail, the content =
is:
> >>>           spin_lock(&mapping->host->i_lock);
> >>>           xa_lock_irq(&mapping->i_pages);
> >>>           __clear_shadow_entry(mapping, index, entry);
> >>>           xa_unlock_irq(&mapping->i_pages);
> >>>           if (mapping_shrinkable(mapping))
> >>>                   inode_add_lru(mapping->host);
> >>>           spin_unlock(&mapping->host->i_lock);
> >>>
> >>> so for all I know it's all about the xarray thing, not the i_lock per=
 se.
> >>
> >> The soft lockup signature has _raw_spin_lock and not _raw_spin_lock_ir=
q
> >> and hence concluded it to be i_lock.
> >
> > I'm not disputing it was i_lock. I am claiming that the i_pages is
> > taken immediately after and it may be that in your workload this is
> > the thing with the actual contention problem, making i_lock a red
> > herring.
> >
> > I tried to match up offsets to my own kernel binary, but things went ha=
ywire.
> >
> > Can you please resolve a bunch of symbols, like this:
> > ./scripts/faddr2line vmlinux clear_shadow_entry+92
> >
> > and then paste the source code from reported lines? (I presume you are
> > running with some local patches, so opening relevant files in my repo
> > may still give bogus resutls)
> >
> > Addresses are: clear_shadow_entry+92 __remove_mapping+98 __filemap_add_=
folio+332
>
> clear_shadow_entry+92
>
> $ ./scripts/faddr2line vmlinux clear_shadow_entry+92
> clear_shadow_entry+92/0x180:
> spin_lock_irq at include/linux/spinlock.h:376
> (inlined by) clear_shadow_entry at mm/truncate.c:51
>
> 42 static void clear_shadow_entry(struct address_space *mapping,
> 43                                struct folio_batch *fbatch, pgoff_t
> *indices)
> 44 {
> 45         int i;
> 46
> 47         if (shmem_mapping(mapping) || dax_mapping(mapping))
> 48                 return;
> 49
> 50         spin_lock(&mapping->host->i_lock);
> 51         xa_lock_irq(&mapping->i_pages);
>
>
> __remove_mapping+98
>
> $ ./scripts/faddr2line vmlinux __remove_mapping+98
> __remove_mapping+98/0x230:
> spin_lock_irq at include/linux/spinlock.h:376
> (inlined by) __remove_mapping at mm/vmscan.c:695
>
> 684 static int __remove_mapping(struct address_space *mapping, struct
> folio *folio,
> 685                             bool reclaimed, struct mem_cgroup
> *target_memcg)
> 686 {
> 687         int refcount;
> 688         void *shadow =3D NULL;
> 689
> 690         BUG_ON(!folio_test_locked(folio));
> 691         BUG_ON(mapping !=3D folio_mapping(folio));
> 692
> 693         if (!folio_test_swapcache(folio))
> 694                 spin_lock(&mapping->host->i_lock);
> 695         xa_lock_irq(&mapping->i_pages);
>
>
> __filemap_add_folio+332
>
> $ ./scripts/faddr2line vmlinux __filemap_add_folio+332
> __filemap_add_folio+332/0x480:
> spin_lock_irq at include/linux/spinlock.h:377
> (inlined by) __filemap_add_folio at mm/filemap.c:878
>
> 851 noinline int __filemap_add_folio(struct address_space *mapping,
> 852                 struct folio *folio, pgoff_t index, gfp_t gfp, void
> **shadowp)
> 853 {
> 854         XA_STATE(xas, &mapping->i_pages, index);
>              ...
> 874         for (;;) {
> 875                 int order =3D -1, split_order =3D 0;
> 876                 void *entry, *old =3D NULL;
> 877
> 878                 xas_lock_irq(&xas);
> 879                 xas_for_each_conflict(&xas, entry) {
>
> >
> > Most notably in __remove_mapping i_lock is conditional:
> >          if (!folio_test_swapcache(folio))
> >                  spin_lock(&mapping->host->i_lock);
> >          xa_lock_irq(&mapping->i_pages);
> >
> > and the disasm of the offset in my case does not match either acquire.
> > For all I know i_lock in this routine is *not* taken and all the
> > queued up __remove_mapping callers increase i_lock -> i_pages wait
> > times in clear_shadow_entry.
>
> So the first two are on i_pages lock and the last one is xa_lock.

Isn't xa_lock also i_pages->xa_lock, i.e., the same lock?

> > To my cursory reading i_lock in clear_shadow_entry can be hacked away
> > with some effort, but should this happen the contention is going to
> > shift to i_pages presumably with more soft lockups (except on that
> > lock). I am not convinced messing with it is justified. From looking
> > at other places the i_lock is not a problem in other spots fwiw.
> >
> > All that said even if it is i_lock in both cases *and* someone whacks
> > it, the mm folk should look into what happens when (maybe i_lock ->)
> > i_pages lock is held. To that end perhaps you could provide a
> > flamegraph or output of perf record -a -g, I don't know what's
> > preferred.
>
> I have attached the flamegraph but this is for the kernel that has been
> running with all the accumulated fixes so far. The original one (w/o
> fixes) did show considerable time spent on
> native_queued_spin_lock_slowpath but unfortunately unable to locate it no=
w.
>
> Regards,
> Bharata.

