Return-Path: <linux-kernel+bounces-383791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758F9B203E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56C3B21050
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8540178389;
	Sun, 27 Oct 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iXxY774"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FC17736
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060294; cv=none; b=PvhakVRnB8sqGna6IUIJC/cqfHuTP5k7nlHL6xiV5xDW0VcIp7M/vW5aB9sCnWk8i/KK0L7ayXoqQTNhTP3B4N0A3f2m7Ugj+UED0R2FLJn7cENc0Uu0LpV6t9IhBYjWc4HJoX+dH9MUMjzBmZyT8C4s2VsPJW79acpyiJsj6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060294; c=relaxed/simple;
	bh=uCbWZKe7zah7SfMOTrCl6DB+kJXZVc1avt4pz5z6l5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqlGYrhvFNwUX9jf97rMqtVv4zOyfQJFu8ubPT2IrXMsem87yci6ByFQ62XTkAV7jCcsJ2uhIDBPkBMm9G/NmAMMbR1frtXquwRXe7a/Hp0A23Qq5vXkqkhDgDSRsPNVpu4EnlQXwmbf1h3txBVaUuhAf8eGtZvBnedqFNLEUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iXxY774; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a46b6affeaso1233533137.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730060291; x=1730665091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W57syI8B6s1vBoi10dck14GYovzdeItChLbMs8WjR18=;
        b=3iXxY7740P6LjSVVeS4/yOBTtDzt3rulWLl44uk1ixUksMGwVff57IoPwzX53RWL+u
         yisabixcpcj4xOXSyYWJgcgeCLy8Dho6a892LAkHMsGdLVt+sbmi9Ow9BaGgE2KGzzWj
         kJ2KYvMbB7D1+B0dQGYsVdoWG256KvdgGVw6Xv1w1iO9Uh5tbO+mGMDuKA1uRw6iTqLB
         1wcVUfkhHTOgZrHVgdzjj5RdTBzIjI0dRoPhIHo3vQY1DmCUnGeE3ET1mMhfLR2CKzTr
         IiVPhHtvEjn0C6d3C8fZ8mjVFw7twjkqlhsY2og4CzdWQljjbYk5HbcYiSq/9CmLtAW2
         FIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730060291; x=1730665091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W57syI8B6s1vBoi10dck14GYovzdeItChLbMs8WjR18=;
        b=sDg9s7qBcLpZurcB9GMoS+NY1yRTTo6La9/d9DGr7cDaIwsdiw4ae6rC7sTqUJyTj4
         EmaQ4FzHZmOOW98xPPKfhH3icd2/JaxcfRrxlNilFMhTxurp4EtmBzxV5FKFMjcg5RJb
         lt/l61EgrRB+DVlYFF9wdJDyNXUwwRoKe0+JLJIwfOm1JRJ0qZ17kip9e11FXipp/VRs
         0cnXYy9kMf/tcgT36gQr25tpozC79/XEchYsYO3tHXvwKOcdOI+YsfN3XQ0L7zQgjEaL
         uysVWxBeRg+LLkCuCXRLScWvm7CGQxBwBbooWzFPqzLMM6w0mLuxQJ+Nlr10Fvx9iEHR
         M5bg==
X-Forwarded-Encrypted: i=1; AJvYcCUAkk4cEQ+BFSbkeCrG2u8mjYRceECP2ucUEbDflzYZGTqEqXEhPKB83sGTcfIJzK3weiEnht6u44YPdr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWT/SqJ0yWXAVISerNBCzP3d/u2jC3hmMgUf7tf/7cz+gFbwf
	ujZjzCUQJ2eZdjarrjicNVb250zpZ/HNT219MU8fbHAtWJsxoLsISS4Kmkq/hWqv0YAL4urWdH7
	2jpJUzFwOMfzJhHRCnIZ6oGCISy91+f3viVSs
X-Google-Smtp-Source: AGHT+IHNn/80bAwbV/gVMgBG2OR6yzZFwt2z7VdJybvOFsuE/f7+OoV6aFj4QLToELhZAh1CaRLJsImbdT6goWg/5c4=
X-Received: by 2002:a05:6102:3e82:b0:4a4:8b30:53e with SMTP id
 ada2fe7eead31-4a8cfb5de26mr3927354137.7.1730060290830; Sun, 27 Oct 2024
 13:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026033625.2237102-1-yuzhao@google.com> <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
In-Reply-To: <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 27 Oct 2024 14:17:33 -0600
Message-ID: <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Matt Fleming <mfleming@cloudflare.com>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 1:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/26/24 05:36, Yu Zhao wrote:
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
>
> It's only possible to track this reliably since the "mm: page_alloc:
> freelist migratetype hygiene" patchset was merged, which explains why
> nr_reserved_highatomic was used until now, even if it's imprecise.

I just refreshed my memory by quickly going through the discussion
around that series and didn't find anything that helps me understand
the above. More pointers please?

