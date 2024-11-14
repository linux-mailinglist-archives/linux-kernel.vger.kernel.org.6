Return-Path: <linux-kernel+bounces-409725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72529C9090
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE6C2830F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B66188735;
	Thu, 14 Nov 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX2DdKZl"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBA433D2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604402; cv=none; b=ZipBsWbympnpIIOe6lWJ3ibDzEJugqcao/0DbA/3gJp+BF72PqAaghIhpF80zTfRhuLWp0em4O2Uxr8jQS5UID5vK5gwYzwSqwCIPhipkvkXl1bKrcIzM6Lf4Us1f4gLrs9zlaJCHA7YsyvyTexZVzVza8/A12Za/KODLlkGzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604402; c=relaxed/simple;
	bh=A80VzsnOEipCxkUh97wzvMqS3FP+WLn0ePpQ1WrySQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKsbxK9JQFRTMgnIVmQkS0VV2f8gPIL35vFlPvqbx0OZzeJdL8tpiXPaSJR7yriTIvS6Vubb5E6o/HW9HPMY58sj3BBHOQz9VP6P43kiJZlOaUG2xsCZjlLC8CykOlE6ki02GcYu/OZXkbewzNzNfb65QNWj0tkgmG3sj9vch6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX2DdKZl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c693b68f5so10131055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731604399; x=1732209199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2r2gffF9fCgNgH81FqMLKgByrEvtAcE8L5uD28+7jI=;
        b=qX2DdKZlzYwNaXoPAbk1LsDDMB2lpfN4G5jPeCf6vpuXFWqYqvk/bn7yAfnwJk2s/8
         b0+yACgDUl7plZea2AJ16i19zAEOktnvBN9k4Q2vrpIIfeFAqoQZul0zftxGNb0hDvI0
         OSynRpQdb0kdGR/L6ymPKOI/dKxz4dLhEaiKxGbj7eVieS9GOiZOL2BIm3runT8Is8/K
         46mcIOysvdqw6htxox080Xvm80370HbFVKoqbbAv4onkW+F00I2fivzkS0nC8UUHQYqY
         c4W87PU1MvRsf/QFyU+PrwWV8RqDaOJMJ3EMro9YnR+kibwUOL9GIVz2oOLgYt/bB/py
         iOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604399; x=1732209199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2r2gffF9fCgNgH81FqMLKgByrEvtAcE8L5uD28+7jI=;
        b=llQlSYjQ11jLiFiwbygzWMgP4v80hfRbyvfmG12KpQrdUKyJu+dDsK6YG3kiLuCmKc
         UzfII7VMY1Rt08SaTvUkURKQ0bjuyk7AIIKzHsTduo24lT7uFJ+iQPplfmdZwG6yIG4D
         2ZE/SJP7F0YPrp6r0oHldgGFpNLe382qcPl+3ZX9p0TlgkWJsr7uZricLZy5waCeq1Y3
         8UEv9vu5ExQv1jVCUnlaZaum09I5Z5p5eBzQtl8tjskTCGfGWBPmv1YmOxwGJmcpnwaN
         EJbIaN391TxscngwMLYgqTSSvPpEoq28pBaG5V787DOlt/YO+E0DXjqtkLlFxcfIyHO3
         YWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSvN+qkUfjLAYHjOUUL2GkClXeld5Horx5TVnA4p2KX4B6DLxIc0LwpV/mQGyBLRq4I/CCAfSGe/5K0GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypnTRNXZ7fdYmUla6q/qaCk3MkkyywFwJpn3I2PjSx92kk7I3T
	XrrRh5ZyfGgzq2Z8oleRTLNWZeaEUN/4F0uuhsK5qC1VkRyx6tI43C2dih/i8tHv8q0lzS2vmOT
	QAywOsjYjxGIEkYUXFtx9vZyP7ls5Wy9dsiC8
X-Google-Smtp-Source: AGHT+IGXLLQ599KLZBit3Ubp5UM43jPzJZqyV/9Pu9rr5uQzEA3J6VZvB/vvL8YEOtbhRsirwS8okjixKMtL1ARDbp8=
X-Received: by 2002:a17:902:ea02:b0:20b:ab4b:5432 with SMTP id
 d9443c01a7336-211b5bcc3b0mr111508655ad.12.1731604398795; Thu, 14 Nov 2024
 09:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn> <20241105141530.GE10375@noisy.programming.kicks-ass.net>
 <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn> <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
 <7e8adb0b-e681-72ae-40d8-740dc3f9480b@loongson.cn> <20241113211119.lfwlxv2bjyqfqeh2@jpoimboe>
In-Reply-To: <20241113211119.lfwlxv2bjyqfqeh2@jpoimboe>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 14 Nov 2024 09:13:06 -0800
Message-ID: <CAKwvOdmE7zZN2x9echrje7dqunda=SywqurkyXyJaaUp3M0aEg@mail.gmail.com>
Subject: Re: annotating jump tables (Re: [PATCH v2 5/5] LoongArch: Enable jump
 table with GCC for objtool)
To: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Xi Ruoyao <xry111@xry111.site>, 
	Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org, 
	Jan Beulich <jbeulich@suse.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:11=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Tue, Nov 12, 2024 at 08:26:56PM +0800, Tiezhu Yang wrote:
> > On 11/12/2024 11:15 AM, Xi Ruoyao wrote:
> > > On Wed, 2024-11-06 at 13:03 +0800, Tiezhu Yang wrote:
> > > > On 11/05/2024 10:15 PM, Peter Zijlstra wrote:
> > > > > On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
> > > > > > For now, it is time to remove the compiler option -fno-jump-tab=
les
> > > > > > to enable jump table for objtool if the compiler is GCC and it =
has
> > > > > > the compiler option -mannotate-tablejump, otherwise still keep =
the
> > > > > > compiler option -fno-jump-tables to maintain compatibility with=
 the
> > > > > > older compilers.
> >
> > ...
> >
> > > > ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> > > > KBUILD_CFLAGS                   +=3D $(call cc-option,-mannotate-ta=
blejump)
> > > > else
> > > > KBUILD_CFLAGS                   +=3D -fno-jump-tables
> > > > endif
> > >
> > > Has -mannotate-tablejump been added to Clang?
> >
> > Yes.
> >
> > > IMO it's better to add it
> > > to Clang first, and add Clang & GCC support at once into objtool.
> >
> > Looks reasonable, the fact is that there are some corner issues
> > compiled with Clang due to different compiler behaviors, most of
> > the issues have been addressed and I need to do more test, I will
> > send v3 with about 10 patches after the coming merge window.
>
> Hm, I didn't know -mannotate-tablejump existed.  We really need
> something which supports all arches, not just loongarch.
>
> Others were looking at adding something similar (adding them to Cc).

Looks like this was added to clang in:
https://github.com/llvm/llvm-project/pull/102411

A comment in llvm/lib/Target/LoongArch/LoongArchAsmPrinter.cpp
describes the scheme:
+  // Emit an additional section to store the correlation info as pairs of
+  // addresses, each pair contains the address of a jump instruction (jr) =
and
+  // the address of the jump table.

Ard had a prototype in:
https://github.com/llvm/llvm-project/pull/112606
which used relocations rather than a discardable section.
--=20
Thanks,
~Nick Desaulniers

