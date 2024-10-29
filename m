Return-Path: <linux-kernel+bounces-387193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8C9B4D74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA924284153
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96435192D91;
	Tue, 29 Oct 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOx9+8QS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3618C936
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215177; cv=none; b=jQ9U7Swep8/lbLzoQqvA7Q4FT3IrHDUIoTXAuO+HcJb8/dXHxyBn1uOGWdLeJ0hjNuSZlDfpIUt45Hi2H0NDmjtlKC37I4qSPQZwkHr3ZP/irh4kHhnQQjLHWqxzPJMwU3tpx/uKUb8Qxjm+aiKJsAgh6IT+voDDB0R0LXdSPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215177; c=relaxed/simple;
	bh=QIOEFvu4FMncIty+EQ4CDd4qN6V5DqirfrcW+1k0Jgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXoxn7m/j+7cqmycLCieYri0ZANDQ4tbaLKkbhI2v/BD0CE/JZdQLwVDz2KROThg+Fb4Jy76kYqTUPUzMgd2G6KhBbplvhG16h/5bS5U4AaFri5G5AVdWBsyriOOlAqKGQK7ag8wll9EpOuGDsJ1hGXoVauyah6AEkkt+GXvx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOx9+8QS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so238605e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730215173; x=1730819973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIOEFvu4FMncIty+EQ4CDd4qN6V5DqirfrcW+1k0Jgc=;
        b=tOx9+8QS3MTPbe+56ekmI1IZtJaCYvUWhQ21UBTYf9d+lyDHcAXyOt79P+Sy587CU0
         XxmvSyVRO+9FtWHD7deMiD/0PPJmyzVqLJuBxVUsQzAGCL2r4qaDcY+oobvPkIZqhl5O
         ZVn2FckfW/VQtU+ONdlHVQpPP8UBl2o7wexWQOwxODimXN82KA23MF6Wosac0xhcKL28
         0dAZhpgGfbnkZtHhJukWsXoKDDIRs13RKF3EX9Oab2bL7AiyBZeOoc4r2sgLsVNuUE8k
         1DKi0UufE3Njl8J3FrVMgL9686Rc1MPO8Xx7JCqKrkNHCujS4bNfMPcSLkdZsaKm1lz2
         JmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215173; x=1730819973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIOEFvu4FMncIty+EQ4CDd4qN6V5DqirfrcW+1k0Jgc=;
        b=Kl2jdF53zIage9r5R8kIuLGOr9Q0TQAsuOshItNnMEy3Frgm7+OwLHGhrej3GBaCbt
         A/hatiho1CFi1QoAkORQ3TnTDgBPHyPF7hiG8fJFcauxmcLtEBqE28fn7ywZQ6bbEqUj
         uvGVam2nFuo6JpgdjwoaFn+AxKBLAc4U3zKtZ8f377bUCnbOrpT5Wq+OtQili2qAmvx7
         zQfKU+8+Obg8prVLaQHjp9W8pHo8n7acLDec7BkvOgE5E7Lks4WsEPCDnx1CYoMoyhPi
         tcPzUy4k0CceGnFv9ch1O8Bhz0/5FXP7c7F002t1VCR1/5vc1izdIDsI8Mhf30VdxzER
         Zcrg==
X-Forwarded-Encrypted: i=1; AJvYcCVidtj1ebb/Omj1U3b3QKXEOKjV0tFgnB6QGuAK8YnA2UndYmR2JbUqP9CVzw7TggZYm3oh8kmQzLwyvsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+RpmUdvw27UZV0uyW78qWkknN2dAj/XK3g8ufd1mbgslQemj
	eudc4s0vcCJybK+PaLRvvLaIymFkEhqX+Df7UCU/6fVK76DM6p9JNGirRqiU4doM9NdC4nnD9zj
	nXN5Y2tSwilGxILZl9435PHy/pBF0gvde2RFB
X-Gm-Gg: ASbGncujHpZlgSk8dxkic33jCrNgJMzYt0f4YQnY91Cup5bpsl2DxzNyYpT273oepaV
	8amK++6kGQH8ToIjoZqAGB3c0Jh0y
X-Google-Smtp-Source: AGHT+IHu1NlcguibIZqU5bOGPh7SLbPXvlIkXx5brhOqK848UqAFYgPPZ6g4zp4aNdE3qqvrj7UMkAPrUNhisNoxLXo=
X-Received: by 2002:a05:600c:34d1:b0:426:7018:2e2f with SMTP id
 5b1f17b1804b1-431b4a39c00mr4083995e9.5.1730215173087; Tue, 29 Oct 2024
 08:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
 <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
 <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com>
 <CABCJKufypN0c6EwiexQufjxMss-Y_fYdp+2XdpXU=4mmf2ZYgg@mail.gmail.com> <CAH5fLggiMkB5g7=hxN-a+9M3vMxWdoB1QCyX9D3+-_oJ7duQ5Q@mail.gmail.com>
In-Reply-To: <CAH5fLggiMkB5g7=hxN-a+9M3vMxWdoB1QCyX9D3+-_oJ7duQ5Q@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 29 Oct 2024 08:18:54 -0700
Message-ID: <CABCJKucqMyJa+GNZd909GLvrUPfKS4hN8-ac=2GMH6y3fT=q9g@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Alice Ryhl <aliceryhl@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:09=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Oct 28, 2024 at 6:23=E2=80=AFPM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 8:18=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvanen@g=
oogle.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > > >
> > > > > Hmm. This config has:
> > > > >
> > > > > CONFIG_CLANG_VERSION=3D190102
> > > > >
> > > > > Sami, is the fix not available as of llvm 19?
> > > >
> > > > Looks like llvmorg-19.1.2 doesn't have the fix, which means it won'=
t
> > > > be available until LLVM 20. :/
> > >
> > > It's not going to land in a patch release of llvm 19?
> >
> > It won't land to 19.x automatically, but I requested a backport:
> > https://github.com/llvm/llvm-project/pull/113938
>
> Thanks! Looks like it already landed. Which patch version will it land in=
?

It should be in 19.1.3.

Sami

