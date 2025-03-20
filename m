Return-Path: <linux-kernel+bounces-570025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB446A6AAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838B43AEEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911301EC01E;
	Thu, 20 Mar 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0FDLVe2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351961EB1A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487764; cv=none; b=MZaQ8cME5PnYhH/s4/kTtlHlEMLCukrS0AlBcHXcuhvj8Hy0ooCTM3kkU5VzOWc0IJGx+CLJm+id1dBYzJtenHaEbfiK2AfzZxU0IKG0k7yMNuyako/cHU3K5FbitiVxzh6YeTSkc1MSkNiamCvPwey/bcSS18125IDEyiCfl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487764; c=relaxed/simple;
	bh=iBaYrEdxYbwgrtWQPqWaUAtAAyEa/2e7Lr2RG+9BI2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTDy0K6ELfwSK//WepigQ+bsUb/T/NpzRBPKoancxzfmKyA+vXbcWfqn942hGfQAYBTnFrXojmOXH6crdEdyUL0dcMeVI9WnN5JSDT8v7VuIjEoh0T0AEUEmOpxPmzF8w3W76TJ3xybcFXo5t1ZHYGrxMAfOv4ZTGRSQV/3xa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0FDLVe2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso12974a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742487760; x=1743092560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BDyvyLAKvIZ15OGT0Q/ivG26i1ivialqYq2eEg0yYc=;
        b=x0FDLVe2ltU9/2wcf8pgfjW8A1EQpNujm4IMSNESdG8Z+i24/AUMeHUwUXo5igc2nj
         y5uXczolrLfytcV+UXBdprR5nERA6RpjZZY4aTr4I9GhHFWae3uV1GZ4r8YPpuLpaLvv
         c1yz+UowRN1iu4OYmgXPND5uuhhhN+yX6h9LtH8YE0uZClym3IaJot18tU+BNXdPsuP+
         q1uJPIjLcxkhogGAUYrpeNxj8bXOPygnINZ6JISOTpPkEyvHsphoPyW3YtNjBD1kAQla
         IwJFNlaNvRHlCMf8nAK8uqFJjQBso293eQgBxxqlZ63cngHruYstBF89A5nf4y6eSLtc
         28CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487760; x=1743092560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BDyvyLAKvIZ15OGT0Q/ivG26i1ivialqYq2eEg0yYc=;
        b=CIHvHXE/QgvLhZyixCE1mydTXi6etbaD80I6UBW2kfAc6g7O7XKUEXMBscZ4CyZXdn
         nX4qDg73WKVRx/BCUS3G/Qe13oFO3vwcA8rg65dMMPiUqBU1gW2f7xRMXH3drqva625s
         2i6knofYzCqs8lLJ+8XtJLypJ/ThBFwsISa/van9/hhSyiM/19q0u3SoOLs5QzMaeVZB
         PEUq5l9r1LENjc3FwGQUVUO2sFiJ4WyDuZ4RfPEPQ2FHFKG9hdqxWPbmf9U2mZldiZvv
         wGyq+mJLeC6tCmijMN9+gSxPytOMjjJnjp3tLg7qcHA903dYfQQynyJn9oL0jdWdiNN7
         wKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC+DjSvlmGCdowSoLt7R0mcx8KqktMwx+wTgmN/YEuhzCDdlH/GH1zF3NBt01YpA6ovscLEvni3JmE0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfqOJ6z20z5nFaVKLtVXS6mjvh3YzHPg8xa8MjQSo3OQimsPQ
	zeKjAzU3w202cnGUrex4GvgZxFKuK3lEISZnd6puoBW8NNLjJYNAbYU185SHer5ZGPXFaLngEvw
	+WwSy+zlhfFYZPFd7ijosZ4/00BTOSc/zNIQh
X-Gm-Gg: ASbGncsYocLpsyNu+Juak05Oi4NtM4otPcFerl0ZxFxEpxFeF5jWZ/dXbePXyaYS12x
	+HhOHx3bw1+DzxgBlZCEZxryRst52YIJVbs+2Xoo92UJyxS28PShRbbYriQpbLDSTZN1dmoe+oR
	AXl92n82OT1YJsA7ZT3o0CGBo=
