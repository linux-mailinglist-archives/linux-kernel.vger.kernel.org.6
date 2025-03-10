Return-Path: <linux-kernel+bounces-553776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AEA58EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8512416A54C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF022424D;
	Mon, 10 Mar 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0OlKQ0G"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B61A724C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596922; cv=none; b=ClgBVcsNPub+iKB6AS3aZmdgYI/vEUpakrOP6V7AhqEJ/VPWPvl74Eqb3uBE8zz/R8EYgHG3O73NdF+FRVQYwx9baK71kylwSak/1KnOODbxuJgV+89D3knHO3ix+E8LIIQECtEkHIc4qQtoW9kmY2Rhec2LnIjZcQLjFKgfd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596922; c=relaxed/simple;
	bh=+Gkinx5fiEq/vJwH/DFqcyN9jU8v6IMHL3kNlgCrDOk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=smJcoo60HeV3KJeUZpK45TlD1gT36fYbXbE/rezoUyY7APIbUlgdQ8w/hGkpgCxBGQ3fsVk+QTdqx63WdVXupYHQatRn9+ChKpanXB/dUkG0OqdFk4889ClWgeCy30wa6PQLw49GW9m27svz5OfVCLlQazTX4LkBpjfOLAokoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0OlKQ0G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so71527765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741596920; x=1742201720; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tm2wvmlbOJnRRib3mELhH6TcvAZa/xniLi1Hhu2zvA=;
        b=Z0OlKQ0GEtUOCAin9LZtiy0vV0nYqJA4wXoZ/KpH4wghVdNnn20+Kg9856C4AjsTjg
         R3Ipiuqv7inKKQ3uSOboTuK//AEfQAIRXljc+iRtFwBrpW61+drqIpPgDlLJiF5kNi2O
         tq+QFtDMiA7DhRqyYr+A8+Dr0Gb35h28cXr41pVc+/KKJVpH9uNqJ6S5eCYpByXhUdD4
         3ATf0RWGZtKXONvdfcSzM4zkB+7zCh733KZyNmotfq14rj6MoI8CtjHFdOnO63tsivh8
         EK13Jq9i/bZBXzPFT/rAJb+8TxWvYXpsC1kIWg0RXJbC8QCSdLNXfnpobGXbEbPK5Vwx
         CwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596920; x=1742201720;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tm2wvmlbOJnRRib3mELhH6TcvAZa/xniLi1Hhu2zvA=;
        b=Ayllf+pO7nfUr3AXADxn8Wv/2Z89/F60Tl2fNmPNrbAw6eEQkjD32sY+859/H1kbac
         wupY2EmxhToDxQcan6gXXIqfIDlCOtmXtuGZGE+HPJVTKdfum1T8fkHQkwYAI1XOpeS6
         yuOz11Iz5j6zKC1F4vezLCXWTdNMBELkVNqhxiw8JidtTFwjUUFI0bp3rfubYSOvZ5RS
         5cePARdETMSosJcbJuMuFZ+YQcbPOuJfxAUa5tWd5cEhYnAmsUx+Xb8vYY5tRPkpF7Oe
         h870e049+Lo49gTOFD81JhGqZcs6Wa2xUwJS1wkWcAkzIaOPDLoJVOWFYY36QPnXVcYt
         vs6A==
X-Forwarded-Encrypted: i=1; AJvYcCUqMU/RfsSNxn2KD0o+HjRKH4LNKQFB7scbvpDPq8ON2eNiDkL5x4qor3K1tyMOEaOj61IjB1YxeTo7HI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6FsOsJ4HisUoWn4iWU5LLX7RJaCzWpz2ko+CmnnX5pKxUYe3
	KWTJJktH/2dQbVlXy+xtydwn9EXM0ygn34j9HB2HKiBiS5ziui0nP7QV1KS0Vw==
X-Gm-Gg: ASbGncusm0s0uURnH1WvTPQROgX4IoDn06IHqQha/9EQ+W7Aa+rm7uIjo7WXZsPtfUH
	ZhcRPAekzGpAZxWdXdVH+oeNjxKDMlu1rubn9PZedGCk4rktDH3rJSLoPlcOa8GEH0TrgB8ZKiA
	LcVvRWUC0bu4qnY2DqGKE9us37DciVJSOCPYSR6Gbu72uW3qrLMnvYU+DV2t+Y58NxJI0Kf3hxC
	X3wobdjHUDeptw7QnSJcIC6htHPYsn5gOCPfbtqIgzDVYIRIeu6ay7/LDgayg8zNFO912cz5xDi
	q0KHV/fALSPwQywgB8jrLPjt+5r+698OLWIfdWDt4DWtXRwoCtd9kN4DnudN2a61wNZNx4dYbyx
	KbvBx+kAdmeje4b1brLTIpMHF38tx
