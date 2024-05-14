Return-Path: <linux-kernel+bounces-179169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C88C5C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94297B2207B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6A181B82;
	Tue, 14 May 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHft803e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMWfzj2H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hHft803e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMWfzj2H"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D41DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720808; cv=none; b=W0Q7qOqhE41wLQK9SqBt6V70zbAly6HO7GwZJd8VyZsjEDp4Ad+Tni4zSQ8fKrPZ47Il+AJSRkfshtz41sj9wPc28GNonpcxuP1O7DYpoZvPV6T9CpKwPfRzHyFOA2vOe4VqS8GNYKkVYMBNgyJfCgvqCV18zaICO97GnIKSsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720808; c=relaxed/simple;
	bh=gYCUW4tqnJup9F7JzVjpKyNyJPHk/tRp5a9F0VQighA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a283lbMfGBTRO97l+PcUt3J9j7QJTM4PMxnx6XbWQRb1ufFLed20pev43Ylo2CGSPXpciFXMNhbJTGQauMBDGYyhh/9FbAkM2ddxOxv86qnkbPOem9awB2X7GHct2yWi5O6PXuzb/yNyROqAtIud81iPmwzuovntyw4yaUtG2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHft803e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMWfzj2H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hHft803e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMWfzj2H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 670E51FBAB;
	Tue, 14 May 2024 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=hHft803ecNlAb2YgHf6izR+uuw6VXIVGwgEFzoR3J5Fmy5mxhCGpMIwVP/QgnoAuADzfR8
	3fBt2jrbi3GFXS3JqjP3piN11nmBrP+zcHEkBhDSoXVP0kPQC3xT8lJyOMt8SqNesYXY9U
	NeV9r4RpUeBPDj9g0R0N3D5bQ7WuMoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=wMWfzj2HuRxxULRaIM/Wsg5cwWf03TJ88p+VC7oC193PoZn+9GVXkz0sGMRxpDwJhL28LZ
	O6TSPa/HhmUko3AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hHft803e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wMWfzj2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715720805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=hHft803ecNlAb2YgHf6izR+uuw6VXIVGwgEFzoR3J5Fmy5mxhCGpMIwVP/QgnoAuADzfR8
	3fBt2jrbi3GFXS3JqjP3piN11nmBrP+zcHEkBhDSoXVP0kPQC3xT8lJyOMt8SqNesYXY9U
	NeV9r4RpUeBPDj9g0R0N3D5bQ7WuMoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715720805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMfKixceV4qr83nNPK38FwuyfKkOiLi4Qx7Rk6Mapug=;
	b=wMWfzj2HuRxxULRaIM/Wsg5cwWf03TJ88p+VC7oC193PoZn+9GVXkz0sGMRxpDwJhL28LZ
	O6TSPa/HhmUko3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E7D21372E;
	Tue, 14 May 2024 21:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUEoHGTSQ2bjKAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 14 May 2024 21:06:44 +0000
Date: Tue, 14 May 2024 23:06:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
Message-ID: <ZkPSY6JLddeusGXJ@localhost.localdomain>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-7-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514140446.538622-7-bjorn@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-2.99)[99.95%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rivosinc.com,eecs.berkeley.edu,redhat.com,dabbelt.com,sifive.com,lists.infradead.org,catalinasystems.io,gmail.com,ventanamicro.com,vger.kernel.org,kvack.org,lists.linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,rivosinc.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 670E51FBAB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.50

On Tue, May 14, 2024 at 04:04:44PM +0200, Bj�rn T�pel wrote:
> From: Bj�rn T�pel <bjorn@rivosinc.com>
> 
> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> RISC-V.
> 
> Signed-off-by: Bj�rn T�pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..b9398b64bb69 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ARCH_DMA_DEFAULT_COHERENT
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> +	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU

Hopefully this should be SPARSEMEM_VMEMMAP.
We are trying to deprecate memory-hotplug on !SPARSEMEM_VMEMMAP.

And it is always easier to do it now that when the code goes already in,
so please consider if you really need SPARSEMEM and why (I do not think
you do).

 

-- 
Oscar Salvador
SUSE Labs

