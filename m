Return-Path: <linux-kernel+bounces-388412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6C9B5F50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D761C21327
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C21E284E;
	Wed, 30 Oct 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMccqZvY"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10591E2016
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282077; cv=none; b=NRDpwox8muNcp4CMCZHENK2nTM6vRjwcy3OFnHULDaSmQ+N2ViiPiiEjaH93XmslemeAi95pFKsCsF+42GUelgcFbFqbm4igyNEPdc7ZSebkd4spF+ne8IdeRQ1CJMOwsMtwLqp7zkvlMzlnsJBUd5eaT8RAclotRonqGv8LU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282077; c=relaxed/simple;
	bh=39Ix/SJospyZR38U4GKG7hy0q05YbfUM/x+eNpbawAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtY8yx3od/ekpocQZPa1UQmXgLxZ18RE7uzeBY04ByThXMcMGFo7mJQ9nfAnmTmygzAWhjPjNZOsU5ZQ+4969Bbp4QaLhtCobWYy2qMWOLY/w6L4JFKoyvMlZU4Ksu1+3MuVCiEnbajkAYX0gdbvSwhGJyXnHEZfjpaWaVeoFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMccqZvY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so4515458f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730282073; x=1730886873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39Ix/SJospyZR38U4GKG7hy0q05YbfUM/x+eNpbawAY=;
        b=mMccqZvY4Wn0EAhvqaQJZOFwiZAI2h6tNVdBYTaxqK0cY1HWo1M8OxdFh8fQf3dXW2
         ZlDvt/sbOt2TArI1t3H0sCUALEKnAOcEcidvQPveL84H547NHoHfNNSWlydzq4bFAEXE
         moeVJiSVyuxZjSuymtEEteHIjP273CIRawPxAoXpB7w3f27IVlKIASASWR7ShQapvVnj
         LA9ylsCQCjtF471kv5L34nJ2EpYe5DPVhsGTgubp3iU3yzJck7SYxIDQaqz0VcVt+Gep
         96smJ5PZe2L+W9LnYEWV4AEyhnrChsdf90bLDSWhRvBb6zQPgZ+B6rQNIzdkRtsc4QB1
         Y2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282073; x=1730886873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39Ix/SJospyZR38U4GKG7hy0q05YbfUM/x+eNpbawAY=;
        b=dPDMSfyyy+00vjTYOFFbKBCg35NvlSaLmnGyRwUVIOEzIKOCrTSLyqQdlDKyn4lkKY
         sUjhAaR6bi0EzURR4vjPMU1NyLgbTd0qvczeAkMSDdu6/SQBj9dpPQxUdPl0iRApAW2p
         fd/Verdhb/dy7PZpp84s/7yvS7NG3LzONuWs1D+RKhLMgsduZWtIOwOKZbI7ybckumKQ
         WUl7yPoaOteAJc/CZcqcr50zcqmO78jIdknP8hNsqJtUGSibrkjtr6YnIOYq3pW5QxbV
         qvgohGTqSSXhV9jJcMpQkjmJ7X2qNv9vHoUvx2WsNCF3xGYH4Rtk4FJNVP6oPB6vn9bI
         +tZg==
X-Forwarded-Encrypted: i=1; AJvYcCUcH8mWXgu5BpCDyAtxvFfE3/zTwXxKFKjKm10ccCcm6Xg2zdYpD7SYfVlHaGfAZDe/syhVqwTah3IBGfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDvTiQpQxo5B6rpf3aJXKf41aIuTdloZ5f5pnfEO+N8FfKsWs
	uD3xDwRmvbK495YCfp4jYD15XoH7qEFLahkQXpeqwb5oG7sWnKHV/De6KKCG+2PMggUpzOMC7r3
	H4epEv7KnLHhdz2jZn5/QwUo9fuweEPyWa8pH
X-Google-Smtp-Source: AGHT+IFJzaejnYJElNz9zq/Lt1nQyJB1ktRWnzTAIJwTQydTdxe/5/Z+My/ZVsnw+DLqolx560inm53VcSo0a4xvUo0=
X-Received: by 2002:a05:6000:1286:b0:374:c3a3:1f4f with SMTP id
 ffacd0b85a97d-381b7076e1amr1836909f8f.24.1730282073114; Wed, 30 Oct 2024
 02:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
 <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
 <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com>
 <CABCJKufypN0c6EwiexQufjxMss-Y_fYdp+2XdpXU=4mmf2ZYgg@mail.gmail.com>
 <CAH5fLggiMkB5g7=hxN-a+9M3vMxWdoB1QCyX9D3+-_oJ7duQ5Q@mail.gmail.com>
 <CABCJKucqMyJa+GNZd909GLvrUPfKS4hN8-ac=2GMH6y3fT=q9g@mail.gmail.com> <CAH5fLgisaG8vRS6douNUuXOgp4ZsM=nD_ZLosE=q193K5pjvLw@mail.gmail.com>
In-Reply-To: <CAH5fLgisaG8vRS6douNUuXOgp4ZsM=nD_ZLosE=q193K5pjvLw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Oct 2024 10:54:19 +0100
Message-ID: <CAH5fLggsduKZJya0R+Gpn9C-4cphK7cJEe++n7A6JJCGiZ8bGg@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:47=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Tue, Oct 29, 2024 at 4:19=E2=80=AFPM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 2:09=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 6:23=E2=80=AFPM Sami Tolvanen <samitolvanen@g=
oogle.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 8:18=E2=80=AFAM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > > >
> > > > > On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvan=
en@google.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@g=
oogle.com> wrote:
> > > > > > >
> > > > > > > Hmm. This config has:
> > > > > > >
> > > > > > > CONFIG_CLANG_VERSION=3D190102
> > > > > > >
> > > > > > > Sami, is the fix not available as of llvm 19?
> > > > > >
> > > > > > Looks like llvmorg-19.1.2 doesn't have the fix, which means it =
won't
> > > > > > be available until LLVM 20. :/
> > > > >
> > > > > It's not going to land in a patch release of llvm 19?
> > > >
> > > > It won't land to 19.x automatically, but I requested a backport:
> > > > https://github.com/llvm/llvm-project/pull/113938
> > >
> > > Thanks! Looks like it already landed. Which patch version will it lan=
d in?
> >
> > It should be in 19.1.3.
>
> Looking at
> https://github.com/llvm/llvm-project/commits/release/19.x/
>
> it landed after commit 17365dfd2101 ("Bump version to 19.1.3"), so
> does that not mean it will land in 19.1.4? Or does the repository bump
> the version at the beginning of the version range rather than after?

I guess they just don't synchronize the bump with the release. It is
both under the tag and listed on
https://discourse.llvm.org/t/llvm-19-1-3-relased/82829

Alice