X-Google-Smtp-Source: AGHT+IGVsvgzAwUBvLy58/XpPXaFRBbWWGnJg8e5NysxhOMMoYZ6rY0jW9IEi729pGV2nyMk3NkzQw==
X-Received: by 2002:a17:902:e802:b0:220:ff3f:6cc0 with SMTP id d9443c01a7336-22428ac9ca5mr222065895ad.38.1741596919463;
        Mon, 10 Mar 2025 01:55:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm72469265ad.243.2025.03.10.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:55:18 -0700 (PDT)
Date: Mon, 10 Mar 2025 01:54:23 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    linux-mm@kvack.org, 
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, 
    John Hubbard <jhubbard@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Kairui Song <kasong@tencent.com>, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
In-Reply-To: <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
Message-ID: <fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com> <20250226210032.2044041-3-ziy@nvidia.com> <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com> <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com> <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
 <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com> <176731de-6a3b-270b-6b5d-dfce124c8789@google.com> <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-310574914-1741596918=:2706"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-310574914-1741596918=:2706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 6 Mar 2025, Zi Yan wrote:
> On 5 Mar 2025, at 17:38, Hugh Dickins wrote:
> > On Wed, 5 Mar 2025, Zi Yan wrote:
> >> On 5 Mar 2025, at 16:03, Hugh Dickins wrote:
> >>>
> >>> Beyond checking that, I didn't have time yesterday to investigate
> >>> further, but I'll try again today (still using last weekend's mm.git)=
=2E
> >>
> >> I am trying to replicate your runs locally. Can you clarify your steps
> >> of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D=
? Do you impose
> >> a memory limit so that anonymous memory is swapped to SSD or make tmpf=
s
> >> swap to SSD?
> >
> > Yeah, my heart sank a bit when I saw Andrew (with good intention) askin=
g
> > you to repeat my testing.
> >
> > We could spend weeks going back and forth on that, and neither of us ha=
s
> > weeks to spare.
> >
> > "To fulfil contractual obligations" I'll mail you the tarfile I send
> > out each time I'm asked for this; but I haven't updated that tarfile
> > in four years, whereas I'm frequently tweaking things to match what's
> > needed (most recently and relevantly, I guess enabling 64kB hugepages
> > for anon and shmem in addition to the PMD-sized).
> >
> > Please don't waste much of your time over trying to replicate what
> > I'm doing: just give the scripts a glance, as a source for "oh,
> > I could exercise something like that in my testing too" ideas.
> >
> > Yes, I limit physical memory by booting with mem=3D1G, and also apply
> > lower memcg v1 limits.
> >
> > I made a point of saying "SSD" there because I'm not testing zram or
> > zswap at all, whereas many others are testing those rather than disk.
> >
> > swapoff, and ext4 on loop0 on tmpfs, feature in what I exercise, but ar=
e
> > NOT relevant to the corruption I'm seeing here - that can occur before
> > any swapoff, and it's always on the kernel build in tmpfs: the parallel
> > build in ext4 on loop0 on tmpfs completes successfully.
>=20
> Thanks for the scripts. I kinda replicate your setup as follows:
>=20
> 1. boot a VM with 1GB memory and 8 cores;
> 2. mount a tmpfs with huge=3Dalways and 200GB;
> 3. clone the mainline kernel and use x86_64 defconfig (my gcc 14 gives
>    errors during the old kernel builds), this takes about 2GB space,
>    so some of tmpfs is already swapped to SSD;
> 4. create a new cgroupv2 and set memory.high to 700MB to induce memory
>    swap during kernel compilation;
> 5. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_mem=
ory >/dev/null; done=E2=80=9D to trigger compaction all the time;
> 6. build the kernel with make -j20.
>=20
> I ran the above on mm-everything-2025-03-05-03-54 plus the xarray fix v3,
> folio_split() with your fixes, and Minimize xa_node allocation during
> xarry split patches. The repo is at: https://github.com/x-y-z/linux-dev/t=
ree/shmem_fix-mm-everything-2025-03-05-03-54.
>=20
> It has ran over night for 30 kernel builds and no crash happened so far.
> I wonder if you can give my repo a shot.

Thanks for trying, I hope you didn't waste too much time on it,
I was not optimistic that it could be adapted easily.

You appeared to be suggesting above that I try your setup, which did
not reproduce the corruption, instead of mine which did.  And later you
appeared to conclude that all is good because you saw no corruption.

