Return-Path: <linux-kernel+bounces-309265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE2966848
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391BE1C23FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F101BBBF0;
	Fri, 30 Aug 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvjgDGnG"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C381BBBF1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039940; cv=none; b=dxh9x4GUX7SC1V3114kplZV26HuU4YJAhvFdul5aYYSwWWc/iHJ3pHozcpPydN2k0W+ckFTFt8YDn5W/0DupHj6lOTzWL503rRchR7Rtxu65+ECqg0rNtHBUZHaHfCvqxZtfd5OaleCKPCq+8NPQM4WoC/0dkQk4WBWAiGTXiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039940; c=relaxed/simple;
	bh=ThNEZGKKRi+s1cs5hbQJ+xtVuVFcI/+4LwCoqRexnoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE/I+/cHEX4gMB6zVAig6oRrmd1/9EhYx2o7R8FcH1wE7wAYGseCOmOwzdw59CmY2iXOt3CJtKQYgfWLBzM+JAIc1Ur3St1f+gMTgtBC5u2qkV82OWUclE0FGl2UHT1TOCEUiebazDIPk3rBuu9t+FtYQw2loMbugIuM3TVXSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvjgDGnG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6c3f1939d12so18527547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725039937; x=1725644737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azpsT0NFXGlhE8xUNNV5X8CWtenfsuPd8m4SIZciwf8=;
        b=TvjgDGnGnkygOTHQQfp45SGKxD+VRNjQTmxP1wKMW+DbGSucIniW8v/eNgW58Ebxk4
         2xFwJ4a0/jxGQwUZ8zzPF3p1X5X4V1sH/Xk3KkgbG3oisLpjuEOe61ZT1VpmHK67vcxi
         Y2RirM8hXkMz/yniHOjf33iMzg6bfAhRXk0h3UpCdye+c37Vx2GCVmgKsxF7+u48UEIC
         vUyEtwdd6PitHcA0eeuKlBFUuGQCfUb9skak9MdtWxZAaZiRMUjxeyJ6Pu3BCPgNlED1
         eDuxBymM/VeOnR/hALggg9HnnjVmSrYdL1bW8PPBPYBxMKRH7vvEdh4lpvqHeaBScfPj
         FO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039937; x=1725644737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azpsT0NFXGlhE8xUNNV5X8CWtenfsuPd8m4SIZciwf8=;
        b=K3k6aKk7xgqVlKPeRAKMhMNAV81mKLf0GG+DBsSoF2k16Ra+popQBczMeDH7g2g0vN
         CA8Wf6R7yRI9H3DSuUqNFNf/6xHxcsM+buVm6sxdRuf+zRWaNMxP/D0yGr9SlRStDN5+
         B9CyHpE3kC5xmOx0LZ9uLM/tRKSjez/mmTabz0JBn0FD25M+t78+QVfp1p/2Lrha7Pkr
         g4Wpu+2B8DAcXO/pHGLNcbrpDsNkoWx1TTCFBZ1wUFUOlLXY2wSISvazMuUwbQts0SoC
         cEVUbtTuP9OKNA0THGlOlKvtyN1PtKhYDJEGMd/anDFq+EiybFNKtEkKXn8S/wOqHXFR
         267g==
X-Forwarded-Encrypted: i=1; AJvYcCX95a1CH2n5vHxN+12On92qMyCh6/5PHlBBvARv4kiX+8N8u715Yz7ztRNa1J+scW90o6lt7o5Dgj9iYXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEe7b3M7vVnyQ3ile9UZC0DtAU5GrLeX1iGM61SkM7cByZXfR
	wnr87Ct9dYwzWDeoZlv7Cfhl2u0bp3/2MmLZbFQ7Y+Y5+BOsEgww87FS1mMea4sCO8EP9T/gArk
	DXFTJhqpwGqJ1IajWcGiHBYDhVQTB7/LKJB5U
X-Google-Smtp-Source: AGHT+IGcp0wnQ/zRxm9VODIQ0aDlBP7iiV43CvMwVqxDtzhppwfs0wrOvC0f7zW4ryj5VbvgChaKEDTD7WmudZ/g0NQ=
X-Received: by 2002:a05:690c:3386:b0:6ad:91df:8fad with SMTP id
 00721157ae682-6d40e689319mr34935327b3.26.1725039937243; Fri, 30 Aug 2024
 10:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
 <56d42242-37fe-b94f-d3cb-00673f1e5efb@google.com>
In-Reply-To: <56d42242-37fe-b94f-d3cb-00673f1e5efb@google.com>
From: Kinsey Ho <kinseyho@google.com>
Date: Fri, 30 Aug 2024 10:45:00 -0700
Message-ID: <CAF6N3nVWPJT+qrcz2jGw+sNoKge1qgDGSYg5f0Ur8a6O8ziUQg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals raced
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, baolin.wang@linux.alibaba.com, 
	tjmercier@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 3:04=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> mm-unstable commit 954dd0848c61 needs the fix below to be merged in;
> but the commit after it (the 5/5) then renames "memcg" to "next",
> so that one has to be adjusted too.
>
> [PATCH] mm: restart if multiple traversals raced: fix
>
> mem_cgroup_iter() reset memcg to NULL before the goto restart, so that
> goto out_unlock does not then return an ungotten memcg, causing oopses
> on stale memcg in many places (often in memcg_rstat_updated()).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f66ac0ad4f0..dd82dd1e1f0a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1049,6 +1049,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
>                 if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
>                         if (css && css !=3D &root->css)
>                                 css_put(css);
> +                       memcg =3D NULL;
>                         goto restart;
>                 }
>
> --
> 2.35.3

Hi Andrew,

Would you prefer that I resend the series with Hugh's fix inserted?

Acked-by: Kinsey Ho <kinseyho@google.com>

