Return-Path: <linux-kernel+bounces-246848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F192C7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9ED28235D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9EB4A07;
	Wed, 10 Jul 2024 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUQWg7mT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0F8F45
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575043; cv=none; b=e/TTs9rWZIx+hvOLg1Xj1fEkIjmlSYyOqWeJI3ypooM3Ume7RMT4dPXINVjSB1zNVqDa/fNmX4P2Yu6NxbjsP47Rv96dUFhgWSa9hKth3mBRMV7T9YV0IvgkknBqf5oE0E+P5Uqn/Hg9rlkGy6/kg9zgAwKpZqzKzEVRP+Qplbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575043; c=relaxed/simple;
	bh=x8lbjp1PceBBHgHt/P9hnewqF+n+jC/8hR3PnA9sUm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrMOO0uz91vN/D7z6K4VLhxYyDi62xgwKLqApB2eKvSivMDFpHWkjLK95IlMx3DF+2Z9cg1wa0tz1sK3jl0i4DlP9yCgsXiTNHK67s3JQ7z7EJoolukEA6QXbjEE3XNzIvsryjw2YJhYrA/sAPIyz4RiblwotVRP5Pve9uNbgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUQWg7mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DDFC4AF0D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720575043;
	bh=x8lbjp1PceBBHgHt/P9hnewqF+n+jC/8hR3PnA9sUm0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUQWg7mTEV6OmRojL7nUg0OUek3kS9/ygMMWSVrYJ+km9k5ZW9KkP4CTg2VE7W44R
	 2BAcK3Wxca3N6OhUHET1M8XXEGFnpQNcR5y1LIOkHpCfiOK8somwtjQrljAkKfcIDT
	 Svyu8bb6fy/TXo80PovUSSvhPAA6ayqonJBGRB1eRSl+krtvIpbevTmpJPyVjLjDM3
	 1wlLVs4NUoA/H/nNe3bz7jtbQvcnWpAWjZuRAlLiI5S9h8jF7v0ANSBv/hiaHe40pz
	 VwZqxVbKbPWaFWuohqxIh/l75ucRjY4xVPvmxPw5nehhMnyzdodSpEjdNOjlAzOQ80
	 HO5sug59CxFpQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea0f18500so5453556e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 18:30:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMBVJvdHMiku/Ra4x6OPzFXS4VweB5JwTX6GS43fbNJF5JoxhhJYRoWMWWVjITaZHO+GSILOxmXl4YXxT+kp6lDfckNzgB1IjT4jny
X-Gm-Message-State: AOJu0YzQ3PZE8HmX8B7XqfytplbW9fYL/8i7vw2J0TELfdFnLll8++2X
	LEA6rHx9FAuGo+PvY4LM1WRSxgYF2UDW3QBrnR0AynGXQvBG7x6ufrIPL2y99FvWDN/InJELZlc
	6Qw+q7EEP/gK/7Da1QTYezL/Jtwo=
X-Google-Smtp-Source: AGHT+IG1sql72T4MYGYs5bbPBtwbR0BPqk0ELWMv6JVktc9ot3/sctTKgw2yg1t6XZqxEchSw0NJeHoB1P31cM21LRQ=
X-Received: by 2002:a05:6512:114d:b0:52e:9ba5:9853 with SMTP id
 2adb3069b0e04-52eb9994357mr2664442e87.24.1720575041326; Tue, 09 Jul 2024
 18:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060902.113294-1-alexghiti@rivosinc.com> <20240705060902.113294-2-alexghiti@rivosinc.com>
In-Reply-To: <20240705060902.113294-2-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 10 Jul 2024 09:30:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRJ2pPgqf0KSdk-q1w80vnVg6gPgRMw1NkQMPJJztr56A@mail.gmail.com>
Message-ID: <CAJF2gTRJ2pPgqf0KSdk-q1w80vnVg6gPgRMw1NkQMPJJztr56A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: vdso: Prevent gcc from inserting calls to memset()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Vladimir Isaev <vladimir.isaev@syntacore.com>, 
	Roman Artemev <roman.artemev@syntacore.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:10=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> gcc is smart enough to insert a call to memset() in
> riscv_vdso_get_cpus(), which generates a dynamic relocation.
>
> So prevent gcc from doing that by using the
> -fno-tree-loop-distribute-patterns option.
Good catch. I think we could put a comment on
"-fno-tree-loop-distribute-patterns". eg: Perform loop distribution of
patterns that can be code generated with calls to a library.

Others, LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index f7ef8ad9b550..c7e40bf36371 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -18,6 +18,7 @@ obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
>
>  ccflags-y :=3D -fno-stack-protector
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> +ccflags-y +=3D -fno-tree-loop-distribute-patterns
>
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o +=3D -fPIC -include $(c-gettimeofday-y)
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

