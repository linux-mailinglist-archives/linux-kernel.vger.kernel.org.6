Return-Path: <linux-kernel+bounces-180423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB188C6E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29E41F23362
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C715B968;
	Wed, 15 May 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="2D0xzGf6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59415B578
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811624; cv=none; b=OVLnD4q9OKKiqC4pU4q0KS4s4I3a+f4r/ARaH1XI+DplD0V2Cv0Ow5q528UBg21Lyd+djs7xE2fEB3PFGV9TT/ztP+EGS0TTWzeWi8rRjZ81SLG88KSfr7u6FLtXNBJYiqfju+awO6OuZSNgN9YfhPNV6C0z2G9LSGtZz543O5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811624; c=relaxed/simple;
	bh=zHDyKDJHC6NugxP4s4BCf1sMZ+O+QoU46wnbbwkXAfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA7/kneHtW8Ez+ppHGDtCklbqmli+bgTfX/Z1Jq1TcSq3AMayebYbhgvj3wGAcMzSX198RzhCyqiYE/BNw6k+VDNg8DjuFBBqxm9kM8pvvpVUrs3GHr1ewAXdiKePbv9OZY4wTYvfdqE/cFLG0Psf5VvMdxlAPMfRysH1RIOONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2D0xzGf6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso46203a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715811621; x=1716416421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JjCgBiQoM5fCyA+EXfpGyLzGnNJOcvDx0VjNNMaI6A=;
        b=2D0xzGf6OMzXwyb+wVioCY2vBL97Y+1AuMvxaUkM8wmRva/aFUOTShy6ZYibxtRpS8
         8TKYt8dcK6TQWhDRLcBipBcEHGn6cmahZJl37qr+/9LsKiS5oe8tc6k8zUx2eyBvwwAw
         hvx4vN9dmkY3t1TbTK1HbJOCgwm1Ij1/tzRzEC5VEOy0sp92GS3eEjmO8eNcPnGyh0I3
         q5NhIWb7ICNQRRa64ZiyKwQWOoLlZ3+oNn7UsVOLqKHb68/XMIqFOCQBrpQ8oO3GAO2J
         nEc/2x9dM4tc8eryPZZqDwyXEXOXrNVGEN3Q1q0e0wgES+GTJv9PMqB3eyJ5oyMafnuI
         VEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715811621; x=1716416421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JjCgBiQoM5fCyA+EXfpGyLzGnNJOcvDx0VjNNMaI6A=;
        b=LJCunJn0PXAeT2+7zubHhfef/G+wtuEyD8agCSlHiC8NePmMHsYLkjaI6PtwRb2k5d
         mabrZXMmbOCUmduxjgPKMXszyjVjl3HLYaiEGcXbAV8vi6EVnN0+fK5EtzXT7KNEogan
         Aw42fJGzYb0rssT/C438ywwf2aP15VFgLEIQGVFL5QVVIA4eZUyD9arCnPpaMibb2KXB
         uzOBazkW8wx8jqoh+JN8GWq6sl81XCPVjjQLpWkYGgD+nYe4VF7q2IZKMyf5JiZOLp0q
         2mxicWcSkLBiV586DJLRCVchngc+6NOSIY7sC+Keiwu/Lwo4s47m3GS66YWTzTMYdig5
         Wscw==
X-Forwarded-Encrypted: i=1; AJvYcCU79zHNG1o6cIdTXnn/MwkivgY4TflN9jsTg/JXfLSFgUKe44ATaCfbuqdh3h9AllzsB9idl1898lHhSa4c5+Hvh/iAieS1rS2MEJpp
X-Gm-Message-State: AOJu0YwSJghPg+i5fju5DcNs1fDqfCpLZ9fdkDvHK9KPzZwRD7U7LVeg
	a9Hb9izjJ38idSmjYUkjJxgaBn2DrgZx34NsV0PvSwpIssFNwhTwudt/7i8Ipp4KSyNLr8OUB6d
	1X54NO5pM2mlETxhFpyTn2XaPBA/B4XSxKKVI
