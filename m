Return-Path: <linux-kernel+bounces-187427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C58CD19E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DE81C21A57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B213BC3F;
	Thu, 23 May 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZVFQaf7E"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881913BC0D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465563; cv=none; b=Z7BOMCEfUKhmgUmnd2nsApClJHAObPBxUCF+rkoQllAvq6WmyY39D/8R/rbsPFRw5jZBfT9D03cJCiSSJsZRhVV0DqVafr333mqm/sG7PlMvZ3MT/buoacohRHpYa7zgOwrEjRyK4aRxHoAJOox/cy5qqlUvrbAv0EI2DplAHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465563; c=relaxed/simple;
	bh=nCYyWaFGLLT7ScHfTFWeiiMhfHnpnv3BAEhybJUG9A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSLD8S0hCrgAlQBwlJDRAiaH4mOXoN0GMPFg5/syD8j2Lij5FmOq2Oo8d9QyL79B7q97OvZvHhWFImoyTci00jirESCRo/RozK7kf6OgjmUsp4qOI//FHn4X4WtPRUBG7RWU0ECCPDtAHkcdVaT3uIt0YZshm5ZDsHalXWePtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ZVFQaf7E; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716465558;
	bh=MyKrkfyh6coOYh8JbTipr70bfsFYaSpyWOIp4W1neZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZVFQaf7E2zMMMzhb3+1ZMWVsQ8PClWLWieXPc49DYI1gbsc96gPXIaEoNgy1zBuiL
	 LpqUF+uV07ofe2G1PfOMosiD8+uu3otXR5JROLvcKgNDCUCez/ZAmozlbAyRoDJUGH
	 +OJLO7wpBv+gExkoaJd9O3KKVaCMw4AxSL7IjdAV45GbClx5m1CVfftaRkQtAlYrC6
	 szRqm6ZzRDmZKHFeC1L1HUEV6Z9vA4QzRTQM7csJ5jXXSdChkzOk+lDhOGjQOQ9N4C
	 4/F3hZ9TFP13C8VzsJEgdqLfCLLKFuwIjBqTJBJZww51pStCeiiuXEgUD/4P+eOjEL
	 qXV7J6NFZnJjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VlRY25NmDz4wcg;
	Thu, 23 May 2024 21:59:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>, Palmer Dabbelt
 <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
In-Reply-To: <CAK7LNASVhbtJ2=72TsCu1C7+uLsXySNffPcNZU2NiFKitM6-Ew@mail.gmail.com>
References: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
 <CAK7LNASVhbtJ2=72TsCu1C7+uLsXySNffPcNZU2NiFKitM6-Ew@mail.gmail.com>
Date: Thu, 23 May 2024 21:59:15 +1000
Message-ID: <87ed9s3fjg.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Thu, May 23, 2024 at 1:13=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.c=
om> wrote:
>>
>> The following changes since commit 4cece764965020c22cff7665b18a012006359=
095:
>>
>>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/ris=
cv-for-linus-6.10-mw1
>>
>> for you to fetch changes up to 92cce91949a497a8a4615f9ba5813b03f7a1f1d5:
>>
>>   riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800 (2024-05-13 14:26:34=
 -0700)
..
>>
>> Masahiro Yamada (2):
>>       riscv: merge two if-blocks for KBUILD_IMAGE
>>       export.h: remove include/asm-generic/export.h
>
>
> I am confused.
>
>
> This commit was applied two months ago by myself,
> and it already existed in the mainline.
>
>
> After this pull request, I do not see no such a commit
> applied by Palmer.

It is in there:

$ git log --pretty=3Dfuller -1 36d37f11f555812b0ded5d15aa686a6b9da57f61
commit 36d37f11f555812b0ded5d15aa686a6b9da57f61
Author:     Masahiro Yamada <masahiroy@kernel.org>
AuthorDate: Sat Mar 23 18:06:15 2024 +0900
Commit:     Palmer Dabbelt <palmer@rivosinc.com>
CommitDate: Wed Mar 27 07:14:19 2024 -0700

    export.h: remove include/asm-generic/export.h

    Commit 3a6dd5f614a1 ("riscv: remove unneeded #include
    <asm-generic/export.h>") removed the last use of
    include/asm-generic/export.h.

    This deprecated header can go away.

    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Link: https://lore.kernel.org/r/20240323090615.1244904-1-masahiroy@kern=
el.org
    Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Or via:

$ git log --oneline -2 92cce91949a497a8a4615f9ba5813b03f7a1f1d5 origin/mast=
er -- include/asm-generic/export.h
0316e4b04e01 export.h: remove include/asm-generic/export.h
36d37f11f555 export.h: remove include/asm-generic/export.h

cheers

