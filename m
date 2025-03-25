Return-Path: <linux-kernel+bounces-575871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C1A70868
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433B11890A75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2644263F49;
	Tue, 25 Mar 2025 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vtm0J5GH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EB262802
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924693; cv=none; b=j+c57BMmcTH2IE5fzZkaVkxExnuJNgzRYLjdZkMdgwhg8Dv7qkSwOZ/w4Ret1oasy73wKpA/EXpg2M57SnoSumDM1nD1KZtqYayWt/sH8pHfRw6dXXmEn34ghkXQ6gcYyn9tAyCcuq8JQTP2zTwmQ5GmJ8wQNrl1PQdVVF+WLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924693; c=relaxed/simple;
	bh=MtAwrWmxg9dBi0rjvIWm0PgZYmZqT8SbziCNVAGnVG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK6TcHPYQj/+boeOkFSKl5/Tp+6dEWlxzMgzApHEusrqzi37iS9dHL5ONzqDgn72HSmea3wIyQNfUeuzljvSQUn21kzSpzR11wm69d2F6KPDgKp+jaOnKYjv0Vk8gIfh1M6RoPSSquVdkAORv+LoVEaZD1yjdF+/aVwQ4V0flC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vtm0J5GH reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6ABD840E0219;
	Tue, 25 Mar 2025 17:44:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bbYwQWPG2qlw; Tue, 25 Mar 2025 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742924683; bh=OZ4u4nJjvdtzKInAzjV19TBfXzG5uiiiHQN7zhblzZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vtm0J5GHGZPjia8oGn0oaUS9iZeFqUp4hxxdsB3phfwleSjLaXq8Hw1FFyV6HREJx
	 qlcpBtmO/HQ/mLWnJw4mabx0eZmfhl+y8kDtT1DGDVObEP9j+TeajNLqN7EjheaNft
	 XMnim2rMRriM0D9/tYuAgK9UpxXGLfObK1PbUou1ROhDBGWlQVpGMr+xy5Lc6gX4xR
	 9E/7AgSSjpnEbNwivdVB/jPAhreo1olFABGzkkFQaohgmrU/M8qPX0dWSiiMEjhQD3
	 E2hf5+Gqvo2rS/0K1jlyo8GNBCJtpJymLQpk3gIeqUIbrbLmbasn6MI09YN71Wicfj
	 d0MC4s8RId9s385EvjWMId28HxKngWhotdRhZUomlpGCMMZbQ0XmO/UdfuXYipMHQi
	 l6oY/8cjemt/10XIFBzmE5igSm0SISD6IN5xOgu7geaSP8+i4XGdzmMMzyfQF2U/Sw
	 OQWMRxgErheAHzc9MwM5YUiRbru8nI7MxMiXmfHnq0O2HVepeI2zliIUlrXr0SCRW0
	 HSaOxnWT6x99FoYLI2Y6OXsaap0dF7+r9j1m8Wz6ulCXB6J6lyd4l82T+oB+ds4BuR
	 7pkrmYMZf5qtfnBbMRm0340eW1MUONyOkCwxChfNy/aKqnY3wBk7nqLymaHZFNy+Kd
	 37pV+o4f/Ax57OcQGisDz4Vw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C98A40E015D;
	Tue, 25 Mar 2025 17:44:36 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:44:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip 1/2] x86/hweight: Fix false output register
 dependency of POPCNT insn
Message-ID: <20250325174430.GEZ-LrfugbyA0OxOnH@fat_crate.local>
References: <20250325164854.199420-1-ubizjak@gmail.com>
 <20250325170953.GCZ-LjYdl4rftqY-us@fat_crate.local>
 <CAFULd4ZbYmwTOR0vc8+Xiq8uPgqbte=ruKVGiKKngjHmkNunFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4ZbYmwTOR0vc8+Xiq8uPgqbte=ruKVGiKKngjHmkNunFw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 06:17:01PM +0100, Uros Bizjak wrote:
> Please see [1], errata 026.

Then next time put at least a reference to such official source. Because =
right
now it reads like a wild guess.

> There is a lot of performance analysis at [2] and [3].

You mean the commit message should not mention it - people should use a s=
earch
engine to find that?!

Lemme quote our documentation for you:

"Quantify optimizations and trade-offs. If you claim improvements in
performance, memory consumption, stack footprint, or binary size, include
numbers that back them up. But also describe non-obvious costs. Optimizat=
ions
usually aren=E2=80=99t free but trade-offs between CPU, memory, and reada=
bility; or,
when it comes to heuristics, between different workloads. Describe the
expected downsides of your optimization so that the reviewer can weigh co=
sts
against benefits."

From: https://kernel.org/doc/html/latest/process/submitting-patches.html

Please peruse that document when you get a chance.

So my question still is: does that change has *any* *impact* on *kernel*
workloads?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

