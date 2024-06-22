Return-Path: <linux-kernel+bounces-225692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67A9133DB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5294E284529
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F116630B;
	Sat, 22 Jun 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cH49pnWe"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF111155C87
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058707; cv=none; b=t0zc0oPzsz1MtVHKXmzjr8Py5OmiMS4frP1t8kAMQidcbOp71x2QU326Rn03/A0eGGLWPFYGDxmxAa14DIQ1ywoqlXg7+ak74vQvHU4VhPyjsRFxx6f2bxVPAvPotchwXPYI0qbaw1bDmZI0JLkL56xDDjHXYtRkEG3/1SVp554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058707; c=relaxed/simple;
	bh=luy69jnF5njL8gUfluNCNLhAakoaL/yegWrkpfKE/rU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT/7lN0utCQVTS/l/gep/p9EVQBZ/h+IBG0YpfOoqDDeEF2AF0Ff4NLfRc+6aeU81Rxp2HMiZYATYbZy0om8lyZQtqQHkcDEcFB0OtGW8tH0l+GPqlB9iUjmPLdALrKoIbter2zLHvolo4kpTTU4khSW3VfRCVRnwOk14uvJQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cH49pnWe; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719058703; x=1719317903;
	bh=luy69jnF5njL8gUfluNCNLhAakoaL/yegWrkpfKE/rU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cH49pnWeR6k+nnE2zzNlVZ9ld0S/hoSZduwUitTHA10DJ+ICOAk+Z42SNhXkpROjX
	 4+0XRsEts8n9OBiBMRxhPRHFApprxhKdrGYYObqGY2L3xcmx/VNHr48k3tzGHn39Rm
	 uMk4Q9M1t7inlqzc7KwrtcyDfq4Sbq+LJSKhEfIIA3xww8MKaGReY5YYvOJr39U9Jm
	 PGJJbh9sA12AL7XN8d/1r28hywKazGtehwqGZ0QMWFRTMesU/8eID+LitF4R8QZTad
	 wIXhs1c2J7WQ+5cAkIU8DgPvF4vj0zY6FFqJClF4SX0KSo/ILfUxJcSZ0uvKXKV+6L
	 gX6MJjFVJhAsA==
Date: Sat, 22 Jun 2024 12:18:17 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sparc/build: Make all compiler flags also clang-compatible
Message-ID: <e26PTXUXEz8OYXmaeKn4Mpuejr4IOlFfFwdB5vpsluXlYiqDdlyQTYcDtdAny_o4gO4SfPeQCCN2qpyT6e0nog5EaP3xk2SeUPTrF54p1gM=@protonmail.com>
In-Reply-To: <20240621185345.GA416370@thelio-3990X>
References: <20240620-sparc-cflags-v1-1-bba7d0ff7d42@protonmail.com> <20240621185345.GA416370@thelio-3990X>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: a46a21971ad74a875ee1462ced2663a00c9316b2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

Nathan Chancellor <nathan@kernel.org> wrote:

> I saw through the LLVM issue above that one other patch is necessary to
> fix an issue in the vDSO [1], which I applied in testing this one.=20

Mhmm, I did not submit that yet because I don't feel fully confident
with it. I think it should probably live in include/vdso/math64.h
as plain C code instead of the current asm version, but I don't know
what is the proper way to check the current environment's word size.
Is checking BITS_PER_LONG enough, or should I do it in another way?

> I noticed in applying that change that you appear to be working on 6.1,
> which is fine for now, but you'll need another diff once you get to a
> newer version, as we stopped using CROSS_COMPILE to set clang's
> '--target=3D' value:
>=20
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 6c23c6af797f..2435efae67f5 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_mips :=3D mipsel-linux-gnu
> CLANG_TARGET_FLAGS_powerpc :=3D powerpc64le-linux-gnu
> CLANG_TARGET_FLAGS_riscv :=3D riscv64-linux-gnu
> CLANG_TARGET_FLAGS_s390 :=3D s390x-linux-gnu
> +CLANG_TARGET_FLAGS_sparc :=3D sparc64-linux-gnu
> CLANG_TARGET_FLAGS_x86 :=3D x86_64-linux-gnu
> CLANG_TARGET_FLAGS_um :=3D $(CLANG_TARGET_FLAGS_$(SUBARCH))
> CLANG_TARGET_FLAGS :=3D $(CLANG_TARGET_FLAGS_$(SRCARCH))

Yeah, I was working with 6.1 at that time since it's the version
that my distro have installed for me. Now this is more of a workflow
question, but this means I should submit a v2 with this change
merged in with mine too, right?

And thanks for the feedback!

