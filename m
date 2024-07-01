Return-Path: <linux-kernel+bounces-235647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22091D7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6824B23EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820941C85;
	Mon,  1 Jul 2024 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cpONkq40"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22233FE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814147; cv=none; b=Vq5v73Jd1/Hmo8A1Kut0EJa7/dVDCu0w9t7bidQ4axLFqlpWsbn/irkBjgy3cThB7L9ErWgD8crw3SHfje4ZWrKvLOvwDDO+b4ZrsQhVvq5l0DHJqyFjaEb6P9p5SNkH+HZMIZb4SDh+AFp1aELMU3BdDK3KKE9AlRXb025qeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814147; c=relaxed/simple;
	bh=yu7zEuDuX70Ff8y7mh42pUCyTGIn1VYL9Vh9F/cXML0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu0g/DA25Y7Rrqis/1zlgmLEa4Kyw9PWF+7xYA6AvgRaifg863QpmINVpto3I4s9IifRgo2DfJHJQBbcwayUscfdKFS8J4ClC5/AF9Y+ea2m48s1fgBkfbBOrEDho5HxU0yqFttHgcfg1Ec5Vd63noTeUgikfTBVuQsJTTq9EAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cpONkq40; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A37ED40E019D;
	Mon,  1 Jul 2024 06:09:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cYihkSCg1Nn2; Mon,  1 Jul 2024 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719814138; bh=Hhxy5v3YzmxyT9Wh7oyXjG1N4XxgzLak4QFrRjCzjOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpONkq40WMXb1P+Hv1N8WbDQ5R9UUSFDx9PaiBjD4B14ip9ZgOZ98vcEx2A/BqInm
	 ZoaO/yeEq85mIqh8XBWLrlsQgJq7lXMikkUWl79J5f6V1joBDPUj5NtKiXxTPyfZIe
	 /lnsWER3GOVxVzrHoVd8bx38SYFhjoGqXsUWCNQgj2tk7L+CTApcqd2PzE4TX6le1J
	 c96DVgUMAZzaf+v4rXSCt1vYOfbo8duP9A3MPuO0oQAOPIo07WRhjUqArOSH80zPZx
	 hwwfgIZskFeTjqmeyth6DooObkK5WDRCOFkhwOf3OgOwce9ioDhhbXiItAq8BqqQDM
	 /+oH65ULtOZ8yLrts44nPh3ykHOx016erfQel9gUbvAVbluo084xFb4srhHAe/uycL
	 qxvzVJMkf/NGMY2Sbl5KzL9RLWUg6K3PqomlnqJHNO+NTsKwGUvTvPLW3VWrRCi1Y8
	 LQclwojvwm2BtBeqfqxnlb7IXsQouUfjMybitadm/K9votri1NDG+Tq1XCjSyadIKI
	 OMGJhQXg70Yef3TIJwF0fLQzcFIlRBdxidMePV+Fukp0jFjzYFHQ6qC5EnWrUpWcQO
	 7opd1YlFZFbag3NwAVphAN01f5XAZC3GXhphw7raRGyzy9JcTO3YlSLfq7HXKTnPU8
	 +6YkeR0zDP/XwKQvAvehVZyw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DC1C40E0192;
	Mon,  1 Jul 2024 06:08:47 +0000 (UTC)
Date: Mon, 1 Jul 2024 08:08:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, peterz@infradead.org,
	brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Message-ID: <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <20230112072032.35626-6-xin3.li@intel.com>
 <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
 <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com>

On Sun, Jun 30, 2024 at 07:34:42PM -0700, H. Peter Anvin wrote:
> It is much like "movl %edi,%ds"...

You mean ...,%gs"... :-P

But yeah, that makes more sense.

Are we saying somewhere that when moving into a segreg, only the lower 16 bits
of the source operand are used?

Both docs say

8E /r	MOV Sreg, r/m16		Move r/m16 to segment register.

and I read that strict as r16 so I'd expect a "mov %di,..." not a "mov
%edi,..."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

