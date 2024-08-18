Return-Path: <linux-kernel+bounces-290907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD69955B0D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67B61F2174C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4ABC152;
	Sun, 18 Aug 2024 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cYRnmdsc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA723AD
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723960115; cv=none; b=WsvdxCOsRPVNUOWnPqSwS7M+4jR/XIiO1H/Ahajy/+f6S7gkc5zQ5Ji3KlkKo9YS9URbehhl6D2g1CyYhrEmdhmg4lcadgIFmhWKAjiLcAwrD/LMJGYV5PLI6ocU84MQS5v9C7vQ01aDZkuun5jmwdZvkXNAQq2J30XyQKORISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723960115; c=relaxed/simple;
	bh=EepZC3PZkbDEcnPfFCfp7F9HHgU/98QSGU8rnJ6cMxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+BH0BzMf0MRR/2aLKpm3Uo5Yfy7EcrbQHdwdG0nxYHpmYqimHHB/yoXBBVgFSj2bvWsF9T5igN3YbSKmA0bPtYkC+r5itOTjqgm08OKZ9Arb4Cp97xtT30kMLTdCvH9LLQoAge3vQ9brERGYTYzhWhk5isycESw8L5Bb15Lz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cYRnmdsc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 75A5440E025E;
	Sun, 18 Aug 2024 05:48:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y3ZQCI2g1daR; Sun, 18 Aug 2024 05:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723960105; bh=G46Z/pwImR59vx/idbYZcXh9u33rHLa1v4l5EuhbeuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYRnmdscwe1I9nXGQutjoeJqvX76LVPchWORKyxyfVtnXBsogpdeCZ7cjQyaB+upZ
	 /hLfMIHiuyQAQ2xyjr0HBq2elOVhNpj1ISt5gbuVZUEKYYFB1SdJ/VgVI+atZxmeQO
	 l7PwNJNcYoc+SZVZO1xPxYTJhwHTsXisAWGOoaSfiEGqaH1uM4k9lghG4CDu+sW/Z5
	 CpQpD33lqTf0bcX50J4jqbjRW+Bl0ldKjC1YEEBsxR4E1fpx/hWCh6BD7mZT4IC+7g
	 CvpuPvTUoKCitkAqRw8ggqiibDVPhKqEx4OyArExY491wkV4rwkuMnZ5l1xiM69+bU
	 /avlvZWFWhA/U9qUSaeZJAMJXqJ3ZagHANfDnQ8rSJhXk9vXeQHqkH4q6tSK2GKz/0
	 6JStwk1FYzwiMkY4dTjxw4Mw5DJEMl8XNCs+V0XhbAFud8O6yGtIuEeByoiODP8LA7
	 fCOwCBpQ59gU6dUUv5y44LZjN4IbA35/EP0qFiHEc4fa9ve3aSzJTLUQgPbDknhzH2
	 8UO0dFYhYOhIUOaZGXVb4Yod1ODZgY36pEBQgTwx//yLjkMGPYDHgMpscR2SfgmeJ/
	 3/zwHyRGXWPPLhs+nv7+y7AMyt0tPedwJU9UTI16Z/iLIH+LHdWAZ5nyjaOQu8H27q
	 5IF11SdbqWL+K/TWRSu0AO4U=
Received: from nazgul.tnic (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D45DD40E0185;
	Sun, 18 Aug 2024 05:48:14 +0000 (UTC)
Date: Sun, 18 Aug 2024 07:49:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
	seanjc@google.com
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with
 the alternatives mechanism
Message-ID: <20240818054911.GAZsGLV1MAEMLk9RiP@fat_crate.local>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
 <CC9FA68B-551A-4357-9088-D199C5859356@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CC9FA68B-551A-4357-9088-D199C5859356@zytor.com>

On Sat, Aug 17, 2024 at 12:22:22PM -0700, H. Peter Anvin wrote:
> The padding avoids unnecessary NOPs.

And a NOP vs some other prefix to have one less insn matters practically
how exactly here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

