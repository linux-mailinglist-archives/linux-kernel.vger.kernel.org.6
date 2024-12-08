Return-Path: <linux-kernel+bounces-436607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7239E8889
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E339281184
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10E192584;
	Sun,  8 Dec 2024 23:03:23 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120253E47B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733699003; cv=none; b=pUImQBFUHLow0OLaxj/gDvn+gGAPlK5h7NVLc5HG6cY0vicywHzq6dbvaG8IWOw98QqNPqMGw3Tj6IpGJCVXFh+hqVmmSIOf2++Tq/Hqt44F2vrPFmZ3ct81JzQYhC3CpBf1+t59J44l8hgws6+e2Rje9byWwVMqoeVz3oq4xRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733699003; c=relaxed/simple;
	bh=40veVCVirRVktaqVPrM2p4Qks7Saw4ORgWg04SUdY50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoqBg9pZlD1n+zhgr6goil7eJ/fkPqusDtia8f9kXaVE2+B8xazEcloXDDOZe3NEcpzRFXqxsVE83i7SCkPDZCbiXncDzcuJP1Q2xkfuXt45iA2qRuxw3oImpQAd8Al/qGM7W7WI/nmDDtePA/LUqEcWTpK5++/obS9Wkw/HM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4Y60gg08dmz1sB7H;
	Sun,  8 Dec 2024 23:54:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4Y60gf6RgRz1qqlW;
	Sun,  8 Dec 2024 23:54:54 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id T0-rdDGm_aRI; Sun,  8 Dec 2024 23:54:54 +0100 (CET)
X-Auth-Info: p2dcipIOeCHJ4WzOEzV4hDpcyOeAurrqSICwrZBUAPVj2EEyzsLx8mpKpH+qJ2m1
Received: from igel.home (aftr-82-135-83-17.dynamic.mnet-online.de [82.135.83.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  8 Dec 2024 23:54:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id C74EA2C19F2; Sun,  8 Dec 2024 23:54:53 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>,  x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] futex: improve user space accesses
In-Reply-To: <20241122193305.7316-1-torvalds@linux-foundation.org> (Linus
	Torvalds's message of "Fri, 22 Nov 2024 11:33:05 -0800")
References: <20241122193305.7316-1-torvalds@linux-foundation.org>
X-Yow: I had a lease on an OEDIPUS COMPLEX back in '81...
Date: Sun, 08 Dec 2024 23:54:53 +0100
Message-ID: <87bjxl6b0i.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Nov 22 2024, Linus Torvalds wrote:

> Josh Poimboeuf reports that he got a "will-it-scale.per_process_ops 1.9%
> improvement" report for his patch that changed __get_user() to use
> pointer masking instead of the explicit speculation barrier.  However,
> that patch doesn't actually work in the general case, because some (very
> bad) architecture-specific code actually depends on __get_user() also
> working on kernel addresses.
>
> A profile showed that the offending __get_user() was the futex code,
> which really should be fixed up to not use that horrid legacy case.
> Rewrite futex_get_value_locked() to use the modern user acccess helpers,
> and inline it so that the compiler not only avoids the function call for
> a few instructions, but can do CSE on the address masking.

This breaks userspace on ppc32.  As soon as /init in the initrd is
started the kernel hangs (without any messages).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

