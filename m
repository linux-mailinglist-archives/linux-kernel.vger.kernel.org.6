Return-Path: <linux-kernel+bounces-309819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2449670B4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB4C28421E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190317BB24;
	Sat, 31 Aug 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRha+bv3"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B2176AD0
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098959; cv=none; b=UR6VYA2+mY0zfiBbfGZ0cxWv3UqqfFkDLgRcK44uW+GOMsH2v4+RCr6zrV8g9uzwPz47IzGJc615ZiwEUceM4En1yHwUxTxU4ZEH2+7iWxsy9EC6MrfJOB8i8vJSSTko3WUGECf7XfGlxn+/R1kU2B7pR59yXyigEBEB06K1soA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098959; c=relaxed/simple;
	bh=63lGmTrAHU/aO7Pq2J0/znNs7T7uZbZbSeDBKV2dWt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElKYtamGrubahocXVWZaiYjnFmjm1yvJrsDNIUIE26PUz+eY67vds75wm/v2K+IRLEAur77SU4d6Xe4Ry8s0cTibJxvL8Cs2ub2qhafmnhnlFfdJqww+1QKeWpaF3NuHXvT4p32lDa0LT1tgSl4vo1PKCgLSwb0KJSg9zHmKIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRha+bv3; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fd142a798eso740559e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098956; x=1725703756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMIAsf05xblxABJbGq9fMP/mE25x4zXuc8GRvOofYRs=;
        b=nRha+bv3yv89Canzi0Jz5EZkHBU5wexrjQN8LU3+NbHofY7dRtwqt0/J1hCg9wXCbQ
         b8BMZaHGjpKE/HPNQZO9uE2QgVITdnCcmInF80eqdcalM4J/GAYObS+tdqWyauPvD/38
         LDxEDDRzFYnjwX7a2UtYZp1cezWM4Vjri3+6FKEKgl2+LvI74q3RnOC4EpmA8T7nUf+4
         +Tb7YKN8F7diG5bJmIyXD0grtWYm7b2w7G/lqJdaZ6ZiTXvXsoXi/Nh04Afl6SH8XqTz
         OTD8mieUNHpbuipB36bkWWaU0zhGyjO6b7LB/xeNIJYjy90oH/XCYE0+R6P4CLc1JA0O
         9OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098956; x=1725703756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMIAsf05xblxABJbGq9fMP/mE25x4zXuc8GRvOofYRs=;
        b=AJBHvKUJFRHx5NeFPMAw3+++lRJOhCwTSZsMou/nL17HNc0BrShrRjhMkV7UF5VEHY
         7VXOvSD3K3X4ixf0yEoYyx85djOqJ6y6yuvxuyrZ7ntGdMIzGdWfxJ50Q+D/3UhHUA6d
         6oPzI7JicSR6ZwlSOgGvUG+tBq7KHJ24qhYpRG6HvcxMQYXn+5y+2MZlgdrbHca2Dwui
         QeuM1JXYkxKie+W2M6wck91n93PawXLFw1sLF+O1v4DJQgl8+0ZsInsgZ9iS2dd5+yuQ
         Pbo0QNP60nGdkG3LT3UurMKmIuZLJpglOsCwQ/6Yd49cZig1DaLcNXS7pODz9hpB7OCO
         d3tA==
X-Forwarded-Encrypted: i=1; AJvYcCW48kTY8sbcZngoTZFlkCAqzi+C8mZsHvNvb1GpdMcf4uAFtA16FVSKLi6t0eu1Z3LQcKpBqRbrQX63gZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1RhSY1XladtvB5ocqXVRrl5XLj6dphHXMDUs+CHGf2J97eKHE
	8KWvuygX0ci2A5weblXUWNYRWuSmDAQAf9neVAIp/H34VZEu6IrNu1y9fFMVwK1zx3NziY3LPoc
	ePpm085oCcosX47VQPFgWojtXAYA=
X-Google-Smtp-Source: AGHT+IGpV55JQZNentY8D2NUN1bNdSfSH2h6yEnuqfI4K8+9qaTMytABl3522UWCKfSXzdQCp68REDVswoZyeJMww5w=
X-Received: by 2002:a05:6122:3d07:b0:4f2:a974:29e5 with SMTP id
 71dfb90a1353d-4ffe4a5c6bdmr9241955e0c.1.1725098956630; Sat, 31 Aug 2024
 03:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831092339.66085-1-21cnbao@gmail.com> <c0f79761-f753-4df7-9d02-3bbcbfbd902f@redhat.com>
In-Reply-To: <c0f79761-f753-4df7-9d02-3bbcbfbd902f@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 31 Aug 2024 22:09:05 +1200
Message-ID: <CAGsJ_4z=wHXa4Mug8RZJa4zULndPA0k9dw+OC41Lbv4nJUw3Ww@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: entirely reuse the whole anon mTHP in do_wp_page
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:59=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
>
> > +             idx =3D folio_page_idx(folio, vmf->page);
> > +             folio_start =3D address - idx * PAGE_SIZE;
> > +             folio_end =3D folio_start + nr * PAGE_SIZE;
> > +
> > +             if (unlikely(folio_start < max(address & PMD_MASK, vma->v=
m_start)))
> > +                     return false;
> > +             if (unlikely(folio_end > pmd_addr_end(address, vma->vm_en=
d)))
> > +                     return false;
> > +             folio_ptep =3D vmf->pte - idx;
> > +             folio_pte =3D ptep_get(folio_ptep);
> > +             if (!pte_present(folio_pte) || pte_pfn(folio_pte) !=3D fo=
lio_pfn(folio))
> > +                     return false;
> > +             if (folio_pte_batch(folio, folio_start, folio_ptep, folio=
_pte, nr, 0,
> > +                             NULL, NULL, NULL) !=3D nr)
> > +                     return false;
> > +             if (folio_mapcount(folio) !=3D nr)
> > +                     return false;
>
> BTW, you're not checking against the refcount (and it's all a bit racy
> on concurrent unmapping!). So you're re-introducing the vmsplice
> child->parent attak.

i don't quite understand this, you mean the below is not enough?

-       if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
+       if (folio_test_ksm(folio) || folio_ref_count(folio) > 2 + nr)
                return false;
        if (!folio_test_lru(folio))
                /*
@@ -3591,13 +3627,13 @@ static bool wp_can_reuse_anon_folio(struct folio *f=
olio,
                 * remote LRU caches or references to LRU folios.
                 */
                lru_add_drain();
-       if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
+       if (folio_ref_count(folio) > nr + folio_test_swapcache(folio))
                return false;
        if (!folio_trylock(folio))
                return false;
        if (folio_test_swapcache(folio))
                folio_free_swap(folio);
-       if (folio_test_ksm(folio) || folio_ref_count(folio) !=3D 1) {
+       if (folio_test_ksm(folio) || folio_ref_count(folio) !=3D nr) {
                folio_unlock(folio);
                return false;

>
> --
> Cheers,
>
> David / dhildenb
>

