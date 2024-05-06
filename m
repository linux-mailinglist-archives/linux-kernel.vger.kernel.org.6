Return-Path: <linux-kernel+bounces-170505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF28BD82D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA3D1F23D33
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F2F15CD7D;
	Mon,  6 May 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcS/kx1/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398F8488
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038002; cv=none; b=lLrBIO+RnOd0bg9VzwtGUNl3f+WIAF4hgHZPr3qziBF9+0ACrTJNuw9m+LJUWurhgXdVWgmWxEBJArJujiZwscNDqVkc6+6VMp2QBR62Gi6pwSGE2ipaDEgJpNq0BlA5mWmpXgxYB4s6R9snqWMIcHG6ExmhjSGrm6qEA27+w7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038002; c=relaxed/simple;
	bh=cJ9hyxh3nF+1An19GSvXwAC4s8YrykB9K2WJtVoH5bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBK1NkA6S1y/VmTjZJW1WyMyrvqfv+wZBgsnU22k8wb706MDCPINsEVN/F+gTAuBFsnxO8cCJu4D7zR/irdfqkLEdvwj1JRcfcolWHNm9tAG/S4fCzMgrkb4AFRhMvtyxdkQzpU2Sd+/xX34ToDDEGiGdIlGLN6lUwV7cb5/MdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcS/kx1/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso2315a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715037999; x=1715642799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arg5k9e4eumU/21NxDFCZ0styz6cWNXoQ5vyGJusoQ8=;
        b=gcS/kx1/4uQwRmvAXj49bbVHKWMUge5aWVFibTGOeNb1lZdlQIyu8tH34Si5vmLP9V
         PVtycKXIf/+ED7wLGsSImwyXOKI5V6Yu8es1FPdPfE1gA5Tkv43mwQLoh93/5B1f9O6m
         Ozl6StrWFSKWpIzBj1EXI+Y4wmyD6e6IDPaK7BL9iQkQxi6bCkcOlD4AJCzhg/lzt1Y/
         L4K/RQNdGcSnpoOyP0hDlnbFLQQnlkXKwyGBNSnBdc8t1eVIL9iAq99BUW1HSFsi9WVj
         zSGCGgB2a/Z0/FE0g9FMq4hZxvh/tbg805un2GP85QJIIAScnmG9IcQkTSkjh40uPvWz
         O+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037999; x=1715642799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arg5k9e4eumU/21NxDFCZ0styz6cWNXoQ5vyGJusoQ8=;
        b=dk9eZfM3Q4g83YIBCZzfxg43cC/e3xTuAFAGyxFoLPk0CPnrXZXH9MstHwnUVoOiXT
         qFcuTDJS33DYRFJP9kZU2rDmWJsW+u/6zf7GM/CrNnY7qh+mgOAFhrChuxjQ/KXh1zDb
         7SSbcPXpqFyOAF0yey//j9bRzSpR8rVK0y5PXUOtXICpRzdKMAp/mG2di6gw6H3iRg92
         iYGpBaPL94bdK6pIaeua6qQu4iTj5P6q6I4xPsj5cb32VZYVsPJcmGY/Jh3TqZ3RcmBD
         gNmvbxQINVQEzpj71aN6bf1G2goOU/Ru5SlN3JdwXBO11eQ5a9K81xkQSTSL3aJHx+6G
         dtCg==
X-Forwarded-Encrypted: i=1; AJvYcCURJUoPn17C3aAE4zeSVdHEhcLpOw1ExsSDxxhyogf8L3bchAAjdUM6bwQbNU2bJ2xdFOvtCt6WbOaqj9jmmkNfWNlukugglfG7Y41a
X-Gm-Message-State: AOJu0YzXgQAR/jItsVW3/0EDXx3b1b4/BdeuI2LfpyjsXoi+eeqByww9
	ao6g9FJvYLcDMorzzs3dM9g/bZfQw0ZyW1eJ7AbrqefMzRMxyl6T3ZgvuG9xvGeYmLewCm1na7z
	sTZLxpRu/0L11I7AHr50djsDpBYghAt2ibTfN
X-Google-Smtp-Source: AGHT+IGJV7l8Y6VljzbpAT4oaU0i2MC2YKQ4WajhRPny/3d+aBTKQkE4NpCFTHY4NBSikNHOII7Lohs8MRKp9IuOFiI=
X-Received: by 2002:a05:6402:34ce:b0:573:1366:d196 with SMTP id
 4fb4d7f45d1cf-5731366d350mr39525a12.1.1715037999082; Mon, 06 May 2024
 16:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
From: Fangrui Song <maskray@google.com>
Date: Mon, 6 May 2024 16:26:25 -0700
Message-ID: <CAFP8O3JkgQsH-4Lmr2W_teuvLjOCPi1htr9r3CO1O0yLyw=Azg@mail.gmail.com>
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

On Wed, May 1, 2024 at 5:29=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> This series fixes build errors found by clang to allow the x86 suite to
> get built with the clang.
>
> Unfortunately, there is one bug [1] in the clang becuase of which
> extended asm isn't handled correctly by it and build fails for
> sysret_rip.c. Hence even after this series the build of this test would
> fail with clang. Should we disable this test for now when clang is used
> until the bug is fixed in clang? Not sure. Any opinions?
>
> [1] https://github.com/llvm/llvm-project/issues/53728

I've closed https://github.com/llvm/llvm-project/issues/53728
(constant expression folding for relocatable file output
(MCObjectStreamer)).

I've sent a patch to address https://github.com/llvm/llvm-project/issues/62=
520
(constant expression folding for relocatable file output  when inline
assembly is used).

(I am subscribed to llvm@lists.linux.dev but rarely read it. I noticed
this message accidentally :) )

> Muhammad Usama Anjum (8):
>   selftests: x86: Remove dependence of headers file
>   selftests: x86: check_initial_reg_state: remove -no-pie while using
>     -static
>   selftests: x86: test_vsyscall: remove unused function
>   selftests: x86: fsgsbase_restore: fix asm directive from =3Drm to =3Dr
>   selftests: x86: syscall_arg_fault_32: remove unused variable
>   selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
>   selftests: x86: fsgsbase: Remove unused function and variable
>   selftests: x86: amx: Remove unused functions
>
>  tools/testing/selftests/x86/Makefile            |  9 +++++----
>  tools/testing/selftests/x86/amx.c               | 16 ----------------
>  tools/testing/selftests/x86/fsgsbase.c          |  6 ------
>  tools/testing/selftests/x86/fsgsbase_restore.c  |  2 +-
>  tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
>  tools/testing/selftests/x86/test_FISTTP.c       |  8 ++++----
>  tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
>  7 files changed, 10 insertions(+), 37 deletions(-)
>
> --
> 2.39.2
>
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

