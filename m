Return-Path: <linux-kernel+bounces-547676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D367FA50C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E25188A8D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4465255E4D;
	Wed,  5 Mar 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e4DmnVf1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8508255229
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205579; cv=none; b=A7LcOSC/EOU9RKVXX9Ro23GlZ4KIn5XJIhyuyNODbF+hhUU3uImHtTZFhaE7JLTCpoyhAdKTjD03zODD79xAWOxquOoAx+ZryZjmrMVWLoeFUGn7lW9+pin4mkGgvpXcCz1dAouVcwRCkHhKLRT2QhoqNWInArv+Ir5nrumqEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205579; c=relaxed/simple;
	bh=zNu+uO+qVUH2lHjGc7UpYzRsUdmyNBFYkU3NKGrAkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMTGeGza8E9/lpmjU9pOkHGu7Nucjk0bIHXUKVG9+TwSfS9kfdNnHFxHpQgy44SxcxtO2jzv3z4SnHFocYjY4u82q6pZMEIwXaobe3njU9i2huzFvx52x3HaiXkAO3Sk/fBrQ9ubWqfsPFZvBWDn+jO4enjpXFtfcjSISnyKBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e4DmnVf1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e549be93d5eso7721817276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741205576; x=1741810376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=e4DmnVf1JnnsCxVgdzaOP4TrtubowOesKiuaSgiG9QO+lp0h+qY9DOgENeER2dLmqG
         CxOVClWd5YkgpuoYVRAk9UCwndpm11nb+Aysjyufc2MuYE/YqThJ3hv8ZfRuxosEZLkH
         JCJaa0Ju0njoFu/iWOvAarrPbHJuCBNuG/90tnNI04Ja9zo3tyjdFREQHu9dHQ0+/DPm
         8CQDPp1dRekR8F+Kn6j0PYfZUGm3RcmYatxnXY41ndACeTeg1YpEyxOsTLszIrqBLG9Z
         xzqLmOhkUJAPTbZ5UPLnAFFVUq2JZh7x/bnjRkZNI4xnThy5Q4TXmXZ2y8xzJzBCsXLj
         n1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205576; x=1741810376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=w+kl8/o40ky+10GRPpm1u3ZCS8cz64TQPE0raZT8scP4LOL1LeUOPiCRWNk/7zEGY+
         FqVvVUGAVfLj0B0dz8IgXvJv0Bb1pKcE6MHDoYjLzIhNZIK9aetz+D6YX9vTXmq5Dzjz
         X2yoI3N3mPTNCTppW7enrKPefa7KAwCNyQv2kQrVF+e8BxUY50QU2vpS+DsBOCWqwW35
         /lxcBJ2gumabFocPJwkukkfAfFQa/WwfNWamvULFNvjFXwqbt+/05a8Y644bN8nWBNw3
         XpkWuQkeH23BSaNL7Jo5k/G/IkBbT3JXk7mOLwhQ7wrpYkz467HgoPAMscm4RTzUNml1
         WqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVED1gePmfQuMSyw4VUFzmOy5shYUqX6sXLZkkZk3fT+DOOYFZK4TlO1SvS3xqALqm5GHPt7mAGh+oWP2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOsMYIOk+oy2JY3/5XLY9hrSFDIr2L484Vsv/a+LINTrlZCLl
	DhRwXmkl0SaQNNz97UVvtjt2VFxWzoFEnDbzOQa00yMi7vUNhvUq5QRjQjeyjbmB+HpL5riPfc/
	QCLFgaMUXQHo9ukvSQ4NvmdFXeP/58I3C49OT
X-Gm-Gg: ASbGnctM+lucm0ZW4rambhOySVraXSBChYAGgJyJL0eEcE4XLSIhCnajo76RroYJXMM
	b4dYJknqiV+yi24sIde7DJWf7qaqeMywBEZaw6vyggRjwlif9NA0xgIfQV/PRnrO9/r+lhmo3wf
	4iGFxWhbfEEt3EZeJuA+znfxcAzw==
X-Google-Smtp-Source: AGHT+IFb1lQWxZfA+3Fj3IIMOvkgMjpy++obS3VPsP4HPWlePPjHMEfo/RAlFL+2ENHWUfAYeV2u1UeTQGpoYyph5bM=
X-Received: by 2002:a05:6902:161b:b0:e5d:d2ce:a40a with SMTP id
 3f1490d57ef6-e611e30582dmr6534407276.34.1741205576740; Wed, 05 Mar 2025
 12:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
 <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com> <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
In-Reply-To: <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 15:12:44 -0500
X-Gm-Features: AQ5f1Jp_oXF4bydH-aIRtYZmN6RTF7YwHfbbSgRNBrjTiC_WlFGzFQqTRg_361Q
Message-ID: <CAHC9VhR5NmSU+eanprCk-osSMZnZ+ODwLJKWuqd8e1qDobim7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 5, 2025 at 8:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:
> > > > > Paul Moore <paul@paul-moore.com> writes:
> > > > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > > > <bboscaccy@linux.microsoft.com> wrote:
> >
> > ...
> >
> > > Do we need this in the LSM tree before the upcoming merge window?
> > > If not, we would prefer to carry it in bpf-next.
> >
> > As long as we can send this up to Linus during the upcoming merge
> > window I'll be happy; if you feel strongly and want to take it via the
> > BPF tree, that's fine by me.  I'm currently helping someone draft a
> > patchset to implement the LSM/SELinux access control LSM callbacks for
> > the BPF tokens and I'm also working on a fix for the LSM framework
> > initialization code, both efforts may land in a development tree
> > during the next dev cycle and may cause a merge conflict with Blaise's
> > changes.  Not that a merge conflict is a terrible thing that we can't
> > work around, but if we can avoid it I'd be much happier :)
> >
> > Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
> > and feel free to keep my ACK from this patchset revision.
>
> My preference is to go via bpf-next, since changes are bigger
> on bpf side than on lsm side.

Fine by me, the patch has my ACK already.

--=20
paul-moore.com

