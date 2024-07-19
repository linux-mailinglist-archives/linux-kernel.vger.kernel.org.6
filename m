Return-Path: <linux-kernel+bounces-257372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74F937925
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A26B22573
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8B13A276;
	Fri, 19 Jul 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0tisWrD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6C1E871
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399232; cv=none; b=p22yY5xVwrHD65KwdIUMn+7gVe9jtPs5jROg7lnhNue2pulUYsst7HpL34ogDgBq8XzNnUUtRkadPzSZs7sKDFzAGn88yt7SRLOabqSK8N73mzxBivWR+v8XiHmiM58cIVj0vpi6JyfWztZwkTQTn5aWYRqn5k96K8jFDs/s9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399232; c=relaxed/simple;
	bh=7tRylOOg9aUyw5QsLl6E6hK+Dz4+eeAsgOslnuDxZkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBt0v8To/zpNib8AzBi9XqBoOxWscxT42kbU5bhRXgjOUfCPc+6rHMfFPmpsNV/sA5LVtvWpVRegDBHRXob3jDsO9xW/h0odYfgC6J/02Jx50h22QecCk3uM9IsO17mLTxIMP+SRR0Pu+prYCoXcpsdgivBKnQ8DrdEA/jXwASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0tisWrD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ed741fe46so2214947e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721399229; x=1722004029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+osyaJNx4mfMZk2eanEYAdvwKA1Rms6iSrfEr1XNps=;
        b=R0tisWrDPD35N5Q8LTLraNDVz8ch7qxkEDW3k6RlWuf9vm+TuCHt6oCnhaTh3VCgUI
         f0XXIFiafiEfW5QWTuJM84KzPQtiSpo7OSepN0vAVqDflJjP9iVreFzocWCcPMWv7FE0
         MJQDhJQ2aW5ZvqswqjnycVKtz62PqhCL5SgZI5OrN7YTucsyFA18ha4JcPbS0bAl6171
         pnhiRk3MugSEBh7f8s/WKixWieF0fqkrFCVvt81ekR7NRupyXBFOno3W1a/W8EJTxGWQ
         oUEdDwi3HTdR2x6lz2UF/A4pLVnRDywy2Iyl4CplkzJuB+d6zTb4Oiy+UFhIagjL6vAv
         LOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399229; x=1722004029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+osyaJNx4mfMZk2eanEYAdvwKA1Rms6iSrfEr1XNps=;
        b=sWpoVzBCi5nF5MDZjXDzOn1Me3uJwbusy2lV3/ifzacOEpqjCcHxeDKn1HSQrGo1gu
         VyRfV42NBjRpty6PcVY0ATa1vknhhch05j0Ki/WlYc10EgOHI3H4/vgtQI8TkdkrCtOz
         wh29W9eERFZ/Q3+4k5pa1RB8uAawc7WbVcSleQTu9ZYUE/5GohLeCE4+DbVbJBiiX2pY
         K/uBRlYDcNyKubIW8pmowdRQqBDf+JD6DeWoInSo6R81HgoykhZN24nJBQhUB+mVKIem
         hUGdyIIwQAf5i7f3nkzLgqvERGn1WSd+jNc0lZCvsr7QwxtYRj8ksBLDoo487FkFLgg1
         Ii/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEL4zzT2RRTCQOVSQUVKyayCCwA2+S6Va+srzqjpkv97AEri4/udY1adqUXZZ+4N563wtgVmZbHVX/mwcDGFEAcqcmaTdQwcdmdTEH
X-Gm-Message-State: AOJu0YyYn+/B5LJRD6WkivAC63vUiHAL3VNgo68MSrmFZcaPsKFtu6fq
	i6+t/Jhsvf9k3BUGPYvmIxCiWwyjoyK399JmP4ce8R/rKu9o70hdHo8Bvx3TUNgMPPpSE8sn36M
	th5QIiR59t0teDPIn6XQGyqJu6cgobQ==
X-Google-Smtp-Source: AGHT+IEf4pZtVJ+V6gYfLN/60C2qztF+Mjf3NHIRKamIshYpH62Za/TqThNueJ8rw2+8mpx50FLfuDK9cWccpvXo2C0=
X-Received: by 2002:a05:6512:12d4:b0:52e:a008:8f55 with SMTP id
 2adb3069b0e04-52ee5427198mr5690402e87.41.1721399228909; Fri, 19 Jul 2024
 07:27:08 -0700 (PDT)
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
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 19 Jul 2024 16:26:56 +0200
Message-ID: <CAGudoHEC6WD3NkssVz1gXzsBFa4WCSKKx2f6eDDC9q_Qh9nSdg@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 8:16=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
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
>

bottom line though messing with i_lock removal is not justified afaics

> >
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

So I think the problems at this point are all mm, so I'm kicking the
ball to that side.

--=20
Mateusz Guzik <mjguzik gmail.com>

