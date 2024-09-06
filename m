Return-Path: <linux-kernel+bounces-319108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B5496F7CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512DB1F25048
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C41D1F56;
	Fri,  6 Sep 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="pT9LGt6H"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9201D1F59
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635214; cv=none; b=Rlu7II1zMEEUe16BG/YE8OcNu5QmId1ii3ryXSRBqZCjTCuWdBpgxGnqHaZ5g+uW5PgWminwRzQzAzbM0w8lgcl60tX/TV1vv7Z6j2U0MHGPyRs48WF4Cf/f8f4wUFlx0BDtT/oceD4wfsPFTZgMOe55eg6VDjiVhgUObB0JrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635214; c=relaxed/simple;
	bh=aQLKfK6IyeVlvPZdEpJhpjuD9yzE9AaUJBwaw3oLa4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srzt6vJ+ySZb2oOjAUgwNDntsoYrjZlz1QjMgJ5y2G60LuooL9WuPl/812Q9AsPJOTdK5M+UhMrkX7rwH2aHXg+7jftMMfw5rBrujkxRelfxJxeZ0Ms+cM2+wLlAKXlsdrGVSpwW8eDcHFsBDU4ZME57mVfx/ARA0w44isF7zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=pT9LGt6H; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8696e9bd24so277732366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1725635209; x=1726240009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9ZAlMwEyYD75XfvfcvFROEESwWLuQ5Z/p2zffJIs9s=;
        b=pT9LGt6HoMXbBN6Jb11wMUrNNRszdLRxKwZK2np3gYd6xtdWx554OI2X6ryv7x9sj9
         egV7RxfVPXlVEjVEwOV6azELU6NUOQaQNtn2aVi+XPx+YdBiWBYOg9Lkhjh6JrumSZEW
         k/zixBuf4n/9A48lPNSgALlpPuXeiQnbBj/byCznMYchDb89+DpEC+nE4hdiZ/kKn6tu
         5fKVm8pN72HP+YyC1eAEk9GUuNaEAB+h1qBYMAmyu5CymxP/sTv8BRWh2XO2OZgODq+U
         EHJ+4rGLO2kBF6JQEOWkfsuIk4st0Uq6uoyK++ASAT6H6TDKRIVkKm+uBy9kvt2vPtZ/
         78nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725635209; x=1726240009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9ZAlMwEyYD75XfvfcvFROEESwWLuQ5Z/p2zffJIs9s=;
        b=I+5CAoQ/h+V3e8ahTkmlSFP4GIRRXr5lXUH1h3qg1VhlpplbjJOlEDKz/Diky+Lxfl
         1RumCi2J8i12ZsBRG2WoPgwhmU2xNKeYAzvh2BUCsBKAsNU6IUJOokipFdolzuQVk2sY
         ILyNfs0NLg/70S3Uhq0fdIWI25ES5Rz2WZGtgp/zeXzw6ytCHcjko/klP31JBGh3ZrYV
         W2uK1OMtvIoEwbc263c/ngEmAO4dpymVNYGwqstJq0uAdMb+JbpQJ8saZiELeXqmul3q
         saMt9WO0QP5L0qJ0ik2vAVboyncOKDNGOnbXaOwBlJlP7nYSoR+RAnCfZ2Py7tUp5Zt3
         NPLw==
X-Forwarded-Encrypted: i=1; AJvYcCVfNsj0K17f9ImZjf6cC9FTKlrMjdSiqAOThBSgWbp1pGTbzvHjxM8tgbIvhBVclPqp9Y80/iTpy7OH4qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82KIEq/F5MtBphibzygzfMyWfhls0PHqVIkOFixbOAiagIezM
	a76tyA8mSgJBGEvmmteQC2YykKC/lMdvpXZ7h1JdGbU4vMQZaIRevoFZkLo/mHtL8FlVelCqh8z
	BEeO5Y4E5JjLhmY/V9XaoR/phknZVrd6rsqdbSQ==
X-Google-Smtp-Source: AGHT+IE5oYDSfTzIe6hHUgUBH7wdkZoXXSF0xeHeSRG+IYdoi10a74SFm4+xUjHqeOxdrh5qK7III9nawL/szJxa908=
X-Received: by 2002:a17:906:c141:b0:a8b:ddf4:46f1 with SMTP id
 a640c23a62f3a-a8bddf45606mr100660666b.63.1725635208952; Fri, 06 Sep 2024
 08:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com>
 <20240906-macos-build-support-v2-7-06beff418848@samsung.com> <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
In-Reply-To: <CAHC9VhQkstJ8Ox-T+FLU34s9U0gezRba6bMA-tUPs80u6sVh2g@mail.gmail.com>
From: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>
Date: Fri, 6 Sep 2024 17:06:22 +0200
Message-ID: <CABj0suCtCfd58+i0s5LzsTUwwd=1o1nMRvmqsxsraJcTiX2mSQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] selinux: move genheaders to security/selinux/
To: Paul Moore <paul@paul-moore.com>
Cc: da.gomez@samsung.com, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
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
	Finn Behrens <me@kloenk.dev>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
> <devnull+da.gomez.samsung.com@kernel.org> wrote:
> >
> > From: Masahiro Yamada <masahiroy@kernel.org>
> >
> > This tool is only used in security/selinux/Makefile.
> >
> > There is no reason to keep it under scripts/.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >  scripts/remove-stale-files                                    | 3 +++
> >  scripts/selinux/Makefile                                      | 2 +-
> >  scripts/selinux/genheaders/.gitignore                         | 2 --
> >  scripts/selinux/genheaders/Makefile                           | 3 ---
> >  security/selinux/.gitignore                                   | 1 +
> >  security/selinux/Makefile                                     | 7 ++++=
+--
> >  {scripts/selinux/genheaders =3D> security/selinux}/genheaders.c | 0
> >  7 files changed, 10 insertions(+), 8 deletions(-)
>
> Did you read my comments on your previous posting of this patch?  Here
> is a lore link in case you missed it or it was swallowed by your
> inbox:
>
> https://lore.kernel.org/selinux/3447459d08dd7ebb58972129cddf1c44@paul-moo=
re.com

Apologies for the unnecessary noise. I=E2=80=99ll review your feedback and
revisit the patch accordingly.

Daniel

>
> Unless there is an serious need for this relocation, and I don't see
> one explicitly documented either in this patchset or the previous, I
> don't want to see this patch go upstream.
>
> --
> paul-moore.com