No. I continued with my setup (working on mm-everything-2025-03-08-00-43),
have now root-caused the corruption, and have the fix: as so often,
it is obvious in retrospect.

After looking at enough of the fixdep failures and their .o.d files,
I found them consistent with seeing the head page of a large folio
in place of its first tail (presumably while racing a split).

And the debug patch to filemap_get_entry() below (not something we want
to go into the tree, but good for confirmation - maybe it will even
show warnings on your setup) confirmed that - well, head in place of
first tail was the majority of cases, but head in place of any tail
in general.

There's a race between RCU lookup of the xarray and your splitting.
That's something that normally the xas_reload(&xas) check guards
against, but it was not effective.

I wasted a day getting it exactly back to front: I thought the problem
was that __split_unmap_folio() needed to __xa_store the former tail
before unfreezing it; but the patch reversing that ordering still
issued some warnings.

No, it's that __split_unmap_folio() must not unfreeze the original
head until all the xa slots which used to point to it have been
updated with their new contents (as __split_huge_page() always did).

I've taken the liberty of simplifying the unfreeze calculaton in terms
of mapping and swap_cache, as we did elsewhere (and after fiddling
around with the comment above it, just dropped it as adding nothing
beyond what the code already does).

And there's one other, unrelated change in there: I've changed the
folio_put() after __filemap_remove_folio() to folio_put_refs().
I believe that is what's correct there, but please check carefully:
I'm a little worried that my testing (which I expect to be exercising
that "beyond EOF" case plenty) has run well both before and after that
change, whereas I thought there should be a noticeable leak of memory
while it was just folio_put().

Or maybe my testing is barely exercising anything more than uniform
splits to 0-order, in which case there's no difference: I imagine
your selftests (I've not tried them) will do much better on that.

Please fold in the mm/huge_memory.c mods if you are in agreement.

Signed-off-by: Hugh Dickins <<hughd@google.com>

diff --git a/mm/filemap.c b/mm/filemap.c
index f7281ad22743..34b4fdafec40 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1871,6 +1871,15 @@ void *filemap_get_entry(struct address_space *mappin=
g, pgoff_t index)
 =09=09folio_put(folio);
 =09=09goto repeat;
 =09}
+
+=09if (mapping->host /* filter out swap cache */ &&
+=09    /* !folio_contains(folio, index), but that requires lock */
+=09    WARN_ON(index - folio->index >=3D folio_nr_pages(folio))) {
+=09=09pr_warn("Mismatched index:%#lx\n", index);
+=09=09dump_page(&folio->page, NULL);
+=09=09folio_put(folio);
+=09=09goto repeat;
+=09}
 out:
 =09rcu_read_unlock();
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e05e62fdccb..be0c9873019c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3787,18 +3787,13 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
 =09=09=09=09=09=09MTHP_STAT_NR_ANON, 1);
 =09=09=09}
=20
-=09=09=09/*
-=09=09=09 * Unfreeze refcount first. Additional reference from
-=09=09=09 * page cache.
-=09=09=09 */
-=09=09=09folio_ref_unfreeze(release,
-=09=09=09=091 + ((!folio_test_anon(origin_folio) ||
-=09=09=09=09     folio_test_swapcache(origin_folio)) ?
-=09=09=09=09=09     folio_nr_pages(release) : 0));
-
 =09=09=09if (release =3D=3D origin_folio)
 =09=09=09=09continue;
=20
+=09=09=09folio_ref_unfreeze(release, 1 +
+=09=09=09=09=09((mapping || swap_cache) ?
+=09=09=09=09=09=09folio_nr_pages(release) : 0));
+
 =09=09=09lru_add_page_tail(origin_folio, &release->page,
 =09=09=09=09=09=09lruvec, list);
=20
@@ -3810,7 +3805,7 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 =09=09=09=09=09folio_account_cleaned(release,
 =09=09=09=09=09=09inode_to_wb(mapping->host));
 =09=09=09=09__filemap_remove_folio(release, NULL);
-=09=09=09=09folio_put(release);
+=09=09=09=09folio_put_refs(release, folio_nr_pages(release));
 =09=09=09} else if (mapping) {
 =09=09=09=09__xa_store(&mapping->i_pages,
 =09=09=09=09=09=09release->index, release, 0);
@@ -3822,6 +3817,9 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 =09=09}
 =09}
=20
+=09folio_ref_unfreeze(origin_folio, 1 +
+=09=09((mapping || swap_cache) ?  folio_nr_pages(origin_folio) : 0));
+
 =09unlock_page_lruvec(lruvec);
=20
 =09if (swap_cache)
---1463770367-310574914-1741596918=:2706--

