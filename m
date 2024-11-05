Return-Path: <linux-kernel+bounces-396858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02A9BD344
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF781C226F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9C91E32CF;
	Tue,  5 Nov 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ON7U6VP6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425A1E1335
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827319; cv=none; b=BovSI3aPydedkC1AsBbZlPfTYpfiyOma+LWVozAKBMahpEouOgvKzDJMCBdNAY8xT+nQxO8dsEe00Eib9J/ner0ppOTnNqLfyQh4eERnyrjqkYy//Efe/uXyJB6AhJI1yTyzDRk1ZzS/eIOuNFm1jTmwND7bRDlDgtG6RGNcDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827319; c=relaxed/simple;
	bh=D66gZ7X7+VYJX9wsXbBvZN4emEJA+HiBFRzwQAdTgS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS1KY/HzBvU3U7BHc+TQLFpF/sOyC3vXBxWNVdtIlkQpw7SLcWE5OxaRhhiIoxO0Tvi6gyKbfZQhKVp0bOwg+55fqALVycndpA31y3RJdLH6cE+fzO+yOetSCJJZPZ+60VK9dmsLcn1diXEPtr5ZALlgxTbaaA27bA/+OlxPXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ON7U6VP6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e617ef81so16003e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730827315; x=1731432115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Oa954kD6XCaRt5fGl4rXY5k6zboqDRGjgfVfwZcrQs=;
        b=ON7U6VP6nkVjIiNy2xYXMVxV8mZmxhcOIp2Ki0XddR1fCoAmiDLk3jEo2Htk21XDmD
         BeAGdrmf/qz2iE/NrV6sLHbyJnzouzP1iS2cfHxyadYGZhAOUMnIAsxzQOHchUAn6Otq
         pljwZon7UbYU+S6aUEfLCKcLdAI4t2nvibPFQ95e52GcrSuktje30KIyl/YWQt1sofD9
         Q7pATw48DAsdlIoBP7QnER7Jf//yrjBQztwUAIYY5S5YDKPyccLddND3Kz9Kn89lC31f
         sbq+HJjj1D2cPYXX7YLKLzUTa/v0J4NDCc7ur+bH6UCb2NDudjE/vYTgKx849BeYbzNw
         Bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827315; x=1731432115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Oa954kD6XCaRt5fGl4rXY5k6zboqDRGjgfVfwZcrQs=;
        b=O1zsGyO83H2NWn1Q+oe3FDiI0eppGvOErzXqBCd6ETyxJJq/v6232pU+2bqxJ7VHns
         RPjiUyatAl198YaSeJ7YZW2qbfncVCaOixSDDxVrpxdM4GujEMSlMHUCSA34gAGgZP4B
         PXkk80djYUezUfmYHQbBcrvIcXuoNn6jtJKR8Lj0JS04zGgjQ9nzNWoN1Juomen9D25n
         v9jI8b7FCR1OQJcYI+zjeOFIp7VKvsa3O+tyqfiQ0OzPK90KrFr1rKuTc7RJAhLpuIc1
         +bmgT27+NUOi5FWbCUEwAzCMRSObqw8otMVR3tpg2mdJj7iiIWbN8HKy2eULNNllKgqq
         48og==
X-Forwarded-Encrypted: i=1; AJvYcCW1y64DWXPNCyQ8gMe2Nc1H9mdusGUhHdDQ0odob+lRAk0Z1GcrdwvEfnE23hLuKJxGb0P/DFF8+S+brI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYZeyY90Ms6FBvrCVKskJcQdaY3KR4PwVuzyykRBNFvGx+409
	nx36rzacbQogQ4LYP6Tky8fRJ25KcpUgkMDNg2t28NKd7LccvRGlLU3lym/JMjEldABDGDlhUdf
	VqMCyX8eHDE46quDnOKTu8+teVhKcPUpS7Q/5
X-Gm-Gg: ASbGncshPUS29QqDVqTfCyPSZ+uMIo/yE74bKV+uMICz0IjzzZhdeq6r7LM9QH4Cvi+
	/UergxvzoD3BFwDDmJaVolVOWeKlF166tM8/Ppqaif7yZm83tzABcL+CNBW8=
X-Google-Smtp-Source: AGHT+IGm3F52/nNqqcOqRdxFJuhV5jymVu9gPUHEg4JCykt5fGL3gHiQJj1l8LCsSMEDvzdiWg89RqYTDaz/6NYopa4=
X-Received: by 2002:a19:385c:0:b0:52c:dd42:cf57 with SMTP id
 2adb3069b0e04-53d78288128mr270429e87.0.1730827314967; Tue, 05 Nov 2024
 09:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local> <CAG48ez1eeQatc0GC_hfOM_mvwjwQ=89JDmp_U5_diLy7ycjEdQ@mail.gmail.com>
 <94e4ba07-42bb-4567-b0c9-b719f81dc61b@lucifer.local>
In-Reply-To: <94e4ba07-42bb-4567-b0c9-b719f81dc61b@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Tue, 5 Nov 2024 18:21:17 +0100
Message-ID: <CAG48ez0t8QoeqmG7v=aXTo0AgiyBUur1Ba4gCmbi8v9zpuU+nA@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:10=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Mon, Nov 04, 2024 at 10:29:47PM +0100, Jann Horn wrote:
> > On Mon, Nov 4, 2024 at 5:42=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
> > > > On Fri, Nov 1, 2024 at 7:50=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > 3. PMD entries that point to page tables can be changed while holdi=
ng
> > > > the page table spinlocks for the entry and the table it points to
> > >
> > > Hm wut? When you say 'entry' what do you mean? Obviously a page table=
 in
