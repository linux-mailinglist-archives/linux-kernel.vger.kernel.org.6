Return-Path: <linux-kernel+bounces-317393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B696DD86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B59B26361
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC53F507;
	Thu,  5 Sep 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSMza4IT"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E64C634
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548963; cv=none; b=dVQ5WU/R6Ua61/8rolpZIjpSwOKWPCemZHrBO3nQ44js1N3WTZzS7iAFqho1YDGWFkh7hWCbiiNlkUqPr8gPDHFyJi/tNfd9oItouDygaLL8yTWKmphiT+pihup5BiQY1xwJeERyrtARIbtTcDheOMERaTLxendZ07pWug+00+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548963; c=relaxed/simple;
	bh=5At7AS88ojaHEpLfzwd+uuP1TygxmDDvrhAPPWk3d04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvYsMj8pQ/JPjTvw62AtxfLg0B0oWg2o0480PqUoiQLXZXubREUG9wmziawkwSLI19mDw9OMDeNTw5h3apHmpcao2FgM9dNxSXKvBnnSaqH8y+dE2yj3iJYoIO+RIjaFFOtE88xKV5XY8W9YxMFZtUFaETA5cXrDVF9teefo3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSMza4IT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3fea6a0a9so8684101fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725548960; x=1726153760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0ecEHBuF4G0+dFN0O/ngX7lW/i8zn8XsUfg91/PKxw=;
        b=WSMza4ITeU2gUJni1rH5hB94GgFb07UPjUA1e2Qw3kxcEWP+rV2oF/ejw9tFwNqfyJ
         Z8eWmKTyYkNvF9XUINmI9/8vmWYDJaFylvtwk11N8D/hyTGNV7st5DJAw0jblp2QKMfu
         PpK+/wKZ+DeBWVjwSstPL8G8LnQFEiONtCkXaTDOeIuN0H1sNH/CVRmP2dW2684H7RF8
         Btcxdmr4F4SmrMZ+xS6z7jW9DNb1ty8PenJK8okG+/8ZklnCMBUlm2QqY80vOU/QJ3ks
         tJKPWVvn7RBl65+JmVHDuoSnm/hAo4rM2YHLnwboz4Q6cy/yGLrSm+L1+16BbZShF8M4
         8Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548960; x=1726153760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0ecEHBuF4G0+dFN0O/ngX7lW/i8zn8XsUfg91/PKxw=;
        b=LoLUmgW9yaks1CV6UwCZ4UDGbOh6bObGGFK81oRKDLOkAN0Dn05AfGRRc028BxMxZV
         Rhn8aatAKB9tuFexLLf1Iea3AtThHTaU4+Xs1XRz1BPXqNW1IZGkEMfiMipQt9nkI0F+
         aIeeRg53AzKv15cA9/k+QmxAZo+5YyiKtNsJWUzzVO9/1rM8CWSn5h6Hhc8Qi8j+GOjq
         w3Q5nqpSrarWwF+tDKgoMPCeov/cA1BEcuyRyKqH9kvIrIfQrCyhJjDfs8WIJfMPfA/h
         ZDmpQU9bU8mBDBiNAEoNIrZIBrOrUn1nvup48BclrJjMSNmyqr7aZMSfdYllxQhnMaWQ
         X/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUWdZD8A9HJU41oM0qClbclRyqGoSxjWyJ9ORs+lgoZEtQ1hD/VNAUXBMcO4XKSW82ym98NXbsDXR+6MSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCzCFblo231eXkvI1rIYsTDG+F0anCwXw5wdOTqjNIqVS4Xua
	8acViv5lVxt4sYUmuaErnRM2PKnC4tyCWaNViXRxiaKK8nYu8PqBazEsHkjBh/EYf67WRwRc7dk
	BT2bJspdaJGDwrgieyzdyz6Cmfgo=
X-Google-Smtp-Source: AGHT+IESnECagBvZ42e0ZM60QicgffuZ7u2D+POegNCSLP0LNOf1FGPir6Ly6gtTXxMVUNhrP+TjXqIPSIDnhR0O9ug=
X-Received: by 2002:a2e:f09:0:b0:2f2:b5c6:ccca with SMTP id
 38308e7fff4ca-2f657d49ecfmr15631471fa.14.1725548959149; Thu, 05 Sep 2024
 08:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
 <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
 <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com>
 <CAFULd4b9pV2Rpb+X8gTsDdePtcAppmh7jDVcXBQsk39sicRbhw@mail.gmail.com> <CAAhV-H5eLXcAQ_GpEcO7rPZ2iJ7gqRxhXvGg=__p6+XcRK-gCQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5eLXcAQ_GpEcO7rPZ2iJ7gqRxhXvGg=__p6+XcRK-gCQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 17:09:07 +0200
Message-ID: <CAFULd4bSHM9j11N8b3+V8N-pQTconan53THeme4p3UR3COCTLQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:04=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> On Thu, Sep 5, 2024 at 8:46=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> > >
> > > On Thu, Sep 5, 2024 at 2:09=E2=80=AFPM Xi Ruoyao <xry111@xry111.site>=
 wrote:
> > > >
> > > > On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > > > > > If the input value is less than 0xff, then "& 0xff" is meaningl=
ess, if
> > > > > > the input value is more than 0xff, this conversion still cannot=
 give a
> > > > > > correct result for the caller. So I think for all sizes it is e=
nough
> > > > > > to just use "((unsigned long) val)".
> > > > >
> > > > > This part is used to force unsigned extension, otherwise the comp=
iler
> > > > > will use sign-extension of the possibly signed variable.
> > > >
> > > > It's not relevant.  For example when size is 2 __pcpu_op_##size("st=
x")
> > > > is expanded to stx.h, and stx.h only stores the lower 16 bits of a
> > > > register into MEM[r21 + ptr], the high bits are ignored anyway.
> > > >
> > > > Thus we can just have
> > > >
> > > > +#define _percpu_write(size, _pcp, _val)                           =
             \
> > > > +do {                                                              =
     \
> > > > +       if (0) {                                                   =
     \
> > > > +               typeof(_pcp) pto_tmp__;                            =
     \
> > > > +               pto_tmp__ =3D (_val);                              =
       \
> > > > +               (void)pto_tmp__;                                   =
     \
> > > > +       }                                                          =
     \
> > > > +       __asm__ __volatile__(                                      =
     \
> > > > +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \n"=
     \
> > > > +               :                                                  =
     \
> > > > +               : [val] "r"(_val), [ptr] "r"(&(_pcp))           \
> > > > +               : "memory");                                       =
     \
> > > > +} while (0)
> > >
> > > Nice, the less code, the better. If it works for loongson target, the=
n
> > > we don't need this paranoia.
> > >
> > > I just played safe and took the approach that x86 took.
> >
> > Please note that the original code extended the value to a long type.
> > If the simplified macro works, then the usage of macros will result in
> > a better assembly code, where zero-extends will be omitted.
> OK, please send a simplified V4, remember to remove the if(0)
> checking, which is the same as V2, thanks.

Are you sure we want to remove type checking on _val ? I'd rather
leave the if(0) part, but remove forcing zero-extension.

Uros.

