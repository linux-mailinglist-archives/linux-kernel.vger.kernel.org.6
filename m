Return-Path: <linux-kernel+bounces-188325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2A8CE086
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F20D28280A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19B524AE;
	Fri, 24 May 2024 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHdzqMoi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD542ABE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716527251; cv=none; b=MVlKETcCy/9oEmdPVGJv4Dca3MSIFWx0ZtgyF9Ii06xgUPs+jvEIa5h+rSvFAZtA4h4+mWJWHKZ8CApLFvYG9g8JmyPa8KeipQow0gU6o2AHtOV1d8frPkNK0i0LWqM6ctkXvNTIoSGbpRrXCb3BkJ7ueae1TrHSJP9F9KPBrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716527251; c=relaxed/simple;
	bh=GK/V1QQD57TCm3aTnWvaZuyMKv97lo7ihqyFiCTHVH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKocHcQ7F3Y0Lv+x9Fgn25F+sqA74jyRTnnPmNvDsuL21IzU7F2pshx47rNq375u7wNlFFFiiPen/yifwsxJ3BGwE/XnAUISBWBp2WhCT+L02mXr4RBqie3fcKxBvpM7nu9ik4P/j5IkGBD/cramRqO6aqcxTOgLNvrxihSdg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHdzqMoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85CAC32789
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716527250;
	bh=GK/V1QQD57TCm3aTnWvaZuyMKv97lo7ihqyFiCTHVH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gHdzqMoiSBchjJmRSkLxFuJtEiotCsSp2EIXu9kE5gAoC+S6+4Go6/E3h98uTVSTM
	 R88wlrSL1ztQE+JuAjTVYxkTGLcGs9U4q4a4+3h0C5MOgTkSEsdxzo8u5/AE/Ikb4T
	 KTJO+tmLc/ZI7rtbNBoAJUZ1c4UW8enqYyO6xGb6Xd5o0AEcyPHuOGS8aWK8wlkzpF
	 LMBZNCHEyYgW1ux1w2s2VhPOHXVLPvq0D8iHpEIBnZeAz5TeM3RYaYHhixnC0RCwWG
	 IhLWzsgvHYKRRxnrs7iHuiNi5RGlsYuHrNbVE+2w2PG9CPYr6ZGTeuDFeJFSLkif09
	 SgSy32yLEumig==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso6692501fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:07:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8y0Dooe00hSWitjZVSxnDnjMB2pkxsSQQ142/9I5jmi5Fi1+OUwjxQ81OrFueG8LS79huVAQZsp5+AkAUSXFMOYFW6kE+TAfnSIJr
X-Gm-Message-State: AOJu0YyUXzSqBIJ1Bbv1Y7bsS1T1poBNJSHG1QQ556tJ/5epk+2GgB0k
	oJc+Erx3/ZFEs2ilSbnayOwfEvZwmv7obh/CYimQn6BNCy+uoJeC4CCnB8qjOXI1W8AaHX0H0RH
	lL61rnJws2A3JfBzp43H7aipfMAs=
X-Google-Smtp-Source: AGHT+IF5borjWS+EoVCFZTJVzvu0BFneN5NQLU0c+j27aNCmdIZ7uUmDcRXXzgAMVGog9KLMwYcDyxgy90AjZfUKuWQ=
X-Received: by 2002:a19:910a:0:b0:51f:2a80:a982 with SMTP id
 2adb3069b0e04-5296736bb70mr619521e87.47.1716527249327; Thu, 23 May 2024
 22:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
 <CAK7LNASVhbtJ2=72TsCu1C7+uLsXySNffPcNZU2NiFKitM6-Ew@mail.gmail.com> <87ed9s3fjg.fsf@mail.lhotse>
In-Reply-To: <87ed9s3fjg.fsf@mail.lhotse>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 24 May 2024 14:06:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbHVR2r1YdWCiTg+Tp29uJZyZv2nghFsrUoKszFP-UdQ@mail.gmail.com>
Message-ID: <CAK7LNAQbHVR2r1YdWCiTg+Tp29uJZyZv2nghFsrUoKszFP-UdQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:59=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
> > On Thu, May 23, 2024 at 1:13=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc=
com> wrote:
> >>
> >> The following changes since commit 4cece764965020c22cff7665b18a0120063=
59095:
> >>
> >>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/r=
iscv-for-linus-6.10-mw1
> >>
> >> for you to fetch changes up to 92cce91949a497a8a4615f9ba5813b03f7a1f1d=
5:
> >>
> >>   riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800 (2024-05-13 14:26:=
34 -0700)
> ..
> >>
> >> Masahiro Yamada (2):
> >>       riscv: merge two if-blocks for KBUILD_IMAGE
> >>       export.h: remove include/asm-generic/export.h
> >
> >
> > I am confused.
> >
> >
> > This commit was applied two months ago by myself,
> > and it already existed in the mainline.
> >
> >
> > After this pull request, I do not see no such a commit
> > applied by Palmer.
>
> It is in there:
>
> $ git log --pretty=3Dfuller -1 36d37f11f555812b0ded5d15aa686a6b9da57f61
> commit 36d37f11f555812b0ded5d15aa686a6b9da57f61
> Author:     Masahiro Yamada <masahiroy@kernel.org>
> AuthorDate: Sat Mar 23 18:06:15 2024 +0900
> Commit:     Palmer Dabbelt <palmer@rivosinc.com>
> CommitDate: Wed Mar 27 07:14:19 2024 -0700
>
>     export.h: remove include/asm-generic/export.h
>
>     Commit 3a6dd5f614a1 ("riscv: remove unneeded #include
>     <asm-generic/export.h>") removed the last use of
>     include/asm-generic/export.h.
>
>     This deprecated header can go away.
>
>     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>     Link: https://lore.kernel.org/r/20240323090615.1244904-1-masahiroy@ke=
rnel.org
>     Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> Or via:
>
> $ git log --oneline -2 92cce91949a497a8a4615f9ba5813b03f7a1f1d5 origin/ma=
ster -- include/asm-generic/export.h
> 0316e4b04e01 export.h: remove include/asm-generic/export.h
> 36d37f11f555 export.h: remove include/asm-generic/export.h
>
> cheers
>



OK, thanks.
I think I was misunderstanding the effect of "git log -- <path>"


When "-- include/asm-generic" is passed, 36d37f11f555 is hidden.


$ git log --oneline --author=3DMasahiro | grep include/asm-generic/export.h
0316e4b04e01 export.h: remove include/asm-generic/export.h
36d37f11f555 export.h: remove include/asm-generic/export.h


$ git log --oneline --author=3DMasahiro -- include/asm-generic/ | grep
include/asm-generic/export.h
0316e4b04e01 export.h: remove include/asm-generic/export.h



"man git-log" explains why:


<path>...
  Show only commits that are enough to explain how the files that match the
  specified paths came to be. See History Simplification below for details
  and other simplification modes.



--=20
Best Regards
Masahiro Yamada