X-Google-Smtp-Source: AGHT+IGZ3GJvtzMop9dwqIvXre4rgfTZO15wpGDTxHvaHQ7WHetdGZHHg53H8t3pQXebBpag/n52DXaZ7drKVOiwJFA=
X-Received: by 2002:a50:c943:0:b0:573:4a04:619 with SMTP id
 4fb4d7f45d1cf-57443d30f6cmr899677a12.4.1715811618461; Wed, 15 May 2024
 15:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501122918.3831734-1-usama.anjum@collabora.com> <CAFP8O3JkgQsH-4Lmr2W_teuvLjOCPi1htr9r3CO1O0yLyw=Azg@mail.gmail.com>
In-Reply-To: <CAFP8O3JkgQsH-4Lmr2W_teuvLjOCPi1htr9r3CO1O0yLyw=Azg@mail.gmail.com>
From: Fangrui Song <maskray@google.com>
Date: Wed, 15 May 2024 15:20:04 -0700
Message-ID: <CAFP8O3LaEAuUtEERr_Loxazw1wDO1ufVL_-g+XoBsZgseT3QCQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests: x86: build suite with clang
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:26=E2=80=AFPM Fangrui Song <maskray@google.com> wr=
ote:
>
> On Wed, May 1, 2024 at 5:29=E2=80=AFAM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> >
> > This series fixes build errors found by clang to allow the x86 suite to
> > get built with the clang.
> >
> > Unfortunately, there is one bug [1] in the clang becuase of which
> > extended asm isn't handled correctly by it and build fails for
> > sysret_rip.c. Hence even after this series the build of this test would
> > fail with clang. Should we disable this test for now when clang is used
> > until the bug is fixed in clang? Not sure. Any opinions?
> >
> > [1] https://github.com/llvm/llvm-project/issues/53728
>
> I've closed https://github.com/llvm/llvm-project/issues/53728
> (constant expression folding for relocatable file output
> (MCObjectStreamer)).
>
> I've sent a patch to address https://github.com/llvm/llvm-project/issues/=
62520
> (constant expression folding for relocatable file output  when inline
> assembly is used).
>
> (I am subscribed to llvm@lists.linux.dev but rarely read it. I noticed
> this message accidentally :) )

On the LLVM/Clang side, I've landed
https://github.com/llvm/llvm-project/pull/91082 to make the following
if directive work for clang -c. clang -S still doesn't work
(https://discourse.llvm.org/t/rfc-clang-assembly-object-equivalence-for-fil=
es-with-inline-assembly/78841/4?u=3Dmaskray)
but people can probably live with that

```
% cat b.cc
asm(R"(
pushsection .text,"ax"
globl _start; _start: ret
if . -_start =3D=3D 1
  ret
endif
popsection
)");

% clang -c b.cc     # succeeded with this patch
% clang -S b.cc     # still failed
<inline asm>:4:5: error: expected absolute expression
    4 | .if . -_start =3D=3D 1
      |     ^
1 error generated.
```


> > Muhammad Usama Anjum (8):
> >   selftests: x86: Remove dependence of headers file
> >   selftests: x86: check_initial_reg_state: remove -no-pie while using
> >     -static
> >   selftests: x86: test_vsyscall: remove unused function
> >   selftests: x86: fsgsbase_restore: fix asm directive from =3Drm to =3D=
r
> >   selftests: x86: syscall_arg_fault_32: remove unused variable
> >   selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
> >   selftests: x86: fsgsbase: Remove unused function and variable
> >   selftests: x86: amx: Remove unused functions
> >
> >  tools/testing/selftests/x86/Makefile            |  9 +++++----
> >  tools/testing/selftests/x86/amx.c               | 16 ----------------
> >  tools/testing/selftests/x86/fsgsbase.c          |  6 ------
> >  tools/testing/selftests/x86/fsgsbase_restore.c  |  2 +-
> >  tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
> >  tools/testing/selftests/x86/test_FISTTP.c       |  8 ++++----
> >  tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
> >  7 files changed, 10 insertions(+), 37 deletions(-)
> >
> > --
> > 2.39.2
> >
> >

