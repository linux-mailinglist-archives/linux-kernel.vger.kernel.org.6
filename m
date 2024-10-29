Return-Path: <linux-kernel+bounces-387350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58959B4FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EB6284AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D01DB54B;
	Tue, 29 Oct 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxLr9e8h"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385427DA81
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220621; cv=none; b=eXCIof0AQNJoT1c3fkD+RkfHFQqBOdGr+eNx3JAw13r6XKb2/T581Sr639YFVuKk8U+jvUBuea6USK8J5+paWlqPG1zzOwjC/IyYQ3yM3nEBBZcqG9FPGajbjxOT0juvMzjROo9OTPYOr3jil7tIrOVMwjxrC8DcCHW/UzltP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220621; c=relaxed/simple;
	bh=yLC0KAEIkh+wSFqceBJBTeo6+eUjo/Vil2ys+kWIoWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0gaN0ifrpi4gR8aOlJg8uypbyUa1YKYWJXwLIvKq9Rrwa58hOwPjzEyLrWWha+Cc8No4ieyoGIfpKkQ6GEllQc8HCcf+29HGnnNjDsrFW4+JHZgaYKn87yu48iB1AhDBFP7XdyEkmq+tSVvFhakyJJtrKSZqbURyIfThBWFRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxLr9e8h; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a742ea907fso1532104137.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730220618; x=1730825418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkjcRVrYm5OJUoP2IRHwoD9m2+Md70Qn8IIA4I5kKkU=;
        b=vxLr9e8hp5F/kZHF21Etu/kwJkCZUdmmUJw+eligTIpGje9QiFbZR5LnS6pD1Ag0fr
         wdEZ0uvpE4ADa4tpdetbaGOhvDCEGfS6uROG/s/4TrAgn9S3XnMdyc9tu17IiT9Cq6WX
         0FzeSQFRUU6TxYZLBvLWOtQiBT+KmNXSWV1eGqwRh/a5/gyvBh11Cq/9AWTfDMadpslR
         EnxmUWluOGUO125U19K+yjs7/ueWtytt8MDifnUazrYj1P/yT3zV6xSkcqFTzExCNEzB
         VUoCCZvNL+h6O4bHIUFIiAR1GnWqAKACejWN/BKaQtQRbTBX/ALbguK0f8kvmJGM7m5v
         RQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730220618; x=1730825418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkjcRVrYm5OJUoP2IRHwoD9m2+Md70Qn8IIA4I5kKkU=;
        b=XXzutBegjgyTU63gM5ju03Wn3i2DYgXnf0jjbpgYc9zUydU/35/zz/42OF1QU7s1xC
         PZHkTZeU4kQ3oBw7qhWSkZ7CaLH0Rb242npUTRCmQifqxDjjkAWcfblaxwq5zesWr1qO
         f7JIl6WNO5lR13S4p6AtUg2TxzU8MD0dWP8d/VpiygOaI06qmZUbZB/sFPEtJs02eqMb
         clOhRuPPle1RFgXe36crNsU+RWAD2y9dwDD2P5MW7/Pp1c/Slfo7x8kfm94CqH903CbF
         DUazJAsA8r9FEqa3O13+M4Sj7kIndgTmoNcVrZG4hhQpIAbsRwNee8SnKY22gIwQsr0A
         MFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDIsQ2r26IOqwOsrZb9cewgQeq2CREZs/7MY8qXdo3VG2kPQZSt8FzNKvLvB4hbJuud54/GlnyluqlGzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tfCAjS18XWLc985hHRkyArlM8iow7gh2eL3atsrjyddAaJqM
	G8NLYehGTSOzjBmivUR2ZhNxE+MiQReKNb+WIjQQ0l7Th1lDl1DL7/0MgX5uWOTjtW7pkhCRI1t
	Vb2uoOovV3A85dvEB4v2Cx3ckAQKIsPlaK6z/
X-Google-Smtp-Source: AGHT+IHebFD55o0zkd/1hrEPtCqWpuTMh+G9F5NshG7sI3vNtGfIBXr1uEs8WQ6Aw79WN69N5TPAsmq4eH5vaI/YqDQ=
X-Received: by 2002:a05:6102:160a:b0:4a4:8756:d899 with SMTP id
 ada2fe7eead31-4a8cfd723demr10154610137.29.1730220617796; Tue, 29 Oct 2024
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028182653.3420139-1-yuzhao@google.com> <20241029164637.GA5108@cmpxchg.org>
In-Reply-To: <20241029164637.GA5108@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 29 Oct 2024 10:49:40 -0600
Message-ID: <CAOUHufa=H4WF9=xk9GXK5G4uHVghxikV1zqwO4BMQR=f_3_itA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3] mm/page_alloc: keep track of free highatomic
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Link Lin <linkl@google.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:46=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Oct 28, 2024 at 12:26:53PM -0600, Yu Zhao wrote:
> > OOM kills due to vastly overestimated free highatomic reserves were
> > observed:
> >
> >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE), or=
der=3D0 ...
> >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high=
:1068392kB reserved_highatomic:1073152KB ...
> >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME)=
 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*=
2048kB 0*4096kB =3D 1477408kB
> >
> > The second line above shows that the OOM kill was due to the following
> > condition:
> >
> >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB < min=
 (410416kB)
> >
> > And the third line shows there were no free pages in any
> > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> > 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> > usable free memory by over 1GB, which resulted in the unnecessary OOM
> > kill above.
> >
> > The comments in __zone_watermark_unusable_free() warns about the
> > potential risk, i.e.,
> >
> >   If the caller does not have rights to reserves below the min
> >   watermark then subtract the high-atomic reserves. This will
> >   over-estimate the size of the atomic reserve but it avoids a search.
> >
> > However, it is possible to keep track of free pages in reserved
> > highatomic pageblocks with a new per-zone counter nr_free_highatomic
> > protected by the zone lock, to avoid a search when calculating the
> > usable free memory. And the cost would be minimal, i.e., simple
> > arithmetics in the highatomic alloc/free/move paths.
> >
> > Note that since nr_free_highatomic can be relatively small, using a
> > per-cpu counter might cause too much drift and defeat its purpose,
> > in addition to the extra memory overhead.
> >
> > Reported-by: Link Lin <linkl@google.com>
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Acked-by: David Rientjes <rientjes@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> > @@ -642,6 +644,9 @@ static inline void account_freepages(struct zone *z=
one, int nr_pages,
> >
> >       if (is_migrate_cma(migratetype))
> >               __mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
> > +
> > +     if (is_migrate_highatomic(migratetype))
> > +             WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highat=
omic + nr_pages);
>
> Minor nit, the page can only be of one migratetype, so `else if' would
> be better.

Right (copied and pasted without thinking).

Andrew, could you please fix this up in place? Thank you!

