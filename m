Return-Path: <linux-kernel+bounces-170222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77FB8BD3B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C57E284C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7815746F;
	Mon,  6 May 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqINxCSe"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4015665A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015775; cv=none; b=ZhwSBip1DMDjHgDOJrLrzNOsCcsC/9O/07HGKIR9SJNtHr1U5Fh5IaAp6UKj2W7nUkR1T+2RtkjZaK66HIYpT+otCDRHjRxzXGlPnD5kGTiDX8H49Y+2Jna1FQi2RYscZtpJBEIbnMpZ5tb0b8cSqySLe4am6JR2ANidGlCYJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015775; c=relaxed/simple;
	bh=CH8+eM4S1n20YyEYWl0xkpP7fPFGyFDj7hZD+iuKZ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbMvNr6OtCaS3DqTXK/YiKMe33WuyHqJ/Wf9dT296zIm56keZ6CGSDQLlMBi+xjC9MLIwvQldQH+CPwp8GVFx5kf+a+x8lBHy60J5171hRXNycmecF6kjSeC/rfEAblUBK12zgJ+gcL6N6nlrJPobwv8xI2CAI/T7VoTR05s/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqINxCSe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61bb219737dso24473887b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715015773; x=1715620573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KofGXFo7s9xwEHva7ZrVmJtjldE1ogFbG7iHwKVRDOA=;
        b=ZqINxCSe80y6QXEPYUKNdUeFBBAdvKolrppp7RDI/OFz7VaTwxFuvKcdiPseCPpAEL
         uOJEb5pZpvqj7T9n5lDjxWoQO3M6sPzQYdbIIoUlkLVGPpo46gMiue8UGDU0fBwwUuWe
         Mz0hvF6eRPWmb9xlHs6VHAq9MptbPMWP+HqBiIuMisiZuxQO9IsW9ohQg4ryaf2Ej+Ja
         F/6xNWPtSnOIYvGC2hrWoVmYaNvAcTnmJ5n+afohHORfBPhK8u0hzyiSZwkaw2z/w5wr
         hXYA1vGhzjTkUEKL41hxulI3ralpUR0I7OwPD4B17Mpnab/N9HuCxPWrRJHVlvc0cBYS
         UjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715015773; x=1715620573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KofGXFo7s9xwEHva7ZrVmJtjldE1ogFbG7iHwKVRDOA=;
        b=qrlx/KvfYR1MtNOjQrqAJD9hjDfJuUNJLfmXkHp72F0POJd7VVeKXq5NkFbroZ4NYc
         TRa2Nho0McQQjQBt/4P148c6Gbp/Za7pOvuZcBEz/KPPFb0mnZe5gZLIa46meA47pER5
         GPmjWb2bOwqPJhmeetQYOY7Hbie+8VIoqN7xHnyPbfv2VoCsRW/BYGV4jg1Y6Uh9nVBu
         ZgWKObqCWcz1xIGBUtgyVszS9I6x1wSCWyRpMkF5z2ev0NeDQ1iW0mRTMiUdHziNKmm6
         tgZqG1xXerpR+EiRBDDx2F37luEIwgne21oac1v205qKT5PjuSfXWisZxhVnsij2hLyp
         D+YA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4tmqFenGIaViZxbDbdgCLfdxOLyJ1PNu2LDb+lXWFaAd0w2/CyIJ4SlVQlUOeOpUCuQTa0lcxwvbQU4WEIJ3FybdmCTGbgJsWCIL
X-Gm-Message-State: AOJu0Yz3QR5tuIWgNMyWtVfltQlh1dmAezoHp1entgxQHiicgcu21Vyb
	LxCKGP6NRZXYDGPMLvxmrD/LSaLH4kN4QQnpy78IY46/j3+elzaIDnxspMSl4lpfVJryQdgU+J1
	wZaIMQmwJyJQkPyALbpzLwuYJCNFJ2xSlNNYQ
X-Google-Smtp-Source: AGHT+IEzpiV/fRSpmds6fIDkQinopcpDSw1n1WY0/LX7bnm5aatstSpU5088BhxTIMAs0gqkQJ3SCI0XZ85AoTU9WjI=
X-Received: by 2002:a25:204:0:b0:de6:4ff:3155 with SMTP id 4-20020a250204000000b00de604ff3155mr11865643ybc.16.1715015772984;
 Mon, 06 May 2024 10:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501180622.1676340-1-edliaw@google.com> <osgrbhnqlyh5yw4y4x6wjggx56dogsgje5yy3mkpu75ubs3zwg@5tliydzky37k>
 <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
In-Reply-To: <b55272cb757743548c789aa8c0efa448@AcuMS.aculab.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 6 May 2024 10:16:00 -0700
Message-ID: <CAFhGd8rAW4Mkctq5VkcfVjw_yr=jVdXaWbYXP-vmeVpw7q4ruQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/vDSO: Explicit unsigned char conversion for elf_hash
To: David Laight <David.Laight@aculab.com>
Cc: Edward Liaw <edliaw@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kernel-team@android.com" <kernel-team@android.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 6:21=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Justin Stitt
> > Sent: 01 May 2024 20:55
> ...
> > > static unsigned long elf_hash(const unsigned char *name)
> ...
> > Is it possible to just change the types of the parameters of vdso_sym()
> > or does that trigger even more warnings on the callsites of vdso_sym()?
>
> Isn't the problem the definition of elf_hash()?
> A '\0' terminated string really ought to be 'char *' not 'unsigned char *=
'.

Right, although note this comment just about its definition:

/* Straight from the ELF specification. */
static unsigned long elf_hash(const unsigned char *name)
{

which indeed matches [1]

[1]: https://man.freebsd.org/cgi/man.cgi?query=3Delf_hash&sektion=3D3&aprop=
os=3D0&manpath=3DFreeBSD+7.1-RELEASE

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>

