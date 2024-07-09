Return-Path: <linux-kernel+bounces-246179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C27192BE9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C511C203D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A319D889;
	Tue,  9 Jul 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPlQ+8tl"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD115FA78
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539600; cv=none; b=Tn4dGRA3OcordZ8wKN6HRXBBXoggkvKFWIvtBkefb7oWrcZvxqab2wPKKuUmjJjXdmeVcUf0jaMJJLgBakLh9EnnuEZyjBW0ROZWlyGS2NYj5uwVS/5IrQvPqW0aiMIQT1VpuPtrBAcAX+YFaKbNvyKoZ2j34ciVeh8Q3ukwdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539600; c=relaxed/simple;
	bh=lO0EXZ8u0doWqiDCNT6UGt6hepafHZ/DVaQMdYvBbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORNVWYmsE2wbAFuqfl1yS/n7jZ11i3LSlS261ItZoET9wqlBB/FUFDMjpEHpmgpkH6mSMxiYj6j2W4HTbZc6rqgAKOJx6iQzWkwd7GbDr6OhvcKm7VIn+94np74ug85kzfkSC1bvB6Q8JBxzlZ8eQbBjkD0hr411+W0OSNXLDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pPlQ+8tl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367a081d1cdso3023575f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720539596; x=1721144396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij3mKo3zmTBAVQWjsn142BPPHP7peJhFQ7Yp10RsABY=;
        b=pPlQ+8tlOjFLL40ZRvQ9Ui76twcKq3CGmR//OYtTb/S2suPZjGQWnyCodSQJw4gxoS
         g/v1dsllw82nQMqnxVDDFYnt1lbb4buDsL9fdWGvAlStBEGbPpm/mAqcSckv77fL1pGs
         wN8bquWOlIJ/NQffU8DugFp3v8123VClW7rGz0WH1rbYhbSQEzVUlNLHwDoPyU+44vlD
         icAZvmugQMgLc5ja9BVcUbsA72Wztr4MGsmDXzcfIynbvMxTp7a1RYjesl0QtWZQ+/xl
         TX/mZ1g2b1uyJCrJyaqC0ME/ZdGDHxIag1lhMkauIoMGIkIh05g14jHtloPvydnU6rRe
         iU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539596; x=1721144396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij3mKo3zmTBAVQWjsn142BPPHP7peJhFQ7Yp10RsABY=;
        b=d9DyU5VydHwsULfLm2YoXnmdR2M4bLodj8vIvfq21EXOhlML7YxknxIwM1fjEXmYgc
         CBTWnnkKdIU8Je/blHrH/LfTCt8Lq/38maNm7iXkdQ9uCeq/et8HEZZC+17Gxv6wBDpZ
         rpv8TBWHXZdIHuolPNgF4EpYC7pFzI57aA4beZYzJtjjgZu58zqzAhHXqbB5/BUeWt6o
         k8fjYBV5YfL/q0021Ugk6nKZVdmCe6FprG+kSIeikWi7WqK+CVzSefvA9O9M5e2LEbdB
         SJGWphGh2WK7wbsAs7a9GATEX+aHgR+S3qnOQONjGlMvod2blMYYX/Spst9EVqx2u2ah
         nEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq27sr2I4A6DGspYbeC06+f6RFACXptxQ9ChahQcBhAz+x4GbirOuWWJJmoKrJ3BEry2w5K/10Mocuy/wfTjN40HL7Oy/ITNyQYBfD
X-Gm-Message-State: AOJu0YyNxUSXmYQ6m5y4soRmE3ZC8M9nmlRjYk/imUTFOOKXMAzkz+rd
	+f1pKx09DXWaE0Qz5hvsWCQirjq3+PtbxjsvYLvc3u9cmpShe9yN9vzsPdegMwYnKAwWK/Zu7qA
	HRFbIfuVo1UQQtxVPsyO5PJG97BHbRLHIlfp/
X-Google-Smtp-Source: AGHT+IHSk95HdHi4c6PzxIf8LwZMhKckgawRZD8wEYRhn3wS21A6Qc/ITn2wPdNvMmb0d6hzatZvDLV43Jg0B8ADrLQ=
X-Received: by 2002:adf:f6cc:0:b0:367:9571:ceee with SMTP id
 ffacd0b85a97d-367cea8fa2emr2321977f8f.37.1720539595631; Tue, 09 Jul 2024
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-master-v1-1-a95f24339dab@gmail.com> <CAADnVQJLgo4zF5SVf-P5U_nOaiFW--mCe-zY6_Dec98z_QE24A@mail.gmail.com>
 <270804d4-b751-4ac9-99b2-80e364288c37@leemhuis.info> <2c9089c9-4314-4e4a-a7e2-2dd09716962f@suse.cz>
