Return-Path: <linux-kernel+bounces-569398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ADA6A273
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C539618952AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE761221DBC;
	Thu, 20 Mar 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UZUcr4fx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jLPI9mzx"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE71D6194
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462517; cv=none; b=l5Zaonz7sAQ2xyNRl0ehk8BMc2MpPNxyMgSmyhzxt4aohgUVBvbfFo3pu1K/QMRrBEuI5TH9h9Fe/DWuISHqnm6R07K+SrUZpOpYNXRgOZccQyzCmOG4RFkIeBXEEjdxwRT7XSN6UUFHM1JFf/YHiQCivn56KzrGqT+Qozssens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462517; c=relaxed/simple;
	bh=TKt9Etbyd+6lbrjcqrPujBy370zZM6JfyA35fvk4SUE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CFmFgb+HnNM5QPOklzkcgupqQnTvdw5QlaJi6PGbfOx7hvxWmc3eH5MrQt2PNQgPGKW+ggF4u4b90xwoCXDD275qxmoJhdsJ4QTX/vGpDo6GK4bhgQqgLf8ozI2dDATGhYR9g3WRIBWQthZ1SiwGGhZnydjRFZcHNij1qOI9mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UZUcr4fx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLPI9mzx; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5FF471382D7C;
	Thu, 20 Mar 2025 05:21:53 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 05:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462513;
	 x=1742548913; bh=bQtSbsAebIiFW2nPgYN3fEu05hmxSDGpViPkOh0koQY=; b=
	UZUcr4fx0KomfbUqK39EysoFlxL9GhmhTZMPcCYxOz4b/G6z/eM3ebkeTdXToCbK
	5SiGo+qH5s/HQZw+d4PGWXNQuEeHnhN7M7+JSpLpmdQ4YqvhEh4YwqkXzGKmFqpF
	sjFEB1m8CUAtFPKEwaHyEFUtSl4UCUPog+l+T4PZUhB4s5DAfREqpk7Oyyq74bRE
	Xu83hvKcooGVjp2MoPzr0S5lcAzaYbRq1sa7Aao6p+Whp1lUiHyoXy61YoDF6TJH
	1VLUcW4tCnSyTmTWgffkJC4cZQYhbtL11PEl6RPanqD/6pR3485/FWpgLuWc5FhD
	aMLyteTXwpqUEHvYqN3Dsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742462513; x=1742548913; bh=b
	QtSbsAebIiFW2nPgYN3fEu05hmxSDGpViPkOh0koQY=; b=jLPI9mzxH/l3E0zsf
	SzC9PLwK8Ff7q42HgpNcoebmCDgABrfYWmVYYgLcoNzAk9vzRJCnXUY8yGQf9l6/
	lMNbgexOaWdfgwzfEOvj0Ts6iInMyDIWEgfJZYEFdSHu+kWj/VEDy28pgl02te9u
	JFyiOic06liT4waRmKRaLd4LT6YT4LNy2cEJou4firkiz7NPfiZwQGVxWbGh++e9
	Cl1zsl9L/putUkRmO7MR2I0t1vO/L7NBwzxDTNxBZv+khkFeGBWVb1JXX3Ibzn14
	XBBofO/z0orgipB1c1coFL0e+w90+oK14xPH2OxXbV4a5Byt22VRrQMeaOMyDMzk
	VCvRQ==
X-ME-Sender: <xms:Lt7bZ8pWqXjAQ6u7qBzAZuT0FRf-IKSNeJpeJYlgmXyiPqsms9wDFg>
    <xme:Lt7bZyqMQfpTjS15apx_W1On5aBJvFYOrpUsN4FjzMBOqO_v_nyE5yaUkzUtU1SkI
    g8S-JACu45bn1b9mJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnshhhuhhmrghnrdhkhhgrnh
    guuhgrlhesrghrmhdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghs
    segrrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtoh
    hmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdp
    rhgtphhtthhopegtuhhihihunhhhuhhisegshihtvggurghntggvrdgtohhmpdhrtghpth
    htoheplhhugihurdhkvghrnhgvlhessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthho
    pehsthhurghrthdrmhgvnhgvfhihsegtohgurghsihhprdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehp
    rghlmhgvrhesuggrsggsvghlthdrtghomh
X-ME-Proxy: <xmx:Lt7bZxPC7gt6magmAguzg9AaQpy15VbQT7DAikwuuVy00CL9frpODg>
    <xmx:Lt7bZz4gbT_UC3NYCu_FnAfGC6KGYSFj93BoAlDuEPCzMyMXguwKFw>
    <xmx:Lt7bZ74y2sX7ZoHXB_-nyGLbPsYukcxteYVAyynniwTubpHATHw9og>
    <xmx:Lt7bZzjrjFNl3O27frSyV2o8kCHLfLT-UhkPHyF4Gd7PfxRxyqLA4w>
    <xmx:Md7bZ8T8nxjacSeX6SLbQC8QitXN-rHGe1jXSiFmXzkSPnWKCN671kNX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65F342220072; Thu, 20 Mar 2025 05:21:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4d23c9949082f1fa
Date: Thu, 20 Mar 2025 10:21:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Nam Cao" <namcao@linutronix.de>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Stuart Menefy" <stuart.menefy@codasip.com>,
 "Xu Lu" <luxu.kernel@bytedance.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Dawei Li" <dawei.li@shingroup.cn>, "Mike Rapoport" <rppt@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <9256ca10-323d-41b4-b935-5281f925d50c@app.fastmail.com>
In-Reply-To: <20250320084428.51151-1-cuiyunhui@bytedance.com>
References: <20250320084428.51151-1-cuiyunhui@bytedance.com>
Subject: Re: [PATCH] riscv: introduce the ioremap_prot() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 20, 2025, at 09:44, Yunhui Cui wrote:
> It's advisable to avoid mapping memory with the non-cache attribute.
> This is because issues may arise when the same physical address is
> mapped as both cacheable and non-cacheable simultaneously, such as
> in the case of hardware prefetching.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Makes sense to me. Ideally we'd have the check in generic_ioremap_prot(),
but I believe this would break on (at least) x86 because of
legacy callers of ioremap() on memory.

> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index a0e51840b9db..736c5557bd06 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -133,6 +133,8 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
>  #endif
> 
> +#define ioremap_prot ioremap_prot
> +
>  #include <asm-generic/io.h>
> 
>  #ifdef CONFIG_MMU

This feels slightly wrong to me, the "#define foo foo" method
is normally used to override a declaration or inline function with
another one, but this one only overrides the implementation, not
the declaration.

I see the same is done on arc, arm64, parisc, powerpc, s390,
sh and xtensa, so we can keep this one as well, but it would be
nice to change all of these to a less surprising approach.

Maybe we should just remove these macros from asm/io.h and
the trivial wrapper from mm/ioremap.c, and instead change the
other architectures that have GENERIC_IOREMAP to use

#define ioremap_prot generic_ioremap_prot

It seems this would be only csky, hexagon, (some) loongarch
and openrisc.

     Arnd

