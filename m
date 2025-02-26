Return-Path: <linux-kernel+bounces-534365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE5A4666B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7C426CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD389221D80;
	Wed, 26 Feb 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kw+PK3Nq"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB521D583
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585458; cv=none; b=eCPp3Ydm12ktNwu13sxg7wB6zMiiOkMSgSeuiBbUm+swkBYugKL+2RehZv7nDGKGYsAHvRnfC+iyHzCuIHjnuUFYAn6NRFiZxXn+zNg+FuXZEoAgvgQRdkXjLMxJSlcrtO+vJ2veVL1OO6M08VIL5Uc4+DZ4wc+ZFPdU5RhpllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585458; c=relaxed/simple;
	bh=59VdEI2rBy+d1m76/S0g6/tGo0P+zWBuf7eI9U8rZZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y53cAO2miIVnbPi8cQqulRt8JvQ+Td9fZ0qGAkO0qAbIt7hfSdS7K+jfq/qtz2HogbSSjtyhtYlvj8EcrZqLW1wu9siTjuRgeBtO7SVPxOlzrNZ6PLnVqJV6dW7PwDsF4E/O+AIHJa2pr1kQoiKIe3ioNaFEAdrvNvSdciRa1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Kw+PK3Nq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5db2d767f2so5433804276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740585455; x=1741190255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTEZRC0guY0i44I90elxKU5uA+fxPCt+MgWlS+WCEoA=;
        b=Kw+PK3Nq5ApoUIG3Qg8sE25sguWY12zUcofUmZQtWeTE1SVgm9njf22w2fzAtVrpQB
         P1EOxpV7by5gDTWc8Ji6R0/VEv08M1hHo7qDcaKN2xhVQnX1SSat007Etq0wv/ahfNp1
         iJknVUDTgBCrCOi12uqOZ55BxxiuUL3enUpYmKxGPLf7jLmnL3HrIJIxqyJRkaKk9U/f
         9GmkJao0UiOPbhnPbm7t9nk7nFITJuBW6cfJG4R9UzRdoMAhgzRSRxu9FQqR3hU2wKdN
         fO1EustKcH2Bt9nJ1VRbNeVwCfD0j1id6veeC4L9sGFK+srpTROGSDwDrXauGAaudCC7
         tTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740585455; x=1741190255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTEZRC0guY0i44I90elxKU5uA+fxPCt+MgWlS+WCEoA=;
        b=DGMpQKFE40NchGWp0aqbFo/GuI6tUGWy2oGSrbjHqIuSZQg28SS/Hb13xF3k7XXXLI
         CbHeAxaU1BlU8HvwjPdH8gTY5XeFZbZ5HeVrnYrtioqsjVOQHtEZb2igDZUJNaCEhCqq
         H0xPZd0RTuF8WXQU26dJnVCS9dhT/CTc3AjsUn/AmnK56rbjOpFTLbMDnzI48P5NvdEF
         duofYEhD4IjZr/WkGzncfFpn+d1iVONMIL7WVqGusPqeuwXbWDv7onLQWMhkNWx4SE4F
         ttUZG+a4aj+YZPjoq+esqxdr0AqD/KMt4+aSVUWuj0dVuIFVSPuxxkUmbLRH2FTLaLkA
         Svaw==
X-Forwarded-Encrypted: i=1; AJvYcCWE8k9u7p2tu/vlOJSqA5tsct9qYLncx6VHLVHXR31ntEQ8wbsYaxpUYkrHWCc9L92nBvPhvIn55km1Vn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwuIJsFgb9ZwaecOvah+RMBEwXJh7BwgdVjJOaiXqMtxbdT+D
	FrnqUkHp+60pS/SFFCromVbVr+JK/q7lW5OF5+YzV6pgRMm93Uf53Ahl+fvErtApsjUCp+dBo9r
	9GrEF4FohcbIrWHyI2+Q+Jt4Lg8u+7A2v9n0y
X-Gm-Gg: ASbGncvs/VazWM9pzGzFO0EqEunbBHx9o8ET7Vo+9VaTcctsixj1n03vFnKk0oKswmG
	CPsGO60HjB/kboraqjmMX0zQeAaxVSG0G0hOTmHBo1ITcci8jqMmOyBCjhUthD1uXqFcTWxQUT6
	u1eAnPeJs=
X-Google-Smtp-Source: AGHT+IFH+gpBtOHXZppIp2fl84NjvsbIRPhAR0sJm1rizuyRz60NgJJh8Zs6NY0f9cGV/7yczMUYu/Jph3y1o7+NVnY=
X-Received: by 2002:a05:690c:6303:b0:6ee:66d2:e738 with SMTP id
 00721157ae682-6fd21dd21d0mr42627597b3.2.1740585455503; Wed, 26 Feb 2025
 07:57:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226003055.1654837-1-bboscaccy@linux.microsoft.com>
 <20250226003055.1654837-2-bboscaccy@linux.microsoft.com> <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7=uALYiLfKfApvSG0V+RV+M20w5x3myTZVLNRyYnBFnQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 10:57:24 -0500
X-Gm-Features: AQ5f1JoD9duQ0JL_CjsyBWKC0ngLOXb9NPe6dh7dHIluAww-shddRwfboF0WYfQ
Message-ID: <CAHC9VhS8ST6ODB2pFJTMK4qu8FdM2J=6qEbB=XGxo2ZAZgo1Aw@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate universal pointer data in bpf hooks
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:06=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Tue, Feb 25, 2025 at 4:31=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> >
> > Certain bpf syscall subcommands are available for usage from both
> > userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> > need to take a different course of action depending on whether or not
> > a BPF syscall originated from the kernel or userspace.
> >
> > Additionally, some of the bpf_attr struct fields contain pointers to
> > arbitrary memory. Currently the functionality to determine whether or
> > not a pointer refers to kernel memory or userspace memory is exposed
> > to the bpf verifier, but that information is missing from various LSM
> > hooks.
> >
> > Here we augment the LSM hooks to provide this data, by simply passing
> > the corresponding universal pointer in any hook that contains already
> > contains a bpf_attr struct that corresponds to a subcommand that may
> > be called from the kernel.
>
> I think this information is useful for LSM hooks.

I've only looked at it quickly, but so far it seems reasonable.  I'm
going to take a closer look today.

> Question: Do we need a full bpfptr_t for these hooks, or just a boolean
> "is_kernel or not"?

I may be misunderstanding the patch, but what if we swapped the
existing 'union bpf_attr' parameter for a 'bpfptr_t' parameter?  That
would allow for both kernel and usermode pointers, complete with a
'is_kernel' flag; or am I missing something (likely)?

--=20
paul-moore.com

