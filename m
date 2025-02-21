Return-Path: <linux-kernel+bounces-525534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE8A3F0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92E97A9E27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B5D204C3A;
	Fri, 21 Feb 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEGfEXLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12312046A2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131246; cv=none; b=ge9P/AqJCzmQfRkPwRTvKBnAm4Nlx3x15Z9qhdMtwqMGcyn9tJZEKl44S0dElBuKw1AB0ae+t5JwnvSDSxr6DRXazcr4WYgbGuW7SuAQuoQjzqXIjY4JlsU22LBXgtmvBEzQ0fIORVtS4roTAmdWTFm9fuY1jEqYc78l/G1n3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131246; c=relaxed/simple;
	bh=rJNU3ob/aPwqNORKtLCnuHjcwh1c10jRgXG4TPfs2Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrpITjZRJi0HXZvtQOmUqV05T2RDyUMxWe493tJfr0CXqjtiMo9P1gBPYdfPTZJfROtIcJIudEV+Z74goHwzs6OnNBCBJ2hFB/nFlKlqPXxIgsFz1eVcjjXHx44UQKHmt3FqYagx+sj0QXQFOqyhHchHld0kbVr0GFd3mMRCZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEGfEXLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE4C4CEE8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740131246;
	bh=rJNU3ob/aPwqNORKtLCnuHjcwh1c10jRgXG4TPfs2Cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IEGfEXLRtsitu8Q4QtZnubD3ZMkWPuN5SRc/Vy3/VjJnD0MBiAYeRWSJLylELKH/L
	 hWi49QG81PPOpEWMbAgChBrAR7h7yi4Iaj0BsiHGtn/TRAtK+SBri8i+8JGfmeuGN2
	 ovsqYHbTxPc5ow0jCX7zFHVC7N1YigPBMXR7H2qgO7jLtYl1HBoIco66tla2/qj2s+
	 bhsGk2yLEHj69zDBa1VjPU2MNCH9V/xXOFCzw0YrnkuIZgwDfEuGJEbhqQ15oh0X6a
	 mS2NAg32ifdpjQwoikQmDt7eOOrd6SbmIu5TdWmBAQjDNCJnn7gSmGDGqMuh+wLwSr
	 47M6Oai0pA3rA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso2959735a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:47:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXi0MPIFRehmmQQh7EF0O5sleM30zvLf2eg1mycACXILWNa39pbSYbhS4qBwRyO2V7NpINh3zkQUNAUYok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQNLPvJuEIEVDfxUguoVytnyIBHpkvYLnJtisfMNZARll8Bu1
	zK5+L0yt1CiK21yEOhLOJC4nNbBK/70kHjgU7eNFkrO4MghRCDwoTOwOtJSSEjRNWFdBnFE6EJ9
	7zZBqXLWmB/RfKbc2GBXJHbwrzyA=
X-Google-Smtp-Source: AGHT+IGSJjdvJ0toZhyDL2EWJHkijnJYax5gDezORY24ehEmV5n0uHFbAzYdLClvsRv6D4vW2HBgGRZmDk7UzKDGvHM=
X-Received: by 2002:a17:907:97ce:b0:abb:b209:aba7 with SMTP id
 a640c23a62f3a-abc09abecf4mr231626766b.26.1740131244734; Fri, 21 Feb 2025
 01:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221092523.85632-1-xry111@xry111.site>
In-Reply-To: <20250221092523.85632-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 21 Feb 2025 17:47:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
X-Gm-Features: AWEUYZkA8NJ7SEds2EO_kG3_seA_MCw5AQY6HyivlKgtpLIyaHhDr8ouWVekGFc
Message-ID: <CAAhV-H5_bKtO2mAFmfcZvD0pn9RhTA+UPjv7K574uPKxZbxX=g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: vDSO: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Masahiro Yamada <masahiroy@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, "Jason A. Donenfeld" <Jason@zx2c4.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Fri, Feb 21, 2025 at 5:25=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> far before the first LoongArch CPU was taped.  Using
> --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
>
> In the past we really had an unaddressed issue: the vdso selftests did
> not know how to process .gnu.hash.  But it has been addressed by commit
> e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH") now.
>
> Just drop the option and rely on the linker default, which is likely
> "both" (AOSC) or "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch
> distros.
What about changing to "--hash-style=3Dboth" as most architectures do?

Huacai

>
> Similar to commit 6b7e26547fad ("x86/vdso: Emit a GNU hash") and commit
> 48f6430505c0 ("arm64/vdso: Remove --hash-style=3Dsysv").
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index fdde1bcd4e26..abaf87c58f9d 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -37,7 +37,7 @@ endif
>  # VDSO linker flags.
>  ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
>         $(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
> -       --hash-style=3Dsysv --build-id -T
> +       --build-id -T
>
>  #
>  # Shared build commands.
> --
> 2.48.1
>

