Return-Path: <linux-kernel+bounces-567077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61954A680D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FA219C0B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA12080EE;
	Tue, 18 Mar 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RaOciKBT"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F320765F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341190; cv=none; b=S+rucPpM18mRnVQY1w0fnTuMbd0npqHGsKaXQfxGfgD9pQehzpf0iNVm4VZcpqMkbPM/pMiVcGRutWeq9plv+LQr5HxYUaYKJFE8pU7bJrhPll5nV0QP2Jh0UUiaYgWvGDA96AWO7iLB0k7RWzktMuKMds3FeAr9qbznsQbnWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341190; c=relaxed/simple;
	bh=fGuUKbDOB5dmTVEfiXG6YxIzsikn2cP+B87uXozbX/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moiZtNB0B64vFM5YqY4YBXFeqBHd4PidbATRheZcXoYfcftsTP368FYT+oMYMK2m7uIUEfzLIGbXHyy1SOq5UkTgdkWAU9VRWIEEX+BtFbvbcesk8vWGLJ+FZ78A5a1irlELZ06kRsCw1L1t/l3HzzRPRIncMW4x9/YxFuQeW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RaOciKBT; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742341186; x=1742600386;
	bh=d34UJK5tJkTjTYS+Ho6QsGFR8HYdLE42Xz994EfYEqE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RaOciKBTsTlblmMpVe62hSQ6/t3Mi4fW8+urMe45f79YfYG5yf6E64gryI9qXf49Z
	 A8SNKRsiQsAPgHHVOyC7Nkv8vMiQ5kwv6ijAk4DumuFZ1IFVJxDy78hFcOY/z/p5eM
	 R6BPafrmCaSo4Jt22oLXFQacIc0PGZzkAZ/A3as5ArVeTvXw8s3V99AKjSiNQzXpZA
	 fNqC5l3ap9FTBQOA1ghIvn5t6mDDnTou2c1V1glM1dcI8tpvaOVhTIRkXpTtkPxAYt
	 dLWcQHmvUJj+10vWtNmwu0l9tFCIKgj+9/m8Q85DtGSE8vBXG3nYX6Sdk4AG9e4fyJ
	 uo2A0y/stXPSg==
Date: Tue, 18 Mar 2025 23:39:41 +0000
To: Ingo Molnar <mingo@kernel.org>
From: Denis Mukhin <dmkhn@proton.me>
Cc: dmukhin@ford.com, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/early_printk: add MMIO-based UARTs
Message-ID: <wlidpR0nAfMoUkVTrtOogcSBeZ8pEKU32ZCubunTj3-kDUj4hKY0fJAAQD11aFA5xkGAH9qV2tNee7yB5qJof_lq9zxdXAfzR0Fm6mf5cqI=@proton.me>
In-Reply-To: <Z9fWMaX25c8GIaQK@gmail.com>
References: <20250314-earlyprintk-v2-1-2bcbe05290b8@ford.com> <Z9fWMaX25c8GIaQK@gmail.com>
Feedback-ID: 123220910:user:proton
X-Pm-Message-ID: 4861024a656d413dcc21272edb7c9479286245a3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for taking a look!

On Monday, March 17th, 2025 at 12:58 AM, Ingo Molnar <mingo@kernel.org> wro=
te:

>
>
>
> * Denis Mukhin via B4 Relay devnull+dmukhin.ford.com@kernel.org wrote:
>
> > + if (!strncmp(s, "nocfg", 5))
> > + baudrate =3D 0;
> > + else {
> > + baudrate =3D simple_strtoul(s, &e, 0);
> > + if (baudrate =3D=3D 0 || s =3D=3D e)
> > + baudrate =3D DEFAULT_BAUD;
> > + }
>
>
> In standard kernel coding style we always balance curly braces and
> don't skip them in the single-statement case. Ie. the above should be:
>
> if (!strncmp(s, "nocfg", 5)) {
> baudrate =3D 0;
> } else {
>
> > + if (baudrate)
> > + early_serial_hw_init(115200 / baudrate);
>
>
> Hm, I think that division will go poorly if 'baudrate' ends up being 0
> in the 'nocfg' case ... ;-)

This patch has a guardrail:
  early_serial_hw_init(115200 / baudrate);
will not be called in case of baudrate is 0.

I can re-write code to avoid confusion.

>
> Thanks,
>
> Ingo

Thanks,
Denis