X-Google-Smtp-Source: AGHT+IFpFBTDamZKIcGbe7VxKrGvHYZqw8Fe/GUpRMNYQ0c3sJ45Y9wp9LjHfSnBLtyqeVFzM46xQ/CwyLk98V3T8Xk=
X-Received: by 2002:aa7:c60c:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ebb577b697mr103587a12.7.1742487760036; Thu, 20 Mar 2025
 09:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320070746.101552-2-ardb+git@google.com> <CABCJKuc3zZOG4qgoFca_g80GMkzviVRemGLJB8GaA88u27Mt8A@mail.gmail.com>
 <CAMj1kXFZFgYp40xD72s0oMThgxK7J-yyCYUQkkBQjh3xR+fNeQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFZFgYp40xD72s0oMThgxK7J-yyCYUQkkBQjh3xR+fNeQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 20 Mar 2025 09:22:02 -0700
X-Gm-Features: AQ5f1Jp7FiFR1QRjVB3v5G-LDWHzZlwlrm9-TE5zzogir7SBr-YQDMk289Fbkh8
Message-ID: <CABCJKueFujwW_=JMZHTf+Y3qN9=uvQYSoDcg_6v=9svUYTsMGQ@mail.gmail.com>
Subject: Re: [PATCH] gendwarfksyms: define __GENKSYMS__ when processing asm-protoypes.h
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kbuild@vger.kernel.org, brgerst@gmail.com, 
	x86@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	linux-kernel@vger.kernel.org, nogikh@google.com, 
	syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:09=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Thu, 20 Mar 2025 at 15:48, Sami Tolvanen <samitolvanen@google.com> wro=
te:
> >
> > Hi Ard,
> >
> > On Thu, Mar 20, 2025 at 12:07=E2=80=AFAM Ard Biesheuvel <ardb+git@googl=
e.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Ensure that __GENKSYMS__ is #define'd when passing asm/asm-prototypes=
.h
> > > through the compiler to capture the exported symbols. This ensures th=
at
> > > exported symbols such as __ref_stack_chk_guard on x86, which is decla=
red
> > > conditionally, is visible to the tool.
> > >
> > > Otherwise, an error such as the below may be raised, breaking the bui=
ld
> > > when CONFIG_GENDWARFKSYMS=3Dy
> > >
> > >   <stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_=
guard'
> > >
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Reported-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  scripts/Makefile.build | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 993708d11874..7855cdc4e763 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -305,6 +305,7 @@ $(obj)/%.rs: $(obj)/%.rs.S FORCE
> > >  getasmexports =3D                                                   =
             \
> > >     { echo "\#include <linux/kernel.h>" ;                            =
   \
> > >       echo "\#include <linux/string.h>" ;                            =
   \
> > > +     echo "\#define  __GENKSYMS__" ;                                =
   \
> > >       echo "\#include <asm/asm-prototypes.h>" ;                      =
   \
> > >       $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
> >
> > This works with gendwarfksyms since __GENKSYMS__ is defined after the
> > EXPORT_SYMBOL() definition, but I'm now getting warnings with
> > genksyms:
> >
> >   AS      arch/x86/lib/clear_page_64.o
> > <stdin>:3:10: warning: "__GENKSYMS__" redefined
> > <command-line>: note: this is the location of the previous definition
> >
>
> Oops.
>
> Do you think the fix below should be sufficient?
>
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -314,7 +314,7 @@
>  else
>  cmd_gensymtypes_S =3D                                                   =
 \
>         $(getasmexports) |                                              \
> -       $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
> +       $(CPP) $(c_flags) -xc - | $(genksyms)
>  endif # CONFIG_GENDWARFKSYMS
>
>  quiet_cmd_cpp_s_S =3D CPP $(quiet_modtag) $@

EXPORT_SYMBOL() has a different definition when __GENKSYMS__ is
defined, so I think with genksyms we actually do need this on the
command line. I suppose you could wrap the getasmexports definition in
#ifndef __GENKSYMS__ to avoid the warning, or just use
__GENDWARFKSYMS__ like you suggested earlier.

Sami

