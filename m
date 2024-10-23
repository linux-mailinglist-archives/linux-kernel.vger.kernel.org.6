Return-Path: <linux-kernel+bounces-377801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9A9AC6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF061F22112
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5119CCEC;
	Wed, 23 Oct 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADIq34tk"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BD15AAC1;
	Wed, 23 Oct 2024 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677122; cv=none; b=UO53TUV+tralV5ceIuDcgbqiwD/gacup8F6LL91Nr5VUoYXosj+JT4yQx++DB7pZjFcIKIOuznw6iEEneyEu2UIfyanTW76wsUwNB8jxzpBIOa3hgEeQ0En2V9+LQVBp4S+0L/7xLP3LG+mxRM0usCzV2SrXj3sx921MMyM10/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677122; c=relaxed/simple;
	bh=KVG+LgeTsLcyc+fpYicfssUNkaHh7Ne9ebt7bjnWcAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZL/4CpqVAM/HX14UEY9YBXYrghrEDlZMiZg/VzkNE7VMprFfaMIwP/6AU7Rud/nWCy75aIIpF0UVf0pnSrboFQV0/nIF5q+uZT92hembQ7HcKWFP5rjcqHj4/FAOfbXs2URWfVkf/JY0rMXVA+rIYXZyQF4FKCFx02wGVjxzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADIq34tk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so440445a12.1;
        Wed, 23 Oct 2024 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729677120; x=1730281920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkQeDkofuLximRnKKf+OZHZQhGpW0sW9HFbld40vo3o=;
        b=ADIq34tk73aj0QdUGObx/CXRnYiQdO4xjaav4OCV0BVTlLkldNi+sNnnhV2hgTOqVi
         mPYCdf18o6abJAKxK6XsJdRzYYz0s7xBT1vol0FzPGPeLH0ZkRM2jPlfTblfaU1Veo6O
         5q/AgXXgeqtcVrjhdD8IO/koX4SUjSWucsiGvDtWCIhd/C26XUh42PZ2nFdTS2tLzG6W
         xQxTirdd5GJYNqlq08gGZexCqYBKUJmsDy73exGHHm9akysHGKS0iN9ly1FLuXFqI1nz
         2CK/GGfCb61xyIURk96a41rrxLoZd8m6TwJ4JMOQrHOnbJ3fbnuUPdiixw9NFCFHL8Xo
         GYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677120; x=1730281920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkQeDkofuLximRnKKf+OZHZQhGpW0sW9HFbld40vo3o=;
        b=eE11eoXD/nhxqQFMu45iRZucAPPH8R0I10AG/HWOVJA/Ug5ZZ4bIGGDFmxIclotXWC
         1Um5dzZUbduvB3EHZD2EPRUBSOAfsqiDDMEGnSxTstcyu224igKf2kqbXv7C4iB/oQ8/
         vZTgZXEXe+ntnu6ltfJUhM2knek/hrghTFx+bebMCS47LqaqCuzsSkk6vDIdHqfJZ/3n
         /rOwO/vZW/z0S7vtRsYmW0nmCv1pNBaDq8/SQkySWrujpuc94Y6U1BsU3rOkIwlhylTe
         Iu2nh2vqK1hrR9W4MKTbWUWOxMYOZqfYfXRo41ewW77YU/4xDlTAz6qDbNK2VCzAX8pL
         Ntjw==
X-Forwarded-Encrypted: i=1; AJvYcCUSnfQulgOYeDI41WbB4DRwM4BT24zoFSc/Ksjd+dWXeDsakn6Oa/dJO3N4+Q09QgbJFnwq42cYQtaEvQY=@vger.kernel.org, AJvYcCUzmrbsWc/Z2bF7tQ2FVvETwlSOZmaRbtJcqCCmeaTQ9BBFreReTbzTmid9K4OASAwoHMKEYEjuSeC67q24+U8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj0PnZre0XqBYiLIJw00IgFYat26mPhzt9IULHqs+cH5PviHQb
	rI9UkwGkA6XUhIS8puTFfZX69aAn6ayoeu93Nw86kpV+qKU7nVqAXiZjjnHccMy+txaePsGK9b4
	D5iMCLezhfhbFlXZqumOL/DJF2ME=
X-Google-Smtp-Source: AGHT+IFjo9VQQNSXEKEjdyoBruP80pCYF3csoMWfcpF3ddf2Rxdo/elU9rpL0xypUDw3Ellg5/pf7IG3kdG1uPMBRpw=
X-Received: by 2002:a17:90b:3cd:b0:2e2:a60f:289e with SMTP id
 98e67ed59e1d1-2e76b204452mr973258a91.0.1729677120060; Wed, 23 Oct 2024
 02:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com> <Zxitz41uPPeloK0o@pollux>
In-Reply-To: <Zxitz41uPPeloK0o@pollux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Oct 2024 11:51:47 +0200
Message-ID: <CANiq72nagKRUmHWVOFGNBuiVnqdmgqPm8b6ZtG1edobmrQMr3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce Owned type and Ownable trait (was:
 "rust: page: Add support for vmalloc_to_page")
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	aliceryhl@google.com, dakr@redhat.com, linux-kernel@vger.kernel.org, 
	airlied@redhat.com, boqun.feng@gmail.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:03=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> I wonder if it would make sense to make `CLIPPY=3D1` the default and only=
 disable
> it by explicitly passing `CLIPPY=3D0`.

That is what I wanted, but when I asked long ago to the Clippy
maintainers if using `clippy-driver` was guaranteed to not affect
codegen, the answer was no: for instance, optimization may be affected
(at least back then), and the maintainers said the intention is that
is not to be used for normal compiling. So I sent a PR to document
that. See:

    https://github.com/rust-lang/rust-clippy/issues/8035
    https://github.com/rust-lang/rust-clippy/pull/8037

Similarly, Christian proposed running `rustfmtcheck` unconditionally
on build and offering a way to turn it off instead. I think that would
be ideal too, but it could potentially lead to problems too, so I am
not sure either; see e.g.:

    https://lore.kernel.org/rust-for-linux/CANiq72=3D=3DAkkqCDaZMENQRg8cf4z=
deHpTHwdWS3sZiFWm0vyJUA@mail.gmail.com/

So I wonder if we should instead go with a "dev mode" like `D=3D1` that
enables Clippy, `rustfmtcheck`, `-Dwarnings` (even if `WERROR=3Dn` and
applying to everything, not just kernel objects,), potentially
`rustdoc`-related warnings too, and whatever other tooling/checks in
the future (e.g. klint), and not just for Rust but potentially for C
and other bits too (e.g. `W=3D1`, some important subset of Coccinelle
scripts...).

That way, "normal builds" (i.e. those done by users) stay as
fast/clean/warning-free/bug-free/optimized as possible even across
compiler versions, potential bugs in the toolchain, etc. And I imagine
it would be easier for newcomers, too.

Opinions welcome! I am happy to prepare an RFC, since it seems a few
people would like something like that.

Cheers,
Miguel

