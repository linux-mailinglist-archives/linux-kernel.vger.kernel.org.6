Return-Path: <linux-kernel+bounces-186200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687C8CC101
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADADA1F24999
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22F13D88D;
	Wed, 22 May 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFavppLv"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C613D628
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379907; cv=none; b=tXxhMDKY/19tUpNw64PGgn4rtjxbtesQgy+rXi6rEIi1p0xBC5/Fy8HqNF1LvY73GMK/ALBU9pXlFMLBzm5/xBhqsLJsXQW5PsbLxmyBD4ZQriNvkZkGHtnJbKEWqqCyJeAKRE69RPtQVujeYuF1IFEOkct+wdNSn7DJoLtdMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379907; c=relaxed/simple;
	bh=0ffb1noRUwPFeM8oQh9ctOYinLBaFo/O+lJlNNwiZR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao1Vu1wAb1/BXDn2kH1wR/DeZXJbqsRhUr/PgHaTv6HZy5LnNaR3ukuVuUikVmcW2USori1v4YgXj15zghMpO2JyLOo+wUDK3LtZsHCaCJlR6j+HEvlDU2YMFNedHstQFQcgXUcAMD7qIWdkJbc8gkTNFaLl/tjilhjSH502vGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFavppLv; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7fb42630cc2so49948241.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716379904; x=1716984704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrO1EgX+XFaaM20QiGf+71AFWvOpo9n0VTGIHy7U0I0=;
        b=LFavppLvXt6AHpNKqMDWmgLLHsc2YWW3vGs9ODlSyXoU4W7NACuxrwe1HpfXX7wAxo
         /fYUrr2XYBkSHca8+uC1Z8Vb5B/xmzFxEbJ9m1MO1lynYwCqdNBaMBhcmlnSOSVJmRhD
         XPbFwY9BsOFDyZvAkOp+w4iagQkMKjoLLsSx4zfmysy4oJcdIcxo+DWEgp9QwGCg9exu
         wWPqf1Di0oZczv8GzjB79PaCamfjIY8DDgV5awk8U3E/cuovR3kSgvIoBKlSppWQ7LAW
         rSGUI/fBneyNjJXbwjiqRVXsnJjtsehBAqbIccjddjdzs3VNMoM2LvD52k9gDuJKlS8f
         BmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379904; x=1716984704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrO1EgX+XFaaM20QiGf+71AFWvOpo9n0VTGIHy7U0I0=;
        b=rWOH6eHZnHlrzCwZwNHDrxWw/hY5Hyk1lfEHkrqNSR89mLpCuAeYdtc2803VZJXC/x
         OMsDE2CH8M+FHhwEbT/mfIR5q9KdbT2W1BZuwV28Suftw0KQLyywebhK1tGwM4gI46sy
         mn+oWbN2AP0hOqB44p84aHhdFKvp3Re+LMgewcXORQULX7ctzkbJgxzf4T5sV+d61SLO
         jELMaq3BOZ3cVFBl9uiH2eZy8hXje/Nnd0IMi5qDPanfKASuykMFB8zlH0PoC9azuJy3
         V2pE1VyigvESB4szjpsdFtybrMGbeuFCoWhC/nU3puOTiDUQ2S5laOODf9RDzYvZFJcF
         iXbg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDSk05DwYW2NVLdw/bwD5g0x70cSbsKVY6uWeVJjPOnyk/PrZNzgjBVmJYBTkUAqz8djvhI8JtYmuMTwEvXqCzl399ieqC2sYqglO
X-Gm-Message-State: AOJu0Yxw/e5XcswP3UA1Zeuu9WiiBCmH8M0JyKoLlispmTba8ElFzytR
	147fXPn5j5QwSSrPOiHWJIbYgKF+m1w0Ns9wgS3l/tPdx6m7gsWkIj9ylxv+l9/SGuEIp6AiwAT
	UGQiMLnXkdTTrt4tfdjUPRJi4YxU=
X-Google-Smtp-Source: AGHT+IFwO+ZoDXwLARMyHWVQfAb49OZrvN7wRZnNt57AXwV3QQdIvuaXg335YcKEA1Hg4A9r1bBfhh+16vSn8iO/z3c=
X-Received: by 2002:a05:6122:2b9:b0:4da:9aa1:dd6d with SMTP id
 71dfb90a1353d-4e218599ef0mr1763982e0c.1.1716379904260; Wed, 22 May 2024
 05:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
 <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com> <51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
 <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com> <c55648d4-cec2-48ca-9ca9-c8fc2aecc741@linux.alibaba.com>
