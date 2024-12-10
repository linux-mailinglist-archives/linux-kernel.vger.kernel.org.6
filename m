Return-Path: <linux-kernel+bounces-440290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FC9EBB51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56DE16811F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636422B5BD;
	Tue, 10 Dec 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s/ea9UNn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59C22B5AE;
	Tue, 10 Dec 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864305; cv=none; b=M2icEh/gpKXrdLoGez7ZPyzB+Cy07oCvqewMMV3kANIcX9N79kAovyJk6mLvX6KjuQdY+AKcxArO8fsCA+cUz9zAW48FH4a9uJQuHhpFuwk6eByre+L/fuToylcfnnbMe13ahrm+vabUGysD1grfwVhi8W0BDTxa+qcpaGNYkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864305; c=relaxed/simple;
	bh=NYiJJVcb3fxqrUAWXCEzIIatk6i4VnLLRQo6oCtsa4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lmOVxr0YDvpIKXQaJb0ANOwdZqSd+SePbtxVKiPSMLxckhVrnHS6ZATLMMdK1aJ+fsOV8So2A2Ar/1TZiIRLh1jZMw3aNDjLm3Bk4t0P8zAYKtcoxZEQ6L+B2AwF7dkkvARNcs/wODU5eYjCbS0SWfsSMgLQuNuEJozT9cHpOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s/ea9UNn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95F7540404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733864292; bh=DTxlnJahVld0of3yDlELN9loIz47Uu5Bz3neHxKlj0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s/ea9UNnYpECXcSIK1r6JEGmF+nL+OEgbp7Nf8BYhahlVxw1qNdegXdqXliSwHj0+
	 9GP/4ninWW32QMZCrYXhfo3r3vIzCg/0WyHtQ4+unObFkZtCiNJIgOEiSwvzZc+fD0
	 kmFteNGJXQW6w62W6MhABPTbuTkQrm/f+wsve51dxowMsPuo74UUOT1NDzFvk8nK55
	 HHdv7kBn0du9O78iCQmBe838LPwJbrPtBGKh0lo2G6hKdka4hhnEnVNqPCAeEQ1UmP
	 qvOQpo/LwIpehPLO0waLttN2n8b92Hidy94d6kspcBRCjWtGEi8DtOHQ1Nw7hbrrWj
	 y7WpGVr3ralyg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 95F7540404;
	Tue, 10 Dec 2024 20:58:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada
 <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
In-Reply-To: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
Date: Tue, 10 Dec 2024 13:58:11 -0700
Message-ID: <87pllz2r30.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> literal"), exported symbols marked by EXPORT_SYMBOL_NS(_GPL) are
> ignored by "kernel-doc -export" in fresh build of "make htmldocs".
>
> This is because regex in the perl script for those markers fails to
> match the new signatures:
>
>   - EXPORT_SYMBOL_NS(symbol, "ns");
>   - EXPORT_SYMBOL_NS_GPL(symbol, "ns");
>
> Update the regex so that it matches quoted string.
>
> Note: Escape sequence of \w is good for C identifiers, but can be
> too strict for quoted strings.  Instead, use \S, which matches any
> non-whitespace character, for compatibility with possible extension
> of namespace convention in the future [1].
>
> Fixes: cdd30ebb1b9f ("module: Convert symbol namespace to string literal")
> Link: https://lore.kernel.org/CAK7LNATMufXP0EA6QUE9hBkZMa6vJO6ZiaYuak2AhOrd2nSVKQ@mail.gmail.com/ [1]
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>

Ah ... I should have thought of that ... I'm glad you did.  I've just
pushed the fix out to linux-next, will send it Linusward in the near
future.  Thanks for fixing this,

jon

