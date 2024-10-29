Return-Path: <linux-kernel+bounces-386575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DDC9B454D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989171F22749
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E4204039;
	Tue, 29 Oct 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eahB84HQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C12038D6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192947; cv=none; b=B/MkTUZTGovJPo0hWP/RZxjxgCEBEDWzA/3E2UPmXCx5TFrLJBFIJc4WIjMjngbjhl9XLehqBOA6sVaiVXanfHyhgdRWW1VNo0jvy6yUHhL8U3q0H1smo/wCQTVIeV/Hdn+5J5xFjTLiekmsNyNpA+4EjRsjsjDAsEqWCkw04l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192947; c=relaxed/simple;
	bh=Ybash4pv5nyVrAZaJt2dYgUqiEmKyR3rbX3Iwp7HQHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1aNITWnvHCZf7FVZtAW4Wj/qtEOzlgujTk/rhfyJ/X/BExEyuxWvL5CHbfgIoYI7TuaUfjDK02HOZRQpfATcV7DZM94abxxJBub6cRI6VI+qQWY6cN9FUNKWuH2nKm2hGDmNbCYo2kXsu3gOD+hbND5zIikSVY4sDh8zKMRDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eahB84HQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so53928985e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730192944; x=1730797744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ybash4pv5nyVrAZaJt2dYgUqiEmKyR3rbX3Iwp7HQHM=;
        b=eahB84HQHw2GaEhzhmuU9TnFVgdJAHzd9/UJDHwhzw38ytx9mZQGJJS2uOLT79Mfz+
         MsSDrR7ORppdFWdkcvAD7rymnH5xexpSl+mnDEMSrw+h+x7KZhMTNGESazKJsCKMuzlf
         ewGvBWd2hBWBttVOj6KUfTFTWmJHNjPTQSc9sK2RWyQRz/jo3QOP+oUgyiUvcbPPbUSf
         G5H2Q4Tg2CxhIv2xavzwH9LVhejkjrehZXn8z3Y9NJ0qd4KQnzsxuUj6wNLD2a0c0oC7
         Jk7Iq9+4p+fM8FqckDnV7OHwjrvY+Gdy6YguWRJODCg4HO4euurTaftI1ogZ4v0qC7/f
         B9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730192944; x=1730797744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybash4pv5nyVrAZaJt2dYgUqiEmKyR3rbX3Iwp7HQHM=;
        b=DCeiXIn3/GPzoQOX3UHEiYqcsuAXJZPGYgeItq/4FQImVzwWkkSqfYPvnEzQOlMGNz
         ydkJHqpZG/B1tCOo4zUlAsg4HqGO9rw0aUHJpUIc4VGDdmJN1yGjOQnXHP1OZv4rcod/
         sAb/cgyH7kPKPIKmOo6AY6HID18f/GtIRnBqMTG3Sh/snmC8IQ38M5Whuf91+z0UDeG/
         icTp+jM76WlhyWzKm6kQ3bAvZt7MhE89RkXKBHs+HJKu6PJcPee58J75jmybB+Xlc0Xl
         UqETPhAZr9OTAB/sXOE7Ayrhf0kDjCvZ2rqlW5DKA5X67OhqOjRPsWdNmcvsje2QqtIf
         k+1g==
X-Forwarded-Encrypted: i=1; AJvYcCUwRdiPmGdXTqkPt9YdZQDdiIMOo6Ze08q1EnI7hRvtzEPG9NlWKsG//Yi7iZZM9jpfbeqC5s0WJJabh14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrARrU+pm4qBQscYiqdcZpZji2LXN52OcdcosoXvnemzIGbnS
	ZkFhGK/EUAfcQc30fLUfHXzQrEBoJ8U1lFTz1p3aF9CERCxnVP+bQd6PccH8fOozFeFSj3vIT63
	lAoiKnXtJZk6BZgPGP2h7b+uoOGses+cm6J/bwbClPtlEjV4Jqg==
X-Google-Smtp-Source: AGHT+IGYeyyFOmhi43shzOqo9SvBKhlltr3fgWBBXUTNjlb8ExPC2NAWDNo7iiRGPVSUcdTWjzMUtyNrzJso9FcYum0=
X-Received: by 2002:adf:a450:0:b0:37d:4ebe:1644 with SMTP id
 ffacd0b85a97d-380611e34b4mr7318682f8f.43.1730192943863; Tue, 29 Oct 2024
 02:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410281414.c351044e-oliver.sang@intel.com> <CAH5fLggdtev=scJ1C9EefZf-fVrMvgMbfD+b_T5vFfHqNTn8Kw@mail.gmail.com>
 <CABCJKudR2UwvR8x4MwKYPmHETMz+aoiXEXz135BoufTF9Pt2Gg@mail.gmail.com>
 <CAH5fLghwEGCAxCR+OifGYh3jKK4jJqa-AX3gMUdN0HETBNBkYg@mail.gmail.com> <CABCJKufypN0c6EwiexQufjxMss-Y_fYdp+2XdpXU=4mmf2ZYgg@mail.gmail.com>
In-Reply-To: <CABCJKufypN0c6EwiexQufjxMss-Y_fYdp+2XdpXU=4mmf2ZYgg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 10:08:50 +0100
Message-ID: <CAH5fLggiMkB5g7=hxN-a+9M3vMxWdoB1QCyX9D3+-_oJ7duQ5Q@mail.gmail.com>
Subject: Re: [linus:master] [cfi] 8b8ca9c25f: CFI_failure_at_do_basic_setup
To: Sami Tolvanen <samitolvanen@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:23=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Mon, Oct 28, 2024 at 8:18=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Mon, Oct 28, 2024 at 4:15=E2=80=AFPM Sami Tolvanen <samitolvanen@goo=
gle.com> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 1:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > Hmm. This config has:
> > > >
> > > > CONFIG_CLANG_VERSION=3D190102
> > > >
> > > > Sami, is the fix not available as of llvm 19?
> > >
> > > Looks like llvmorg-19.1.2 doesn't have the fix, which means it won't
> > > be available until LLVM 20. :/
> >
> > It's not going to land in a patch release of llvm 19?
>
> It won't land to 19.x automatically, but I requested a backport:
> https://github.com/llvm/llvm-project/pull/113938

Thanks! Looks like it already landed. Which patch version will it land in?

Alice

