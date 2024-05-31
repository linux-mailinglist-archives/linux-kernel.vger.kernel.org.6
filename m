Return-Path: <linux-kernel+bounces-196984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463588D6497
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1A428B9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5333FB96;
	Fri, 31 May 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X/sce4D7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BBE17758
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165989; cv=none; b=fkk/4vowVVyXRGD3U+0KgfgX87/L3VjSoOSk1ctRG8Ii0A1JCU6uBRRyf+emwYXFhQsQIljsQxrxg1R+7cp7rKKeaK+9GNgZH7PVO9Bd8wNw26snRy4wVsxc01PjN3EhxJIwQ+A81n67t7EkWBBDOZrNcALn3HOqtOpxS6uMnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165989; c=relaxed/simple;
	bh=/ybGb71D4r00IUnnKMB3xndfFp9T+1YpgNy/AAMZhWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doy6VpXA9sxgJ0Fz8hHCecUTjO6yVxbW3+6M0U/04hIx7Q6n9JtmfkfOQajNN+PMF5eJACTif8qikDiNUKs1f0KrOxJYAC4+cLcyxiFP/ulmFkdnYZbCh/jXqJPzuCSFWpcWIX7n6t5QAItB27TWKnmC81l882f0f7Fr7pFF7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X/sce4D7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0849740E01E8;
	Fri, 31 May 2024 14:33:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H4Oojfp3Dg1E; Fri, 31 May 2024 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717165976; bh=YQhuTQMib3XYb0Fnoq/gWXTobkZBhfftmNFNgwns6Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/sce4D7j/NmOMCg+fBeikOfAkcD0Qee/Vkbr/Vyxaaa5RtDwX04EVriwZdri3tBa
	 5PBHP4r+g94qvgk8D8VmZGUPqGI97eAZcpGV0gqsgasmJjYlVf86nvOYHTnbRsxeO7
	 K7jGZn4vOHY2i7H4X8Si1m7v8w+ae/OwyspbdSHr1kJ/dTlCYXbWuO8k8qyHLwGvDX
	 dOZ2zM+oLhUguvrt1nG4e9T8vf31WdO4yNf1J/2AgVlC5T6XJBSOSPs7Nc5iQN19HK
	 u37UZWC8kMoK3sLjd9wQ4kpobNi+R18kiEgm34NLoCpBv6aZWF6/u/krENZihVW5BH
	 Hv9fR3HbP8UiqDau535n1Rcxpq/a/fIKBmouaLoUKJ3boMqFng4nFU50F0ADQFPruJ
	 3XOMOB8un8cSUj/zSPMT68w2ZDjh+qMdg94x9a+J6eHx8Uh76Zs6J34/BSpmcRCLhh
	 PsNqF8zGLaaVGcJhUEh1La6CQLoVSkzj6/AxbaVBriYzjSWjAtlinxsZXyXbdfujEa
	 4C9rjgI/qcZKeFGU8n30virDqXrXIK7Rnc1KHjzYcn3uQCWxUtNZdiv+l+9BbI/uiY
	 dr9X6dV1EDElD8vV3yGqfZrf+hLeeOXH4stqlUSZaegR0vFMgW0y9MOzEOELNxcX6V
	 rOLF0DPaUHF/c8wLu0cajbyE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0257F40E01A1;
	Fri, 31 May 2024 14:32:50 +0000 (UTC)
Date: Fri, 31 May 2024 16:32:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 02/14] x86/alternatives: Add nested alternatives macros
Message-ID: <20240531143244.GGZlnfjCYalemAZ_Fu@fat_crate.local>
References: <20240531123512.21427-1-bp@kernel.org>
 <20240531123512.21427-3-bp@kernel.org>
 <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a86f790-3194-4ea0-de8d-0af231ec7525@gmail.com>

On Fri, May 31, 2024 at 04:30:31PM +0200, Uros Bizjak wrote:
> Please don't resurrect the %P modifier, use %c instead.
> 
> > +
> >   /*
> >    * Like alternative_call, but there are two features and respective functions.
> >    * If CPU has feature2, function2 is used.
> > @@ -307,6 +376,15 @@ static inline int alternatives_text_reserved(void *start, void *end)
> >   		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
> >   		  [new2] "i" (newfunc2), ## input)
> > +#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
> > +			   output, input...)				      \
> > +	asm_inline volatile (N_ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
> > +		"call %P[new2]", ft_flags2)				      \
> > +		: output, ASM_CALL_CONSTRAINT				      \
> > +		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
> > +		  [new2] "i" (newfunc2), ## input)
> 
> Here too, %P should be avoided in favor of %c.

Yeah, will do.

We probably should update our patch checking scripts to catch such
things in the future.

/me adds to todo.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