In-Reply-To: <c55648d4-cec2-48ca-9ca9-c8fc2aecc741@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 22 May 2024 20:11:33 +0800
Message-ID: <CABzRoyYqCSZafj2wmdgaYutOZtNAL2hozZV24mMjYrgf_BpJmQ@mail.gmail.com>
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	willy@infradead.org, ying.huang@intel.com, ryan.roberts@arm.com, 
	ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Wed, May 22, 2024 at 7:24=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/22 18:40, Barry Song wrote:
> > On Wed, May 22, 2024 at 9:38=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2024/5/22 16:58, David Hildenbrand wrote:
> >>> On 22.05.24 10:51, Baolin Wang wrote:
> >>>> The mTHP swap related counters: 'anon_swpout' and
> >>>> 'anon_swpout_fallback' are
> >>>> confusing with an 'anon_' prefix, since the shmem can swap out
> >>>> non-anonymous
> >>>> pages. So drop the 'anon_' prefix to keep consistent with the old sw=
ap
> >>>> counter
> >>>> names.
> >>>>
> >>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> ---
> >>>
> >>> Am I daydreaming or did we add the anon_ for a reason and discussed t=
he
> >>> interaction with shmem? At least I remember some discussion around th=
at.
> >>
> >> Do you mean the shmem mTHP allocation counters in previous
> >> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
> >> not find previous discussions that provided a reason for adding the
> >> =E2=80=98anon_=E2=80=99 prefix. Barry, any comments? Thanks.
> >
> > HI Baolin,
> > We had tons of emails discussing about namin and I found this email,
> >
> > https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat=
com/
> >
> > David had this comment,
> > "I'm wondering if these should be ANON specific for now. We might want =
to
> > add others (shmem, file) in the future."
> >
> > This is likely how the 'anon_' prefix started being added, although it
> > wasn't specifically
> > targeting swapout.
>
> That's what I missed before. Thanks Barry.
>
> > I sense your patch slightly alters the behavior of thp_swpout_fallback
> > in /proc/vmstat.
> > Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though=
 we
> > always split them.
>
> Sorry I did not get you here. I just re-name the mTHP swpout_fallback,
> how can this patch change the THP_SWPOUT_FALLBACK statistic counted by
> count_vm_event()?

Currently, PMD-mapped shmem folios are not accounted for in
THP_SWPOUT and related counters.

So, IMO, if we intend to account for them in those counters in the
future, removing
the 'anon_' prefix from the mTHP swap counters would be reasonable :)

Thanks,
Lance

>
> >                  if (folio_test_anon(folio) && folio_test_swapbacked(fo=
lio)) {
> >                          ...
> >                                  if (!add_to_swap(folio)) {
> >                                          int __maybe_unused order =3D
> > folio_order(folio);
> >
> >                                          if (!folio_test_large(folio))
> >                                                  goto activate_locked_s=
plit;
> >                                          /* Fallback to swap normal pag=
es */
> >                                          if (split_folio_to_list(folio,
> > folio_list))
> >                                                  goto activate_locked;
> > #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >                                          if (nr_pages >=3D HPAGE_PMD_NR=
) {
> >                                                  count_memcg_folio_even=
ts(folio,
> >                                                          THP_SWPOUT_FAL=
LBACK, 1);
> >
> > count_vm_event(THP_SWPOUT_FALLBACK);
> >                                          }
> >                                          count_mthp_stat(order,
> > MTHP_STAT_ANON_SWPOUT_FALLBACK);
> > #endif
> >                                          if (!add_to_swap(folio))
> >                                                  goto activate_locked_s=
plit;
> >                                  }
> >                          }
> >                  } else if (folio_test_swapbacked(folio) &&
> >                             folio_test_large(folio)) {
> >                          /* Split shmem folio */
> >                          if (split_folio_to_list(folio, folio_list))
> >                                  goto keep_locked;
> >                  }
> >
> >
> >
> > If the goal is to incorporate pmd-mapped shmem under thp_swpout* in
> > /proc/vmstat,
> > and if there is consistency between /proc/vmstat and sys regarding
> > their definitions,
> > then I have no objection to this patch.
>
> I think this is the goal, moreover shmem will support large folio (not
> only THP) in future, so swpout related counters should be defined as
> clear as possible.
>
> However, shmem_swpout and shmem_swpout_*
> > appear more intuitive, given that thp_swpout_* in /proc/vmstat has
> > never shown any
> > increments for shmem until now - we have been always splitting shmem in=
 vmscan.
>
> This is somewhat similar to our previous discussion on the naming of the
> shmem's mTHP counter[1], as David suggested, we should keep counter name
> consistency for now and add more in the future as needed.
>
> [1]
> https://lore.kernel.org/all/ce6be451-7c5a-402f-8340-be40699829c2@redhat.c=
om/
> >
> > By the way, if this patch is accepted, it must be included in version
> > 6.10 to maintain
> > ABI compatibility. Additionally, documentation must be updated accordin=
gly.
>
> Sure. I missed update the documentation, and will do in next version.
>