> >
> > By "PMD entry" I mean a pmd_t (located in a Page Middle Directory),
> > and by "that point to page tables" I mean "that point to a PTE-level
> > page table".
> >
> > In other words, from the reader perspective (as I think you already
> > mentioned further down):
> >
> > Rule 2 means: From the perspective of a reader who is holding the VMA
> > lock in read mode, once you have seen that e.g. a PUD entry
> > (overlapping the VMA's virtual address region) points to a PMD page
> > table, you know that this PUD entry will keep pointing to that PMD
> > table.
> >
> > Rule 3 means: From the perspective of a reader who is holding the VMA
> > lock in read mode, once you have seen that a PMD entry (overlapping
> > the VMA's virtual address region) points to a page table, you don't
> > know whether this PMD entry will keep pointing to the same page table
> > unless you're also holding a spinlock on either the PMD or the page
> > table (because khugepaged).
>
> Thanks right I see what you mean.
>
> Might be worth having an explicit THP (thus khugepaged) section? And
> perhaps even KSM...

Maybe, yeah - I think it's important to roughly know what they do, but
I would still focus on what rules other parts of MM, or users of MM,
have to follow to not break in their interaction with things like THP
and KSM. So maybe kinda do it in the direction of "these are the rules
(and here is the detail of why we have those arbitrary-looking
rules)"?

> > But you're right, I was being imprecise - as you pointed out, it's not
> > just used for zapping. Maybe the right version of 6 is something like:
> >
> >     Leaf entries that are not in "none" state can
> >     be changed while holding any one of [...].
> >
> > Though I'm not sure if that is overly broad - I think in practice the
> > changes we make under the rmap locks are something like the following,
> > though that might be missing some:
> >
> >  - zapping leaf entries
> >  - zapping PMD entries pointing to page tables
> >  - clearing A/D bits
> >  - migration
> >
> > > OK so interestingly this really aligns with what Alice said as to thi=
s not
> > > giving a clear indicator from a user's perspective as to 'what lock d=
o I
> > > need to hold'.
> > >
> > > So I will absolutely address all this and try to get the fundamentals
> > > boiled down.
> > >
> > > Also obviously the exception to your rules are - _freeing_ of higher =
level
> > > page tables because we assume we are in a state where nothing can acc=
ess
> > > them so no such locks are required. But I cover that below.
> > >
> > > >
> > > > And then the rules for readers mostly follow from that:
> > > > 1 =3D> holding the appropriate page table lock makes the contents o=
f a
> > > > page table stable, except for A/D updates
> > > > 2 =3D> page table entries higher than PMD level that point to lower=
 page
> > > > tables can be followed without taking page table locks
> > >
> > > Yeah this is true actually, might be worth mentioning page table walk=
ers
> > > here and how they operate as they're instructive on page table lockin=
g
> > > requirements.
> > >
> > > > 3+4 =3D> following PMD entries pointing to page tables requires car=
eful
> > > > locking, and pte_offset_map_lock() does that for you
> > >
> > > Well, pte_offset_map_lock() is obtained at the PTE level right?
> >
> > pte_offset_map_lock() is given a pointer to a PMD entry, and it
> > follows the PMD entry to a PTE-level page table. My point here is that
> > you can't just simply start a "lock this PTE-level page table"
> > operation at the PTE level because by the time you've locked the page
> > table, the PMD entry may have changed, and the page table you just
> > locked may be empty and doomed to be deleted after RCU delay. So you
> > have to use __pte_offset_map_lock(), which takes a pointer to a PMD
> > entry, and in a loop, looks up the page table from the PMD entry,
> > locks the referenced page table, rechecks that the PMD entry still
> > points to the locked page table, and if not, retries all these steps
> > until it manages to lock a stable page table.
>
> Right yeah, I mean this is kind of a standard pattern in the kernel thoug=
h
> like:
>
> 1. Grab some pointer to something
> 2. Lock
> 3. Really make sure it hasn't disappeared from under us
> 4. If so, unlock and try again
> 5. Otherwise proceed
>
> You have this pattern with folios too...

Yeah, I agree the pattern you need for the access is not that weird,
it's just weird that you need it for page tables at one specific
level.

> > > pmd_lock() at the PMD level (pud_lock() ostensibly at PUD level but t=
his
> > > amounts to an mm->page_table_lock anyway there)
> >
> > > > I think something like
> > > > https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#ov=
erview-documentation-comments
> > > > is supposed to let you include the current version of the comment i=
nto
> > > > the rendered documentation HTML without having to manually keep thi=
ngs
> > > > in sync. I've never used that myself, but there are a bunch of
> > > > examples in the tree; for example, grep for "DMA fences overview".
> > >
> > > Ah, but this isn't a kernel doc is just a raw comment :) so I'm not s=
ure there
> > > is a great way of grabbing just that, reliably. Maybe can turn that i=
nto a
> > > kernel doc comment in a follow up patch or something?
> >
> > Ah, yeah, sounds reasonable.
>
> Thanks.
>
>
> I think all this makes me think that we should actually have entirely
> separate top level descriptions and internals sections in this document,
> which align's again with Alice's comments.
>
> As the level of detail and caveats here mean that if you provide
> implementation details everywhere you end up constantly on a tangent
> (important, relevant internal details but to a _user_ of the functionalit=
y
> not so important).

Hmm, yeah.

