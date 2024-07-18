Return-Path: <linux-kernel+bounces-256361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B95934CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130FE281E36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88E13B5A2;
	Thu, 18 Jul 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unm1ZWBI"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5312FB34
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304729; cv=none; b=eeCiP2F1aKr7MT+FR7O0n2sp1pP7Xs3/yW4I+raPcu8jeyHPzEdqNNNM/YqSBM4zALz7HSRquH3teLlssmpVCV1U1727w8i+1Css9TrmOPcn6KnupOMJtQIMhO3ivZvKO7uQb9iu3UHRQ2GBvuCoDJ/7THNOR3f8AZEtuFx6w/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304729; c=relaxed/simple;
	bh=V4tza6XYunP9XtuqkepnXv6yRle3OpreNP0O5UPB4lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzq9ZcF3+OSzyHELhAr5sBu03wDz+8pXT4HCz2FEpbu4VekEuVU9fTZhP7EeuHfYp0074YdW1XrFQ8z8v3Y7zKs9iV9uZzFyxR0pGq0LGsPSIAGlKeyhyCX/DNbrelxe+3QSjzjS7bR5ccA0UzcWyRzUnWYZp6w+MdwwGJZ0Nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unm1ZWBI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so12168611fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721304726; x=1721909526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JbIOCcBdplPSNhXHQ/OhleOxgeAg8kacXZRAhR44BI=;
        b=Unm1ZWBIkia5yySKu/rwSSg5kRTcCuA9VU0i2TAxbuWbdYMXFOFIopMKfjj6H01mgr
         A3YANjFqcIAeeMmZO/izMPyfSSga2JVzZzseto9RltzkuLTIjklDlqdz6+d+L8QF41KX
         jd1uW6rf66Nn8syyQGqSqfkFCDmgvbl6Yg5EcXenP6F6r4ntXSHtSG2VYEUNh9xO3Lf0
         z1Fw6IMfb8Sr/bQM7njyeS8iRjK5hzqZa5JJc3Y3ttqCmD00UHfmFOKdDfWiGO4d2jtB
         I5tplGZFWA+sz+0DOlo4/jo2c0bAZPtzlo2F+mdnsRCDyw8FXOMbF892T4RwechXNvut
         ZQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721304726; x=1721909526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JbIOCcBdplPSNhXHQ/OhleOxgeAg8kacXZRAhR44BI=;
        b=EVGoLrKPRCeYoGCMekQxwQ+dUxnufzeZhsht7IDznuRGFop+C4v9++hQ0pvV6WztJo
         yF0lMO/UhM6hT73P6RsUH2BFoGRS+KDn4BS+WA5eCP02nTpxO/IH+c2+nZegdcihVQI2
         b2Gt07Jkz8ZygU09SpW8eme17yhCif1CodiZ1JZJ0vst7oEssd0CtixogZWBCHTA0lbp
         eAtEeg/ue5r59xMKugbTYNRr7zzJrip4HJc6mQ4jgtGMh0Re/f4WOoiWwQpTHWLFsKFC
         7xx9LgBcralU3knVtKnXf2C5QZ1ppn4ORbDgfzvYueiX5maxe06q8vI+Dz6DIm3qokrw
         x+HA==
X-Forwarded-Encrypted: i=1; AJvYcCXKgjrjIHXfmay2r+ERDkOJP20xP8QtAPLoAP+gFJjcvXSV6r30fywvyqcA3eYX3iUyfXTlYYgvEvhEDg/e9HtZHbU/zii5+wQnwVZf
X-Gm-Message-State: AOJu0YyYc/fylLdHjC7oY2xPqwSiKpz2G+uJR4Ms/GX9bJBPIHMCvLbF
	We17CzgfFu8LiTyabE0R9stpDaMbhZuEKz96sQM3OvnEHIyPaDYoKvZBjYB+vGAAUUG84H4bJgL
	LpBhGaQ3z8p6zFeJclmW6CgXJ8PI=
X-Google-Smtp-Source: AGHT+IGADOgkOv+UO/f6fCr0cwG1TMuNLhp61jlQJFR5VxGypmKktddke7jNVONc7yit8nKlPg8SF8vH7oM5eirsoIM=
X-Received: by 2002:a2e:87cd:0:b0:2ee:d5e1:25eb with SMTP id
 38308e7fff4ca-2ef05c54440mr19870831fa.2.1721304725513; Thu, 18 Jul 2024
 05:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <3128c3c0-ede2-4930-a841-a1da56e797d7@suse.cz>
 <CAGudoHESB-+kHPJO+4MHnUDPJXGP87=yJ2QrW3q8pkO5z7OLRw@mail.gmail.com> <44fb1971-f3d3-4af8-9bac-aceb2fedd2a6@amd.com>
In-Reply-To: <44fb1971-f3d3-4af8-9bac-aceb2fedd2a6@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Jul 2024 14:11:53 +0200
Message-ID: <CAGudoHFDZi=79GgtWHWw52kyu81ZK2O4=30YrKhPerDxXdxbKg@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	yuzhao@google.com, kinseyho@google.com, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:00=E2=80=AFAM Bharata B Rao <bharata@amd.com> wr=
ote:
>
> On 17-Jul-24 4:59 PM, Mateusz Guzik wrote:
> > As for clear_shadow_entry mentioned in the opening mail, the content is=
:
> >          spin_lock(&mapping->host->i_lock);
> >          xa_lock_irq(&mapping->i_pages);
> >          __clear_shadow_entry(mapping, index, entry);
> >          xa_unlock_irq(&mapping->i_pages);
> >          if (mapping_shrinkable(mapping))
> >                  inode_add_lru(mapping->host);
> >          spin_unlock(&mapping->host->i_lock);
> >
> > so for all I know it's all about the xarray thing, not the i_lock per s=
e.
>
> The soft lockup signature has _raw_spin_lock and not _raw_spin_lock_irq
> and hence concluded it to be i_lock.

I'm not disputing it was i_lock. I am claiming that the i_pages is
taken immediately after and it may be that in your workload this is
the thing with the actual contention problem, making i_lock a red
herring.

I tried to match up offsets to my own kernel binary, but things went haywir=
e.

Can you please resolve a bunch of symbols, like this:
./scripts/faddr2line vmlinux clear_shadow_entry+92

and then paste the source code from reported lines? (I presume you are
running with some local patches, so opening relevant files in my repo
may still give bogus resutls)

Addresses are: clear_shadow_entry+92 __remove_mapping+98 __filemap_add_foli=
o+332

Most notably in __remove_mapping i_lock is conditional:
        if (!folio_test_swapcache(folio))
                spin_lock(&mapping->host->i_lock);
        xa_lock_irq(&mapping->i_pages);

and the disasm of the offset in my case does not match either acquire.
For all I know i_lock in this routine is *not* taken and all the
queued up __remove_mapping callers increase i_lock -> i_pages wait
times in clear_shadow_entry.

To my cursory reading i_lock in clear_shadow_entry can be hacked away
with some effort, but should this happen the contention is going to
shift to i_pages presumably with more soft lockups (except on that
lock). I am not convinced messing with it is justified. From looking
at other places the i_lock is not a problem in other spots fwiw.

All that said even if it is i_lock in both cases *and* someone whacks
it, the mm folk should look into what happens when (maybe i_lock ->)
i_pages lock is held. To that end perhaps you could provide a
flamegraph or output of perf record -a -g, I don't know what's
preferred.
--=20
Mateusz Guzik <mjguzik gmail.com>