In-Reply-To: <2c9089c9-4314-4e4a-a7e2-2dd09716962f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Jul 2024 08:39:40 -0700
Message-ID: <CAJuCfpFsKsA3vTZCPTCKL9-Xs9G+07b8vgr0PunqZzVSN1Lmmg@mail.gmail.com>
Subject: Re: [PATCH RESEND] bpf: fix order of args in call to bpf_map_kvcalloc
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Christian Kujau <lists@nerdbynature.de>, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:14=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/8/24 10:20 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [CCing the regressions list and people mentioned below]
> >
> > On 12.06.24 16:53, Alexei Starovoitov wrote:
> >> On Wed, Jun 12, 2024 at 2:51=E2=80=AFAM Mohammad Shehar Yaar Tausif
> >> <sheharyaar48@gmail.com> wrote:
> >>>
> >>> The original function call passed size of smap->bucket before the num=
ber of
> >>> buckets which raises the error 'calloc-transposed-args' on compilatio=
n.
> >>>
> >>> Fixes: 62827d612ae5 ("bpf: Remove __bpf_local_storage_map_alloc")
> >>> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
> >>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> >>> ---
> >>> - already merged in linux-next
> >>> - [1] suggested sending as a fix for 6.10 cycle
> >>
> >> No. It's not a fix.
> >
> > If you have a minute, could you please explain why that is? From what I
> > can see a quite a few people run into build problems with 6.10-rc
> > recently that are fixed by the patch:
> >
> > * P=C3=A9ter Ujfalusi
> > https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.=
com/
> >
> > * Christian Kujau
> > https://lore.kernel.org/bpf/48360912-b239-51f2-8f25-07a46516dc76@nerdby=
nature.de/
> > https://lore.kernel.org/lkml/d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdb=
ynature.de/
> >
> > * Lorenzo Stoakes
> > https://fosstodon.org/@ljs@social.kernel.org/112734050799590482
> >
> > At the same time I see that the culprit mentioned above is from 6.4-rc1=
,
>
> IIUC the order was wrong even before, but see below.
>
> > so I guess it there must be some other reason why a few people seem to
> > tun into this now. Did some other change expose this problem? Or are
> > updated compilers causing this?
>
> I think it's because of 2c321f3f70bc ("mm: change inlined allocation help=
ers
> to account at the call site"), which was added in 6.10-rc1 and thus makes
> this technically a 6.10 regression after all.

IIUC the above mentioned change reveals a problem that was there
before the change. So, it's a build regression in 6.10 because the bug
got exposed but the bug was introduced much earlier. The fix should be
marked as:

Fixes: ddef81b5fd1d ("bpf: use bpf_map_kvcalloc in bpf_local_storage")

> So what triggers the bug is
> AFAICS the following together:
>
> - gcc-14 (didn't see it with gcc-13)
> - commit 2c321f3f70bc that makes bpf_map_kvcalloc a macro that does
> kvcalloc() directly instead of static inline function wrapping it for
> !CONFIG_MEMCG
> - CONFIG_MEMCG=3Dn in .config
>
> The fix is so trivial, it's better to include it in 6.10 even this late.
>
> > Ciao, Thorsten
> >
> >>> [1] https://lore.kernel.org/all/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@=
intel.com/
> >>> ---
> >>>  kernel/bpf/bpf_local_storage.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_st=
orage.c
> >>> index 976cb258a0ed..c938dea5ddbf 100644
> >>> --- a/kernel/bpf/bpf_local_storage.c
> >>> +++ b/kernel/bpf/bpf_local_storage.c
> >>> @@ -782,8 +782,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >>>         nbuckets =3D max_t(u32, 2, nbuckets);
> >>>         smap->bucket_log =3D ilog2(nbuckets);
> >>>
> >>> -       smap->buckets =3D bpf_map_kvcalloc(&smap->map, sizeof(*smap->=
buckets),
> >>> -                                        nbuckets, GFP_USER | __GFP_N=
OWARN);
> >>> +       smap->buckets =3D bpf_map_kvcalloc(&smap->map, nbuckets,
> >>> +                                        sizeof(*smap->buckets), GFP_=
USER | __GFP_NOWARN);
> >>>         if (!smap->buckets) {
> >>>                 err =3D -ENOMEM;
> >>>                 goto free_smap;
> >>>
> >>> ---
> >>> base-commit: 2ef5971ff345d3c000873725db555085e0131961
> >>> change-id: 20240612-master-fe9e63ab5c95
> >>>
> >>> Best regards,
> >>> --
> >>> Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> >>>
>

