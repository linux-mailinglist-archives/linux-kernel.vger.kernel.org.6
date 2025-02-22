Return-Path: <linux-kernel+bounces-527242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A2A408CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B5617F8EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579178F39;
	Sat, 22 Feb 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV2z9tFS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B345383
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232041; cv=none; b=bUhHHLca5Kq3jWeK4yLv/QXgH4vQXRgE19+eAETYl44Je4nV4XLNcYaUM5BK4R+tK86m+8FrwGlNyhiWB7yjMe2c4l6DzIH9/7Onsw5f/eWzUOlN5NfWJCjneo17esmUtGF2KuGLdZBVl8JvJZjTICE3AOHAURSvI7dBFuLUC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232041; c=relaxed/simple;
	bh=URQQNTWp9kN/3dcwyakm6DK5xOxP0YcnOg7S3kdCazI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APQ06Kq49aaxVbrPiTpb2y22aMM8WSzlQkAt4grt3I1tyZizFoBhCihNjbkornbjtFadwv9Okv7t15i+9Wyx29cx12m2RlzrC07348vje4VF3j5a3RbXdrmx9xPPwiLfj0WkqQsqk1BSw01xnn2rzzW4ShwMLiqkBBNC6gNqQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV2z9tFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEEC4CED1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740232041;
	bh=URQQNTWp9kN/3dcwyakm6DK5xOxP0YcnOg7S3kdCazI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AV2z9tFS8c0RMWNNQxuceg1LNVvZvjJYrdbC6xKMdGj66VoQ8VZaYP6JRcjIzvz1X
	 EDeMGqNxZaM+Y1Sv1yjaV4ERxn/pKOHFcDyvUgZVr9zEtUK47TQzMOr+WZClzEAmiu
	 g1YHLBjA1Pw4W9Ac8SDzOnONJr2TRGF8BeKlBw4PIqMMNOs90Yom+hAdpwyrOJwtKl
	 Wf0G0w93gJ7z10jRRSN+Bbhd0iIWVUdSOKU5Cye2SJrYrcr6ixD6lO5fJbVFkpSE3e
	 7eAprgN/g0YL3/X1MbsN2+Fm+zAp3GlMOIHO05xBcBAwe+KOrg2OdkP3EZXFhsxckP
	 UrVxQNBOp0xig==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54298ec925bso4400532e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:47:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLWqB73s/Jqie4/hix3tfXUJIhtKCydSdxQCMwwB/A6VarBd8HOMnrLHBMNqxNKb1zd2v1pVaKioYq4xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9hJnmLNy3SThiV7YDi1bCw4AcODkGE8l5RaThnmvHMZ6aakJ
	v9Emt2pHocw4Z/eCQ4GS+GV0GqYkRPVJsIQu8FBrrBuoV02HdMvDS/U1YkMLQIQ1TYDPByNqWmm
	ylOmuIEtzbYokRoY6mIDXLzO1epM=
X-Google-Smtp-Source: AGHT+IHr6FlSsJHfzICCVBUrl5CzCaA/udUqGMEb2lfywIjXACdmACVxomV4UlAhuTi7R4XQjTsvVGS+sUWHnscJ5Yk=
X-Received: by 2002:a05:6512:3d11:b0:545:2e76:495c with SMTP id
 2adb3069b0e04-54838ef5a3emr2518535e87.25.1740232039369; Sat, 22 Feb 2025
 05:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127114334.1045857-4-ardb+git@google.com> <20250127114334.1045857-5-ardb+git@google.com>
 <CAHk-=wgD1TGxZPC0yoiVJb3qDN9vDpzNkcW1z17+6mk_Rh+iFg@mail.gmail.com>
 <CAMj1kXGfgxBM5DJ6vwwGvqPs9hH57h-G4w=-bF51+7cckayPGA@mail.gmail.com>
 <Z6CPFv_ye8aSf320@gmail.com> <CAMj1kXHi63vHS7EuZE-frb-nf8P9RV=dPyFR+UU9=NaCHvP=MA@mail.gmail.com>
 <Z7m8i8YC7Mltqcpz@gmail.com> <Z7m8-4X0DnPVn-SZ@gmail.com>
In-Reply-To: <Z7m8-4X0DnPVn-SZ@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 22 Feb 2025 14:47:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHu6yUXoGQJCqfZyBeyvSQ+8k9QEQgJJb1au3P76851Bg@mail.gmail.com>
X-Gm-Features: AWEUYZmd-dmDY7OFVgiiFv8JuhYoasVT26gks_4ztu-PYAr2fmWi-mxl0kNzwA4
Message-ID: <CAMj1kXHu6yUXoGQJCqfZyBeyvSQ+8k9QEQgJJb1au3P76851Bg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86/relocs: Improve diagnostic for rejected
 absolute references
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 13:03, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > So after another 2 weeks there's been no new upstream regressions I'm
> > aware of, so - knock on wood - it seems we can leave the die() in
> > place?
> >
> > But could we perhaps make it more debuggable, should it trigger -
> > such as not removing the relevant object file and improving the
> > message? I.e. make the build failure experience Linus had somewhat
> > more palatable...
>
> For example, the new message is far better, even when combined with a
> die() build failure:
>
> -                       die("Absolute reference to symbol '%s' not permitted in .head.text\n",
> -                           symname);
> -                       break;
> +                       fprintf(stderr,
> +                               "Absolute reference to symbol '%s+0x%lx' detected in .head.text (0x%lx).\n"
> +                               "This kernel might not boot.\n",
> +                               symname, rel->r_addend, offset);
>
> as it points out that the underlying bug might result in an unbootable
> kernel image. So the user at least knows what the pain is about ...
>

Ultimately, it is the die() that results in vmlinux to be deleted. And
this is actually a result of the slightly dubious way the
Makefile.postlink logic works: usually, artifacts are created once by
the Makefile rule that defines how they are built, and if that rule
fails, no output is produced but the input is preserved. In the
vmlinux case, the file is modified by a separate rule that executes
Makefile.postlink in an entirely separate make invocation, which
splits off the static ELF relocations, using vmlinux both as input and
output.

I can have a stab at fixing that instead. That way, we can use the
improved diagnostic message, and leave the die() in place without it
resulting in vmlinux to be deleted.

