Return-Path: <linux-kernel+bounces-428336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0409E0D12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AC164FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0F1DED7D;
	Mon,  2 Dec 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0KwWqID"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1A1DED67
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171794; cv=none; b=dCN9lNundXe1LMycXLnIe4mNMl1rwBVU059onV4auME23MNUcmm6PJV35j2ftrOLc5fzw/l04y9UVfFkvBuTc+R8KiSmMA/yLkbz+U3IDm4ixfqOoFv2rv5MT+CzG/KZJGV6f6Mr3BvFXdoyvb1dA3V+fzVUJyMFdY/h3Td1YWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171794; c=relaxed/simple;
	bh=XD9iY38x8nxbzuUKa3NNEXIK3w94T0wlfzgrCdxAkQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDwbYof576HFZGKBflDw4VrOq3YBq8A+gguEWk1YiDS2txDNc9ipGw6kpn5ZW8gW8VsYP/f014G33nP/ZzNnEeOcuNs2FPUWHRMzSs72DAkifhvfXYkmCQoZgcR1Xs3ZnopvDF08nWpjWstsffE35iMrYbGaKN5jzXyk1mFpnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0KwWqID; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d87a55bc50so31770976d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733171791; x=1733776591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dnX/R1eAhG3pFiUW62lup7SRGntNYB80vGLWFfHvFU=;
        b=N0KwWqIDqAFqgtSvLhzv5PzZJvm9k98JaS0aT+ur5ZXcxuXy970fJJxI7VyjNZzwZE
         sfz1EP0hf5w9e8Q/SZxFNk3q5pzzCDlVFyQFr8rSa1rpwIHvMD3dk848g+cIxmRClM3F
         ZIo7d7UZb+YaaAt+VYl8Rh+knFOL3FeNPhzWAiRDFJhu9Yh+fWUNAyhw4EG6+1/7fRS9
         qxFJ5T3QrjzcueOpk6nHpdDOXI+w6wNhRcOgL4BNExe9vXckoec6FKD8ERJvc35Kmk7d
         fNXTjAFw4U8Ot9xxBvy+BFvNmzA+YnfuV5M1RhBNcWUskI0U7ny1VWjSvJNN3CY5RxVn
         k6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171791; x=1733776591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dnX/R1eAhG3pFiUW62lup7SRGntNYB80vGLWFfHvFU=;
        b=bmbN6fd+kjUWQzhQ+WI5JlNeFj5V/gsBV8QtdlUHP7f+0miDmwDJBfQPNn9n55qV8G
         YnifptxbErGSF39Ajk/XaGBnVjF1ta6BJoCQGFuQLkY8C7jQmY1T6fpZDfGOYXLHTBZF
         WY9uDzV58oXSpYRoHq5jld6j1/IfeQWNIozDSHOOnJGs5wxMNOck+OJoaa5isqjbWlA1
         Qx+9/wh/Vo3GpheDkwGBCxOUfM40kQV7sHxpvaQtal6GIqxDu5SfhyoJeckZnI54znrM
         bZYaXXqoSUYtBmtxcNF8kZG/JTkEWgoi7TrVi8gpwBNTTT/cmdZWBaGuzaCaFCaT9sqS
         ZAOw==
X-Forwarded-Encrypted: i=1; AJvYcCV01Eg2fnVqapRBm9AMXrSnepMRm3BJPKAooilG3st/gWIjTJTKVlLJ99pdxhotSCCUHkxEbrvRWHSlCw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgIH/wIrODTuIxj+QtC+zS9oFGz1vCQAcAM7oKnz8JI3rlqpx
	6rZFeAJt8bHBTxAujJmKO3XSCjPf0T8Tf2hQNWHU9SwcC2PmqC+TDEZG/Njjx5bWWeV7pAzIN2s
	giIVSkibqcveumM2iwxeasLC0WKuAHGpLUb0J
X-Gm-Gg: ASbGncv2C7VX7bsF5trboTamOQZVGNI5NeonQ03kgZH3ZAhIYTyf5UggDF7iwRmyvTK
	PnIlVgiaDnde0g/pFBJMzjkI4BUF3
X-Google-Smtp-Source: AGHT+IG1AClFTBW39Yk/jmXT+RGFuQs2al0GRUyyi1ND8H1F/qr/HPRF81yEQhpsm1ghgVrNDXVv2GxFhCIO3ziGwhc=
X-Received: by 2002:ad4:5aa5:0:b0:6d8:8f81:e2e3 with SMTP id
 6a1803df08f44-6d8b72ecae5mr192196d6.8.1733171791392; Mon, 02 Dec 2024
 12:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
In-Reply-To: <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 12:35:55 -0800
Message-ID: <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintaina=
nce")
> > replaced the cmpxchg/xchg with a global irq spinlock because some archs
> > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
> >
> > And as commented in swap_cgroup.c, this lock is not needed for map
> > synchronization.
> >
> > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implement
> > it to get rid of this lock.
> >
> > Testing using 64G brd and build with build kernel with make -j96 in 1.5=
G
> > memory cgroup using 4k folios showed below improvement (10 test run):
> >
> > Before this series:
> > Sys time: 10730.08 (stdev 49.030728)
> > Real time: 171.03 (stdev 0.850355)
> >
> > After this commit:
> > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > Real time: 159.78 (stdev 0.577193), -6.57%
> >
> > With 64k folios and 2G memcg:
> > Before this series:
> > Sys time: 7626.77 (stdev 43.545517)
> > Real time: 136.22 (stdev 1.265544)
> >
> > After this commit:
> > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > Real time: 129.65 (stdev 0.880039), -4.82%
> >
> > Sequential swapout of 8G 4k zero folios (24 test run):
> > Before this series:
> > 5461409.12 us (stdev 183957.827084)
> >
> > After this commit:
> > 5420447.26 us (stdev 196419.240317)
> >
> > Sequential swapin of 8G 4k zero folios (24 test run):
> > Before this series:
> > 19736958.916667 us (stdev 189027.246676)
> >
> > After this commit:
> > 19662182.629630 us (stdev 172717.640614)
> >
> > Performance is better or at least not worse for all tests above.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > index a76afdc3666a..028f5e6be3f0 100644
> > --- a/mm/swap_cgroup.c
> > +++ b/mm/swap_cgroup.c
> > @@ -5,6 +5,15 @@
> >
> >  #include <linux/swapops.h> /* depends on mm.h include */
> >
> > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
> > +struct swap_cgroup_unit {
> > +       union {
> > +               int raw;
> > +               atomic_t val;
> > +               unsigned short __id[ID_PER_UNIT];
> > +       };
> > +};
>
> This doubles the size of the per-entry data, right?

Oh we don't, we just store 2 ids in an int instead of storing each id
individually. But the question below still stands, can't we just use
cmpxchg() directly on the id?

>
> Why do we need this? I thought cmpxchg() supports multiple sizes and
> will already do the emulation for us.

