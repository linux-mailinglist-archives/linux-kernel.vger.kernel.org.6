Return-Path: <linux-kernel+bounces-235956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CD91DBB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D051F231F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8686252;
	Mon,  1 Jul 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YwIh839T"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01C2C859
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827304; cv=none; b=r4E2XsJH5QGz1m2TJkVx1bemqLVQss7l8m2i/FM/fIBt0B+0xi9GqjqMe+EsDHhhxOASglaAhTQuoCTVAO2PeDp3zLwYxWqf1Lf6WBvvSLXwwTVezawBXNHmeRAc9+ivANHjLW4I4F3yeWjzwmOESWJRIiSi/ZmoYjGt3TV/C7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827304; c=relaxed/simple;
	bh=WDBFL/17CdcA7gxHJdZAMmvj0UN0nf3e/J0B5ml6HnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXn/hKhxtSFa3UPi7h3IylmWHhGdTxgZ/bNnjIepBwuTHdJA01B/Dkqjvs2INL/IB2SW4I6lIaTKrX/nker6ya8UcnWe8yl2HJ3o+9RWm3aydWzAGf8rUKXtxlfJNzvljv9K2R+u2kasbACk/twwsBFXjB+icqGVDgyWiNHuAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YwIh839T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25E9240E021B;
	Mon,  1 Jul 2024 09:48:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LdQdrtoIkIOu; Mon,  1 Jul 2024 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719827293; bh=auILb1VYaqkHFB1JzDesJQYua+AJ8kjsg0oXI4kMZlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwIh839Ttdc1S+Rk87CgorgNgx69rP98x4dik6SvjhqDM/bGZFnSc2DEGCJ7u/q77
	 iO9qlN4ODlt0ygVMAhmLb7Y2/QqaCdKzaezFRnZZ01hwF1RePatrufVc0TDYOsHEWy
	 xeu9deJ7T5A+jQDbmuT01jYSr1JUJLuv/H+qS14AqxdUYwtXoMI1G9v0xTUl6JOX7f
	 Ss82uJJVH8TVsrfTLZ8N93rZJ+FF9j4ljgNCN/PWKyBi7K2uKG7/hWm6nVenh06He3
	 7Mrc9c5DNmexNj73bFeG95q/trV8SWEEMi8TXAKD44/QxpAGVks7RS+RmMR3YRtY6B
	 Hu4WIVhs3zhQrYPRYA/2CG9fhseeAKsHE1ZaYgBv2MBqB/cuw53xlp4j/kUmGtePH8
	 +EKGhLeCPw5s9x0mrBriOzJ9CUipjcTnHNBb3RVAtXQvv6AaIHxKS0nIv/OrNNpUub
	 cc1t+w3QqRpXVPkCfiCxH4D3xDDJz4PtNAGJdfOk27XLG760VMcF/1xlzbB25RweuM
	 79dXnXzn+BFTvLF550SC83qtiXqqFcNgNVoyYIWqaWvT4Y6CWQTEt4dYnhtpW4FsaC
	 /FtRoAB/cj8ga4IRfZAEit6cAQMjROchp4l/Oopk+bFDNYmtTqIjrpA3aOgSwYfnuK
	 O1ZYrmu1Mmzr5frvdOsyFtQA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E64640E0185;
	Mon,  1 Jul 2024 09:48:02 +0000 (UTC)
Date: Mon, 1 Jul 2024 11:47:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, peterz@infradead.org,
	brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: Re: [PATCH v6 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Message-ID: <20240701094757.GCZoJ7TWGdv2Cm6egY@fat_crate.local>
References: <20230112072032.35626-1-xin3.li@intel.com>
 <20230112072032.35626-6-xin3.li@intel.com>
 <20240630160448.GAZoGCIHXRuBY8sLqW@fat_crate.local>
 <3A846C73-305E-4C55-B846-AC00657BA95B@zytor.com>
 <20240701060841.GAZoJH6XpJz6qyo-Lr@fat_crate.local>
 <38C69EA0-DB74-4D2A-ABB5-CB3F1D31FB0C@zytor.com>
 <20240701064002.GBZoJPQg2IXSCRa4sN@fat_crate.local>
 <2B27D0A2-B1D0-4347-8587-DCFDB05BF683@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2B27D0A2-B1D0-4347-8587-DCFDB05BF683@zytor.com>

On Mon, Jul 01, 2024 at 01:01:54AM -0700, H. Peter Anvin wrote:
> I don't know. It is stated in a number of places, but I don't know if it is
> explicit in *this* specific context.

Right, so the *read* side is explained tho, in both manuals and I presume for
the other direction it is implied that the 16 LSBits are used:

AMD:

"When reading segment-registers with a 32-bit operand size, the processor
zero-extends the 16-bit selector results to 32 bits. When reading
segment-registers with a 64-bit operand size, the processor zero-extends the
16-bit selector to 64 bits."

Intel:

"When executing MOV Reg, Sreg, the processor copies the content of Sreg to the
16 least significant bits of the general-purpose register. The upper bits of
the destination register are zero for most IA-32 processors (Pentium Pro
processors and later) and all Intel 64 processors, with the exception that
bits 31:16 are undefined for Intel Quark X1000 processors, Pentium, and
earlier processors."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

