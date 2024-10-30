Return-Path: <linux-kernel+bounces-388400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584769B5F26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB39C1F21D63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E31E260D;
	Wed, 30 Oct 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItueOXHz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A01E2608
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281674; cv=none; b=DRgcz9FanTk2MDo3Q6kHZ2AIRdX8/4l7T0rmySvd9CTBTx+NVugS1iFDahhApyFan5dEhFY33NBS5IKOGhZsx2jrY3FyhUev576Ux65NUIzF51Ec5zb1y+L1CSCSmi4Y//caCTHHJhzEpV2Tej27sTSH5GMQ1JB2Pt7qzVIcbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281674; c=relaxed/simple;
	bh=hi1vS7M7Cb02oiFGZI7mPIfB3ALjkTP8s1aT83tB9RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8qQkS6jKUBTIt9y3uoeJJ6ozjsCZWGh64KWLUUNDuQ9fVYN46y0/s7R6ZkT8NfEe75Q99c4AEy5F4VAuMR38ObeFgt7HBM2uOjHEgwjhS7qOTvnqm2Lm6MIrTmWGDw77N2Ajb1nK6EGmiRaVAhMz3bVx8KsymLgiG33L27y/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItueOXHz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43159c9f617so60101705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730281670; x=1730886470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi1vS7M7Cb02oiFGZI7mPIfB3ALjkTP8s1aT83tB9RA=;
        b=ItueOXHzhbAmBBxpFqebA95Ruc+bzjOyVTNpPrGXIFpXuC8HjchStg7vkJuJinVX/k
         ZPzTXWi4Zp3gfOXv50J6C4IBE5z4fsVgEAV2xTwJankQSg0lmlG+9RAot0mJ8+3VLQuv
         eIBW5dRu4S5NHDgHfPFtommqOOniPfRDeiuNLUhBR4OFof7fq5m4VD5JOdkfIegrdNY0
         Ww6H1tj6hfoP6CM7seE9LrJ2ZBX6mhIH/uA8L/HzMEHVkbEq2LSMOjhzf4vTAuhOgq0J
         nt7niEna9//Ah5VBGQV5767GkRqEbPasOzp1auVwB0PJMLCSknqMvvvKESYiBmAHZqbM
         dPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730281670; x=1730886470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi1vS7M7Cb02oiFGZI7mPIfB3ALjkTP8s1aT83tB9RA=;
        b=PzZtZPBG7PuX+NMFyD0ZRI5yfGNBJPQhgwBYIXwMNLwEB9B8wpqLE5vL8X87IGboNr
         a64hn3opl3TyT8PtfpL8VSkc4j3weW9SFZ0kVfVG+9vGQXER/z3HCoKcLN82ysgGvyJF
         4tLyfu/hdOxy68I403sBA0TbH6kZF/HCwWJJj7KQyuxKfFpHCpwGQccHb6O8XhCU+zTV
         6TIPn9hO30pmX4OVLpMVsW97s8x7YCPtdKXBRueaIs8nhMORJCPLPKcLUUkp07Mdbd8E
         67uFPvzCIOzr/fGzP2h+5KPpdWPYDAIaJ2j4JLm0zjXj+a8PCqtNSDTkbVwIcep+dIq6
         6d+w==
X-Forwarded-Encrypted: i=1; AJvYcCWitNEOp5MQp1LuDxXh042mFa/JVMCaZ4hsmvvPD8OnGdYvBMbtLYSoeTNRpvI7Bko0M8SwptHvQi+Oi80=@vger.kernel.org
X-Gm-Message-State: AOJu0YznS4xcZn9Wo/Hf+bmpyhqre27OxnyJV8tpumThvrt502QAm0p1
	OUsaASZ+AwXtEsc8zvyV3EwB19s9Q8OR8crMcnM+4fF2EJSCgm/X8XD/8VSW0ZsniKUqBBrXqcv
	Vcf657OgHX4VbFikYUa+ejmWJST03uB59ulqp
X-Google-Smtp-Source: AGHT+IEzMsmpWu43poaWWVqNaNJFdcXi+tTW86H6Qn6hltbtJBiOz/MZmz6DsXj0dlgOT/6hVbIWsWPMSHIc1a/EcuM=
X-Received: by 2002:a05:600c:3ca3:b0:42f:823d:dde9 with SMTP id
 5b1f17b1804b1-4319acbba20mr140922575e9.21.1730281670298; Wed, 30 Oct 2024
 02:47:50 -0700 (PDT)
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
 <CAH5fLggiMkB5g7=hxN-a+9M3vMxWdoB1QCyX9D3+-_oJ7duQ5Q@mail.gmail.com> <CABCJKucqMyJa+GNZd909GLvrUPfKS4hN8-ac=2GMH6y3fT=q9g@mail.gmail.com>
In-Reply-To: <CABCJKucqMyJa+GNZd909GLvrUPfKS4hN8-ac=2GMH6y3fT=q9g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Oct 2024 10:47:37 +0100
Message-ID: <CAH5fLgisaG8vRS6douNUuXOgp4ZsM=nD_ZLosE=q193K5pjvLw@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:19=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Tue, Oct 29, 2024 at 2:09=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Mon, Oct 28, 2024 at 6:23=E2=80=AFPM Sami Tolvanen <samitolvanen@goo=
gle.com> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 8:18=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvanen=
@google.com> wrote:
> > > > >
> > > > > On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@goo=
gle.com> wrote:
> > > > > >
> > > > > > Hmm. This config has:
> > > > > >
> > > > > > CONFIG_CLANG_VERSION=3D190102
> > > > > >
> > > > > > Sami, is the fix not available as of llvm 19?
> > > > >
> > > > > Looks like llvmorg-19.1.2 doesn't have the fix, which means it wo=
n't
> > > > > be available until LLVM 20. :/
> > > >
> > > > It's not going to land in a patch release of llvm 19?
> > >
> > > It won't land to 19.x automatically, but I requested a backport:
> > > https://github.com/llvm/llvm-project/pull/113938
> >
> > Thanks! Looks like it already landed. Which patch version will it land =
in?
>
> It should be in 19.1.3.

Looking at
https://github.com/llvm/llvm-project/commits/release/19.x/

it landed after commit 17365dfd2101 ("Bump version to 19.1.3"), so
does that not mean it will land in 19.1.4? Or does the repository bump
the version at the beginning of the version range rather than after?

Alice

