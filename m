Return-Path: <linux-kernel+bounces-419328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F09D6C89
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 04:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A30F2816B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 03:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31824B26;
	Sun, 24 Nov 2024 03:10:05 +0000 (UTC)
Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05A25745
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732417805; cv=none; b=elDIP9BlIp+xJPIu2mhqe9s6Gs4JxD+VAvdjiWDnvbvBi5CpEV20HsNcNV0Wa6Esf1Se/ISWpz3t21XFE7728KJsyBMsXsMjtzXlk0SvhgSSzicHPr4ChMCuTbEEIpTxQn/GvZjT1YoFdzOL30/EQXKqkgGFTQ/iCgUiuu8DNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732417805; c=relaxed/simple;
	bh=TRDCz7rZW73cyfup64t6Wb+A0Uz7Wwtxn/v5XnEXp4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGsEOX5jlSPb41Nr5AeB5YneLxDCnb6SE1iyLozXzsL/A+sd5kpOi8/vKuT53XP2IVTssKmvABsPx9TLPDa8mMC1Vkn6J+azUtx23ZKK2OZdiPGYc/PLWcK7TKZKmIYcbylX0vf6NAM+Xc0TOYgtjkRKcSO9esGKw0I4fReeRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.localnet (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by yyz.mikelr.com (Postfix) with ESMTPSA id 0B70373006;
	Sat, 23 Nov 2024 22:10:02 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Allow user accesses to the base of the guard page
Date: Sat, 23 Nov 2024 22:10:01 -0500
Message-ID: <2331683.YKUYFuaPT4@basin>
In-Reply-To:
 <CAHk-=whkMC3afZJBamTuppf4BTJEuHNVpqK7qMKsg5VgX8q2HQ@mail.gmail.com>
References:
 <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <2195976.7Z3S40VBb9@basin>
 <CAHk-=whkMC3afZJBamTuppf4BTJEuHNVpqK7qMKsg5VgX8q2HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, November 23, 2024 7:30:06=E2=80=AFP.M. EST Linus Torvalds wrot=
e:
> So if David's patch fixes your use case, I'm happy to apply it with a
> fixed commit message.

Thanks, confirmed this case is fixed with David's patch:

Tested-by: Mikel Rychliski <mikel@mikelr.com>



