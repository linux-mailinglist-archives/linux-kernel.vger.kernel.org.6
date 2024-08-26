Return-Path: <linux-kernel+bounces-302259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EDB95FBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996B21C22681
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AC19D079;
	Mon, 26 Aug 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GlHIqnnH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93519B3E3;
	Mon, 26 Aug 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708150; cv=none; b=nzViuQBLH8t/KN1h0laeCrzOiMXDCv+RXy9kivH4IIx2OyxtUVUo9+fpigMGB8oikyieegkxs0dV2R6N7v2ZULIAWhZxosogwRNLDMSBxijW6JuzxDln6/jQtYOeEXlVFZVcBj4gZhoLJsFXsrKsBiiyrOH0f74zOWUfa5ljyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708150; c=relaxed/simple;
	bh=KWFanSE7a5YD1qySSVxDMrsb9vLrSW3D7bdJrpj+tcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjzoXx0/sXuEhv59KH/znBtqPVTvp6Dc7Ik9/zuUGYJR9d+jk3wcwsKu1FxOF9akuHYFDJtQV2uNeA1CPhAFjRPGWrrsVbETg2nq0d1NpGWAizNUQxYCc6kOkObXtI1gtVT2pnZgO/dbYzTsE1ZLJdVePKyMmSE+lsLXW77PUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GlHIqnnH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DA85645CC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724708148; bh=qqrB4CtT9Hw69RzlowOexS1vm29yAxh8AIkHouAVxWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GlHIqnnH1C3iLtsC6/OA+z1r0SIN9p7mNfnFygC2Kl01fqr8sB7p3kPQv5Tmt2Lss
	 br1wTld4pXrvyie1zmphj7CaWHHMy4VBqsdPZc7sh7/wwxjFuYAlIOPtpoheohYdTk
	 PHnf8wIohO3v8I2kK07hyCVOVWHic04ErQzjdY5NOStG6YeD3XSHBeeLOpI3dJh2iO
	 foDwGXPpj9NnM7s2EhS3RmHq8vOmYzQeANsDRpCymy+kKkywwAhPP9nsn4NQXyFoKB
	 AMGaVjVAACSjH/ABmXhbZi4YBaVe1ltuwYJ0+XLPjFqR6Rph4nQ8smwREyf4JDJk1V
	 y1Gbtbcu6x9wg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DA85645CC6;
	Mon, 26 Aug 2024 21:35:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v3] docs: bug-bisect: rewrite to better match the other
 bisecting text
In-Reply-To: <74dc0137dcc3e2c05648e885a7bc31ffd39a0890.1724312119.git.linux@leemhuis.info>
References: <74dc0137dcc3e2c05648e885a7bc31ffd39a0890.1724312119.git.linux@leemhuis.info>
Date: Mon, 26 Aug 2024 15:35:47 -0600
Message-ID: <871q2b6k7g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Rewrite the short document on bisecting kernel bugs. The new text
> improves .config handling, brings a mention of 'git bisect skip', and
> explains what to do after the bisection finished -- including trying a
> revert to verify the result. The rewrite at the same time removes the
> unrelated and outdated section on 'Devices not appearing' and replaces
> some sentences about bug reporting with a pointer to the document
> covering that topic in detail.
>
> This overall brings the approach close to the one in the recently added
> text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
> As those two texts serve a similar purpose for different audiences,
> mention that document in the head of this one and outline when the
> other might be the better one to follow.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> v3: (this version)
> - incorporate a few minor changes after review feedback from Petr
>
> v2: https://lore.kernel.org/all/fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info/
> - incorporate review feedback from Jonathan
> - rename to 'Bisecting a regression'
>
> v1: https://lore.kernel.org/all/10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info/
> - initial version
> ---
>  Documentation/admin-guide/bug-bisect.rst | 208 +++++++++++++++--------
>  MAINTAINERS                              |   1 +
>  2 files changed, 139 insertions(+), 70 deletions(-)

I've applied this, thanks.

jon

