Return-Path: <linux-kernel+bounces-319152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981196F898
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B55286F44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE351D3191;
	Fri,  6 Sep 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BforSi7k"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090731D1F6F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637676; cv=none; b=IeXpM5iXqoUUVbTi6hUYrx6PzffKC7cA816pOCLWNR79CxbHwVuEKxFivI6fzNh3egBadPcwFNH7YBByRfzJUlH67iuFzXCobr0k2m0Rb8RC8l1ieFMRAfE8sHdpctyxg/RdZTQCToaHkwXb1R0JzUp+QMuw2dGuOayOo4SJVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637676; c=relaxed/simple;
	bh=zp+DRchAoSH6nEhGn8NigH/AGNYz0sJ/vBoXvNGXq6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5B9Yf7oqYORPl6c6f5Ub67TYbDXbVxW4DckuUxF7rQouBmdZFmqer1xYvkRJt9qdmioiTh1uAYUjw9L/qgFUzKUpQ4lnD1Za+Ny8nOk8DOhJEGQ9sxuu6utgT7RYODjpv5QClVxI6bt4vL/iF1fJ0zhcw01MXnPgIjPwfV4Htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BforSi7k; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-846c59979efso589248241.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725637674; x=1726242474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhSj9nfZOKGx2oI8Vgr1Z2YFtbWDQo0OdEcOMXGBUVQ=;
        b=BforSi7k9socR64Te/cpapTn6yC0bYcbN3Sfzw/xTTMSFDrrNJOrW3NKVtJDXi3VfC
         Zdp4DusPrRw4KlUACysbWt/CCNZ6TjMUPnYa1x12BMyTMm/M0e7Im6erF9YMbIO2IA13
         +zBR3l7GHLCtnPQ/ySbCofJUlFWf9djWDIELjC4emJTJq+2ihklhinrQF+lYuRyQ11sl
         yBfVTnMQ5ffdww5Gf1sAL1NXeKHUZwBkFNHQg6jHXO0kXNNeiOko2Faw6mBoao3LXvWZ
         PaPWPN8fzjtffqPymGsZ2aanuDpdSkR2i+aF9dkP0WrJVt6qKJUDEWwAzBO/1bBgtT7N
         Nl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637674; x=1726242474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhSj9nfZOKGx2oI8Vgr1Z2YFtbWDQo0OdEcOMXGBUVQ=;
        b=JgfIVq2QHrIUlmzZFEtI/5PnLI57JIYmVz915PBBL/Fy9IxEgY+uQZjgNPXLJDpYnG
         XLQlM6I70pwnMCeAaPlORmnHjSCaZqYltZSNI7bnz0Acp9q0u40IUI0uppSaNGD7dmlJ
         z+/2WfRp7qwinKfAuajT2RmE5E54f+glyA2lrfwbiJnm/usoIqP3LHeQIPbE4g+OqXLQ
         G5oHRgpW46xTzaQUK6urjpCMvFEEw1FRDy0UTJqEHVNasNZXBkazRHdi1U31iqd7sOl5
         Wp/7xtRj/3eGhRYtdVbK81/UzeXvszAAk4KYcA3uhZHAR+70RK/Ve+MSJdCXrzNuTp2O
         4XVg==
X-Forwarded-Encrypted: i=1; AJvYcCWeKOTJaXkrZL1pDdmjtA2VxMSiB8CkK54dAv8u0jqqOID/5+YKldF7JRYXw/F0hLudnvTYq5+OK8Thhtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjuPV1MPXRnec0yN5a9ckwTHKMCy/8SVoagaHIqyjrhuaQ9cm
	82YJ1QoBP2MtjW/S9XQSLS+fTLGIKyBJUKDxooAdGTjS7F3Mnetulh1DB2rA+zssvmUXzr4imhz
	E0Lp8sEy4X896OvPBjmXhs+Xfm+sC1rpxBFgf
X-Google-Smtp-Source: AGHT+IF7X3uC600GKPCYXtrk3rXSJ/jRYK/ecUEv0Py5v9ieqTUOC1FYqsUcW+C1Bf7xEBaWosXwVByWGbyAX14C8rg=
X-Received: by 2002:a05:6122:1e16:b0:501:2a26:8ccf with SMTP id
 71dfb90a1353d-502141df589mr3197102e0c.6.1725637673925; Fri, 06 Sep 2024
 08:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-7-06beff418848@samsung.com>
 <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com> <CAK7LNAQytsDzaJfAJA0nL=KPjxj3DBCRLeuHUwgGDt8fTJ0fTQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQytsDzaJfAJA0nL=KPjxj3DBCRLeuHUwgGDt8fTJ0fTQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 11:47:43 -0400
Message-ID: <CAHC9VhS19s9+F2LhagbpxTR6DZPu_A8FADmBw7+BdaFQ6vx=LQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selinux: move genheaders to security/selinux/
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: da.gomez@samsung.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:37=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Sep 6, 2024 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
> > <devnull+da.gomez.samsung.com@kernel.org> wrote:
> > >
> > > From: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > This tool is only used in security/selinux/Makefile.
> > >
> > > There is no reason to keep it under scripts/.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >  scripts/remove-stale-files                                    | 3 ++=
+
> > >  scripts/selinux/Makefile                                      | 2 +-
> > >  scripts/selinux/genheaders/.gitignore                         | 2 --
> > >  scripts/selinux/genheaders/Makefile                           | 3 --=
-
> > >  security/selinux/.gitignore                                   | 1 +
> > >  security/selinux/Makefile                                     | 7 ++=
+++--
> > >  {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c | 0
> > >  7 files changed, 10 insertions(+), 8 deletions(-)
> >
> > Did you read my comments on your previous posting of this patch?  Here
> > is a lore link in case you missed it or it was swallowed by your
> > inbox:
> >
> > https://lore.kernel.org/selinux/3447459d08dd7ebb58972129cddf1c44@paul-m=
oore.com
> >
> > Unless there is an serious need for this relocation, and I don't see
> > one explicitly documented either in this patchset or the previous, I
> > don't want to see this patch go upstream.
>
>
> I commented on the previous thread.

I already responded there.

--=20
paul-moore.com

